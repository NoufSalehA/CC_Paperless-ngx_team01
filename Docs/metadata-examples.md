# Metadata Examples – Paperless-ngx (IT & Operations)

## 1. Sample documents

| ID | Original file | Title | Correspondent | Document type | Tags | Date created |
|---|---|---|---|---|---|---|
| 10 | it_operations_change_request.pdf | IT Change Request | IT | IT Request | IT, Request | 2026-10-07 |
| 11 | operations_facility_work_order.pdf | Operations Work Order | Operations | Work Order | Operations, Order | 2025-09-03 |
| 19 | business_owner_operational_review.pdf | Business Review | Operations | Review | needs-review, Operations, Report | 2026-10-07 |

## 2. What each field is for

| Field | Purpose | Example |
|---|---|---|
| Title | Short, readable name shown in lists | Operations Work Order |
| Correspondent | Who the document comes from or belongs to | Operations |
| Document type | The kind of document | Work Order |
| Tags | Labels for filtering across areas | Operations, Order |
| Date created | When the document was issued | 2025-09-03 |

## 3. Document details used for search

| Document | Searchable text from the content |
|---|---|
| IT Change Request (ID 10) | Change ID `CHG-2025-0147`, Corporate Email Platform, Production, Risk Medium, Approved |
| Operations Work Order (ID 11) | Work Order ID `OPS-2025-021`, Riyadh Head Office, Priority Normal, Completed |
| Business Review (ID 19) | Business Operations Review, Operational Efficiency, Digital Transformation, Risk Management |

## 4. Technical metadata recorded by Paperless-ngx

| ID | Media filename | File size | MIME type | Date added |
|---|---|---|---|---|
| 10 | 0000010.pdf | 26 KB | application/pdf | 2026-10-07 |
| 11 | 0000011.pdf | 27 KB | application/pdf | 2026-10-07 |
| 19 | 0000019.pdf | 27 KB | application/pdf | 2026-10-07 |

Paperless-ngx also stores a SHA-256 checksum of each original file, which can be used to detect duplicates or changes.

## 5. Classification rules

1. Use one spelling and capitalization for each tag across all teams (`IT`, `Operations`, `HR`, `Finance`, `needs-review`).
2. Every document gets a correspondent, a document type, at least one area tag, and a date.
3. Add `needs-review` to anything that requires a reviewer; remove it when the review is done.
4. If a document prints no date, the upload date is used. Add the real date when it is known.
5. Do not create a new tag, type, or correspondent if an existing one fits.

## 6. Example searches

| Question | Search or filter | Finds |
|---|---|---|
| Which change request covers the email platform? | Text search `CHG-2025-0147` | ID 10 |
| What work was done at the Riyadh office? | Text search `OPS-2025-021` | ID 11 |
| Which documents belong to Operations? | Tag `Operations` | IDs 11, 19 |
| What is waiting for review? | Tag `needs-review` | ID 19 |
| Which are IT requests? | Document type `IT Request` | ID 10 |

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B72F84F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748344; cv=none; b=M6YHUAjSgYafb66jZqVekMh5z4S9FFcpVO2OxKEDaYhTuHTHpRXTQyRdOWt7ULvhKqaUc9BNEz2vl1iWtVi/xkghbINIQWMRI9Y8h9hcUmUD46JXUIczyB9QprgMZur45cgZjBuRIjlL+YlkXSzGiciqJWDgt8jinmq2NchT47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748344; c=relaxed/simple;
	bh=vh8q2aILKRCuAbFgRHTQnt+eOOaJnlzfBPFOHU0wW1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNfEv3wm5dytK8Bc5r5nPJin2SG1A8xQX8LzABkQ6CqOGm9TlO8eO0BEqTISN8beOGK0DO9qf7n5jYEG4fIp/cr7dpHCcDw/G8NWT9gOPSF48LV0xMecGOiaXrRMcJqWgWpAqXuQ7nPvQfyARTDbygwsNr62NuUC62pVd/V9o5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izJ36z5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izJ36z5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570601F00898;
	Sat,  6 Jun 2026 12:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748343;
	bh=M4JBzDfWAp6PKlVqAs2sKu3b0p/wTG1uNZLckpHWq/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izJ36z5OKdQorQf1xK2QzzEXtxMd1vAfeBgSS8ETNplmtcusWgipQXl8SBVoyxRb6
	 lZp3sZmyO7LgAyTzpIuZnR3B9jxwFScsEgyBn6Sjv1O16GSzYLzjBjlFLin/EdUVmu
	 qXCZhaWmHM0AB6/icaTWonrq10DbnJ60V9KagBZh1exuF7KV6uz9uJZI1Lw2gzo3qp
	 BVUi26yM+TvIo3PwR0jFkGeLRqFO4qIpbThc1tZwL/lWdrfj4rngjI52nAVFPSwuPJ
	 19sgm55vKWQv0MfzIxmBiBYw/ZgFuZQ2qh6hq2l6+8P2Rq2iAC6rg3ZTfyy3PeSXfy
	 MNRvDA6fseAiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] [AUTOMATED CONFLICT RESOLUTION] Documentation for d98d413ca65d0790a8f3695d0a5845538958ab84
Date: Sat,  6 Jun 2026 08:19:00 -0400
Message-ID: <20260606121900.2851177-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606121900.2851177-1-sashal@kernel.org>
References: <2026060551-crazily-gatherer-b40f@gregkh>
 <20260606121900.2851177-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit documents the automated conflict resolution performed by claude
for upstream commit d98d413ca65d0790a8f3695d0a5845538958ab84.

claude's resolution process:
================================================================================
Done. Here's the detailed breakdown.

## The problem

Commit `d98d413ca65d` ("usb: typec: ucsi: Don't update power_supply on power role change if not connected") **cherry-picked without conflict markers** — git fuzzy-matched the unchanged anchor lines (`typec_set_pwr_role(con->port, role);` and `ucsi_port_psy_changed(con);`) and silently applied the body change. So it *looked* clean, but it failed to **build**.

The reason: upstream's hunk wraps the psy update in
```c
if (UCSI_CONSTAT(con, CONNECTED))
    ucsi_port_psy_changed(con);
```
`UCSI_CONSTAT(con, FIELD)` is a **function-like accessor macro** introduced by a later UCSI refactor that is **not present in 6.12**. The 6.12 `ucsi.h` only defines the raw BIT-flag macros (`UCSI_CONSTAT_CONNECTED` = BIT(7), etc.), and every connected-check in this tree uses the old idiom `con->status.flags & UCSI_CONSTAT_CONNECTED`.

## The resolution

Single minimal change — translate the macro to the in-tree idiom:
```c
-		if (UCSI_CONSTAT(con, CONNECTED))
+		if (con->status.flags & UCSI_CONSTAT_CONNECTED)
 			ucsi_port_psy_changed(con);
```
This matches exactly how connected status is read at ucsi.c:1108, 1149, 1251, 1663, 1937. The upstream comment was kept verbatim, and the actual fix logic (gate `ucsi_port_psy_changed()` on the port being connected) is byte-faithful. Result is +6/-1, identical line count to upstream.

**One subtlety I verified:** upstream's context line reads `if ((change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role)`. The `role != prev_role` comes from a *separate predecessor patch* (`b80e7d34`, the v1-1 of this series) that isn't in 6.12.92. But that text is **context, not payload** — this patch only changes the block body — so its absence is irrelevant to this backport and required no action.

## Verification

- Author preserved: **Myrrh Periwinkle** ✓
- Commit message unchanged ✓
- No functions added, no divergence beyond the one-line macro translation ✓
- **`stable build log`: 0 warnings / 0 errors on both x86_64 and aarch64** ✓

Committed as `782ea4e61bbf`.
================================================================================

Backport verification analysis (via claude):
================================================================================
Analysis complete. Here is my detailed verification.

## Backport Verification: `d98d413ca65d` → `b25f1e36558347` (6.12.92)

### 1. Intent preservation — ✅ Correct

The upstream fix gates `ucsi_port_psy_changed(con)` (a power_supply notification) behind a connection check inside the `POWER_DIR_CHANGE` handler. Rationale: when the port is disconnected, the `online` status is identical regardless of power-direction, so notifying power_supply is unnecessary/incorrect.

The backport reproduces this exactly:
```c
if (con->status.flags & UCSI_CONSTAT_CONNECTED)
    ucsi_port_psy_changed(con);
```
preceded by the verbatim upstream comment. The gate logic is byte-faithful to upstream's intent.

### 2. Differences and justification

There are exactly **two** differences from the upstream diff, both fully justified:

**(a) Payload — the one real change (justified, required for build):**
Upstream uses `if (UCSI_CONSTAT(con, CONNECTED))`, a function-like accessor macro introduced by a later UCSI refactor that **does not exist in 6.12**. I confirmed `grep "define UCSI_CONSTAT("` returns nothing; 6.12's `ucsi.h` only has the raw bit macro `UCSI_CONSTAT_CONNECTED` (BIT(3), at ucsi.h:340). The resolution translates it to `con->status.flags & UCSI_CONSTAT_CONNECTED`, which is the established in-tree idiom — used identically at lines 1108, 1149, 1251, 1663, 1937 of the same file. Semantically equivalent and compiles. This is the correct and minimal resolution.

> Minor note: the resolution writeup claimed `UCSI_CONSTAT_CONNECTED = BIT(7)` — it's actually BIT(3). Harmless, since the named macro was used, not a literal.

**(b) Context-only difference (no action correctly taken):**
Upstream's block header is `if ((change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role)`; the backport's is `if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE)`. The `&& role != prev_role` and the local `change` variable come from the sibling predecessor `b80e7d34` (the v1-1 patch). I verified `prev_role` is **absent** from this tree — that predecessor isn't applied here. Since this patch only edits the *body* of the block, the differing header is pure context and does not affect the build or the fix. Correctly left untouched.

### 3. Potential issues — none material

- **Build:** The macro translation matches 5 existing call sites; no undefined symbols. Resolution reports 0W/0E on x86_64 + aarch64. Consistent with my static checks.
- **Dependency ordering:** `b80e7d34` (v1-1) ideally lands before this (v1-2) in the series, and per my prior records it was backported separately as `e405a0183c94`. Its absence here is benign — the two patches touch disjoint payloads (one edits the header condition, this one edits the block body), so neither build nor correctness depends on ordering. No risk introduced.
- **Metadata:** Author (Myrrh Periwinkle), message, Fixes/Link tags all preserved correctly.

### 4. Overall assessment — ✅ High quality, correct

A textbook clean amend. The cherry-pick fuzzy-matched the stable anchor lines and applied without conflict markers but would not have built due to the missing `UCSI_CONSTAT()` accessor macro. The single one-line translation to the native `con->status.flags & UCSI_CONSTAT_CONNECTED` idiom is the right fix, is faithful to upstream intent, matches local convention, and is line-count-identical to upstream (+6/−1). No concerns. Backport is correct.

(Recorded to memory for future reference under the `backport-review` tag, cross-linked to the `b80e7d34` 6.12 sibling.)
================================================================================

This is an empty commit for documentation purposes only.
-- 
2.53.0


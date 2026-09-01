Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D264A2616
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290923; cv=none; b=ItJ4tzEy3A4rpiLYFkmPfIk6Quh5CQgydKqTVv9Cen62WwzkPZjtyhqL4754apxzBKCpS2QnPtwoaTHFaWTz5y6KBX763zGdEriatxPZKYiT/5aGHIYHdKWXIdNtfO0ZVmWlurgqR5TWxDrlJh4jCStb8OCWwYg+zsRBwKq8z60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290923; c=relaxed/simple;
	bh=rkowEac86FDPWoAGdBGUie5sOODkAc8dpR+n35wOfJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFLSxZoIQKYv25O/4RxCx072PmHqL6cOWqL/lE6OmedJY8B1QnGWfiPEX4jZY/W3pcGSjufSSBIFYga9HToAUCXtSiwmF0J7Im/fy9i604lXk24SsCVof1s+DcHxQfE7Z/mmWoh2a+XsmJxn+Q6bVuiWLTfSYieyb7bOzxxevXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRbpZUMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRbpZUMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72D01F00A3E;
	Tue,  1 Sep 2026 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290922;
	bh=tYToL4RQ+eROirgxTTTYmhXK9GpxvX4EQ68rxZpQNOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RRbpZUMFhkQO42sR4636uWD925byq9HtDk8MvbUp7O+k2Sj/5z3APsOWWVNafzYxK
	 BOT6nEvGBxye1zptU7uDezkzh2I2XjyKj/x+gikr2QpV6dYmz5ZPevPt/UaS/6ir1a
	 2OuKIWW5Sih30PHYqpXKF+M0KDNJ23vw27TV18m5+JhI6QkvZOh8yiBsaZ03Z4JdNT
	 xxX/MjubUvzGWa81pMSqXT4Rsl/D608WF55SLnqX5LrFk5fHdn3KwHjKuWfyRJ2IoC
	 WtXQBOZ6cYzP/DNpaNHNGSPkYae41V9nM0EV8lCLZJVUK/a61KYOq8gqruUOrYAStZ
	 vEmkfoX9AaINQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 8/8] [AUTOMATED CONFLICT RESOLUTION] Documentation for 870a9e42ecc6fe1b8c25d87af043cb0d9c178fe1
Date: Tue,  1 Sep 2026 15:28:33 -0400
Message-ID: <20260901192833.1439569-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901192833.1439569-1-sashal@kernel.org>
References: <2026083106-glider-shiftless-2e30@gregkh>
 <20260901192833.1439569-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit documents the automated conflict resolution performed by claude
for upstream commit 870a9e42ecc6fe1b8c25d87af043cb0d9c178fe1.

claude's resolution process:
================================================================================
Build passed clean (rc=0 on both x86 and arm64); all warnings are pre-existing/unrelated (dtsi clock warnings, xen/objtool noinstr warnings) and not caused by this change.

## Summary

**Conflict:** Single hunk in `net/ipv4/tcp_output.c:tcp_connect_init()`. Our tree's `window_clamp` assignment (`tp->window_clamp = ...`) lacks a `WRITE_ONCE()` wrapper that upstream added in a separate, unrelated commit not present in this tree. Git couldn't reconcile the two forms of that line since the target commit's context included the `WRITE_ONCE` wrapper.

**Resolution:** Kept our tree's existing line (`tp->window_clamp = dst_metric(dst, RTAX_WINDOW);`, no `WRITE_ONCE`) unchanged, and applied only the actual payload of this commit — replacing `dst_metric_advmss(dst)` with `tcp_dst_advmss(dst)` on that line, matching the other 4 (conflict-free) call sites. The resulting diff is a pure, minimal application of the upstream fix (new `tcp_dst_advmss()` helper in `include/net/tcp.h`, plus 5 call-site substitutions) — no divergence from the original commit beyond that one unavoidable context difference.

Commit `18e91d6e2785f` is on the branch with the original message and author (Yong Wang) preserved, and the build gate is green.
================================================================================

Backport verification analysis (via claude):
================================================================================
All 5 file/site changes match exactly (same stat as upstream), and no stray `dst_metric_advmss` call sites were left unconverted in the TCP paths (the remaining hit in `xfrm_policy.c` is outside this commit's scope, untouched upstream too). The build gate passed clean. This is a high-quality backport.

## Analysis

**1. Intent preservation — correct.** The helper `tcp_dst_advmss()` is added verbatim (`max_t(u32, dst_metric_advmss(dst), TCP_MIN_MSS)`), and all 5 call sites that upstream converts (`tcp_ipv4.c`, `tcp_minisocks.c`, `tcp_output.c` x3, `tcp_ipv6.c`) are converted identically. The fix's actual security-relevant payload — clamping route-derived advmss so it can never reach 0 and cause a divide-by-zero in `tcp_select_initial_window()` — is fully and correctly applied.

**2. Differences from upstream — justified.** The only textual difference (beyond expected line-number drift from tree divergence) is in `tcp_connect_init()`:

```
- WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));   // upstream
+ tp->window_clamp = dst_metric(dst, RTAX_WINDOW);              // backport (unchanged)
```

I verified this is *not* something the backport dropped — the parent commit in this tree already had the plain assignment (no `WRITE_ONCE`), confirmed by `git show 488f5e59f0d9c^:net/ipv4/tcp_output.c` and a fruitless `git log -S"WRITE_ONCE(tp->window_clamp"` search. The `WRITE_ONCE` wrapping was introduced by a separate, unrelated upstream commit that was never backported to this tree — it's pure surrounding context that happened to collide with this commit's 3-line hunk during the 3-way merge, not part of this fix's payload. The resolver correctly recognized this and preserved the tree's existing form while applying only the actual substitution (`dst_metric_advmss(dst)` → `tcp_dst_advmss(dst)`) on that line.

**3. Potential concerns — none identified.**
- `TCP_MIN_MSS` (88U) already exists in this tree's `tcp.h`, so the helper compiles as-is.
- No other in-tree callers of `dst_metric_advmss()` were missed; the one remaining hit (`xfrm_policy.c`) is out of scope for this commit both upstream and here.
- Commit metadata (author, `Cc: stable`, `Fixes:`, `[ Upstream commit ... ]` line, dual SoB) is all intact and properly formatted.
- Build gate is green with no new warnings attributable to this change.

**4. Overall assessment: correct, minimal, faithful backport.** The single conflict was a genuine context mismatch from an unrelated, un-backported commit, and it was resolved with the minimum necessary divergence — no scope creep, no missed call sites, no incorrect logic. No issues found.
================================================================================

This is an empty commit for documentation purposes only.
-- 
2.53.0


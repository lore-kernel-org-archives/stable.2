Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5B32A3D7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971216; cv=none; b=gJQK8l5ue7Pura13iF4ZNNELqWm5DKSsz8IUcIN0rJE/epIJtehQ8rveLt+EYLhngbSAGhiI9kX+QjAofgpGXJOLYnYYnXAieryjIkuse8AxEMteieVCmruFhsCsAMdcTl0AjGkZGFZ3NcjvGfhGSIBbjoIXbeOZ0uXMshZAUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971216; c=relaxed/simple;
	bh=If3efuHEztmN1XfCj12NWrIZr95/MO/3x8KuW38oK1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4JtMf0RdU+TOQi0H7DL4P9fgWEX/o8wV1gx0wNF9Fsf3uIDQ5iVsHePHe0CLTkcreGaasW9oE2ALad9zk1X/1vqkdoXPi1fHPy4+aGTZr4fvMHh3ta5nP75PnS+exhpqPDgvBfAXn0D5J8Vf49PVzrHXxbsW9U79YdM0i47rWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZUcaIfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZUcaIfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D741F00893;
	Wed,  9 Sep 2026 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971214;
	bh=Gyh8b3JIzCC0hiGO6ckMAk+OVJcOQj4ewweVAKPPUf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nZUcaIfOu9Z8AYAnkDd7Iyc7sU4yZgXaa2W2vOB8VrHoyJeNaM7Jfg0yebZiJsaxt
	 FBaxkET+U97w/o9DZa02JrpOIT29kJgg4yl2OpMenTXnNFvCUFRE3t5ooyCnnr1sMW
	 PP5NXIAl5FUxF5n8fuseBLJz81YGTqWabfwwh9VwkAKtB/5ZaJk0W9CAh3qpCAQPC1
	 RiakXkhEzs2V3pMWYnswuMSC//2ZMUoETU0yUiDOWF15pjN0gOUUubBuCFvoMMDDU/
	 FEiQRawLgXfmMJHsP806wx4x4RazxiiR6xRER1Cbj43sfmhkq4NgUUi9NpP1tSL54k
	 tHIodpfTRcqTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] [AUTOMATED CONFLICT RESOLUTION] Documentation for 2cf20c4e0f72d523b8673053e7120d092ff1f074
Date: Wed,  9 Sep 2026 12:26:50 -0400
Message-ID: <20260909162650.2981584-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162650.2981584-1-sashal@kernel.org>
References: <2026090355-lavish-nimbly-617c@gregkh>
 <20260909162650.2981584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit documents the automated conflict resolution performed by codex
for upstream commit 2cf20c4e0f72d523b8673053e7120d092ff1f074.

codex's resolution process:
================================================================================
Resolved and committed as `52c757d6eca3d` — `io_uring/waitid: avoid siginfo copy during ring teardown`.

The original patch failed because this branch uses older cancellation interfaces: cancellation calls the helper directly, `io_waitid_remove_all()` receives a `task_struct` pointer, and `io_waitid_complete()` lacks upstream’s `copy_si` argument.

The resolution changes only [io_uring/waitid.c](/home/sasha/tmp/stable-parse-fail-6.12-1788966592/io_uring/waitid.c:134), with 11 insertions and 7 deletions:

- Added the `copy_si` argument to existing completion and cancellation helpers.
- Used `task != NULL` to preserve copying during task-scoped cancellation and disable it during ring teardown.
- Preserved copying for explicit cancellation and normal completion.
- Kept teardown’s waitqueue removal, state cleanup, and `-ECANCELED` completion.

No functions were added. The original commit message, author, and author date are preserved exactly. Only the resolved commit was created, and the working tree is clean.

`stable build log` ran **after committing** and completed without interruption. Both **x86 and ARM64 passed with zero warnings and zero errors**. Whitespace and checkpatch checks also passed.

[Build log](/tmp/stable-parse-fail-6.12-2cf20c4-build.log)
================================================================================

Backport verification analysis (via codex):
================================================================================
**The backport correctly implements the direct ring-teardown fix in `2cf20c4e0f72`. I found no defect in the added cancellation arguments or cleanup logic. There is, however, a substantive remaining concern: upstream’s companion fix for fallback task work was explicitly skipped, leaving another path that can still access siginfo from a kworker.**

This distinction matters for the review record: the requested commit is faithfully adapted, but HEAD does not provide all the related protection present in upstream at that commit.

The direct teardown path is correct. In this branch, [io_ring_exit_work()](/home/sasha/tmp/stable-parse-fail-6.12-1788966592/io_uring/io_uring.c:2877) calls:

```text
io_uring_try_cancel_requests(ctx, NULL, true)
  → io_waitid_remove_all(ctx, NULL, true)
  → __io_waitid_cancel(ctx, req, false)
  → io_waitid_complete(req, -ECANCELED, false)
```

The final two calls occur when cancellation successfully claims ownership of the request. Passing `false` bypasses `io_waitid_finish()`, which otherwise attempts the userspace siginfo copy even when its input result is negative.

The backport preserves the intended behavior across the other paths:

| Path | Backport behavior | Assessment |
|---|---|---|
| Direct ring-wide cancellation, `task == NULL` | Skip siginfo copy | Matches upstream’s NULL-`tctx` selection |
| Task-scoped cancellation, `task != NULL` | Preserve siginfo copy | Matches upstream |
| Explicit asynchronous cancellation | Pass `true` | Preserves existing behavior |
| Ordinary callback completion | Pass `true` | Preserves existing behavior |
| Immediate completion during submission | Continue calling `io_waitid_finish()` | Unchanged |

Using `task != NULL` is justified by the actual callers, rather than merely by similarity between parameter names. Task-scoped cancellation passes `current`; ring teardown passes NULL. The older matching helper also checks the supplied task against the request’s submitting task.

The no-copy path retains the required cleanup. [io_waitid_complete()](/home/sasha/tmp/stable-parse-fail-6.12-1788966592/io_uring/waitid.c:134) still checks the ownership reference and ring lock, removes the request from the cancellation list, and removes its waitqueue entry before releasing the async state. [io_waitid_free()](/home/sasha/tmp/stable-parse-fail-6.12-1788966592/io_uring/waitid.c:35) drops the PID reference, frees `async_data`, clears its pointer, and clears `REQ_F_ASYNC_DATA`. Consequently, bypassing `io_waitid_finish()` does not omit resource release or introduce a second async-data free.

The negative result still sets the request’s failure flag, and cancellation still queues completion with `-ECANCELED`. Skipping `io_waitid_finish()` also skips its positive-result normalization, but that is harmless here: every new no-copy invocation supplies `-ECANCELED`.

Both native and compat siginfo copies are bypassed, because the conditional sits above their common entry point.

The differences from the upstream patch are appropriate for the older interfaces:

| Difference | Reason and assessment |
|---|---|
| The backport adds `copy_si` to `io_waitid_complete()` | Upstream already obtained this interface from companion commit `14572de82e502`. The backport needs that portion to implement the requested fix. I verified that the resulting completion function is textually identical to upstream’s. |
| The backport passes booleans directly instead of adding two callback wrappers | This branch contains its own cancellation loops. Upstream’s wrappers satisfy the generic cancellation helpers’ callback signature; they are unnecessary here. |
| `task_struct *task` replaces upstream’s `io_uring_task *tctx` discriminator | Correct adaptation to the branch’s cancellation interface and callers. |
| `__io_waitid_cancel()` retains its existing `ctx` argument | Harmless preservation of the older signature. |
| The ordinary callback gains an explicit `true` argument | Required by the new completion signature and preserves its previous behavior. |

The older cancellation loops also retain some pre-existing differences from upstream’s generic helpers. In particular, local `io_waitid_remove_all()` reports `found = true` after removing a matching request even when the cancellation helper cannot claim ownership; upstream’s generic helper conditions that result on the callback succeeding. This patch does not introduce that difference. Because the local loop removes the entry before reporting progress, the retained behavior does not itself create an endless rediscovery loop.

I found no new locking, reference-ownership, ABI, or cancellation-matching change in the reviewed diff. The repeated `hlist_del_init()` between removal and completion is safe and pre-existing.

**The remaining issue is the skipped fallback-task-work fix.** Upstream commit `14572de82e502`—`io_uring/waitid: honor task_work cancellation`—introduced two related changes before the requested commit:

- The optional-copy completion interface.
- A cancellation check at the start of `io_waitid_cb()`, before `__do_wait()`, completing canceled task work with `-ECANCELED` and no siginfo copy.

The backport incorporates the first part but lacks the second. The dependency-preparation commit `b003e5c572cf6` explicitly records `14572de82e502` as `SKIP_RSLV`.

This is relevant to the target branch because its fallback executor really can invoke this callback. [io_fallback_req_func()](/home/sasha/tmp/stable-parse-fail-6.12-1788966592/io_uring/io_uring.c:244) runs queued callbacks from workqueue context without automatically replacing them with cancellation completions. Task work is routed there when the originating task is exiting or when adding task work fails.

A problematic sequence supported by the source is:

1. A child wakeup takes ownership of the waitid request and queues `io_waitid_cb()`.
2. The submitting task exits, causing pending task work to use the fallback worker.
3. Cancellation encounters the already-owned request. `__io_waitid_cancel()` sets the cancellation flag but returns before reaching `io_waitid_complete(..., false)`.
4. The fallback worker executes [io_waitid_cb()](/home/sasha/tmp/stable-parse-fail-6.12-1788966592/io_uring/waitid.c:243), which calls `__do_wait()` and eventually `io_waitid_complete(req, ret, true)`.

Thus, the no-copy choice does not protect a callback that already owns the request. `__do_wait()` operates relative to `current`, and the subsequent completion can still attempt the userspace copy from the worker.

**This is a pre-existing bug left unresolved by the dependency selection, not a regression introduced by the new boolean argument.** It nevertheless prevents an unconditional conclusion that this HEAD has eliminated waitid’s teardown/fallback context problems.

I recommend backporting `14572de82e502` as a companion change. This branch already exposes [io_should_terminate_tw()](/home/sasha/tmp/stable-parse-fail-6.12-1788966592/io_uring/io_uring.h:431), so its existing interface can express the missing check without importing upstream’s task-work interface refactoring. The corresponding logic, immediately after `io_tw_lock(ctx, ts)` and before `__do_wait()`, would be:

```c
if (unlikely(io_should_terminate_tw(ctx))) {
	io_waitid_complete(req, -ECANCELED, false);
	io_req_task_complete(req, ts);
	return;
}
```

That is a recommended follow-up; I did not modify the source during this review.

The conflict-resolution report is largely supported by the repository, with a few qualifications:

- HEAD is the requested `3e4a65037355c9c14b1f16196bedcababe2261fc`.
- The reported intermediate commit, `52c757d6eca3d`, exists. **Both commits have the same parent and identical source trees.** Their different hashes do not indicate different conflict resolutions.
- The patch changes only `io_uring/waitid.c`, with 11 insertions and 7 deletions, and adds no functions.
- The author and author date match upstream. HEAD’s message preserves upstream’s text while adding the upstream-commit marker and stable sign-off.
- The current working tree contains an untracked `tmp.cmt`; therefore, “the working tree is clean” is not true of the present snapshot. This does not affect the committed patch.

I independently reran the whitespace check and checkpatch; both passed, with checkpatch reporting zero errors and zero warnings. The [available build log](/tmp/stable-parse-fail-6.12-2cf20c4-build.log) reports successful x86 and ARM64 builds with zero warnings. Its timestamp precedes the final metadata rewrite, and the identical source trees support applying those results to HEAD’s code. The log identifies the build as `HEAD` without recording an immutable commit ID or detailed configuration.

I did not rerun the kernel builds or execute runtime race tests. The remaining fallback issue is established by source tracing; the reported build successes cannot validate that execution-context behavior.

**My assessment is that the conflict resolution is a sound, minimal backport of the requested direct-cancellation fix.** I would retain it and add the adapted companion fix. For future documentation, record the targeted fix as correctly backported and the fallback-task-work protection as still outstanding.
================================================================================

This is an empty commit for documentation purposes only.
-- 
2.53.0


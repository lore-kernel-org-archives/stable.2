Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A7331EAF
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976931; cv=none; b=EZidnwr2aXwicAOLsSqKcmGIiCld556xH06Q9HFFzh1D7VdIJiOVIMZtvQaWDTYaQvjFq+WFgu+ojnKEyvwnshOEO4CfnjNoaoWTKR0bp1dDVQmcXz7pck8lFUgFPncfmUbocaRssz2iGjM9Cl1syw+C9oIhNTOYufqKeeCyq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976931; c=relaxed/simple;
	bh=SN9aTpMkcafP2vm6R3EMT+XdOuugzYY43JHBP/7gi6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6ILctA49tbGxOSuvI+DcWVdYBxXxSakADFtgB5Zkbhx4z99lG36eZ7K+EPeQR20W4f+tSiih7bN0SyGNL/rdRuc2ELK0L2xiA1FzuzSDbAdf2kBe+OJ9KQozQGlYNlhyxWaDeUY/YbVz3mKorUcQBEpqnFarOjOH/0tfg5rrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmX63jiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmX63jiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF09C1F00A3A;
	Sat, 25 Jul 2026 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784976930;
	bh=LfMuEsjl5fmgOoR55DgiMTl160+HwNPqCZT3nFF/63Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gmX63jiUP3Eg2bVjEdy5z8D8EgpUdljjEx3m/HG/ql5l8mdV5n+Q2NnpONeMTvni2
	 G3U7x2X6v5XmFCHMH6WRtkiLa5YqM+8jZMTeBinCwh0KrqnQBqFP6brBe46vi6/zIb
	 h5Nbsg9e+0cdOsIPPzghC9xnF6czonlMKL719NdhQX5ULMQXBg212QyPuI8o2AlLa2
	 bfyqcRjaWfju/IxfZP9R/dtocF2v5VsXGcK4LfwTIHlFh2o30qq2x3pl5vXl87KRN+
	 Ore6JJXvLVRVTl/zImSB8CRYPLHuPF1+7o3yDnD0cLAiStH53iKFv4txcy/t614PGM
	 iOltLOSGho5Vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] [AUTOMATED CONFLICT RESOLUTION] Documentation for 6b4f48728faa8bb514368f7eacda05565dea8696
Date: Sat, 25 Jul 2026 06:55:27 -0400
Message-ID: <20260725105527.1856073-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725105527.1856073-1-sashal@kernel.org>
References: <2026072024-extending-list-343c@gregkh>
 <20260725105527.1856073-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This commit documents the automated conflict resolution performed by claude
for upstream commit 6b4f48728faa8bb514368f7eacda05565dea8696.

claude's resolution process:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Build still in progress (no output yet). Waiting for completion =E2=80=94 I=
'll report once it lands.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Backport verification analysis (via claude):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
## Verdict: correct, faithful, minimal =E2=80=94 context-only adaptation

### 1. Intent preservation

The upstream fix is two lines added as the first statement inside the `type=
 =3D=3D P9_TFLUSH` retry branch of `p9_client_rpc()`. The backport adds tho=
se **exact same two lines, byte-identical, at the exact same logical positi=
on** (`net/9p/client.c:773-774`):

```c
	if ((err =3D=3D -ERESTARTSYS) && (c->status =3D=3D Connected)
				  && (type =3D=3D P9_TFLUSH)) {
		if (fatal_signal_pending(current))
			goto recalc_sigpending;
		sigpending =3D 1;
		clear_thread_flag(TIF_SIGPENDING);
		goto again;
	}
```

The `recalc_sigpending:` label exists in 5.10's `p9_client_rpc()` at `clien=
t.c:797`, in the same relative position and with byte-identical body to ups=
tream:

```c
recalc_sigpending:
	if (sigpending) {
		spin_lock_irqsave(&current->sighand->siglock, flags);
		recalc_sigpending();
		spin_unlock_irqrestore(&current->sighand->siglock, flags);
	}
	if (err < 0)
		goto reterr;
```

So both post-conditions the commit message promises hold in 5.10:
- `sigpending =3D=3D 1` (a signal was pending at RPC entry) =E2=86=92 `reca=
lc_sigpending()` restores `TIF_SIGPENDING`.
- `sigpending =3D=3D 0` =E2=86=92 `TIF_SIGPENDING` was never cleared on thi=
s path, so it's still set. Correct either way.
- `err =3D=3D -ERESTARTSYS < 0` =E2=86=92 `goto reterr` =E2=86=92 `p9_tag_r=
emove()` =E2=86=92 `ERR_PTR(safe_errno(-ERESTARTSYS))`. `safe_errno()` (`cl=
ient.c:94`) passes `-512` through unchanged (`-512 > -MAX_ERRNO`), so the c=
aller genuinely sees `-ERESTARTSYS`, not a mangled `-EPROTO`.

### 2. Differences vs upstream =E2=80=94 all pre-existing context, none fun=
ctional

The only diff-level deltas are blob hashes, hunk line numbers (600 =E2=86=
=92 771), and the `if` condition's parenthesization:

| upstream | 5.10 |
|---|---|
| `if (err =3D=3D -ERESTARTSYS && c->status =3D=3D Connected &&`<br>`    ty=
pe =3D=3D P9_TFLUSH) {` | `if ((err =3D=3D -ERESTARTSYS) && (c->status =3D=
=3D Connected)`<br>`			  && (type =3D=3D P9_TFLUSH)) {` |

That is purely the v5.17-era 9p checkpatch-style reflow, semantically ident=
ical. Other pre-existing divergences in the enclosing function (`wait_event=
_killable` vs `io_wait_event_killable`, no `READ_ONCE(req->status)`, `p9_re=
q_put(req)` vs `p9_req_put(c, req)`, `p9_tag_remove()` vs `p9_req_put()` at=
 `reterr:`) are all upstream-only refactors from 6.1/6.2 and are **orthogon=
al to this fix** =E2=80=94 none of them is touched, and none changes the si=
gnal semantics the fix depends on.

Critically, the killable-wait semantics are the same: 5.10's `wait_event_ki=
llable` returns `-ERESTARTSYS` only via `signal_pending_state(TASK_KILLABLE=
, ...)`, which for `TASK_KILLABLE` (`TASK_WAKEKILL|TASK_UNINTERRUPTIBLE`, n=
o `TASK_INTERRUPTIBLE` bit) requires `__fatal_signal_pending()`. So at the =
new check `TIF_SIGPENDING` is still set and `SIGKILL` is still in `current-=
>pending.signal` =E2=80=94 nothing between the wait returning and the check=
 dequeues signals or calls `recalc_sigpending()`. `fatal_signal_pending()` =
therefore evaluates exactly as upstream intends. `io_wait_event_killable` d=
iffers only in io_schedule accounting.

### 3. Concerns checked and cleared

- **Build/compile**: `<linux/sched/signal.h>` is already included (`client.=
c:20`), and `signal_pending()` is already used ~25 lines above in the same =
function =E2=80=94 `fatal_signal_pending()` needs no new include. `goto rec=
alc_sigpending` targets a label already jumped to by the pre-existing `tran=
s_mod->request()` failure path, so no "label used but not defined". Label v=
s. function name `recalc_sigpending` live in different C namespaces (alread=
y the case pre-patch). `git show --check` is clean; diffstat is exactly `1 =
file changed, 2 insertions(+)` =E2=80=94 no stray hunks.
- **Applicability**: `Fixes: 91b8534fa8f5` (v3.7) is confirmed an ancestor =
of HEAD, and the commit message explicitly states the defect reaches back t=
o 5.4. 5.10.261 is in scope.
- **No duplicate/competing fix**: `fatal_signal_pending` appears exactly on=
ce in all of `net/9p/`, at the new line. No prior stable-only patch to coll=
ide with.
- **`p9_client_zc_rpc()`**: correctly untouched =E2=80=94 5.10's zc variant=
 has no `again:`/`P9_TFLUSH` retry loop, matching upstream, so the one-site=
 fix is complete.
- **Abandoned-TFLUSH lifetime (the one thing worth naming)**: the new early=
 exit means `p9_client_flush()` returns `-ERESTARTSYS` before calling `tran=
s_mod->cancelled(oldreq)`, so `oldreq` stays on the transport's `req_list`.=
 In 5.10 the flush req itself then goes through `reterr: p9_tag_remove()`, =
which does an *eager* `idr_remove()` + put, whereas upstream =E2=89=A56.1 r=
emoves from the idr only on the final `p9_req_put()`. I checked whether thi=
s makes 5.10 more exposed: it doesn't. `trans_fd` takes its own reference a=
t `trans_fd.c:475` before moving a req to `req_list`, so refcount goes 2=E2=
=86=921 and nothing is freed; a late response for a now-unknown tag hits th=
e `!m->rreq` guard in `p9_read_work()` (`trans_fd.c:336`) which logs "Unexp=
ected packet tag" and errors out rather than dereferencing; and `p9_conn_ca=
ncel()` completes and puts the stranded req at disconnect. Identical exposu=
re to the pre-existing `err =3D=3D -ERESTARTSYS && c->status =3D=3D Connect=
ed` path and to `trans_mod->request()` failure. **No UAF, no leak beyond di=
sconnect, and no 5.10-specific regression.**
- **Behavioral note (upstream-inherited, not a backport defect)**: as analy=
zed above, whenever this branch is reached `fatal_signal_pending()` is nece=
ssarily true, so the `sigpending =3D 1; clear_thread_flag(); goto again;` r=
etry becomes effectively unreachable. That is upstream's deliberate semanti=
cs ("return `-ERESTARTSYS` to the caller"), and 5.10 reproduces it exactly =
because its wait is equally killable-only. The backport does not amplify or=
 alter this.

### 4. Overall assessment

**High quality =E2=80=94 accept.** This is the minimal possible adaptation:=
 the added code is byte-identical to upstream, the target label and its bod=
y are identical, all supporting semantics (`safe_errno`, killable-wait sign=
al conditions, `sigpending` bookkeeping) verify out in 5.10, and the surrou=
nding version drift is entirely cosmetic/orthogonal. The only "resolution" =
required was matching the older parenthesized `if` context.

Build verification is the one item still outstanding =E2=80=94 `stable buil=
d log` (x86_64 + aarch64) is running now; I'll report the result when it la=
nds. Given the change adds no new symbols or includes, a failure would be s=
urprising.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

This is an empty commit for documentation purposes only.
--=20
2.53.0


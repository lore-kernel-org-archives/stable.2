Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C70396D0A;
	Thu,  4 Jun 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568847; cv=none; b=tx93akwsRfAl9dvcGTE0mXSoe6GygUkcgrk2A0aV30+Zf6urMh4fZKUHd00966eSiQlcBoXOWQZS/YqGI1Q3p7Eml7QciNSnATlu3OMQgBKo1EVmnk86sYb0AIthVRYqN3wiyUxVglxQMbAipKpKFCEJWbDdnGlzHJVzW+Zy7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568847; c=relaxed/simple;
	bh=8ytD6fh+kb94EYG4EWuFGF4MDorLMGcTZcu0LrxnFk0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufFoRCJVgfM8xTJkfbe3ciB71WgJtlK1MV/tDgQJMW4SyTpgrjCbwENeuAEiHGM1KkJTa/5h5+SRQvVzDNveGSXVn4lhE8/nMP6Y1clJTiR7rQu+LBOJqNm6ECrFLIgl2K07PV3QLSoaGQudTjN7sJTCDd1AJYo1KQHdxdypNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BLBa/26D; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BLBa/26D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780568842; x=1780828042;
	bh=bHw9600ipMORyOji7HH9OSGXMzsw+pVJ13JeBJ8PC5A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BLBa/26Dt4wJGlHsTES9WdHQXpK5knUCdM8ctijSwgmlqLrQ9XBP7167kVSWwvCHd
	 dy3m3pPOGQFjkDXTn7aH/TsYgXsjKVqgn2dVVb3FhhuDTR/jQz/4PIJUD9NUFFTemN
	 azq5JRAcpZWfDxH9g78O66qOGYsGs97h+kvhxCjyDDv80E0QpM0Y5S4Q7sJa308BAb
	 a+O1t8fSUaMGvB0uN4Penymke0wVPhxuKx30MJU+L52vf7l8y9tCTy7nWiTX00DJOF
	 W6mKkUyMMIjiOYJu82vlJ1H+M8FxX5GSLRJtnNd+muSTHSLCHzIxPJT7Cwcp9z5Mpr
	 s+HIKLel1uNzQ==
Date: Thu, 04 Jun 2026 10:27:13 +0000
To: =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
Message-ID: <20260604102707.133997-1-hexlabsecurity@proton.me>
In-Reply-To: <20260604.f1cb6ce9cd6b@gnoack.org>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me> <20260531.irah0eiM3Chi@digikod.net> <20260602172741.18760-1-hexlabsecurity@proton.me> <20260602172741.18760-2-hexlabsecurity@proton.me> <20260604.f1cb6ce9cd6b@gnoack.org>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 3eb54473c11b67113bdd13d08dbd2fcd8b4f1b13
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnther,

> I believe the result after this patch is:
>  - No threads receive the SIGIO at all.
>
> This is because we have been setting T2.2's Landlock domain as the
> "sending domain" for the hook_file_sigiotask(), and that hook does on
> its own not do the "same_thread_group()" check [...]

Confirmed -- I traced the delivery path and your analysis holds.

For a PGID owner the signal is anchored per process on its thread-group
leader: a task is attached to pid->tasks[PIDTYPE_PGID] only in the
thread_group_leader() branch of copy_process(), so send_sigio()'s
do_each_pid_task(pid, PIDTYPE_PGID, p) walk visits exactly T2.1 for P2,
never the non-leader T2.2.  hook_file_send_sigiotask() then runs
domain_is_scoped(recorded T2.2 domain, T2.1's live domain, SIGNAL) and,
having no same_thread_group() exemption of its own (unlike
hook_task_kill()), denies it -- even though T2.1 and T2.2 share P2's
signal_struct and 18eb75f3af40 mandates that same-process delivery always
be allowed.  T2.1 is P2's only entry on the PGID list, so P2 receives
nothing.  You are right.

One thing worth putting on the record: this over-block is not introduced
by the patch.  In unpatched control_current_fowner() the PGID case already
resolves through pid_task(fown->pid, PIDTYPE_PGID), which returns an
arbitrary hlist head -- one representative leader.  Whenever that head is
outside the caller's thread group, the domain is already recorded today and
the same delivery-time denial of the registrant's own leader already fires.
The patch only makes domain recording for PGID unconditional, i.e. it turns
that order-dependent behaviour into a deterministic one while closing the
order-dependent bypass.  So the corner you describe is a pre-existing gap i=
n
the delivery hook, not a regression in v4.

That points at the real root cause: same_thread_group is a *per-recipient*
property, but control_current_fowner() approximates it once, at F_SETOWN
time, against a single pid_task() representative.  hook_task_kill() gets
this right because it evaluates same_thread_group(p, current) live, per
actual recipient.  hook_file_send_sigiotask() is the SIGIO analogue but
delegates the whole thread-group decision to that one registration-time
check, which a PGID delivery set simply cannot be captured by.

So the fully-correct fix is to move the same-process exemption to delivery
time, keyed to the *registrant* rather than to current (at SIGIO time
current is the fd writer, not the task that armed F_SETOWN).  Concretely:
when hook_file_set_fowner() records the domain, also pin
get_pid(task_tgid(current)) in struct landlock_file_security; in
hook_file_send_sigiotask(), before domain_is_scoped(), return 0 when
task_tgid(tsk) =3D=3D that recorded pid.  PGID owners still record the doma=
in
(so P1 stays blocked -- the bypass fix), but the registrant's own process,
including T2.1, is always allowed -- restoring 18eb75f3af40 exactly.  The
new pid is taken/put in lockstep with fown_subject.domain under the same
file->f_owner->lock and freed in hook_file_free_security(); the equality
test follows neither pid, so there is no extra RCU surface.  Sketch:

    /* struct landlock_file_security */
    struct pid *fown_tg;   /* registrant's thread group; NULL if no domain =
*/

    /* hook_file_set_fowner(), where fown_subject is recorded */
    fown_tg =3D get_pid(task_tgid(current));
    ...
    put_pid(landlock_file(file)->fown_tg);     /* release previous */
    landlock_file(file)->fown_tg =3D fown_tg;

    /* hook_file_free_security() */
    put_pid(landlock_file(file)->fown_tg);

    /* hook_file_send_sigiotask(), after the !subject->domain quick return =
*/
    if (task_tgid(tsk) =3D=3D landlock_file(fown->file)->fown_tg)
            return 0;   /* same process as the registrant: always allowed *=
/

I do not see a correct fix that avoids recording the registrant's identity:
the registrant task is deliberately discarded after set_fowner (only its
domain is kept), and exempting on a shared *domain* instead would be
insecure -- sibling threads can hold different domains, and a different
process could share one.

> To be clear, the patch is still obviously an improvement [...] it just
> seems to block it slightly too broadly in this corner scenario?
> [...] Micka=C3=ABl, maybe you have some thoughts on the tradeoff?

Agreed on both counts.  Micka=C3=ABl -- two ways to land this:

  (a) keep v4 as is.  It closes the bypass; the residual same-process
      over-block is pre-existing, deterministic only under the stacked
      conditions G=C3=BCnther listed (already-multithreaded enforce, no TSY=
NC,
      SIGIO to a PGID that includes self, registered from a non-leader
      thread in a per-thread signal-scoped domain), and arguably tolerable.

  (b) v5 =3D v4 + the delivery-time exemption above.  Strictly more correct=
:
      it also closes the pre-existing delivery-hook gap and restores
      18eb75f3af40's same-process invariant, at the cost of one struct pid*
      in landlock_file_security.

I lean (b) -- it fixes the actual root cause rather than the one reachable
instance -- and I am happy to spin it (with an added selftest covering the
PGID-includes-self / non-leader-registrant case, A/B verified) or to hold a=
t
v4 if you would rather keep the change minimal.  Your call on whether the
corner warrants the extra state.

> P.S: [...] new patchset versions are posted at the top (no Reply-To
>      header in the cover letter) [...]

Will do -- v5 (whichever option) goes out as a fresh top-level thread, no
In-Reply-To/Reply-To pointing back at this review.

Bryam


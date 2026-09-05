Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9930CD81;
	Sat,  5 Sep 2026 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607363; cv=none; b=GsGncWiD+z09bRBiciMSTiJ7skebBP7ynXuCJmvyDlv0Me8QzSTIRtCxIVOeiKmI/Sxpwc9+O0CR5+TKFHzCqKCy6c2zQ8U8aGhRexaCk//W5p51SRnfXyV0lrGgx4Ypgv8c8S/t47EahmRFDxsGAk2fUyC8uTXpSNmpRO+CyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607363; c=relaxed/simple;
	bh=U1FFhfIGgVmnFIAqFnO3ycODMkeXWNLKzbZrQTyeNkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xv/4MIeunAxcdS5jdrrze1uaDUejl8aPPUnrAwI9JQUFtNXzngcSJ2xvP6vw/KXw8KbukBcs6BSthySlMZsQg9Y0f+mAlirkPSTRblqirD1OnggTN7XHShJJ9KEntl0DLEav4CdIeqZrdqZNfA1adqMs385hnv2sJgNWsKk8hOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYQqhcgS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYQqhcgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6AB1F00A3D;
	Sat,  5 Sep 2026 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788607362;
	bh=9lciWz/KhZxXm3cVbO7PN0WBss1i3i2bh2I3OqpO8u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XYQqhcgSzxA9h7ectcMPu6F0xS97O8wWOUN3vmKE0b//vTGdxjnQTB1/Q2tUMY9k/
	 UA27JejE3On5WFQ72l78jTJGAkuUAYXjzQTDbhMu/WD0g3U4iVOe9WAi9c21neewy/
	 UoPNMTY64S2/dhMaYb/VLwZt+dMFWyzfyMPx4XTWUCnbpnygc6UFXCidxTVEjlkL1E
	 u0UOTgFb1t4yQBTws7EPvCBgJY+DK/f967/1GLM9NJKyz/HFTXEPTEpAmBWSNTpDI4
	 mdoycLQ69cPlHuLdljqFp4pT9ErCbnYIWt49YOy/eeD82szBdrE1uzf8Mnv9r4/fYA
	 GLJT0TT0pY47Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Hyunwoo Kim <imv4bel@gmail.com>, Christian Brauner <brauner@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>,
 Ingo Molnar <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 "Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch 1/8] signal: Prevent exec() race
In-Reply-To: <apvJ0PO7DJnh1JHS@pavilion.home>
References: <20260904112100.683893401@kernel.org>
 <20260904112202.074391651@kernel.org> <apqs6wgDtpdLI-k8@redhat.com>
 <87zexw5exv.ffs@fw13> <apvJ0PO7DJnh1JHS@pavilion.home>
Date: Sat, 05 Sep 2026 13:22:39 +0200
Message-ID: <87o6ec54e8.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 05 2026 at 09:50, Frederic Weisbecker wrote:
> Le Sat, Sep 05, 2026 at 09:34:52AM +0200, Thomas Gleixner a =C3=A9crit :
>> On Fri, Sep 04 2026 at 13:35, Oleg Nesterov wrote:
>> > Thomas, I can't read this series today, will try on Weekend.
>> >
>> > But you didn't reply to
>> > https://lore.kernel.org/all/apgHJj0qH7HlAXKO@redhat.com/
>> > Let me quote that email here:
>> >
>> > 	OK... lets suppose the exiting task T passes exit_signals().
>> >
>> > 	Suppose we have an "ignored" timer tmr. Another sub-thread calls
>> > 	do_sigaction() -> posixtimer_sig_unignore() and finds that tmr
>> > 	in ->ignored_posix_timers list.
>> >
>> > 	But posixtimer_queue_sigqueue() doesn't check PF_EXITING, I guess
>> > 	it should check it too?
>>=20
>> From the patch:
>>=20
>> @@ -1990,6 +2004,9 @@ void posixtimer_send_sigqueue(struct k_i
>> 	if (!likely(lock_task_sighand(t, &flags)))
>> 		return;
>>=20
>> +	if (unlikely(tmr->it_pid_type =3D=3D PIDTYPE_PID && (t->flags & PF_EXI=
TING)))
>> +		goto unlock;
>> +
>
> But posixtimer_sig_unignore() calls directly posixtimer_queue_sigqueue(),=
 not
> posixtimer_send_sigqueue().

I obviously can't read.

> However posixtimer_queue_sigqueue() -> complete_signal() -> wants_signal()
> checks PF_EXITING and complete_signal() then just drops it.
>
> Ah but doesn't that leak a refcount drop? Looks like the PF_EXITING check=
 should
> indeed move to posixtimer_get_target().

Again. get_target() is not protected by sighand lock when called in
posxtimer_send_sigqueue().

Let me stare at it some more.

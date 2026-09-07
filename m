Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813A3B19BA;
	Mon,  7 Sep 2026 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820089; cv=none; b=b8lWd85uUYuK1ZrCl/V03FFPhEd/VWb32ek3OXPaYSkf8mKLbIY1etCT00xoVcrLrDtMu0ChQBmAJSX1u1qNDZhldJBRBJdXMAj02UcSPF0T8EoMXohjVCAG/w4gxSK0jgnVf/MUHfQRUahR1sJBnFR5Mmued5gHkh3VIQWhHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820089; c=relaxed/simple;
	bh=kFsP8flph4By5hSciAQBrkAJYYF2XHr8hl58A6t7uB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGobEJTWN5WuqIC8vqwfGWuGW3YeZLPNEOXUS8Tk05rwU9AICS4c2BxxpsAMloM67ga+rR9PLAsV3Eo9ldnO7jPmWWUHs36Vn48K4566tkJPWOMCSkHKhJWRqDLeHRZ0jMR0jc/EZB64KZCI7SYqMN+NwTuehS9PDdSF4aKpiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c77j3gHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c77j3gHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1061F00A3D;
	Mon,  7 Sep 2026 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788820088;
	bh=CrjVftsd1fDJTk3OIWY22Z3hvfMnt42igjADpNK0vfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=c77j3gHGJEuQykImQKnfc9hUR+TEmlYCyI/SWgLWJ30uf1v5BJ0KbhjwaT73Ollqs
	 kam3QhfGx5KvQBfkcnHRt7huZiXW/ROsYHqvsBB0pgVIHWv1U9sVIbLWOrdgTz7JB4
	 E3CLG0wwr3GdzAyivM5Dfvmk3Amc0usM1JFndiqJZZd3lGcLKGWtQB5FpTVPAo58W7
	 MJhR9yxRr/zwTFGOG53LkdcnrnhOuGP+N3GUjYsUDl86tr5l0u5oQTcu0NJvZalBvV
	 CmG5k3jBf3KP++Pddt9bX0Dx6fONmVmDqlbCEr9oa7bwts4FE7WzzXWVJ/uubDRaAv
	 PnkkbKDfdoMbw==
From: Thomas Gleixner <tglx@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Cc: Hyunwoo Kim"
 <imv4bel@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz
 <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>,
 stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
In-Reply-To: <ap8bUiYYwQT1nVg5@pavilion.home>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain> <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
Date: Tue, 08 Sep 2026 00:28:04 +0200
Message-ID: <875x0g3de3.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07 2026 at 22:15, Frederic Weisbecker wrote:
> Le Mon, Sep 07, 2026 at 05:26:04PM +0200, Thomas Gleixner a =C3=A9crit :
>> It's not obvious of course and might deserve a comment.
>>=20
>>       exit_signals()
>>         lock(sighand)
>>           old_leader->flags |=3D PF_EXITING;
>>           head =3D remove_signals()
>> #1      // RELEASE: PF_EXITING must become visible
>>         unlock(sighand)
>>         flush_list(head)
>>=20
>>      ...
>>      posixtimer_exit()
>>        posix_cpu_timers_exit_task()
>>         lock(sighand)
>>         ...
>> #2      // RELEASE: The stores in flush_list() must become visible
>>         //          They might be already in case of preemption
>>         //	    or due a RELEASE operation in seccomp_filter_release()
>>         unlock(sighand)
>
> That second step only appears at the end of the patchset, right? Otherwise
> it's done on release_task(), which is after transfer_pid().

Cleaning up the enqueued posix CPU timers has nothing to do with the
signals.

>>     exit_notify()
>>       lock(task_list_lock)
>>       exit_state =3D EXIT_ZOMBIE;
>> #3    // RELEASE: exit_state must become visible

In context of patch 1 alone, this RELEASE operation guarantees that the
stores in flush_list() are visible.

The new leader cannot proceed with swapping the TIDs _before_ it
acquires task list lock and observes under task_list_lock

         old_leader->exit_state !=3D 0

The TID swap cannot be reordered by the CPU _before_ task list lock is
acquired and the exit_state is observed as non-zero.

As the exit_notify() RELEASE made both the exit_state store and the
preceeding flush_list() stores visible the third party must observe them
correctly as well when it can observe the TID swap.

It does not matter whether the RELEASE operation after flush_list() is
spin_unlock(siglock) or any other RELEASE operation before and including
the final one in exit_notify().

Any of them will provide the guarantee because _all_ preceeding stores
must be visible before the RELEASE operation is complete.=20

No?

Thanks,

        tglx









Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4136F91F;
	Sat,  5 Sep 2026 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788593697; cv=none; b=Vtx6yejClG94QysLl39EUmwk43FKBhJAHiukGxXIj9NxBc/0ifSf9kD0n+uMGCsoYOoaimbCSCgunH17s01AG0oEkHbrdCzwVtEezDDPkJv6PXbb/50cz79hFFL3N0Yv4ZV/1qx+bInxlyRCeTx7MNrQJco7bpMiR2bRvjtvmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788593697; c=relaxed/simple;
	bh=KqhRb7TRaO4oUTnAn3+0uR6jeZjjx+QI/9BBsvkDdrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wb4QPJuAvAmSpjaQtspDU+t59pO5Zhbb4PZWSVkAXK4WmAaL+St/J2CkZ5E/x8d6tsG0nHImS7Zf4dPaSeTJHXBXU/QWJbtS0nWBbKzjziZPTrRsswepGEoQ7jTEep9CjNRKcXxtwl8E4K7Qqg7ZutNuiktI/d12RDqIDkNO4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjnMXgcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjnMXgcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E91F00A3D;
	Sat,  5 Sep 2026 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788593695;
	bh=JUhUTyBAxM0l7I08t5Sh934jIW0eNDg1bZYMXNdSnOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VjnMXgcpfqz1VY9tQ6xqIxdT0yLbLVH1nxzvmUVRarBcZnhMnKcWSsSqYIutvfr3H
	 P9oz/qxswT6yFzcOg2Bri1WAmMwQPty5gn0VCtlbwpS/cN5tJ9jFPdaLcKkVtwydtt
	 H+J9pIzHQeiOVTW9CMCV6QJW3JFxRF9tEbwzFZl1sKqit2oYvgTqBkOo3v9aHXPfto
	 DX/FaBYmdcvfWRPU2RT+WPxBi4acVjzz6C6GCKlhYdiTBOjhHr3Nrm2u3Dicz8dXt6
	 wXM7O+ydyEXd4ZQ/L2VNF/3mci5SMICPm6mpJFyRe850nexE6FiDkNw6+2ifwNldm2
	 U30v4duv5qN4Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz
 <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>,
 stable@vger.kernel.org
Subject: Re: [patch 1/8] signal: Prevent exec() race
In-Reply-To: <apqs6wgDtpdLI-k8@redhat.com>
References: <20260904112100.683893401@kernel.org>
 <20260904112202.074391651@kernel.org> <apqs6wgDtpdLI-k8@redhat.com>
Date: Sat, 05 Sep 2026 09:34:52 +0200
Message-ID: <87zexw5exv.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 04 2026 at 13:35, Oleg Nesterov wrote:
> Thomas, I can't read this series today, will try on Weekend.
>
> But you didn't reply to
> https://lore.kernel.org/all/apgHJj0qH7HlAXKO@redhat.com/
> Let me quote that email here:
>
> 	OK... lets suppose the exiting task T passes exit_signals().
>
> 	Suppose we have an "ignored" timer tmr. Another sub-thread calls
> 	do_sigaction() -> posixtimer_sig_unignore() and finds that tmr
> 	in ->ignored_posix_timers list.
>
> 	But posixtimer_queue_sigqueue() doesn't check PF_EXITING, I guess
> 	it should check it too?

From the patch:

@@ -1990,6 +2004,9 @@ void posixtimer_send_sigqueue(struct k_i
	if (!likely(lock_task_sighand(t, &flags)))
		return;

+	if (unlikely(tmr->it_pid_type == PIDTYPE_PID && (t->flags & PF_EXITING)))
+		goto unlock;
+

> 	Or perhaps it makes more sense to check PF_EXITING in
> 	posixtimer_get_target() ?

No. Because that's outside of the sighand locked region and therefore
can't provide a reliable answer.

Thanks,

        tglx

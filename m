Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922036;
	b=K24/uJ82TnbfGNP02wZz+NvC3p+itIMNomqXMNeXjPyqhiF+pGCGTGWTZNL/Qi1c18Ns
	 iGrLxaJaZZ6oMj6KGEyDkP3URR0sHAhYABUMoDeDI71ToTipXbIZr2X95JRLDC2Ooh+s8
	 RzbT9ihTyhSGXVIywZ7+3fNRRrJNVLNobQzN2XvC6o6/BwIvAjnwuJXOE170AFH/0273a
	 ksToofAS+2mZbHYAtvhmQar581pB4NlHbiPTBNzpa1VM0BDk69Our3lkFgZ78nCqQBoL6
	 jUsDjkGpoeUcjECFH4vK228eG7FVIDdCd8p42P/XFACKGp3U/8wHE5pstOWiSc7y6og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922036;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=DhpQikh/j+IYKn/SiXHM5qk/4wFDsh9pRbRs8jpBleU=;
	b=NtPSJSC5ZRmz7Ghwn1F9T8XlnHV2jKRAxu6zOPFAIbFhH0x6N3oD6Jrw9l+uJN7Lh+3Q
	 Bry9jqmceErCedZ6mMsOY3m2feaZ0YHwmawK/W0SF7ImWR4gofVqISC+0CpxFZvYCVxAd
	 Ko3cen4aGTodjaGCZUu/nxhDrSuaRNmBsync1nCO1HBDxa2ttSOY9d89s0jq5KC3lX1EU
	 vHPe0BODTqzo64SP7YwVtoZlFIO0lSLsXxfuIaJyXBdajoglqDtqMgFzXpvmWP63yfZze
	 4Ys3DV7fuYL0/s+neeV0/RDwb5jx+9iL6mGkUdrT31XNhwRxWVN+HqU/o6R+B9BHpbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LcOiSOKu;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF1D606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF1D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LcOiSOKu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794922035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhpQikh/j+IYKn/SiXHM5qk/4wFDsh9pRbRs8jpBleU=;
	b=LcOiSOKusLHd8FboIu3hI6wzpEJn1UvxqP+ylDKOjsUGznep3faoD/a1gZTh8yP79MAkka
	GIu/tY20yCMdBjzAvKhwdH0VB4LKUyyehVPzXRkUkGRloitYxYBvrWoxiYRg2aYK0H20G6
	45K0ca+rrnisXNfc/X41JpWcLV+ZT/Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-vqidz2F6MtC3esXBLjIAAQ-1; Tue,
 17 Nov 2026 08:27:11 -0500
X-MC-Unique: vqidz2F6MtC3esXBLjIAAQ-1
X-Mimecast-MFC-AGG-ID: vqidz2F6MtC3esXBLjIAAQ_1794922029
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 107041955D88;
	Tue, 17 Nov 2026 13:27:09 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A1725180054B;
	Tue, 17 Nov 2026 13:27:05 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 17 Nov 2026 14:27:08 +0100 (CET)
Date: Tue, 17 Nov 2026 14:27:04 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <avxWKI795DthE8Sb@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Mani reports the case when f1cebdec9739 ("pipe: only enable the extra
wake_up(rd_wait) for EPOLLET consumers") makes a difference, see his
email below.

But lets forget about that commit for the moment. With or without that
commit this trivial test-case hangs,

	#include <unistd.h>
	#include <sys/epoll.h>
	#include <sys/wait.h>
	#include <assert.h>
	#include <stdio.h>

	int main(void)
	{
		int pfd[2], efd;
		struct epoll_event evt = { .events = EPOLLIN | EPOLLEXCLUSIVE };
		char c;

		pipe(pfd);
		efd = epoll_create1(0);
		epoll_ctl(efd, EPOLL_CTL_ADD, pfd[0], &evt);

		if (!fork()) {
			epoll_wait(efd, &evt, 1, -1);
			read(pfd[0], &c, 1);
			printf("1st: %c\n", c);
			return 0;
		}

		sleep(1);

		if (!fork()) {
			read(pfd[0], &c, 1);
			printf("2nd: %c\n", c);
			return 0;
		}

		sleep(1);

		write(pfd[1], "12", 2);
		assert(wait(NULL) > 0);
		assert(wait(NULL) > 0);

		return 0;
	}

the 2nd non-epoll child sleeps in read(pfd[0]) even if pipe is not empty.

anon_pipe_read() assumes that all exclusive waiters on pipe->rd_wait come
from anon_pipe_read()->wait_event_interruptible_exclusive(), and the woken
reader will set wake_next_reader = true.

However, EPOLLEXCLUSIVE breaks this logic. ep_ptable_queue_proc() does
add_wait_queue_exclusive() if EPOLLEXCLUSIVE is set. So write(pfd[1]) above
wakes up the 1st "epoll" child, which then reads one byte from the pipe without
sleeping, so it doesn't set wake_next_reader and thus it doesn't wakeup the
2nd waiter.

Again, this happens with or without f1cebdec9739. But that commit makes a
difference: the 2nd child will continue to sleep even after another write
to this pipe. So Mani suggests the trivial change which should restore the
previous behaviour

	--- a/fs/pipe.c
	+++ b/fs/pipe.c
	@@ -700,9 +700,13 @@ pipe_poll(struct file *filp, poll_table *wait)
		 * and the ->pseudo_edgetrigger check in anon_pipe_write().
		 * Currently io_uring sets EPOLLET for multishot polls, so it gets the
		 * same behaviour.
	+	 *
	+	 * EPOLLEXCLUSIVE needs them too.  Its entry is an exclusive waiter on
	+	 * ->rd_wait that can take the wakeup meant for a blocked reader, and
	+	 * unlike a woken reader in anon_pipe_read() it doesn't pass it on.
		 */
		if ((filp->f_mode & FMODE_READ) &&
	-	    wait && (wait->_key & EPOLLET) &&
	+	    wait && (wait->_key & (EPOLLET | EPOLLEXCLUSIVE)) &&
		    unlikely(!READ_ONCE(pipe->pseudo_edgetrigger)))
			WRITE_ONCE(pipe->pseudo_edgetrigger, true);

But I can't decide if we actually want to bless another historical
"nonsensical" wakeup until have a user application that actually cares?

Again, the test-case above will hang with or without the patch above, with
or without f1cebdec9739. So do we really care? If yes, then perhaps we should
also change anon_pipe_read(), something like

	--- a/fs/pipe.c
	+++ b/fs/pipe.c
	@@ -468,6 +468,8 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
		}
		if (pipe_is_empty(pipe))
			wake_next_reader = false;
	+	else if (pipe->pseudo_edgetrigger) // for EPOLLEXCLUSIVE
	+		wake_next_reader = true;
		/* Consumed buffers may have refilled the pool; trim it and unlock. */
		anon_pipe_trim_and_unlock(pipe);

?

(of course, this won't help if the 1st child doesn't do read() after epoll_wait()).

What do you think?

Oleg.

On 11/11, Mani Tofigh via B4 Relay wrote:
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> A task blocked in read() on a pipe can sleep while the pipe holds data,
> when an epoll(EPOLLEXCLUSIVE) watcher of the read end was added before
> it.  The watcher's entry on ->rd_wait is exclusive and sits ahead of the
> reader, so a write into an empty pipe wakes only the watcher.  The
> watcher reads without sleeping in anon_pipe_read() and doesn't pass the
> wakeup on.  Since commit f1cebdec9739 ("pipe: only enable the extra
> wake_up(rd_wait) for EPOLLET consumers") the next writes into the
> non-empty pipe don't wake anyone anymore:
>
>   Task E                   Task A                 Task C
>   epoll_wait(ep, -1)
>     /* EPOLLEXCLUSIVE */
>                            read(p[0])
>                                                   write(p[1], "1")
>                                                     /* wakes E only */
>                                                   write(p[1], "2")
>                                                     /* no wakeup */
>   read(p[0], 1 byte)
>   exit()
>                            /* still asleep, "2" is in the pipe */
>
> A then sleeps until the next write into an empty pipe, if ever.  Before
> that commit any pipe_poll() enabled the per-write wakeups.  Those
> reached A because an EPOLLEXCLUSIVE entry only takes a wakeup while a
> task sleeps in epoll_wait().
>
> So EPOLLEXCLUSIVE consumers depend on the per-write wakeups too, for a
> different reason than EPOLLET.  Enable them for EPOLLEXCLUSIVE as well
> and say why in the comment.  With the fix, A reads the second byte.
>
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 2s.
>
> Fixes: f1cebdec9739 ("pipe: only enable the extra wake_up(rd_wait) for EPOLLET consumers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/pipeexcl.c
>
> There are a couple of older gaps like this (a single write, and the
> write side with EPOLLOUT|EPOLLEXCLUSIVE).  I left both alone here though.
> ---
>  fs/pipe.c                 | 6 +++++-
>  include/linux/pipe_fs_i.h | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 4c1122597a3c..8ad792d300c9 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -700,9 +700,13 @@ pipe_poll(struct file *filp, poll_table *wait)
>  	 * and the ->pseudo_edgetrigger check in anon_pipe_write().
>  	 * Currently io_uring sets EPOLLET for multishot polls, so it gets the
>  	 * same behaviour.
> +	 *
> +	 * EPOLLEXCLUSIVE needs them too.  Its entry is an exclusive waiter on
> +	 * ->rd_wait that can take the wakeup meant for a blocked reader, and
> +	 * unlike a woken reader in anon_pipe_read() it doesn't pass it on.
>  	 */
>  	if ((filp->f_mode & FMODE_READ) &&
> -	    wait && (wait->_key & EPOLLET) &&
> +	    wait && (wait->_key & (EPOLLET | EPOLLEXCLUSIVE)) &&
>  	    unlikely(!READ_ONCE(pipe->pseudo_edgetrigger)))
>  		WRITE_ONCE(pipe->pseudo_edgetrigger, true);
>
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 95f6236c5c5b..6b2e14ec6ef8 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -90,7 +90,7 @@ struct anon_pipe_prealloc {
>   *	@files: number of struct file referring this pipe (protected by ->i_lock)
>   *	@r_counter: reader counter
>   *	@w_counter: writer counter
> - *	@pseudo_edgetrigger: has an EPOLLET consumer, enable per-write wakeups
> + *	@pseudo_edgetrigger: enable per-write wakeups for EPOLLET/EPOLLEXCLUSIVE
>   *	@fasync_readers: reader side fasync
>   *	@fasync_writers: writer side fasync
>   *	@bufs: the circular array of pipe buffers
>
> ---
> base-commit: b0993210e420f2f1d61e6719fbcd3966b96ff9ed
> change-id: 20261111-pipe-epollexclusive-wakeup-981528041b4d
>
> Best regards,
> --
> Mani Tofigh <mt4022@columbia.edu>
>
>


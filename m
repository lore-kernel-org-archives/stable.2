Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521270;
	b=nt9iIQsJsWlPM/FpuEliB1NwrRf5Dc32MELW4ujae0nFZYfpLH+V5S6h3QPSnTdZ6Z1Q
	 M0CRLQa7SRICzU2M+wcstqBplYmyWzUV77H7Gr6kaHC18fFCca+zmG45YJ8+d3y1aQFA5
	 Ysgae/79LvrNdBWJJN73RvhM0tpXOmPWj5qS2NUqZ4RzQ3Ms4BQKoCekZRBVMqHH2UZz3
	 9j5W0NHAVrujfpJJYjNFVxiF5O8AV6QK1Rb0NVKcbcS8aEn4+26eOKQ4DphoF4PO/a6zW
	 nKOKIjRkOGAzjuH71ET33K2j8q3QdAe6XH96yfm15LjYWCEkvsg4ZhGHA3oGm8aEjoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521270;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=SazTzdn4IEa6QiZ2+dOeuOq88TDrasWUOqoW06iFXvo=;
	b=aHsusydjawYI1o0J9gyLHfVlucbN+AkU6eyc5kCRzLJKBGq6EpjrHjBkzlqxHUdgucVC
	 KVyR30wt0q3eSqQ/EXzHAPhF+49DzgP+XpOPvDQQTZEr7jP9/OTzDLpmy+OFPw+92T1ZZ
	 JxShCV58pO5cDi6JClzg6mACrfFtIOj0MB2K5gktlRkGQZTPw+1yHfXNjgWsHwG/KXPGF
	 Z6IbNHKkOVnndwRBE6Fx+24N8UxVKhlTem4KT5qjGv4TH9SwvtiAzi+KRMYqu09FfDsiQ
	 X/IQGN95pVQQkMPon7Rqk9sW3UYf/PD6fmdX7WvyN45yi3+fOCIbU9j0Wr8f/CuEEgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="QkR/Tblq";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEF606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30EEF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkR/Tblq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795521269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SazTzdn4IEa6QiZ2+dOeuOq88TDrasWUOqoW06iFXvo=;
	b=QkR/TblqxU1zKMLMl412HhoWnShgo3oOmJZrpSH0fsl4e1TRfeNpePahO78FbFDec3jAco
	IIYLBiCVRZQRTUUInDZRoo7b5qrNCedoVe1tOE5Wr0sFcatEotR0lLU9UzXztN/FwMFuqA
	BVdQWyPQC4ibsieK+whiA5URyxVkgyM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-wSrG8mvnNHeWAvs1NWoD-g-1; Tue,
 24 Nov 2026 11:54:23 +0000
X-MC-Unique: wSrG8mvnNHeWAvs1NWoD-g-1
X-Mimecast-MFC-AGG-ID: wSrG8mvnNHeWAvs1NWoD-g_1795521262
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A20151802171;
	Tue, 24 Nov 2026 11:54:21 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9FE31956087;
	Tue, 24 Nov 2026 11:54:17 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 24 Nov 2026 12:54:21 +0100 (CET)
Date: Tue, 24 Nov 2026 12:54:16 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
Message-ID: <awV66PQWrBOKcZCE@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BuV4xHRsX/o8lmUR"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

--BuV4xHRsX/o8lmUR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/23, Linus Torvalds wrote:
>
> On Sun, 22 Nov 2026 at 16:35, Mani Tofigh via B4 Relay
> <devnull+mt4022.columbia.edu@kernel.org> wrote:
> >
> > A task blocked in read() on an eventfd or timerfd can sleep forever
> > while the file is readable, if an epoll(EPOLLEXCLUSIVE) watcher of the
> > same file was added before it.
>
> Honestly, I don't think this is the right approach.
>
> We need to fix the disaster area that is epoll, rather than work around
> more epoll bugs elsewhere and make other places more fragile and
> complex.

I agree. But to me it would be better to apply this patch from Mani,
then do something else. Not because it "fixes" the scenario described
in the changelog. As for eventfd_read(), it probably makes sense to
change it to use wait_event_interruptible_exclusive_locked_irq() at
least if !EFD_SEMAPHORE, and then we will have the same problem with
EPOLLEXCLUSIVE again.

But simply because do_wait_intr*() are wrong regardless, and the
change is trivial. And perhaps the changelog should not mention
EPOLLEXCLUSIVE at all.

> And I think we should always add new waiters to the end of the queue,
> and stop any other games. Just walk the whole queue at wakeup time.
>
> Finally, I think we should make the return value from the wakeup
> function be a bitmask, and count "exclusive" as only "we haven't seen
> this bit returned yet". And then *real* exclusive users that actually
> guarantee that they react to the wakeup return all bits set, but the
> sh*t-for-brains garbage that is "epoll" only returns its own bit set -
> so we only wake up *one* epoll user, but we wake up other users anyway,
> because epoll clearl yis lying about its "exclusivity".

Perhaps... But it is not clear how to do this gradually...

And lets forget about epoll for the moment. Lets suppose we change
__wake_up_common() to do

	list_for_each_entry_safe(curr, next, &wq_head->head, entry) {
		bool excl = curr->flags & WQ_FLAG_EXCLUSIVE;
		int ret;

		if (excl && !nr_exclusive)
			continue;
		ret = curr->func(curr, mode, wake_flags, key);
		if (ret < 0)
			break;
		if (ret && excl)
			--nr_exclusive;
	}

This will change the current behaviour if ret < 0. Say wake_page_function() does

	if (flags & WQ_FLAG_EXCLUSIVE) {
		if (test_bit(key->bit_nr, &key->folio->flags.f))
			return -1;
		...

so this logic depends on wait-queue ordering too. "ret < 0" can be encoded
in the bitmask, but it is not clear what exactly __wake_up_common() needs
to do in this case.

Can't we at least cleanup __wake_up_common() ? See the patch below, I already
sent it but it was ignored.

Oleg.


--BuV4xHRsX/o8lmUR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-sched-wait-kill-leftover-bookmark-logic-in-__wake_up.patch

From 887e7597e23b1beb5c6ed536cb342a2daa740ce5 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 12 Nov 2026 15:53:53 +0100
Subject: [PATCH] sched/wait: kill leftover bookmark logic in
 __wake_up_common()

The manual list head check and list_for_each_entry_safe_from() in
__wake_up_common() are leftovers from commit 2554db916586 ("sched/wait:
Break up long wake list walk").

This logic was later removed by commit 37acade0ce89 ("sched: remove
wait bookmarks") but the now-unnecessary list hacks were left behind.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sched/wait.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index f8d6d8b9d03e..d0521b54eeb3 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -96,12 +96,7 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 
 	lockdep_assert_held(&wq_head->lock);
 
-	curr = list_first_entry(&wq_head->head, wait_queue_entry_t, entry);
-
-	if (&curr->entry == &wq_head->head)
-		return nr_exclusive;
-
-	list_for_each_entry_safe_from(curr, next, &wq_head->head, entry) {
+	list_for_each_entry_safe(curr, next, &wq_head->head, entry) {
 		unsigned flags = curr->flags;
 		int ret;
 
-- 
2.55.0


--BuV4xHRsX/o8lmUR--


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527376;
	b=wWHRVp07OtLoIGJUkH9b+5I/ugNZTSPs09FIepSOsAkVGqbhkbVR3A6da8E5fKEEMKVN
	 gLYbR+eucUfKfFkkbxiosnN9D51wx8Sn3VGlUhghJFMdFKigPtVPqqqBoKByqlPOyagV9
	 oQM1KpjFST8qHNuqQaMSpoSjCSvexXHi18lTsFfVB7m+H3FeMewLd01FSslZ17HF1YdjE
	 sGHkGXdSiDJ4/eTBM03SoHWdv3nU9ATDcWz+XhMa0DxUSqoRlUdm861xwYjXUNN1pUwP/
	 /AclesvoldwN8oOa8dLfVy89+Hz1MghHs3BWHTZPJYQnyK2YtJNTIUOQaKcxWVvNr3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527376;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=+ig6FTaY9UYhfakPyt5XHggpDeHMd5GJavSEOD3Ro6k=;
	b=GrBrB9KOsghYQ5iPyU+xSYR2/pUGG6SiMz+ldtoIkVRYzqD/8qM5q6Yf7jUfBHpt/wov
	 9iqZqMRfUFwxo8wtN90Bc1coySRT5gRdzya1o6mRmzH7NuZ8DuyiqKmQfz57/eDMwwWKu
	 A5JGh3RqyVD1LflyxaGrTIC4zM6uOJcMwpRuweB2Jmpxw3RcqOg2qdYIfU5+rA59FSDYA
	 7aplVGTxrdr0wmdZGIFVcIGYUIy3yqT/7z/c5LdLLAjF/OAsD16s13wa7QdjYXIZjHCgs
	 WOq2RaSGzrQm93oxLPhHHJUn/2FDBPQWHVWoHbYjhv2Jz3TOkljR1s9pqUhTp3piKiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJVJhF3y;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C29606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C29606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJVJhF3y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795527374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ig6FTaY9UYhfakPyt5XHggpDeHMd5GJavSEOD3Ro6k=;
	b=KJVJhF3yqQJDhT9WNVZj1o8siSmiAvsapP2m/AdlCBGlLGsX3M1TnBZU+bNNUWyYx70PtT
	kWj/uNtk0NYhlvuNBNu5qK34XGWE/R/C7zB4yBqu+WlqW8lLZGJNB2ebzaQlvZDLfJbWGr
	0prVjd4kEdZX5C8eIy6Ttj7sNSsNlBk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-ZdDEksctOqGrPB9-9Qiw8A-1; Tue,
 24 Nov 2026 13:36:09 +0000
X-MC-Unique: ZdDEksctOqGrPB9-9Qiw8A-1
X-Mimecast-MFC-AGG-ID: ZdDEksctOqGrPB9-9Qiw8A_1795527367
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AB561800344;
	Tue, 24 Nov 2026 13:36:07 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B4F295B1;
	Tue, 24 Nov 2026 13:36:03 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 24 Nov 2026 14:36:06 +0100 (CET)
Date: Tue, 24 Nov 2026 14:36:02 +0100
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
Message-ID: <awWSwmvaTwBxfU-r@redhat.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/23, Linus Torvalds wrote:
>
> Finally, I think we should make the return value from the wakeup
> function be a bitmask, and count "exclusive" as only "we haven't seen
> this bit returned yet". And then *real* exclusive users that actually
> guarantee that they react to the wakeup return all bits set, but the
> sh*t-for-brains garbage that is "epoll" only returns its own bit set -
> so we only wake up *one* epoll user, but we wake up other users anyway,
> because epoll clearl yis lying about its "exclusivity".

Ah, I don't think this can work... Suppose that ep_poll_callback()
returns its own EP_XXX bit set. Should __wake_up_common() wake up
the next waiter? It can't know until it calls ->wake_up_fn() which
can wakeup another epoll waiter.

Well. It is not that I like this idea (and I bet neither you ;) but
we can add WQ_FLAG_EPOLLEXCLUSIVE set by ep_ptable_queue_proc() and
__io_queue_proc(), and change __wake_up_common() to check it

	static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
				int nr_exclusive, int wake_flags, void *key)
	{
		wait_queue_entry_t *curr, *next;
		bool seen_epoll = false;

		lockdep_assert_held(&wq_head->lock);

		list_for_each_entry_safe(curr, next, &wq_head->head, entry) {
			unsigned flags = curr->flags;
			int ret;

			if ((flags & WQ_FLAG_EPOLLEXCLUSIVE) && seen_epoll)
				continue;

			ret = curr->func(curr, mode, wake_flags, key);
			if (ret < 0)
				break;
			if (ret && (flags & WQ_FLAG_EXCLUSIVE)) {
				if (flags & WQ_FLAG_EPOLLEXCLUSIVE)
					seen_epoll = true;
				else if (!--nr_exclusive)
					break;
			}
		}

		return nr_exclusive;
	}

for the start.

Oleg.


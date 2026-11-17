Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948103;
	b=PT380Hrsl3s/Ze03lIbrU0REI8j0sGj+jWx6xcV9i0a1XEzR02cb5FTgq/Oi5BYLBg9T
	 G38QTNpXcvDH68Uf17Hkbj8X2efmJwTQuAc1qBBPFYLBmMIJA8vUWdwvJkYmPLjmBFw6Z
	 0vtNiJmRJDBVecx6aq8hHQTV3br4QHgNWd7SmPf09uRCC1rk783hqr3ynEGzfT+XVRUPC
	 3Q+Wzwz+Gobxc1UECz3sNUXbhFSghSJt9PQ0TI3+wLGeQQYNFzEUYA8sTmHKbfIHJX5tk
	 u7HVqzjDAwtJOtQ1OpSLLSzSwR2HIvk/s4mTEX+uzPBi7Nu3LWZ8V0Nx3yd1Q7gimnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948103;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=S7xqb7UvzbEnUt6XJ1+tm8jlYeEATOyg2jR5hBQlbVo=;
	b=EqdEhmHwjAN6sMCBv7mjvjk7DNGbUvtWa4RM0oAuPKC7agU6O4YrDyfw103FjmhtuDOD
	 W8olDohxEukaTuKmCrpLhb/p3NEXjEau6liVjftaX1RZqBYoknk3ybjD0VHlYSIiqm+Bc
	 FNfRnTMtsLjSqM6imkq1o/LZLWuzrGEAx8o8XzVpUqrKY16hNYFKCgLx1kZbvcL+qr5gB
	 aPN3M3IVPkf4HN+GVzIBJBtmnCLJ+ZjXt0HIYesgw7Yh1KtWmCVdZl4aLmj7f3v3VCoqq
	 XR4IwGsh+QwJ/9Gx+ca0BoEsqdvv+NOfvkeVYApPLjSNDmV4hfyQ68Q/jSxc6zQT/vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bXZNs9D2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EA606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 20:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC4EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bXZNs9D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794948101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7xqb7UvzbEnUt6XJ1+tm8jlYeEATOyg2jR5hBQlbVo=;
	b=bXZNs9D2fydnwopBPydpEPOstb8xW008WrgszYjsDMip9BVuNPC30GC45PGeHUQ36U+jxl
	fzxCs4/b+pzlMK5WWsMUKzcdBrMESuY7ukrfhIZHyF3l9GZ+CPrcvXxZrDN+7/2EwGph+J
	BIkINs3Nn6yxVvHXRcqhKoq2YuamvJs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-tH5EHz67OeyDOL9pbbFrUA-1; Tue,
 17 Nov 2026 15:41:38 -0500
X-MC-Unique: tH5EHz67OeyDOL9pbbFrUA-1
X-Mimecast-MFC-AGG-ID: tH5EHz67OeyDOL9pbbFrUA_1794948095
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A32518004FE;
	Tue, 17 Nov 2026 20:41:34 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D0B70180056E;
	Tue, 17 Nov 2026 20:41:30 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 17 Nov 2026 21:41:34 +0100 (CET)
Date: Tue, 17 Nov 2026 21:41:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <avy7-XJkoRyslipt@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com>
 <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com>
 <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com>
 <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/17, Linus Torvalds wrote:
>
> Side note: as part of looking at it, I did look at what it would
> involve in our wait.h infrastructure.
>
> That header isn't _horrible_, but some of it was uglier than needed,
> and adding WQ_FLAG_PRIORITY would have been a huge pain because the
> code unnecessarily special-cases WQ_FLAG_EXCLUSIVE.
>
> So while I threw the rest of my trial patch away, this patch remained
> as a cleanup. It *looks* sane to me, and I think the end result looks
> better and would be more flexible.
>
> For example, it would have allowed just adding a new user of
> ___wait_event() that used WQ_FLAG_PRIORITY to put itself at the head
> of the queue.

...

> -#define ___wait_event(wq_head, condition, state, exclusive, ret, cmd)		\
> +#define ___wait_event(wq_head, condition, state, wq_flag, ret, cmd)		\
>  ({										\
>  	__label__ __out;							\
>  	struct wait_queue_entry __wq_entry;					\
>  	long __ret = ret;	/* explicit shadow */				\
>  										\
> -	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
> +	init_wait_entry(&__wq_entry, wq_flag);					\
>  	for (;;) {								\
>  		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\


Damn ;) I simply can't resist.

I swear, I was thinking of exactly that same change during our discussion.
So I think it is obviously good and makes sense, but I will try to re-check
it after sleep.

Oleg.


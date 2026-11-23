Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450740;
	b=FFgbVTWp3f4yiQ1K4f0sSgT1pAbW8CBcaWPTdeXr/WXneGmkU6Fo9iDbL0KQm9EaDYnA
	 0aULFdhH8KFkAmWnygGs7FeGvY4HnepX+Gd5jSv09eyblYkqPpqxT9DCOs0sCh2bDbLUp
	 kcUv0/xi76dnBhgJcVENn965+HQTbkdW6+3xspe6RnEQBjTQQTYHbeJSiyXSo+gpWn7cQ
	 HB5vWSuzPsOB9NQ9d89Ru013ElaaUmbonbxu0K/QaQxI1jkDJkDXnhhzAjkZQYonmtpLD
	 ojBVxmwmhW8HNFAmO/JcXUpn7kE0MOvxr+gqGxJIQyeOf9TGdrF6KvlN5qdGPWxXgJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Qb3afpjfNKL4NW0mFPEpkg1ptnndJIVYWJyHLR3epgc=;
	b=Y6VRedl3EKwlpDlmx1e4dMsayhI7WdPsCyPKh0/aUixABB19U84OdOIC4b2O3ndLugFr
	 j8nRj0Q2NztqYAJa2M8Bb+24AY17ASHf+W0PG51KpCFH7A+nRfHpZ/Y9h6MQyWd8Iy3B3
	 +fTcxnAKEl8bCOhAyhoHTCjAMoA45IZADvIe7GgAjJCCRlcB+AA77rGKOt8aUWUwd+wtG
	 VOcsyTLN5bnwNuETbFXDjYY7LRLPGCNgrowI4IW6AgIIB4iuSLbfipl6mzAVh9/hH0yln
	 meNV1Z28xpZtSSxhiMgGGjQr4dnCRwvAc5AOBTAS6KoeswUyJymqmZSUxWkOxGJ6fLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mDy575Ld;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11A606A31A;
	Mon, 23 Nov 2026 16:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA11A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mDy575Ld
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jYB2q1Tgbz1XM6Hx;
	Mon, 23 Nov 2026 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795450734; x=1798042735; bh=Qb3afpjfNKL4NW0mFPEpkg1p
	tnndJIVYWJyHLR3epgc=; b=mDy575LdZGhwaCqlKZEzucW3H19DrXMU8Ej1CUQS
	n3RPo/dKz2JpDqIBXHPGbvwYsv4DgpUV9pPgv4MS4DRja0O3hwSErPBm8vraormq
	U7b1ls7rL9QexvoJv14a0cAi7eSRqSX0gDGUqRon1y4jTqoZbnfBS5i2SaeFapAl
	K4rUukPxCDt/5ykRNtG66wGF+kiIS7Ve4M7JAzuY4fiVq0cBQHkuS/09eFHIxDsr
	4xgvRjDvyeb/DWW535SaD0W46QOOr39aslDAWxIap/BuOrYTMZU1u8ZxwaG0MpNS
	Z9duMVf21i1R65joYqQ7A8tCG6WvlXkDP6MEM0D6/WSIOg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nOt5yBC1lqBa; Mon, 23 Nov 2026 16:18:54 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jYB2j75Mhz1XM4Tn;
	Mon, 23 Nov 2026 16:18:53 +0000 (UTC)
Message-ID: <0c9c4e2a-2fd9-4e0c-846c-d2f810ee2cd8@acm.org>
Date: Mon, 23 Nov 2026 08:18:51 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] jfs: wait for lbmDONE under LCACHE_LOCK in lbmRead()
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
 Edward Adam Davis <eadavis@qq.com>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <tom.leiming@gmail.com>, Hillf Danton <hdanton@sina.com>,
 Tao Cui <cui.tao@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, linux-block@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
 syzbot+ecf51a7ccb6b1394e90c@syzkaller.appspotmail.com,
 syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
References: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org>
 <20261123-work-loop-backing-file-v1-1-48f83eaf2499@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261123-work-loop-backing-file-v1-1-48f83eaf2499@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 5:02 AM, Christian Brauner wrote:
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 306165e61438c..e96593d79a1df 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1984,7 +1984,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
>   		submit_bio(bio);
>   	}
>   
> -	wait_event(bp->l_ioevent, (bp->l_flag != lbmREAD));
> +	lbmIOWait(bp, 0);
>   
>   	return 0;
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

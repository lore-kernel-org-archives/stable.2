Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795357374;
	b=PVwGoU70diU5ISQsGHf7Q14BUbSMoqC7xtpkr3BU5d9H37K4MOASxeDS4sQlyzvLSQy4
	 TgOOeU338tdZ0AL12j+3wOAyBWA6YYQY3Wrm+FZCQdYJvgwKT+IYyDX/j2k3QLj6J+g9B
	 VD6u48zgqS8KRIa/F4HYXZc7yhT6pVfSP6Mt71wUBxUPp8VhK1Lx384B13igUc5VJhjJa
	 HqFkf3gY60fPHOqT8Oi+9yNiUN17QWZNWgmwbcoCV1TPVAK+xqP1EB0QQMoDyHfKQQs9w
	 WSUCKwdHY6H4x2U1ufFzHASmJOsSsp6nX+rW7/bin4XedJ0VV6eMQkP3Fl55IlR1gAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795357374;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=ryvEPjqew3yO9j3FoUR+1enMAncqpW1VfNIetah7IDk=;
	b=HFxmeHAjZe3th5wWTtssnsBDR3duRHI3cFItoQAGTavaRj8IjgLD5QV1Z61ilgIaWnyb
	 TB9zaU4nCNr3SuWlfLS6+kq2J/0O4J0dJm40MHM491LK8uN9GGI4ZjOYBdBAMFHa9MJCN
	 ojL/kOalmks487wsopJVr4WhsDyixeD43UPxKmonbkESeR9C8nvpt9UQvBdor9FlVGh++
	 2Y5O0LEVslY3HF85908TEajDE9O0PugWhKw7IKwtFg5gW1W7GqXPBhjwvYfrB/2v97w2X
	 cv+zB3I00KKYP86GjYDfkytEODe2Yb62J+W7YYrAiYzJBupbG+HNcpOEOPy8oyXa78g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=JMxKDPpt;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D8606A32A;
	Sun, 22 Nov 2026 14:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 855D8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=JMxKDPpt
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXWW8432Xz5BNRx;
	Sun, 22 Nov 2026 22:22:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795357364;
	bh=AkAy6g5Mb/vdkDcejg0T3zp8tTGdMmRjwKRwl7qrpUE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=JMxKDPptcJN48tRTY9gX4hH2Z3eBv2l4XHGQL6AEtoTxS6lci8TLYtJJkwhJ2sKlH
	 rOdqdaX5Zu3WJNqwWuLVzvBjwK5iocP0SVQ3E6QlfazqY3TUJSRZi72qvPyqDi/73I
	 B0dF4Zdq9K+kiOODrs2KMbNhOx2xPpTwr1BuEnd1SDRB982agHo0sZwgwQtDocwnoZ
	 WxfC6XbbPXua9oxJP2hmX6qsKZgFXJQ/zsg4fzRHgpWTjGVFj8/GDcV56Gj3RWbcFV
	 LrXZYbp3NIW3lh+2QTw09AE189s5pykSO7RpVvLQ5VsfOt2JIEyKUmz2FYH9DiqReg
	 Ic3AeAibP73JA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AMEMZUY030623;
	Sun, 22 Nov 2026 22:22:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:22:37 +0800 (CST)
X-Zmail-TransId: 2afc6b02faad7ef-373bc
X-Mailer: Zmail v1.0
Message-ID: <20261122222237542HTrb5XjZWwOHuyfeaimCs@zte.com.cn>
In-Reply-To: <20261120175207.GD1484@lst.de>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn,202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn,20261120175207.GD1484@lst.de
Date: Sun, 22 Nov 2026 22:22:37 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzVdIG52bWU6IGRlY29kZSB0aGUgRkRQIEdldCBGZWF0dXJlcyByZXN1bHQgYXMgYSBkd29yZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AMEMZUY030623
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 22 Nov 2026 22:22:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B02FAB4.001/4jXWW8432Xz5BNRx

Hi Christoph,

> With this struct nvme_fdp_config becomes unused, so we might as well
> drop it.

Dropped in v2; the FDPCFG_FDPE definition stays.

> Also can you look into the Sashiko found existing issue and fix it in
> a separate patch while you're at it?

I looked, and the buffer is initialized before hdr.sze is read.  hdr is a
stack object, so nvme_submit_sync_cmd() -> blk_rq_map_kern() takes the
bio_copy_kern() path: the pages come from
alloc_page(GFP_NOIO | __GFP_ZERO | gfp_mask), and
bio_copy_kern_endio_read() copies every bvec of the full length back into
hdr before the command returns.  A short transfer therefore leaves
zeroes, not stale stack.  There is nothing to fix, so no separate patch.

Thanks,
Shao

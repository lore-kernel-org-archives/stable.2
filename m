Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962490;
	b=aRDAHPoB6MYD3iJkTc6BiOBESzgSTXHEZpjm+htvGPWwKxpBjvrlqV2fulZqjgSbYhQ9
	 vm4gXPJJkvQ374/BLbeJUp1qIw/J9JwcshiOeW/LKqzxyYezlz4/VQ9okQijEVId7aJme
	 gAdF10OvLd0yqD0x3L9iflKQoXCCU3zJL5bI1lJcRk9vFmyfxIcTg90SJNP8vdZ5vK/B2
	 +WsZ8ozjr/Mrcahr5SxgRsUpADLyX177Db1qnqognLv2futKM9k4wppMyyG/mFMTZSJHG
	 lACwmknSElLCnOMVS2Bk7mmzJygQtIY2vSltdYrgHmz+lUbxP1ch5/p3v+jwm5xjHOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962490;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=tnKERn8kLNE/XYtMUrmwCSiXpsYUwB5jGNqoeDEI5WM=;
	b=hDUOYd385OjVLduzQM7m95RZbV6XljWyShcgskDCZotmAg1aUlDDlVY+AqYx2KpLMpyb
	 1r/6Uu8CZkRoeaCz1xDOm4aitPWKmu4FqoqrZI4qoCP75jNb9FZZ2gToMoKaXcfHdV+Yj
	 VlqAQ4/5u8gudGLINV7kPduRWpIYIEjsm6Mn+Jl0UHy/igx620e+waB7hy8nQ9kuRQa4J
	 QTVg+kgYaBZY53Arr9tXEqlewoG/vQ62gS8mfNFVgKwJPEiTy5zcwYc93r5/jCS/b5uyB
	 MLZQzlZam56cFoyW9P5R/bCMkbp2R3xU4GtrSVgXi+Gog1SW9AgXIirn/qXHzxhAabw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2041E606D81E;
	Fri,  6 Nov 2026 10:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2041E606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLbfb2KXdz5B12g;
	Fri, 06 Nov 2026 18:54:47 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A6AsYjS091147;
	Fri, 6 Nov 2026 18:54:34 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 18:54:37 +0800 (CST)
X-Zmail-TransId: 2afc6aedb1ede3e-55f15
X-Mailer: Zmail v1.0
Message-ID: <20261106185437430NmohowCOBUVnZF5l4dRE_@zte.com.cn>
In-Reply-To: <20261106103932.GA5633@lst.de>
References: 20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn,20261105215759419k4-bV6cgNlque5OLcc4E9@zte.com.cn,20261106103932.GA5633@lst.de
Date: Fri, 6 Nov 2026 18:54:37 +0800 (CST)
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
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIG52bWV0OiB6ZXJvIG91dCB1bnVzZWQgZGF0YSBvZiBmaXhlZC1zaXplIGxvZyBwYWdlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6AsYjS091147
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 18:54:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDB1F7.000/4jLbfb2KXdz5B12g

On Fri, Nov 06, 2026 at 11:39:32AM +0100, Christoph Hellwig wrote:
> Given none of these are in a fast path, should we simply zero the
> entire transfer length first?

Yes.  v2 does that: each handler zeroes the whole transfer length and
then copies the fixed structure over it, instead of zeroing the unused
tail afterwards.  The Error log zeroes first as well and clamps the ring
walk to the requested length.

> Also please cut down the commit messages a bit to be on-point.

I also cut both commit messages down; the long rationale is gone.

v2 follows.

Thanks,
Shao

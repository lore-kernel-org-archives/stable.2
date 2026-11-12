Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456779;
	b=OWHcX6uTYuuNcbqQhbGAhgFLlTVeHHsobTKwb+3EkNCYPeW2YalZhB4gwqTR9J2X0lpS
	 eK5rG+otJhpc2M8KAOzdLBgeQSwMK4PW950qWQ4lPceaQ5qbiBGdkHmSGsdL3La+6Y0Jn
	 wIy+g7iGo77fzT1HmLDOcb+KenQhO5reVuCoUY2ZZ+mOPs6NnCUsrYLCyVwHIRciSPD7W
	 2esxsmVhvIJ/P8qSA+TnUFmNXdcEszxj+qxef+7mwfknqesFLn7ztYyzLQgCKNz+SIoTp
	 8SgT6XPptr7hPVakcoNYGHm+A7AKX4JryUxQ3nqKKaNQNxERFg6dIFzl8Zy6S7lZKuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456779;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=cb5obflgdjLo8+XlhF7MpnjCCe8r/1kAHNWYSeIRm+Q=;
	b=cLf45fQPGNGwUjhCu5tl1fvm6zTgAZDNVMk811eOvlG9XswO1HQXSqgBEm12jYeVPfif
	 jZ1Z2GmJR04YAsFBzq1Q66q7GPXMWvjlAKAmNKVJakWvYTBWhALkEYZhtw6MheGDYNmPq
	 QCAozwNOzqG4mNb6+mD0kMgiYu1Ua5jMQiBze5t0X7lqUkbDpteU4Mj1OXiEiDkgbSp51
	 fN/FZbvoPV1GNgH9ckv2HTB+butFQvOuqjYJCYTqNKvW5kSXnR800bSGBGPYyjbXfVlkJ
	 QyxHN2zmIQfS0xqF6pueYffHcHYeLSWNYjP26GztXPBntGyciCU+8D4NhvdInPliuqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=tpMyBUOe;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29624606A323;
	Thu, 12 Nov 2026 04:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29624606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=tpMyBUOe
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQ6S765rLz8Xrr9;
	Thu, 12 Nov 2026 12:12:55 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794456775;
	bh=tlBiVJzWbGNGR99ZbsJuFMRnwt2+GmTnvfSshwizJCw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=tpMyBUOe+9HJE9nJm0FvBTNXHWbd1D4EzFntyaMAo0g5eNY6BYJpbuCrAORPg+NIV
	 GC3lrRVqr3+Lt6sCmwUb/KdfKhYDDHHpqDXwjiXxhTL9empzwKZnuSyDuVlZV6Arec
	 GTOv+pLz4quKOB4+oZe4En0kXLoqOPeFNUMf0UlkvNPy/hZzQTRlol9lseMgL7vD5x
	 vRHRKHxAbwrqNnr9NPzsvHoTJSqhUCdfoan0kcCJFTfOeSK4EUbcaLb9ViXhyP+KUV
	 juQW+O8yzSLPyBs8TQLLGhSwfb+SKgyXMUcbBVhajimNuUOzUzxuzveQwdsFxjY/Ju
	 N/yhvPVupElaw==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6AC4CmRu074280;
	Thu, 12 Nov 2026 12:12:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 12:12:49 +0800 (CST)
X-Zmail-TransId: 2afa6af53cc1a82-62570
X-Mailer: Zmail v1.0
Message-ID: <20261112121249497K1uXj4qW2lrd4ZbaTHDM-@zte.com.cn>
In-Reply-To: <20261111164311.GB18076@lst.de>
References: 20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn,20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn,20261111164311.GB18076@lst.de
Date: Thu, 12 Nov 2026 12:12:49 +0800 (CST)
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
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIG52bWV0OiB1c2Ugb3ZlcmZsb3ctc2FmZSByYW5nZSBjaGVja3MgaW4gdGhlIGZpbGUgYmFja2VuZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AC4CmRu074280
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 12:12:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF53CC7.000/4jQ6S765rLz8Xrr9

Hi Christoph,

Agreed.  I'll fold the open-coded check into nvmet_file_check_lba_range()
(a byte-length variant) so that pos64 stays local, and resend the series
as v2; 1/2 is unchanged and keeps your Reviewed-by.

Thanks,
Shao

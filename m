Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187049;
	b=Swwv1PGB0h0pBzlPgLARHpmcDes1XP3JcPN9ZqgQtB4fR5KApem5ryec56sIsuR6FCw0
	 nnO4/4Ql3OYePXhWpQFuqasAfw8SbyZUI/NG6KrDsACcSX8vlTUERuvh2Rb3haDvlshwd
	 bQaS6pqksw0wcW5LLNOxDXZhHdZVKMqhRlnyGbl10tfmzk5C7hwUbXZPWPCuvcKMqaRdI
	 wsL1u5XDzPh3d2ienPt5WfATOsBhVB+A9dH/afnm0HUoDgBu11VO34kaAeV84S33cnBa1
	 VjuqqEXSRMMMvO+7FufrlQEPBF9MBYBrF6uOMLKsfgM3aFKZufSo/QFqYqUebtW3GVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187049;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=qTsVWDFIN84DHt+aCPVV0qGJJbilxMxMCdLcxlnYey4=;
	b=O9Nm9U50K+5bnjs9NQF70tbTO5UyQMdbbDslBfdknmwF3zXXdt332KcKxsZ3IlCbRN/q
	 MYNTSsZvmhnRyFsP3VbLbP4Ck5x2N/Cwu3aK0kHey9pFk2RqQ5ViW9nStkmtniL3NKAMi
	 /xZAVk6lIufyoneZ0oM5RE3fFgIbMATf04PxZLRky2CJ96qhgD33+sY/9jtOeFQ85Eqfp
	 Ps6iHl5aK4RmlW5C8RA2bCFtJbTTnxMdOMp+y5uvBQYH2wbCGp4Vb2kzOOsOQ3C/OUxM9
	 uIRobc2x3I6DSR/hgnsQvzRzkiFP+7gWBX4zQ/m1XEvrIQ8qz3Xw4CJUS9M53zuTa4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=17SXczhd;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862A606A829;
	Fri, 20 Nov 2026 15:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9862A606A829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=17SXczhd
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1BEA4C6221F;
	Fri, 20 Nov 2026 15:04:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 58653601B9;
	Fri, 20 Nov 2026 15:04:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFB5A11BC02BF;
	Fri, 20 Nov 2026 16:03:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795187042; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qTsVWDFIN84DHt+aCPVV0qGJJbilxMxMCdLcxlnYey4=;
	b=17SXczhdsGQgnzYyaX+DdmSQiY9lY1lgd5mlOS8ckNA/+SdtTzJTUyIUZnJbb0LAvXITvX
	c7TvhPYX6GInBZflUf3B8+g3a0Tp6gxYnkWJkFRH8hZxTYkQdljFs8JFzNrD0HNyvbjOTI
	7IuvCOsy5/0Kqdnt0PXDHEFE0tZPF275pP82yLebkHbB1Hs6euMVj9aG0cVmsnjI8GbknV
	ytnxMwYduRaERuSQN2XNNO3r5CSbN80y//qYYEqs5avwFAb19loYMDvfyueT1qjDMCb46D
	aMqmkm2wbxYK1BmkCOTlyXtruFqG1ex/GyRacSsgEFz27RyLw83aV3IqUXQpnQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 wang wei <a929244872@163.com>, stable@vger.kernel.org
In-Reply-To: <20261108-submit-nandsim-overridesize-bound-v1-v1-1-9cde7657a69b@gmail.com>
References: <20261108-submit-nandsim-overridesize-bound-v1-v1-1-9cde7657a69b@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: nandsim: validate overridesize before
 shifting
Message-Id: <179518703904.3404688.2705223904736724197.b4-ty@bootlin.com>
Date: Fri, 20 Nov 2026 16:03:59 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 08 Nov 2026 14:01:38 -0700, James Hilliard wrote:
> The size overflow check shifts by overridesize before validating it, so
> values at least 64 already cause an invalid shift. Smaller values can
> pass that check but exceed the width of the later eraseblock-count shift.
> 
> Use check_shl_overflow() to calculate the unsigned eraseblock count and
> reject values that cannot be represented. Derive the byte size by
> multiplying the two 32-bit quantities in 64-bit arithmetic.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: nandsim: validate overridesize before shifting
      commit: 388cc8f9c51163e849ac9d749800e0435db76e51

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


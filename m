Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018063;
	b=YYgSfXuzL0p1vHc4jpzRzqpbl9W9gIAfVyz0IiBwca6AXTn9KpYloN5MYHT43nsELceq
	 yBj+jhUhvxyustBsj9T9/JRxfQZPsqnhQX4YSlfGsxfE2aBuQzj+gaA7xS6wtFbowWBHy
	 woHqUZNXHgre1nM1iGOPBDcPuLVwD9v6yQNDRBVAC86SYf5YAmvypBdF9QxjDbHimJov1
	 bUFeL+Q3OE57FRKG9WgsWdkPrScsis0Bsf/vs/xVG7gWcLNkdoEXzjX0Hqcgtc7QuxzuW
	 /BZ7PRUlJZ8l4Uliwd6Hbl20tpPXCf85+tMJb6HiVrt/HcQI1ZEg/GlNmIQxKcgnKrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=JmaZ/n9FsASCYINSVjYeJtINexMMe1X6XnCohCT4mSs=;
	b=O/kU6dkGMfpaagyfhorfqcXbPQ8lcvQj94jbzw07yeuB5BWQqTFWYMiWBp2Vrusptw9C
	 c8wPCHzOS4tD8yGZe+80ineuvPYrbkmLee0M708spYYzvafkGalTexq/yJGFFfsd5rwVn
	 P6q2znfFpYJPO5Y3twFoZFQB0G7M3h7c8j8dQX6r7j4XhnWCIbwft+32i5p0mLnrjpNDh
	 tGR8/7dL1HScdisip/1VLLB/k2jQnxKaEON7dsVW1+px3nLOKIbSy5pw8fhsg3kHPvrVh
	 cCHZ6TOsvtcZKfCXfz/Abmd+iYfeKBYR4c0hQEBmMSQ2IX4+rN/ZwOodqOBnaed/+2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YIGUfzF4;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE64F60A2623
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE64F60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YIGUfzF4
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-451a49abd8aso1040518fac.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018062; x=1795622862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JmaZ/n9FsASCYINSVjYeJtINexMMe1X6XnCohCT4mSs=;
        b=YIGUfzF4YnoSIglmvHhpupDq72wlS4QGZnvMOEHjBAiofpTfvXUr9l69ZgY5KW9v37
         BebnR6s4m+EJuuRwS1MIoehf1B1szHGaFvybAFk/6Y67mWgEwe8Z1j2yNgyUbPpmq+Qw
         uB0lALKqu0H19jXyksW90i8+XVHdbLYnn9AQZDE3vmQhy6Kw/Z7vihQ4fQ+RtCLB6QLX
         UQrpjYpz90AZg4LIeflbmQvQAZSJOpX9QQzrIdZqIUG1i1FQi2ajKubFOllnTD1ABKPl
         zzUfkW/UQPqAxI/BJnq/h/YKqJkem64f0sGOoXqJQohx4xM62iNWD+mdjup01f4EsJBZ
         0nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018062; x=1795622862;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JmaZ/n9FsASCYINSVjYeJtINexMMe1X6XnCohCT4mSs=;
        b=YkgefxGCTsrkk8XAmimFeaD5DtTBitTAnncDhkugU6ltNwTYWr1lhgaiJqPbfE1sOx
         lZfCnziKh8pviRXGbq7DYfCq98ge8LVB948yVlYnY+ZQMVqCgcBPoW+kMkhetBp3Y70u
         ZF+ECU3xQ/TRCbOtLzOgMmqLhwdPei+QSTuHSI/qHE8ePGU91jVgRESiAutQRbC/41mB
         ptK9GllchVNgvESnBxLt+p/QbdMdYg6TEAfi1RhLxlt5j0nRny06v8n64XjSpUBOWJXp
         tbkArfW1nt6MZHhSkqS0BUudZ6NUJQmRurMFceiL7MJD6gMN3rDW9ynfMbkdqdFFqllM
         rGuQ==
X-Forwarded-Encrypted: i=1; AL+hErGY4UzJJogWF4w8DzKmsKkjv8eglq/jpMqpGDHv0kteXmsyeBUG9oKZQ93TY4XeS+iW5YPIOrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z81EI4wq9O4jn+6Fhhvo0tIXNeAM0jIiCsbPN3eFZ4xSngvW8qT
	sFbQJUmPSeWs8K1gOv2GvS6n1Gws7bED5k6UE4QFHFy1FIhwi+cGIUDGvgZ5D28ygg+gqw+SJqm
	3PrV7AmI=
X-Gm-Gg: AYBFou0uB1GmsZnQrcnkle6jYGG/7E9E0OaP8Vv1DLFl/U7xw+fOf6V18iENLJiQUY1
	A1n2cafl7wMbPkWHFBH5ildCwhrVLZOgGFJMPgPF26xvIQQPMQoy8k/HczKiYH2J1Yuk0NbohYs
	qj/YGV/mHvy92LmmmjwMVRbiICgo05l0gl8GKqiVFAPJo4buBGdT/cl6r8aLb/51O/INWXF4sEK
	LtgjD+n1gaNlbhisyj60eY/hiejfu2Fx/5x8j/8j8Y140825B1o2iggQRNSAaO0xVfeNorbIZdf
	khs7p5inXcmpbjeE3t7luSxefrEB7+oeRCe1+YlNyzgeDvsI7dAQpcSF2ntKBP7j/WTIs2PXTW0
	bnYjA9n8GB8phXVKkvDOuJyCXDeA42LN0YP2DMah/mTffjgXPyBNVK28Rmfbh+R+ARqLXgijsP/
	Z5HiPh5XKSqxmbpLDc/yRlOwPX8fxNB5ERysy623vqZnwcCjld31Iqb8vKqVGt8M0Af/Yz4LZtM
	2WAqXJc8mxCcWxuDZyqa5SXeoPrmh9xo+TexFogXxyN0huig6FV/ylUEwXbXRqoDnD1i6f33Ezq
	RkgV2NDYQbVjFYpqIZxaY7Y13RCCg7sNwQWUw052J4AoW3DnJBI3quo8PCap1pfGrqBd/yobSdE
	gslGgwrG4hsJE2eD9Ltu54lbSsRGBNey7npK0DifhN+hOsBXiuL4=
X-Received: by 2002:a05:6808:2220:b0:4f6:a430:1822 with SMTP id 5614622812f47-5773c52fedamr3373325b6e.7.1795018061884;
        Wed, 18 Nov 2026 08:07:41 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261115003345297PJDJduSwIS5uDYxPFRxKJ@zte.com.cn>
References: <20261115003345297PJDJduSwIS5uDYxPFRxKJ@zte.com.cn>
Subject: Re: [PATCH] partitions: aix: validate the physical partition size
 exponent
Message-Id: <179501806057.17649.7759332240241480233.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:40 -0700
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 15 Nov 2026 00:33:45 +0800, shao.mingyin@zte.com.cn wrote:
> The physical partition size exponent is read as an unvalidated 16-bit
> value from the LVM record and used as the shift count of an int. Values
> of 32 or more cause an out-of-range shift and can produce an unrelated
> partition size. Exponents below SECTOR_SHIFT produce a zero sector count.
> 
> Reject sizes that cannot be represented by the parser's u32 byte count
> or do not cover a whole sector before doing the shift. Use an unsigned
> operand to express the representable byte count directly.
> 
> [...]

Applied, thanks!

[1/1] partitions: aix: validate the physical partition size exponent
      commit: 9ce4cf1ad3392b2945bf1d49f1fd305364020a1b

Best regards,
-- 
Jens Axboe




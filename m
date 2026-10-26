Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054553;
	b=Tvcrwbxr9RxHK7yD8t+nWaRXulGJCW7eYM0ba+M2XRh1XdJAMtazYwxg9XD8k8kQUyOf
	 mBQQx8ViNYpw8iM1BX0rbcgV3C+Chm+4qvutaujO8uIJJQWh/NQY6cYAvMXpo1P8XePl9
	 TX0XO8EnnxD2TWm+cwPNGyFU8iOpvdHRMwDI58pZOy74aCkI5Rku8+Fs1dsoc9X14bf5n
	 Z9O525lQxIDJZP0cz2N8WTDTW8omEnl1oCuFmsGwgqKTUg2KQBXGLQ0kG6S8HF/59X7aL
	 Cb6Se3vEaDpULZenhqvjqzR5cUcBhHJ0duTw4BaPJ/f7oIIPWopVLwbsaF+9j1pdahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=FA3eo9Ml5dMrUZqSyy99rnSaNT5Gvkpu1eGh6dR+CIA=;
	b=HRWsNkyBV2pQTcxpWpd1mTg9gee9ESSPPikKfWVhMWBjb/oB+LTs6ngGyBRdMp2f+l/W
	 HS/tjN7Mk9maIJ9AWeYVI9FZ6Wt21y4pOrvj+ofQXXLHb0UYgLepriRFgeWfiV4j9HjvW
	 9I43uSGHsd/UYfyYXRHTzEQkD9ShXzHSqbaznt1zpeSVFOLA500xECMGAEgSDACe0WS9t
	 KFrPy0Eum/x9QGlRRnmbZaP3DOew1/o5Et2x8r6ciHFBXp8A7JOFr9+MHZltbiwZG6/nD
	 qfbMf1TKdtT25UcbdUh13cOjeN85UAtO2QFv1PDLxyFiWWPQyK/FNk4me8yMwTFlQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pURyyqNk;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA97606A320
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA97606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pURyyqNk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so30274915e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793054551; x=1793659351; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FA3eo9Ml5dMrUZqSyy99rnSaNT5Gvkpu1eGh6dR+CIA=;
        b=pURyyqNkKDHarBqDoX2O5yAmjoxUoo0s3xrIN58Sa6ATNJ4JBBCpAogmB2eIbqm6zM
         2CXNvIxCfGpNzXlKJct6dBNsJbpDZOz1zvp41eNlNKEoeBMEzgN3aOvnC9slmy1QMJzs
         ZQdWZo0/soNsaplv7BjmwAFN0mA79rSbQkxcSyd+FXyOgrRMv9p7rTdwvTTv1nmbZyvG
         WVJ6Pri0pmz2rSGVJQIM6EswrqwqcVGzq2iYZJCTAVmWKCn9YsGaqgBvqD60gBR+Bjuq
         wCcXNIKlnNKSRG8MhECsh7kK8bgaJ/efa+EYMrEzzcVa4vbJiKPOsL6KjvygNmHDLNfF
         21KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054551; x=1793659351;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FA3eo9Ml5dMrUZqSyy99rnSaNT5Gvkpu1eGh6dR+CIA=;
        b=P+vzRcCPd/cJrzszePO1bnu3eTvMLEmJrYb73MPFdZcalrWc0cuxTkg8kv49bxj8Rz
         UbVUcZQFjM4DdKePVJzwVS73eYuaDZVnoKqdyFXE5efi1ny/1ZjwD1UQBFm+XFD9xO7T
         ZEbqyzP05acXuInpeSyxZXtzsnd2Jjy4PocWtnflQpRy2PCg3b+9cmgPE294uyuT7txL
         T34gtxQ5husnfPVNYgbV2z+avVhkEKLQETGQAvukq97qFpmh6hlZYoMk+gprI3NQA1nb
         rceR3BvDBax1g5S5pcy71wWmBfe5u00V+mDMNjcarg6Azfp1nd1ztTcNjKubbW6IRIkk
         +d4w==
X-Forwarded-Encrypted: i=1; AKwUvBwVMAKHMhiBIGgMKH6AO446GjZwq5X8PvIWme4TheSCZCtGTFkxSxb55tAJTpAXtvGP7HY8MYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3WEa6CqooFNrc9v/vrC9jgY+/4hyI2yi3jnNGUVScW8mrK8/N
	yZTVB32z/R6u84HqDchTcNU8lMLrIRU9LIudAGcg3vWI7aIycBS4yhK4
X-Gm-Gg: AYBFou0w/9KQtyyuMVhMQBK+cdJPmV9Ej1YaxbWVEFvm1gcM2LAmzB2PimoenIAGBcP
	dnEFitBiXG/Tjco9dVnTdX1YLRCIBncAMl14UUT8Cjq1dQtPLhFuXdx7FTNbm2eXfVN2eU9lVHg
	WxWbzelU4SAeluyscaudQ1UlM1S5lBPhX1b/wBVQNVyVF6u9WYv3jMb+jwgt4QeVEGqf6+nHzbj
	UoQhdof42cTwtGfvY2fQVlDeaWHdQuK+Q25oPrE13tl2XVCSrUV5NYRLiCgakvmZD4ZiGBMep7n
	hxPIfbMbfFIQOP/2a2p604JMoZ3UTVzUlFRC9fHn/7McoYyzOcTjT5OeCo2q4YZPyotPThW2oes
	XL86YU9QmQE1iat+436ZXEGxWE3XRK1uID4QV8QOKnitdaWWxJ2ZC1wsezlMBCa1lWBIokOwBS5
	NI44USthwICT4xHqpC5kjpXNblXaA2231urD7VgVyYGE/GZL99tWC8TiSSbV7Zdi/UYNJpMfJQx
	IZUlPwYeLlRYrV4UItm+NVkaooNTF5SzbZRbw7MS8SfeNussCELaABdpKwN8qDv/PM+bSP/S3UW
	Wj6rzPEs/eEUnm9iiZME
X-Received: by 2002:a05:600c:609a:b0:4a2:fd2:985d with SMTP id 5b1f17b1804b1-4a35ac95969mr132696405e9.12.1793054551580;
        Mon, 26 Oct 2026 15:42:31 -0700 (PDT)
Received: from localhost (bzq-79-181-189-120.red.bezeqint.net. [79.181.189.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bac37sm239054165e9.6.2026.10.26.15.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 15:42:31 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 00:42:29 +0200
Message-Id: <DMF4SGB80HC3.36K88VCSLPHHS@pve>
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
To: <netdev-bot+sinfo@kernel.org>
Cc: <netdev@vger.kernel.org>, <pavan.chebbi@broadcom.com>,
 <michael.chan@broadcom.com>, <kuba@kernel.org>, <edumazet@kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] tg3: Invert restart quirk logic to restrict SNP
 power-down bypass
X-Mailer: aerc 0.14.0
References: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
 <179305291274.3327.7897598693564915611@kernel.org>
In-Reply-To: <179305291274.3327.7897598693564915611@kernel.org>

On Tue Oct 27, 2026 at 12:15 AM IST,  wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
It's mentioned in the link to the mail discussion earlier, I had
discovered it on my own Dell PowerEdge T440 in production it caused a
reboot hang 100pc of the time due to the known AER issue that my model
wasn't listed in it's growing quirk table
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
Yes it was triggered the AER logs are identical to those in 2ca1c94ce0b6
Fatal AER event regarding ACPI _PTS and the main symptom is that iDRAC
regards this as fatal and hangs to restart until manually interrupted
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
This change was tested on said Dell PowerEdge T440 which shares the same
Dell Firmware as the R-series and has the same physical NIC mentioned in
all other relevant commits (BCM5720)
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


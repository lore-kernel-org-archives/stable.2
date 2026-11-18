Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018059;
	b=v9Agj7XuFcHSz1ppPGaRqEYlnJrulduy+u2qek28Jh7uz2sVE52xfQY+/z375lVR+6wx
	 blP7FeU98KDGU8qLmb+KDCYQtcRan1665MgQu/xf9cn9CF+3jZq7WuzBXY62KKyxYoKvd
	 2rvA27yuIRtibXA+UvWNycmErD7Crk/aZU5xmtLPSfYthV0GIFcN5SaatFmuhD3pzX4+U
	 asv/zOnxU30+y0rSZalQU/uVU1FiumQqqCslbukDfaOxLxml4VORN4WpIbMrsBfi9swGM
	 R20XpQVqH/riQrUeg1Hr86SKK0hRpimkKgUu43TkWjYvv3wP+mVmCfHz0TCqyC58AiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=CV7oamrSYXfpp3NnleoEpP5E6f5lbD9kU3nbbqKEnc8=;
	b=c7gqHTVGMzzuh9sq0dIL6+qao4UcxugdayUQb/A6+CKMKKLSJonBqfeHV4CGvtlbHOoa
	 yfDUUEi3UYeryZWA3AqEDxi9NzZb4H7t26Ot/KTAW5CeBf0sNAXcadxEutnxN8B5/3gx9
	 V9i9I0YnkyKjcDG6+z6fmNkVtDA8lrAtGwWwHY81sFzm/5Q6aTbqTe7Ych8cZvDf+R17/
	 xQUPuxZjUMxL9hsGzj8bInQalCugNh4zOTHOaoTzYPuWAx9wlTIDPGuq7osAs18wG8Fh6
	 A5efMrx6jkLmPkMeDwQXqTE8UHcfA7wPbvm2IbcFPI3PuIkZmncaJ4Q+ZEJpYWKaAIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a5rhgeb3;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFF606A332
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCBFF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a5rhgeb3
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-48ed0b68895so779925fac.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018057; x=1795622857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CV7oamrSYXfpp3NnleoEpP5E6f5lbD9kU3nbbqKEnc8=;
        b=a5rhgeb35b8T5xllNNAeAnECO5OGWZ6FRR7g3JBTBjO3p29UNlMA5n5uAkVzlQrWDb
         9X9tktBgkFW+N1AWN82LjGdQogSQ4C20Uq3ZqEfNc6b6QQnInosH7yAuraUEAckqLXRN
         H8QXC6YWgM0rKmm4+aQArZeRlYHi5A9ujcVq17/4jz1Po88aC8PZnbgZwqfdfkRwCDwC
         qIHH+l6buu7Fbly+5y4La0q2XL0yaSHrAlzPVTYXoW28SKbupT9CWG8AVuN6tBNNGPlM
         8hw0B9CbHIRCEOd4dlJM8dAk2Ph1GA2THTGe5CsJF+6hPmUpcm7u9I0yji42m2YfX3bz
         V/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018057; x=1795622857;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CV7oamrSYXfpp3NnleoEpP5E6f5lbD9kU3nbbqKEnc8=;
        b=nEa6+NEPE5JpkAEgZoj4rPjbicVkDaNKK3HdhzXbXYlraa6q/A3GAeaFfPiQ/UyJ8q
         KoJgREC6w2aawIx4DW0JMJ7jmL9e7cwdzFTdbAHyblVeY8insgbr1n7k2lHNcAxxq+e2
         sAp7dHVbVIhZLF1hNIr4qJIg3K3mCi5TUIEysyKMEutcCOX3ErPl37QFJSXzzNJ4RkRy
         e8hO27VvhSeay9Z17UrgV2vp2j7WABOjk3wUHa9n2nEiOrNrQ2hqWdGV8A/M6gK+uADm
         nODaQ8/orwtKFNsaFTFcpy5AxA0gVYr4xSsCZnnudBtxGGSutnWlwPNqcKWUZoIPbg7I
         OQLQ==
X-Forwarded-Encrypted: i=1; AL+hErEile/AdR/hiDtsUrYOO9AdXw20TfetM0niA1JuG1PE9zqjs61anQplr/bvtgXg9S67DJYqUMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vEf7YIFXCaNzwa4eehni0SANvXt2Q1mP+rTdfecZmKU6zHaW/
	da6s2wcj3WheTY22VE/UDMt4h7DF1E1M2viEhklMq9souesPPuN28Y+bhVy8GAysItY=
X-Gm-Gg: AYBFou1mOkiDPTrqk9CDVaoA/Apew0QiDyzrXUGS/P+eHIT/wppqw8XqOwFwaGf6IYb
	CdbIMzV7dRP+Bkm1e7Tqrv7VUoBgdDqFyNq2CowC9pjCTb1hPsIGcQc61NruifTuxrF8HpAWJUl
	HbzqClHK54cLPpmsMa/kqLCtrWPctFef4LWdKAZX9waZWAu0A64zh37pzQGrtlzeE7c7B1hn7zk
	l02bJedV9/If+g1FwYhXWCTXCCiRPafJFYQcAbpDfbeDZt+9XvVQlp8wva9Af1Kxm5s1C1dFEdU
	X+ZS6L2kT94/6yH70br13W3j9Q6N5Bc7Y7YNS3z45BJGsSnkQY1UCqCwdH8VnB5mMDfuG1jBWxJ
	OMlEZkq1KZH3jGHWWZDR+Faii6gQs55ZCbyPiDX8ihGpa+JcrbkUpBGBmAuR4VRv1mw8b0fAcTJ
	3PIy5/JlzmdjXrpZd9Ez+n4aDHC8SbsUAvcMwTf5orTmRpss4d9zJhU5Q6V/3IoKhjq6G+VBTpr
	ZPtUOzlwfMQiHmpOBYFRrG4/Lmx0byeAGRsYEuJS466JKujenNNq/TCXAd04aNPzDZ2gbXHZe8c
	kJSGwo0YwR9AqFgc/LubxE0kkPHcoUtTx35o4vEb5EKi8UnUNmK2WYnd5JLj9x2Us9I9LoH2LEo
	xeI83SSiGhihD5iXF39xdr6ksTcFZ6Mp2uVpaR/Hx2GbMBhgVH78=
X-Received: by 2002:a05:6870:d285:b0:4ad:5a7a:f7e9 with SMTP id 586e51a60fabf-4b7613c52femr2613744fac.34.1795018057354;
        Wed, 18 Nov 2026 08:07:37 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20261115-blk-throttle-wunsequenced-v2-1-1d297c891b82@kernel.org>
References: <20261115-blk-throttle-wunsequenced-v2-1-1d297c891b82@kernel.org>
Subject: Re: [PATCH v2] blk-throttle: Avoid unsequenced accesses to jiffies
 in throtl_schedule_pending_timer()
Message-Id: <179501805630.17649.245726738544852847.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:36 -0700
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


On Sun, 15 Nov 2026 20:37:57 -0700, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], two instances appear in
> throtl_schedule_pending_timer(), which can break the build with
> CONFIG_WERROR=y / W=e:
> 
>   block/blk-throttle.c:469:25: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>     469 |                    expires - jiffies, jiffies);
>         |                              ~~~~~~~  ^
>   block/blk-throttle.c:469:25: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>     469 |                    expires - jiffies, jiffies);
>         |                              ~~~~~~~  ^
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: Avoid unsequenced accesses to jiffies in throtl_schedule_pending_timer()
      commit: ae1171f38098098e88c13c38e462d27babb50038

Best regards,
-- 
Jens Axboe




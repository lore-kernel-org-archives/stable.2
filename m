Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107602;
	b=Hm0Q3q3rvWfctQ8Ui/bwXIpIbSDGhqNQ1hZrDlo/dPiK4S7lXJHhKMC3uGVoy5Sb97qx
	 3dZMPVEaKg92a/t1MjELDe4NeN+ELqHRmziCQ+4ITU9z37YPSaOpONvVNcIvm0VN2xM6e
	 fvqAEmBwj1vkNIpW02DxhOBAL65pTbKwvU4esM3VyDkNIMQ8jvoKG2ROpA4RwEIx9Y6fz
	 ZoNhfCXdAAbd7JbOU99MBclpiP+ncdlFVL/1+V74FCZCmps/vBV9v04Z+tMcqzCrBMsWO
	 fWsYLDcBXwBzJCpgEm6y41DiQp3ZoN1DAa05shbJH5eXqblaa9qYQsRmoMt06/P2Jgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UaQii/2KLE61POICHXTv/XcYptcQvuPmNYxjzl0fZKI=;
	b=RjH47WyWZ+YsRcsW+WAl4AwlIlDX75fqZZO4HqqDUhj7ofewK4D+nQYmb3YObt43qs8o
	 DTWNdh3eFG7ZHwfVQKZZlecBk/4S6AEbJ2jBMINhWRt3KMzuLglFH6SDPXlmC/pcsL/03
	 W/ci3+fHqeT2bJ2KVlUvixql3l9C/qFQ3M84iFVX+/7vp7O2CoaSBYfsM6XCmQirXfPX5
	 N5z0EOrv5nQM7z9OzFOGweCiIc14RV1bsL1iGwPfODtvk8RGa0n4B/zUQDhL3W8TUyhTC
	 yuWPFBqP/4JliyNqLjgHuMx9PHOeuZxdAFOF6oeANrSDtzsY3KP/iws2V/zXZHUC0VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OK9TotMC;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51516606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51516606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OK9TotMC
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14f0e9c6543so100847c88.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793107601; x=1793712401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UaQii/2KLE61POICHXTv/XcYptcQvuPmNYxjzl0fZKI=;
        b=OK9TotMCE05Hedid5XG0LVl7FLYqe8ZH8kprcIB7UdfEYJGARO7MopLEC7hlhuiUfd
         0d6/N8qFuGmAzBQRrKU/QKdtNKmfzLWoc7TOJ1fWJbsHwMcE02GuvHGkgRs+tvs2LhAK
         Hkrscyu0EGwegZHJhqwGb5RZn3lLam/DERk2NF4dffTs1dBg9gA9oh6rd93RghAtjSv+
         /Cks4H01uITera+4iEjCUQJF0lp+IW9yYuPyVdLYFpY2B2Kb8yvkVPUvXjgfgjIobD2e
         7D87S+QCzblGbPBx3qiGf49thDvLaKhj2MfyrFjcWsPwMUaJYG+nSaS3Y1zV3APa0dHQ
         QsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793107601; x=1793712401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UaQii/2KLE61POICHXTv/XcYptcQvuPmNYxjzl0fZKI=;
        b=0PGmjf+4xNQ624DdEV/TCOHaTLCJoD2shsOsxm4ncuim5ab3BISiQ6L7Qp9iaWG7mv
         9OV5nr8phUqPOYtxDEcpjvOdtmspdOSk5O3fE1Az7jespyLIZ/O4tnZhbFN9ZCYBRaQW
         EivB6OI06C/KKGvZMdU+zOKHUR7+3xEVVg4QqiU3cP1twxnwRJxEP0yzjMgF24HEilOy
         RqasQcc0h5vBFNlcUTsJKaZim63rGmqyQ6NCDM2yZHSioqn+adYRxSbBsZAVC6FuvsZ6
         vIAiHT1yyu+6sYMydLpoetFnSEP49APnhCl+GnP6qiiAGEfNucjugK3INP8bRbcmsrAQ
         GQmA==
X-Forwarded-Encrypted: i=1; AKwUvBx9yZfo5+Iiyds/b7FQHPxGq7LVHs7eryR1JKgih6HqD9nGj/B7rHEQ6PtPzIPjrf0lCOymRlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxnH/R+k+O74wVY0ysZ9y1gS0GnZeJRaRl0j1Zyg90zXymvTBi
	8mec8rr8nQTUqNrcS1pyjDvS/VUMJ62MzhlI1dcio5EmgjVyuvKtS5lq
X-Gm-Gg: AYBFou1UvTzELJkc4jlyPpKkieTdksnsi/1cxPhjp9yFDDXMd3Qt6rSHXfuLdiV/yZV
	yd6YP+ye5k+IRB84KbSnaMeY4alWAIdE9Gd5P0tZ5Xekz8JWjTx1TzCYOTPplQ9fzmBdu0lOOXo
	y6ESLJ1ar8KlBMR6Dtf+XTMxg0AnCw0oliGOZYBu9TUkQe5gyhpb8Md1ibusqdHZsYtNAVSe9xl
	yhxwIDeZxL3AvRJlrT+/A8RyRCDKdfFFCj9t8az5TIvY1QeqykmatuuY54Q0nPzE6wuoxZZHPjM
	qVy2GpTbH+daaAbmoVAhm0MHeYlcw41bRgSoncR7zrXEP0M95hHNCvmQcKuCNjGFK96tSfIHx3I
	+Vcm1ign1/T4242OxgrdpoaqMEqSkWcSpViCa3vnn0Zwj0uMDLOrCoR1yuX8bZOmSB0ZWc0XDez
	kSQeCFM2p/xflD9quzh9CExmtiN4DWC0GqbszH9hvFO+mdkCgoq5HqJfSeWMYfLEeTbMqVk2g9D
	VSB0ekeAZga6j9j2kFadVWtZDDlnSEN/Kob4rkYrJM4LJOMv1H6pSHC+G43clKT62myws7hJffS
	R67gH6+Ue60Xh2uBAS5rrn23IQhkQt0/EooMVQAuC/hS2sFucqhIoRkYj77CE4IAvGUnIKAwUyY
	DRdgFjEyoQr6lRnAIfhX48hemqJceL3H7ydT7czqhuBm0Jw==
X-Received: by 2002:a05:7022:264b:b0:165:be2f:c56e with SMTP id a92af1059eb24-199376df85bmr20204030c88.2.1793107601105;
        Tue, 27 Oct 2026 06:26:41 -0700 (PDT)
Received: from esteban.tail1178e6.ts.net (132.20.31.150.dy.iij4u.or.jp. [150.31.20.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm30235977c88.8.2026.10.27.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:26:40 -0700 (PDT)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: dmanresa@gmail.com
Cc: linux-media@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	djrscally@gmail.com,
	dan.scally@ideasonboard.com,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/7] media: i2c: ov7251: Fix link frequency index
Date: Tue, 27 Oct 2026 22:26:37 +0900
Message-ID: <20261027132637.540222-1-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
References: <20261026111032.88355-1-antoine.pichot@gmail.com> <20261026111032.88355-2-antoine.pichot@gmail.com> <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Tue, Oct 27, 2026 at 03:26:45AM -0700, D. Manresa wrote:
> Applying the patch makes this machine worse, though, and since it carries
> Cc: stable I think that is worth resolving before it goes in.

Agreed, and thank you for the measurements.

The patch selects the 319.2 MHz PLL table, which the index bug has kept
unused on IPU machines since it was added in 2022. That table runs the
PLL oscillator (the VCO of figure 2-12 in the OV7251 datasheet, rev
2.12) out of range: it multiplies before it divides, so the oscillator
sits at 19.2 x 133 = 2553.6 MHz before the divide by 4 brings it down
to 638.4 MHz, and table 2-11 allows 300 to 800 MHz. The 240 MHz table
divides by 3 first and stays at 480 MHz. The datasheet is public at
https://dlscorp.com/wp-content/uploads/2019/02/ov7750_ov7251_csp3_rev1f_ds_2.12.pdf

The Windows driver on the Surface Book 2 uses both orders. Its Windows
Hello mode divides by 4 first, which keeps the oscillator at 638.4 MHz
for the same 638.4 Mbps, and writes 0x1f to 0x4837, the MIPI pixel
clock period register. Its two 640x480 modes keep the mainline order,
with the MIPI divider at 0x01 and 0x4837 at 0x19.

On my Surface Book 2 (IPU3, kernel 7.2) I ran three 150-frame captures
at 30 fps with each of these, the last four with the series applied:

  the 240 MHz table (unpatched)
  the mainline 319.2 MHz table
  the Windows Hello divider order
  the Windows Hello divider order + 0x4837 = 0x1f
  the mainline table + mipi_div = 0x01 (what you tried)

All gave 0 dropped buffers and 0 CSI-2 error lines, so the divider swap
is only a hypothesis for your machine.

> One hypothesis tried and failed, so you do not repeat it: the out-of-tree
> Surface driver notes that the vendor runs the 319.2 MHz PLL with the MIPI
> divider at 0x01 rather than 0x05. Building this patch with mipi_div
> changed to 0x01 in the 19_2_mhz_319_2_mhz entry was worse, not better --
> 3 frames in about four minutes. So the divider alone is not the missing
> piece. The vendor path also uses VTS 522, which I did not try.

The datasheet decodes both as "divide by 1" (0x30b5[2:0]: 2 is /2, 4 is
/4, anything else /1). A frame length (VTS) of 522 belongs to the
Windows driver's 640x480 modes at about 99 fps, so it is no alternative
at 30 fps.

> So either ipu-bridge's advertised link frequency is wrong for this SKU,
> or mainline's 319.2 MHz PLL entry needs more than the index fix to be
> usable. I have the machine for a few more days and can run whatever would
> help decide which.

Could you please try the two patches below, the first alone and then
both, with your 150-frame measurement? They are on
https://github.com/antoine79/surface-ir-camera/tree/test/pll1-vco under
kernel/patches-test/, for git am on top of 1/7.

The first swaps the two dividers of the 319.2 MHz table:

  -  .pre_div = 0x01,
  +  .pre_div = 0x04,
     .mult = 0x85,
  -  .div = 0x04,
  +  .div = 0x01,

The second also writes 0x1f instead of 0x19 to 0x4837 in the three mode
tables.

If the swap helps, v2 puts the PLL table fix before the index fix, both
Cc: stable. If it does not, the question moves to the Pro 7+ receiver:
ipu-bridge asks for 319.2 MHz on both machines, and the Windows driver
programs 638.4 Mbps on the Book 2. Your unpatched numbers point the same
way: at 480 Mbps, three runs logged thousands of error lines and your
568-frame run logged none, with the same timing per line. Could you
please also run 2/7 without 1/7 at 60 and 90 fps? That shows whether the
error count follows the number of frame starts.

After 1/7, pixel_rate reads 63840000, but the pixel array runs at 48 MHz
whatever the link frequency; v2 fixes that in a separate patch. My
319.2 MHz captures above ran at 30.0 fps, which is 48e6 / (928 pixels
per line x 1724 lines); 63.84 MHz would give 39.9 fps. 63.84 MHz is the
CSI-2 bus rate, not what V4L2_CID_PIXEL_RATE reports
(Documentation/driver-api/media/tx-rx.rst).

Thanks,
Antoine

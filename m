Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D345471257
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662694; cv=none; b=TzR8uWFB2n9QbySn8u1dpN9c+In3tXJRkSC0OoWeedeq8Hkb7/CNTPJtvnS5Q+SEZJKvlWxrY6j5/8ZuNhoI1ow5Zcr6D2D9cmbp854RzHWAw8DJYojV0/+RfnQ24/bc91w7jt/qat+6qqJ0SV3WQzXsnDoPSUvBhNNJRYb2lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662694; c=relaxed/simple;
	bh=6M8b1p+ST8nuue596dbyURkJ4CV4UWHAuUCuKNISn4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQtx04zCH/QwPE7EuSSpG3Y7PEhRMhYV2ZZCMmgshQOrCmyhxN2yUOwqshWMbCGovzJimZ2Yx2zSsRbejDITuDAJPWsgPmQ78Cev8r8d+6t2bHmLanHFUOdghFVCkz51rPfYL4NP6icOKZzlmmdIkppHlI8x4fjU4Rx355Cf/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzVsGWO1; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzVsGWO1"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bfc54558d5so4311393e0c.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784662686; x=1785267486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6M8b1p+ST8nuue596dbyURkJ4CV4UWHAuUCuKNISn4g=;
        b=LzVsGWO1uYPOH5XFei40fhfNGqSyTygvSSkwmCTwG5Jp4+dziDDSvOO8Og0qigp99c
         1xq1GbouPFijgUNwH07CVCiJS4U28gwGsUb8RPVa1rg3fqhCJqIvOFXl5et8ZP+1Zatw
         bVFGkP2zz7g4qffmsmzsKBgFBF9jJ16a2rysHV+sbBjZR3EN0H/M4L/nzQzvkCltO2k6
         zQWeiA0t1/WXNuwNhtNC7LzZ6K8ZO8ReSksMbs4T/3F/YQrzIcswaECcSpFVYLAFhllW
         k+vGTcGg0kuEA4hu0OLzXNxuDvKyllKU7Gu6sTqogu4HWSPmoanthq1UhAxKNzJKNd9u
         g32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662686; x=1785267486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6M8b1p+ST8nuue596dbyURkJ4CV4UWHAuUCuKNISn4g=;
        b=joYZY2mEBfa6WLR1kjNdAkv/ZoLBr2vymDLXOfu1/ieMsCGuBPb0gtjyQqDO9EVCrP
         WbOS0+0HvNOvQY/sCLgNwApGJxJTD0uy9JEPwdv1pAIwqKS8qR9/CCbJlsGHc7KsaYQe
         Fkq+QGgxdALIULcI3PXk+KKz2tBwXNAOTWzmKSfDBnixLtYfNfvrJ0UPGUNpJR5B31JR
         fGwyY3kE8/l/9whw9kixEI6nt3PcX3VaM6fDe6/nyyBcPE6QlIaC+jQCaRXDaNITdkI2
         b6K+jQBats0GB+9ccLORviO6xoTsS0ukxa0f2UZc8KbwAWDNzI9aexz/bfetodwlY8my
         qtfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgbjB9QPRsCo1vWmfNPCwwhzK3HLM2FMI0Yq+Jn79gMnVIkzFBMhha6yOJd8qtLF5s7OFKtOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wQvpYwrZpLTyktfofRwKW9q9pRIJ5LZB274ZO2kNmgMrsSvB
	74USfxv12Jhkw5RWSTzDXynScZwfoEI7Ww37OtrOIfNU5T/tRtLB+nk=
X-Gm-Gg: AR+sD13ngbAf9EP/jQkCJMyxewzuCkyPlKciSic3R/MjEYLMyfsyOmpkkAC8WBgpFxA
	eSUTz7Qf5p3GETKZX2FPx4fgER9jXEzlH8tQtufb7KDE5KKWvi8wMLTg9B0CejKbHhYsfoGV0rM
	KD/W0hseP9Zab4vck0LMhLWuTSR4Ov3ycxjgSEMrb/9QhGjGq3FTVjy/KJTrrTdYGRqLcY4FTz6
	R0eXxeOJhgwiT4gIs2KjRP1SnsEMiYEHEgOpWdBSd9/bu+EhWzhMJTwd1EZxDnQB85CZS7+KGXZ
	luDjCFNicC6KvemcyRCsFXWNfO2OJM+DJHGxWbQYBpiD/tf2KpBvLWBfxrj7cn85WN9hy+p1M6/
	BFdB2tIqht7Mv9Bf+U9nbYCxQmgkbfYLwn4Qlr92JNldHoQNRRcn8EBhByoH920m+/Cy/6HJTtY
	ybv4NNig/xMehkn4jY+sNKh+pA/NQvmg7jtmqDsTbr8afmiQqjKQ+1Z7s=
X-Received: by 2002:a05:6122:414d:b0:5bf:6d5c:8cfb with SMTP id 71dfb90a1353d-5c2c3be4ef1mr561179e0c.6.1784662685993;
        Tue, 21 Jul 2026 12:38:05 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c2c648944esm390996e0c.10.2026.07.21.12.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:38:05 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	hvilleneuve@dimonoff.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	m.felsch@pengutronix.de,
	rwilbur633@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250: clear a stuck RX-timeout interrupt with an empty FIFO
Date: Tue, 21 Jul 2026 16:37:51 -0300
Message-Id: <20260721193751.22760-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c8a74142-5704-5ad3-3504-946bf3496cfc@linux.intel.com>
References: <c8a74142-5704-5ad3-3504-946bf3496cfc@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I suspect Andy meant you should put this into hw specific file into a
> hw-specific handle_irq. That could be setup in 8250_of.c, it already
> seems to do something like that for some specific type.

Thanks. I'll move the fix out of 8250_port.c into a PORT_LPC3220
handle_irq, wired up in 8250_of.c the same way fsl8250_handle_irq is,
with the handler logic following dw8250_handle_irq's empty-FIFO
RX-timeout read.

> (8250_dw include check for LSR_BI bit and this one doesn't seem
> include that bit, not sure if that's an oversight or intentional
> difference [...])

The missing LSR_BI check was an oversight, I'll gate on
!(LSR & (UART_LSR_DR | UART_LSR_BI)) to match dw.

> So 3rd alternative would be to add e.g. UART_BUG_SPURIOUSRXTO but again
> there are the per driver variations. [...] definitely cleaner approach
> than copy-pasting this code around.

I'll go with the per device handler over the UART_BUG_SPURIOUSRXTO
callback because I can only test LPC32xx and I'm not comfortable touching
drivers I can't explicitly test against.

Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEC39FCD8
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959091; cv=none; b=fpOmrzoJQxvzTwzq9OJmwJO6fCgaeEyTllPaBJb3GwTYkaZNrDjHRvof5sHepgXhM7xjViwSSUw8VJJ0l2RbB9dFIkc3WVzyjdEow0M1VJZF2iY4cBYP7Q3+stelvzxfjJOgMMc7rXMj3/TfHY3qUEtF+5VdwfgLyv9zw2QZxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959091; c=relaxed/simple;
	bh=nJ+QZDsE+bh8f+mn2u8v660wXJGAZHXVGBjCbEvjcd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMOR41rf8M9+I55pksf+yJyfP1AZqi0UDJIksll3Twy5BcA/6OXXaIZGjlhqTg3XfaoVTZvMvZsjVFRfHe/BbUwUbE2p85mA7WPoZSgLL7cmTEr6YGAcCSAFgDMvRlxcRh5jjltLPIbAsCDXJFoObRie1bpc/cFhP8+z8FUD8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHrWEOk7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHrWEOk7"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4798bea72f9so998131f8f.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 16:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787959087; x=1788563887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbNXNUsbJJs3dF/DfgTaL47t7uOjQRpSFIW3utnz9Kk=;
        b=GHrWEOk7ctL4HamGcpdMAZq9KaNIc92oR+7AGOmcDU7fAmIyo8qRhckL7x4zl+0WsZ
         S/E8vKfbH8FDNf4lVlZUahLBLO/GjNz/X+LvgCNv6EhACNpz2gb7KMPRNRBW3BOF91Sf
         UWncJfuB1dhQbhkmuPYrMiExlNOSlR5KGaob2T+0VKRzabC2p9X5M6moaxnvKxEyqLOi
         xAE0pvmggC1tuoqHWCEG1OG5lOd1xBrmS2Xf7pxNoicN/ggjin9oRVokh7ZU5xK+3hzz
         hp26cBcwntmyTbPX1CMcy/YdDvz+34G7Kgv8CxNrt9S16PfrnfRo8Uu64r+EwPriHWV6
         IysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787959087; x=1788563887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbNXNUsbJJs3dF/DfgTaL47t7uOjQRpSFIW3utnz9Kk=;
        b=FmJkpzFN8/+mJgME0eNmOa+QnB3FY7h4UXb4XiHRO7SgjgPRnCuyseLemFBRIc7A9G
         CmBZsfj8P0NsTOCwlDLcj955ew95x4Uzjwm/sydrwlFhJpAsu9To6m9VCRZbgWOt2pmQ
         +qQyeHy/Mz/8b5S5R9B1dHr9CHeZ5r8/A3xq4YxVxc5dl6O05TH4JdJTbGqKlgCuHh1E
         S5LZYssYef6V0A8tRwn2ff4pOhKTeFX9LanSyPteMRIJcPZJ+lEJXM1oF6BaXwI3kjfu
         U31KTuAaqaaK9w4sXPiQ1+vWIpt3pfxwYvcsT30MfTJkzE/FQqAWy+5Pz57fdAAXK27R
         +IEw==
X-Forwarded-Encrypted: i=1; AHgh+RqvArb43o4TXo6Srj4Xj+3at4ToXntYOyfag9rwuk7gr1J4n+zaVLYymeQf5oOqISLTfiV5MSk=@vger.kernel.org
X-Gm-Message-State: AFuF++n6/KSVKY8+qlpkRDjaoz3oOHHOYwmQa5VvVYKaYYYeJloSuv68
	jJKNkIkv/Io/ygNr0/tiv7kmtVPg6zp2TTZrwKu6sL96l8frOjdl7GU=
X-Gm-Gg: AR+sD10nWsWE+84Br2p5Xuj94G8fvcVwrI+Fd3iiL9k1VZOdRwI1v4EwOWFyPoKAW+0
	jLN6vlCumc5saIt7yh9ZcOX/0JghHs6LnaxsUBI7a6yp3sdIsNtZYn3M6PFCeBRdVmYuTw9bF8h
	0KqbK8bYWjQ27+fOY0OLZsItJPsC6ogTluOYpKteu8s6xavlFfOZQK1HOmNKAexZYfq3pTTIkHl
	LkXM+HqqPJms4mnuR3Ayje/iAfblhhDCbo0jlqOjaDrZDW6iVWG8dyZwiRMqr1dP3yLzqx6PcZ2
	1LQQbfs8tqsVF3EIdhbsmoid2trGqKo1Nq2IoJJTfBWGbJdSb3V4J7761MJee6m/9mNFIqmG+f4
	dV/on4Vx1tynQO56tgDDM8jIef2HBqTK1deUpYrMeOB97Dk027othIgI2Lr+w9a0uom+EZ2euAf
	WdEvVXovHGAnviE/qhhKd0Y9cpa+2kJK+Pquz9tx6U27hMEPgoWv0FMcWdcVhzzXbYJDwofW8UB
	2osBO66UOF4
X-Received: by 2002:a05:600c:620e:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49cc0d4545emr77747415e9.14.1787959087181;
        Fri, 28 Aug 2026 16:18:07 -0700 (PDT)
Received: from surface.. ([217.61.227.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a8e0657sm54933605e9.13.2026.08.28.16.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 16:18:06 -0700 (PDT)
From: "D. Manresa" <dmanresa@gmail.com>
To: Jakob Berg Jespersen <dev@berg.pm>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@bootlin.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Fernando Rimoli <fernandorimoli11@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: ov5693: fix horizontal flip polarity and Bayer phase
Date: Sat, 29 Aug 2026 01:18:05 +0200
Message-ID: <20260828231805.29790-1-dmanresa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729-sp7plus-ov-flips-v2-2-91884b81a8f5@berg.pm>
References: <20260729-sp7plus-ov-flips-v2-0-91884b81a8f5@berg.pm> <20260729-sp7plus-ov-flips-v2-2-91884b81a8f5@berg.pm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026, Jakob Berg Jespersen wrote:
> The sensor's native readout is horizontally mirrored and the FORMAT2
> FLIP_HORZ bits (reg 0x3821) un-mirror it; the init table sets them by
> default (0x3821 = 0x1e). The driver sets those bits for V4L2_CID_HFLIP=1,
> so the control is inverted: HFLIP=1 yields the un-mirrored image and
> HFLIP=0 the mirrored one. Invert the polarity so HFLIP=0 yields the
> unflipped image.

Tested on the front camera of a Surface Pro 7+ (OV5693 behind an IPU6,
patch applied on v6.19 sources, loaded on a linux-surface 6.19.8 kernel),
Bayer phases read from raw 2592x1944 captures. Partial results - the
polarity fix checks out, the 0x3810 compensation appears to sit on the
wrong flip state on my unit:

1) The polarity inversion is correct. Independent confirmation: the
   register tables inside the vendor Windows driver (ov5693.sys from the
   Surface MSI) keep the 0x3821 FLIP_HORZ bits set in every mode
   (0x3821 = 0x1e/0x1f), and Windows delivers the un-mirrored image; with
   your patch HFLIP=0 keeps them set, as the init table intends. HFLIP
   also toggles the mirror geometry correctly in both directions here.

2) The 0x3810 write does what the commit message says in the relative
   sense: the two flip states come out with the SAME Bayer phase, so
   toggling HFLIP no longer changes the colours.

3) However, on my unit BOTH states then decode as GBRG, one column off the
   reported SBGGR10. I measured the four register combinations
   independently (phase identified from raw frames by green-pair
   statistics and confirmed by demosaicing a known-colour scene under each
   hypothesis):

     FLIP_HORZ bits set     + 0x3810=0  (your HFLIP=0):  GBRG
     FLIP_HORZ bits cleared + 0x3810=1  (your HFLIP=1):  GBRG
     FLIP_HORZ bits cleared + 0x3810=0:                  BGGR (clean)
     FLIP_HORZ bits set     + 0x3810=1:                  does not stream

   i.e. here it is the un-mirrored readout (bits set) that carries the
   one-column phase shift, and the mirrored readout that is SBGGR-clean -
   the opposite of what the patch compensates. The last row is why the
   compensation cannot simply be moved to the other state: with the
   FLIP_HORZ bits set the sensor refuses to stream with a one-column
   window offset (perpetual "Frame sync error" on the IPU6 CSI-2
   receiver, reproduced across repeated attempts); shifting the crop
   window by one column instead should work, but I have not tested that.

4) For completeness: in the 2x2-binned readout the Surface uses for
   video (a downstream patch of mine, not in mainline), the mirror does
   not move the Bayer phase at all - same behaviour I measured on the
   OV8865 - so there the 0x3810 parity must stay constant across flip
   states.

Since you and Fernando verified colours correct in both flip states on
your units, and point 3 is exactly the opposite assignment, maybe the
two of us are not decoding the same thing - or the modules differ. Could
you double-check the absolute phase at HFLIP=0 on your unit from a raw
capture of a known-colour scene (not through an ISP that may be
auto-correcting, and not with the sensor's test pattern - on my unit the
colour-bar generator is inserted after the flip/window stage and shows
the same order and phase in every flip state, so it cannot see this)?

Happy to test a v3. For patch 1/2 of this series everything checks out
on my unit; sent a Tested-by there separately.

D. Manresa <dmanresa@gmail.com>

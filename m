Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370390;
	b=WVbU1qZDSmqwcK01e7+jjJZpp5c07XVbuV46TGfwgOaMt6VJ671rLrEtxlNPGANZH1Vc
	 Gr6EFXMUS77wDPXREfjFHepd60RicgQgIjqxvcf2u9j1gGvxtXovbuln/yBlpK/+0KCFJ
	 XR5fC/T9C78u4JqOTOONLImNXGXQkxnI3ULCDd4GjnbHg1vJHpu6i3cFvASuA1m29VC+c
	 zeb0GBCjtwiPxFi/q3VkY7z1NQnOcWv6rKubYBvXDGaIEkLk13Ipskl57ADC21GI45qfI
	 SHYgxKZ82a0lJFsNeK5xeK4H3vMPbD21LeI2oUnRZ+EBSdBfRbnOeNotdZHT2WWgwAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sAoD4mQFdz5KOYnm3Mb3Er1f5ViHeAPHJb+fiv/iKuU=;
	b=bldqFq6CJW9yWqVIwlFwI2eRLavJsdtt3y471bdWTxgRzL5Y2ws2anKqruwFmSDJRumR
	 T06cREX8kU7t6kATSgWh1Whe3n8RrdZiGElXkVyWnTbXGjdgUnkyIAXtAywCYXGRx2BwT
	 xt5JHWy61u/djeKPTmaCoElN1U6+ar/IAoAA1Q3gwL8PPKcrLu4inQH4RISJxfpOlUfhm
	 tbY7M3KIM9UTNtIBH8Qp3lnC/MFl9F0t74L+AxNh2pubZPL5gul7Nr9GQxxbJpqe8B6PI
	 leOgLi49auOaRY0z+JaJ/qlkRP/tt3qF0OZWsZ6oPLed6A4AkNso/LfrPhSUJrbEgxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oer7YIdo;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0355606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0355606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oer7YIdo
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a0eecf73fso149361eec.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370388; x=1793975188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAoD4mQFdz5KOYnm3Mb3Er1f5ViHeAPHJb+fiv/iKuU=;
        b=oer7YIdotKz/JXRB0qdpxYIPan9ozLr+1Yi+VxrAD9kMoAS3kXA9PaZbyNOJyvMrbS
         v5fjw3XXmiEoi9gPbOXeUp2UbBBzqJztqgXUFxAgQVMjR9/jjE7+Na4ZasF4q3YRWgaa
         GhPMPJhn5SXgAJkQrRyxYp3+2mmlwe+tUW4/F8CyVOQky43y+AbcJAfjoPl/b6CJm+0s
         S+APslvYn7nYiXfzHxsT8UDd0tH5mTfRNwrCYIPe8f12gGx8hUF5dMSqG0eHC6LikE+p
         ekUQJD7QyZPHN8mBaH7V2gXWHApDzpBCNnG4/Uba7HY6byMSbN5w8aX2NoR4GmLRucM+
         Bl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370388; x=1793975188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sAoD4mQFdz5KOYnm3Mb3Er1f5ViHeAPHJb+fiv/iKuU=;
        b=wyFpaJOhEbaBRw/fW62IRFat1h/bYHyM3aOa5HKh0G8tuJlFYbBwfFKdA1SlhVnh81
         RjFl/oDVaKdT7L4bZGAYYlmkid0YQX+MinWIsC6mWfazvEnc3SS4wXtoAYHx3pS1QnTH
         gqrGD2MGXFxJ4MoHCSp1ThMx8z6J7IEvTcq38qjgoyc4/j6XG4dVOuhOFZVb4yt6FrSP
         pxYEQupuZJdSPzaY2Uj8SCdKwnDD7u6mR1UXMGC8lBJKbhGRRfDsj5+8FIvLMoDIHxYX
         S/Ij20AT61J/Y4KXLKNGjvgRNLlD+Fq2isuozQhrqwSuD5V/anjJjKjS2kFBomQKs9fe
         W65g==
X-Forwarded-Encrypted: i=1; AKwUvBzxU0Hxc6cI/V37td74TThj3nvib407r+VkMw/y1u9wZCJmbBN8d6nduG/7ruyITGP10bCHSrk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSwUubZTsUtbg/3gL2EMKOz/6yX3xZzzXxSGhTUDCMmeu+bmqA
	NPhvB7u1MC3QHdrXL/Vv3XRq3KRw1qisI7mjYuEAuNuHQDS3BjQDlpoy
X-Gm-Gg: AYBFou1O4X1xazOwL3OlLxHziLb5KvcmCI0GbSCciYmhbV182r1gw/9gDx+6hQtN933
	4HV3XguhXOmFR4hS0srDoFgBrQpmX7R3mLQBlQn5I8axy6FdVsfS2kRpQVbaMt33c8mdLYw9DkH
	bt4kQX/DHrCTR/YvuiCkKM0yYAAHkWMnyd4PowtkQkFvbDQX0G5+8enQko1uQVI2xvvu/W9d7VF
	w0PBouM4ylfahzQCYe08JnN2RU3eruuR9rQsZKudv+lgaRsiHpEF3JwH+va421l9yRZ6Jag1Pcx
	km3XazbKvsFcvdoij1/CitqkqwELbQrSTsmZKHCryOBSg6rH2atCbxU+gUF9LSt14jjALxYZpBL
	Vi3KWuUS7X9eNMaCkK8Oa2gpknxPCz2cFMAxm8xomL1UtlR780calgy9+PoOVDVtQJPQrhlb6kQ
	AnMXWt1xr0OHDTLgFAnXnTOvJDg3ZFu5lcdBGx1uK9zbvFoHE0cn7YUwOJBivWl8Oeh0S6A0Ge5
	6qvKVSDlOzjFw7QLkBPaOgNb6zHsTTAtNwXvEuV8J2czzHRTVSkVFNPGvgMeTsI+FjlOM7AU/7H
	BSS6RHjjEdUAZjJj4eBBrWhFhPUE8obHltin7KZPmjtATqOeuWPZYInhOMDEVkl6io0rdqTSOyo
	QbtQHvINKvAyrfw1QaX/T4283/TpoMvfx14vqjKuCs+4YBaK++QodwZV1HLGBsOoRApOodtbvgM
	HcRatuGVMg6hfs2ka0mZ/xZL3+8sYNBLqbZAYUa+VF
X-Received: by 2002:a05:693c:6304:b0:368:1f8c:5f23 with SMTP id 5a478bee46e88-36a4205b0bfmr5705081eec.0.1793370388197;
        Fri, 30 Oct 2026 07:26:28 -0700 (PDT)
Received: from esteban.tail1178e6.ts.net (132.20.31.150.dy.iij4u.or.jp. [150.31.20.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca82sm7869265eec.0.2026.10.30.07.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:26:27 -0700 (PDT)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: linux-media@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	dan.scally@ideasonboard.com,
	djrscally@gmail.com,
	dmanresa@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/9] media: i2c: ov7251: Use in-range PLL1 dividers for the 319.2 MHz link
Date: Fri, 30 Oct 2026 23:26:24 +0900
Message-ID: <20261030142624.2235132-1-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAPY8ntArdj338V8bcSxrmwKQecy-pAcCXMbkWy=qLckX=hawNQ@mail.gmail.com>
References: <20261028112154.855185-1-antoine.pichot@gmail.com> <20261028112154.855185-2-antoine.pichot@gmail.com> <CAPY8ntArdj338V8bcSxrmwKQecy-pAcCXMbkWy=qLckX=hawNQ@mail.gmail.com>
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

Hi Dave,

On Thu, Oct 29, 2026 at 07:06:31PM +0000, Dave Stevenson wrote:
> I have a 24MHz module and had tested with it, which you'd acknowledged
> in the previous sentence.

You are right, sorry. v3 replaces that sentence: the 24 MHz tables are
left to a separate change, with your measurement cited.

> I've pushed where I am to
> https://github.com/6by9/linux/tree/rpi-7.3.y-ov7251. Patch "media:
> ov7251: Add support for a 400MHz link freq" fixes up all the 24MHz PLL
> settings. I've also done the conversion to use the V4L2 CCI library.

Thanks. For v3 I am taking your "Move the common registers into the
global init table" as patch 7, under your authorship, in place of my
strobe-register patch: the strobe registers now sit in
ov7251_global_init_setting, which answers your question on 5/7 of v1.

The move has two side effects on the bus, both in the commit message:

- The common registers are written at power-on instead of at every
  stream start, so a restart within the runtime PM autosuspend delay
  skips them. The datasheet allows it (table 2-8: software standby
  keeps the register values).
- Register 0x3820 holds 0x40 while the sensor streams, where it held
  0x00 before. The flip control writes back the value probe cached,
  and probe now caches it after the init table has written 0x40, not
  right after the reset when it read 0x00. I poked the old value in
  during a lit stream: brightness, picture, orientation and frame
  rate did not change.

Tested on the Book 2 against v2: the clock, timing, PLL, flip and
strobe registers read back while streaming at 30, 60 and 90 fps are
identical apart from 0x3820. On a sensor kept powered, a restart and
mode switches from 30 to 90, to 60 and back to 30 fps give a correct
first frame every time, at 90.45, 60.15 and 30.0 fps.

The rest of your branch (400 MHz, CCI, HBLANK and MIN_HTS, the
optional enable GPIO, the gain rename, the VBLANK minimum) I leave to
you as you offered, to keep v3 to the fixes and the IR camera. I can
test them on the Book 2 (19.2 MHz, 319.2 MHz link) when you post them.
Two things for that:

- A data point for the VBLANK minimum. A sweep on the Book 2 in the
  30 fps mode (exposure 400, gain 16, 20 frames per value) gives
  normal frames down to 41, white frames from 40 to 26 and frames
  rolled sideways from 25 to 16, both without CSI-2 errors, CRC
  errors from 13 and a stalled receiver at 10. The same boundary as
  on your Pi.
- At the tip of the branch (fde519da0503, "media: ov7251: Reduce
  OV7251_TIMING_MIN_HTS"), unless I misread it, ov7251_set_vflip()
  writes OV7251_TIMING_FORMAT2 (0x3821) rather than 0x3820, probe
  stores the 0x3821 read in timing_format1 rather than
  timing_format2, and the return value of devm_cci_regmap_init_i2c()
  is not checked. In case it helps before you post.

Thanks,
Antoine

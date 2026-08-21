Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63423D47A1
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346676; cv=none; b=Eb5ExkbEJaRGGtm+3bDg1p8A1jv79wAcNlcMAoYyQVSnqggYyH5d2vj1N5bw7QgGNrAQU3MUZkQ4f+/XC2y1u3NLH8fxx516yCqfQT94IMej2ULHoOT9FjSFoqZIX8zn6pze4EvqnuecYdP7E5VebDNgZo1REgBtDqiGKEoXKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346676; c=relaxed/simple;
	bh=2otbn34nfGVAQWDoW3kygwVPRAZNy6bTzKDAgEDbuA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTsm3HAg2fOuyci3j9H7izjPsjzrp+A4hDpxRYqITuhRGRf/ITl2+niYCmlcLP9qKnJSJJFe3LGgrwvA1oKh8aQRMIn1o2IlCp6dHjNeCz+h3pSDxtO9MZPr0YufkJ48bM2H+/i/CuVBuSz2g8/etqAJhig6SvuIidyPg0nkCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owohuVT+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owohuVT+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so919184a91.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346674; x=1787951474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sCsIOnwlsCxJXPIRVBkV12bzXwBoxzZvCo61RvGv4w=;
        b=owohuVT+66KwR1dYuxvUunOIPP6jS6bnC6CHQ7uCrTSeKG5pGd9NBkEmGvaeOoIn0x
         EQw85R1sLBzPBd6EvlaLsOaQPQER+2tn6pexbWokjSRINw6qC7DgVUSh59svgwWZC4Iw
         gfT2/ENf5OZB8oK4hCqCGhNw/M0/f3Zn3UKUBIK+1VkcG7+s5QNnpLSj0ScqPuNl4XRx
         8HAhP1KMMw8ctALf65FC8/M8/cNgAK8ws0rgNRaiDVINCzTFad1ocdL8NOOdfGCGvdDC
         dZqhIVi1jUvoMkx2ZFYX/dV7Vb3Nni1okAnVUN9rn0HyFfKFe+X6Ni0d/b9SIB2+Rjty
         vRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346674; x=1787951474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9sCsIOnwlsCxJXPIRVBkV12bzXwBoxzZvCo61RvGv4w=;
        b=gEJu9fHZKDnbHOG9oGzqhHerIwpWC/tF2md+TUVmIhVq4RGKhh7kT1o4P+Alz38xrE
         Ot9VScwQsSNTtuyE2QXSiz0d0PFNKodmI6NF12MA7V/o5RIeJxyTAw79QoUgmhClmEzn
         jfCV5PW14eYKImFL7I4vN3nfkk7TfME2oLzIluSxI1zWx5twMm2cIPtrwE6f3yLHw2eN
         KXoP/IjTmOGGr3pde8gbRwm3YXolrgLmpm+b4Fuj7MosjVzUd66FrTYlHZAVhDEoVFYU
         TC9Nj9t6Ni+Nq8Qsnq7fioqu9TWX3EAWBGwQkcgpvKUULxyAaA38VdGbVK/jhEHtxzCo
         yETA==
X-Forwarded-Encrypted: i=1; AHgh+RoJTrzBk/P07qm2hryMobwpSAUFbJZtlacOlCdYOaV7m+vIOIm7gHsJKEmHtwaZy/HNvWwtJ+c=@vger.kernel.org
X-Gm-Message-State: AFuF++nwQtppR0hHzz2bZzNn0nReNOF5U5OQYQao34PxDsdx+Mk9eSOW
	CB1+6ObIf5U+/rwCay7LBM/c7e3/supEsfQnYy/azlMJJfX9/TGROgkJ
X-Gm-Gg: AR+sD13ECZtJ+bhkhgOTbPfzhuNDM+v/DXG5LlOeX00AAmQTRKyR0RWC9uGMvBw2E3c
	f6sU5LEvJnAGOd2tgvEpPKiVnlwKJ2pxV+taZRk9wdVsnRf6En2Nkm/jSJjKIc69mNxXRfkzLIi
	lkFUPFotf75vA6/TZsE3Bxu1d1aPZ8sc0wK9kI7Z7Vcig442HF32SDo0dbTqCeSPHTzhQdrF4ix
	BJKBBGKsYvjdFE/RGPDq1bGifMpjheSwdmrnlMbQHPINNuu3CehlfjU72A3Jvh9GuYe0UNv1Thx
	jPXm7wfXbiGw50kIrm+5X0u+v7k3JrDhi9dBc/snvOE+w5/5yJMSNKgI6AM6z+hzf3IGbCR5eMa
	V/UCTbOg6dU/jLUob0skEq2VPC1LXodIU//JrbIHa6hOFyTYBcJHG2FvHO4GN11RaIprwbtOOBG
	GSRve3NDOJ4qt5pQAXKCOefdDK8vqAgENcllKM97C0e5ykXRJxqCwOGmSFbXV48kaQC1d2P7+90
	6ycIpCJyVyv37F3t8MtTA9knTzRyaFJ/6SfxNCL528WrqSLDOLSxY68zRdRH4vgMebyyX7a
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-395c3a43766mr18539447a91.15.1787346673939;
        Fri, 21 Aug 2026 14:11:13 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:11:13 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 04/17] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
Date: Fri, 21 Aug 2026 22:10:19 +0100
Message-ID: <20260821211032.13554-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

RZN1_RTC_ALW is a weekday bitmask where bit N represents weekday N.
When no alarm has been configured, the register has its power-on-reset
value of zero.

rzn1_rtc_read_alarm() uses fls() to convert the weekday bitmask into a
weekday number. When RZN1_RTC_ALW is zero, fls(0) returns zero and
fls(wday) - 1 evaluates to -1. This invalid weekday is then used to
calculate the alarm date and can either leave tm_wday set to -1 or
produce a fabricated alarm date.

Treat a zero RZN1_RTC_ALW value as an unset alarm weekday and return
without calculating the alarm date. Move reading RZN1_RTC_CTL1 before
this check so that alrm->enabled is updated for both configured and
unconfigured alarms.

Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- Dropped the output log from commit message.
- Added Reviewed-by and Tested-by tags from Wolfram.

v4->v5:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 56284a4320ae..d4cba0d415b6 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -235,13 +235,24 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
+	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
+	alrm->enabled = !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE));
+
 	min = readl(rtc->base + RZN1_RTC_ALM);
 	hour = readl(rtc->base + RZN1_RTC_ALH);
-	wday = readl(rtc->base + RZN1_RTC_ALW);
 
 	tm->tm_sec = 0;
 	tm->tm_min = bcd2bin(min);
 	tm->tm_hour = bcd2bin(hour);
+
+	/*
+	 * If wday is zero, no bit is set in RZN1_RTC_ALW. This is the
+	 * register's power-on reset value.
+	 */
+	wday = readl(rtc->base + RZN1_RTC_ALW);
+	if (!wday)
+		return 0;
+
 	delta_days = ((fls(wday) - 1) - tm->tm_wday + 7) % 7;
 	tm->tm_wday = fls(wday) - 1;
 
@@ -250,9 +261,6 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		rtc_time64_to_tm(alarm, tm);
 	}
 
-	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
-	alrm->enabled = !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE));
-
 	return 0;
 }
 
-- 
2.43.0


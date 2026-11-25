Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619392;
	b=TxxTdk1HDgoalPfCkyd7Jcm7EHWaNDE8q4HLfzssX0ZIOVdsxxv3tVilP+1GMfbILEOw
	 EAeldRXZK3Ru+ziVa2CQoEizheODG4Pk5+JVS+BUfub6UssUyxsg62QdR4qfe3i4+4PO7
	 CI0Gr2leOynVWpFtDLllEdPYbXl64JPNRnbJi7WKKZK9ROg5w5tyhScLl+QveiyErEgQZ
	 Q/wlfMy7UDkPtdyOnp3CYyckBvrhWwQ1xIX2vW7yYnR/2MJDAGLgMgiPEAp6W2ysusu6c
	 lw5glNS6MihVrdnB6fLRuJ5VEjBonswq+qpi9b2RHO40jDgh6qH9RzR/W1DW6OHmQjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wU/3Wiw6HBpJUb9vOL67s+ORbpL0ttUSloHr/zoQa8U=;
	b=f13xikjn30kzpRvJOZvwmxhtI8DZmHdL68N8WztAIjVMw1vR4bU7xZ1Qe6K73GUOL6qR
	 +ktR7fLI6GlQ0feJQmVPHaZfgzbvBDzcb2fgtFIYPiNJukcdQQ0kGgvxej1lY45Dx5tKO
	 1Ie3mthX8ivJ63ArBINlxyTlJ95Gzo/m4BBAEbZHqBHBOh20HSfFbiuBAxTMeB6WHVISi
	 eTcO4AvEqseM9ozi9y2diMsS4XPvdLcUBFnV99mjWxF02eMonVB2xYxWXZhov8YTreOom
	 jF0puYhsXmCvSs90awEyHjovZ2U72jICXf5KB1p8I+X+0gGCzP5/DgB3fuc0ahww4rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hU/cJhaK";
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32466606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32466606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hU/cJhaK
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so9002908c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619391; x=1796224191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wU/3Wiw6HBpJUb9vOL67s+ORbpL0ttUSloHr/zoQa8U=;
        b=hU/cJhaKNz93P0GMjl+URa/kTV1SPk5EUW78kR5rcIqbWBPJnNZnSKopxe3Z6sM5mO
         7gMi0+nQDW5f/J6fK3Vrto6r/lfCgiutnUnrBVcPYzyhwSORjvzyY1SVTRM+EGzBFw3u
         1HtNQI48JRidDGAvnuFMQj3k9n/XBUDjXVAddK9i1Y6xj5spbkuQED810lWK21cyS64H
         UoSpqCz+vD04AshM31wrNhQqErNNy98MGxr/fU8dhRApx9eihUH5mIyucLHjb8o3Q5PJ
         u9gtBSysro6RUsF0f+sE6jksOtpW/KlmydrS1rIvLKpgrgS6wgPzMx+ITjCVG8/eY64E
         XYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619391; x=1796224191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wU/3Wiw6HBpJUb9vOL67s+ORbpL0ttUSloHr/zoQa8U=;
        b=j3FV7ELeU3n8ieLJfjEeXMkngJPF1LWMQRrN6tvSNcGUsVOj6HjFkaM1HLjvDQMwMu
         JydS/h1X8ePjnYpiLXJPw38ILYLeVhp/bTbGUdH17fEpC0UtWtl57a8m///tIE+dJ9IG
         iyWFtNwFZEsY1psa7J9g3J/INYMTdV9Xo+y/wtl1iUiFi7/LSZ98+sPIkO1tmYJsZd8I
         7nvpDML/q/0HBW4ZMIvbM42SLpzZr9pGKzRzaZ5bgtrtit3WTPLSXjslVaskhInLk8Mw
         XLSvpK/ctKMz4FB8V90z94FkFsZ5ml2ac6Fj7+n5vK2SbtuulxOR4NeX5ROtBKVFQ0Rr
         IBjA==
X-Forwarded-Encrypted: i=1; AL+hErFgVo1Ff20HbP6hZyzbZUbMJ1KFr64oHyyYHAvOg10zztIR5jcXd5cuCxotreoYoXYNbJsgNhY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XFierzzMiXuM7PL/zL6+Q1vGIz9wCWUdnsbTj9+5on38DSTjb
	VaaRJhhPLBx+nlxMd9o8Jvg+ySSgp7ar6tV6xsxvm9RPmVy5VppawAJe4yOPXRcm
X-Gm-Gg: AZFdTZc+nVXtE3/oF+YPU1Kmi2MuC5kVriTP7MfUHBdNaWtC973hQ/5XNTJ6Z5XCyc3
	L8VUgUOtdHayMw8YfUKQfzb/6sSpDfpYJRpzy6s7r3EVbFHENjsGP7SPtqpCQJlh+U+oQIaybpJ
	EnS3cWcne3DvtbWe4THbsWP9bP6JyHMPw3Ei1dJ++vyBBkzomm82oa9ofW2t9XdMtTU95snKeIh
	cPob1IAGqkf2uL/6x80IqeA6eIbegD4JRq7j1deWKziIbC5MOC5Plv+9zBuOmqG5rXlKMafX1JQ
	xsbJCIIlK1VnHRPhdWPSpDCDxfBg9sMZ/Wr/4mIMopPR/Q83V0+h+kh7+MTRuMas0/CRPn1uYp/
	OiY8XSfkDNO5j4VgnyEHDtVaKchg+o+GJ/IqYLy5XPm0ZMdSCN54VcjcVn05Ve31mY3gvw8xswm
	B6Ul0lXRy/bbBeow77eJGPEu69+v+LRCsHXQs9sd9/wRcX3b0CPAam6AMwK4li0Xye4ZYOl+V+Y
	rlOK0cvDNy/jNQ236P35hrIjNYFe/KD8GGl3t9z01jKG00XnZEZ8cuLLbY/9C3LGgft7JdcBZ4q
	GJAxE4/7g9dbIYrV8Q5/J/l5qcDpbiDZ9nqqsLFCFJ6xBvvyAPR3046kiqU5
X-Received: by 2002:a05:7022:ea8d:b0:1a7:216d:157c with SMTP id a92af1059eb24-1b556902db6mr18127873c88.34.1795619391089;
        Wed, 25 Nov 2026 07:09:51 -0800 (PST)
Received: from LAPTOP-LJ15R92N.localdomain ([152.58.24.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm41950101c88.2.2026.11.25.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:09:50 -0800 (PST)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Elena Popa <elena.popa@nxp.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH v2] rtc: pcf2127: fix regmap_config corruption across probes
Date: Wed, 25 Nov 2026 15:11:08 +0000
Message-ID: <20261125151108.423-1-akshatrawat095@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Both pcf2127_i2c_probe() and pcf2127_spi_probe() declare config as a
static struct regmap_config and update it in place based on the chip
variant.

In pcf2127_spi_probe(), if a PCF2131 probes first, read_flag_mask and
write_flag_mask are overwritten to 0 and never restored. Any PCF2127 or
PCF2129 probed later reuses those zeroed masks instead of 0xa0/0x20,
breaking SPI register access. Modifying static max_register and flag
masks also races if multiple instances probe concurrently.

Remove the static qualifier from config in both probe functions so each
device gets its own initialized copy on the stack.

Fixes: fd28ceb4603f ("rtc: pcf2127: add variant-specific configuration structure")
Fixes: fa78e9b606a4 ("rtc: pcf2127: fix SPI command byte for PCF2131")
Cc: stable@vger.kernel.org
Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
Changes in v2:
- Reword commit title to state the bug fixed rather than the implementation
- Simplify to dropping static from config in pcf2127_i2c_probe() and
  pcf2127_spi_probe(), as suggested by Hugo Villeneuve (note: checkpatch.pl
  warns that struct regmap_config should normally be const)

Compile-tested (x86_64 gcc 15.2.0, W=1, CONFIG_WERROR=y) with
I2C+SPI, I2C-only, and SPI-only configs; not tested on hardware.

 drivers/rtc/rtc-pcf2127.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 27c5fb9b2aaa..d9ac2dbb4023 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1455,7 +1455,7 @@ MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
 static int pcf2127_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
-	static struct regmap_config config = {
+	struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
 	};
@@ -1520,7 +1520,7 @@ static const struct spi_device_id pcf2127_spi_id[];
 
 static int pcf2127_spi_probe(struct spi_device *spi)
 {
-	static struct regmap_config config = {
+	struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
 		.read_flag_mask = 0xa0,
-- 
2.56.1.windows.1


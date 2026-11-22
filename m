Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339557;
	b=4Qdo1C6XBFZeNxDMlDgAyVydpCWXTH37PG6Ee0TeRQNTn1b0uJI9L6/2Yg1P9KIUtlF+
	 UmSt0ZYfHNVzruixquWT9iH8Ps+nJSZO92Rvbkz+T+BaqClpFbPro4mj1tOaGrnqIfCGY
	 gn4aFetashHQcW90y4GHpiHbkxPsd9G4G4H+nkxBaWR9PSKDq5ZZIEiU31d8sRrWVYvS+
	 6GXyofuSJNt4lhlrId6Mc6ajgx83RqityQ+Dd3anBrqsnT0AOxtI1YUJt9S5MdJooSsCM
	 8XbcuWwk11zzUmL0wY4hYOMaNoWZm2ybB4QjC+xt1NuQbLE1PRyteYy602itu3TftdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=BTf5fmfGtJLtKBIVqGLksqJZqD13fP13MFLwQsUjm60=;
	b=Qj3reibooQNR42TyR2PIulSz06OkmSem1M0jZoE5eIDNlQ0grhli/djHZUJQlTCda0DC
	 HlNCo3R/g7314rjENz/QTTM/u55qfHHYYzLn8+Ipm5TdKGcq+/ctdf4hFla16NPt8NPlm
	 QmE8Vz8GEKWzlopbfYejeZvuchUKiSbonVrgE3xTbetw5pAQnLWezHvjFi3/USFJSRU28
	 TPbO/SCeIWXpjX17UZ91qGkYB2kESCmK7vILV4dmpRIAgX+HVGUL4pdSz1QOMNnX/Yanw
	 Epe/RfL9lMq+AH687TzvSUxBizQAPSGIZVQBCfeDRJA/N5t9J1XIxGZCyqVePsATpRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3022H6i;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F43606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51F43606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3022H6i
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4b8587b395aso1456169fac.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795339556; x=1795944356; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BTf5fmfGtJLtKBIVqGLksqJZqD13fP13MFLwQsUjm60=;
        b=J3022H6ixoVu+KaarkZvYO6TmfdJ4oVK4lE0rjbY6gkzmV8DWN8aqVt8aeCIlv5Pwe
         TipkLk4yvIRc3LFO0QD9yxxLhFz5yegJ0O8ihwyOxU5VFCBmbBixNkaN8oJIGIewKzPz
         iVIk1Vc4GfM9gTiDiFKvJlOzlpRIFIvLvz0tvWf2YnCzqWLqhuS0dZQ7AvqNGJo8d5ld
         yr9WGOF27+eeqKQ+xHcbCXbSMNb77mNAHuSGm6vCnsI7051/rMK4dkEBwBRwyiUAw8ag
         yNqHLoHl9l7NUusdf/9WnaBJAKXiaWvRgO5KputJDUUCFfLq0oLa3fkBLMbwsN/QDBLO
         qUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795339556; x=1795944356;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BTf5fmfGtJLtKBIVqGLksqJZqD13fP13MFLwQsUjm60=;
        b=fQdi7x2jF2sOvCGEVdhAVgORllcGosChgjxROLjBPkGYA49ZK3uVcuZEdFtUfeLa5E
         lCB0zVtAl6iiBWmGlKupibSNOWJMaMNQ5JRo0cd5U+3eyOajovatWjIyfX8ANcxCY/aj
         XooHIxvc23+w86D/4gxnebqx3xXsqRGpYaHIf1W4Gq3RidFRLHPPqgGIO7yFX+9oAUYq
         o97lce5koIgVOLJgd1Vig+V0t4O9azlZkiFqp5J8i8cwfwPHNh8fkGN4Pog2R1S9ZJGo
         cH56tChvIs/V8lscXK83jvTJqG3t48RPTthfOmyA3rsrzJixKnVChUBHeaYn0av8blqJ
         N0Uw==
X-Forwarded-Encrypted: i=1; AL+hErEoPBb2Sa7QnznNcSY3ZJEh6KvxTdhPf20SgKGra+RfvJrPK5hpRAonPjbpawdLUEAzXCAVq3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0iBSE47dz9l9AbudwQBPgvJWYVhGgU++Di0W0pScNJute9IX/
	ovtgiFgeTIWwQ/6f0XG6+v0DAWc6mkuS3BvvFZthfWL9O05txgHkzgY2
X-Gm-Gg: AZFdTZf32Zw2Jps+itWccoLpL54dfmAQ4WTNiwQ0gFuf3LN0Rf23fIbBVMExlGFXcUf
	VU+EaILypRwqGfywXVSCClT4jgLuGDKLybnTUAdOennHDvgWNECr/s4L67suLGOMqhsqMgKweK4
	nVjPLWjAt5i/70bqZCXXr0pY/AWBFfrnWXa+4Vf21qVirQn0kklS0LqUvGOHboiPlcEcDwOf774
	q6yo9Nhk9iHXZBaaVjCzFPAU3CpkvbzJVIClsh2BjeURcL9ow4hHZuZ4xOeTkQGxNm5DurziUhU
	cOjiig4ywSf5t4eX1gwm8u501zCgUSlkgP1kqZ4k39tPOR0cIuFpsrmm2gXVxdSsgMBiKpp/SF7
	mkxlo4QMKA9SjlZACgfEkVwZFZ7y+rvVygQKQ+3FahUl9ZQqjDsMBdjjcawAgx3aKl2VmK+5Zl1
	lYd1awBJ3TjNewL5Zpm4oFxpSx5wqsgHcs4BJuTKl4jIxVZljLzTjQQpX6Ayye8sVkCfAfFStMC
	pLkqfU1RE/ovetAV49Yp4ewRBdVOSfgG6H2MtuS0k7HG6fPE6IfFF2x4yJcmnJAuCjf0VZPADjp
	Mqb5XuANRgNq7KJgesvpPOWBp7BJHbDHvibCeUkzb1Aq3OtWUQMWTVDIGoh7BKjEq9c1R1KHTcp
	EU1rHPWnOmS7kpwqWht09/ZykXXta7f4u0qbIq25hWf10eiTU1Mc1YTorexHZIobRTkdfU419pi
	2iaSE7WVq/TrUPn8cQMp/PkGGOlkJb9caEDXF9N2D53s2wcRVo6RRV
X-Received: by 2002:a05:6871:c8c5:b0:4ad:73bd:91b3 with SMTP id 586e51a60fabf-4bc829912cfmr8276733fac.9.1795339556073;
        Sun, 22 Nov 2026 01:25:56 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdc0acsm8698476fac.3.2026.11.22.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:25:55 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/2] mtd: rawnand: serialize OTP and BBT recovery
 operations
Date: Sun, 22 Nov 2026 02:25:19 -0700
Message-Id: <20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WQ0U7DMAxFf6XKM0ZJl6ZphRD/gfbgpG4XWJOSd
 GVo2r+TtkhIvCH55cr2vce+sUTRUWJtcWORFpdc8FmUDwWzJ/QDgeuyZiUvlRBcQ7qY0c0Q8dO
 j7yBMFHHOS3AO9t35ARYBArnRPdVadZJlpylS765byutx19nmjey8Wq8TJ5fmEL82jEWsc/9Lz
 MWhUhUXvLdVr83LMKI7P9owsuN9j4z0ccn3zTsHM5gIcj97twVZQVpK00itDrxEqTUayw+EjdC
 dUbzmTa0UrawjpYTbY9ri6S/liDYG764Q5gkoxhDTD58A3SuJJXYVCv7L95wB798sdu0FiAEAA
 A==
X-Change-ID: 20261108-submit-rawnand-operation-locking-v1-1a0b8fe786d4
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Kyle Roeschley <kyle.roeschley@ni.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

Use the existing chip/controller serialization for the Macronix OTP
transaction and for marker writes after a BBT erase or write failure.
Both paths issue NAND commands outside the ordinary MTD read/write
wrappers, so they must acquire the same locks and wait for suspended
chips themselves.

The first patch makes the existing helpers available within the raw
NAND core and uses them for Macronix OTP. The second uses them for BBT
recovery.

Assisted-by: Codex:gpt-6.2-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes in v2:
- Rebase on nand/next after the BBT logging change.
- Apply the Macronix locking change on top of the posted OTP error
  propagation fix; both touch the OTP cleanup path.
- Link to v1: https://patch.msgid.link/20261108-submit-rawnand-operation-locking-v1-v1-0-565010fc5f8b@gmail.com

---
James Hilliard (2):
      mtd: rawnand: macronix: serialize OTP access with NAND operations
      mtd: rawnand: serialize bad-block marker writes during BBT recovery

 drivers/mtd/nand/raw/internals.h     | 2 ++
 drivers/mtd/nand/raw/nand_base.c     | 4 ++--
 drivers/mtd/nand/raw/nand_bbt.c      | 2 ++
 drivers/mtd/nand/raw/nand_macronix.c | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: ec1e844b9486302a488abc03ea918db60709766e
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
change-id: 20261108-submit-rawnand-operation-locking-v1-1a0b8fe786d4
prerequisite-message-id: <20261108-submit-macronix-otp-errors-v1-v1-1-8f64a2ad5a10@gmail.com>
prerequisite-patch-id: a542c9cd698d2d4c090932b8d74dc6f520a71166

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


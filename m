Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B742B322
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556792; cv=none; b=EHeY+dXFdq7+AGSB7EEVLm1GPQd9xpm6ywSBK8hV7DCDsdKBGLKZ11vy8j2A+dvHp1hCPHYDLwKoe2E83pd4i+XBGMxq3xh9k0ALuqtKdB0S7TM1tig0FaEtCOjJEq5PFNejL5k7sF1wNMH7ScqYudWSwY9xKdmw8T+Hpxqh4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556792; c=relaxed/simple;
	bh=itB2O4GUgGv95QM0OP7pQVex4/safeVqHqwTGlJLAw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQE+vEtqkf3TsXBGC/ScGbYKpUw98VbznE6WqZtU7UFHD1YrsoESiR8AeVrKH8JOCbpiQzjl17omY9+0E0jexv6C2tFjfz+zD+0VCMfEv1kXoh16a7i0CBWu3SmCtosegETqDjKxN+1mSmylPHPcvpDnzljg1qG/rAIqjPapmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1zv1Glt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1zv1Glt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso115353765ad.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556791; x=1785161591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8XF7nrzvK9JY0N2y+Fglwp5PAhvkeA4CdEStxZj/5I=;
        b=T1zv1Glt7Jkta70E8ULlx0lpkHv+I2u/NFaaP/FhIolf0jJFVyVan7q0w/wS9hGBpu
         5mH5azZ6cR7sSdkagz43S6NCeBQW/a1QJ3fVyd1bB6U3S7M7gsDHawy8ToJDtGxzO3+z
         0PiDZLtVMEaNOK+OYC8jQGTabZ2yxrtzHHMY6g6H4ebWcdNPN0Tni4D9gWq8pUHJMLUg
         wQ5asiBvelb3Isy2AfkbW+zMn+G8vkSsTXLQUUZyO0nm+Ec3t1UGRCpVQqvrV29+1frH
         Ro5jbAxcHD5HZo8lDDJNEpBUGwWgkBjmskRVKYTGIpoZfs9U4PHi65qtj2GQ4+VIE8e0
         N/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556791; x=1785161591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b8XF7nrzvK9JY0N2y+Fglwp5PAhvkeA4CdEStxZj/5I=;
        b=P05f9IyiY4lXsXUt9uErQCt/3difEMlqZPRtPGtpZk/PMTCjLGMY8WDreQoYktFQD4
         hDKtFfRvrFDxBzv7q3K4Z1CR3tB16+jl5dnFpjHizT/a0x5kVsLbEGaYD5FvDuFWamCi
         oGZtP5BaSQSuud2eUJdWqui1sj1LsiFAMsMn6GJ8iA9e2GKpyzh/nHXFDJdmGO9Xzchj
         P4JCj6iGTx6MtqFgRNu/ng1/oi+tPyuiyAfcHy+YS9tzxyOurDYe0uDpuTs/C1YptHTZ
         mqUCa7JB6ZtnB+PpkuUkbOcpp/jyv2hPjm2jN0bGuTDSpJL5r434zpyHzKUjGiaqZWCv
         tzSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzvghJ4QU5rJlTEteYyhtbx0nYsm5K+0p4TLaeTfJvzqVU/PmrKNgD+S1HfzcIaAIdsFTOqbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwlYdJaosioyL6x0FBzPF+n1Dn2n5vcs6YJxjuRuPiM7pyxel
	tAZQh2A1d9wW2X99hEz7yoF7T9mB8C8zk2u6fDVFv75MKaZNY9uPMj/D
X-Gm-Gg: AR+sD13U1eZnTPW97nRVrjacrebHC3a7lko9Bm9VK2781GvCU7xpD3fpBwT17+YerGv
	O+ela2kFN+re+3ytA3D7prICu+/2U9noZ/dVVo1amTa+1dFPzzfOy8EG/LS3aRGsMaZEUbcLLXf
	15/A/qG5vspDRxhFQAFe/Jl44+ltdCnudgrYTqKlpADEhzEMaQxIQrCazlLlQ+QGkLKcMJkzPVC
	4JjPcvOj3FRQbsqGqxGawXWak5oNHPAsrtRON3DklPYLqhgEuaFQqkW6StkRhWihdlFmsZu1F/5
	GfhNS0dxw6KASUEJab3543obHj6J0PRCMx38UpsPy6hVriRPea004d70XcPj5wkDlw/5DSMfCNk
	XrL7bUYU3KWzOVVzjRyBL5TprmGzmMMoG9j4x4LO1tBakqXL1n8ED8lvmAfr2v4gj2E1UjF+T88
	xtq46QUgZ/5f924HsZ3yqfrwy1mtLP0hS88LvogVSfxvYqwlqnl31y8hqKohB6lAlTAIY=
X-Received: by 2002:a17:902:cecd:b0:2c9:9a19:10c with SMTP id d9443c01a7336-2cf34a4c9d7mr151190115ad.40.1784556790807;
        Mon, 20 Jul 2026 07:13:10 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34730e35sm57578155ad.64.2026.07.20.07.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:13:10 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: pratyush@kernel.org,
	mwalle@kernel.org,
	tudor.ambarus@linaro.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: takahiro.kuwano@infineon.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH v2 2/2] mtd: spi-nor: sfdp: check the length of the SCCR map
Date: Mon, 20 Jul 2026 23:11:04 +0900
Message-ID: <20260720141104.2054417-3-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720141104.2054417-1-sammiee5311@gmail.com>
References: <20260720141104.2054417-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spi_nor_parse_sccr() sizes its buffer from the table length the
flash reports in the SFDP parameter header. But it then reads DWORD1
and DWORD22 without ever checking the table is that long.

So if a flash reports a length of one, the buffer is only four bytes
while DWORD22 sits at byte offset 84. With a length of zero kmalloc()
returns ZERO_SIZE_PTR rather than an error, so the NULL check doesn't
catch it and the first read dereferences it.

To fix this, reject a table that's too short for the highest DWORD the
parser reads, the way spi_nor_parse_4bait() already does. The table is
optional, so this isn't fatal. The spi_nor_parse_sfdp() warns and
carries on.

The spi_nor_parse_sccr_mc() doesn't need the same check. It works out
the number of dice from the length it allocated with, so its highest
index stays inside the buffer.

Fixes: 7ab8b810757a ("mtd: spi-nor: sfdp: Add support for SCCR map for multi-chip device")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/mtd/spi-nor/sfdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index ece8bbd4bc47..98559536d41b 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1266,6 +1266,7 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 }
 
 #define SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE		BIT(31)
+#define SFDP_SCCR_DWORD_MIN				22
 
 /**
  * spi_nor_parse_sccr() - Parse the Status, Control and Configuration Register
@@ -1284,6 +1285,9 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
 	size_t len;
 	int ret;
 
+	if (sccr_header->length < SFDP_SCCR_DWORD_MIN)
+		return -EINVAL;
+
 	len = sccr_header->length * sizeof(*dwords);
 	dwords = kmalloc(len, GFP_KERNEL);
 	if (!dwords)
-- 
2.43.0


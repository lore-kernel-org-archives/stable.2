Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06438C2A0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756398; cv=none; b=WD84zanQtgHp5Fog9LGBahrzKAWbVic7QXZLwIgmpaNeXQ+MMOuZsYQ3u7v1YtbYEjc+UUpqJpqgYtKi2pZDG99HivM76++3wc67t8ml+rFGonWlS42pt6LMIqzxSlXL3k3uk2My7iPoK4rZKz5os6rX3jaf4qIe+Yi5r+lIXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756398; c=relaxed/simple;
	bh=S1kI0kz2VpIgx3UB+JHbQdXuW4beVBoQ7fRV5J6w0Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwCf8PymDhk96ycBiFv8fgOef6/aXWMf1uhL5y8GGVO+EDKSunBSlgEkMY5CF3N/w9V6fhhCp7nH7K7gYIYbELAyIO0PBhhj+3D9A2tztc5URUf8Wy/43dNHhh174VPaEYOW4DzWFAs+rQIYL6fj5miS/Kp8tHstxvtDwSDo0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8npc05Q; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8npc05Q"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd54610so1826996a12.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756393; x=1791361193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++V1wMCrHdy0Mjct0UTBFxjzclTBEd3vplbF3Wd2tWQ=;
        b=Z8npc05QGf4zSc7ViLHPLTxzVjUE0bRgL3/LIUFlc2Xjw1PjMkEV0HNF91o3xpNuc1
         HPGT3RBdplQ1Ripe9ZRAXhi299G+NHWe7X/VDmcX8+vUK9EYXncmBiPrsTvj2oJeSESD
         ppm4uP8c3COjbcNGlsrBzGrcc7e63KyW4Ull9SkX/Ygp/Cgnr8Hejx4oVPT2VKw0ordi
         rcHoF0ifuBMET1kULb9ijBblnsspIQjW3gEkKs3TChpB8mMdUddiMUckqTjUFRteNnY3
         5Utia1AbY541AYDmLmhWdtnUjxErqJKTPIf0tKumaq6qObHhRJ9L0VraKsAJN7PRipOV
         dPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756393; x=1791361193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=++V1wMCrHdy0Mjct0UTBFxjzclTBEd3vplbF3Wd2tWQ=;
        b=2UZx1a8tiVfLbMJSyR/d83B0exkFPIIFvHE4tMyCA6s7px8aOm4dpS4QXi207Ir4ii
         yUtbTEZWyqxOstsf0YOWXPfPrG1pMbTT/7tu6wN4ZGMoMu7tAiTY6sLGuoK12u80jtpb
         6WBjGRhNomv4q2UHep5sJk8PKibDO6qcFX4wlS6BeWkC1MjHXhFy1WB8ycjJ72RALdQl
         Xbzj+xtYgPukpR8FzLkQI8QEXXameBgiV34MkFgDV4oJQus/HJL5YcBGwnIQbVF0gdV+
         HP4g2KMc87xnLJcps14lFecspnhi8WKIrd/s0pc3MxRiDlZ0uGD4zqmrEGqQPAViUCN0
         Bfew==
X-Forwarded-Encrypted: i=1; AKwUvByiifzG0pjZdleBujskTHen4kRrPTnw02QtZT7AvzqOhh/YEWKzl7mtCxV13s5IKTeYXc0TW20=@vger.kernel.org
X-Gm-Message-State: AFuF++k3J5sH74Q40ld1PUVnlqeB4HxWIdK53lE3rog0MPKf3nDIqOLv
	kIyQwrBYLs896g+jybZah7zNxPH9e5uHvSgmHi8ns2GUhsUGZiMuax0C
X-Gm-Gg: AYBFou1bIRU3xS5Zroq5w6frNZi0Y2Fv+9pPBj7gqkWMelifaAgxhJg/SjLXEzQPcaC
	zlFVCERkECh7BehBdIhP4BANOf3VJc0zldgsUrXgsGFiU5r5klEeIaqdwzoW1Au5nGV//J52Gay
	BipvT1vvC88fiGDFIXiLyZxM/j6DUwK27AVQkvcnWZcxjSSMB1rSC1K795NNo7sTmOV1z0vvuDP
	JNrN+7lF+jWzuuL93eKiRGsExMv52TmcxnTQ3J7rBJJaC8Zwd6Gk3P+GpguTpA3eo97YShKc2mh
	Ghl6PdmRn7qDh3fL8D4NGVDUAmBgZbkeDXT0ORj6WWR4QVnu8goGDKRGoZ/YknChKe6i2oV10TW
	vAZeQmpdIgBzlcPgxmm5+bwYBjgKIOMGh1YL95sGgJY9PhX+bWaa8/RbZ9tgnoR9hqQOAbmUHPR
	pAPrECk61cNZflpwUAfB4bBiIeD9lBvWcp/2WzWBsiULD3yMXpaeYs/pHQ1sxiv7zSmCyZjSBWK
	WKTpSo4pfOI/5iaenN4IPr6Ru0jK07LqQw8Bde05q7QG3WZQ8h1l45mgeXDN1V4+l9BmichK3TX
	OtDzZy8sMg==
X-Received: by 2002:a05:6a20:db0c:b0:3dd:a196:308f with SMTP id adf61e73a8af0-3de9eb7cf18mr792880637.63.1790756393029;
        Wed, 30 Sep 2026 01:19:53 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 5/6] qnx6: abort mount on superblock magic mismatch when silent is set in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 08:19:46 +0000
Message-ID: <20260930081947.511613-6-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), when checking superblock magic for candidate
superblocks, if the magic does not match QNX6_SUPER_MAGIC and silent is non-zero,
the error message print is skipped but execution continues to subsequent checks,
resulting in invalid superblock processing.

Jump to error labels out1/out2 when superblock magic mismatch occurs,
regardless of the silent parameter.

Fixes: 3377755f1064 ("qnx6: add support for MMI (MME) media filesystem variant")
Cc: stable@vger.kernel.org
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 fs/qnx6/super_mmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index 19f123d45678..2b6183d2c889 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -62,6 +62,7 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	if (fs32_to_cpu(sbi, sb1->sb_magic) != QNX6_SUPER_MAGIC) {
 		if (!silent)
 			pr_err("wrong signature (magic) in superblock #1.\n");
+		goto out1;
 	}
 
 	/* checksum check - start at byte 8 and end at byte 512 */
@@ -83,6 +84,7 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	if (fs32_to_cpu(sbi, sb2->sb_magic) != QNX6_SUPER_MAGIC) {
 		if (!silent)
 			pr_err("wrong signature (magic) in superblock #2.\n");
+		goto out2;
 	}
 
 	/* checksum check - start at byte 8 and end at byte 512 */
-- 
2.47.3

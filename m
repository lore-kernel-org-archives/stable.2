Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30347253F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584045; cv=none; b=GPYnAGI6n6LCBBETOMIMJDiiOId2YHBQZWTpwnbyBuo0E9k77mW2xkFbmTHRYOi924+zuxDFGAHV9X6sy/V+SPMEkzvYKA7iJTkdDywQrmjmDtNr0c5U8JstQEVlLEMaZCEBu42VTH+XKjmwu0dwe5uSLiH0Ywz0aWwuByCoJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584045; c=relaxed/simple;
	bh=abf0CWKhpj6pL3vQ087zXOZUjUm1ZLL1hnZCQzMvphw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeXIewra3+bWzSeVnfsaQckuqOnvnM3Og99EB+MOBqUVWl6mA9Tgv4FyISLeWyfUc/kV9Jm9Xy9TPBLSSG/4XBGKldjLdFo4/1vqzS7P1RBukom6yC9HvsniGDQbXenRvDIb0WKTL7wrN8wxSq7XrK571UKEBEhQtuXzOipietg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/ZBHRDe; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/ZBHRDe"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso2009489a91.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790584044; x=1791188844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vX0JjjA39zKKltn0X7k+S3g1AJ/3Xp/uB/9KtblEZgY=;
        b=r/ZBHRDed0MgJCk0LrZCVnXn8x/WiOJyVNXZvGqXCXxOcH+LQkIOILdOsWe7QO+dAp
         Jcr4cK8iLALtqOLMkegHqdxCmB/mP5j5rXYEjU9mMDJzVDvhIpcybaOnW3NUfOEt29gt
         soynLOt3jo8sd1yUmvHQis9F1JYkRCJtIMOD2vtN0Mg0/jBghgx0JIUxTKdB13NAUGUT
         //F5i2eibM1BVgcYmiyUaDepFyZ+yBusPZUqz0G52KXb+XSlJjvT7zKt3+Y9lpLL4CRY
         H7KO61AZpN//bZGH9/vONe6/r+vb8aX5IRKPI5fjYtbjrrEuOhqohIDalNhbtlzoZzQq
         vt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584044; x=1791188844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vX0JjjA39zKKltn0X7k+S3g1AJ/3Xp/uB/9KtblEZgY=;
        b=oIRr+9ZWaTe9uUaNWbIDedQ4sjXK9Lw+Ki+2SarJm9CLRZ8H+vSC8535oUj4G/ponZ
         KI95ZWhjEb8h33/HtBKo1wJhe0thVMWbeacf8LVESI4Pmn/x7TE7JV+HN2xyLWkC6Kmq
         tUaLiCLCxltikNg8qLy6QSeYAsNUearEGBYiGBpl3S+3x0tSBeLNpK9vVg+m2a+DBFqk
         fYCs/WvaLrvUAJZ3pVydyxyBoa997fMq7SNJ4f4CHeSuDEXTu/oa7larf2ZGRCwRlXx+
         OGUyejWYPmB5jH59kt9Mc/FxbFUBazd97AyEtXaEpgsAotifdhITowujwVdD66Tocgw6
         UG8A==
X-Forwarded-Encrypted: i=1; AKwUvBwTvb2tRwohFKyHybKNsqjnk6dxlMenQElTiczvJqs4F3CljuzB0JbLJq83QZsfRwxd/wSaVRA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxSBLWN+k++iUdJZRUApzdM4L+cVF3v9m+6V8xwiW+xpnlQa+y
	DQV2ovBoeDoFG8c0ZiyMkd8CcpAHDAcCWkK7Z31Ti+KYL2HZFrEdp4cu
X-Gm-Gg: AYBFou2G/ktw6R2aBMxpwveEX8vI+dLmSQgzHTEeMklQSr4KeyWpEu+pfz+lfYW9Avt
	mmfefA54nFwM1Jif8u9Hc1N3UF22b9cbFxqJfYJQ5VOsmKMd7GLevn1/v0NDKGpMUTWXaEjpFzG
	npALbY3tzedRc89+Td1N1/wKUB8C+QlZbOamXEprodVtS+DMKGjN6AceMHX4Vj4SbDJ+Ykx6/TI
	1X3qRqTp/EMqt9Q1cQcaO0yz8T/l2b4HEpssScDyYT2o07ljNqqA9WTtWJLPXP7pqu9NPZU51Xh
	a+xT3pHd4IdJm8IGJRgta3jwlUOiCVKdXPrSN3ezdcUDXmSBwcy7zgSybRwdREcbPBIRsfD+2mw
	RTVs9bhuHtDYAj0lL6gL7FxhTWUGCUnA5n9dgR5hz3uIwmjyGx8Nc0mgiH/ofOxF06YyOSVl4N8
	v7z2ONikJ9uCzMhFs3gBSCZu+1Shc9mOz90WMcxoodDuG6uVW0ECb3MkxAnGxhVzsHPk/ImZQen
	CksLIAFycSp4ywLOYeC0z4xwO6H6awPit9oPrgOHUnYigGyR0cHjj9oloFpwlTluWNT64AXozLF
	ILptU3+f0g==
X-Received: by 2002:a17:90b:4b12:b0:3a0:8050:2ed1 with SMTP id 98e67ed59e1d1-3a0bb6596e8mr7982777a91.63.1790584043566;
        Mon, 28 Sep 2026 01:27:23 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589f7esm19265257a91.10.2026.09.28.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:27:23 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH v2 1/1] tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation
Date: Mon, 28 Sep 2026 16:27:00 +0800
Message-ID: <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790568982.git.xuyuqiabc@gmail.com>
References: <cover.1790568982.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPM2_CAP_PCRS response is external input. tpm2_get_pcr_allocation()
adds every active selection to allocated_banks, while
tpm_sysfs_add_device() has one group slot per distinct hash algorithm.
Eight duplicate selections can therefore write past chip->groups[].

The TPM protocol does not allow a hash algorithm to appear twice in
this capability response. Treat a duplicate as a broken TPM and return
-EIO so the chip is not enabled, instead of silently dropping the
extra selection.

Fixes: aab73d952402 ("tpm: add sysfs exports for all banks of PCR registers")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
Changes in v2:
 - Return -EIO on a duplicate PCR bank instead of silently ignoring
   it, as requested by Jarkko Sakkinen. A duplicate violates the TPM
   protocol, so the chip is not enabled.
 - v1 Link: https://lore.kernel.org/all/cover.1789800840.git.xuyuqiabc@gmail.com/
 drivers/char/tpm/tpm2-cmd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ae22295df798..a94f4395c198 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -527,6 +527,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	u32 rsp_len;
 	int rc;
 	int i = 0;
+	int j;
 
 	struct tpm_buf *buf __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
 	if (!buf)
@@ -569,6 +570,23 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 		pcr_select_offset = memchr_inv(pcr_selection.pcr_select, 0,
 					       pcr_selection.size_of_select);
 		if (pcr_select_offset) {
+			for (j = 0; j < nr_alloc_banks; j++) {
+				if (chip->allocated_banks[j].alg_id == hash_alg)
+					break;
+			}
+
+			/*
+			 * The TPM protocol does not allow the same hash
+			 * algorithm twice.  A duplicate means this device
+			 * is not behaving; do not enable it.
+			 */
+			if (j != nr_alloc_banks) {
+				pr_err("tpm: duplicate PCR bank for algorithm 0x%04x\n",
+				       hash_alg);
+				rc = -EIO;
+				break;
+			}
+
 			chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
 
 			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
-- 
2.55.0


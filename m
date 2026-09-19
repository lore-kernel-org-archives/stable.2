Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327413C81B9
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807642; cv=none; b=MCZULWZ/InMshbpwNVp0WcjMVjiWBhfOJrGIfKuM/HS6qWZFMO50xJTMKjRQUfUbfHlJkhmFDJ0O7iTbcMrzCYXt1XNupKySNcKQcPgi0GvMZBN3V9meMF/lM0XPUF29q3++oXgs2BvbmAVSGheLNZsTqnMRfdLvs6wU0WuL4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807642; c=relaxed/simple;
	bh=j80gGp1mQQqYOGLc25zXbELHZ56zd+Nm2USR78qFXA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqGW5qxEJGwdwBkSBByu6vtplJt5V6yfGCGzntQV45860WnH4oeZONH9H1CY0XIm2vJ4MidGMllnbYy7Lf74yMSBry7bcexa9Q5dA9IdHWUVoGm17uf9e/zZTw3RfglfLMG5m1o+kzShcLfNpxlNfxmfe3bpey+kwxTqkR4YB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5UGpiLg; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5UGpiLg"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so472365a12.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807639; x=1790412439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eKrINCbjz06iI3XHAyCAb5A7LBzsyEXpm4t3U5fKalE=;
        b=P5UGpiLgCKwdiIFY48xloNe+TX+JpH8KVHS0sicyoA6mw5cHeULZzvf4AB+3Vrtxqg
         WB6jQcllgZi4l5VcHKYLC7zy5tVlN4EVqbwBjnEWez66u0qrnKKBOMzGh/zOFzCQ6x+U
         7O/FSsQYI3sANdAn84dFhCuxnYVeZjOqffeGdS99FArK2k/dpqrHEIhjQVwxZS46iaFn
         +6olXjCjAZc3XWx1SVb1D0VAlt22iJzfsCuXa6jyiMqhPZDy/f5Np75ErqoxSxAPZD64
         bk2/SHvq7pxDJRSCfomOyAklH0hMpStEQDb/4G3z8+iLlL+lXcBFxfFdjpTvXcy4Er2u
         HbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807639; x=1790412439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eKrINCbjz06iI3XHAyCAb5A7LBzsyEXpm4t3U5fKalE=;
        b=lcZMvbWqZViI0vbE5MB9OUqtwwmQzxxPgnhgUZaIQ6lKRW+nkQPyOh0OH+Jl/U9WmP
         flZ2tFTdiJsyB5hJrv7tnLlFYIR8scBjH/YqCOoBIQCUfEqu4LpHVElfhc3QBYG5ezUU
         JxRBcV3FZ6U7F1TNsXGxTbDULmLvioc7F5uY0BnU3ValsA8LpH7aOok64bacQVuRXX4U
         hSLFdPF35I0k81xzAFV2Ety4IxmMoIxERyByxuVkeMkjUCoSVjRKFX7n3h3iwyeSiByX
         RX27WorFIJxAadJjgni/dCF3oKP689QiXvwSb1VYhR6DKjEkSfcswi7Svh5WHR2frxXa
         2zdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAOgrqeQmly3nQiSW3ENXq3BvnLTuLM5NoPvlEbmnrGx5RACDoNnz5o6EGN5r6LLWNO+vU7zk=@vger.kernel.org
X-Gm-Message-State: AFuF++kT+FyeP0bYYTC2unvCZToIqkm/vAZajszG5x910ZgMV59xtMSO
	zJXg0LRwsXUz5Ml1tIacHhABUccFLUWTEXiK2pamZIBWjY6tXZaew0HF
X-Gm-Gg: AYBFou2wwl4Dwb5534213lu6mj2lw2RcB+fvw/egygMqHNL44RaZvCNQYvioJkKNF5N
	jTCG2QIUVhX5R/5wcNxFVap8gSLQS+gDwITA+1ZloTA/3nto/xNCwnyFla6Xus1cwcAvsxGGGZ+
	1dy29OSN5U83wdCfgERkxOUZ+RBZYIceFZ8Q0b3ol6esGjIonF7tFHgaMcuK5YQhw2QjHcfN4pA
	+ikby+VtXHdvPGAPUWV/w8L1jadMKLsg5/aFkn6wpYF6fgS/LR94Xa1MK/1VB0uNwQgbzqH1ZNx
	lGq3v2YeWto25Os+p2cCGAigVrUxPR2JFCxzCHn1LRa6Wm7bgpDqb74bV8q3MeCXSDlkmpju1Sw
	qen44rUvpmeop7fO27BvaBBaiJUgqgHf3+IZY9CVi5YSWbWQ1cKScamWmI7RZXIqg72k+5zgc18
	yvfw2Yz9eA/b2nkg0x0i0W0wNUmkVA8Y8j9yApMk7GKlAX5sp2UOZ5XxRoSiuGuyZD1BnMFXCRg
	dL0Z0pqDm3I14/FGdsurFr8GTg5YpXuDe0O+ImwGHMCcrJo/qwzzcF03kcULppFkBxjwg==
X-Received: by 2002:a17:90b:3908:b0:39e:3d38:7ef1 with SMTP id 98e67ed59e1d1-39e5565236dmr5237971a91.10.1789807638878;
        Sat, 19 Sep 2026 01:47:18 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca871edsm3492881a91.5.2026.09.19.01.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:47:18 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH 1/1] tpm: ignore duplicate PCR banks in tpm2_get_pcr_allocation
Date: Sat, 19 Sep 2026 16:47:00 +0800
Message-ID: <85b8cbb1985c743325d57e05d51d8814d3c56549.1789800840.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789800840.git.xuyuqiabc@gmail.com>
References: <cover.1789800840.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPM2_CAP_PCRS response is external input and may contain duplicate
hash algorithms.  tpm2_get_pcr_allocation() adds every active selection
to allocated_banks, while tpm_sysfs_add_device() has one group slot per
distinct hash algorithm.  Eight duplicate selections can therefore make
it write past chip->groups[].

Keep allocated_banks unique by ignoring duplicate hash algorithms while
parsing the response.

Fixes: aab73d952402 ("tpm: add sysfs exports for all banks of PCR registers")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 drivers/char/tpm/tpm2-cmd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ae22295df798..99e9d89b18e1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -527,6 +527,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	u32 rsp_len;
 	int rc;
 	int i = 0;
+	int j;
 
 	struct tpm_buf *buf __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
 	if (!buf)
@@ -569,13 +570,20 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 		pcr_select_offset = memchr_inv(pcr_selection.pcr_select, 0,
 					       pcr_selection.size_of_select);
 		if (pcr_select_offset) {
-			chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
+			for (j = 0; j < nr_alloc_banks; j++) {
+				if (chip->allocated_banks[j].alg_id == hash_alg)
+					break;
+			}
 
-			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
-			if (rc < 0)
-				break;
+			if (j == nr_alloc_banks) {
+				chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
 
-			nr_alloc_banks++;
+				rc = tpm2_init_bank_info(chip, nr_alloc_banks);
+				if (rc < 0)
+					break;
+
+				nr_alloc_banks++;
+			}
 		}
 
 		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
-- 
2.55.0


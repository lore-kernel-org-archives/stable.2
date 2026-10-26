Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013040;
	b=CfThoVaCu2xAk5Zbq2ZXvvDSsUtue6nVnFDOx0skZ/5jE0xW9RWIV6TEVqTvqviUrAIG
	 DD+xS9oOKaS2vQGkEsdCdNb/9wTy8raeABKZH9gPsF/a6vXXfytz44I228FAwZjNwM8mq
	 HfNVAl46Tzeigr3kFC2yJdHF5htDvuEpnK7PUS8/9gnSEgdvoiQ3v3FKu7zzyMHP1ZYpj
	 1qpmkY89UlB/5zIwnYNfD+0ifQQdAteGVGdGrPG/p/+iCl7880aWfxShe5F9Duj5eQ2nY
	 a7caFWVdvMCep7xxc5/zL5d7g0W+nnK8eT+Tuq3oQcBwCpZCzRUpU1HHqc5mlRVlCcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nPvZd6ipcHhyyKgSYRp44a/mOJGJPLjA8+pqMRT1rUc=;
	b=ZP4FnyDhFDfvitb12UAypcPCZ0NTNL68yvjQAKDwJNhl9qe4A8tluX42f2A6J22WV47D
	 wPMyKRxfzX0DKmsJZGSBveB7mCmWt75ZWUI51Xfi4czk0aVvh3heeigYHhH6rlF6LaVbl
	 bA5n5oHh6mv8HfPJaZyQ6TwT28mWUYCPljGVUybx/6kh99AI/pHqbaHCyeChqnn2RXChu
	 h0tuhaLowiEN2rbyN+/T23ZoFnjSWECCSWVg7RWrFDvvvD/Yzo9DDM0oJy4PlzOdBZjEI
	 qrDT4Zyt9d6xqCsZVe37zFRQ20dtU3WpLnYZZmplO4RZqAx2ZTepjEdaKzYKhFZuRQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NFrt4eiV;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEC60A5BFD
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47FEC60A5BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NFrt4eiV
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab3f899c8aso516330a91.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013040; x=1793617840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nPvZd6ipcHhyyKgSYRp44a/mOJGJPLjA8+pqMRT1rUc=;
        b=NFrt4eiVbq4Mp8B0y4o25ojFp+FFa+4f66uMwJtHoVi/woM9GOFpLAcZWlD8iPQMSV
         s4eoGDF/diHSBsKR/tsnpoY7RrRmG20QTZe5kqKT7s2fYLf301xS5hunbFVxI9gR9T4A
         CjFVGigZlaPXSYWVSZ64dZMArV19RYkeO02mm6MWuMvpRbxdFqXuDTrloQPz8eXMtyZ4
         5+tz5yEDhOTfPLYDXvKgvClHmd/AoBm5hig71DxXYHskC02+iPVBWKVJTS6EJAXsSx4c
         lZFEg+Bf4wA1B0szWc/6Zmx0DNhbtRiN8q+GMGbsYOIJe8+xVAAy6354QW73xycIxW9t
         edPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013040; x=1793617840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nPvZd6ipcHhyyKgSYRp44a/mOJGJPLjA8+pqMRT1rUc=;
        b=2ZAxCjEr3KD4v3Y0ys3uU7awkoXCrKn37+IO8n8Vt2YcoUmLwnLCryfjD38QudihnY
         9psjezH6LErlgO0Jil8Kx2cf/vxYGA7Mq5Am4ynVfjpTNP5E0DFieh+SJAqI0F5mlP9y
         rUpXv9FDqVHztoKhSjZB2UAabWG8fvzBaj2wV2J8gNgkQ3KqXLi8RUZrnk2KLPiXlw/x
         TRvmD1uvRzeXNqZ4pKF6p95J3TISo9yl933jcVSrdaFtJ8K43CQULHczvrjX3xO8yhIW
         IXjKOpm5ANVe9hG9c9JRcB4DOVr5wDpkyHx3crdQmpbGwg+pC8Lin8VeGNMyHKW19bEm
         X+5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzX54mJjE2RisplKR1jcSR9g5PXDkJsBwavcZmuidH/zbqtT527zzuvjwVkd32VEx4WSEXP5eU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/3TK/GILBHxKP6OPOY3gcPbkchF/4ZDUV3Q6GDFFkswNNGwik
	tbtTY6DZay2Gjd+i6du9zE3BSajLIHfRZ93CMzIFNLL5+A1VYJ5GmHe3
X-Gm-Gg: AYBFou07N75hKfTLPYysgicyQjp6XjFhj1BMcRfcGkRuUHnqC8wBEMnm42ZLkm0mY/p
	7RwvknTZotM5EF4wuDNqricqSVRRt04MD9xJ3W9kuWlxEaHYwHuxZbsfwaED21LKPXpJuwuCIVA
	i+Xb6MgYfdogf1OErtFKMu+v9YsVe4mxZSDIHUhxaDQ/riYhwsA6riqwlzBkYoyY/PiETriT6s8
	rNboBSrR7//wJ6S6I65KpoE2pi55tiq+bysYfpBahDxG1HTjzyn5oZgcr63XFgklSWaRyVEz6dd
	1nmwe2h2vxkseH3cI2EG2H0OYEFG95T2rK5MjRiqagXyOPvgvTNZJ44V5iSzreHAhNXv2L6rbnj
	Tbk6N/luxYROtdfha+WUD/YwXky59iygPw94byGyIojt5gARk6yGCCRZPLDYjwDPzeHAuQ6GVH7
	lLTxt70HjEHW3NUn2R2LiXPE72CBjBU299FVWpwIgji1r170IWTLfCftvdu6rIerApfxAdVwtKi
	o1qklPmJg2rmBVRTUBF5SuJN3SLE4GpDb3nVZa3esNmtIx04RxaGNLybFz9PwZ69TC7CKZ5YvQN
	nlv2OYxcmkSNTKT49qa+8P1YosZrTIKfUdMN2tDMyt3wDwI+ktW/yRFb/UvBBBE+AicyDVDF6zo
	XwhpVWoE1YznxKUX3FV2cpY6mLs1SQd0iCe2d3GzByB9J1Q==
X-Received: by 2002:a17:90b:524d:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3adeafddb1bmr8922396a91.4.1793013039674;
        Mon, 26 Oct 2026 04:10:39 -0700 (PDT)
Received: from esteban.tail1178e6.ts.net (132.20.31.150.dy.iij4u.or.jp. [150.31.20.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa82sm8023593a91.8.2026.10.26.04.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:10:39 -0700 (PDT)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	djrscally@gmail.com,
	dan.scally@ideasonboard.com,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Antoine Pichot <antoine.pichot@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] media: i2c: ov7251: Fix link frequency index
Date: Mon, 26 Oct 2026 20:10:26 +0900
Message-ID: <20261026111032.88355-2-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026111032.88355-1-antoine.pichot@gmail.com>
References: <20261026111032.88355-1-antoine.pichot@gmail.com>
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

ov7251_check_hwcfg() stores i, the index into the firmware's
link_frequencies array, in link_freq_idx, which the driver then uses to
index its own link_freq[], pixel_rates[] and pll1[] tables. The matching
driver entry is j. Store j.

Observed on a Surface Book 2, where ipu-bridge lists one link frequency,
319.2 MHz, which is link_freq[1]: V4L2_CID_LINK_FREQ reads 240000000,
and the pixel rate and PLL registers are off the same way.

Fixes: cc125aaa5a78 ("media: i2c: Provide ov7251_check_hwcfg()")
Cc: stable@vger.kernel.org
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
---
 drivers/media/i2c/ov7251.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index fce6344b51..1413f1856e 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1523,7 +1523,7 @@ static int ov7251_check_hwcfg(struct ov7251 *ov7251)
 		goto out_free_bus_cfg;
 	}
 
-	ov7251->link_freq_idx = i;
+	ov7251->link_freq_idx = j;
 
 out_free_bus_cfg:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
-- 
2.53.0


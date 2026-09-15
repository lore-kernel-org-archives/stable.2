Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED93090C6
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434422; cv=none; b=RHg/cF3SCNMwLKKEVYOXzGNF3NQiDVkYv82IJWZZ7zdyXqGqbfeIMmd90gQVcMWIo4gcPGOA7QrVUoiOJzdmDZ1JrlH3Wyr2Q4EuSqfKoAS9Y/vZtNW3ZYEscskjKGlEhKgeNG8gpXGdmMbVhAIhgdRgrxVnOcJmX7hydyw4VDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434422; c=relaxed/simple;
	bh=ar5w2bICKs61a2oJgBZNjiCTwG1evAr0pHP0ww9A13o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rH6MUTLNgE5Qw1eqsXY1lG0bQFp7EStRzwny5FiAsUG/1YGIPSoeu4GBBQVea+2zqUqo0uXZO8mnys2uWpbHMAnljxWzP05tGFmwCV8sPLucesrbVz2iZ+/JBRmGq8E7Pi7oaPYaHcE6rRactV/6R3i7rpgsSTAswdVrIAXAtKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLgQRNm+; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLgQRNm+"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76bcb1eso31416241cf.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434420; x=1790039220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0NSuQEoXQJcg9ajYYVwURRCgxkdaWdgI2zUIGcducQ=;
        b=iLgQRNm+U3GfvJtCiRIx1VZdz3bIywg9XvJqv3AddACwgrn/Pppnp6DEklMyqguGWa
         DVQKQUjyVuIfkNE1JjyNgAe7bGwCRigbHF5AzU8KspdkCQaehFu3fPQRZmUFDAFPHa95
         wHeOdvHu9D6DSPVNoE981qe+WbJouk0MeV3XlJgGXidZ1b74agscJwguv8YSafPg9P32
         QOa9wtZnAEKdKr27fclf5HdusxP+IT6dSXduVTF7k09o8BGbhZwPtP+vNvxEDAYqvWU6
         5VQV5ZXsZFiFDcqwWih1kP7nZrExQGt5ixeKZ2iNW+umytkxyZxL4cGgsMlatPdNSoV1
         rKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434420; x=1790039220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0NSuQEoXQJcg9ajYYVwURRCgxkdaWdgI2zUIGcducQ=;
        b=VnBHHKSBoBc4PkKEozaHkRzkFeDMlD2A4km1+LcHuZ0OWqvgjENvuxsapWbN/m6BlV
         h5c2JVqKMPR+//0WffWvUu+06bCweULOxYzBm+wbhBFFo7ZV1tx+ST7xiajS37c8oRqL
         dQCPHHCdDUsyyLf/zu6YCfu0mZidc7lBQmsTv4/mCw7/aQMUbxhhJPAuqlvWt7SAllEV
         Lv2ExV6cSU54Re50ASsNiU9mNm0VuDIGSU33Ee+kyVL9mp6CHnkKQp7bWQee1BDho1YM
         1NvDoIyNk5ic+tfditACiciaRkQ9z7tkU4CTLxvvefFzOPsmY/v7EMcyS8xyho9OvxEa
         TLqA==
X-Forwarded-Encrypted: i=1; AKwUvBxCrHUnnmQT9T/FTN0/oy6vPqjjClS0+2Kf1AuuSYSlm3I/X2h+DlPoQWuaP77kgkTQEi4CMsM=@vger.kernel.org
X-Gm-Message-State: AFuF++nb2PsX7nB3lBZh2cxdfNSS8mnpmET0RVRupcVj/U216htaNusH
	+0rih49D96B5RqUATDv5wbfKjUyrNKalaQaeAyqwCK4DmL35gAndjpw=
X-Gm-Gg: AYBFou0eACpiX+k0t7ye2MNHECR7BwpexGShZwdh1/Yjcjz74hagC/Gy/9sPAMtl9YZ
	Djj8SZAcFl9U8nyx1umPZuu8ynQp2amWQKzdq0HWJ4ewO+SYPIoaMqCijMAI4giArWDyeBzG3lg
	3uCYozHmoy8EAVeeISpncldt3Otqa8a/aNBufi9P7Tm7uCoTaFa9iyEdlKjBv+UA6mBmUPOUzLz
	p8K5UDn05jEmxWhYLqv4ZoSIZ5B2qazY0EKU9TSKQsKXDtdRZcL9gpGici25+J8uQvUVhs0khLp
	xxB86a24jeti11CezLouEJu6RLJz2W8MMmPxmQiRvfxdSlpNsee0PalPhOTofHYuYwKtXhCPc2N
	071tP8LHSlOdwVf4lTXw0eQQ8HGFCzYjYmSfifOz3acI3j+mBiAwk3DaUjRIRJVOYcXh44N/xg1
	yQ7VplLOGD4sead8JTlMkRcqKAq6WhgGROq5eWwGpI2D75aa2oI4r2DhQNJdav3FOmE2GyopOqr
	Fjy0zAfmHt40hX+t+T9LamNyKDw5qQOdaUV2+Dwiy/PIe3gDXxXojNIN3PEZG+dzfnFRxe6wMOL
	41gvgUSrpW6IRrq1fjvEjYU3AITyHcDXGGpfZGTv0SjqX6Vg59nInYQOQJXledU6VtZarfl4lcA
	Pf6dI
X-Received: by 2002:a05:622a:4c8:b0:530:8853:1be5 with SMTP id d75a77b69052e-5310cf0d3fbmr79307801cf.10.1789434415206;
        Mon, 14 Sep 2026 18:06:55 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47a5e5sm108327076d6.19.2026.09.14.18.06.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:06:54 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mtd: maps: pci: balance PCI enable on cleanup
Date: Mon, 14 Sep 2026 21:06:47 -0400
Message-ID: <20260915010647.54099-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtd_pci_probe() leaves the PCI device enabled on later probe failure and
mtd_pci_remove() does not disable it either. Use pcim_enable_device() to
release the enable reference after the existing map and region cleanup.

The imbalance is already present in the initial Git import.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/mtd/maps/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
--- a/drivers/mtd/maps/pci.c
+++ b/drivers/mtd/maps/pci.c
@@ -250,7 +250,7 @@
 	struct mtd_info *mtd = NULL;
 	int err;
 
-	err = pci_enable_device(dev);
+	err = pcim_enable_device(dev);
 	if (err)
 		goto out;
 

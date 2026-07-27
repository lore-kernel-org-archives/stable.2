Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3C3CCFC4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181856; cv=none; b=TAihkm5BkocCXWb+J1KIvBv0YL8NEppXZlMa6HcDcP0amVDv6KxT3AsOIFW2TBv3M4EqCGlp3IPtwSXo08A7Z424TI8/nOshO0eycSGbDqTLYtALYS6LUk1Mf5wk8RdHhi7efW56OdvlwNZpmXguqCccLkqmsHqC3NvyuLMjwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181856; c=relaxed/simple;
	bh=rs2WIBZzkqRCwsjBtX1X4LTczbabKnucj1w0vKsrAAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n418OC+EsaFvXtEe/ztAj1sOvCfuR73FyXHlL60HfJ07cFPAVvgr0vstHJPrsRQsVpMfKbA8mh2geAYFNhbF3WewwWFUdeVGeO2gSzZGH7SlNPGyZa47C50H3C6mRZI01K3b0m5Jc0rCb2GX9q8MQ1upqYXtJyjRezbZYT9NntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6CgDe8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6CgDe8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E8E1F00A3E;
	Mon, 27 Jul 2026 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181855;
	bh=2cMkN1XFkK2elDRgoqaVJlFZJ/cU6lEnx9A1xTzWSE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E6CgDe8ISujJp6hvbmbzkMJaHgsjGOMZEM27DX9k7NF2erjh5///mRLEYYs9dsBTE
	 LwgH9cEdOeb9qmAQniYGC/gXOMipedsKpwFJjiduv51Th/fkW1e6I16Owyxh2HzLKU
	 ZdGr0/IFdOTSPv5fiZVASxs1bKyrQy1bLDSs5PmqR44FpCllU2GmnOmEXtg4JX7hJ9
	 ZlN6LAyPdIOpQGx10kVXrfUkJTJljAPIY51E9sV2FlcidAhM07tEOCJRSFoa3NFqvE
	 dNsg4IXlL40v5e5pez/xFphUOTKhw2T9Y5AF2fdtHAezp445GB8kv75lTMnxA4Z3YW
	 WIDAEWXsHVWZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heinz Mauelshagen <heinzm@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] dm crypt: correct 'foo*' to 'foo *'
Date: Mon, 27 Jul 2026 15:50:48 -0400
Message-ID: <20260727195052.1774404-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727195052.1774404-1-sashal@kernel.org>
References: <2026072050-armless-fidelity-4a3f@gregkh>
 <20260727195052.1774404-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit ced6e475c3754dad3b63966d79f375d8f7193750 ]

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Stable-dep-of: edf025f08385 ("dm-integrity: don't increment hash_offset twice")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 57e662861c2e38..6a117d8669d655 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -990,20 +990,20 @@ static int crypt_iv_elephant(struct crypt_config *cc, struct dm_crypt_request *d
 	}
 
 	if (bio_data_dir(dmreq->ctx->bio_in) != WRITE) {
-		diffuser_disk_to_cpu((u32*)data_offset, cc->sector_size / sizeof(u32));
-		diffuser_b_decrypt((u32*)data_offset, cc->sector_size / sizeof(u32));
-		diffuser_a_decrypt((u32*)data_offset, cc->sector_size / sizeof(u32));
-		diffuser_cpu_to_disk((__le32*)data_offset, cc->sector_size / sizeof(u32));
+		diffuser_disk_to_cpu((u32 *)data_offset, cc->sector_size / sizeof(u32));
+		diffuser_b_decrypt((u32 *)data_offset, cc->sector_size / sizeof(u32));
+		diffuser_a_decrypt((u32 *)data_offset, cc->sector_size / sizeof(u32));
+		diffuser_cpu_to_disk((__le32 *)data_offset, cc->sector_size / sizeof(u32));
 	}
 
 	for (i = 0; i < (cc->sector_size / 32); i++)
 		crypto_xor(data_offset + i * 32, ks, 32);
 
 	if (bio_data_dir(dmreq->ctx->bio_in) == WRITE) {
-		diffuser_disk_to_cpu((u32*)data_offset, cc->sector_size / sizeof(u32));
-		diffuser_a_encrypt((u32*)data_offset, cc->sector_size / sizeof(u32));
-		diffuser_b_encrypt((u32*)data_offset, cc->sector_size / sizeof(u32));
-		diffuser_cpu_to_disk((__le32*)data_offset, cc->sector_size / sizeof(u32));
+		diffuser_disk_to_cpu((u32 *)data_offset, cc->sector_size / sizeof(u32));
+		diffuser_a_encrypt((u32 *)data_offset, cc->sector_size / sizeof(u32));
+		diffuser_b_encrypt((u32 *)data_offset, cc->sector_size / sizeof(u32));
+		diffuser_cpu_to_disk((__le32 *)data_offset, cc->sector_size / sizeof(u32));
 	}
 
 	kunmap_atomic(data);
@@ -1268,7 +1268,7 @@ static unsigned int *org_tag_of_dmreq(struct crypt_config *cc,
 {
 	u8 *ptr = iv_of_dmreq(cc, dmreq) + cc->iv_size +
 		  cc->iv_size + sizeof(uint64_t);
-	return (unsigned int*)ptr;
+	return (unsigned int *)ptr;
 }
 
 static void *tag_from_dmreq(struct crypt_config *cc,
-- 
2.53.0


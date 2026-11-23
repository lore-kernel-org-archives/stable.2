Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458742;
	b=oMiAq3ibf75U0ZTWtt4BzzUQ/mRT5QwLgvdMOPhnavLM4P/g/GpO4vDET9L4D9cnnEnE
	 etoMHcxjaY0btzd+4HAcgNC0cmEUiEXqncJIW+HHBejRgL6D+IN6UkXfK9MYnbQx3nxB5
	 jj/lfWz5eRFWL7XVni2/gC3q6LsYJTPaX2xteZlPnYLNiSFRkRRABf8zRbXFf4vIoxEWc
	 xVAbwtZffhvef6Boj8VOtQgy4SgXI35sLhv+hjS/1VgnVngGUy43YzwQuaQGwKRu94P0/
	 ut21iTZDK7bMSc9AlJ35NzxpqyEYM9/yFWOXWpny3X4NS33EniMMK7z3iSi4cu0BeDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458742;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=N3j0tMFhAaHpZ1oUDtj+e2ouvtQx8Dl5D+bVcC0aqr8=;
	b=5nTukzUv5V3OX7HfZiIJw+fwCxZefozHjeM4MthRaf5RSgT39YOuhW7e5ktfAxiABBo2
	 vJTrnuK8sigwChp5UYK/u4zXmuYd1yRGxfVLjVH7LOcp8aqFG3JwEk1Vgy/p+AgVg4pPo
	 CcG/xvN551oN4ZB5l07REqMzBwTgZV4I3+2EpbaeK+JMhchAQ1BX/fjeUJMOyrCcOzvDm
	 RkWE+8+W97EKmpN3oMCag7POJBvAVSFjzMj+ZaBOGJTAdPp50VG6sexRa1q2tYpo0HVwN
	 Ui4Cf15/sqWXOiJVYoBW7M/Wi9eGGc/NVj4qeC9aeqrww3LRL0nVUgtAfc7bnc63B/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUsq0Isu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADA606A31A;
	Mon, 23 Nov 2026 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUsq0Isu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDACB1F000D0;
	Mon, 23 Nov 2026 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458742;
	bh=N3j0tMFhAaHpZ1oUDtj+e2ouvtQx8Dl5D+bVcC0aqr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUsq0Isu+TTIX6CBirD4XJ+gqjnwzZkTSyy/NtnhlI1Q9YlOY/lhySvARFcnG/Nso
	 SZsFBFMKSYHGYaqJkO+89X8mVuq+jDjDfu/FxKTG6F9+swdFEe40TfVk0U/XI7UzPn
	 HRH0nhrgUr+zNNzY5lSu5c2O2t36H5/TrY0Jm7FqFZ86jEleDHG7Uqaou8iFISgKhk
	 5d8n+9J7mHKA2v8BZcKhewK2bqxHgpQW0cQePEckrTenTo4Vpxv0oS3Q34vVpJSiM0
	 pV+TonIqNSNeiTOt22dPCnhcZPXGqf41+WCe6ZZOtJl3Tmp7JQV2um0/O9Op2rrYsZ
	 h+WkrF+TMHq+w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dudley Du <dudl@cypress.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] Input: cyapa - validate firmware image size in cyapa_pip_check_fw()
Date: Mon, 23 Nov 2026 18:31:08 +0000
Message-ID: <20261123183200.3900004-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cyapa_pip_check_fw() parses the firmware header, the trailing
application integrity record, and the application rows without verifying
that the supplied firmware buffer is large enough to hold them.

A truncated firmware image smaller than struct cyapa_tsg_bin_image_head
causes an out-of-bounds read in cyapa_pip_fw_head_check() and can
underflow the unsigned size subtraction in
cyapa_get_image_record_data_num().  An image containing a valid header
but zero complete flash records causes image_records[flash_records_count
- 1] to read before the start of fw->data.  Finally, an image whose
metadata specifies an app_len exceeding the available application
records reads past the end of fw->data while computing app_crc.

Validate the header size, ensure at least one flash record is present,
and bound the application row count against the non-integrity record
count before dereferencing image_records.

Fixes: 5812d3067294 ("Input: cyapa - add gen5 trackpad firmware update support")
Closes: https://sashiko.dev/#/bug/linux-cc76de59-950f-4e64-b49e-7605164e02a9
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/mouse/cyapa_gen5.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 59f6e97d5482..bce8104f4149 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -1249,6 +1249,11 @@ int cyapa_pip_check_fw(struct cyapa *cyapa, const struct firmware *fw)
 	u16 app_integrity_crc;
 	int i;
 
+	if (fw->size < sizeof(struct cyapa_tsg_bin_image_head)) {
+		dev_err(dev, "%s: firmware image is too small.\n", __func__);
+		return -EINVAL;
+	}
+
 	/* Verify the firmware image not miss-used for Gen5 and Gen6. */
 	if (cyapa_pip_fw_head_check(cyapa,
 		(struct cyapa_tsg_bin_image_head *)fw->data)) {
@@ -1259,6 +1264,11 @@ int cyapa_pip_check_fw(struct cyapa *cyapa, const struct firmware *fw)
 
 	image_records =
 		cyapa_get_image_record_data_num(fw, &flash_records_count);
+	if (flash_records_count <= 0) {
+		dev_err(dev, "%s: firmware image has no flash records.\n",
+			__func__);
+		return -EINVAL;
+	}
 
 	/*
 	 * APP_INTEGRITY row is always the last row block,
@@ -1295,6 +1305,11 @@ int cyapa_pip_check_fw(struct cyapa *cyapa, const struct firmware *fw)
 		return -EINVAL;
 	}
 
+	if (fw_app_len / CYAPA_TSG_FW_ROW_SIZE > flash_records_count - 1) {
+		dev_err(dev, "%s: invalid firmware app length.\n", __func__);
+		return -EINVAL;
+	}
+
 	/* Verify application image CRC. */
 	app_crc = 0xffffU;
 	for (i = 0; i < fw_app_len / CYAPA_TSG_FW_ROW_SIZE; i++) {
-- 
2.56.1.750.gf70dc682cf-goog


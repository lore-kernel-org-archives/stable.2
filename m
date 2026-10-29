Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262665;
	b=xgsOohjMc7EOIbzFA/PIC+WCt0X5OSfPX1MEYHiwS/GgmgjA1Z/HH/D3DXGnL1bJ+jqj
	 MJrTFZm3ZSYvq52SVaDdwcCFOe8zCKpisrelSf/WSxSX9RFr4LSsC/HVw3PMmWLWEwQv0
	 LOjZRVhPa9vD1BOMagVJRUdgCUuoEtQAwA+lzmRk+O7d6n6tBiKQfESFpish6asVn/yzD
	 vDJLbJPImz2VhM4xiDpp49cmsb6VYEh7kjQKnC34tKYFuvpfcp6U+cxiwh5Fdt2lj5qz3
	 2I2Sho8ptZKA3Zq+KRN+JBTvlGvEO534XWCWHjX8Jobm7K5ewQpMoDV90u83hiUmOzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262665;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wSx9wCcjJKvOn/7c6bUYnvLr92t6bdv4PcrFzzJjwD0=;
	b=c2iVZR+OPzn3zFGl8fLzrS/r2e+V76YHKNgttIjHPDeaj7ovuOWtRnqQQAapamZltE1m
	 PQQgu8FKtP0Q4TPzHM7o0Tr/xJffwq/HbOe8XWFe3djV94IbIWQWvdtP7Ffia2E1THbC/
	 QYzt5RSuQ1D0K01YtaoFfOT+FWLBJIShWJWqZqqYBcZtRDjaQGRvSMzGgWaiFZalaTiTG
	 WKIu+f1tZld71oBe27aA74P1u4suCuedqrTuvZtZwyUMqVk/FPXE43tKtXrlayDVzDPA7
	 suZrjg4NdoIpdWMLlDVBMW3Ha/Yxh+Qe3U9BWntFJepHzQL0i4gD0NIqy3/kcW+1dFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=a3kfMKr5;
	arc=none smtp.remote-ip=115.124.28.100
Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112B606A31E;
	Thu, 29 Oct 2026 08:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A112B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=a3kfMKr5
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793262661; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wSx9wCcjJKvOn/7c6bUYnvLr92t6bdv4PcrFzzJjwD0=;
	b=a3kfMKr5P5D8V+YGv4YRFJaVEheO+avCzAISNp8yn7u64Gv1EyAFS0KXTUCNGUo3So5ivGblL+5BQQAD5NrTxYrX4CdSI8EdKp7F7Ie8ClBd7byZ4xrChy6LIuT4giSAmdJ9vh3Vcd0YQnUAM/e3W7w3187Mi0cJsZZPb+fOegI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.8749246|0.1059115;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.0833209-0.0015473-0.915132;FP=14879031229243279073|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jsHP3Mw_1793262659;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jsHP3Mw_1793262659 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 16:31:00 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: hverkuil@kernel.org
Cc: mchehab@kernel.org,
	niklas.soderlund+renesas@ragnatech.se,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: adv7604: fix out-of-bounds access with a one-block EDID
Date: Thu, 29 Oct 2026 16:30:59 +0800
Message-ID: <20261029083059.546070-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

When VIDIOC_S_EDID is called with a one-block EDID (no CTA extension
block, hence no Source Physical Address), v4l2_get_edid_phys_addr()
leaves spa_loc at 0. The fallback path then sets spa_loc to 128 and
reads edid->edid[128] and edid->edid[129], 2 bytes past the end of
the 128-byte kernel buffer that check_array_args() allocated for the
EDID data. The physical address is subsequently written back at the
same out-of-bounds location, so this is both a 2-byte out-of-bounds
read and write of kernel heap memory.

This regressed when support for EDIDs up to 4 blocks was added:
commit 54b74981c86c ("media: adv7604: writing a one-block EDID
failed") carefully handled the one-block case, but the fallback that
was added six days later undid that protection again.

Only take the spa_loc = 128 fallback if a second block exists, and
only write the physical address back into the EDID if a SPA location
was found. This restores the one-block behavior of 54b74981c86c.

Fixes: c730ff32b917 ("media: adv7604: support EDIDs up to 4 blocks")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---

Triggering this requires nothing more than a VIDIOC_S_EDID call with a
single-block EDID on a subdev node, i.e. the most basic EDID a
userspace application can pass.

Verified by an ASAN-based userspace reproduction of the
check_array_args()/adv76xx_set_edid() path (kmalloc(128) buffer,
blocks=1, no SPA):

    ERROR: AddressSanitizer: heap-buffer-overflow
    READ of size 1 ... 0 bytes to the right of 128-byte region

With this fix applied the reproduction is clean. No regressions for
multi-block EDIDs containing a SPA: the spa_loc != 0 paths are
unchanged.

 drivers/media/i2c/adv7604.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index ac9c69ce438f..c007ac0bd8e5 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -2358,7 +2358,7 @@ static int adv76xx_set_edid(struct v4l2_subdev *sd, struct v4l2_edid *edid)
 	if (err)
 		return err;
 
-	if (!spa_loc) {
+	if (!spa_loc && edid->blocks > 1) {
 		/*
 		 * There is no SPA, so just set spa_loc to 128 and pa to whatever
 		 * data is there.
@@ -2404,8 +2404,10 @@ static int adv76xx_set_edid(struct v4l2_subdev *sd, struct v4l2_edid *edid)
 				  mask, (spa_loc & 0x100) ? mask : 0);
 	}
 
-	edid->edid[spa_loc] = state->spa_port_a[0];
-	edid->edid[spa_loc + 1] = state->spa_port_a[1];
+	if (spa_loc) {
+		edid->edid[spa_loc] = state->spa_port_a[0];
+		edid->edid[spa_loc + 1] = state->spa_port_a[1];
+	}
 
 	memcpy(state->edid.edid, edid->edid, 128 * edid->blocks);
 	state->edid.blocks = edid->blocks;
-- 
2.50.1


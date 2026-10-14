Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDB25B2F4
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938568; cv=none; b=hXb/bLRZ/icxdKB+94oAVb8CPiZvGxsg2Ul/GJJ7QHap4+XoFwbJ5dJSWIsHxhT1+fZWa4sqrA2WGRfVQU16tPhNJkv7OSaIO2YR5Plam2/CVAoLi+MuydxhaUOOh2W6wmSVXo7MXPAQC1jQGSeQuT7/6QOzea1t/Fm7gZ/FQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938568; c=relaxed/simple;
	bh=7HcUK1CTNpahJarcDRW/PNLN4S+XdFX5l+dOxrBeiwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4LjnEk7GPl9CxTi+G/oSw/JmdUamfRFrcM4hpcNtCxKlvBpSgMFHS5WDI+46W3t3zqoBSln8oRmBu1lJyiEm9grqyWHxyeeYFc40Wb0IvXw1siYHSuKKHFZxbzogzmNv514UeA6FcWQ9+/O5PNCW7fuTGL9XJmvf9N3A3RE6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=B/a1jyGC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="B/a1jyGC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-88aea027391so1725343b3a.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791938564; x=1792543364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LySGsEgkXXlREpE9ITg3+XAbVmPqYYJKWOIEOpJmtB0=;
        b=B/a1jyGC4kVqHhRUO62V4xQnJGh7D370CWqXbo26VH8KINX0odsXelgLHAWTvg1w0T
         7p/Uj8QVg5/OWyySWbNzqhXZVhFlXQ6BlnGyPPtqn+MQDDbO3enLWtw+l+FxGLkW9gZD
         b3TxHsY0PA8M7qal8Gsn7Sc9ckaVeL8CMvsa4sQrmBvJMWBTsGJL8Qgaqlbdq5tf1LSA
         40+YHdeMxpf0azPX67qLMUKtIHjLUt97vJ2CMIaqi7SbeCzlXIa1RR+9062Duobtvy9f
         KstNdc0AzWj+qMr2tyOlE9OVACYplyEnRL2YTJ36TrubogogBFEY5F1nfivOEwqXj7Yq
         f3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791938564; x=1792543364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LySGsEgkXXlREpE9ITg3+XAbVmPqYYJKWOIEOpJmtB0=;
        b=FKp7ZNhOQoT7mQu0bqdDuz3dwL8uDovXT03bw8z3m+Re+O+G4KR96Sj9usMUKO1RZX
         1U0w8xaFWfpTyam4I5hEpXBL4lmZaM48XfO/8gTdJEjXAwO9sdGytzacvnM7GqgH2Y3n
         GwFdeP8sl7Le8XRT3jpOehMNQljua0rZ0YxG1Dm9ueCpusqCA3vtCf0xGqLgtG6qs1Bz
         r/BCUji1PsBk0liaM0bPaAmpBPm540TaLEZ34x7KFS/nWa7ju56Wxr4gdnoArcX3ugad
         e8IW4obeynZkRD5zIIJ3+Cs5NHADpec1xwUJgadxCK8S9XPYHawBAPjAn1F2ZUEU3KhU
         c9UA==
X-Forwarded-Encrypted: i=1; AKwUvBz4M8eEPFUZvt1xI9kkFWpi1YpxjzXoa9hzZDPWpIhXuc7ozjjhmMPaM/dVxvbqxtKiH64VtKA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNqQYfQU5iWI3crI+exarKDK93iLzfXLd4OQQZFhdgVryacg2x
	ruUJYh7yDrEFQfKRvNRZkGw984nLpSdmY/RmUPLayzvgbkvZg709Q4cvdy3lbqSlF+46uR7dqfT
	+2VxU
X-Gm-Gg: AYBFou3zj5rCtswOr1oc78g2ab28uzIjIkXkCKCpGXL7tJux9lqAwWGLbQqoLh/TEVb
	b3YV0YOQ1aL18DF0JHI1eTOqwgTmBU6YLWKxeDCgdIHvTy3YTvEGgqFl//INWctpAir0OiVwT3h
	MeeN95CVv502MrH1KZkRo6biHPIyvMN8TxNKQDNkNv1GyTv6jSGdzyGDVnaak8qG5b6SeoO+1/s
	l/VFfT5/Z+YKy1jPG0sKd7iiKfFIi4U+6tFPevSugiRt7xP7IZAptXlVq410umaqnFrF3BXUGPz
	kuyw808QwHvdKqaxwOzsNCSQOpzfxHhsqyN865L49+skTozxOWyunPvromp4qrUh/5IOkbSLYHr
	iG5Ti3ka9qqkBjKeVRHb/wYTwG/W9MCrtNbSBYML5QjYg/1hPfZW1ePMz4mhYIGYbaDdhzaZ+c/
	qQ/6IJ3Ntc7QjyZ0ulghulqepNcJcpvzS/sNSYRdXROYInKspP50ls/M+GFy5+/8wv+EzsF122Y
	asRiHJjJzH37Bj65AXsNg==
X-Received: by 2002:a17:90b:28ce:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3ab3a79df67mr12125184a91.29.1791938563588;
        Tue, 13 Oct 2026 17:42:43 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac7321cc5bsm432716a91.14.2026.10.13.17.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:42:43 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH] scsi: mvumi: reject handshake sizes that overflow the list allocations
Date: Wed, 14 Oct 2026 09:42:25 +0900
Message-ID: <20261014004226.3469868-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_hs_process_page() takes max_io, the two command entry sizes and the
list depth from the firmware handshake page.  The entry sizes are u8 fields
used as shift counts, and 1 is an int, so a count of 29 or more makes the
<< 2 applied to the shift overflow an int; a count of 32 or more is
undefined outright.  max_io is a u16, and the sizes derived from the shifts
are multiplied by it in mvumi_init_data() to size three unsigned int
allocations, so a large entry size wraps the product and the loops that
follow then walk and write past the short allocation.  The list depth is
used as a shift count too, but only when the firmware sets
HS_CAPABILITY_NEW_PAGE_IO_DEPTH_DEF; a count of 32 or more is undefined
there as well.

Reject an entry size above 29, which keeps 1U << n and the shift that
follows it inside an unsigned int.  Then compute the worst-case allocation
size in size_t at the top of mvumi_init_data() and reject it if it does not
fit an unsigned int.  That total bounds all three allocations: the inbound
list total, the outbound data pool and the tag arrays, whose sizes are the
same products plus smaller terms.  Reject a list depth of 32 or more on the
shifted path only, so that the plain assignment a few lines above, which
takes the depth as a count rather than an exponent, keeps accepting every
value a u8 can hold.  The shifts also use 1U now so that a legal count
cannot overflow an int.

No realistic controller is rejected: a controller reporting 4096 commands
with 64 KiB entries and a depth of 12 needs 513 MiB and passes unchanged.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index e70d336b4ab39..b86d954f3576b 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -912,10 +912,23 @@ static int mvumi_init_data(struct mvumi_hba *mhba)
 	unsigned int tmp_size, offset, i;
 	void *virmem, *v;
 	dma_addr_t p;
+	size_t total;
 
 	if (mhba->fw_flag & MVUMI_FW_ALLOC)
 		return 0;
 
+	/* These are firmware-supplied and size the allocations below. */
+	total = (size_t)mhba->ib_max_size * mhba->max_io +
+		(size_t)mhba->ob_max_size * mhba->max_io +
+		sizeof(struct mvumi_dyn_list_entry) * (size_t)mhba->max_io +
+		160;
+	if (total > UINT_MAX) {
+		dev_err(&mhba->pdev->dev,
+			"handshake sizes too large: io %u, in %u, out %u\n",
+			mhba->max_io, mhba->ib_max_size, mhba->ob_max_size);
+		return -1;
+	}
+
 	tmp_size = mhba->ib_max_size * mhba->max_io;
 	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC)
 		tmp_size += sizeof(struct mvumi_dyn_list_entry) * mhba->max_io;
@@ -1051,16 +1064,24 @@ static int mvumi_hs_process_page(struct mvumi_hba *mhba,
 	case HS_PAGE_FIRM_CAP:
 		hs_page1 = (struct mvumi_hs_page1 *) hs_header;
 
+		/* Firmware-supplied shift counts: (1U << n) << 2 must fit. */
+		if (hs_page1->cl_in_max_entry_size > 29 ||
+		    hs_page1->cl_out_max_entry_size > 29) {
+			dev_err(&mhba->pdev->dev,
+				"invalid handshake entry size\n");
+			return -1;
+		}
+
 		mhba->max_io = hs_page1->max_io_support;
 		mhba->list_num_io = hs_page1->cl_inout_list_depth;
 		mhba->max_transfer_size = hs_page1->max_transfer_size;
 		mhba->max_target_id = hs_page1->max_devices_support;
 		mhba->hba_capability = hs_page1->capability;
 		mhba->ib_max_size_setting = hs_page1->cl_in_max_entry_size;
-		mhba->ib_max_size = (1 << hs_page1->cl_in_max_entry_size) << 2;
+		mhba->ib_max_size = (1U << hs_page1->cl_in_max_entry_size) << 2;
 
 		mhba->ob_max_size_setting = hs_page1->cl_out_max_entry_size;
-		mhba->ob_max_size = (1 << hs_page1->cl_out_max_entry_size) << 2;
+		mhba->ob_max_size = (1U << hs_page1->cl_out_max_entry_size) << 2;
 
 		dev_dbg(&mhba->pdev->dev, "FW version:%d\n",
 						hs_page1->fw_ver.ver_build);
@@ -1069,8 +1090,14 @@ static int mvumi_hs_process_page(struct mvumi_hba *mhba,
 			mhba->eot_flag = 22;
 		else
 			mhba->eot_flag = 27;
-		if (mhba->hba_capability & HS_CAPABILITY_NEW_PAGE_IO_DEPTH_DEF)
-			mhba->list_num_io = 1 << hs_page1->cl_inout_list_depth;
+		if (mhba->hba_capability & HS_CAPABILITY_NEW_PAGE_IO_DEPTH_DEF) {
+			if (hs_page1->cl_inout_list_depth >= 32) {
+				dev_err(&mhba->pdev->dev,
+					"invalid handshake list depth\n");
+				return -1;
+			}
+			mhba->list_num_io = 1U << hs_page1->cl_inout_list_depth;
+		}
 		break;
 	default:
 		dev_err(&mhba->pdev->dev, "handshake: page code error\n");

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0


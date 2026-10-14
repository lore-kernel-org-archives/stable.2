Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FA288D0
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791940706; cv=none; b=mBhI2TKDIzDMJvUrV68Gr2bQGKmPDSuHGhWDK/sXiJOtLrZnWr6Gqn+nX3L4V1FKIfijlVGVN0FJTpVTd6KKYdDH/qqs2tgg1PmXzbM6nuuz+Bx2aJ1IG2bwbl8EnJ/AU1H40cgd3OBYYiYnimTBAQaSFYIS16DMsoPbUFx3ipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791940706; c=relaxed/simple;
	bh=JNttwEjgy5z4n6HzQBDVYpWxW1uUfRClvv2Tgp2w09o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/fH5KX+PWkk2OoNnvtV0zd0dso43hw5PTBuse5kkgDLQPGoL95gqr2Bk9bqDTxJS04/EyBLP+AgCQEODXj5fo5dN++AiNnGdCVzOfH+k1mHWC6Nq79iso+p9o1e+G+pDwsseQWSdYml+cvR9HXtP6/fquOLV+dF3o5vAZGynqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=VszaL9K1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="VszaL9K1"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so2937134a91.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791940703; x=1792545503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Z2WQcUySBwN042YBIoxAnN3IuR9gqDhYBmuGU28Wu4=;
        b=VszaL9K1yE1I7Tf9zapShSrVWjOIn6C9gXSLGeHmpRIBeB8ButH2Ne/yCb32UwsPJp
         lVssBuWPl0XcM25e8ZXrCpO70O8lOP43wdwVnkB1pnpUA4a+f+SfXmMYBlGRXKMlYhzg
         UGrvA9WOjCUxipkvFdXamkRAcaukV9i7rZNY7U523v143szfaaTHkE1GEu9V63zugerU
         bzsmQed7jafODZrGNI1Y3MKIkmfIUUn0lde7HzKjJO37mOQztf5+6wyTEpwXkbHojrm4
         ugUP8dEV+7jAJ534VOU326WUGgzQpTvnJE1gABK1vXGpSL3dXInoXEUZ6tGOTJZkMMUg
         yNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791940703; x=1792545503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Z2WQcUySBwN042YBIoxAnN3IuR9gqDhYBmuGU28Wu4=;
        b=qKE6Aq34RnxBXW/b0y/pxMYeK/Ixh4FelICWjvHN0wHqgS0KqUTJIzHr6NsOmAQrhG
         JFru203iJu5rVyoackd6G6WXIXX93lZmQYt3mOuGPe+4ZUDlHPrkIr1iiAGPa8e7f66W
         o7pDOL1k/FVMg/VTRPgvXoMXf1wzVdSFIAlvesdBXyP4/7MErKEc8+a9Fvvd7+RgfOWq
         0owo9nQ6eCh2n+OXoHf02Vv4tj4pwiSnlIK1y9yUu+yFNE5/FEW9luX9Te6nTUwh5Y2k
         OsR+48JirtiyEuJfM1yI8ZEAnxmUyE3YjcWkuCr3S/4kqvxdPj+mKx8ljyu1h1Si6v8X
         mb5g==
X-Forwarded-Encrypted: i=1; AKwUvBz2Zaq53CFLguBh27KpoL2XoccstlFjOyOq9jwfxWtlTbSvENcBdVTD0vYB38sYIjKgiJ0ca2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaZIwZ4xO0ABl22R49Zx5drLTLtShHoF86vniaFm2HVYhgxmBB
	3KsUJS/FiWo2OSQtThHifzC4uNXZ8rAPbXbNsyAHNhZ1XSfMGC7CK+fntMZ+B/Lanj4=
X-Gm-Gg: AYBFou26g3hHHQj03x8/P95eTt9oauhOpCmJQwWQMIYOx/D05T9PFmRavqV0hijctf4
	Af/9ndjeFZjP6uXixJ7rjWWxrGGWYKOMlpPI5EFz+oJWDmZ6g65GLPO8DkocWtDukPpBSq0VJVG
	EEcjFZKJyUgTVchmsO+feqq7ndS64nysRqWoWJ+7Rp5pHXa5N1nOXPIydehNACTNsqx6RvG5d6P
	rB5yLOw3xpzgSsXkGcCL5BCrh7W1z64Wk3zvo8nQHTZCnqSkPz5PK+X2ub8giIxm3suFdwTdRpi
	i6/eLBcQLrCDfbwx9bTbhS8a3Pfj6AuAAWnO32mYk+7bp/z/phqdE7fxnyCkXx3nvh6A7oJmbQF
	gtcfxxzKoVBQm5fn83691Vh7t4Bri5u4rcPJ0aRYHBB/KNUTPeKRGhRvuw3n4sZzcER7XJoN7GH
	H9JaRIJUEdtvNQs+YNnJ4wElU1/iVSyWLBa2pAl2LDHpk0DIJzxsuFYe0nonJ4mj2GsaQkPinKV
	FngjTBm+3Y4aAjsiB5j
X-Received: by 2002:a17:90b:3c04:b0:3ab:39e5:6268 with SMTP id 98e67ed59e1d1-3ab3a92f39fmr12335751a91.53.1791940703089;
        Tue, 13 Oct 2026 18:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac684c7cb3sm532763a91.3.2026.10.13.18.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 18:18:22 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2] scsi: mvumi: reject handshake sizes that overflow the list allocations
Date: Wed, 14 Oct 2026 10:18:08 +0900
Message-ID: <20261014011808.3479480-1-yhlee@isslab.korea.ac.kr>
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
there as well.  The depth also sets how many entries the inbound and
outbound rings hold, and the per-command slot index wraps on that count
while the rings are allocated for max_io entries, so a depth yielding more
entries than max_io -- or none -- walks the index past them.

Reject an entry size above 29, which keeps 1U << n and the shift that
follows it inside an unsigned int.  Then compute the worst-case allocation
size in u64 at the top of mvumi_init_data() and reject it if it does not
fit an unsigned int.  That total bounds all three allocations: the inbound
list total, the outbound data pool and the tag arrays, whose sizes are the
same products plus smaller terms.  Reject a list depth of 32 or more on the
shifted path so the shift stays defined, and reject a resulting entry count
that is zero or above max_io so the slot index cannot walk past the rings.
The shifts also use 1U now so that a legal count cannot overflow an int.

No realistic controller is rejected: a controller reporting 4096 commands
with 64 KiB entries and a depth of 12 needs 513 MiB and passes unchanged.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2:
- compute the allocation total in u64 so the check also holds on 32-bit
  (Sashiko).
- reject a handshake list depth whose entry count exceeds max_io, which
  would walk the per-command ring past its allocation (Sashiko).
 drivers/scsi/mvumi.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index e70d336b4ab39..e9ba072220331 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -912,10 +912,23 @@ static int mvumi_init_data(struct mvumi_hba *mhba)
 	unsigned int tmp_size, offset, i;
 	void *virmem, *v;
 	dma_addr_t p;
+	u64 total;
 
 	if (mhba->fw_flag & MVUMI_FW_ALLOC)
 		return 0;
 
+	/* These are firmware-supplied and size the allocations below. */
+	total = (u64)mhba->ib_max_size * mhba->max_io +
+		(u64)mhba->ob_max_size * mhba->max_io +
+		sizeof(struct mvumi_dyn_list_entry) * (u64)mhba->max_io +
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
@@ -1069,8 +1090,22 @@ static int mvumi_hs_process_page(struct mvumi_hba *mhba,
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
+		/* The rings hold max_io entries but the index wraps on list_num_io. */
+		if (mhba->list_num_io == 0 ||
+		    mhba->list_num_io > mhba->max_io) {
+			dev_err(&mhba->pdev->dev,
+				"invalid handshake list depth: %u entries for %u commands\n",
+				mhba->list_num_io, mhba->max_io);
+			return -1;
+		}
 		break;
 	default:
 		dev_err(&mhba->pdev->dev, "handshake: page code error\n");

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0


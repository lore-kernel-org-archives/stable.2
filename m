Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F926ED3E;
	Tue, 11 Aug 2026 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414560; cv=none; b=O2X4UA2AvSjfe/owVgVCRHBv1tlKupGo/7DPBDYsou/+5pxZNSK2rjE5e6R0yyDNkavrWodMUJJ5g6+NUCIyL93u3IUzPO9Iegmx5a4eg/WJ43my+OfTR47WRxwO3MrGZ2YD1mK8tAX9teUi0MfL4m/SU/EFzZolnHJqGE/M7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414560; c=relaxed/simple;
	bh=sTe+XpyhJzMWfTNhvWfFNAL6pCP89RRwpvH6J10fqRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EJuX7fiy9MGQjk07/r3xaZBvdIHY/CTLKKMAEQL3K8o99C6zrzwrJgEJYS+Ukur01yHfqtbWD97vxy5xGMAGkwoiN8Eym0YaoRKhurouqJG6wWj2Lfaz9jXOBTLAky3TWBbGH42uv0uRIciRQ7LTEk/PHu9XR1r9vzK7tYN3VG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 93da974c952a11f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:219899ee-5547-4ea3-953e-39053f9ff749,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:3fe5d8582adcfcb05c23e364a984aed9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 93da974c952a11f1aa26b74ffac11d73-20260811
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 391263554; Tue, 11 Aug 2026 10:15:52 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com,
	hexlabsecurity@proton.me
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: verify run length exceeding volume boundary
Date: Tue, 11 Aug 2026 10:15:48 +0800
Message-Id: <20260811021548.15328-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mapping pairs decoder validates that the starting LCN is within the
volume but does not check if the run extends beyond the volume boundary.

A malformed NTFS image with a crafted mapping pairs array could cause
the kernel to access memory beyond the volume boundary, potentially leading
to memory corruption and privilege escalation.

Add validation to ensure lcn + length stays within nr_clusters.

Cc: stable@vger.kernel.org
Fixes: b4be3a47f8ba4 ("ntfs: bound the free-cluster bitmap scan to the volume")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/runlist.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 17eb275a21ff..9eaadbc0ef47 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -897,6 +897,28 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
 				goto err_out;
 			}
 
+			if (lcn >= 0) {
+				s64 run_end;
+
+				/*
+				 * Ensure that the run stays within the volume.
+				 * A valid starting LCN is not sufficient because
+				 * the run length comes from disk.
+				 */
+				if (unlikely(check_add_overflow(lcn,
+						rl[rlpos].length,
+						&run_end))) {
+					ntfs_error(vol->sb,
+							"Run length overflow in mapping pairs array.");
+					goto err_out;
+				}
+				if (unlikely(run_end > (s64)vol->nr_clusters)) {
+					ntfs_error(vol->sb,
+							"Run extends beyond volume boundary.");
+					goto err_out;
+				}
+			}
+
 			/* chkdsk accepts zero-sized runs only for holes */
 			if ((lcn != -1) && !rl[rlpos].length) {
 				ntfs_error(vol->sb,
-- 
2.25.1


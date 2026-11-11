Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407254;
	b=NDEfNIlSzGlEvjalnse+RmORNUTzQdZ6F+FZ35DYBb0/RX1PSGCJsJGWR1Vk/iy/JZ4+
	 MamkegaasRojKNwLUIZIQ5C51IKgcqawYIOq1KwgHNNjIQD/Ky8TLlMF7L64nO82PuGi0
	 2VLTvPC4zvpvS3lmBjbf20jAL5gXFC4j64B6McFl+ypPaqEIZqvxZMLRd22cJXH9eSmte
	 a1wDdXT6jnA21fEzFU5YoOD70j3SEcPIY2FyFVpPQo+RN91BKs218B7i4RcyTQ2o2oGt5
	 ncYbMDkj4mBZKBe9puO4ZUwf0yI/vqGCvG4Mq0TIFnzo8+lW/+JFvR8RIkRkR5fCSbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407254;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=5OdqLlXVofYhgXwfpFpn5S7e9rSwH2M7lMV1Hw+hRww=;
	b=v0mc6JUowWFU7ApEqCovD/3YiOwhiJSoDBaFpxB3zMaQHodulwScsPB0HTv5STtM8QkV
	 vlH820dOeOa0Yy/m346AsUgG5Umq/cfmsbNhV/gR9LDV2hJ3VlJZFr6nSwymqLU0zhYAo
	 GXdnGEzPkuZit8ruvS5OjN85GcgCPKiJvq4rrq069Fw5GbPSPWPBs6tRo8Ioohmmfd5Lp
	 gRz3s7jSYcJ++eCInmTTQHIut5Tr4/DFmxlVmXAekCkkgB++olD77yzgpYQNZDjNQlKe/
	 J/kcd7gKDxC7H6wrjHE0AfP4qljRf70hhoS2j5R2dvO+tSCk7eFBALFlK3MbEGUZFsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="NS/DzVdQ";
	arc=none smtp.remote-ip=91.218.175.153
Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A2606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A38A2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NS/DzVdQ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n7dKz5VV++RbTugrK9P7KhSNMntn2iLxBmjeZLHK0hc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794407249; v=1; x=1795012049;
 b=NS/DzVdQwYZFY/k5KQ10KPQXnEMR4Pn8/ahwNhVmUu1OPjeb+kPJD2ktdQqY8+MpRfB6WPBK
 0qn4vozFmRQCSymeuoJIMHKwhU7aQGLqBuIWS3rrX4d92UvY5+zUHIxNTQfVhWajtskSFLbQ6Aw
 5Z4WpFSCrPcxrSWdkp5Wx4Rc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2f1b5625be9d2d26;
	Wed, 11 Nov 2026 14:27:29 +0000
X-Mizu-Trace-ID: 2f1b5625be9d2d26
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Wed, 11 Nov 2026 09:27:19 -0500
Subject: [PATCH] scsi: target: alua: Hold tg_pt_gp_lock across the RTPG
 size check
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-bug-target-rtpg-oob-v1-1-1c6b9cfb6831@linux.dev>
X-B4-Tracking: v=1; b=H4sIAEZ79GoC/x3MMQqAMAxA0atIZgNNh4peRRxajTWLlbSKIN7d4
 viG/x/IrMIZhuYB5UuypL2C2gbmze+RUZZqsMY6IjIYzojFa+SCWo6IKQV0biEfjO3s3EMtD+V
 V7v86Tu/7AVymkullAAAA
To: "Martin K. Petersen" <mkp@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

target_emulate_report_target_port_groups() checks that each target port
group, with one descriptor per member port, fits in the allocation
length, and then writes a descriptor for every LUN on the group's list.

The size check reads tg_pt_gp_members without tg_pt_gp_lock, which is
only taken for the list walk. A LUN attached to the group in between,
e.g. by a LUN created through configfs, adds a port the check did not
account for, and its descriptor can be written past cmd->data_length.

Take tg_pt_gp_lock before the size check, so that the member count and
the list walked stay in sync.

Fixes: 6b20fa9aaf0c2 ("target: Fix REPORT TARGET PORT GROUPS handling with small allocation length")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/target/target_core_alua.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 140154d93c430..c9413e67b7f3f 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -166,9 +166,17 @@ target_emulate_report_target_port_groups(struct se_cmd *cmd)
 	spin_lock(&dev->t10_alua.tg_pt_gps_lock);
 	list_for_each_entry(tg_pt_gp, &dev->t10_alua.tg_pt_gps_list,
 			tg_pt_gp_list) {
+		/*
+		 * Hold tg_pt_gp_lock from the size check to the end of the
+		 * descriptor list, so that LUNs joining the group cannot make
+		 * the list longer than the space checked for.
+		 */
+		spin_lock(&tg_pt_gp->tg_pt_gp_lock);
 		/* Skip empty port groups */
-		if (!tg_pt_gp->tg_pt_gp_members)
+		if (!tg_pt_gp->tg_pt_gp_members) {
+			spin_unlock(&tg_pt_gp->tg_pt_gp_lock);
 			continue;
+		}
 		/*
 		 * Check if the Target port group and Target port descriptor list
 		 * based on tg_pt_gp_members count will fit into the response payload.
@@ -178,6 +186,7 @@ target_emulate_report_target_port_groups(struct se_cmd *cmd)
 		if ((off + 8 + (tg_pt_gp->tg_pt_gp_members * 4)) >
 		     cmd->data_length) {
 			rd_len += 8 + (tg_pt_gp->tg_pt_gp_members * 4);
+			spin_unlock(&tg_pt_gp->tg_pt_gp_lock);
 			continue;
 		}
 		/*
@@ -215,7 +224,6 @@ target_emulate_report_target_port_groups(struct se_cmd *cmd)
 		buf[off++] = (tg_pt_gp->tg_pt_gp_members & 0xff);
 		rd_len += 8;
 
-		spin_lock(&tg_pt_gp->tg_pt_gp_lock);
 		list_for_each_entry(lun, &tg_pt_gp->tg_pt_gp_lun_list,
 				lun_tg_pt_gp_link) {
 			/*

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-bug-target-rtpg-oob-66d1ab0272c9

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>


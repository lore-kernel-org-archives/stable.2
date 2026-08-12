Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C19234973
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493391; cv=none; b=tAn4flkhgE9jvTPyeejVWdf74BhtNOu54iL7W7v50VxNqWTNvsIXqrgDvfpXwzKSWdwHn7Jt15HwypQwMfP6/SNCZosqTSnt7BcmBthDZKR3NgR8uklLKJ4Bu3zy4bxjNtipoiEchG5YsSzX+KolvyDmgvbOjRkXkPYPeLqxXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493391; c=relaxed/simple;
	bh=QyhlVUC/LXcj6K2yrAFP0IR9zbh+0K4XGH8lOr0k+dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5kv6NLLlFpqpzIDRYDy6dErIfCRnn3NVBk8ATp2spGRRqlcL1mvyFDgg8AVN9zcKKnaEdx24RV3xdUWE0bZ/pnO7smfJ1o7Go7l5pN/FxSbf0QpX9pZ25KvjyfBMkeehCSJq3pjRtcpxinu2SCSvhhbV4nG0sRAW84MAbPiF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiEdct4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiEdct4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0481F00AC4;
	Wed, 12 Aug 2026 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493390;
	bh=p9MQKG7lfh7G01KYL36gtq1Bf5LMdtwbE4rISPXAV/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QiEdct4b0kVUGvh6P1LJtLGMBkKGvuH0tnih25zgd/y1eWrbgvX4fC98ClQKiCjfH
	 SpvwhlAEemq1+jOeh4cAmL7LEwHycozKwbqqtS2YugbnLving+9UrByQm0R4TZwJ7w
	 BKDVMQMIeQ0mvUhcYPc/zafq4B85oEymhbWnHiBWTFIadIsuoNaDlLMkYXL1L2eyQK
	 8vRtujdLnvD/6ETiT36o5ARm0HHmCmVgyotl/PbT03KjcNbuhvs8Oq3OAa8wlK7sgQ
	 uBQ6oI8DEeX3B6YMmaI93cBBkuzc/2u/UiRxHXBX2IBUrXWSRb5SRXRZeQ1XTk9+vr
	 e9hHqAwEawqWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ibrahim Hashimov <security@auditcode.ai>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write
Date: Tue, 11 Aug 2026 20:09:41 -0400
Message-ID: <20260812000941.4158732-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812000941.4158732-1-sashal@kernel.org>
References: <2026080556-pancake-criteria-119e@gregkh>
 <20260812000941.4158732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ibrahim Hashimov <security@auditcode.ai>

[ Upstream commit 93dde0bf2f39a0f9f57fd610aa3201ce5b753433 ]

resp_report_zones() sizes the reply buffer from the CDB allocation
length. The v3 fix rounds alloc_len up with ALIGN() before deriving the
descriptor count:

	rep_max_zones = (ALIGN((u64)alloc_len, RZONES_DESC_HD) -
			 RZONES_DESC_HD) >> ilog2(RZONES_DESC_HD);
	arr_len = (u64)RZONES_DESC_HD * (rep_max_zones + 1);

For alloc_len in 0xFFFFFFC1..0xFFFFFFFF, ALIGN() rounds up to
0x100000000, so arr_len is 4 GB. On 32-bit, kzalloc()'s size_t is 32-bit
and truncates 0x100000000 to 0; kzalloc(0) returns ZERO_SIZE_PTR, which
passes the !arr check, and desc = arr + 64 is then dereferenced in the
loop -> out-of-bounds write / panic.

Clamp rep_max_zones to devip->nr_zones. The loop already stops at
sdebug_capacity (after nr_zones zones), so a report can never hold more
than nr_zones descriptors; the clamp does not change the report, it only
bounds arr_len to (nr_zones + 1) * RZONES_DESC_HD, a real device
property that can never reach 0x100000000.

Fixes: 7db0e0c8190a ("scsi: scsi_debug: Fix buffer size of REPORT ZONES command")
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260712183739.83915-1-security@auditcode.ai
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_debug.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index e39675649bae6..c4749ab443d2d 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4341,6 +4341,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	u32 alloc_len, rep_opts, rep_len;
 	bool partial;
 	u64 lba, zs_lba;
+	u64 arr_len;
 	u8 *arr = NULL, *desc;
 	u8 *cmd = scp->cmnd;
 	struct sdeb_zone_state *zsp;
@@ -4364,10 +4365,12 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	}
 
 	max_zones = devip->nr_zones - (zs_lba >> devip->zsize_shift);
-	rep_max_zones = min((alloc_len - 64) >> ilog2(RZONES_DESC_HD),
-			    max_zones);
+	rep_max_zones = (ALIGN((u64)alloc_len, RZONES_DESC_HD) - RZONES_DESC_HD) >>
+			ilog2(RZONES_DESC_HD);
+	rep_max_zones = min_t(unsigned int, rep_max_zones, max_zones);
+	arr_len = (u64)RZONES_DESC_HD * (rep_max_zones + 1);
 
-	arr = kzalloc(alloc_len, GFP_ATOMIC | __GFP_NOWARN);
+	arr = kzalloc(arr_len, GFP_ATOMIC | __GFP_NOWARN);
 	if (!arr) {
 		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
 				INSUFF_RES_ASCQ);
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A19400962
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525922; cv=none; b=hcVLza5HuyUjyxS15+XawdIooUQudsUxenxvSHlQ74U5eMliX5CuvWT5xBi9U8SQlEJT/wlayH5FNdwl92F4f5TeNGQUYJrExB1ZYZcparxwHfXTTpytzARVl7oC51QA7ftd6jLEU88P9aTg4+5guFqlf+HgGHeAO0RC/2X4uR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525922; c=relaxed/simple;
	bh=hcASKUQ5remP/76NP5bh8mPhV3zus8u03yze5NeJDiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWyk9UNaF1khiW908x4xyJ/+jYx4DEIMWsrctmz/iFAizjsBZWZvxsRodOVu0E6r9L1tzOT6m1x3hYmwdnHAChmejF92De9E5CIN7NggwfQNb7Z7UahehI/P7vvtQBY6hkRDU7uJJRja9hoVVPwLaptQIAM0UVHr/ZTNOAU38xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADz5wxmr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADz5wxmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B94B1F000E9;
	Wed, 12 Aug 2026 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525920;
	bh=642/aGNTrmqsSfjC6kLC7gnrIiVl2Y2ucaJPkz3/sDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ADz5wxmrvoWle5mKRFq3/COABB3kds9Z32Zvok+WF6NTpI/xlvAwpOQ46QKcpegLn
	 vs6Bcaq95UiwbkEyZDw9YDTbCuVmrgkVOkGxgvze7M/rTR1127w6J+EE8ZuIHADhO9
	 ceC5Gee7+fdorwYKe1isj5+SJmRp1KOVzH2oW2Ye4AvmLd6tosm03N651UTNckOB+U
	 u4O4HOLo+wiSQZZa4/XEJ/J4Uk68c0HA/ffQqTSZrsbUizUQqcBD6qdO9+weMvd3Gl
	 vnmiwn66eFSShXF3ZDi6AeRz4woJmyCZa/VuBuQso5Pu0GmqsQGh8UVTTU0TMmg30H
	 g+gl+UboQo/Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ibrahim Hashimov <security@auditcode.ai>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10.y 5/5] scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write
Date: Wed, 12 Aug 2026 05:11:53 -0400
Message-ID: <20260812091153.1357339-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812091153.1357339-1-sashal@kernel.org>
References: <2026080556-overlap-everybody-5524@gregkh>
 <20260812091153.1357339-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ibrahim Hashimov <security@auditcode.ai>

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
[ Adjusted for 5.10: resp_report_zones() here predates commit 4a5fc1c6d752
  ("scsi: scsi_debug: Add gap zone support"), so it still computes

	max_zones = devip->nr_zones - (zs_lba >> devip->zsize_shift);

  and bounds the descriptor loop with it. Keep that existing, tighter
  clamp instead of introducing a second one against devip->nr_zones:
  max_zones is by construction <= devip->nr_zones and is the actual
  number of descriptors the loop can emit, so it satisfies the upstream
  requirement that arr_len be bounded by a real device property while
  leaving the reported zone list unchanged.

  Without the fix 5.10 has the same class of bug from the other end of
  the range: for alloc_len in 1..63 the unsigned (alloc_len - 64)
  underflows, kzalloc(alloc_len) returns a sub-64-byte buffer, and both
  the report header at arr + 0 and desc = arr + 64 are written out of
  bounds. Sizing the allocation from rep_max_zones rather than from
  alloc_len fixes that too. ]
(cherry picked from commit 93dde0bf2f39a0f9f57fd610aa3201ce5b753433)
---
 drivers/scsi/scsi_debug.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index ad4cea4e14848..02d624dd35964 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4320,6 +4320,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	u32 alloc_len, rep_opts, rep_len;
 	bool partial;
 	u64 lba, zs_lba;
+	u64 arr_len;
 	u8 *arr = NULL, *desc;
 	u8 *cmd = scp->cmnd;
 	struct sdeb_zone_state *zsp;
@@ -4343,10 +4344,12 @@ static int resp_report_zones(struct scsi_cmnd *scp,
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


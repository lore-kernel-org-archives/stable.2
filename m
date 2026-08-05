Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474A18A92F
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929843; cv=none; b=rqvy3Qq3AxVYzmLQwFD7al77tT25nWc4ana2fvC7pB/t60Uoz4XiRmwkMRTAD8KNexE3ad/FZP4kerL7B51r7XOpqYDkSr4di05CS5/k9rgg8iREm83Ie8V4SWWiP/hQ1vX+MvprKQwqCs5JTwE4DNO+Cw68Qt8VTAZNHiVA4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929843; c=relaxed/simple;
	bh=VWu+hr4meKYefqrqDs48m4ZuoU+sj7rCnf2r+jYbBIE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hnHhCCYuw2ZzSJwutHaQU8k4H1/nhuHKXBRH/bHAOG7mRaxXkNWFdL9Wgsgq47XWkVjAdAXmvUdD6d8O+X4rcwl2WcSU4wgN/HKU6aZFmemn+91dlUx9Cy3e0tuCEX26ipPDnDMrp4Z1vnJE5GxlCdTgmI5wxJfwM/e2AcWSXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NASYSDdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NASYSDdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5771F000E9;
	Wed,  5 Aug 2026 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929841;
	bh=mnmVlLw4BBEJK6Ujv1W5Jb1+xjfhe8AknmK1x+L5VQg=;
	h=Subject:To:Cc:From:Date;
	b=NASYSDdbp5qg68WOUlaA/MziOI5D5KmYAL47Yf9mIgGv4XBDFO7aE6sw/OX/oWh96
	 gbsn4BzyIcVW+fBfkYf/pqiyPWQ61qURae0BfFzEyl/LpBvzexVu7Gz8EkaRUcMBTo
	 CJQH3yZSft1N5ahWFTjJQRMbJz0xUr1qOSHfGmRU=
Subject: FAILED: patch "[PATCH] scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB" failed to apply to 5.10-stable tree
To: security@auditcode.ai,bvanassche@acm.org,dlemoal@kernel.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:36:56 +0200
Message-ID: <2026080556-overlap-everybody-5524@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 93dde0bf2f39a0f9f57fd610aa3201ce5b753433
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080556-overlap-everybody-5524@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 93dde0bf2f39a0f9f57fd610aa3201ce5b753433 Mon Sep 17 00:00:00 2001
From: Ibrahim Hashimov <security@auditcode.ai>
Date: Sun, 12 Jul 2026 20:37:39 +0200
Subject: [PATCH] scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB
 write

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

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 9d1c9c41d0f9..643051332132 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5890,6 +5890,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	u32 alloc_len, rep_opts, rep_len;
 	bool partial;
 	u64 lba, zs_lba;
+	u64 arr_len;
 	u8 *arr = NULL, *desc;
 	u8 *cmd = scp->cmnd;
 	struct sdeb_zone_state *zsp = NULL;
@@ -5911,9 +5912,12 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	rep_max_zones = (alloc_len - 64) >> ilog2(RZONES_DESC_HD);
+	rep_max_zones = (ALIGN((u64)alloc_len, RZONES_DESC_HD) - RZONES_DESC_HD) >>
+			ilog2(RZONES_DESC_HD);
+	rep_max_zones = min_t(unsigned int, rep_max_zones, devip->nr_zones);
+	arr_len = (u64)RZONES_DESC_HD * (rep_max_zones + 1);
 
-	arr = kzalloc(alloc_len, GFP_ATOMIC | __GFP_NOWARN);
+	arr = kzalloc(arr_len, GFP_ATOMIC | __GFP_NOWARN);
 	if (!arr) {
 		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
 				INSUFF_RES_ASCQ);


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD359B68E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161346; cv=none; b=GvCy0IhaU1kXMNemGAMdhwzQlyiemmKBEW9iVELIeBn5YurDwQLE+sFtqEYrmydH3pjD98zag4iTEx5AVjgQlts3TLf5fKbm9OIweYh6/TCJvdZUYX8YfJ2zs+vn6atjck73B22JO7NJCzRP7MBLFPCuw9Gwo0iN3AvkFznSlCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161346; c=relaxed/simple;
	bh=ENv5WDcAxjS52Fq1cWeRDCeMspK96Ic6Za1NQOhS7kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPuPssafMeAp5sp1UZqcsMIdtie2aXI+t2C40mHk8jLN1H1bXBpowJcYiZtAZmZgzQjZQKDrknbEJEyrbNftFKe3xOHFidJh32zpyBYV8OqQpKaMn0PR/fCWI7MFa6RpWLoTEUrl9wPlspQYQ+sRqi+EHgtmniWL1YZ8M9IK6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUchu6f4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUchu6f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A7D1F000FF;
	Fri, 11 Sep 2026 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161344;
	bh=GAUpwlzWBKEGu1nHoRVDz3ldhtK8aCesyFFactWq5jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nUchu6f4xwGaNgP+0Yc5dzQko+XVL97FakMnH8Tx4WUTP66KO4sK32y0XidIDvrGE
	 LlKvjqYc1SKV2JVnZxtB+igOPoLbTil8ohzH0SJ3fMOGhTRA6umb3cerRp/vTCDoyy
	 SEkQXeY9SuJGoeamSLJqdVF2lf9Gwqtca9lW8+xscfaI03yoReaKKUFU7GHLvqhmmM
	 NnVBlMk1Vr0Fb9ScGn1fvYmKXXKfrF227UCVQZfJLS8WFbjEVfG9WZzGP6aHlZ1ftj
	 7WnbWaWG+CNbK6CpHIaUSMm5pAwv5+K2doCjbXN/586sMkWZIwzTIK1QhKO5E9TM+V
	 undpRQ0pju44g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: qla2xxx: Fix soft lockup polling continuation IOCB signature
Date: Fri, 11 Sep 2026 17:15:42 -0400
Message-ID: <20260911211542.1532236-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-lucrative-hydroxide-cdb1@gregkh>
References: <2026090958-lucrative-hydroxide-cdb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit d7e3fa7d06bf7fcaac186d3c4d635caac166d36c ]

qla27xx_copy_multiple_pkt() and qla27xx_copy_fpin_pkt() poll
rsp_q->ring_ptr->signature for RESPONSE_PROCESSED (0xDEADDEAD) to decide
whether the next continuation IOCB has arrived, spinning on cpu_relax()
without advancing the ring or decrementing the entry count while it has
not. response_t::signature lives at byte offset 60, but a continuation
IOCB (sts_cont_entry_t / struct sts_cont_entry_ext) carries raw FC frame
payload at that offset (data[56..59]). A received frame whose payload
bytes happen to equal 0xDEADDEAD is therefore misread as "not yet
arrived", and the loop spins forever in interrupt/DPC context, causing a
CPU soft lockup.

The poll is also unnecessary: callers of qla27xx_copy_multiple_pkt()
(PT_LS4_UNSOL and the NVMe purls path) already gate on
qla_chk_cont_iocb_avail(), which guarantees all entry_count IOCBs are
present before copying begins. The sibling helper
__qla_copy_purex_to_buffer() already drops the signature poll and relies
on the entry_type == STATUS_CONT_TYPE guard instead.

Remove the signature busy-wait from both helpers, keeping the entry_type
guard, and gate the FPIN path with qla_chk_cont_iocb_avail() so it defers
and re-processes on the next interrupt once all continuation IOCBs have
arrived, mirroring the ELS_AUTH_ELS and PT_LS4_UNSOL arms. With this the
signature field is never read on a continuation IOCB, eliminating the
payload-aliasing lockup.

Fixes: 9f2475fe7406 ("scsi: qla2xxx: SAN congestion management implementation")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-15-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ made __update_rsp_in() unconditional before the availability check to accommodate 5.15’s conditional producer-pointer reads. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 7dcd2c8577db0..6662f8fa81737 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1042,14 +1042,6 @@ qla27xx_copy_fpin_pkt(struct scsi_qla_host *vha, void **pkt,
 
 	do {
 		while ((total_bytes > 0) && (entry_count_remaining > 0)) {
-			if (rsp_q->ring_ptr->signature == RESPONSE_PROCESSED) {
-				ql_dbg(ql_dbg_async, vha, 0x5084,
-				       "Ran out of IOCBs, partial data 0x%x\n",
-				       buffer_copy_offset);
-				cpu_relax();
-				continue;
-			}
-
 			new_pkt = (sts_cont_entry_t *)rsp_q->ring_ptr;
 			*pkt = new_pkt;
 
@@ -3930,10 +3922,25 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 					       "SCM not active for this port\n");
 					break;
 				}
+				__update_rsp_in(1, is_shadow_hba, rsp, rsp_in);
+				if (qla_chk_cont_iocb_avail(vha, rsp,
+				    (response_t *)pkt, rsp_in)) {
+					/*
+					 * ring_ptr and ring_index were
+					 * pre-incremented above. Reset them
+					 * back to current. Wait for next
+					 * interrupt with all IOCBs to arrive
+					 * and re-process.
+					 */
+					rsp->ring_ptr = (response_t *)pkt;
+					rsp->ring_index = cur_ring_index;
+
+					ql_dbg(ql_dbg_init, vha, 0x5095,
+					    "Defer processing FPIN...\n");
+					return;
+				}
 				pure_item = qla27xx_copy_fpin_pkt(vha,
 							  (void **)&pkt, &rsp);
-				__update_rsp_in(follow_inptr, is_shadow_hba,
-						rsp, rsp_in);
 				if (!pure_item)
 					break;
 				qla24xx_queue_purex_item(vha, pure_item,
-- 
2.53.0


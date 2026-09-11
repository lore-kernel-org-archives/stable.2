Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594D4A8FD8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146993; cv=none; b=thY5iTBrNgBMM0qye3+EV8+Pl8lVGYdQjduhQ9Og+VYaZLZdyIoXNkz7drQmt0MlLPKgnR+pZyeIb8va4TR3uRwSFSolrKULDzaTIFyItnUrE1GHFJiZwVtUejEtoOY9ZMCmdb+J044tp4xC5ypkkVQdbJ9cCJzkGxcH03NCUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146993; c=relaxed/simple;
	bh=5KeqAFmZwczdG7zQ3/NfyhgnffeOEfqGqy7l/8GpxMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmQPUe6YZncM+bu1dKC2oCnIg/HgQdqpfZoemSHn+i3ifCzok3n6uk+hRZ3vim9zxrPWniA5K/IlD8nctbfa2TTqga6WkNMkMEhcfZkYZybA9bF2LBAcV/fGjBHePpAzsTVT2OGyvu7abi3EllVJJnfsgt3c2Ag+ayuHf22In48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt3dr8IF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt3dr8IF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80EC1F00893;
	Fri, 11 Sep 2026 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146983;
	bh=bxvkg8xDL53t8vACTH/eILlWzeATkLHX4b0KfueAVlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tt3dr8IFFx3cGswggC2VcW22NX/W3+20xqUxbyqJf9bs4Xjo2Ot4I1yhOTu6OEJws
	 v4Y0flpM9O8X5YvqUUKVFbc0foqHSx9l3gQY6IH7bNJNiUyn5QvacFd5wF7YbOTWfG
	 e4uT3whCuEHVXQ8S4ooox3aqaPexF/dJfMzG4uMsMupdwYryMvvahucBOzW21fNxYP
	 GGheL778NmpDKcBpNDkoXp4VB+d+e75m/E6GayA6sO7Hh3l83a1Ev4CBdQQFzsNvSt
	 OINy8EbvKpGcSPV9F1pyEfw4CViUfe/WsI2ZgqzteUS8KxumMCxj+kRxvYuSEojD65
	 38/xjKa8JOmew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] scsi: qla2xxx: Fix soft lockup polling continuation IOCB signature
Date: Fri, 11 Sep 2026 13:16:21 -0400
Message-ID: <20260911171621.1218430-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090955-dinginess-finisher-2b7d@gregkh>
References: <2026090955-dinginess-finisher-2b7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
[ replaced unavailable qla_rsp_ring_rewind_to() with direct ring pointer and index assignments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 612e00ca1ada0..81997119fd07d 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -921,14 +921,6 @@ qla27xx_copy_multiple_pkt(struct scsi_qla_host *vha, void **pkt,
 
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
 
@@ -1205,14 +1197,6 @@ qla27xx_copy_fpin_pkt(struct scsi_qla_host *vha, void **pkt,
 
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
 
@@ -4142,9 +4126,24 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 					       "SCM not active for this port\n");
 					break;
 				}
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
-				__update_rsp_in(is_shadow_hba, rsp, rsp_in);
 				if (!pure_item)
 					break;
 				qla24xx_queue_purex_item(vha, pure_item,
-- 
2.53.0


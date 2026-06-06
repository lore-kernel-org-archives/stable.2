Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7612773F0
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748353; cv=none; b=d2KxOcN1hjdRnWmnKMvh/KywVzRMD1lvUS0EwfJ7uWji3qQANfT4jfHiX9kSBaWsXRhd7QHj6KI5cSXCWDn6z6CNcP+D+esWCr0NJmXE3320ZzBA/I+XZtq8Nu9MYFDuvZ9sisLfOF8hCBrNAXZtX4qGtvjvb2dMCo+7kLF2qpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748353; c=relaxed/simple;
	bh=wK2+q4RjDqHV92DtNcbNzkFVZZ5IcovKBALzZ2TD8Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WY6eTdUz5ScIfVYni8od/Jl131d/FWEpWXBW0UN8WX8oL1JBZwMfrhLqBezFlS6fxayZz45qTIBKcxxXIdOgVYm7F2C0EUUk3v+QPaRHUO8ALtVjlbybg3GVLYp9xjX/V5xSLjtm3lQ3MpxEB0IkdpM65eJc/6GfAatYAOgc68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORi/nXep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORi/nXep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD621F00893;
	Sat,  6 Jun 2026 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748351;
	bh=Tom1WOIgNvN3Zz76xyYmjiCQ1yxOKvr9mmBGVwLS6TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ORi/nXepjfPwvAdAaBzCwF1GboMqFLYZlgVxbFd1Q6JhzWeLQkjRTJNq7fp8EjV1O
	 ex6VRt7Tf/Gqz5behcEDwZ+deUIBmkgFzVZWLgaYCvOURtacJ9sKrXaYlDuwOppQ+k
	 I7n+xFP4RLcv06n7mS/nUU9AEcywaLkvveM7SmMBcTj5kCDC0ZyRvG/6JwlVs9JgOu
	 dZNCux/1Ap8Nz175M8izGGd2PB8CuQcAccYrnwPcNiq/t7u+RBoyP6yeQi+7LnuIDi
	 qYz6MFczmwUnMY54oYgBM4LRgs5y8sz0XrcXJ34wqVWV3cZoeNbvz1FJbmhcimmOEi
	 3Atm3jnMw98eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()
Date: Sat,  6 Jun 2026 08:19:09 -0400
Message-ID: <20260606121909.2851630-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060458-caviar-selection-d50e@gregkh>
References: <2026060458-caviar-selection-d50e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 778c2ab142c625a8a8afa570e0f9b7873f445d99 ]

Two latent bugs in the Text-phase handler, both present since the
original LIO integration in commit e48354ce078c ("iscsi-target: Add
iSCSI fabric support for target v4.1"):

1) DataDigest CRC buffer overread (4 bytes past text_in).

   text_in is kzalloc()'d at ALIGN(payload_length, 4).  rx_size is then
   incremented by ISCSI_CRC_LEN to make room for the received DataDigest
   in the iovec, but the same (now-bumped) rx_size is passed as the
   buffer length to iscsit_crc_buf():

       if (conn->conn_ops->DataDigest) {
               ...
               rx_size += ISCSI_CRC_LEN;
       }
       ...
       if (conn->conn_ops->DataDigest) {
               data_crc = iscsit_crc_buf(text_in, rx_size, 0, NULL);

   iscsit_crc_buf() walks rx_size bytes of text_in with crc32c(), so
   when DataDigest is negotiated it reads 4 bytes past the end of the
   text_in allocation.  KASAN reproduces this directly on the unpatched
   mainline tree as slab-out-of-bounds in crc32c() called from the Text
   PDU path.  The OOB bytes feed crc32c() and are then compared against
   the initiator-supplied checksum, so the value does not flow back to
   the attacker, but the kernel does read past the buffer on every Text
   PDU with DataDigest=CRC32C.

   Fix by passing the actual padded payload length
   (ALIGN(payload_length, 4)) that was used for the kzalloc().

2) Stale cmd->text_in_ptr re-free (double-free) on ERL>0 bad DataDigest
   drop.

   On DataDigest mismatch with ErrorRecoveryLevel > 0 the handler
   silently drops the PDU and lets the initiator plug the CmdSN gap:

               kfree(text_in);
               return 0;

   cmd->text_in_ptr still points at the freed buffer.  The next Text
   Request on the same ITT re-enters iscsit_setup_text_cmd(), which
   unconditionally does

       kfree(cmd->text_in_ptr);
       cmd->text_in_ptr = NULL;

   freeing the same pointer a second time.  Session teardown via
   iscsit_release_cmd() has the same shape and hits the same double-free
   if the connection is dropped before a second Text Request arrives.

   On an unmodified mainline tree the bug-1 CRC overread fires first on
   the initial valid Text Request and perturbs the subsequent state, so
   #4 was isolated by building a kernel with only the bug-1 hunk of this
   patch applied plus temporary printk() observability around the three
   relevant kfree() sites.  The observability prints are not part of
   this patch.  On that build, a three-PDU Text Request sequence after
   login produces two back-to-back splats:

       BUG: KASAN: double-free in iscsit_setup_text_cmd+0x??
       BUG: KASAN: double-free in iscsit_release_cmd+0x??

   showing the same pointer freed in the ERL>0 drop path and again in
   iscsit_setup_text_cmd() (next Text Request on the same ITT) and once
   more in iscsit_release_cmd() (session teardown).  On distro kernels
   with CONFIG_SLAB_FREELIST_HARDENED=y (default) the double-free
   becomes a remote kernel BUG(); on non-hardened kernels it corrupts
   the slab freelist.

   Fix by clearing cmd->text_in_ptr after the kfree() in the ERL>0 drop
   path.  With both hunks applied #4 is directly observable on the stock
   tree without observability printks; fixing bug-1 alone would mask #4
   less, not more, so the hunks are submitted together.

Both fixes are one-liners.  The Text PDU state machine is unchanged and
the wire protocol is unaffected.

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Tested-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index b756d4cfecfe93..5cad0868535030 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2335,8 +2335,9 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 
 		if (conn->conn_ops->DataDigest) {
 			iscsit_do_crypto_hash_buf(conn->conn_rx_hash,
-						  text_in, rx_size, 0, NULL,
-						  &data_crc);
+						  text_in,
+						  ALIGN(payload_length, 4),
+						  0, NULL, &data_crc);
 
 			if (checksum != data_crc) {
 				pr_err("Text data CRC32C DataDigest"
@@ -2356,6 +2357,7 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 					" Command CmdSN: 0x%08x due to"
 					" DataCRC error.\n", hdr->cmdsn);
 					kfree(text_in);
+					cmd->text_in_ptr = NULL;
 					return 0;
 				}
 			} else {
-- 
2.53.0


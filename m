Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEC3815D6
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751145; cv=none; b=jEjluxd8ohhD0Mxb9iuR2TVBQp2+PSGBu6a7UAalj0wcrfF+pW2EEt6cu0etwrcTdMvdO2DDrMxCwNPeU/6JnLlx0lWF03dOrOjamFS+RmXbR9ugdM4pa2nwG2lFtyj3dHtGjkBOHYb7nxgMmWg5EWIJG2useXNHMK4dTojRVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751145; c=relaxed/simple;
	bh=Ib2LlOvmRLa5sSNTrDQD5V69rWNPCjy3i3ezHTBOJ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLVi/tkbmp9lFg7CmsVHJ5z/BDn6e5isMQ+yQA+lb2XKOU7P/esQ1v/2zL0mYpm7SHW1d+bs6GY674jY5BgqQ3EqWtnBX4bxjU6iLFZGDstMrkY2oFiELy+8e51lU6Nqi4AFP5F+nvtLGPWFzX9doaSDLmaEHTQOYxyIv7ADDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJGovwMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJGovwMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133441F00893;
	Sat,  6 Jun 2026 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780751143;
	bh=vg37zT2TlB0TNd8jHfhLavDYpKyUnS/74LTWSYDgaFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJGovwMjTO/TrFOrrfcnFzLl/9Nf9nc/3XSZ5g/BpelviYUVX1HI3t3oqm6j5Ovzn
	 PyppH71NdIi/Es0X07FHurdiRakzz4iiWpvkUndaepZhM9HYSlBVFt17y0XbtoybEY
	 aT3m+7yEydEdyO9pyxJl60vC6QbOPfKHxV/u9XdsdnqimN9o7RtbIyeUne7twVqTc5
	 azXg/3ghCtXPxxzqNDoGaX/HstbeBF0tVOuJxP/j+BGh4A7FyxxQinNvNxUtW6gSGu
	 jFLjKk63OaNZgK9j1jobu0vXwIy8eoucRe+wdZx1x5Rwg1d22pO9gQg4+bShQHxZ0+
	 +ywJMr7Eslvcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()
Date: Sat,  6 Jun 2026 09:05:41 -0400
Message-ID: <20260606130541.2924890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060455-reseller-handwoven-ef39@gregkh>
References: <2026060455-reseller-handwoven-ef39@gregkh>
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
index 48fe53323f84c7..c7941130db84d9 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2294,8 +2294,9 @@ iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 
 		if (conn->conn_ops->DataDigest) {
 			iscsit_do_crypto_hash_buf(conn->conn_rx_hash,
-						  text_in, rx_size, 0, NULL,
-						  &data_crc);
+						  text_in,
+						  ALIGN(payload_length, 4),
+						  0, NULL, &data_crc);
 
 			if (checksum != data_crc) {
 				pr_err("Text data CRC32C DataDigest"
@@ -2315,6 +2316,7 @@ iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 					" Command CmdSN: 0x%08x due to"
 					" DataCRC error.\n", hdr->cmdsn);
 					kfree(text_in);
+					cmd->text_in_ptr = NULL;
 					return 0;
 				}
 			} else {
-- 
2.53.0


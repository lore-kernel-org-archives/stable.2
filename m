Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B906406275
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570247; cv=none; b=Up+/4ueozyh2X3EAUrkQ55hR/9KQw1kGW9SsMKokp6J3F1XoM2GNn3jck0L96f9/mQ4k8qCFW6HC5bzT7zzhP6cbvU9SpZ/zHhVgY/sL5WOO4rBLqcLH4oZzDP/XPIcGSk1WlvdFqkQ8fgBAuy7J657ucp7MrA9b3LoTt9BDgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570247; c=relaxed/simple;
	bh=zvFiiqunIoyGw7sRFYmpstEFNJmbc5+3ISBUi2VKVYo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e66o4rox/NXLPc4koTFuxRKm7DGlPz6ND3XiD0RjCvuar9a2mvgV5bJFI0QG+cicYWnbBNEU8ebDzbEHnX71QDfs8FDoazc3anoBbk7m06EIiWSbhBksSxxteuRRgUplaYp4NfuG+NVaie6jKW/jMJAJnrusQL1XBIBBTwrB27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=paEeHDYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="paEeHDYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507A01F00893;
	Thu,  4 Jun 2026 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570246;
	bh=DWsYUEBuB/h0op716+YnXhpMLUrYA305Jbom0L10tI8=;
	h=Subject:To:Cc:From:Date;
	b=paEeHDYoXyT9XQNalceh5Xy8jjW9u6Q3o205cF7e92UxBTfOnT9gt9vqbWmWsYwG1
	 5ds+YkZNQMe6JL8/qXfzK3zt4RxhjTxlle3DP6tsjMhKQhyxa6hCriMYRz3b+B3gS3
	 Vb6Rxw+i1qu5aqYyluWcA3aA89b//J0lqlRXQYbs=
Subject: FAILED: patch "[PATCH] scsi: target: iscsi: Fix CRC overread and double-free in" failed to apply to 6.6-stable tree
To: michael.bommarito@gmail.com,john.g.garry@oracle.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:48:58 +0200
Message-ID: <2026060458-caviar-selection-d50e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 778c2ab142c625a8a8afa570e0f9b7873f445d99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060458-caviar-selection-d50e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 778c2ab142c625a8a8afa570e0f9b7873f445d99 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 18 Apr 2026 11:49:27 -0400
Subject: [PATCH] scsi: target: iscsi: Fix CRC overread and double-free in
 iscsit_handle_text_cmd()

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

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index cb832fd523af..62ada3a52210 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2295,7 +2295,9 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			goto reject;
 
 		if (conn->conn_ops->DataDigest) {
-			data_crc = iscsit_crc_buf(text_in, rx_size, 0, NULL);
+			data_crc = iscsit_crc_buf(text_in,
+						  ALIGN(payload_length, 4),
+						  0, NULL);
 			if (checksum != data_crc) {
 				pr_err("Text data CRC32C DataDigest"
 					" 0x%08x does not match computed"
@@ -2314,6 +2316,7 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 					" Command CmdSN: 0x%08x due to"
 					" DataCRC error.\n", hdr->cmdsn);
 					kfree(text_in);
+					cmd->text_in_ptr = NULL;
 					return 0;
 				}
 			} else {


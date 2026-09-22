Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1938737A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090069; cv=none; b=pujn6g/kDmoIGJx4ikmx+VcQ9xD3wXYJFfQLLSY5MLZpWmWTiOVc6o7NTIEEimzqgWfeFo21l3DE84Rt1sg1xKUDN+ZCXtzt3J/rkhiJR8WXx1Ky3STPtB5LNrFbI0lvfxBi6QYxNdB8Eax7PtonIN1FvVV+7hqvnPiZV5gs4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090069; c=relaxed/simple;
	bh=h0v8uiEqPziD5WLt3v+S/nSVMc492KX0yJc2VX+dTBg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ELnl8c9Pn5BzUuG7rRblrTNbMlw19xIls6LLhQlmthJFah2wjfHbC5qmd2EBvTJhmB/wIeMUX0M0+dkMtgagHb1Jo7MbfDHIWkCedvIohW/GNBmgvB3DQj88oIrTDQfVknQyMQUnKFEmJLjySaOJia/7yISJ844BWZUMZcb+ZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i85HsOIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i85HsOIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED00B1F00893;
	Tue, 22 Sep 2026 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090067;
	bh=07XZf0aNiTjPZ7mjB99mA3J4LLBinJu/OpoMYznaI8w=;
	h=Subject:To:Cc:From:Date;
	b=i85HsOIxOdnJLm1nTlo0Xv9Ncw/UTiIzNMcFzvop4AT//WfFkNFTUIOjGeSz5MkNT
	 Ik1HDP1SEh2cW2UpJLhWz7xVfrMG8EgXlJE9VHckwlC/IuOetUK9WOK78HaQmgps1s
	 5cIlheEUbphbHzOFQJztNcVHf0laO9KSrOuTL09o=
Subject: FAILED: patch "[PATCH] smb: client: fix server->total_read for compound encrypted" failed to apply to 5.15-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:08:13 +0200
Message-ID: <2026092213-aflutter-survive-4ebf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f73726b83e4756fdaa099e1bc1143293bd57ad79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092213-aflutter-survive-4ebf@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f73726b83e4756fdaa099e1bc1143293bd57ad79 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 16 Sep 2026 16:33:54 -0500
Subject: [PATCH] smb: client: fix server->total_read for compound encrypted
 PDUs

In receive_encrypted_standard(), server->total_read is left at the
full decrypted frame size when walking sub-PDUs of a compound encrypted
frame. As a result, cifs_handle_standard() passes this full size
to smb2_check_message(), causing the PDU length guards to incorrectly
validate the entire compound frame instead of the current sub-PDU.

This allows truncated non-last sub-PDUs to bypass length validation,
leading to out-of-bounds reads in smb2_get_data_area_len().

Fix this by setting server->total_read to the true length of the
current sub-PDU: next_cmd for non-last sub-PDUs, and the remaining
pdu_length for the last one.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index fcf7033889c7..7f2177f6fc01 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5371,6 +5371,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+	server->total_read = next_cmd ? next_cmd : pdu_length;
 
 	if (*num_mids >= MAX_COMPOUND) {
 		cifs_server_dbg(VFS, "too many PDUs in compound\n");


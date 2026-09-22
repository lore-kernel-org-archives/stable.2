Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11455295B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090073; cv=none; b=ukkuhUQGuFe28Ldj9PgyPR2hf4WsTrGsl0yyIpJ4elVf1Vkm9FuRGLRkLEa9HHVyD8crB0rNjwsdApAsp4dalBzm7YkgRCeJnf7WDJdM7JgSqcaNYCoARIt6JZ583wMzDhktPBi6SjXj9Rl1Slr/Ew/daDYez9+L49Ztn0IgQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090073; c=relaxed/simple;
	bh=Y2WQXQ8xIQ5hW92TiIFg0r6WuyNrTl3+WAYwf+Ycxfc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oOnS8NP1Uplt7usxUlyWBfORmos1FaIZ3eu8uQMtlkj5u43OebgoVjiJPKOCH/LSyAgVwSmsul5h9yiAnSCNBP0QZjOFHBLm01U69DW8esk3FL08/LeVnbHv2S3oSseRxs2a1L+QCaarS04yljSU7yX81MeJGDLthykIrBa+4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HBCBkisX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBCBkisX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC1D1F00898;
	Tue, 22 Sep 2026 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090071;
	bh=9C8VxVs+QJc0zYF3qEmQh1OYfJexV5ZTSbi+kGmJRRg=;
	h=Subject:To:Cc:From:Date;
	b=HBCBkisXHgeZ9RcUVupUWlOS0htFc8+dA4vqxDQi/iCB973WqgwrhYOHZAhBYRcCm
	 Bc36B4fGnkuO9xOdqoBSvrKJXXwmx60d9G9HDK5e/K6ZRZ9BI165LQBB2j0PUXcJpO
	 Aw5dHgCiT+NAiCwr7dq3BQDmwBs9GnhLb1jZriv0=
Subject: FAILED: patch "[PATCH] smb: client: fix server->total_read for compound encrypted" failed to apply to 5.10-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:08:14 +0200
Message-ID: <2026092214-passage-deviant-ba7a@gregkh>
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
git cherry-pick -x f73726b83e4756fdaa099e1bc1143293bd57ad79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092214-passage-deviant-ba7a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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


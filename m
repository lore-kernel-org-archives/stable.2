Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674809;
	b=mrqUmhhBRX1O+A4/xLFH45L+jUeMiUk1160n1cqbkkCDTpGsWytZyQIx4bCpBWjaNki8
	 hMPF/b96XIAlZTsp0fhKumWqhtGOhjYKNikkNi8KVGF5BRz7Jx51OObyz1SBFqEBjL8Sh
	 cPcRzN7o03Vlq4MMri53c2e/JbK0WxwH/ctyKYrpNhTnWg9mADtFVLgk1u8jiIOe6Ch9F
	 w1IRmaJxptEW6rXTZCrvpSW6UKvSHzf2ZW1wPFYcbDSn9ZLn2Sg+hm4kY13BF7OJgL01c
	 nvNhP7k4WcMD4J+IlVFlUwaliRYZkLZB4feeTXO7EsZHxwVevKIX1mrbThjqF+cdlIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674809;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j+XQkKwzc3qfWqR6jll45i2DxroUEGrLYw9UQY0sy5Q=;
	b=ibTxRvNDHqWbXx/gAT49HD3CDM3jfAn0BOTL1jqLdjdx3Vox06cG6SLaGSdBhJCVnWVk
	 Yp7OjBGSHfs3SqK28qa1GX2PAIAo86Lq1RL7484eE4lmxB+hgcCfo3STsYXr3rVddGxWG
	 cPGJFb6ol9AflF3R6AcUEcmL3DnzM7DMlPdsTgKyyl5hEF9PttJvgHLxB9PeaJY1XW8FL
	 Je2mKOoqE2/bc1cd29zs/4KurvZpkHePjeNzvMcEg15P+xkBey2wZ3K8aMlAodX/LK3Z3
	 eiB/NPQgbmBfO6bd5JJH95DosGH86EoDCVgpOy2Kt/HCLWyJ49XEgy4cUKQAJN2qMgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JIehBUnk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D3606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JIehBUnk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374791F000C1;
	Thu, 22 Oct 2026 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674808;
	bh=j+XQkKwzc3qfWqR6jll45i2DxroUEGrLYw9UQY0sy5Q=;
	h=Subject:To:Cc:From:Date;
	b=JIehBUnknvEjpz1yVjr0+JVin34qL4+03xxIPjWXaLJE3hXll9yvuLDN3U87ixNNX
	 xydaagY+FIv8nhnTVZFhSuSJrMXPvrPv6b/bsNVI95N5x107lKeaRd4bMmtw7LRMHI
	 gBZ5boKgcKRCfrX2LoDPXn1im2nhwFrPuHabpXDM=
Subject: FAILED: patch "[PATCH] ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer before" failed to apply to 5.15-stable tree
To: haa@amicon.ru,chenxiaosong@chenxiaosong.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:10:12 +0200
Message-ID: <2026102212-scanner-refinery-9bbf@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 399aa12450a61a5c73dc77e73f069ece9687c95d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102212-scanner-refinery-9bbf@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 399aa12450a61a5c73dc77e73f069ece9687c95d Mon Sep 17 00:00:00 2001
From: Aleksandr Khromov <haa@amicon.ru>
Date: Mon, 24 Aug 2026 13:22:46 +0300
Subject: [PATCH] ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer before
 filling it in

smb2_get_info_filesystem() reports 64 bytes for FS_OBJECT_ID_INFORMATION,
that is the whole of struct object_id_info, but writes only 46 of them:

 - objid[] is 16 bytes, and when the volume UUID is not available only
   sizeof(stfs.f_fsid) (8) bytes are copied into it;
 - extended_info.version_string[] is STRING_LENGTH (28) bytes, and only
   strlen("1.1.0") (5) bytes are copied into it.

The response buffer is zeroed on allocation (kvzalloc() in
smb2_allocate_rsp_buf()), so for a standalone request the remaining 31
bytes are zero.  In a compound request they need not be.  The offset of
the next response is advanced by the length pinned for the previous one,
so if a preceding command wrote its reply into the buffer and then
failed, smb2_set_err_rsp() pins only the short error response and the
next reply lands inside the area that has already been written.  Only
the header is cleared there:

	memset((char *)rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);

The client then receives up to 31 bytes of a response it was not meant
to see, including one that failed with an access denied error.

Clear the structure before filling it in.  As a side effect
version_string is now NUL terminated.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Suggested-by: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a8046f477d54..486cd745dd21 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7444,6 +7444,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		struct object_id_info *info;
 
 		info = (struct object_id_info *)(rsp->Buffer);
+		memset(info, 0, sizeof(*info));
 
 		if (path.mnt->mnt_sb->s_uuid_len == 16)
 			memcpy(info->objid, path.mnt->mnt_sb->s_uuid.b,


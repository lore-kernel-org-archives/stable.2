Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674806;
	b=FQsuLnTAoDKzuvu8oiFB6SW1zvr4itrWFg3aE7hXmBpCHdroef7Bhjnpho92KZNRI0ln
	 hEm/Pl6oS47xZRo2VvF0sODnTXDhJg4uCAns2+1ml4E5cqaP0sbICCTazbAzzNTtOgXOc
	 8Ab5bgX/lHUckvXo1/HZFmOTUhnUTTdifizOX8yV497YzwKVNatjwCcDIb6H1/on9fEwV
	 u0smj4g0Nl+yz9jCK6hhFz4D3QCRqfPUcwzB1ni2K4InhyjkmlwPOaW8xvy6vXxv+9QdP
	 6NkeyJwjmhtdjZdc5W9GOKcaD5bcAlJFKAazBozAF99Hy7l3s3VgTK+w3irXg/hTYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674806;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dvF+Gx0f3HjtTSUN9+QmN7hR3wemzwzAuqKXuJSFvNA=;
	b=BsTXlKnSAhtpgelwCGlzPeTWuvsKql6El/eYBQe8eWrSxWNsHKR9tuvjWtBE4ff65hv9
	 6VI0v18vGKmwqnxqbOHPT2v76RQd25CmWBqH9Hp+b7v+Q2tN5bi60zTVnnEz0IQ95r7KI
	 0vAnWwr847MFrVksqvQ62lXeOyp7EeZnhGUWnoKeAS1Q7OZfcetO6wIT0MC89HmCyLt4v
	 5rOr5ClE7EabcAPqdtsVjhjiFKn7BicVN0yYgfDy0TZvltnZw+PBAAVcQBXWQ/Ay9DdtR
	 wlshzdo3R0T5vh61WbvWFdG9F9+afEUV+hCDG4gfOwi+AGbnXsprOueCO0PYAdDKvDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZvDyVAH4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21588606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZvDyVAH4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291431F000C2;
	Thu, 22 Oct 2026 13:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674805;
	bh=dvF+Gx0f3HjtTSUN9+QmN7hR3wemzwzAuqKXuJSFvNA=;
	h=Subject:To:Cc:From:Date;
	b=ZvDyVAH48ZFY16gHC61bvStQ6dLS/oQ0VKy/Y69MuCdoyxdO0D8KRF1h9MCzWKHZl
	 ycaL70LxJeLBL+vk7uTVPQbb+civW9WqqckWKu6w1/9Lds83L1H+9z8SJt5bnP43zH
	 Wsuti+3mIKCan5dRkCzrxC1rFXXjjlUHu7CZOL6A=
Subject: FAILED: patch "[PATCH] ksmbd: initialize FileSystemControlFlags in" failed to apply to 5.15-stable tree
To: haa@amicon.ru,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:09:59 +0200
Message-ID: <2026102259-drizzle-twentieth-49c2@gregkh>
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
git cherry-pick -x c0cd3fc6824122014da2b3b0cb7ddeaa2946ec8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102259-drizzle-twentieth-49c2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0cd3fc6824122014da2b3b0cb7ddeaa2946ec8e Mon Sep 17 00:00:00 2001
From: Aleksandr Khromov <haa@amicon.ru>
Date: Mon, 24 Aug 2026 21:23:32 +0900
Subject: [PATCH] ksmbd: initialize FileSystemControlFlags in
 FS_CONTROL_INFORMATION

smb2_get_info_filesystem() reports 48 bytes for FS_CONTROL_INFORMATION,
that is the whole of struct smb2_fs_control_info, but never assigns
FileSystemControlFlags.  Those four bytes go to the client as they are
found in the response buffer.

The buffer is zeroed on allocation, so a standalone request leaks
nothing.  A compound request can leak: the offset of the next response
is advanced by the length pinned for the previous one, so a reply that
was written into the buffer and then dropped in favour of the short
error response of smb2_set_err_rsp() stays there, and the next reply is
laid over it with only the header cleared.

ksmbd does not implement quota tracking, so report no control flags.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 486cd745dd21..2fbd9010513e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7500,6 +7500,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->FreeSpaceStopFiltering = 0;
 		info->DefaultQuotaThreshold = cpu_to_le64(SMB2_NO_FID);
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
+		info->FileSystemControlFlags = 0;
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
 		fixed_len = 48;


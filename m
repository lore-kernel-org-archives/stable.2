Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701178;
	b=mpHeAelIdOGPNLm3ALmGdllgnu+9c6QpwWhJWleJZxARlxNCTlzJUMyogH509CqkE764
	 NhnuEUVcYClbGK0doaDxDhA73yQ6YCAP5SgMvoHuCFn79dZE6JVhVBKzUca7h8U91VGml
	 IXR04THH0O6C058voXp5WLwH+WIha/FBvLHMbaq5iMic8doz6GGtKvQ8HN658i1sXGtDg
	 nwK+MV4/JbxZwRJC/EhNrwdqYlXUQ+ykqI4rQveyvOwLpbtE54WQ6nAOOVmjFQ8+ZQP4A
	 JX+5TTSLD4iJEnDf7rnZ9VhcRtTO/Nm3vKF5Gp643Uls7vQss4OMPocyZILicKk2n6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701178;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=30mNKg6hG//01rt1BhZJPq4znfkO+wlDmj5IjBjJAYI=;
	b=ZQoK8dfx0g365DFMz1kVcm0CE2UizhJoidyd77PgA5lYO9EPsuzkjg9U+zIC8oPUq2/o
	 MAWM8RK/cqzVOo61auDTOBauep0CeD1izv8yrmth0NJtDeJFXSpKD3KQQNOOFD0TlCY29
	 QKjeVZC10cLKVjaYQxdS3PhRdCBCQ3GDoH5tABeXI1n1jUUxMmtCLbx33z//Yb66zRQco
	 epLRf0B0y3j4ZXWQMGpPaaq6FXZwMjsY18G0uiaMED9dcT5IYFMKG1zILKvKJAmywVoy3
	 ZXB9+iMqxsmF9+W8rzG3V0D3aTrHjASJ/UTZ5Ed/cEo9+GsUjXUvcMkna6CaTtSA6jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=duRlGN2w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BEA606A813
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=duRlGN2w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383F81F0093A;
	Tue,  3 Nov 2026 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701177;
	bh=30mNKg6hG//01rt1BhZJPq4znfkO+wlDmj5IjBjJAYI=;
	h=Subject:To:Cc:From:Date;
	b=duRlGN2w07C4EdY2dh1KtxUDYSNhd6F8EK3qTKzFyQZ1NdUbyBqfKEynzSNzFspT1
	 2KdS/DlqId5CKycyZhZX+VA7q46rquUzV3j7hgaD0xFumvEUe511s5Dr5zo7PkRJxG
	 EsBRIZbzeoXt1uJlRqylVOER/AK14FLhiWr6VtvI=
Subject: FAILED: patch "[PATCH] ksmbd: return end of file for reads past a named stream's" failed to apply to 5.15-stable tree
To: charsyam@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:19:35 +0100
Message-ID: <2026110335-embattled-grievance-334f@gregkh>
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
git cherry-pick -x 626611dc22a3b63b3264a7a797d9dbc530234fcd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110335-embattled-grievance-334f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 626611dc22a3b63b3264a7a797d9dbc530234fcd Mon Sep 17 00:00:00 2001
From: DaeMyung Kang <charsyam@gmail.com>
Date: Fri, 9 Oct 2026 00:25:35 +0900
Subject: [PATCH] ksmbd: return end of file for reads past a named stream's
 data

A READ on a non-empty named stream at or beyond its end fails with
STATUS_INVALID_PARAMETER. ksmbd_vfs_stream_read() returns -EINVAL when
the offset is not below the stream length, and smb2_read() maps -EINVAL
to that status.

smb2_read() already turns a zero-byte read into STATUS_END_OF_FILE, the
status a regular file returns at its end, and an empty stream already
takes that path. Return 0 instead of -EINVAL so that non-empty streams
do the same. Clients that read a stream until end of file otherwise get
an error once they have read all of its data.

The buffered copychunk path converts a zero-byte source read to -EIO,
as it does for a regular file that shrinks during copying.

Fixes: 2ae1a6cc4302 ("cifsd: fix potential read overflow in ksmbd_vfs_stream_read()")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index a6230ed64e11..02ee73d8d631 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -270,7 +270,7 @@ static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		return (int)v_len;
 
 	if (v_len <= *pos) {
-		count = -EINVAL;
+		count = 0;
 		goto free_buf;
 	}
 


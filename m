Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701161;
	b=oaM6ebovR3CWpS+xEexGcps9crKOi1/PY2rwLK7jdZqrXbmCEfK3LqiNXTSDtZmiv8Nd
	 xog9Lns2PyT8logfvLw1ECzpzUbCTzJzDSstsmSG9b8eplviOSXZXZ0ZwAnpAuEKK0fgE
	 8qv30ZJk8zUFsm8hhg2TqtQD5eLdhGS12CWNkNtO8DMKX5WljMmmyNc1h7cjwQzj31dVj
	 YsNKZaQh2sr9wP2wmJdbah7UUkaBW6pNPajF7NMTXbNmnS/kfn/pszKy4ihmhkFypjmph
	 H1vbb676qHrKBHLiUHoWxy0PwTaojKJSFpjidEKKsyxYBGbOH0yoi7TULrF69woHLQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701161;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lXSgm94jsrc1C8Wlm3DNFge04LRQ1ZeT1y3i9fFkh20=;
	b=NjcnyYwGOX2mw/b6Pfv1AQRkhEOqJdRCT2ZYbeW8w2vBktfWomXiFGUTSzvakOFQ5wY2
	 36J4Nbm79/65RyBLkmBkCLUMBBwMD822bplB/13PpALL7xsOz6xvPWi9AEddD2r3Mttx0
	 L2sHBk0ziyRW0gyl5IFDiB4s9MRiwImvg5W6u0lJHdGdsr9jF/q3qw8WYg252CozkgVkX
	 UFsNpkwovGApBOXMPsmiQ1hrHKO5eZpB2TFtPsmi5/FjmD/JUeKc6Vwr88zptbQfnyu3c
	 vD4jEPrmH1zxX+s8/qwGnG2Y2eOiygLljB5WbK8gGmeTH8x3rywT9WyfTjLhzxBvYAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CP9Y4rIM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2939606A813
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CP9Y4rIM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAA81F000C1;
	Tue,  3 Nov 2026 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701160;
	bh=lXSgm94jsrc1C8Wlm3DNFge04LRQ1ZeT1y3i9fFkh20=;
	h=Subject:To:Cc:From:Date;
	b=CP9Y4rIM06GI2XvIVmSGiw7Uc3dg9mgEHz38u/G8crMJYWVbmVKT89t5dADcGd2sC
	 2K3QhtFlRCTRKLqOJE5oTRLMnlXahAbfYuNrthliPscZSFGnQsii3mbZgjCPy+LWGL
	 gDxS88doMLultvaSQAZRMLLGutV/HYncXweg1wKk=
Subject: FAILED: patch "[PATCH] ksmbd: reserve space for the UTF-16 terminator in stream info" failed to apply to 5.15-stable tree
To: suruurism@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:19:19 +0100
Message-ID: <2026110318-lanky-disallow-4cf3@gregkh>
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
git cherry-pick -x a025c4991a7d83edc4dd339e3ea86d8ff6226eca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110318-lanky-disallow-4cf3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a025c4991a7d83edc4dd339e3ea86d8ff6226eca Mon Sep 17 00:00:00 2001
From: Abdifatah Suruur <suruurism@gmail.com>
Date: Sat, 17 Oct 2026 13:54:54 +0300
Subject: [PATCH] ksmbd: reserve space for the UTF-16 terminator in stream info

smb_strtoUTF16() always writes a terminating zero UTF-16 unit after the
converted characters, but get_file_stream_info() budgets only
sizeof(struct smb2_file_stream_info) + streamlen * 2 for a stream entry
and sizeof(struct smb2_file_stream_info) + 7 * 2 for the trailing
"::$DATA" entry. When an entry exactly fills the 448-byte small response
buffer, the terminator is written two bytes past the allocation.

Reserve one extra UTF-16 unit in both budget checks. The terminator is
not part of the wire format, so the reported lengths are unchanged.

Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7efd60c36431..a1b9368504f9 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7274,7 +7274,8 @@ static int get_file_stream_info(struct ksmbd_work *work,
 				     ":%s", &stream_name[XATTR_NAME_STREAM_LEN]);
 
 		next = sizeof(struct smb2_file_stream_info) + streamlen * 2;
-		if (next > buf_free_len) {
+		/* smbConvertToUTF16() also writes a terminating UTF-16 unit. */
+		if (next + sizeof(__le16) > buf_free_len) {
 			kfree(stream_buf);
 			break;
 		}
@@ -7299,7 +7300,7 @@ static int get_file_stream_info(struct ksmbd_work *work,
 
 out:
 	if (!S_ISDIR(stat.mode) &&
-	    buf_free_len >= sizeof(struct smb2_file_stream_info) + 7 * 2) {
+	    buf_free_len >= sizeof(struct smb2_file_stream_info) + (7 + 1) * 2) {
 		file_info = (struct smb2_file_stream_info *)
 			&rsp->Buffer[nbytes];
 		streamlen = smbConvertToUTF16((__le16 *)file_info->StreamName,


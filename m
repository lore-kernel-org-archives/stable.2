Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817042;
	b=3zzz5b+s4I1Ops66Sn9Eliy5WHKo8Ql+flfQ6zwYaogFQNQHNwJ2+6WTG4tGq4rdH/6u
	 oLJxzopmYY+1ncsCHwGYFB8IZn3S9sToLWaL+QXWhDAgMa2Z3eG9LYCTWYEVPlt0MugjQ
	 kWcPlIJWNk2PhTypi7pfaK+md1DjxENCsILTooGjXXXSE8Kk2fAcl8cWo/7WdeiN0e+wo
	 SyCd2QH9ZOggUwd82JwKyqF+oSNKxls2hfPXLYQyN+lPEBPEKHK2A3VfBkKsMslolg4Z5
	 3GeMzb/sS15Av9Jr6+OkgM5F/ejCD/lmfbZOJekmSv+yn3lO+yp5ICTJvhDGUvViD0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817042;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RxtFqtHI/vXEgfQDe6VvwneuYdT2QQiY4ue9KyQiUCY=;
	b=mLoR9P80LX/79CyMNbTbDtc3vvDwG7N0v0zul33U79cLWkE34JemKjLk5HRPgzkx/wwJ
	 Wwz4JFXbYdICWWmCkmSfRoJ4+XcSz10LFKn71kjN6POw91dpU/RVZue9JrCwKdUdJ6p78
	 3zcUiiAPAU/zB87DZnLT/ROW6aj3cT3i5dpR2TPVOenBT4zydzsqDIcy1guzcN02YsqF6
	 wYcLomhow7r1m8d1odPqdVRUL633u/A0ec1XzVE51LW2fytmSwanjib4/OaAmGfwLz39O
	 QNPz81U+EHodw4Ac93xiEpXgUEGsQ4It2WKsgtya2suJG6d6cqmw0KIqwe+mn9WX1Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Usee2yxN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78447606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Usee2yxN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AD31F000C1;
	Wed,  4 Nov 2026 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817042;
	bh=RxtFqtHI/vXEgfQDe6VvwneuYdT2QQiY4ue9KyQiUCY=;
	h=Subject:To:Cc:From:Date;
	b=Usee2yxNrSy8lgvQWgJyRYfe1zhnCIqnvlVtsQ2x1Z0Yy6T81U1FlZ1rMkLOcHNws
	 2x7UbcfNRikrsc8jTjlB+UAVppFQMjBYkuuTOAzyjorIlRrSFXkofn1d9L9DqZgVNt
	 SE4IH5upZUzIXmDrZAdYkS7ugnlhn2CD4vASXw2A=
Subject: FAILED: patch "[PATCH] smb: client: fix buffer overflow in SMB2_tcon()" failed to apply to 5.10-stable tree
To: rakukuip@gmail.com,bird@lzu.edu.cn,n05ec@lzu.edu.cn,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:30:32 -0500
Message-ID: <2026110432-purity-munchkin-1270@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 73cc469b0ff7551f8537ea919709973e6dc4f514
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-purity-munchkin-1270@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73cc469b0ff7551f8537ea919709973e6dc4f514 Mon Sep 17 00:00:00 2001
From: Luxiao Xu <rakukuip@gmail.com>
Date: Fri, 16 Oct 2026 15:11:01 +0800
Subject: [PATCH] smb: client: fix buffer overflow in SMB2_tcon()

In SMB2_tcon(), unc_path is allocated with a fixed buffer size of
MAX_SHARENAME_LENGTH * 2 bytes (672 bytes). However, the user-controlled
UNC path (tree) length is passed to cifs_strtoUTF16(), which assumes the
destination buffer is large enough and writes strlen(tree) + 1 UTF-16 code
units.

Commit 62a1a439e0fd ("cifs: clean up handling of unc= option") removed the
length check on UNC mount options, allowing mount paths to exceed
MAX_SHARENAME_LENGTH while retaining the fixed-size buffer allocation in
SMB2_tcon(). Consequently, an oversized UNC string causes cifs_strtoUTF16()
to write past the end of the heap object, resulting in a slab-out-of-bounds
write. Furthermore, if a tree exceeds MAX_TREE_SIZE characters, strscpy()
truncates it in cifs_tcon::tree_name, causing subsequent reconnects or
failovers to fail.

Fix this by first verifying that the length of tree does not exceed
MAX_TREE_SIZE, returning -EINVAL if it does. Then, dynamically allocate
unc_path based on the length of tree so that it safely accommodates all
UTF-16 code units for paths within MAX_TREE_SIZE.

Fixes: 62a1a439e0fd ("cifs: clean up handling of unc= option")
Cc: stable@vger.kernel.org
Reported-by: Xin Liu <bird@lzu.edu.cn>
Closes: https://bugtracker.nebusec.ai/f/3292
Assisted-by: LLM
Suggested-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
[pc: remove unused MAX_SHARENAME_LENGTH]
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index b140ec0a71a8..5d892300dabf 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2104,8 +2104,6 @@ SMB2_logoff(const unsigned int xid, struct cifs_ses *ses)
 	return rc;
 }
 
-#define MAX_SHARENAME_LENGTH (255 /* server */ + 80 /* share */ + 1 /* NULL */)
-
 /* These are similar values to what Windows uses */
 static inline void init_copy_chunk_defaults(struct cifs_tcon *tcon)
 {
@@ -2135,7 +2133,15 @@ int SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	if (!server || !tree)
 		return smb_EIO(smb_eio_trace_null_pointers);
 
-	unc_path = kmalloc(MAX_SHARENAME_LENGTH * 2, GFP_KERNEL);
+	total_len = strlen(tree);
+	if (total_len > MAX_TREE_SIZE) {
+		cifs_server_dbg(VFS | ONCE,
+				"%s: tree name exceeded %u characters\n",
+				__func__, MAX_TREE_SIZE);
+		return -EINVAL;
+	}
+
+	unc_path = kmalloc((total_len + 1) * sizeof(*unc_path), GFP_KERNEL);
 	if (unc_path == NULL)
 		return -ENOMEM;
 


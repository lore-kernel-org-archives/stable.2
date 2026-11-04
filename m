Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817033;
	b=DeMpkXNQxiZVy2Axged7kgAHdxsBD1cdlv2OytkK2efSc3P+cIlzUVQ0Z9rrtu2QDuyb
	 TuQRjKp6RDBh1ZibO/qw5F7kiC8wxI46QLboWG/DJV/Y5BAC/bxmdVZ5cEYu+fICeGFOu
	 e0K0cgCwbR1QZYt36ZikUsh4Tt7haj5kbYUFeRKWbcRITTHo0Pd5R3MBxafX5vah369Yz
	 vjhUsaF1ilzeQJT6UcjbX7p25PKAwdWs8CvwCPc2d7eNDngIz2BuE1zwGkoji1ChSdWvx
	 wLYuP4TMv0ucQ+vDtYnUR+NDs/TJluQyhMOnM5WEVjP5XqhU3HT3Kr4CiAy27rPB2/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817033;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bzrtlIvz6UlLk7ATFl6D2jtOGSCU6ISd0avQ2fIQOak=;
	b=gxpcDVAv6UTJ2cfqvyjCzqoqZXSmllrAdQa5y3aSjmCg2LZjKcm/5nF3SCEj7KP/wUhh
	 le8J+JlVVeY4hWsKY9rz/bK5NNjoWWpw1e9VDrH+mhqk4vO32Rq/gdfB3IPLoAhrvJp+9
	 5Js0PhzTqakGb3V2t3EcpZcqEGI2i2xRVdvbRKh4o3eXABDeNft/0wOq5gGds/5TwXYcN
	 +2JEaKeRwP9k33q/cHv1Ph+YKrEWrUKQ4hmK0chufRM6lnlHlYLMNa+lHla+U8VtpGMgQ
	 RnJZi1Bgg9lAFGo6Do5pm5F7OiGCH4HpnnEJPy/YNd+txWt2RA++Hx9oV2OhxYdCmUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="liUTl/ex";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1C606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=liUTl/ex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B401F000C1;
	Wed,  4 Nov 2026 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817033;
	bh=bzrtlIvz6UlLk7ATFl6D2jtOGSCU6ISd0avQ2fIQOak=;
	h=Subject:To:Cc:From:Date;
	b=liUTl/exJrINFfnJo3Brc73JZztR+8WWyXnyhhmA1wM/Z5E8dOqXMxpOPjVvMj5B5
	 4HfkNuTBf82Pe28m74eBMpdsu/mFiC6tTsNvlrpzDaPV6TE7NN3n5zCdgco5Vlmtpo
	 EQYSEUcpvb6in9x2va7hddL1Z28tPkypCRkWxlsA=
Subject: FAILED: patch "[PATCH] smb: client: fix buffer overflow in SMB2_tcon()" failed to apply to 5.15-stable tree
To: rakukuip@gmail.com,bird@lzu.edu.cn,n05ec@lzu.edu.cn,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:30:31 -0500
Message-ID: <2026110431-residence-starfish-1a10@gregkh>
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
git cherry-pick -x 73cc469b0ff7551f8537ea919709973e6dc4f514
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110431-residence-starfish-1a10@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 


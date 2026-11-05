Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904299;
	b=s8bQ+j4cqG6KfRGHJofjF/8XPPWXhs10CbALzHinJ+a9JaY2pM2Jzq3tmvv96wjCXUwY
	 Z+gSLttxruhmuy7BbnCzx+4C4jTu2bYlNsDWM7llet56EOLYZ9faRby+zui/kdxTEJBEN
	 6cUX02yLw/SbPu/WrIGOfM9FECFx0mOLdl7/6uAKQDkuBPEPmKzPasFF0I/PcZY/NQJZ1
	 RorOQnRNSN02XpQQSe9AOMcMEBHOFJYasn21uo2V8YQIrFTDr1OFgq5R5FGK7aLOICYjx
	 25pb9/riNNnzkSPUFd0sT8I5FwvtUNawGTj/ZmbtbLLfYiuFGZ9EEfvgVr9yIcyjgpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904299;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ylAdIH9jPkE/KQlVEvMIxI394y6bbrs0wONXvFJYkxA=;
	b=IGsQvrY4vFJsrjSp4H4F5Ej7In02WvuO62P6eUNfLnJQ9kLAbtJATUDe0HJA5aMgKcQr
	 BfJVazIV7tok6Sk1stj6ZJHCBj84EQswa+jJEeGG/dD5FsVI1TQRcO7Xv93DM0bSNVOya
	 08ULHfqqTDDRPMZfjBR9weqezvQSuL0wLU5lqdfmaYnIPFP14b0nTLmu0mpIRvHqqsx7C
	 9TmwP/pSQXbBvRZAFDhDSsjI4ZF34jZ8rvlvkfWYtALb+icCJirBkE0xcpZ2TGEOxreMS
	 nqTmOk8U3uuURTMfApp1c0w56OUqtE3rWD5zzHgFX5gIu3sceHqL144URgHMPp7U/CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0TDaFV1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9379606D813
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0TDaFV1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5861F0093A;
	Thu,  5 Nov 2026 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904298;
	bh=ylAdIH9jPkE/KQlVEvMIxI394y6bbrs0wONXvFJYkxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V0TDaFV1TYSaAJcLwTmdewhSVTZC9JA5H39FwWZdbsm7oAe0lvsqOiB4eKhvHExHI
	 BO58vyiKDtAWUB+ec0vzsify7T9+oJtu5ETx9eZtjUDuFUA2kUDwtjQ8x/XJWJl8Fl
	 YTD2VgrRQHBedv1v4z1fCRYdTSoLAoPGpAIsFRrliCBQZF/kGdOMXwgavG5guQR310
	 CiF569NfY33iFBMMAD9hM8vP+GFUUYD81Cs9OSceGsg63JiyjlfnY1SKg953ubU3Im
	 eETWdtKrA8JO/ntIIUHjhQZnYTUoA3pplDn+9C1R+GOLSpfVXqB3pVOj6Xnux8TJf4
	 /F9QuSHBFXA1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luxiao Xu <rakukuip@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Paulo Alcantara <pc@manguebit.org>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix buffer overflow in SMB2_tcon()
Date: Thu,  5 Nov 2026 13:44:56 -0500
Message-ID: <20261105184239.2191076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110431-residence-starfish-1a10@gregkh>
References: <2026110431-residence-starfish-1a10@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

[ Upstream commit 73cc469b0ff7551f8537ea919709973e6dc4f514 ]

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
[ sashal: Adjusted context to preserve the existing cifs_stats_fail_inc() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 2c7bcb768a64f..d2d8d643c4f7e 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1769,8 +1769,6 @@ static inline void cifs_stats_fail_inc(struct cifs_tcon *tcon, uint16_t code)
 	cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_failed[code]);
 }
 
-#define MAX_SHARENAME_LENGTH (255 /* server */ + 80 /* share */ + 1 /* NULL */)
-
 /* These are similar values to what Windows uses */
 static inline void init_copy_chunk_defaults(struct cifs_tcon *tcon)
 {
@@ -1804,7 +1802,15 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	if (!server || !tree)
 		return -EIO;
 
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
 
-- 
2.53.0


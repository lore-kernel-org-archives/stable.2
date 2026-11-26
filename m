Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667019;
	b=U/qPu4wcjQbymwrY//E+ofW3lCPGUiwtTa0iLx/cQ5giMKbj7npNbwT18VqSSqXy5bDg
	 o/R5SRZv8JJLd8kpFAz5Xg8Z9PEfaU6HGZrBBQr08S5P5b6RbVxqRf6iv8Cne00fQMfqM
	 D7zRYCJPSr2z3wTbDlev5eqBxNsVfHHO4OeUebQtwcuiWZuYrNb8Ql4U9m2VLNjakCKa1
	 I5ima5QiU8MIHJpX3/bv5cWJOaDTXwS2LiL7ouzT9QI3p5MJARlhP2WVJZ4lMwPVzJbco
	 YxlxmG1XJsSYzWM8DvPZkiNSOnFgBdBgqOJMuXKzML5+CgkEKGG5UsSB6gFDE8St9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667019;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bv85iyz6QPhsWFMJ5K8m9CK7IbUGmLWej8TbnLc4uUI=;
	b=doS+MukqF9Xz44oFqSd+862SSchF5GVkHt19/W1/FaG093juYV5fzhOlAcnhj8H9fo2L
	 SOi58IcFcqEvV40KaemdJJIuj16Re/JvNp/bbhXsHAvMi61yB0ygo3JKjXN4KWyDgCofw
	 4Sn3Du61ndhPXYQhZBsvButLmSQ/Nn6fk4LRNvG2QntLqjfOYfN1vxy3174knvxvRsuFv
	 Vw25eh0zK+9OOkqfsgtCTEU63sIXKVjzGDWUfK1gbIy6kIHDgugQrqg7pAiDl1grhnlUi
	 Susx2JOWtUqYxBM/m1dB2dabEMwZsMQWuqvZ6K3honE+P4hBDJEb36kmoTaisWjazww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=el0hRs6e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D38606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=el0hRs6e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9D71F000D0;
	Thu, 26 Nov 2026 04:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667018;
	bh=bv85iyz6QPhsWFMJ5K8m9CK7IbUGmLWej8TbnLc4uUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=el0hRs6evlx8+ZIw7nNPhrSE3XlmyQdfkOZMF36fS6+M1J+kmBOI0CLTFI1MUusEw
	 O51TtZNPNK/YuiLzOqd9bE0gqs3PSCHuS1smpOW/IwigigBpTeVjjuNzVtZzwEfyER
	 jRWBJiS0mTOIdi1rA5AvGDSpeSU7m+3dVv4te96gE4eYWeI3a6FoAOZbUDiIYzSm2a
	 gPR9OsQuNZMAx19YMmJP7dx02zGqJhiOVWkFkowRgKT0P2HEQ4DO+bpcitzyeXXcNY
	 Fu4mi10g8wcpN4WQVbq0XUIPGLT7oJ5A/dMx86Ipt/PICP6jTQdI5hSGyFoMIprb8X
	 KHkuSFyAjBE7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Bharath SM <bharathsm@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] smb/client: Prevent error pointer dereference
Date: Wed, 25 Nov 2026 23:23:34 -0500
Message-ID: <20261126042229.1926905-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112506-zipfile-subpanel-c0d3@gregkh>
References: <2026112506-zipfile-subpanel-c0d3@gregkh>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 7a2158b73c36903e8822dae5442c27d6d0e1014b ]

The cifs_sb_tlink() function can return error pointers, but this code
dereferences it before checking for error pointers.  Re-order the code
to fix that.

Fixes: 0f9b6b045bb2 ("fs/smb/client: implement chmod() for SMB3 POSIX Extensions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: ffb59029c0d5 ("smb: client: validate descriptor headers before query result allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index ac2e09eacabc7..dd88f0ad23915 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1734,14 +1734,16 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	struct smb_ntsd *pntsd = NULL; /* acl obtained from server */
 	struct smb_ntsd *pnntsd = NULL; /* modified acl to be sent to server */
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
-	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
+	struct tcon_link *tlink;
 	struct smb_version_operations *ops;
 	bool mode_from_sid, id_from_sid;
-	bool posix = tlink_tcon(tlink)->posix_extensions;
 	const u32 info = 0;
+	bool posix;
 
+	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
+	posix = tlink_tcon(tlink)->posix_extensions;
 
 	ops = tlink_tcon(tlink)->ses->server->ops;
 
-- 
2.53.0


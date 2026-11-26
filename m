Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667416;
	b=JQ+heF59JnMb3otpgTnv6DUOz4OWFMaQ9SDmjWGWvuBda4ROh2EbAnZDbyy+9Fq6/rLO
	 w0ml1pKuOBodT+iiMjxA8qQzC38Gy4MSX/WU7CxxB/DjE9OtzU5sFVn/kMxQ3tY6EhWgU
	 24RjZjQOKWHMTBJKxwdTFliB8R1nV7SWg8v9sWVMxhnSpny23cHmcTKnxIu2k8vOZH2FE
	 wVa2zcecSDWV1KBeyETUVOKDMbMIxWBROT/vG4CVuUn3jGR3OPxLNzmZMA6YRKLsKhnLt
	 aQPGSo6Bo+Bogb/lCZVZVdxAZqjOOgsdrhN66Jf61K0Z548J/zah0ckFJcSFQ86fxrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nyAQ+2g7It/4qrv77FpSpbkfU4RQXxMju3rIvj8bnr0=;
	b=PYRxPCfM5cmAmob2cq0j6GzdC9OwRnTg4nfE0fRARaBW3qYYuZbwd/6Pw+pNebgLCGRv
	 c0Dsh3cp4RSBOGiRnPtIbClF8F2w8ZsDsVtuq/dcoxpJ06UqBOrH88Z6B6IcmCBzVc4ur
	 doeokZDHmwDGwZk3NMP52ZxYg75zk8hrtbUyFssMRAdMZF9g4yrlys89agHoBnt79vU6R
	 mEKtgKzZ0Ah/tEgCgU5B7DfPRjoKUvfYU8CI2s54vXV38NO3ZJRUjRw88Ysy9zdTqjHPl
	 HhEcMX3l5+zaEwJnuqsrlKUY+CHaeRt1+fBDwPGwX5EVEmZ5n7I8ferE7iV6DbI+wBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ob//x1+c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A5606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ob//x1+c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AACC1F000C4;
	Thu, 26 Nov 2026 04:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667416;
	bh=nyAQ+2g7It/4qrv77FpSpbkfU4RQXxMju3rIvj8bnr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ob//x1+csZM28SqmsMkqMcbEElhGXBrmCxYK8DkEaZGBiOhTFMtJ4kXyUUd3BPuSs
	 QMn57G7mAblrV3stpBbWiigbHFKTP7md0Ku0nMH48afb7OX1C8+T6pmQG3OsC8gTBT
	 1nAl+uIvpTaaMFi0Ox8qKRhPjUmVVtycIDtY2uxVjK6nIleKMgojIuCWUNUO4My+kG
	 hjbfGesuKG4sdgYpBaP7fm8h3kTv1pIWqYuX3I+yMd6IXlb3gMDTwzLWe4ldVNxEJI
	 LZvu0qKO2k8buyygTW/+Rig0SAwdqzwFi7rm79nEma6wnNzcXfJVWpMBgsmK1KTouF
	 c6H/1mJEx4VeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Bharath SM <bharathsm@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] smb/client: Prevent error pointer dereference
Date: Wed, 25 Nov 2026 23:30:12 -0500
Message-ID: <20261126042943.1964790-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112507-depraved-reappear-7196@gregkh>
References: <2026112507-depraved-reappear-7196@gregkh>
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
index d88869d99dfe9..540655c232cf6 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1730,14 +1730,16 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
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


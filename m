Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686392;
	b=hnY+pSF0prl6Jqm4ktscq71IRFoKKguDU5fcBrDflPjJ7mVSE/nGubSvyjmj8waLCTy+
	 ejgDbDEp3Z+WnBwYn4r98n6b7Kcw1nnWPqI95yywToqadXGZdcgFALAZQy1kj58GjgJ+7
	 1PDNbMhkjjsSr3HhEHFrQJmwZQt9V85oeBdVs4PaZrbmjGxqXFY4ayU2douuNQDOj/2ak
	 bNEIr4vLhzvHKubUk8QAPKdVmooq4SixHMuylKRoip/+cjppfAt5+TxSr7r88+Hj7yXD/
	 1V6v1zrwvgF5cBuTyPtk1GVL2LMCwykEUW2yZYqanqoAm7kCT+2WaxBOFyd2L5ATyww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nzrcY2i8l5zIqceA9gC72LVYwK4w51hld8IvtlCt12E=;
	b=BgOBxRY/OPLekQo5GavKTgEnSCy2br1VS8gDr59qoB87TPC2syuYspTCGvR31XsAcw1l
	 sTkkBN+PH4E5RMXhQQcTOu7BJOYGfSzIaT698plnSVH1MMI/e6+4d/+odxqp82tlrUHwQ
	 upY8Je2W1HhsPKiNZI4+eRJnu/Jf7LAd6zCRM5bFIYFgtLbWP6Mu2J+TEp5XQEcvXXzKX
	 fl6xjgIL7L7REN3JuhvmW22W4GLKXL8J7D8ZyepnZM0Oy1ymyDbvQloCO5M+nx0zTMIOs
	 e4EFLtbkTJb3RtIR0ECwS5As8HQtfp7SzgT96pzdwn5WXsowKs8OOLhekQp5izvPtYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kHK3r/Nv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3882606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHK3r/Nv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9311F031E0;
	Thu, 22 Oct 2026 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792686391;
	bh=nzrcY2i8l5zIqceA9gC72LVYwK4w51hld8IvtlCt12E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kHK3r/NvQYKnyONeWYEoevpwns7TSYwfCzgsbeC7BSuv8JbsvBV0x7bc+sqNWhk3y
	 b2IPBM4ShqZdBfbc3fCEBT0pTjI9m6hWpVScjiuz5c2nBtCVnGIIoDAm1FbPltKHly
	 S6iI855A4sYdZ375dcnF8FGQnxaq3ReRpjHonA/O+B1jwRYIFZYJHSdkSeWKXi0wul
	 ibTjTT8WeeoieOBdyEflrDKVl5k5uKOTORdt6t9p4wbVgv4eZYNcBg6Z+tC3gaPJAu
	 LsdhC4iT9Tqw2pLQuIHrrBPpY78id7dWIDr2QgWurrQdTCJiYzrHxsPOLUnz21ciDi
	 mgQIy6MinMF0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()
Date: Thu, 22 Oct 2026 12:26:28 -0400
Message-ID: <20261022162440.1728185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102115-attempt-pointless-b976@gregkh>
References: <2026102115-attempt-pointless-b976@gregkh>
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

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 53676a5e28231186c9f56d87b7998b640699bc15 ]

smb2_duplicate_extents() has no handling for
FSCTL_DUPLICATE_EXTENTS_TO_FILE failure: when the FSCTL fails, local
inode metadata may be stale from the pre-extension or from concurrent
remote writes, but is never refreshed.

Force revalidation on FSCTL failure and use i_size_read() for the
pre-extension check.

Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate extents (reflink)")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: adapted the if/else block to a standalone failure check because the success-path metadata query is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ecc5f27ff1413..5a07d411a00a6 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2027,7 +2027,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		src_off, dest_off, len);
 
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2052,6 +2052,11 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		cifs_invalidate_cache(inode, 0);
+	}
+
 duplicate_extents_out:
 	return rc;
 }
-- 
2.53.0


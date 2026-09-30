Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19C51DE16
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789659; cv=none; b=QT2OeZqp8heLzPavyDYw0MnBJsWepi9nx0PizyEpf1z1glgyJvUXSiM3dQsvRapK7bcB2hU6Oi+qeR3R3uiDEy7j6xic/a66RfmqGN1weflbK++CNLtiY62Asunx6xw+5yW3+6QbOMhAIw6M6XEBmLQs35Wt8BFfCX6jpyfbTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789659; c=relaxed/simple;
	bh=tJgmTKy6CLMQ55XL2nIIiflAl+bls1WOTkTPqpukuDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQN/JEdUW/6bv2kX+4m9ql0gcJLzWviHCFoOoJuNx8k7EV2MabHHeasSbjlLnZudh79fbA7PnVdixHZSm7LnWB1n8xMrdHw/XKkkjLeGskuKMYSVtRYxo86Hl0LAu23ySnK7e9oAp0h81dsYshSdmFZ5v5xcycosv+JsE/Pb7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBjHD95j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBjHD95j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7C11F000FF;
	Wed, 30 Sep 2026 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789658;
	bh=Sg+SGquWNrQI9ZpiQWc79UYcnJdrVWjKAR/ZiPVwFhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NBjHD95jOTla6yU4Vc5870/GWqsFepEMUsi9DQdrYzv74YAXtDVwJ3AUJLocOEV/Q
	 0bv1pY03ntGvnS1Xgn4T2svQLw5T2vIIwwt/TAbl5djhP1kDt3HbrqFdUlNcGsTy4D
	 KAILZT9deqxt9wnYkyIrb/ybU6gnzQ5nz26HjH6n56cpcKOUbAUTWBlBgzUgwqwWCi
	 xNHr6l5UULeZGffGxIPo63tgVJGfBjfWz30n55INTSmI47036roCR6+Wk107f4yZhl
	 1rPo1qMz0a9xHJckroL2SDLTx/dQtfcGdDs3z6TibrVzNdIUGo+z//0CDAvuKKIJxk
	 NkyiNAScSvgYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
Date: Wed, 30 Sep 2026 13:34:14 -0400
Message-ID: <20260930173416.3643771-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092944-ranked-citadel-c0d8@gregkh>
References: <2026092944-ranked-citadel-c0d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit fc8789bb57e625e5f32ac57ca2e7d3e7b7fda225 ]

SMB2_open() only fills the fixed fields, so a stack-allocated
smb2_file_all_info is sufficient here.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 566820af017e ("smb: client: close handle after create-context parsing failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/link.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
index 82156543f1f91..433dce48a6874 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -343,7 +343,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct smb2_file_all_info *pfile_info = NULL;
+	struct smb2_file_all_info file_info = {};
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
@@ -359,20 +359,12 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	if (utf16_path == NULL)
 		return -ENOMEM;
 
-	pfile_info = kzalloc(sizeof(struct smb2_file_all_info) + PATH_MAX * 2,
-			     GFP_KERNEL);
-
-	if (pfile_info == NULL) {
-		kfree(utf16_path);
-		return  -ENOMEM;
-	}
-
-	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, pfile_info, NULL,
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, &file_info, NULL,
 		       NULL, NULL);
 	if (rc)
 		goto qmf_out_open_fail;
 
-	if (pfile_info->EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
+	if (file_info.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
 		/* it's not a symlink */
 		rc = -ENOENT; /* Is there a better rc to return? */
 		goto qmf_out;
@@ -390,7 +382,6 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 qmf_out_open_fail:
 	kfree(utf16_path);
-	kfree(pfile_info);
 	return rc;
 }
 
-- 
2.53.0


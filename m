Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF70233704
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493379; cv=none; b=OTGYhSuS+NxSIqdjUku6LgB8VGAaNtVO22Vb0N6sDnMeo+kY4CHEBZsjagWZ7U8HJXa16RNU3Ca9IQwBETRUffWH4M2DLIjeIl9pALtG7XQa+j2SqJF7vZyrvVZPFkp2ttjpZQpjFPbLDGVAiS0P5Fq4XHym4SMqV3pbrUBMRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493379; c=relaxed/simple;
	bh=bjQxt4Wu7a23G3o3wgdxwWJl2krpMF8us4Nxpl9Ye9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppkV7kfROk0kfaQgztI1vTnS3RIuCKiuatkdr6OdHmXYvQfBozgTnQFXYFkwWnXTnrytIfINmAKkjHYIRcB9qOuuUvChmrgbY5k5/mJUWsp41DFuHbafV2HXgdM8DP13K4POLNbGZ5Y4hh7rpLMGX3Oh7oLOgQTXyRz9gcDVNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqky+wdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqky+wdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739421F00A3A;
	Wed, 12 Aug 2026 00:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493378;
	bh=ppau5VXnltGAaICxpSdAjkJpEEOIPN5H4dJdQilR204=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aqky+wdifL3dJVxp++6gs1bhm4oiP/y6944oHlwHyMcb3id29zfocWzBChJILZzxx
	 /VLRTJ4AD2yJ25hhVWV3rA+qADAMUdttPGm0uWdvXaiukkSssdVO+bllw1lMyniz/X
	 oA0ZJLqfpza76PqRVR5hue1HktGFYPh7zEVeayVIiqT8TlWvaGF4ICVCpBZ+VVu6pv
	 C0P7WI+9XcwIvSKvo/1nwLxaAHScb03oewO0kpGtbxTxN/GlSRIQfva2lKiPzwurnr
	 2EWbu55a402GI0NecTRKV0rmpNdAK8+zm2garHikPnF64BoxlVZ7GL7UG1zlLyUmWw
	 Zfb7/zdPotPHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Huiwen He <hehuiwen@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] cifs: add fscache_resize_cookie() to cifs_setsize()
Date: Tue, 11 Aug 2026 20:09:33 -0400
Message-ID: <20260812000933.4158055-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812000933.4158055-1-sashal@kernel.org>
References: <2026080558-upstream-wooing-96aa@gregkh>
 <20260812000933.4158055-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit fa724e235cfdb0fb0bb427d0f9dfe864ae27403e ]

Several code paths update the VFS inode size by calling
netfs_resize_file() and cifs_setsize(), but omit the corresponding
fscache_resize_cookie() call, leaving the fscache cookie out of sync
with the actual file size:

  - cifs_file_set_size() in inode.c: server-side truncation via setattr
  - cifs_do_truncate() in file.c: truncates to zero on O_TRUNC open
  - smb2_duplicate_extents() in smb2ops.c: file clone extending EOF
  - smb3_simple_falloc() in smb2ops.c: two branches that extend EOF
    via write-range and SMB2_set_eof respectively

Since every caller of cifs_setsize() must resize the fscache cookie,
add the call to cifs_setsize() itself, consistent with how
truncate_pagecache() is already consolidated there.

Fixes: 70431bfd825d ("cifs: Support fscache indexing rewrite")
Fixes: 93a43155127f ("cifs: Fix missing set of remote_i_size")
Fixes: 110fee6b9bb5 ("smb: client: fix missing timestamp updates with O_TRUNC")
Fixes: 7a06d3b816d7 ("smb/client: emulate small EOF-extending mode 0 fallocate ranges")
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>
Cc: Huiwen He <hehuiwen@kylinos.cn>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 453a5df20f8cc..b67b316538b83 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2966,6 +2966,7 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 	cifs_i->time = 0;
 	truncate_pagecache(inode, offset);
 	netfs_wait_for_outstanding_io(inode);
+	fscache_resize_cookie(cifs_inode_cookie(inode), offset);
 }
 
 static int
-- 
2.53.0


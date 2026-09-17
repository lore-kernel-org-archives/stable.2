Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59714E324A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673672; cv=none; b=WMuSbK3cHuyylVACHOskb5/of7NDm99YnXLC7EaHJLC0YseQXtshSv5VZ4IAG2jIT/h8QRtdPpZfLGhcBtCFQOKIW6tAU6kB6+WG4S0puLl/ZTfPfVmuJ1+az4ZDgi4/wP94VtbyvZ/usrO8vHA83mEgA1RtJ09trzIWsOQUP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673672; c=relaxed/simple;
	bh=gakXj3YVdsi35+HYYEheuzyPeBAzBq21osSPHxgiUt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjWGi2IjV7Wsro+GkY6Q99M34gdX8pRRfnoWhDdIRCAiOpbzvnWyTLrsu/FXdwXrGVmj5SLxRgQWdpHglBkKmVX6/irAIwuyHdjq98DnWV3+DyxYPDm4be4SoiP5IC7teE4pBoXSPUAzyK8KEihrteDwolaWYvW3DNAKFDql3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZe4f+7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZe4f+7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78D81F0089D;
	Thu, 17 Sep 2026 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673667;
	bh=1GkC2/JMh8VyypgGgOJIYEb25F1hPlvEy8iWQeoQzwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZe4f+7dQs0mnSVNXR/rFUSwUZIkDZFGoxqATr7BXotwZIawmfDQ10n+7nFJS0hlY
	 8y6/YwsQFjoS5Zgcv0+2NI8rFIr6swVSikC0FNBF0xsc2dwFCiDaASCRSt2fYgUmYa
	 yN7+LGpfFGJsowFxU/b4sjlq6a3s2okXctJG6A7qKpL/2yCy5EH29MsTzCigMJ+rH7
	 uEIFGMJTw7vnTPNK/Rc/JVyPHMQO/dFSRG7odNen/aQN0laoLLIrc+tYhjyb7kl2zW
	 UaSbsKzHgOSr8+mTgjDj4P+HkBEwWslqSgcIFTCpDNb+95JDOfV/UVbQJuf8MUwpL8
	 3SC2G9SKd4sFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()
Date: Thu, 17 Sep 2026 15:34:25 -0400
Message-ID: <20260917193425.1233011-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091630-viscosity-landless-276f@gregkh>
References: <2026091630-viscosity-landless-276f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit da6e25842431982d5a53cf00d925b98c690f4467 ]

cifs_posix_to_fattr() ignores the return value of posix_info_parse().
When a malformed POSIX directory entry is encountered (e.g. invalid
SID lengths from an untrusted server), posix_info_parse() returns -1
without populating the 'parsed' struct.  The uninitialized stack
memory in parsed.owner and parsed.group is then passed to
sid_to_id(), which processes the garbage bytes and passes them to
request_key() to construct a SID string, potentially leaking kernel
stack contents to the userspace idmap daemon.

Fix this by checking the return value and skipping the SID-to-id
mapping when parsing fails.  The remaining fattr fields (timestamps,
mode, etc.) are populated directly from the 'info' pointer so they
are unaffected.

Closes: https://sashiko.dev/#/patchset/20260906172005.627163-1-pc%40manguebit.org
Closes: https://sashiko.dev/#/patchset/20260906181540.647469-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
[ adapted to 5.15’s older ownership handling by explicitly initializing UID/GID from mount defaults. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/readdir.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 7c47a03afbcc3..d7edf8ae18967 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -233,8 +233,9 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 		    struct cifs_sb_info *cifs_sb)
 {
 	struct smb2_posix_info_parsed parsed;
+	int rc;
 
-	posix_info_parse(info, NULL, &parsed);
+	rc = posix_info_parse(info, NULL, &parsed);
 
 	memset(fattr, 0, sizeof(*fattr));
 	fattr->cf_uniqueid = le64_to_cpu(info->Inode);
@@ -276,8 +277,15 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 	if (reparse_file_needs_reval(fattr))
 		fattr->cf_flags |= CIFS_FATTR_NEED_REVAL;
 
-	sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
-	sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
+	fattr->cf_uid = cifs_sb->ctx->linux_uid;
+	fattr->cf_gid = cifs_sb->ctx->linux_gid;
+	if (rc < 0) {
+		cifs_dbg(VFS, "%s: failed to parse SIDs: %d\n",
+			 __func__, rc);
+	} else {
+		sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
+		sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
+	}
 }
 
 static void __dir_info_to_fattr(struct cifs_fattr *fattr, const void *info)
-- 
2.53.0


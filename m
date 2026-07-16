Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EEE41A561
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200852; cv=none; b=RLj+/DAOk1S0XoO0ShBXGnaYg/+8kdcjCtFyTBjOpFoB/wQzpR/hqfdEKILdW4HB9V+u3tSG/5Recba0AE3fkgc48D7anA9oIbQFmu7AZiNnu6lEnA//iK+7iXU7zOQJEG8gURWf738HL/FQuc82LTQSkZa7iqL0D7YTDY8Uyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200852; c=relaxed/simple;
	bh=7FHtFcRfMqI6z6E1VCVGxpqkGBc+W1f8Yxzn4M0KhmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsjsPXruzwnkOIFof7FfUmb1gv/l+WVSg+52mCufy4+mqj4rcUkhTttu4mVxlX84KBXgpyMcWRtNRj1H2OS0gOgYngXGAp4kEKXBEk9WSyvu+gI70gpWLAWUO31n82dgmGUcIeXMzWOLV1o/sD7R3v/AGJYTaM1HhmviETffWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gheWoIcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gheWoIcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB961F00A3A;
	Thu, 16 Jul 2026 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784200851;
	bh=eyCRh9b1WMA3EC06HVcs1YTa5Wu4oyjI4vz/L0YfIrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gheWoIcRQXSv+e8SirpsgrYGCjE7WhdmnpSDKDfa+bo1VQ95DRtghBBga3UX3WcmM
	 Lt7qgb1WS9nSgT8kCK1BBSSBoi0UpzeJRX5/hlzKDFIMiiDYars8/IjEIDT7zIeNLr
	 7P3k8AuCSkrJZMJG6biWStyhHK8pzabITJi8zuCzuGKfn4RPPb46L1LPxEdOvlOq0E
	 O6YHk9/G7q3fpOk1hOOprv9ZtEmErn3RQIcKTUZDxxDNyJbmCxgHD2hmSDjbMVTrmh
	 YHDt5QFBE2S0Rd49pcEIryKKNN+r0aRfD0M3ctcVjt/Q88iyM9VVsvZx2WVZC5HeGg
	 qneseEAbquyEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] smb: client: Fix next buffer leak in receive_encrypted_standard()
Date: Thu, 16 Jul 2026 07:20:48 -0400
Message-ID: <20260716112048.1732964-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716112048.1732964-1-sashal@kernel.org>
References: <2026071454-probe-applicant-d9c0@gregkh>
 <20260716112048.1732964-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit 1c6267a1d5cf4c73b656f8181b310cbbb3e4767b ]

receive_encrypted_standard() allocates next_buffer before checking
whether the number of compound PDUs already reached MAX_COMPOUND. If
the limit check fails, the function returns immediately and the newly
allocated next_buffer is not assigned to server->smallbuf/server->bigbuf,
making it leaked.

Move the MAX_COMPOUND check before allocating next_buffer.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 2a640015c261bf..5acaab18380aa8 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5211,6 +5211,12 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+
+	if (*num_mids >= MAX_COMPOUND) {
+		cifs_server_dbg(VFS, "too many PDUs in compound\n");
+		return -1;
+	}
+
 	if (next_cmd) {
 		if (WARN_ON_ONCE(next_cmd > pdu_length))
 			return -1;
@@ -5234,10 +5240,6 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		mid_entry->resp_buf_size = server->pdu_size;
 	}
 
-	if (*num_mids >= MAX_COMPOUND) {
-		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-		return -1;
-	}
 	bufs[*num_mids] = buf;
 	mids[(*num_mids)++] = mid_entry;
 
-- 
2.53.0


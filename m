Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35425442FDF
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451294; cv=none; b=fFltzxgmYkaQhN9UtZl7k2Kxc3UQ2Xd3RlgRca0plA8kcKSU84GsjQBp4WmBr8j0G90ZtyTwa3wFsLZZYpmv5JT2CkDbgrS+5np4mqMdpYrHwXrAJegNH1bRsKGO+Cpl5U7tpU/A+u0Br/Gz4gLtKd7x7HRZmc8sZSznSkP6dXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451294; c=relaxed/simple;
	bh=+D6S2YDW9rQuqBnoRrnLBMfTOLa1VXOEeMTK1x2z25I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5AfgxAeMimMTnbH/NsO23nerZcfb/Uiqfx+pJ1iTwfXtnl5uFPMtZ4ahMplle5BW9BiNLhzKYxnpp9hIRvFUltuXLR3tj9hSFdpKE7bOTCETAJv5F10xBqzfk2PdxsNZXIKaECbUbBhaioyyFEBHbgIXk9UxJr3F3Y3zLWK9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKs4AzZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKs4AzZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CA31F000E9;
	Tue, 11 Aug 2026 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786451292;
	bh=RWJIOgkWf+2j1VIrUriZj487YUsm2MAov6Ps+Ukn24s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BKs4AzZeSOQV4KEZdJk8sHfdR/6FKD8Q9Ra7R/iCg03cHAdSxQqnaogpU0dFeHyCL
	 BCshQfBLo2CTruzz3PS5L+LTe2e9JQwG1hWcofBofkHtLgccPI3FYfBrIBVttASXvD
	 e+yD9VOdLy+Gnh8tovx5NdSDH+XA4YT9Uj7EraoWrMYbv4h4fQSu+9h+LYTQschOWZ
	 jQQmZadGze/qM7+3hQvaLr3TS9vjf/CmX1KbE73vDoKe7heI8dygVfgFakTNVqMhiG
	 miSxs5OBoTGjfQrcfe9hZ5DNKlpnAPEwxuIQyib7OD+ftWCRN2+elABTVNRi4NnEWG
	 bW0i2w1oQtJaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ksmbd: conn lock to serialize smb2 negotiate
Date: Tue, 11 Aug 2026 08:28:08 -0400
Message-ID: <20260811122809.2388863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080543-chunk-untitled-292b@gregkh>
References: <2026080543-chunk-untitled-292b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit fe4ed2f09b492e3507615a053814daa8fafdecb1 ]

If client send parallel smb2 negotiate request on same connection,
ksmbd_conn can be racy. smb2 negotiate handling that are not
performance-related can be serialized with conn lock.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: cb469993b3a6 ("ksmbd: reject repeated SMB2 NEGOTIATE requests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8ea6d4ce3a1f1..d54a24255fa7c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1126,6 +1126,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 		return rc;
 	}
 
+	ksmbd_conn_lock(conn);
 	smb2_buf_len = get_rfc1002_len(work->request_buf);
 	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
 	if (smb2_neg_size > smb2_buf_len) {
@@ -1275,6 +1276,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	ksmbd_conn_set_need_negotiate(conn);
 
 err_out:
+	ksmbd_conn_unlock(conn);
 	if (rc)
 		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 
-- 
2.53.0


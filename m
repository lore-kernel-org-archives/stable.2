Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA082DF68
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451726; cv=none; b=geVCF6xzJ3rPQHICoyjyWoEwIASs3r7mXMsfoj4AlrXHv0DUf/rxG1esEjcW/GGm+YBC7JBpuyYFZ6CoFpNnQ7Wj0D+yfwedx69YV9oOM5e9VFZdVeTNw2mMAhCrg7j+39kzMMeXHt+eOWbLTQexejU9F9ytX6De6fCnKe86b4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451726; c=relaxed/simple;
	bh=wt85H6ehDCn6W45tZQ/yfT5f89znxVh2wJLtrHSpI3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9hXYAqKINub82EEU1zVezRauu6RbxPsUJIiwbxfqv8oh3YHLmc4tilk9VQTDVU20jbMQMgXnHl6qPVv0k3rv8rX6awSF4LfjtRlMQWsvjRwJWmpo99Pv6mIlBUivH77L83stx3bwBXIf6YHhL/hDIm64oXXBXr40kTg44UvZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W18ULIvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W18ULIvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D611F000E9;
	Tue, 11 Aug 2026 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786451724;
	bh=VUHNAlSxelCqjpSO3ldDsfMRiFhI8KVyD+xJRjb7AP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W18ULIvtLXer1hCFiUoc1ss03esUmzAD+dYQ4F04bn7Y5y4S1tf347WKcsCc9wPYq
	 /A/1AstHjn2j0yjSoUCe1sF+VVPJdxJeJKHHaucvjHJkuc0EjOSiXU2ZgobJ5QNpG2
	 UCG8fFeqt+3JIhIICHN4bViwod4BOm3TrspxmwZFyANkMUCI0haqES06Th00kergVn
	 Zqv0ekJTsQH2ySEkR1NTqiS6uTMfcyye+I4lUpCJiK67KajJ+kDPFg3dO6NGf2U89H
	 zhD9Nd+GVHDilyUpYoKOWExHAkuBXkgN5d6Dq5uT8E/m6OojO0zN7LmHDuYLRbG7TQ
	 mM31X4Q1M+CzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ksmbd: conn lock to serialize smb2 negotiate
Date: Tue, 11 Aug 2026 08:35:18 -0400
Message-ID: <20260811123519.2401179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080544-grader-underline-e8ab@gregkh>
References: <2026080544-grader-underline-e8ab@gregkh>
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
 fs/ksmbd/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f7eeb79be48ab..11c7253e5189b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF0442FD8
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450527; cv=none; b=juwCG5KrOG1gVwg1ydhLoHRWtdi+VrIBfqWdhSDgtHpSBHspnYrq446tvIPwK+zc6hMZkb2AKUUflyXzzQ840ysVAnU2mr5Kqc2/lqXH4wv38V6yJDMdypMZUKsCytvUetbDB2I2lQiAplPQ3wIGL6KpL5YIv0+ewsZRqqHJSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450527; c=relaxed/simple;
	bh=7f9EyVlNVM7/qL6XyDZnnC4ff6WTJ4dNwX0Z3XfYGhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbUz8t2gStayY7LUYUEXSGQyJQxyEU5b5n56QIc80Wj2O/A9aHdJsqxmmKFRatBKGKUtmYxeygX110O04ZWBgF+fwzBtZsWpyQB9xXm6C6iSzPJ0tqzcKSqtq6ijrMTqWQPJJ7MMn1jtaPy4GjvFGRgiCvDLOzRbNjhfitHf2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca0LqtBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca0LqtBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF111F00A3A;
	Tue, 11 Aug 2026 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786450525;
	bh=WnVl/IRyzdR9o37Nfw6XmOCrUCHehEMZijAIM0m/pa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ca0LqtBpwiDfDQwC3fRLnwrGlnurC43vNQre1ZNNm7T91c4MPQPb+xZkEJuxOi+Ti
	 woFz7CeSvphsgWNxll+VRxw3jthcDZITtCNPTXo+gqoGfgkutMYIUwmtvZ8Z4KR76I
	 V4Je6dcQGS8veyd0BuSR+oWLMRk7xCv1+Z9BE+Y3eAdzUhk0iC0MV/AHcrA3bWaYai
	 xWyWrIBZ+McRYsqUTuiEbvFZZJgpo7st31TLFoupSvWDYnAwOnaH/lftvWHHkWP7Ck
	 2cAzcd7d4aZu0WgS8SPvFnYlY6qbp2mj+fDuLrayBSedq4R+hWmKT68wBn4GnpT+kG
	 J5IbBztKfzd+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ksmbd: conn lock to serialize smb2 negotiate
Date: Tue, 11 Aug 2026 08:15:21 -0400
Message-ID: <20260811121523.2373634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080543-praising-unhappy-8689@gregkh>
References: <2026080543-praising-unhappy-8689@gregkh>
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
index 41bc4b06fad08..3098c8b98ac27 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1114,6 +1114,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 		return rc;
 	}
 
+	ksmbd_conn_lock(conn);
 	smb2_buf_len = get_rfc1002_len(work->request_buf);
 	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
 	if (smb2_neg_size > smb2_buf_len) {
@@ -1264,6 +1265,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	ksmbd_conn_set_need_setup(conn);
 
 err_out:
+	ksmbd_conn_unlock(conn);
 	if (rc)
 		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 
-- 
2.53.0


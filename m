Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0473806D9
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447062; cv=none; b=CnRDKVW23AkfaLVBWK8kfGqY9uL9z65s2eZlKE4P6ji61CGcWYCrb0NLbX62SFdzgyIcDwK2vMiFnFpHGPrE0HzXSSwcGow2y0f889v7d8tqnRSPIlsB2Gmb54SQnm/abHGKlpIDppYGOV8fJeI6ONWDDTRY5ufR044vUbb/i20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447062; c=relaxed/simple;
	bh=lfPv2jHWUPEw8T2VjI0khp22LzcWzdmovHM616Gfwjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOJFmJ8SAbv95HAc+9OLc9wrq4CeB3HiaIcfe9vrgFpNvL2V/rhF/v26t0JNOZ1iJAPO+MCDC1uK0WijXFp91UIiyhDnjKKSCv1unmCSjD39VUbNn+eqhfQw949okWbz3fkjifSYIdewrbPQl2s95+lX5+itUhCFOBIAC8VFu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0O1GLrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0O1GLrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B342C1F000E9;
	Tue, 11 Aug 2026 11:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447061;
	bh=dRCvnXnjUFYtMxqZQtPMaKq30Z2IW55dV+Jz/5oRhUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W0O1GLrBpH7EJ5JuZnaXevyxkuxQP+2lKA/F1wuMtP8Cmm32oI6Z+7YmlwHPnBgOl
	 M9diNJ6Lqam8uQOTM69bZQ0eQ13V5X7cu++Yl5xvaPigaotJDmIj/2n+eTjTR6ITPW
	 kIUfMF1BEQmGCL61uDGAQceXyBnKAlgZNRu3ogSbtt6v4FXR0nRcugpd8+VckwcK3/
	 yVEVBMk8cjD3TreoG68jUN63sfnYNtY+1OfMMrnqGLCt/6BTr5D3t6MJzjHEvDjNdJ
	 iTnIsPQph6aYPYbdTuGRnCFzzz65KSRtIG6yZ3xWaT5jp+4SHxhvO664TiBwhL93LW
	 3PXMimj0E63hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ksmbd: conn lock to serialize smb2 negotiate
Date: Tue, 11 Aug 2026 07:17:37 -0400
Message-ID: <20260811111738.2260355-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080542-stadium-unbaked-f538@gregkh>
References: <2026080542-stadium-unbaked-f538@gregkh>
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
index e9f047061632b..180ce5bd1e2a4 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1120,6 +1120,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 		return rc;
 	}
 
+	ksmbd_conn_lock(conn);
 	smb2_buf_len = get_rfc1002_len(work->request_buf);
 	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
 	if (smb2_neg_size > smb2_buf_len) {
@@ -1270,6 +1271,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	ksmbd_conn_set_need_setup(conn);
 
 err_out:
+	ksmbd_conn_unlock(conn);
 	if (rc)
 		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 
-- 
2.53.0


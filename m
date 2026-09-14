Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A53A1CEA
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411435; cv=none; b=ZXXWpfx+OmIHCyjgIBquIz1Ff/W60gXDi5OdnILlJrylRbTODu2CVfOGUUZw5hi31/CTRjUiscFpWrQQUKCAO/NKSBQbQSMVajYyzpRLdwKmIDa/F2hLYELXhxxBNpq5Wyu4097q9Cp48n9h6N9COIdGYYKBz1g5G9soU3XfyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411435; c=relaxed/simple;
	bh=cPsKnKj34kz+iYIOlrInzGovVqVNJ5EGJtvuNUgFFao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZ0ctLn3pQxd9dsccNk1IUokr8dVGaeGdi0NjvhF9Y7fHo3H//ADABvjjMcXF+SrmDRBU+bHe9nIZ28fJgGKi3brZrdOK4gHcsJzRiE8QhDJ6q2EoH0oKiMnmolfbQG8hKafpu7a1dU2BNlUrcqbjzjojd9PclPn/WlJfmpfCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQL31oOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQL31oOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692631F00898;
	Mon, 14 Sep 2026 18:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789411433;
	bh=7ePNm4QVD5I4oXNVGjGruRyKXKuPg7MJeJ1yMnrgcNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQL31oOTbo7TDiX7gxfk5Fahi8PcjM/7BjEXH1+u6Nb7nezNPj35xdJ5DBBdKCCeR
	 AxHI0cPKXIRRZaAvuaxOjDhBx0MMmP4vxOna5SCLGSgwrG77iGiu+C8th6jkEAi956
	 vfN192mrYF8+4mYMJWYjBfZHswDhh0I9QbPzkIdxnWgf/DrrJjIa5sGHx6qiEyNg2w
	 rw7nLL7Vl9dfPMYs+HTf+FGXosymqRQMDpUg6FE9y/vGNVpqRzKuGxCYqqWJHxpH0b
	 MPvxrVr11WDjKN3tSAHpqV/9mAuMag0ZzuCtPctj3yOnMj/uXzNW5zfRLGgrJ01eI4
	 vwCJ09PdEzfAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] ksmbd: Use struct_size() to improve smb_direct_rdma_xmit()
Date: Mon, 14 Sep 2026 14:43:46 -0400
Message-ID: <20260914184350.571525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091413-gills-macarena-de56@gregkh>
References: <2026091413-gills-macarena-de56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 9c383396362a4d1db99ed5240f4708d443361ef3 ]

Use struct_size() to calculate the number of bytes to allocate for a
new message.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config responses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 6ea73fe6de6c5..5e0d821d0807e 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1380,8 +1380,8 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 	/* build rdma_rw_ctx for each descriptor */
 	desc_buf = buf;
 	for (i = 0; i < desc_num; i++) {
-		msg = kzalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
-			      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
+		msg = kzalloc(struct_size(msg, sg_list, SG_CHUNK_SIZE),
+			      GFP_KERNEL);
 		if (!msg) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.53.0


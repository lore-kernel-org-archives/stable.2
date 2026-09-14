Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95347728D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399837; cv=none; b=WJz2FO9AoMAmz5wFaYTt4Z2ACpGCvSmQNEOt/+5ozy6lUURnlPqzJYRuVPOfIrvFZELPGU1atfnoSETN/okCfDRINSEi8Rarni3J1CSCcoLewkXngdLybuuHmOkymiPXgyoeFfu03WZxUTSHSTH6lckFOy3K3LP+Xq4+itp7P2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399837; c=relaxed/simple;
	bh=dmBwPaXVQgjv6lvbH6HBs8L8qdGwO6Gy+hr+/cGFBFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=We4uyaaY5SpcwmOlpsLCbuYAacs/4v00r7DBI/dVd87q0wowGALiKJk9nU5wn/BEpnRq2/5gHqPu/40e/NtAId/QaRAE4YkQlunuIUuaUZsfu5maZfnl3cVnnpUn9EtqfFCQD0WSKsvPMYq+QHcxvujb0+gyA/F/ZLlEoaDoh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QejdQVi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QejdQVi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCB71F000FF;
	Mon, 14 Sep 2026 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399835;
	bh=E11rbbthFfZA/jZIVSDjmzqgTdqpuXwKyq9ZjBDrtag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QejdQVi34U1XtDugy8wkdd3hkkz+uqy0S8bYbsykvvnUGV2HndarjeGNhaIdct5Lo
	 PmE74pbY/xQM/1AJW63cWp8m1d5tloYVj5YU4ZAh/gl2XzsZ81/u7XECBOlnJ/AACc
	 5a9eGDNDh6goIs/RuKc16Oo7H0vb7d8zrM4Bw39bFROo7EAY9NPxEucmzz/ze0D1Zo
	 I4TylJ4x+wqy5zPwEFshNhyQNH771aFusdjfx8nowScEE2oQ+uvP9oYnLOyYdyZAV7
	 lt2JrsbX8Za7FXtu/pPt2ddNyCENn7hXNPOofybJU+wKgDF2aFi6gpPxtgs8O9DYL2
	 GDHaVxoHGYkKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] ksmbd: Use struct_size() to improve smb_direct_rdma_xmit()
Date: Mon, 14 Sep 2026 11:30:29 -0400
Message-ID: <20260914153033.392874-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091412-bottom-cadillac-a0fb@gregkh>
References: <2026091412-bottom-cadillac-a0fb@gregkh>
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
 fs/smb/server/transport_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 1290c0fa7dd18..6a58675deb5a8 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1397,8 +1397,8 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
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


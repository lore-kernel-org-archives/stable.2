Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114C38A73B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054078; cv=none; b=E4VOx5avs8l2a6w1tm1EHyeWGf4Afbu16YgZ9CGn2bUjWF5QqSVMNtZs/z38oUBRWR3P5jgyEXyYWuZlE8RvSZZLwHUyA6z0pXqtOz/cFQ3mSSh4+++L/rv8WnhZM0xE40EiBKTQb+DfLPm2nfBHK1bnhjNVJEzAu8K6NjBVbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054078; c=relaxed/simple;
	bh=dq2bEqIbogGLLQJ7tAqupLT015W1C0riz2pQN2ygk5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPlfOhv+Bf+AQwcFPaDQ6e62aYNp9Oab11vrIkncUypF092h3/VVEQEj3HsxF326zuVfIdjBAjxtYUv9ycKG2CggHKEI6oULhRMJLwHEuLNai6jXxhZ31pNKPSas3dRho2EvvNBfgMxXfvsQLa8YO4yDTfa/Fk/pB7wx8k1uM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSzz3+Yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSzz3+Yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B281F00898;
	Thu, 10 Sep 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054077;
	bh=XSyDEO3C7cXEb0BjiVgDGoWh+TbQ/RsIjzFAh+43qao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RSzz3+YoU8Cb/Jwfqkj7Udi57RcGVWgourlD57GO611LrvozJlxcRnsxEcfupX0nK
	 Sc0ct4GAEQQeicikJ4dp8Gp5SNjlHsBTKW5KovhojuVTOY/By7yvzdkO19+TyBrsve
	 /wxx7h3Epzrz1v7fyvOiN+TqygrOOm3rEwxjkb+8rzdD+pUp1z9onslkT2d0nVjx/h
	 UO6rS1PEenDUmu99yoN//vaIbj29gA7MZDYadSgRq9m5lWSYnZXoSCUCFG7gkD8pGx
	 yGiZKC24USjcNydqimXi84mm117bSeSAqDp2m4vhuMVWsQu+khjK4M3ffgsmcyCVfW
	 zkG0Kc6Isjz7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ze Tan <tanze@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/3] smb/server: fix tree connection leak in smb2_tree_connect()
Date: Thu, 10 Sep 2026 11:27:53 -0400
Message-ID: <20260910152754.950820-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910152754.950820-1-sashal@kernel.org>
References: <2026090802-tactical-overplay-91bf@gregkh>
 <20260910152754.950820-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ze Tan <tanze@kylinos.cn>

[ Upstream commit 39f2032096715daae5f6fd0f587ca7a474b019df ]

See the procedure below:

  smb2_tree_connect
    ksmbd_tree_conn_connect
      xa_store(&sess->tree_conns, tree_conn->id, tree_conn)
      ksmbd_counter_inc(KSMBD_COUNTER_TREE_CONNS)
      ksmbd_share_tree_conn_inc(sc)
    ksmbd_iov_pin_rsp // fail
    status.ret = KSMBD_TREE_CONN_STATUS_NOMEM
    // do not disconnect tree_conn

Disconnect the new tree connection if ksmbd_iov_pin_rsp() fails.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Signed-off-by: Ze Tan <tanze@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: b5ec6c462aab ("ksmbd: fix tree connection use-after-free in smb2_tree_connect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 9b3ffa0929805..64142c1d9020a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2330,8 +2330,16 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		rsp->ShareFlags |= cpu_to_le32(SMB2_SHAREFLAG_COMPRESS_DATA);
 
 	rc = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_tree_connect_rsp));
-	if (rc)
+	if (rc) {
+		if (status.ret == KSMBD_TREE_CONN_STATUS_OK) {
+			down_write(&sess->tree_conns_lock);
+			status.tree_conn->t_state = TREE_DISCONNECTED;
+			up_write(&sess->tree_conns_lock);
+			ksmbd_tree_conn_disconnect(sess, status.tree_conn);
+			status.tree_conn = NULL;
+		}
 		status.ret = KSMBD_TREE_CONN_STATUS_NOMEM;
+	}
 
 	if (!IS_ERR(treename))
 		kfree(treename);
-- 
2.53.0


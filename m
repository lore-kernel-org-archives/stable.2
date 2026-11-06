Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929989;
	b=IHUvLzEYMKjchc0kcCD7WK9YEVAVfyb/QK84RELcMbUfNJ6Q204zHCy4cbt6jKkXHoXO
	 sc+TpQn6iPRSUiU6o7L5MQ0OtH32FlTddMpqDsvStHgqUNQqFRpWwAmDB8jKH/qLiMMoa
	 vB+CEQjZXZPDuz9RZQXplwqVzp6CCkDc1inyfuydkSWKbkknWxhf2h8GFU2enqoV5yMRu
	 R6P3Ae8PWcvToIXj2Yj5kU6qYYKsD7/6/neJIi/z7U02OMKFol/0qCuoeskQ4OaHGRvNx
	 VeDxaacyKgPMQYlAUnbkk+5vs7H+Q2ILWfurp7747Hr+bAM/t1h3J/Gvb/bwu/HhxoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rf96QKX6SpdKmx9ZRKdJREbHTyUGet1s5yFIPz5IenA=;
	b=fPbazTQ84XtgqPDr6AI2t+Txd8aOBZU/VH0OucOccQTD6QZC85Pta80TbJM3d/e0yF/M
	 tfRbwfE0Qs7S3ZCylTdO+eUpbt8dd76kgvIkY7m8pOaogk3d/hueVJDLDtYqOV2PelSsQ
	 i0NOBDlxRQoD59h1KLbOpVR6E6HqH8JHxCmNQJn2k+Z/SyEhuW1t0lyfSvAYHurIka/ar
	 N+tqYtGfuC+rNa2lKnSY89quF6cUsomlgZ8fbvcczH3AMSoaOoKnQNI33FHFk1ApJ1E04
	 X+Gk3mjtUusExZpBXhNjzIjgCS+FfBf0nTQPeYgJDKNQl/9Wk32f8epTy6ky9rCJbDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxWWIAbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDF606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxWWIAbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016171F008A2;
	Fri,  6 Nov 2026 01:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929988;
	bh=Rf96QKX6SpdKmx9ZRKdJREbHTyUGet1s5yFIPz5IenA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxWWIAbnQ7Nggy/BdBu+1cvOvWz+7NUOqh8djTv6MWrx0JPj3otVjvjY3Q/x2mgo5
	 r43h/wsJhNBtcimafZSThcP2JCPwnUpd57dEJRVKZiEklunGO2l5cVG3TKNxgfNJ1E
	 MQjmRUjgagfR7qQ1YssMj54gzXA3+k/x7th3feYiAua2aZzEQqhx3Sdm3RQX2LkThl
	 mLYVbN6c6Dcnk2aUBNTUA2fgSYE7+0f02/peg8UX9CpiXLl4k8oUw93hCzMdg3nPSE
	 qMewY7e65Vpuf8HlTt/q40SjL+CulqhQOPZ1nnvmUUzEbYmxcZmoxkRdtBUszXKcwp
	 qTxssUT8qX/0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] exportfs: Complete kernel-doc for struct export_operations
Date: Thu,  5 Nov 2026 20:53:02 -0500
Message-ID: <20261106015245.3586810-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106015245.3586810-1-sashal@kernel.org>
References: <2026110409-glaucoma-strongman-8f52@gregkh>
 <20261106015245.3586810-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: André Almeida <andrealmeid@igalia.com>

[ Upstream commit 7a6f811e2c06d656996776771f0498df129a0cc2 ]

Write down the missing members definitions for struct export_operations,
using as a reference the commit messages that created the members.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Link: https://patch.msgid.link/20260112-tonyk-fs_uuid-v1-3-acc1889de772@igalia.com
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 5d28b2c920d9 ("nfsd: don't offer flexfiles layouts when NFSv3 isn't being served")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/exportfs.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index f0cf2714ec52d..0dc1bae9e1654 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -201,7 +201,7 @@ struct handle_to_path_ctx {
  * @commit_metadata: commit metadata changes to stable storage
  *
  * See Documentation/filesystems/nfs/exporting.rst for details on how to use
- * this interface correctly.
+ * this interface correctly and the definition of the flags.
  *
  * encode_fh:
  *    @encode_fh should store in the file handle fragment @fh (using at most
@@ -252,6 +252,19 @@ struct handle_to_path_ctx {
  * commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
  *
+ * @get_uuid:
+ *    Get a filesystem unique signature exposed to clients.
+ *
+ * @map_blocks:
+ *    Map and, if necessary, allocate blocks for a layout.
+ *
+ * @commit_blocks:
+ *    Commit blocks in a layout once the client is done with them.
+ *
+ * @flags:
+ *    Allows the filesystem to communicate to nfsd that it may want to do things
+ *    differently when dealing with it.
+ *
  * Locking rules:
  *    get_parent is called with child->d_inode->i_rwsem down
  *    get_name is not (which is possibly inconsistent)
-- 
2.53.0


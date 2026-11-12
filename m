Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450116;
	b=1VYIOtW37lb10wAOCalhuUe4BnJ4LXX4ATvreL5nlBhTQ+0wh5ClT0C4iHLzSqH2nVir
	 kyW6ioJl2vDInqWotqFQyLbTDhXIn6cn5drv6AEMOo6kEePJRIAog2Nso8YzXGf7SVv6n
	 NNofBDjwEZeSgRkkqVkFoHX+eKotMMfVvLpp+VMWh5U24wGUJqHzlWq8L1iTnKaoiltOO
	 iehe3oxKACYiAnkEOYqUKtJV5VKH4MBHazaMVMnGLF+hqYfzPMd4iUMRfTmLZEBizYfoD
	 wK/EMGjJPUw8iwlGCxv29HbVHIyDr+PAK2+bzANFjCzGVsP+ud6oNJSLQNpshuPfGvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BY0DqDK/obqB4hnuVirYoEUJ9t/TX/Y1bU7Sf3p58k8=;
	b=xtjcy6xxCIO+86nmoM47lmniW2tFL9uEHjOLzrFNzSfdQNcNbFPIhfW+AsjN+w2tSCux
	 dA7QRw8Aetvaim+p8jeC+V/hkExk7GCC/RyAng5ThTNuXZNp7hINuhfb2sEZQdLqrFbjt
	 Avj7rfKM2kEJakL++cKYLgB0HJj3y2rPH1kpWJREv8ATPM4p2xy+HvZAa0Ibhuc2lpryc
	 ha71P0jClXxbXuWJtylT98b/9Q7TKRT3eO5usuSZwHbENPhL4ljJGhEwI+O/JBpwuws/j
	 i4yF5JBtjEBeyyxaL2Sh4IH8gLZsw+5sKX10iU0U1EE5v9CsQ2S3u2XqlvB40LgqqkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRkZwYYM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91851606A8A6
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRkZwYYM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616961F00A14;
	Thu, 12 Nov 2026 02:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450116;
	bh=BY0DqDK/obqB4hnuVirYoEUJ9t/TX/Y1bU7Sf3p58k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VRkZwYYM283IfzjypaRl2SsetbVL4t+FkO8cs8fzNDcm6ND03IF7fjNhE7hJBTESj
	 Tl0GGco9Oo1/8JXJ8B7/pkPwEuBiaufrX2IzVKsRvAWC9O1kiQroHB9qcRa20QGqmr
	 vneA6TevUlWkznWmKDugWzpojy8xBJzFFTm1Mn+H7skgE0GO93/kPR2hCx3zL1Us5m
	 1jz2zKojxn4xnMuUbA149B5ABUck+7bcsKIkZF+0Oc8hmmMBkhaD6fvT0FwTcjb177
	 i6DGAYYDCP3SPFiNimldQ0iLzCHoQ6pPLQ+xHSgJL9KwpBSJSrjPLJja26VCn0psNn
	 lTQK4OaCX/OGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Darong Lu <zzyy19904204639@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] libceph: initialize CRUSH choose argument weights
Date: Wed, 11 Nov 2026 21:21:53 -0500
Message-ID: <20261112021845.1355777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055516-failed-6.1-c3a995ff0782@kernel.org>
References: <20261107055516-failed-6.1-c3a995ff0782@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darong Lu <zzyy19904204639@163.com>

[ Upstream commit c3a995ff0782587789333c621e1f6bd5e574371e ]

Initialize the CRUSH choose argument weight-set array before decoding so
entries start in a defined state while the decoder fills them.

Cc: stable@vger.kernel.org
Fixes: 5cf9c4a9959b ("libceph, crush: per-pool crush_choose_arg_map for crush_do_rule()")
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Darong Lu <zzyy19904204639@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ sashal: used kcalloc() with an explicit element size instead of kzalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 803514a1bc7ce..fdb8c398f5ecd 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -320,7 +320,7 @@ static int decode_choose_arg(void **p, void *end, struct crush_choose_arg *arg)
 	if (arg->weight_set_size) {
 		u32 i;
 
-		arg->weight_set = kmalloc_array(arg->weight_set_size,
+		arg->weight_set = kcalloc(arg->weight_set_size,
 						sizeof(*arg->weight_set),
 						GFP_NOIO);
 		if (!arg->weight_set)
-- 
2.53.0


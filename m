Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448804;
	b=AQMLRKiiSjJ6hQZgYGOJJIh10vb1Tw0UXL5JQAFIRDRES0Ey0arAcB/6BRAyW41wjHIK
	 luPY8qB1jLRi0tiC+OAqau7dZHdOWBaalcyuzz/Keg9OEQUR/TlCWnDYxTkQI7OjWTRGt
	 EqsJlcswXg1q+npbnx+bHQfbCBC8itd0Yd1+8nvdlNV2HRwy6N4pLXh2komBIAOMorJ3b
	 RmnpOfC+7w4xHpyiKktrDaGqBSUU3prk5nPXn0R5yPUmQVgvBp+/4SP2foynvUTWFF2jQ
	 7kbdLZctq07scjCm7d8zyMTurBjTX+sCU1Ix511etnVRP9TGiatsZwq6u47s3uieoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448804;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8UDClBDS/Mma8RuKFJQcq+/fqiry+QMaAoA4/b88Chk=;
	b=3KrfOVKYTkbsD3xqG7Id2XKnvpu7YPBErWnSn9OJbwMl5cYwlKYPTbJs1hRLc0UZor7K
	 WFdVXoA0maSS3aDrTVfCXH5PYu5rQuuEHRyiyLQso8lxOYhngqiGnzb236oaRr2QDHL/s
	 PNEQNXGhvB+Pb8oB9Mb9mc1T8JQ39o3ZkcWj8jW2OwwxKv9yWYHD68KalL5+CuOuDbcqa
	 BU293spZQf6OlhEX3Ev7IUQsaPmncpOURV1PBBSDrrc65ImuoGXn5Ik1Hjj0vUvdWE6xb
	 Bkgi6YiVa2+kR5lO6HlZwGNPCzSlxRCNLgc/xugEJfBoSA/zAf7tq01HHua9DnKt06Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pa7J1AXV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B2606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pa7J1AXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EE11F00A05;
	Thu, 12 Nov 2026 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448803;
	bh=8UDClBDS/Mma8RuKFJQcq+/fqiry+QMaAoA4/b88Chk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pa7J1AXV62vlD/mkLGDjMKsS0X0cDPMC+CkwECFQVTw7DvDJk+GSf7IJlW30VsJct
	 a2C4/BsjDlX4n3sVCrwYSah4gNhwZF86QpU1H23SeGJqp5QZGu5y2eVUN4YnLxFs2T
	 vY72cImMz+5c6BqqkZVq4kJvepGCgarLDUFvdY4XmUd/WTlYPlCh4EdnLH1yNX1VhM
	 /3ZunSkhVAKWQa6iYYNDhTgsZWHPdow/T/FwSzjLUI1H9yazOvrF1pOyDLafpCSoHb
	 I1VwAN596ApMW4lWiad2Vi4BcKHXm2ramCNGITGpzFQA1xwP180+sBTFvX+p81CEyp
	 AyCn0WlGOindw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Darong Lu <zzyy19904204639@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] libceph: initialize CRUSH choose argument weights
Date: Wed, 11 Nov 2026 21:00:00 -0500
Message-ID: <20261112015526.1241689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051456-failed-6.18-c3a995ff0782@kernel.org>
References: <20261107051456-failed-6.18-c3a995ff0782@kernel.org>
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
[ sashal: Used kcalloc() instead of kzalloc_objs() to match the existing kmalloc_array() call. ]
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


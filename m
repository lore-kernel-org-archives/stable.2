Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449567;
	b=rR243Gpe0msnFqzmG0XVFWhXcy/g3tdCIZw1tU20TGCiRi/3lFFXdLGbcilf6pCNTiRT
	 a7ar5km78XseMkOX7SJFMfU4ZMX9W0fXpV1QxBr2CwAfCjMr0pXHWvdv4Szq5p3KfFyGy
	 04ZALtyfXCUae+B8+Z6SHyp0IdOccXF/epo3ghSBIiIdW4anY7GKCpIQAcOqZdfAZfzw2
	 vz4t64pFHhP1ROQvayANQdSx3EhSnPnvCA43nFvCeSrdFLwcyXXpBZVHMbVn8yWT1hCX1
	 hTI2zy+z7Ab44tpspnVbXd1toebdUXiOJoNIs8IzBirrN2reP3IWIlajeWFc2CVct5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BY0DqDK/obqB4hnuVirYoEUJ9t/TX/Y1bU7Sf3p58k8=;
	b=RRl4ciSxuBCcTfdwsd3Gsakn/CTddTF2A0TUJj45huOGSTtRbZTy2LlCK9ODM6Iqo8nJ
	 fF5DsuMXYSdJXRiLWO39kDiSFkJC0IlrmhtizLSJttW43SBkor3ydldK5aej6doZdAyEj
	 c0oeojYjauMTtUwZf2C2zNdc6CcOBnAziDZQTVwXDVrMCNn97FLKzpnDsmytboaXosTDj
	 9ONGHDPOgnooT73dafLbZ6jLjJ1vk7KVy8aHRyfBQqBDBIB73vbHchQaKFBUH/XAQz9Ox
	 jLCnUwBI8k+/6B9g+n4koS22hbIR/PnR3+QW/uM/WxmyGI5JF/nCqg0jWpzuQq5kYfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyZZsRfv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F28606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyZZsRfv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D38B1F00A05;
	Thu, 12 Nov 2026 02:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449566;
	bh=BY0DqDK/obqB4hnuVirYoEUJ9t/TX/Y1bU7Sf3p58k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cyZZsRfvSt0zmTARyZGMIIYUgVHm5qDtCkPHDtc+tA1htAQV4otc4OKLoS2aazQcf
	 ys0RGXOMI2ExM9o67Bkc/vVW3g+7oW325m8JYSkBc/CFON74eU4IEgZVDhN9oTrfbT
	 nTbTr58ZCcMwJfStDJFEwAhqYMobTDLCsqa40FbBSTVHU8MEzKSqDsiShPgRGhyroo
	 gOxnsLtotf5drR4tXV8japWnmgqLBPzzJ/yQl/0HHP9Wy+W4Mg7gaFfrrfbqdMvdhL
	 MdCi8k8Suc/NAy8r+sc27UAwVJsbV9B1w408vzuvgz2oDNujZ6rudIswZa4D5/Kg8I
	 74OBAylIo1KLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Darong Lu <zzyy19904204639@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] libceph: initialize CRUSH choose argument weights
Date: Wed, 11 Nov 2026 21:12:43 -0500
Message-ID: <20261112021025.1315163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053933-failed-6.6-c3a995ff0782@kernel.org>
References: <20261107053933-failed-6.6-c3a995ff0782@kernel.org>
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


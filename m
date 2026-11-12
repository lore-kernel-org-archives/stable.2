Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450546;
	b=boydhytD0mvUjKABiiCGG2ltddu9j+fv1eN8niMI7CHL7S7zh7M9sSrvdHhMLjaUn05I
	 84M5378DZF3OXv/Sph/pFxIg/0XWcmORp74/2wMronrRsM3D1JgW49KvppbcrGHzmwSjO
	 1a1DYA0/4BUzie77yfgh12eHhqrlHoNXIhEHjUfV07HIE9+bnTIoF29Wp3Stgx3OAqN40
	 Ttw6CzGIR5aPOrbOXFHXMljBbwBW+91HZLVm4x3fJKqBw0xafqice/FO4M21LVUnDwYMd
	 lFIXoxjOuAFOhe47+keHqxd0MNslnW7PuxuIdGiMdRHxD8PgcTf3TvOFyb+3lI3/Uug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2oy1M6nGyWdXB54nk9X+IzAXBaZhuIs9mX7/0WSrEZ8=;
	b=ABxjfgeO0t3FmO9pjQZYzyG0YpQiaBuG4bjmxhrI9/fHdOnxKiEi551C4dVTNXwNXsaW
	 cIurS4+OAgPLyPia9mn9WdQtktwEJAVgBGIEmVRwZHyo41QvDYoUStBNm1iJLtW6Q70ew
	 m2lay5KJjjz3/nQ0cSPBPmfXgmLv+S/DLwK/otsTyS9tON/cM/W3q3UzoCBWT+snGExsJ
	 ysa25yJYv7RING3Zg2a2EwhOTqHnDx418FaK59AuP8aUHpgskmZgmFHkaUVz3QBzz35Ii
	 okvMorPByJcBAajHC3SRdvj2nlA2dtQrrQ5JQJOQ4E2Y/ZUCXdiPNNexKOuDftFhJTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkvqaIbp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD48606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkvqaIbp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881671F00A05;
	Thu, 12 Nov 2026 02:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450546;
	bh=2oy1M6nGyWdXB54nk9X+IzAXBaZhuIs9mX7/0WSrEZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HkvqaIbpAaWYg0waPOQsa1EEhPvVXfWkWVMnU6eOLuxT40dljucZYpe36l0Uluphq
	 1T489++UBKJc+kickzDTA7O8FOCwgbfDKt35uG2qm3oLR2SnLBIUDxNLYRtaRrybLu
	 r/CEoWq3RBM6WQ8UXG6KQCCrh9Z7FZaaJwD39+rymcivjl0uDlOX3+rcF2l+czJDBM
	 JhKm2BQugnJUOo27sZV7ANPDCpkMpnWb0zLFEoEEz2kDRa38BRy6CfzJLDirbmtrA9
	 FoRUeVH5LttxK6wljvzAh+yU3/BaXmG6hS+j9j+UkBlvENT4COmrja2Nn2aE8in8Zv
	 OvbAud95MQmKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Darong Lu <zzyy19904204639@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] libceph: initialize CRUSH choose argument weights
Date: Wed, 11 Nov 2026 21:29:04 -0500
Message-ID: <20261112022844.1374567-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061213-failed-5.15-c3a995ff0782@kernel.org>
References: <20261107061213-failed-5.15-c3a995ff0782@kernel.org>
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
[ sashal: Adapted kzalloc_objs() to kcalloc() with an explicit element size. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index af8b6c01784ec..4fab2aa5789c0 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -304,7 +304,7 @@ static int decode_choose_arg(void **p, void *end, struct crush_choose_arg *arg)
 	if (arg->weight_set_size) {
 		u32 i;
 
-		arg->weight_set = kmalloc_array(arg->weight_set_size,
+		arg->weight_set = kcalloc(arg->weight_set_size,
 						sizeof(*arg->weight_set),
 						GFP_NOIO);
 		if (!arg->weight_set)
-- 
2.53.0


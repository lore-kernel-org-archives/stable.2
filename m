Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423266;
	b=FTlkLxxCyoMBN+sWGxAzj7tOo+u+b+NY2MFaMxiL9tM8dOB76lI4B0up5o7dNs8J4YtA
	 vSYzz+WGb4X0k9ODYg+THVHq29xZLDcM+w+Xocwa4upScFaedMVtoD/1XyN2SWFGvRRTU
	 GQnR24eGYWUVGbTVXyqT0mbYfzpviT3wGQMmN54zks94gKYY5C1nKmjQYYbSsVzHOnuvh
	 fmuoS+a39lMnCDSTZC+0EcW4pxn30uIMLz9nqRlp1pvFdoPNEkFB15oRUuQgfKASpWsUa
	 emFNn3iCisMAQFXMsBk459eYlXCpF5zRmTCj3Wp9XAKaVz21Zg4Yzfcary+8htpGT8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423266;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=+ORKdRBjWakjfA7wv+LwwnwXiqHg4MbSb+ugIByTskE=;
	b=u5jbv+Xm8l//bT8SiMU/UjMbNn0kVZY5+SRUYFDG9oCd4PSQ6oKRSo/QnXV3eqvh0oLz
	 +5Inm5BlC6OuZEyxhSO9FClWw5Y+8fqG3p2bSiYPeSbtZYq/KlZtFO1dCBl1x56aP9Xp/
	 bLO8wmVAlMlBaSW02VXLrZyk1jxNmPzuVywNXZmn5+obrsPlkv0ZHuJ7rDEUFC1Z6fZSM
	 j/yxY9gZnLunlbPAVHgCEOQ1GsU3WpznRj/fCJenFF8nCZdRn5HWDHN3T6V2O419d220f
	 q4WzEmgHXIxR3NdEWqha2HV1dsBEdDEmGsfpUIPDG2KWgFb5iF61TS8+K5VVSbdyQ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="P/Qn/z+Z";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73060A7E6F
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E73060A7E6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=P/Qn/z+Z
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 613D8C63446;
	Mon, 19 Oct 2026 15:21:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 252FA60582;
	Mon, 19 Oct 2026 15:20:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2C8510328429;
	Mon, 19 Oct 2026 17:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792423251; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=+ORKdRBjWakjfA7wv+LwwnwXiqHg4MbSb+ugIByTskE=;
	b=P/Qn/z+ZkZwhYXVAkqsLzy39JNV3mRnPocwJyV0tqiz2mg0Czew2UY1l72kjN01Y1TNCN3
	x/GDFvx28r3/LPphvr6jpap8QpI87iRbRHy/V1Gj74njHci3z3Tx9d8KwlWrV4wNIU0J7V
	NLF6xkWuQfd5x6H8mCTDxu/FmJO5KGzhNe+gSTxyEA69bDtpswqohee73jUjILERCrGfKw
	UaYulsZBHxd2ha/4r7AdhmTfhzH70s6q2dbT3ol4bHOI6s3aBXn+b1aMpl41oLKJjnJiTu
	OxxITWHg6fdRou5Uf/a6beCOaQuSY3CIJrJZfq19sLsJPqLP1N7/gv4jywX38Q==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 19 Oct 2026 17:20:45 +0200
Subject: [PATCH 5.10.y] bpf: fix potential 32-bit overflow when accessing
 ARRAY map element
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-cve-2022-50167-5-10-v1-1-694b5f334530@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CMAxE0atUs8aVnSiBchXEgqYumEVBCVSgq
 ncnwPKNNH9B0WxasG8WZJ2t2G2qkE2DdDlNZyUbquHYRWHpKM1KFY4CS9xSIGEa/C4m7fyovkd
 93rOO9vpVDwitcPvG8b+XZ3/V9Pgmsa4fBEMMBX8AAAA=
X-Change-ID: 20261019-cve-2022-50167-5-10-d386ce93fe3b
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792423250; l=3293;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=yqZsaOOhM6lW3BWgqCG03TvE1E47SC4WTEHnlJll0Cs=;
 b=PT78VKwEswuT3ZNUBDAVXeRryuho+18I1nPU1p2FzNxilDibbUqcX1jiR8TjxH377rlamJFcY
 RLrKSF0T/8ADNFJitfcVJwMGw46u1S5FSaCAG8n+12nqb2A5oysz9AV
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 87ac0d600943994444e24382a87aa19acc4cd3d4 ]

If BPF array map is bigger than 4GB, element pointer calculation can
overflow because both index and elem_size are u32. Fix this everywhere
by forcing 64-bit multiplication. Extract this formula into separate
small helper and use it consistently in various places.

Speculative-preventing formula utilizing index_mask trick is left as is,
but explicit u64 casts are added in both places.

Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20220715053146.1291891-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[removed the changes that applied to code not yet introduced]
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 kernel/bpf/arraymap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d92e42c3895..06f27f4bdf59 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -174,6 +174,11 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	return &array->map;
 }
 
+static void *array_map_elem_ptr(struct bpf_array* array, u32 index)
+{
+	return array->value + (u64)array->elem_size * index;
+}
+
 /* Called from syscall or from eBPF program */
 static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 {
@@ -183,7 +188,7 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 	if (unlikely(index >= array->map.max_entries))
 		return NULL;
 
-	return array->value + array->elem_size * (index & array->index_mask);
+	return array->value + (u64)array->elem_size * (index & array->index_mask);
 }
 
 static int array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
@@ -335,7 +340,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 		       value, map->value_size);
 	} else {
 		val = array->value +
-			array->elem_size * (index & array->index_mask);
+			(u64)array->elem_size * (index & array->index_mask);
 		if (map_flags & BPF_F_LOCK)
 			copy_map_value_locked(map, val, value, false);
 		else
@@ -530,7 +535,7 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
 	       return array->pptrs[index];
-	return array->value + array->elem_size * index;
+	return array_map_elem_ptr(array, index);
 }
 
 static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -549,7 +554,7 @@ static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
 	       return array->pptrs[index];
-	return array->value + array->elem_size * index;
+	return array_map_elem_ptr(array, index);
 }
 
 static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)

---
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261019-cve-2022-50167-5-10-d386ce93fe3b

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>


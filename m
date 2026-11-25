Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636901;
	b=Ez2/3bZ7/ongiLJFDUJuI+Iiv1Xh7LRhBISuFKqlG8mDvsfePPtgKVKdUZTgq0UTu5M9
	 V5Arjib6JeQ5YciYLbXWigYNyZM04+TGRCCGuWIYUQEwAjVxcEGHyKpPxcQ8ctLj/gzx2
	 j51mu+Zsio+ZDAt4IP9kzVix7zsF+hxvKS8H4pGhExoBNKGccI1yS1o1MSc+Mg7C+6CdD
	 m6UZVBlgng/QjRLMVRtVvQM5oV/RynwAjOkWf1Z2Mnt/I2wXz1pyTBvj9V/oAR5sGG5w2
	 VFJ4O7d7leupNhBh3ZiStU4eBX00Ht/msqCsaPWl/Jbmm6KAq4zJ+wcGq/1xiYHOxFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w78jhgpEJD5rWnXySz1IRnEnfxV0WtXcgdZkpYiv+XA=;
	b=foYP14w1IdqxdEBjPX5hrVThabftkqd+lCHo4hXqtRB8Hqrz6WXtcbXQvqdxOoGoJrpl
	 tBwO3Fh7mxtYmr90EnnBiFSyss6ekQJeJsUPSg1roEsUrHoNYi0DkopaLFxeou0F97eYR
	 pLUHWMqRAG10ellOljZJ+tSwZ08A8FW0qhHXjLZMmEXM6e3F4E95X0Fox/IX+um+lOAg5
	 y9UuMUlMxvMbaojP/TiYo9SYSdIvnCiKG0TWtYKX20Z7cO4zomweNq9NAx357wgWEL3bM
	 Vb0re2xh9xNNYCOS2C6LkLiFRoUqXMv95Yf2yhX3Y6JOXMiE4yhCYKcq5gvnYEqYs3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boylbBBU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE6606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boylbBBU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383A31F000D3;
	Wed, 25 Nov 2026 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636900;
	bh=w78jhgpEJD5rWnXySz1IRnEnfxV0WtXcgdZkpYiv+XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=boylbBBU7o0Qlofcl5E3o92p3o118CUT8/gA8L3NWXlaMrqx28BUWevdIv/waSfJ5
	 dGLiJ4RXwdr9C2XmaEi9KqpJtqCjzqpQwxg+n0HfAaOriPvt0dIKwc2Zo5z4ub7TY3
	 5KQ5VRvR5PetT/cmJRVerMCElDW4OxQEEwq+abLBcHXgYSfnwzutikpbmk4Gdxz3ZQ
	 BC9kERTgdBDeO+bBKTWW0oTV2Gu/5b2xRmhluxXlYm009ZqR/rbLEtLvRo9qIEF7kB
	 P5+y1ItPM6PR9IvmK7YKRHj+T9FWVnn5SZsU0duU1ASu3QRZzLKg8XsdvaTr+qxc3S
	 aOiodCdQ8EljQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tracing/probes: Fix missing BTF kind checks in char pointer/array helpers
Date: Wed, 25 Nov 2026 15:01:38 -0500
Message-ID: <20261125200114.1350736-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112532-latch-ripcord-5fdd@gregkh>
References: <2026112532-latch-ripcord-5fdd@gregkh>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit c1e2c63e65421068566db3dde44dfd4fe7adb46d ]

In struct btf_type, the type ID and byte size share a union, and only
BTF_KIND_INT types are followed by a 32-bit integer encoding word.
Because btf_type_is_char_ptr() and btf_type_is_char_array() do not
verify that the outer type is BTF_KIND_PTR or that the resolved element
type is a non-NULL BTF_KIND_INT before inspecting it, non-pointer BTF
types can have their byte size misinterpreted as a BTF type ID, and
arrays of non-integer types read out-of-bounds or misinterpret trailing
BTF metadata as BTF_INT_* encoding bits.

Validate the BTF type kinds and NULL pointers before reading inner type
metadata in both helpers.

Link: https://lore.kernel.org/all/179455851632.403392.258264246782960594.stgit@devnote2/

Fixes: 27973e5c64b9 ("tracing/probes: Add string type check with BTF")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: Kept this branch's existing &tid argument to btf_type_skip_modifiers() where upstream passes NULL, resolving the context conflict in both helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index deb47ca572bd7..786552250ac13 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -326,6 +326,9 @@ static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
 	u32 intdata;
 	s32 tid;
 
+	if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR)
+		return false;
+
 	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
 	if (!real_type)
 		return false;
@@ -351,6 +354,11 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 	array = (const struct btf_array *)(type + 1);
 
 	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
+	if (!real_type)
+		return false;
+
+	if (BTF_INFO_KIND(real_type->info) != BTF_KIND_INT)
+		return false;
 
 	intdata = btf_type_int(real_type);
 	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
-- 
2.53.0


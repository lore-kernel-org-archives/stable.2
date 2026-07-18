Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A260343D64
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375080; cv=none; b=fTftwdKfxwA3lI4WiqQpw6BFrUR2KC0af0k0p/YSzOlmT5yFAFcFTz0niPaMSAtufaYquZyUH8yzLIp3n739n4Q6Vsl3HfkIG3wG9640UZEvvSqzNldRnZXZkXwOKCcROYVJaVZxzTrTtEHeaD823UIPA4dore7TKHHsBmuJMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375080; c=relaxed/simple;
	bh=wkxQMhMq00cGOPQdrMdUuKq0H5wzUMw0iK3tzfy2kHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCNjuK2ZtbefMYVO9dbJClDattF7LTg+K0QMYY7OxnSKQF0XQ4UmYKSFYjv88sJGrm4K0/TGSFCEDGutRLxO+nRXIb7t7oH73nYzxqju/spGA/tRV+W2eUitFcWVdaDBDObHZy6VeNugbP+6FoKbIEpvAu6MChRD1r5u5iE+QCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsOCKwRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsOCKwRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D9E1F00A3A;
	Sat, 18 Jul 2026 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784375079;
	bh=ghhgUdfY+4NtFv/HvExcX1KtP9XwLEwYxNEYnnEdAMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QsOCKwRwFChTxa+2JQfkBO7c1eFnIuTPHd2RjShCEo/WUgK1l4mXsTiyxvWmRkw5N
	 qPVfjeeCTwCYzZJKDKVAfDE8U+vmCbCuscwpc9mfwjdzUrCN3igERVjySTK8fLzBH2
	 Vv1BxLRJPK57msBbBAl9vGGuLz4EQOFsnFyn/iSMoJL3OdJ0Maz6JW7aJCCgP2rjF/
	 y86qsMC5nHgDbTge7O3WZOzTeuOT9L1lJBVkA93Buf1b4+2oSjrTxka1t+KhS6NO+5
	 fQ0iOaBb/6NzJLNBUImk8TP5dpAd51OyTX9yKywqD08iAiJZMOPM4bK5KvvjolZkNX
	 g+Q43tQnUPawQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] bpf: Keep dynamic inner array lookups nullable
Date: Sat, 18 Jul 2026 07:44:34 -0400
Message-ID: <20260718114435.3046796-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718114435.3046796-1-sashal@kernel.org>
References: <2026071438-pester-imperial-a2dc@gregkh>
 <20260718114435.3046796-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

[ Upstream commit 53040a81ae57cdca8af8ac36fe4e661730cf7c6b ]

An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
inner map template. A concrete inner array with a different max_entries
value can then replace the template.

After a successful outer map lookup, the verifier represents the
resulting map pointer using the inner map template. Const-key lookup
nullness elision consequently uses the template max_entries even though
the runtime helper uses the concrete inner map max_entries.

Do not elide lookup result nullness for maps marked with BPF_F_INNER_MAP,
because the template max_entries does not prove that the key is in bounds
for the concrete runtime map.

Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/20260607-f01-v2-v2-1-da48453146e8@mails.tsinghua.edu.cn
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4bd1c89ae4ee88..cb1893eb5ee11b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9705,7 +9705,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool can_elide_value_nullness(enum bpf_map_type type);
+static bool can_elide_value_nullness(const struct bpf_map *map);
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
@@ -9855,7 +9855,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
-		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
+		if (can_elide_value_nullness(meta->map.ptr)) {
 			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
 			if (err < 0) {
 				meta->const_map_key = -1;
@@ -11428,13 +11428,16 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
-/* Returns whether or not the given map type can potentially elide
+/* Returns whether or not the given map can potentially elide
  * lookup return value nullness check. This is possible if the key
  * is statically known.
  */
-static bool can_elide_value_nullness(enum bpf_map_type type)
+static bool can_elide_value_nullness(const struct bpf_map *map)
 {
-	switch (type) {
+	if (map->map_flags & BPF_F_INNER_MAP)
+		return false;
+
+	switch (map->map_type) {
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 		return true;
@@ -11816,7 +11819,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
-		    can_elide_value_nullness(meta.map.ptr->map_type) &&
+		    can_elide_value_nullness(meta.map.ptr) &&
 		    meta.const_map_key >= 0 &&
 		    meta.const_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;
-- 
2.53.0


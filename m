Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D13644D4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044426; cv=none; b=lfW7H+/TKzoxapVmxUid6QrmqQP0sRBl8TKbXwI8ANNnLWY6pJJRTaqwDC1VBuZQ7utL3EW1/4poRUbbkQY9tA9hApfel3yxrGTcEBlRbxoz3fCJSOYVQZABlGpbrHEXRs95mmIiWfBSj+QvKdc275eLPaFR75mEVgjWQWgIpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044426; c=relaxed/simple;
	bh=OIvKNfwctaG/8mZ9AP8TfdzWX5Sow57sZTIaESxVovE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IUWbCeeTOACEV2HyFk1aBg/LJh2F82dhp5hvuVEZmMGNGTMu0uXgFvzPkC825N/E1t7wOt3nnat4QsH25VNFYgHvSymSzg6kswOg9Hj09cTf6eIfz1ZT3zu3u5kuA+DAjVMEaCOLaV31L8RK7krMoed71o4QEPq+tcoAgKoIQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cp+voVBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cp+voVBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C6A1F00A3F;
	Tue, 14 Jul 2026 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044425;
	bh=CkDqr9gV9ngPcZc0/IV7kJga+6nueyW63keYjg8Bi+A=;
	h=Subject:To:Cc:From:Date;
	b=Cp+voVBI2YSWk844aBERi3M9GCI5yXsccXmTwT61L8BGo+7sIfOsVm/bmXTbc9glM
	 poBU1gAIaWvDU4Ga2wZMYwaV7vHXDcYfbPjesM6c3oikP38avWTasu/1xMjGoBZUzk
	 SKVEx5+bzfxmAeK5iThrE1+X1qUPocbXWvqPVk7M=
Subject: FAILED: patch "[PATCH] bpf: Keep dynamic inner array lookups nullable" failed to apply to 6.18-stable tree
To: gnq25@mails.tsinghua.edu.cn,eddyz87@gmail.com,jolsa@kernel.org,memxor@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:53:39 +0200
Message-ID: <2026071438-pester-imperial-a2dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 53040a81ae57cdca8af8ac36fe4e661730cf7c6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071438-pester-imperial-a2dc@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 53040a81ae57cdca8af8ac36fe4e661730cf7c6b Mon Sep 17 00:00:00 2001
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sun, 7 Jun 2026 21:24:13 +0800
Subject: [PATCH] bpf: Keep dynamic inner array lookups nullable

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

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0c1cf506c219..ed7ba0e6a9ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8179,7 +8179,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool can_elide_value_nullness(enum bpf_map_type type);
+static bool can_elide_value_nullness(const struct bpf_map *map);
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
@@ -8298,7 +8298,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, reg, argno_from_reg(regno), key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
-		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
+		if (can_elide_value_nullness(meta->map.ptr)) {
 			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
 			if (err < 0) {
 				meta->const_map_key = -1;
@@ -10068,13 +10068,16 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
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
@@ -10414,7 +10417,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
-		    can_elide_value_nullness(meta.map.ptr->map_type) &&
+		    can_elide_value_nullness(meta.map.ptr) &&
 		    meta.const_map_key >= 0 &&
 		    meta.const_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603190;
	b=lUx5ca4I6WjRYuGJTFf9xkU9Wod6wYXmgdr3apQkRwuTvNgN5WsTYnLAwceSR7luR/LI
	 jvUV9kqRRLR1yoXQUDSuI8CD2tBEfPK+y6bEsDtTub7Wxx+wH+E2KhibklCcsY/7si982
	 3iLxol899F+rT7UqlBrCeqGSNK3WWXuUpPhrnSBaIKpGA8bOgGExAxtyz+ohf9xBBb6/O
	 4GnpVLLxvFB9baR+W4YLL9Df4kBkDr5OJ/DEWW2YfUthSxw2MfRbvfCK1Gm/hq3PczANH
	 kXtAOEfY3ovg6JKWel/u6oVj9aVw3vsvkD6yhoQ+tK4FOxvD0SlrX3rFN5XKufD9Qvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603190;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KiCZ8guF1AZsLwtns1QfZe6uVhRO+VzgmgtQYBQcqMo=;
	b=HZqNUuSQVOBLRTWOuE9qhKjmT1o7q0GmiCSgLdilr8CtVc6DAraBLxYxzSzjLv0DIfzy
	 jAI0AW5Ls+198J1uMYxJEmNEZF+/zqGm3KILR7p8kyl64cN7Jv+DxvVCyqyqYKuuRecQs
	 tq8nVNZ3hmRvfYv8DhJAlNmYO9cXi05J4hMKCYudehY8KQkurBENjrhXA/M5WvkzGsYca
	 YZ/CbOju5j5732NyJtGav1eHYriDuO90Fj4+gYqVpfU8yBRfroa+fVn0syJ5kFtc8hreh
	 2xHxvfq8pDDcOIJsoxuQhmouZrDsPcj4Q7mXu9CobID3776q9H9cmk5gONV6rvV3G8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RNvXauzk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F7606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RNvXauzk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DB91F000C4;
	Wed, 25 Nov 2026 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603189;
	bh=KiCZ8guF1AZsLwtns1QfZe6uVhRO+VzgmgtQYBQcqMo=;
	h=Subject:To:Cc:From:Date;
	b=RNvXauzkOVt3CyUHNIvXTytYOKxk7CSPzdhTQs6ZzUQF6s1zz9A+/N3hppz9Zu0wC
	 y8s1ct669AhFL1kZXOJs9lJyMeRsAXPpIeq5refulQjSxOMDwut3DOggkh6O78fg9V
	 iPIvPN6lhnfW0spo+Nu4H7PHST3JY/sbe7NzHoaA=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix missing BTF kind checks in char" failed to apply to 6.6-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:29:32 +0100
Message-ID: <2026112532-gone-canine-62be@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c1e2c63e65421068566db3dde44dfd4fe7adb46d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112532-gone-canine-62be@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1e2c63e65421068566db3dde44dfd4fe7adb46d Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Nov 2026 17:28:36 +0900
Subject: [PATCH] tracing/probes: Fix missing BTF kind checks in char
 pointer/array helpers

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

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 01e499fdbfdf..5e53caf2cdb7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -411,6 +411,9 @@ static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
 	const struct btf_type *real_type;
 	u32 intdata;
 
+	if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR)
+		return false;
+
 	real_type = btf_type_skip_modifiers(btf, type->type, NULL);
 	if (!real_type)
 		return false;
@@ -435,6 +438,11 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 	array = (const struct btf_array *)(type + 1);
 
 	real_type = btf_type_skip_modifiers(btf, array->type, NULL);
+	if (!real_type)
+		return false;
+
+	if (BTF_INFO_KIND(real_type->info) != BTF_KIND_INT)
+		return false;
 
 	intdata = btf_type_int(real_type);
 	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)


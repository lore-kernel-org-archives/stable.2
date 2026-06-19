Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F11EF36E;
	Fri, 19 Jun 2026 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781909370; cv=none; b=KSBje+27oI0HPNw4fjOTaBmvHlSW9nvMfMi++1fZyUzEV3Hv3g3Wqdv0vFcyB3Z2E5mpeW9giU1kXGHm+QdxhmNC01Tq8WB3YSjYhg3dPqAzv/4o6bxsxhQPvub8YPDIamVI/VbT1ppLAGpPiWZ9iqa5c99gdjrdLRQk0qdbGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781909370; c=relaxed/simple;
	bh=HEzskbe7bf2AgecACmSCCAzdYviBbjUwZG1tX3ytM0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HbOpzQoUt4GQbeDnBnlBp+9saVFtxBu8HZv7IDnmS21G2wq6oOEiNYyIuBxlehyf2btXJlJ8ub4nFU+949ZDzA3GGxUesQF6A+hW1fhN/CsxzPQFVzE6H7t76QYbM5kApdJk9Ov/8yrNjrGY0d2vEB/kKAknnfa0iy1dIQ5s5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=M8DZTivv; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=C1Y0U0e1; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="M8DZTivv";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="C1Y0U0e1"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1781909361; bh=1UPOE6O/6OEbBsTb44A8w1h
	Etg8iTxmg6wt3V87UyOM=; b=M8DZTivvbss0qW1GYZuv/1I4QmEltkjLWwzH34bzYZ2l9VcQSx
	ZJlZFWTJZ+6YQ4udfAEtlRkXF8tArGLEZS2LCsBlwqCpc5h0Vr7FbnIdvqJyd7H230AkjJaKelk
	cby3leouxHs3yWGC3DA0RSNcDoH9l8zyS/1qi3ar+oDR6XZaPYFZIIGWsOFIdBjj5pWxlj12npN
	kzUDsj6C9Z0AWkqg4Wh5MCfDZ5SQjUNodwPdOeRradz4/1L+dLP5ocmP3oyQqirEY3XJs6LCTqx
	el1uKk90x2IbF9WDpCzRzAaaD238rZXwVQgsMdtQrgB9H/b5wGZF6iA0wfJP2orVPbQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1781909361; bh=1UPOE6O/6OEbBsTb44A8w1h
	Etg8iTxmg6wt3V87UyOM=; b=C1Y0U0e14tq2mVwRNBYuN/DtAgsML7uYABbZ2+ba+qA2k3MUHf
	VBfqT+7oV5RxPUBH5gMdY4/dYqTTTo500RAw==;
From: Aelin Reidel <aelin@mainlining.org>
Date: Sat, 20 Jun 2026 00:49:13 +0200
Subject: [PATCH v2] resolve_btfids: preserve tag and parameter names when
 processing implicit args
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OQQ6CMBBFr2K6dgytiOLKexgWtUzrGCxkpjQaw
 t0FvYHLl7z89yclyISizptJMWYS6uMCZrtR7m5jQKB2YWUKUxWVroFR+i4j3JKnVoCeQ0eOElg
 OAqMgWJ+QwTMi6Mo7U+/rg6lRLYsDo6fXt3Ztfizj7YEurYnVuJOknt/fO1mv3n/lrEGDsf50b
 MtjUbrT5WkpdhQphl3PQTXzPH8AG+w5af0AAAA=
X-Change-ID: 20260619-resolve-btfids-implicit-args-use-after-free-16fc2939529e
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Aelin Reidel <aelin@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781909361; l=4474;
 i=aelin@mainlining.org; s=20260503; h=from:subject:message-id;
 bh=HEzskbe7bf2AgecACmSCCAzdYviBbjUwZG1tX3ytM0E=;
 b=yhex5uKVFchJjm5JbhOl/E1eDAFOfo84gVrt3xtSu2p6rHIVovNnSZBwPqR3PKmX2KMz9CAat
 VkqvJlBC1dcC/lQWEDgLarRbFNzDPiTj/S+MkoeBKKZWs0QJL+2hDFs
X-Developer-Key: i=aelin@mainlining.org; a=ed25519;
 pk=JdivYHq/vT1Z1DpBeadmJbY/Fi5Ab9P/C35KYCOezfA=

process_kfunc_with_implicit_args() obtains parameter names through
btf__name_by_offset() and passes them to btf__add_func_param() while
constructing a new function prototype. Tag names are processed in a
similar fashion.

The returned name pointer references memory owned by the BTF object.
btf__add_func_param(), btf__add_decl_tag(), etc. modify the same BTF and
may grow its internal storage, invalidating previously returned string
pointers.

This can result in btf__add_func_param(), btf__add_decl_tag(), etc.
dereferencing a stale pointer when copying the string, leading to crashes
in strset__add_str().

Duplicate the parameter name before calling btf__add_func_param() so it
remains valid across BTF updates.

Fixes: 9d199965990c ("resolve_btfids: Support for KF_IMPLICIT_ARGS")
Cc: stable@vger.kernel.org
Signed-off-by: Aelin Reidel <aelin@mainlining.org>
---
We were noticing resolve_btfids crashing almost all the time when
building our kernels with BTF debuginfo in postmarketOS. I'm not sure
why specificially our environment triggered this extremely reliably, but
I'm glad I was able to track down the issue. With the patch, I haven't
seen any further issues and our kernel builds are succeeding again.
---
Changes in v2:
- Apply the same fix to tag_name and adjust the commit message
  accordingly
- Fix the remaining use-after-free in the error handling path
- Link to v1: https://patch.msgid.link/20260619-resolve-btfids-implicit-args-use-after-free-v1-1-2af87d4704c8@mainlining.org

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/bpf/resolve_btfids/main.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index f8a91fa7584f..94b89e9c942e 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1113,6 +1113,7 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 {
 	s32 idx, new_proto_id, new_func_id, proto_id;
 	const char *param_name, *tag_name;
+	char *tmp_param_name, *tmp_tag_name;
 	const struct btf_param *params;
 	enum btf_func_linkage linkage;
 	char tmp_name[KSYM_NAME_LEN];
@@ -1163,18 +1164,22 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 		if (strcmp(tag_name, "bpf_kfunc") == 0)
 			continue;
 
+		tmp_tag_name = strdup(tag_name);
 		idx = btf_decl_tag(t)->component_idx;
 
 		if (btf_kflag(t))
-			err = btf__add_decl_attr(btf, tag_name, new_func_id, idx);
+			err = btf__add_decl_attr(btf, tmp_tag_name, new_func_id, idx);
 		else
-			err = btf__add_decl_tag(btf, tag_name, new_func_id, idx);
+			err = btf__add_decl_tag(btf, tmp_tag_name, new_func_id, idx);
 
 		if (err < 0) {
 			pr_err("ERROR: resolve_btfids: failed to add decl tag %s for %s\n",
-			       tag_name, tmp_name);
+			       tmp_tag_name, tmp_name);
+			free(tmp_tag_name);
 			return -EINVAL;
 		}
+
+		free(tmp_tag_name);
 	}
 
 add_new_proto:
@@ -1193,12 +1198,17 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 		if (is_kf_implicit_arg(btf, &params[i]))
 			break;
 		param_name = btf__name_by_offset(btf, params[i].name_off);
-		err = btf__add_func_param(btf, param_name, params[i].type);
+		tmp_param_name = strdup(param_name);
+		if (!tmp_param_name)
+			return -ENOMEM;
+		err = btf__add_func_param(btf, tmp_param_name, params[i].type);
 		if (err < 0) {
 			pr_err("ERROR: resolve_btfids: failed to add param %s for %s\n",
-			       param_name, kfunc->name);
+			       tmp_param_name, kfunc->name);
+			free(tmp_param_name);
 			return err;
 		}
+		free(tmp_param_name);
 		t = (struct btf_type *)btf__type_by_id(btf, proto_id);
 	}
 

---
base-commit: 598c7067dd8b65b93f3ccada47e9014a13137f1b
change-id: 20260619-resolve-btfids-implicit-args-use-after-free-16fc2939529e

Best regards,
--  
Aelin Reidel <aelin@mainlining.org>


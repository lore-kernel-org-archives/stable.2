Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB532372EC5;
	Fri, 19 Jun 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864505; cv=none; b=dyIUylKf+GEUlO2RhxZ3/tBgOMtzvLbZKVbzOTgJJskQ25YmA9nHe/mKeI0OkGJMMZ9Rg6KYlOHlqPjgQ0sJPKSrQE1YVmz0D+aSoOgfWytySevwnDnD1Jw9+tCmIBhOmtKcPPCI90QAnXyWfusdOyHdChhurumWg1CmIwi03Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864505; c=relaxed/simple;
	bh=jFxT0LM8UGsZx6i6qi9eIzbSoSvm7DK4i7WSlN1G+jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HS88dJXlF7PVeYrwt9dYjlpJ6gXK6cFzZkLZoabMeGXmRCqtpyobtK+kIBoXNSeGi8Tp9GlJHSRS5RMXu04HAYKKVoWj4qs/cu6yw7vexkut5NEovubZDaG6rviy7ivh5ISJZ1t1FjgmhU6np8Jep4gy8HjqEbO2o1+WjaWQfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=OAVB6kGM; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=uRRgJRBN; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="OAVB6kGM";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="uRRgJRBN"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1781864348; bh=OpDQSRZvNmDnkH0/vbgSAL6
	YbsYxGu5Q3N1CSOTCu60=; b=OAVB6kGMP5RdoK314cICU2eM9/8bgn1Wg3Ut8QUur9m5Yvc4Cd
	Q8NCSYSE5A1jvCiJXoJeXHKq9YKVSWF0TBFqF6jXY+BLvqo6uDMN4XuHZayr/5ZwM1S+alXFlib
	7PSsXC1z1Rg0W47Cb+clfheHpGpx8AYeTflrKTuHLDaXLPwj78KMuTtSRhqviiTULk1za/aOLsh
	Q6Mmt3TnHGJvD82/HkCu3VM5OlhSLNGSI7iXzNFeF7sxUvwKC79M/vYPgQuSo4DYTKQPjGyNyyd
	Gz4mocDQeKB8cSkHroai4CAaC6a/Q7Wn+6houVIx5+CbhaMHZM80ywgAKjYbZMnB2ag==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1781864348; bh=OpDQSRZvNmDnkH0/vbgSAL6
	YbsYxGu5Q3N1CSOTCu60=; b=uRRgJRBN+6GEO0GQyckBlIgF1DV2BDcC9+QaBtlDKapgta+sG/
	DLFBW5GmS0blYYlJ4AD3Y4pfEi8I9scMu7AA==;
From: Aelin Reidel <aelin@mainlining.org>
Date: Fri, 19 Jun 2026 12:18:43 +0200
Subject: [PATCH] resolve_btfids: preserve parameter names when processing
 implicit args
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-resolve-btfids-implicit-args-use-after-free-v1-1-2af87d4704c8@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBG4auQWTsJrZGkXsW4gPIXxyCQmUJMC
 He36vLbvLeTQQVG12onxSYm81TgThXFRzsNYOmLyde+qRsXWGHzuIG7nKQ3ltcySpTMrQ7Gq4H
 blKGcFGDXpOjDOVx8AJXiokjy/t1u979t7Z6I+bug4/gA9mX0vo8AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781864348; l=2568;
 i=aelin@mainlining.org; s=20260503; h=from:subject:message-id;
 bh=jFxT0LM8UGsZx6i6qi9eIzbSoSvm7DK4i7WSlN1G+jE=;
 b=f/apJd0bxHyyVHuOKoIGyyPR2cSHWkuqqhH94ED/q7iRX7Zok5b2qghLdG1SeTr6D7BYJFvSr
 zOVDmTnivA5Dzd563lZrkRbZS+/TQji0X+X+ptg4XlqK3FxL4drCQFV
X-Developer-Key: i=aelin@mainlining.org; a=ed25519;
 pk=JdivYHq/vT1Z1DpBeadmJbY/Fi5Ab9P/C35KYCOezfA=

process_kfunc_with_implicit_args() obtains parameter names through
btf__name_by_offset() and passes them to btf__add_func_param() while
constructing a new function prototype.

The returned name pointer references memory owned by the BTF object.
btf__add_func_param() modifies the same BTF and may grow its internal
storage, invalidating previously returned string pointers.

This can result in btf__add_func_param() dereferencing a stale pointer
when copying the parameter name, leading to crashes in strset__add_str().

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
 tools/bpf/resolve_btfids/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index f8a91fa7584f..970b810bb779 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1113,6 +1113,7 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 {
 	s32 idx, new_proto_id, new_func_id, proto_id;
 	const char *param_name, *tag_name;
+	char *tmp_param_name;
 	const struct btf_param *params;
 	enum btf_func_linkage linkage;
 	char tmp_name[KSYM_NAME_LEN];
@@ -1193,7 +1194,11 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 		if (is_kf_implicit_arg(btf, &params[i]))
 			break;
 		param_name = btf__name_by_offset(btf, params[i].name_off);
-		err = btf__add_func_param(btf, param_name, params[i].type);
+		tmp_param_name = strdup(param_name);
+		if (!tmp_param_name)
+			return -ENOMEM;
+		err = btf__add_func_param(btf, tmp_param_name, params[i].type);
+		free(tmp_param_name);
 		if (err < 0) {
 			pr_err("ERROR: resolve_btfids: failed to add param %s for %s\n",
 			       param_name, kfunc->name);

---
base-commit: 598c7067dd8b65b93f3ccada47e9014a13137f1b
change-id: 20260619-resolve-btfids-implicit-args-use-after-free-16fc2939529e

Best regards,
--  
Aelin Reidel <aelin@mainlining.org>


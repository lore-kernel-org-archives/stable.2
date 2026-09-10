Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808A35E549
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040826; cv=none; b=gABimAX6ruF0Zi7FH9L0MvCujzjjKv8eeCFu0dxk+xhNFN4YlDG0fF90eos+4NciH34nzUYw2qJKtN6flC8987HRDMSEl2e02lIOFbH9q4vjxo6ia7NVUJVSxD7LULtD8eiCLiWs7FHekMPPnTeheyQ/cKfXJft2d4IfSWV6flE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040826; c=relaxed/simple;
	bh=bYKnUCdazfMpLSs00It10LVZp48QkFivV/jnlXdpX54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teT7i9XlLZXIFmlN52RmZya3ZTpZKkTDRcgnQ2TjkGqUeUn+N3uuZpNvG7zXMeeRKVNIOyxOPQgqIEpHbp6jpgSUdHVdl/jYrMsYh1afWr6h2FWSDN+uH2upOWuqUq2xOYQdv1J6skzgxq7Ky5+PjOZZoWbBspLEpVkp89/peSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekd2phuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekd2phuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AA31F000FF;
	Thu, 10 Sep 2026 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040823;
	bh=FJe/1ecrTUmEg32hBNzgIpos4uqx6fUNtiwFyd2Se9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekd2phuYPJRHn4TW67J+2+adsOOxsiwmpBENmS1L0cm2r5noNV2e/TEvuxEUF40J3
	 x0nCxOI5KezeUcFHc3Vn0RhLrAZ6SDRsvA3SI3C1CVbXTROW1IZOhTGXKb82XVViQR
	 bncVoseM0yt0cQYcaa5HfKUzGzvmsDIpXpHH2MmajN7FpPbL5GPntfrWGA5QrKbXSC
	 bKckXb+v5nHrkSYX4IBoIqU+NIqijtIVdlXtrZAX7d3Tyci5WSNyI0Ol4hYC2tnje8
	 0WL+MJ9KwLbf7TUsdcY+opwf3LoeHNbx+iqKF6owNvzw29T6XdXeURfH8v9188UDid
	 rtXMmdXPPZuKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] tracing/probes: ignore id update from btf_type_skip_modifiers
Date: Thu, 10 Sep 2026 07:47:00 -0400
Message-ID: <20260910114701.98485-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090848-unicycle-recant-e7b4@gregkh>
References: <2026090848-unicycle-recant-e7b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit 823b37855829bc328d46102a56e4d0b2f7a3d0d1 ]

We can pass NULL as id pointer to btf_type_skip_modifiers if we do not
need the id of the returned btf_type.

Link: https://lore.kernel.org/all/20260623132937.3494895-1-martin@kaiser.cx/

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: 47e93045a2db ("tracing/probes: Fix BTF kflag check for anonymous struct member access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index c8fd9b946f442..2d58cf99b6f70 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -356,9 +356,8 @@ static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
 {
 	const struct btf_type *real_type;
 	u32 intdata;
-	s32 tid;
 
-	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
+	real_type = btf_type_skip_modifiers(btf, type->type, NULL);
 	if (!real_type)
 		return false;
 
@@ -375,14 +374,13 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 	const struct btf_type *real_type;
 	const struct btf_array *array;
 	u32 intdata;
-	s32 tid;
 
 	if (BTF_INFO_KIND(type->info) != BTF_KIND_ARRAY)
 		return false;
 
 	array = (const struct btf_array *)(type + 1);
 
-	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
+	real_type = btf_type_skip_modifiers(btf, array->type, NULL);
 
 	intdata = btf_type_int(real_type);
 	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
@@ -585,7 +583,6 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	struct btf *btf = ctx_btf(ctx);
 	char *next;
 	int is_ptr;
-	s32 tid;
 
 	do {
 		if (!is_struct) {
@@ -596,7 +593,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			}
 
 			/* Convert a struct pointer type to a struct type */
-			type = btf_type_skip_modifiers(btf, type->type, &tid);
+			type = btf_type_skip_modifiers(btf, type->type, NULL);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -636,7 +633,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				ctx->last_bitsize = 0;
 			}
 
-			type = btf_type_skip_modifiers(btf, field->type, &tid);
+			type = btf_type_skip_modifiers(btf, field->type, NULL);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -755,7 +752,7 @@ static int parse_btf_arg(char *varname,
 	return -ENOENT;
 
 found:
-	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
+	type = btf_type_skip_modifiers(ctx->btf, tid, NULL);
 found_type:
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-- 
2.53.0


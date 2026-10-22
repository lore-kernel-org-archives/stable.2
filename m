Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678143;
	b=lI8+ngEHt/bc/0xIw/QIaFgD31/j3ZT39Fa+xfwtKnTbn9pks3vIG2syYSwt3rWx7JYB
	 UQ3L5QdC/TqxMY9arlu0uG15IiYJ9thVZ4BnlHWErvNJCudVB/vrMcD65iZYoW21ME4iw
	 hX0M7wEmOfbZo7dWq6pisCmQ11iyA28/EkNyfe4kvpDdIEiAGiCrBmdbRVGpYikFFoWA0
	 7acw6cZZg5e2DoAaSadP4c5FbvZFHVhDW2aiZNPTXIiEY+FB6EiIQQg/zHyIhonQRrNkw
	 Q/srpXUYD2bmG3S86a2B0VNHr8uoQG2jFh4VLud/i3kjVCB32VE9DzdZ4DPUs1xDVLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678143;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q45kTUHwAqCJNhX1DNdsP+3hLbDNU9+IBL03bbxOVlU=;
	b=UC1Yc8WAND+nVNBKHAIB+lrL4Ej44WKbeDm0G9aU/BlR6HUHHI+Gf7hqRTxOfwuEdqyo
	 zIX+F6FscC4CgwRlhKhr5xx/7DRMRneR8y6U4fBv9VoBJ8waI4I6PK/QWPo+rO8yeybwD
	 ixKlCM4NrRIU1Wg0UTm/8mFJjRHqeZs0TmDDi6zdJBuNgKSG4IkAGlSf/+QglHq0r4qum
	 fn36qD81aOHJxVFKhA/1uqhk0BlNkENvCB1XaFaLl5wjtHpC9whefSD/2qauob9oM7hgk
	 aYkQLU7DByvkWtHnFUa8w/yM0moA5ZEUotlpMxrdC7HK0uQdX07628FXSjTrhn7MYBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VlUdXL8/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D28606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlUdXL8/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50B61F000C2;
	Thu, 22 Oct 2026 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678143;
	bh=q45kTUHwAqCJNhX1DNdsP+3hLbDNU9+IBL03bbxOVlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VlUdXL8/XVoizo+jYjFmvlOQCj42WQflIvk+Dmrt4t6uHnoUmBR4ilg8k1js6wvcq
	 r5UWhaP6yD7HLnoiXEP7UNXgotTycb5NDNpACmPMFNyT2knp2LWw/Ex8CMqasTQI9H
	 XUCjobcY4ZQq5MBkgMC01DWv0ShLcz5ur25VadulLVsUZHWfO1s9DPcr5L4aafrgS6
	 IKdDPZgNDtNd+CPkeVJiB5lNE29uJ+rNL4wpzeTm3KqwkDbP/YeghfwEOOr7A0hycv
	 3zSLau1qRxTOMfZX9YiYiViNAdL9HXgQgjZEet6TVs416aH+z3HgKAwEnZpM6SEnix
	 O1sEtkdtg23+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Zanussi <zanussi@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] tracing: Fix fully-qualified variable reference printing in histograms
Date: Thu, 22 Oct 2026 10:08:58 -0400
Message-ID: <20261022140848.1513845-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102122-sandy-lazy-aa40@gregkh>
References: <2026102122-sandy-lazy-aa40@gregkh>
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

From: Tom Zanussi <zanussi@kernel.org>

[ Upstream commit 9236eebd138aa2753f7b30fc6cee7b7202841247 ]

The syntax for fully-qualified variable references in histograms is
subsys.event.$var, which is parsed correctly, but not displayed correctly
when printing a histogram spec. The current code puts the $ reference at
the beginning of the fully-qualified variable name i.e. $subsys.event.var,
which is incorrect.

Before:

trigger info: hist:keys=next_comm:vals=hitcount:wakeup_lat=common_timestamp.usecs-$sched.sched_wakeup.ts0: ...

After:

trigger info: hist:keys=next_comm:vals=hitcount:wakeup_lat=common_timestamp.usecs-sched.sched_wakeup.$ts0: ...

Link: https://patch.msgid.link/5dee9a86d062a4dd68c2214f3d90ac93811e1951.1776112478.git.zanussi@kernel.org
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: a0777b9e5315 ("tracing: Fix NULL dereference when copying keys for a field variable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index eaf6084d65149..31563c47bb8d9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1342,9 +1342,12 @@ static const char *hist_field_name(struct hist_field *field,
 		 field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (field->system) {
 			static char full_name[MAX_FILTER_STR_VAL];
+			static char *fmt;
 			int len;
 
-			len = snprintf(full_name, sizeof(full_name), "%s.%s.%s",
+			fmt = field->flags & HIST_FIELD_FL_VAR_REF ? "%s.%s.$%s" : "%s.%s.%s";
+
+			len = snprintf(full_name, sizeof(full_name), fmt,
 				       field->system, field->event_name,
 				       field->name);
 			if (len < sizeof(full_name))
@@ -1724,9 +1727,10 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 
 static void expr_field_str(struct hist_field *field, char *expr)
 {
-	if (field->flags & HIST_FIELD_FL_VAR_REF)
-		strcat(expr, "$");
-	else if (field->flags & HIST_FIELD_FL_CONST) {
+	if (field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (!field->system)
+			strcat(expr, "$");
+	} else if (field->flags & HIST_FIELD_FL_CONST) {
 		char str[HIST_CONST_DIGITS_MAX];
 
 		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
@@ -6139,7 +6143,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
 		    hist_field->flags & HIST_FIELD_FL_ALIAS)
-			seq_putc(m, '$');
+			if (!hist_field->system)
+				seq_putc(m, '$');
 		seq_printf(m, "%s", field_name);
 	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
 		seq_puts(m, "common_timestamp");
-- 
2.53.0


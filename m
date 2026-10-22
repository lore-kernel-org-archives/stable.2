Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680819;
	b=jd0/YHplnjUUzfPLax4myA8Unw3KQEAD/rU/vK6VZZLJ2iM2oEvqNHQzCi86e02QsbQE
	 XEXj3uoTFLnRiZc8BIsBMGUarrD7RZ0an4EU1nRLt2/zIEUgmbX07PabLlk2J6bJRLQmb
	 2oCIP2s7fKVHp5dIev9b4MBYhoi8m00mkGdge+qxOjA1qpgr5gB32JgtrivLmwMaERP0V
	 iT5YuzEV5L3H/uNoFtwyy+buHpgDkU/PptyV1rN6te+yAuWxP+iA6IkQ7PdAbZc8+4VE3
	 K19BmpvwSkZZirpBiic5LC1dMFdA8KCfwRbOsTnusgvEiQ+VObzZBkKmJy5Cujzo+1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680819;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pJChO1JsxLWliVYwBITWyT1UVJdN0kS6qqUSWqGoqW8=;
	b=5dzEOWhtaVFt6vvKPFBeh1VzzNbtmae5jd75OYSk2QpqagNGwiimPl10/ofnhIf+H87L
	 PtZOXA0r+phySXzHvGRDb3lPyyYghPWBxm1ZStwVMOrbc5RKS0rSZ2+1fQTJvWo7nX7oW
	 oku7PQ7C/Vbdpyg97h1MWShryR1F7d3egJSvaglrdwlkMLnB7QLi4RLsaAaAhfEVdhJ9B
	 n3NIJe45aGaIwiXh8ZME+KcYol1fVy0qMsZLq1vnNyK7GD69dxhZik0sqARnOwfalE0fJ
	 bwkT0OOgyLe+pYM9qsQ//AhILlHe1BvwedkMJ/nu98wTuSu7Npt4p1lW5RKOJ5iSkFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZMGCioL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EF606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZMGCioL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52C21F000C1;
	Thu, 22 Oct 2026 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680819;
	bh=pJChO1JsxLWliVYwBITWyT1UVJdN0kS6qqUSWqGoqW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZMGCioLd5sHu50s+eBd2ogBFqsNouL3ER9TCjP6ofIE+5xLPXsFsakDessEiuTYF
	 6IHFy812f20EpmT/WionOCVpHpb2WtMd2brmCanv6im+JekDMaU+Q6L9B6Pyr9voyV
	 JgS2ZvH7N/nWzrYdQRvLzyHlmnNN8ZkDPuJmB/ygM0QWaBURI0oCZQWRYiq++6FAh2
	 b/S9wDdFIU6bqfig1gRMFPRu5CCu7o/adY3ztCAvS0siH5yakNP6qlbh6xuUZsiN79
	 BT3jy1tG+h9s1RC8yuABrETfoelmcuKCUUsb7zfQaAxKJsT3iviOZygoviOyxnLYc0
	 PtZr5lvaZxohQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Zanussi <zanussi@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] tracing: Fix fully-qualified variable reference printing in histograms
Date: Thu, 22 Oct 2026 10:53:34 -0400
Message-ID: <20261022145315.1599452-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102123-faceplate-shallow-02a0@gregkh>
References: <2026102123-faceplate-shallow-02a0@gregkh>
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
index b4eeb921095d3..f2af4605c9894 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1339,9 +1339,12 @@ static const char *hist_field_name(struct hist_field *field,
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
@@ -1709,9 +1712,10 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 
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
@@ -5842,7 +5846,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
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


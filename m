Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676565;
	b=t4XURo2SwG5OYeTtePUe+n55wSuGh5Wf3duG1qNB9AuHiL0gafHSsOQ/FZ6hIuVSvJRQ
	 oxAKWyBhtFuzjtSUoXrrPAAH4JQAN+d8X396Ipp8ET5np7Q4DKQqW8kb0EaFRBXO3t2Zd
	 4Mc4FofrMCqqhg82vCPIcClB1drEXKe8Mn2efP/MUHEJB92419TRMamNemSV7zAjXbCEz
	 2lRCRY3a3GZM/APPHcxuSuCYmn3mCD/wFnROrW3KT/7ULIba0LghiVVFUgq+cyAGAyVpd
	 3dj+Sh2MM+QQINPH61lumc6a0ukVM6w+0W+zKdIddJ9omNBX+YO9/5l7tXroCuNmB+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YmIclGySJ9hBWuStNof5v4e1D7qYVK7xk32MmCNoaC0=;
	b=INr0oD2h0n148l5rw/wjXf7LgzWORwJLEO155RB4S13VgNfMYqVQnTZBiSfUmmKUoDUS
	 PpyM+E2cuNKTuLm9GWDZWxIwLFMjEz4Yi6ZgwR0TLJMYnOSQQ32JkIwFvmjcsBgPFG2AS
	 6pkSH9XXz9/QRIJ0HhoGmbD1AACeqbr0+R5tjVQk2XUHq9Rgl/CEfgOyEcANQcsLdAmm8
	 gcGkLjuuvDGyRVi4EDexRJodQ1UlRGKMR5QYIDqLTU40KoWKDL3Ol5ELsydRz0Sp1/F0i
	 4hXksnNa6gP+eQL4sOsc3wMCcMm/jn+OeFoRcp34XgdWJxBUa4gsCPUjJMVr7ZdIVzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrvnOOSv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17837606A323
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrvnOOSv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF961F000C3;
	Thu, 22 Oct 2026 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676564;
	bh=YmIclGySJ9hBWuStNof5v4e1D7qYVK7xk32MmCNoaC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mrvnOOSvqKwckGXiWojYOkSaWpd5PfidQsI48izPA47siyl1lZl9rD2qonS5pTLFJ
	 /WPfWtd91nUEQ4Cx1sefV/Ebk+/2srPQSMjBdn6KtGCNsvupkfvUArS9fjA7mhbRA/
	 nR+A7OG4bqtyba8q6OtIrXZJEOy1RSbPF+RG0HUgMRSqwMJElKn/oHPBIF6FeZ9G/m
	 Vxb2+V3eVo6CuDGDcZxcl3i5vJvQ7Kt0Wb+bksZYeU8uMqMUbDSuUWyuoH2JGr4hWf
	 Whmzc9lghjT4RpgWlhD7pFuZEzxtSETUfKU63f/XikwVhAHW55KXuwogNJ/UPZdv0d
	 h7jiJpWtb8gTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Zanussi <zanussi@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] tracing: Fix fully-qualified variable reference printing in histograms
Date: Thu, 22 Oct 2026 09:42:39 -0400
Message-ID: <20261022134230.1444063-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102122-spinster-handler-2d56@gregkh>
References: <2026102122-spinster-handler-2d56@gregkh>
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
index 20d23a08b5b8b..dab2b3dc176b9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1355,9 +1355,12 @@ static const char *hist_field_name(struct hist_field *field,
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
@@ -1734,9 +1737,10 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 
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
@@ -6167,7 +6171,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
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


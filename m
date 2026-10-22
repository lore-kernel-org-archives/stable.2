Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678670;
	b=GGQM1YqTOEQNBZUgWdMbybEQaN/S5wkEBz5TV+yl43sw2KQS5qbMItfZ8eE/Jk1K5bIs
	 2IfILHnNggyun5ec4nM4Ve2VmgDCERoSmZjez9THXnW2KFbwQRGwG35u+2FyzotKqrpAv
	 hgWav7Z50X+zFm6VdSQUalxMYd7owyedhHAIciZ9KAKZtqwsCVcGZ15aVWTk24BzUJnGF
	 hK98FI8e+P3mab30Q1JAqb7Wyd20VQ2os0h6OW8eGWNnjJqnVxu7bu0p4aL49Vr4Zq625
	 z6mZume4zrvJSFomm4DcjDvaeyMcCiMt6vvz0MKYYhxAsgDkjTlPf+BwxH7U/pEq+pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678670;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dOCsWVD6poMUMIY3qxaf+7j9z549uJYTqXiLQLY6ATg=;
	b=BcI/9JgxG3h1VIvECinzUTT5sWqyRJ/SZnIpKsioHWjDQ6wgeIPb89BtnE+a0FVw0F0r
	 5hwOhc4LTABNs6QH9gHmntBNPktKtAkbgTv+Laq2qQ+CejyXynHis56LnnYqp8XLfbHJN
	 LKinyzj2bupwrgfHCtaOabs5ga2H7fZW9abNaLZq99Igw+pNHdwK6IWsd0t0yD6rmgHDb
	 Sry8qMT2EYXcT3reW7/8e78znAUD6LmUt8PD/kxq+WteqkDvjAccqINHPVDj9SUM4H01n
	 iPFSgubI/kuHRJWzrFtPBKOZAZx4u09zZggn8X2oSzIkksMLOvUq9AnSIXOyQ3lQAUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+8nKUnu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56850606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+8nKUnu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6320E1F000C1;
	Thu, 22 Oct 2026 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678669;
	bh=dOCsWVD6poMUMIY3qxaf+7j9z549uJYTqXiLQLY6ATg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M+8nKUnuLBLR3IIPeKApfR4hWxCbQTeAbTE9q8UNK9OmAuBu6OLYJpXw0bnW1SESs
	 4CJAZfI7NZbaABU82b1C9Z1892jgctOY2yHb41rEdShkgUYOoRTq3VTSAkl+sLqLl2
	 hIba5W7bFXz7kos5tH24aENwEEkK0rp5j81pWlhhzxYj0YsYWZEz2rE2ABy5d5cFI/
	 p/tYJJWrXIRRM9E0WThVGkYvfFUKX85q5FtQ8/HVbH2w1icRsHCGyF4+GZ5V6dPfI0
	 TLXJjidUpL1BCRnqg4wFIyZv3+Iq+HzdKQyO2zu2uT1JGJfu67Ne86Snnh0o+JMoaG
	 8KMqZXe89hv1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Zanussi <zanussi@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] tracing: Fix fully-qualified variable reference printing in histograms
Date: Thu, 22 Oct 2026 10:17:45 -0400
Message-ID: <20261022141718.1585988-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102123-crushable-fragrance-1b92@gregkh>
References: <2026102123-crushable-fragrance-1b92@gregkh>
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
index 46d58e0d88c10..d92ac0b37a378 100644
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
@@ -6140,7 +6144,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673685;
	b=XB5Y/a72wEqlnkyN74303culD2AAO8TEQZA0d0Oqev/TvAw2eLHMaszdHYc5A/hkZVuX
	 +B57be5kh0SKY0WpTPqMA7VuVX3cjTB1qWNF4wW1r3lCNWazFLR1EMO7SpmMX00YJlIZ1
	 NF8FFeUmKLuy37GAKJojKAo44SEwHOVrO9CU1OiWEo/UxeIyS8VED7IYwbqshsOBGqplB
	 5m3ZcAalNtt7akuUY0xNwYUU+67HZ4QgeNVXTHWWoqVGa8RY3PVPmo6buILB6YOSppYux
	 5YKZKADH9i2mMGMKn7c8ZiF/3czofA0ToYalN5+8E7G9WqWaCGV55DfV9UMwU5T7vKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qBsfA7HS2a9Ojhy981op17IhypY2l30ZwgdhcpBePEo=;
	b=h7OXN8+vKUBl7U4Bb+UNRX59bDwoyYhImkaCKrehjHFU3vXfqfJ8EooyHJxQS62wRZ/h
	 mOoCS57P6N32Hnsxf/RT8jMdGZtFAxH4Gsq7DrPnrtdE45uk2CBVlkppZhMlMsubylY8p
	 5UYVCnAvocuZcu54yf4Z1xmhUnjGa1vxtlfFm3QtAh4DAODO5o0ZVYUndIu3oPhMZ/IFc
	 fMATGaE4cRH9aCFPoXfDPd5UFQvGOqbHGHyZD1G1Eg0dpxdRrv1D8xBhMxueRw6QGQu2K
	 7qagZXcCItGIj+LX8zcHu0Cv8vXgxdayhExPnMCPy5DlqugK+YZ2AQkqu3abfbaxo1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blBNscZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58B606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blBNscZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36051F000C1;
	Thu, 22 Oct 2026 12:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673684;
	bh=qBsfA7HS2a9Ojhy981op17IhypY2l30ZwgdhcpBePEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=blBNscZPz1pRnd9bEOA453sIHFcbrQe6RdMn+mE6TL5SB4Rrr9iQLsRCO88xTXPLL
	 +wnjdFLDirCFyshEQct59TNFYGEmwBnjz6lVGb99rfIMGKUzYagE4/A+8V6Z8trp/p
	 1eowtIOo7F4QlCZ6Oau8sj5NSFQQPwn5mv9Md11BJLbMMZt3KAVYDp9jTP+cJlQrFc
	 g2ixSKbr51oHXzBSTmHFFuaoTKUVJsk8Q85sLzs2qHtLExHVaXvbZldBNDXokS0nOf
	 hNwjBgTh2UPvkE/QK1Xusc+SdPmj/qaKo+PArGRSfNQpe9slq5oC9CY0LO0PlxXYve
	 0eFbZQ/IilOcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Taeyang Lee <0wn@theori.io>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] tracing: Keep the predicate limit separate from program capacity
Date: Thu, 22 Oct 2026 08:54:42 -0400
Message-ID: <20261022125421.1190173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102143-backlog-glove-c78f@gregkh>
References: <2026102143-backlog-glove-c78f@gregkh>
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

From: Taeyang Lee <0wn@theori.io>

[ Upstream commit 803aa6fc2dbea25ab9d3ed19eca1c96d0ab17445 ]

predicate_parse() adds two to nr_preds to reserve the terminal TRUE
and FALSE entries. It also uses that increased value as the limit for
parsed predicates. If the initial count is smaller than the number
actually parsed, the program can fill the allocation and subsequent
accesses can go past its end.

Keep nr_preds as the predicate limit and use a separate value for the
allocation size. This leaves space for both terminal entries and a
zeroed entry when parsing stops at the limit.

Cc: stable@vger.kernel.org
Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")
Link: https://patch.msgid.link/atELCd1XjKVhrkFL@Taeyangs-MacBook-Pro.local
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ sashal: Adapted the kzalloc_objs() allocation to the existing kcalloc() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index fbed36c49ef6c..7985bbdf2ba65 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -482,18 +482,17 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	int len;
 	int N = 0;
 	int i;
-
-	nr_preds += 2; /* For TRUE and FALSE */
+	int nr_preds_alloc = nr_preds + 2; /* For TRUE and FALSE */
 
 	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
+	prog_stack = kcalloc(nr_preds_alloc, sizeof(*prog_stack), GFP_KERNEL);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
 	}
-	inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
+	inverts = kmalloc_array(nr_preds_alloc, sizeof(*inverts), GFP_KERNEL);
 	if (!inverts) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
-- 
2.53.0


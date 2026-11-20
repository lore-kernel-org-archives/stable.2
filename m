Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196477;
	b=z1oOa4wFdduGYMKe5/cVL2yyD+MYzPvK2YtxRjyCK9H5o5lUk4T+zVAjIixB2ZDSeN+y
	 18sf1cNTtlRnjtVz3t4dvZiykUGHKaedkf5Jv29NV0S1HEourLtwQvoP8bMFM5J7r1wL1
	 PxMjShe4cfaGEC1/J7OKzSbUnoR+PwllsZcSfiod8zRps/Dee6rIMC4B26lU1/EzniPrK
	 UZAyh9DB/gAVdrRCY+vStVNGhfxPjh1sUr7tpnbGm/GvmSPSJrmzU+2ADIECKqszekqca
	 PD9KP5zATaztCdM0IYs23UBR3qzRsTlWbtv35DoGG3S8tRaQBxKe7qUcxLETBNlkBVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196477;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=4tcPV1esp59VoFMfAqyjm1xbf493o8GVPIIHyt4HxhI=;
	b=h5X/pKrsIKsK08oc6WonkcVMoryNQttmgqGTGtr6cIx6fd39mEhnkjUi7iKLvi1xgMwP
	 +FuUQCyOkN6/6aoKG8m36LibnshrrTQ0Zsq8/arpmfyUxEEmaVziGyGXStOYDstskssZV
	 6RZmUSj8Fp4gDG7rS9Wud7gf9a57oRKBkuWG0F/wU4k66ja+dba0EelXHfRLkM5q7W6z1
	 Qn7+e6LHc3K4LSyjkKtG+84Vf4CPP4PXT91UUbEDuOvjncfT6WNhTxX5dau0LJ7ER5RIp
	 svEadbFjCxIUDroQHuSa2Nyih4c261sf+sFcMyvy4FTLjBRJoqV9To6GMNXyj4xXWkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAFSYVR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE560A3809;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAFSYVR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9F41F000D2;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196476;
	bh=4tcPV1esp59VoFMfAqyjm1xbf493o8GVPIIHyt4HxhI=;
	h=Date:From:To:Cc:Subject:References;
	b=WAFSYVR1ufep8NpUUjzF6ZNpZFd1wGc/82d4yEAkt+6UpTkm76N+cz2nkBsxtibSb
	 Ev36RM5U6BY0CxYZuXXiwOvQ/jT5lOcyBumxgQsidkfazw0yzlHjTxjaAQudL3J7av
	 jib02cSm9LEgpzaxV8kDeBIMBZZIDQ6Pw2G/e2ZFnzq6T3NQzBw4Mtkl5hkvTbNeKU
	 0cvTRdeJoYo55PejvM88iI77iojySz8GK5HArmaLeoOUrwNzENbcCg7vfRlzde5adv
	 iVrwSggGZUb+vNqfzr6HUdaoINgQkUzotcbxhQ4xtzXlX9rL1gq0/gDjpQQa1jgRVF
	 8IH91Y62L6LIg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbs-00000004aJn-0UrE;
	Fri, 20 Nov 2026 12:41:16 -0500
Message-ID: <20261120174115.949909796@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:02 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 10/32] tracing/filters: Check for missing operand after operator in
 parse_pred()
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

In parse_pred(), after matching the operator and skipping whitespace,
the filter string may terminate (str[i] == '\0') if the operand is
missing (e.g. "ip ==" or "common_pid ==").

For function events, the loop 'for (i++; str[i]; i++)' unconditionally
increments 'i' past the NUL terminator, causing an out-of-bounds read.
For other event types, allocating a predicate only to fail later during
value parsing is wasteful.

Check if 'str[i]' is NUL immediately after skipping whitespace after
the operator, and report FILT_ERR_INVALID_FILTER.

Cc: stable@vger.kernel.org
Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Link: https://patch.msgid.link/179323789181.740114.16161070743864669086.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1b960cfdc69d..32fcc6215d24 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1766,6 +1766,11 @@ static int parse_pred(const char *str, void *data,
 	while (isspace(str[i]))
 		i++;
 
+	if (!str[i]) {
+		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
+		goto err_free;
+	}
+
 	s = i;
 
 	pred = kzalloc_obj(*pred);
-- 
2.53.0

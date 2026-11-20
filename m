Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196476;
	b=Cu67fWiiIq8q4HOHfunIVsBxWxTnSt/YLaSBZUvEzWXB+s7Xr0/b66MWUqhok9WeaL+0
	 Q1bMOAJMw4sAUKQh/VqW1Fr5aUDfN0ZXow6VExn1F+7vCHJ0KmEl+kPCX5wF6dPxGvByK
	 ll/bQF/SDWOXK0aP0o9Onq4zm5sM7rX2+zibv3UELuvtsq3AH4VUUhlBP6ram/EKDeixi
	 OlwD8BC2ArPSE7CT4DdGqzttxlnfgHSDDQdqPrQDmnDd8iri0Y1fBFzvSSZYurgTSGf+a
	 rtC659/AygKUIMSZXw7bQik3uwEyZ16cg2LL/z4LuC9HeH2+qQdtx7nTsAkRScKB4XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196476;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=5/mgREcDRE9cm5A9J87qj4yWsVHq52QY/AnMOSNx1rs=;
	b=whYb+FoiJfzWdAAfGXI0LQiVa37WSX9RUnI6NZt+cr87jJYaIRLvqbhT32xcOpBzw0RF
	 Z7EC835WXph9y01Gz3RXZq6FIMpBKWMAbJ+7aZZmC3kgeQiMKARmQh9nb8WvGW+9E5GIe
	 93ye3PkO2Xe+Th20wOc1HaNT4pSOZIegRX//b16k7ViZ+lVQhqyZltU2T+pvdvi46+XIK
	 q0V1YJc6FRU578hDGw0d38wTqLX1hvo/U/cvEWu6mJFX70aZGqEg4Xh1lCnjRJHpmut3v
	 OREmg2ktJnq2L4JsAbN4NVnoPbfyzVC0Oo5jHC0tsKCHzbGTfetOryrB2/AE+3/9BDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyQ6HTRQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D260A2623;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyQ6HTRQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369361F0093C;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196476;
	bh=5/mgREcDRE9cm5A9J87qj4yWsVHq52QY/AnMOSNx1rs=;
	h=Date:From:To:Cc:Subject:References;
	b=iyQ6HTRQPBuYdABElXAxB6Z9dGq/HOu7ljkeJsPE9IzKVCdasu70Uo5qXi5fpxUOE
	 E/e4RjSNKn1A9EZoXCUZosUoTeNrGI9+WGt6runSkYGPDv6cJ3YGbhFH+uO25n1yyh
	 zuUjOUcgzRTHc4Mx/qsq+7b7fhRvJnCEy4/A/FGNb5f+LlTFyAvxv/pN0RmfLxPAOu
	 6tlsoETt7BmE9lw62ppNeteVzxS3th0MshFhXTO06otahQoeD78+w47CzpKWTysVEo
	 EBFG8k9tsUU4gOGIJiov3TnplVEilJzTcBrK1nkJZXBn1U4JgfUzANsW2qkERV+hzI
	 CjX6TSvYh39Qg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbr-00000004aI4-2MDe;
	Fri, 20 Nov 2026 12:41:15 -0500
Message-ID: <20261120174115.385884577@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:38:59 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Jaewon Jung <jaewon8868@gmail.com>
Subject: [for-linus][PATCH 07/32] tracing: Avoid undefined shifts for zero histogram map size
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

From: Jaewon Jung <jaewon8868@gmail.com>

Reject size=0 before calling roundup_pow_of_two().

include/linux/log2.h documents roundup_pow_of_two() as:

  - the result is undefined when n == 0

With CONFIG_UBSAN_SHIFT=y, a size=0 histogram trigger reports:

  UBSAN: shift-out-of-bounds in include/linux/log2.h
  shift exponent 64 is too large for 64-bit type 'long unsigned int'

Tested on x86_64 QEMU: size=0 is rejected without UBSAN warnings,
and the histogram modifier and parser tests pass.

Fixes: 7ef224d1d0e3 ("tracing: Add 'hist' event trigger command")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261028074610.2212374-1-jaewon8868@gmail.com
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a87d626e40e8..d4702ad4e003 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1430,6 +1430,11 @@ static int parse_map_size(char *str)
 	if (ret)
 		goto out;
 
+	if (!size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	map_bits = ilog2(roundup_pow_of_two(size));
 	if (map_bits < TRACING_MAP_BITS_MIN ||
 	    map_bits > TRACING_MAP_BITS_MAX)
-- 
2.53.0

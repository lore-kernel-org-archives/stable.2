Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804963;
	b=yGlhZ+PCPJIIGpKM/7nBaP2QQZ3ZhSt013LG7XMsB+AP/qqw9Jsvpuk9fr6/jyMGgB0F
	 dbvNz964SkK1tRfxZGsErBLtuSwO/9jLPtU+UMi4gZSFVYk8xIfIrWC7vcXvSvoIpw7tc
	 4WdapoR4NltpzDMqHzIOHNB6xb1lS/0aKiYXPYJVGH3DcEpSTTl6rAIfwaoBTF9E1ojEA
	 GRAfmuFKC8AfKTgX7pRzzEn2t459PWOZgJjg9Ku4uqAY82FWzrXhXCtNqpXPTAq6ED5LT
	 PIPj/HwQTPBQHAB4nFv1mvemjQWtDxgFzwSO5VCJr7aN8pGYwDn0if3ZsR9pvFgLg6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804963;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=i6vuZp5iYUjCT16EX6/ryDV5VdHO/oUi/XuED6Um3Dg=;
	b=tlgTu+85ZdCKg/ZX0aUVThpQ5fU5veyFoje1uHH2LB6eYRp+MNi0dOqz5KPRYqKacywn
	 /WjyIf7C/FOxOvzh/ROy2l5fifh47pYOxkRlp4Xjd8hOD0MI/Y6zcNsi9MG35cKD6ThC0
	 K/CBKLSeggGSbi7Pj0x/DmYWR0pIVV7yG8dd9arbFvWxywZO76KdktbOHaMHR4o9sisBk
	 K3274STuqu8qvB9elgRsEX3YJ2ljsmiPS9EKCB0jZU1ib/jWDN8S686+Rt78zD3d10FXH
	 2SYbdlZsYcRA/uQdj1wChpbfC1SwUklFHwPYgUzqahaaqgLJFocDwihpYkqYthsKGig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad0hTuHo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370C60A2617;
	Fri, 27 Nov 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad0hTuHo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251A21F0093A;
	Fri, 27 Nov 2026 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804963;
	bh=i6vuZp5iYUjCT16EX6/ryDV5VdHO/oUi/XuED6Um3Dg=;
	h=Date:From:To:Cc:Subject:References;
	b=ad0hTuHoj7BS20iNcGvtV060azXQp3gLUQ/rsGjxKswj0WqQUH21OgSFzUTPHN1GN
	 k93CPL/czMO0CK0uNB33UJpcZObWtkGTOX4V27iv6Oj6N7KLRrhzVot/kPiXcDg6LV
	 5h5nK1LvpsTbDaEFHTgedwAUHRWH0EXxWTTlpA/nCENDH0MCTj3RMfQQQZ02qRO/4Z
	 VVaLcBhcBWwWvp5DzsBdmbBUlpXBoe8a+rODXnfuFGN/7RgRhCb9S9K1nXTa2YEhHn
	 yPUEKooZp2BSapnGE7VZW1FLxzcV/8x8QZvLlgIRTrJLnoBPNECxV5ordr/ejDUFBo
	 cqgKYO+thspPg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xX0uA-000000085aS-1eEM;
	Fri, 27 Nov 2026 13:42:42 -0500
Message-ID: <20261127184242.197661244@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 27 Nov 2026 13:42:07 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Yifan Feng <evanfengff@gmail.com>
Subject: [for-linus][PATCH 4/5] ftrace: Reject "!!" in front of a set_ftrace_filter command
References: <20261127184203.439481361@kernel.org>
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

From: Yifan Feng <evanfengff@gmail.com>

A command written to set_ftrace_filter with two '!' in front of the
function glob triggers the WARN_ON() in
unregister_ftrace_function_probe_func():

  # echo '!!vfs_read:traceoff' >> set_ftrace_filter
  WARNING: kernel/trace/ftrace.c:5675 at unregister_ftrace_function_probe_func+0x662/0x870

The command callbacks strip the first '!' and pass the rest as the glob
of the probe to remove. filter_parse_regex() then reports the second
'!' as a negated glob, which function probes do not support.

Return -EINVAL for such input in ftrace_process_regex(), before a
command callback is called.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261119191205.32892-1-evanfengff@gmail.com
Fixes: 23b4ff3aa479 ("ftrace: add traceon traceoff commands to enable/disable the buffers")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6654da9d1bbf..5b161959e701 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5847,6 +5847,13 @@ static int ftrace_process_regex(struct ftrace_iterator *iter,
 
 	/* command found */
 
+	/*
+	 * A double "!!" confuses the parser. This isn't a boolean operation,
+	 * simply reject it.
+	 */
+	if (func[0] == '!' && func[1] == '!')
+		return -EINVAL;
+
 	command = strsep(&next, ":");
 
 	guard(mutex)(&ftrace_cmd_mutex);
-- 
2.53.0

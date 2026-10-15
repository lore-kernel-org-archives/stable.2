Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FA502790;
	Thu, 15 Oct 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071245; cv=none; b=cvjkv4f7A/xLKlYn/vKgIW1bOwXCHOzT10FRBylPdlH+NbxL2xKcsXlL4wWp7K+96hAN30xAWz2eAnjuZgWEZ/LKMTW0adFbEtFAeE/agFUb8CW0hUf3s6a9jL1vUUi2fXWKPgNIsTcTgXvWWjEZ0mVqEx3sLADvAL8j7weEvUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071245; c=relaxed/simple;
	bh=DkwHn/n3XWCCCg2vRVqMcAqGzjELYN7f2gm94hH7FSI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=B1bGkwCz0BkQN+sMTM0TvTPQICm0P9cd52HQ0guowqfPOlvpLzw2EIXwifKYGzEaZAGPX7oQSfaQ1qbGYYf5YhNirKQrAcQqcRctgbTgKxLZPrF22N6LzApPooRU9OJI7qq9juFcjQTvPO8kqqyrRe42nctNqrfAtyMe3f+vqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaVkAGcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaVkAGcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927EE1F000C7;
	Thu, 15 Oct 2026 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071243;
	bh=8qK15AQdRs6yzl/85eIXds8p4N+fLR8+s4SHk6k4sPM=;
	h=Date:From:To:Cc:Subject:References;
	b=IaVkAGcFe4uFZHiWsFBjZJn0s2Loow65MEQrSxiFtvkoVorhNVkY+xsTpXPGDj1tl
	 VdVzwF12cVSUNL1xm6D7n5QBRcxGdf6B2793h65RUZjaJXVBf4t2evLw+c/84NugbM
	 DgU5A6RFHCL7HYQtDzLRHEPsesF1ayYgIvQuoXdWM5DTPsjLL0HOdwtZO44wX6+p/t
	 iwd0+tcUVbBKZP6r1Pm5D2ncrOVKwIHsnHemciQkDyA5RMndrodKMrnyETBmYbPI2i
	 kCa/z2wuVKkDPOUKNYaW1slwxZQJxHgR1Jdn+100wyfz0CS1HVyCBGGzLHqEhcxeXs
	 dq5Te5l3GRgVQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLas-00000000Mbb-3scr;
	Thu, 15 Oct 2026 09:34:02 -0400
Message-ID: <20261015133402.725501079@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:14 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 04/16] tracing: Fix the shift out of bounds in the log2 histogram modifier
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

The .log2 key modifier files a value under its base-2 order:

  # echo 'hist:keys=bytes_req.log2' > events/kmem/kmalloc/trigger

hist_field_log2() computes that as ilog2(roundup_pow_of_two(val)). The
out-of-line form of roundup_pow_of_two() is

	return 1UL << fls_long(n - 1);

which shifts by 64 on a 64-bit kernel both when n is 0, where n - 1
wraps to ULONG_MAX, and when n is above 2^63. Both are ordinary keys,
because the field fetch hands every value over as a u64: a syscall
argument of 0 reaches the first, and one above 2^63 reaches the second.

Keying sys_enter_lseek on offset.log2 and passing 0, 1, 2, 3, 1000,
2^63+1 and U64_MAX gives

  { offset: ~ 2^1  } hitcount:          1
  { offset: ~ 2^10 } hitcount:          1
  { offset: ~ 2^2  } hitcount:          1
  { offset: ~ 2^0  } hitcount:          4

Keys above 2^63 land in the lowest bucket. With CONFIG_UBSAN_SHIFT=y
the shift is also reported:

  UBSAN: shift-out-of-bounds in include/linux/log2.h:57:13
  shift exponent 64 is too large for 64-bit type 'long unsigned int'
   __ubsan_handle_shift_out_of_bounds.cold+0xdd/0x1cb
   hist_fn_call.cold+0x8b/0xd9
   event_hist_trigger+0x1cc/0x790
   ftrace_syscall_enter+0x197/0x360
   do_syscall_64+0x402/0x4b0

Use order_base_2(), which is ilog2(n - 1) + 1 for n > 1 and 0 below
that. It returns what the old expression returned on every input the
old one was defined for. Where it was not, 0 stays in bucket 0, which
is where x86_64 had been putting it, and the keys above 2^63 move into
bucket 64.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260916002735.808520-1-donggeunyoo.kernel@gmail.com
Fixes: 4b94f5b7b4a5 ("tracing: Add hist trigger 'log2' modifier")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b3df8862855f..71d7f43a7964 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -289,7 +289,7 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 
 	u64 val = hist_fn_call(operand, elt, buffer, rbe, event);
 
-	return (u64) ilog2(roundup_pow_of_two(val));
+	return order_base_2(val);
 }
 
 static u64 hist_field_bucket(struct hist_field *hist_field,
-- 
2.53.0

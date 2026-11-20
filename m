Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196478;
	b=bUmWqQbpTT19MoURvf0lVEI5KXqFF8zxHTusZbElWTimk/YS/SJXArWvSSp0XQ6jWQRO
	 Dy/KBI9rD3qNbqKo/bnqIiMOTNv2u1sSO3gJPV09ykuoHbh8f28kRVGUZvfHtzkDjOJa6
	 JRmNO4f4YnuLkRRc4GQjiXP7ZU39Vapkj5+sad/ppqifF2no+1L4+HJUpSMJ/Govk4t9D
	 vbGD5DJSStfqrENqsckBjR94SG65d4YLTjzhKZdVDd5sQpv685sDpXsLwRNTJ/PCUrTtd
	 i64m+1NljqkqTOGfwyN3ctDA+hxRciLGxJ18/kuqQTUcNwKSC2ltbhv5tBPZwWURQCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196478;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=gPY1qtL0NG3BEqtvAhhfn+1WQEbBzKYd8vzgd415+Jw=;
	b=zYmyvo+U6zQCu7WobeYm8/D0CvG4ItYiiLXRJzohVT5hRgc5gryE4cSuxzU27NBPkpQb
	 6JvVJgYwQ3BiElGcyJqd97tKbxHQ8Qf60v+Bz0qk6qxCa9yL4xkRpnhO8bKl8IqFFQpbE
	 J/4oAfRRAaR4dU6duCcncKxSGwEVgXucjuYG60MYCyyUNyx3cXq4bRWeSO8Ps0mvYgg7K
	 U5UlrcOuyiv6fpqSpVw7BFerKchhVs9P0DROrHiIv9WZunw9GKIHZ3CFbKrdwHImghGoG
	 ZDiz3Iz0go0P3X/nTmTOtvP+fbrBWUIPPPOGN9/aTYtBes+ZSkKTGAgTSvSWxj4Lyrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqsBM42Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77160A5BDA;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqsBM42Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DC01F0156E;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196478;
	bh=gPY1qtL0NG3BEqtvAhhfn+1WQEbBzKYd8vzgd415+Jw=;
	h=Date:From:To:Cc:Subject:References;
	b=QqsBM42QHkCJ8ITjDnid4DDaFnqQ0jbUCHLTdIqAtrZS/TqbQ8Shah4PxmhfwiKYK
	 Midq03OnqMXiI2Duj6t4EpypOZ1ZGeAGYbrQgx34arFD93rxIXIDxwyEhHFbK+Tnhd
	 rtd60Nzzav+5MbRNsudBfuHUlvzQI9wQA8M4fBVTORzVUpbLSDKR+KVMF+BaR5zAvU
	 L0mtZFG6/kx92aukKD5yW6z4pZU6CapmPU1+NCZMYQr51P9pjV+1ZgF5MRsZ7zlthM
	 skKF4HTnI6tVLNjo8d6fpW+9z3tumRNjLIJSrW5o+l5XU+OaM701R/NCpzUSSwwze6
	 Ool2DLC676N3w==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbt-00000004aOs-3FUK;
	Fri, 20 Nov 2026 12:41:17 -0500
Message-ID: <20261120174117.616580958@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:11 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
Subject: [for-linus][PATCH 19/32] tracing: Validate user addresses in faultable buffer copies
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

From: Kyle Zeng <kylebot@openai.com>

trace_user_fault_read() uses __copy_from_user() when no custom copy
function is supplied. That primitive assumes the source address has
already been validated, but the helper only checks the destination
buffer size. A caller that passes an unchecked kernel address can
therefore cause mapped kernel memory to be copied into the tracing
buffer. The original syscall-array tracing implementation exposed this
path to syscall arguments before the syscall validated them.

Use copy_from_user() for the default copy as documented. Non-user
addresses then fail the copy and follow the existing NULL-return path.
Successful user copies, buffer bounds, and preemption and migration
retry rules are unchanged.

Cc: stable@vger.kernel.org
Fixes: 64cf7d058a005 ("tracing: Have trace_marker use per-cpu data to read user space")
Link: https://patch.msgid.link/20261110054411.75788-1-kylebot@openai.com
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bffba5e27086..70b3c11ac166 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6298,7 +6298,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		if (copy_func) {
 			ret = copy_func(buffer, ptr, size, data);
 		} else {
-			ret = __copy_from_user(buffer, ptr, size);
+			ret = copy_from_user(buffer, ptr, size);
 		}
 
 		preempt_disable_notrace();
-- 
2.53.0

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C613876C5;
	Sun, 13 Sep 2026 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319849; cv=none; b=uYgvuBAvHD+r55Hm1SFRvYrMLPM0Ttfo6VdsCMjlTG4S6DGtceDC6A0yh/5cS8ZNDp3vrnwwQL46HJxFHWn6GOVm83xtGMrf7tjvvOqsFMb+V+pufk83bFOgvNq1iwMQDpNCHaV2hSArSfuZ67lMLSoB4tGUpXqFYYoedHdMEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319849; c=relaxed/simple;
	bh=PCrMvJZRXyZvSFsHKytg5k3o8+DFbRdxMwl6rjj4o3M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FlJeGkwVjRo8wIc3s5rjc3Fby5GKeJZS59VG+18L2scvbIi0ZSCo1iVNbWE7kTPtQvT9nIFg/lzGqgbpsqpf4kbhM7Tek4a59Bn4naqCI9XeSxJyUDPfNvHq+pQOO9GSuYi6/A8PuDglSV9UbyD6Z6NKROLUw8cv2wMe+A5wQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se9QN1en; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se9QN1en"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6121F00893;
	Sun, 13 Sep 2026 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319843;
	bh=GbJxA/XWPkGKugAgSRyy9K65mtSnbgmieUz75IVn5K4=;
	h=Date:From:To:Cc:Subject:References;
	b=Se9QN1enyUFIhJAukCjf8aVzEMHHQHNfn+O4syFnG+khabQapulZMw1nol4uA9vqH
	 bmLnqf10+/bKt883CpnTk59ZwUtLGEvBhk1jcBVAW+P4D7DY+OSIGqBlzlPzPT3dyp
	 TJUZ15ik1Cy2RFUcmrwgmRLCWguwrcltr5NHY8Yh1nzNKaoUDyYNIqRpRaLA220JnC
	 2Em4apzoFtVOxhkg8l5RSN9SYyeVV5L48jrqRUa737LMaYGBV/XHdpjiMVcaEO9Ett
	 wUsTa+QPIvEIZv8I/7d/h8/8xBt17oT28w4Sh1qLvZUja1UKSK2vWAuM39m/rXSHvL
	 iOLxOk9tHwn8w==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x5nqr-0000000AQZ4-2jYA;
	Sun, 13 Sep 2026 13:18:49 -0400
Message-ID: <20260913171849.455534017@kernel.org>
User-Agent: quilt/0.69
Date: Sun, 13 Sep 2026 13:18:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 Leon Hwang <leon.hwang@linux.dev>
Subject: [for-linus][PATCH 1/5] ftrace: Use rcu_assign_pointer() for tmp_ops filter hash
References: <20260913171759.469375546@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Leon Hwang <leon.hwang@linux.dev>

tmp_ops.func_hash->filter_hash is annotated __rcu, but
update_ftrace_direct_mod() assigns hash to it directly. Sparse reports an
address-space mismatch.

Use rcu_assign_pointer() for the assignment.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260911142512.19344-1-leon.hwang@linux.dev
Fixes: 50b35c9e50a8 ("ftrace: Use hash argument for tmp_ops in update_ftrace_direct_mod")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609110704.Q3M5vCDV-lkp@intel.com/
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 53d5db60bfa5..673a54fdf392 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6675,7 +6675,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 
 	/* Enable the tmp_ops to have the same functions as the hash object. */
 	ftrace_ops_init(&tmp_ops);
-	tmp_ops.func_hash->filter_hash = hash;
+	rcu_assign_pointer(tmp_ops.func_hash->filter_hash, hash);
 
 	err = register_ftrace_function_nolock(&tmp_ops);
 	if (err)
-- 
2.53.0

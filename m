Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959818;
	b=y1LKwrBjP+jOuuFqESuwjGSLy2ua4hdeBRevcTW8uJCOAqWK4fBHJ6XtBgN1p1HrUvHE
	 CFEqhRQBBvAilcDILFtOXvc6BjCykvNVPl3+D6hvutFiMSxJPYfhrE80Qp8lzNo1IznEx
	 mmTRUSIWaIFg0kGz7zfsgVAeCeOHT62X5aYd8vmvIWRSfRYCQcJu2jUW/EWxqRoiNBNQh
	 93eP2NMyRTPgf8WNEoahIHZWPpMJaPvEDZ2FOPmY1yni0f96XIUXM7rbMrnOlLVRjqLiE
	 +H+Jnd6XI/d4gR3zZEuOVmeTuQRbiXs1sgnQCmbvsQSE+gQHL01y49TTSNCj/n8FPrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959818;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=BO6rMpRO51+EmfR7Pq028wAz+MEmqHVgLskThE+WbsA=;
	b=eU5FMZSTXJTN40y+/4G86C5Ip1AHypZinLPIX0h2UM7aiM/pKY6AiGoKAQGcRFDJwcy6
	 fG0DmpVpK2MfZWIZFJuyFYElJneho3Omtk1K6+j8MCEF7lbSnFl1LI11b4tTtid06fVFn
	 UxcPLGjuyqiFv0nyn2j+XnjwJFKLcqV2L5U6lKtiXKtT7GFoUo3Hmb18ou+tTe9VbyiAV
	 h/Ulz1bJuaWI72QMjpwS5OPi1bqnwTtVkaATybpgPAzVWRHSeiru+vhZp6zGZ/Qdkjo+T
	 S757PYbS69888CEfz8dnYpHV3HYFBF6RYolLxLcyXarwU+9toC791uVo1RGjb8CL+tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=aFUgu0CI;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE0606A32A;
	Tue, 17 Nov 2026 23:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEBE0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=aFUgu0CI
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id DE449A81F2;
	Tue, 17 Nov 2026 23:56:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 8905817;
	Tue, 17 Nov 2026 23:56:47 +0000 (UTC)
Date: Tue, 17 Nov 2026 18:56:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
Message-ID: <20261117185645.628de864@gandalf.local.home>
In-Reply-To: <20261021174406.2891598-2-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
	<20261021174406.2891598-2-vineet.gupta@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ebhdtjq8bkxbp74cuzpt8cmkerspa9aq
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8905817
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX192K54KbB1eAfjdAUQhzeqxqYoG9GPiAkg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=BO6rMpRO51+EmfR7Pq028wAz+MEmqHVgLskThE+WbsA=; b=aFUgu0CIJQ8O5If31cC/ZhQJJ8i0ONW7MwaiF6rfM3wEOZooM1fzqoTQftjgx2kF4k7SUzBBKSVR52E/udV71n+PcQoXLsdWQ9X6IEXwT5KZDmulNB4ukaifEN5B6QpHeyHzwMgZz1pBMa3JFaf2aOmDhb8AcS8dWqU5+jsUf+A=
X-HE-Tag: 1794959807-230204
X-HE-Meta: U2FsdGVkX18ldEUQ80EyGDnP2dorXsVNfpKe2/+FA6c/0BQ5DsCLw4Xi4Y6HwE9QCrJxyW0oKpY4GrZLqvwgYZDEvvGSaJwzsOUCo/D+9b4Ia00MLTllhsg3vRZ+H11RgWes3m7AvwVJsq1Kx8YQt9iNdjQTukmKRSiJ2TJaZmErffuwx0VQaNY1hE9827YON+Yc4N4IgHkerPGK6mQTcnrG55kW2UAb52jfpITUjCOk/oSKM7nsoigyZ85RRIjhtMfM6tuvCbY59S2WzQn9pv/WLyRbm99CvAOt8f/OCmle+oxBSPA9drvajxn0VuGb

On Wed, 21 Oct 2026 10:44:05 -0700
Vineet Gupta <vineet.gupta@linux.dev> wrote:

> smp_store_release() is a drop-in replacement for the smp_wmb() and
> plain store it replaces.

This should be added with that, but I can just add it as a separate patch.

-- Steve

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index bbf6e4e2da2d..d32160a6b835 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -568,7 +568,11 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (unlikely(ftrace_graph_is_dead()))
 		return -EBUSY;
 
-	if (!current->ret_stack)
+	/*
+	 * We must make sure the ret_stack is tested before we read
+	 * anything else (See alloc_retstack_tasklist()).
+	 */
+	if (!smp_load_acquire(&current->ret_stack))
 		return -EBUSY;
 
 	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
@@ -576,12 +580,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	/* Set val to "reserved" with the delta to the new fgraph frame */
 	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
 
-	/*
-	 * We must make sure the ret_stack is tested before we read
-	 * anything else.
-	 */
-	smp_rmb();
-
 	/*
 	 * Check if there's room on the shadow stack to fit a fraph frame
 	 * and a bitmap word.

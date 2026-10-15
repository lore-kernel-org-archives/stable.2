Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916D4FD799;
	Thu, 15 Oct 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071244; cv=none; b=epBqcPibsVjIEqDs/hHV05XCnFEBAdf4uE29LUpA0TdVEqggmWZbM4xMnfHp3SNFtTMLDThmHYfIgYYlZhgPa+OCuRr0TOkKcu99Ik4Kp9whwPCkcks6xkVq9E5oKU4fgZITye6wPDirxiMbr1QSSQkhZYwTRzomLQTW+dnoQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071244; c=relaxed/simple;
	bh=ReGUwNffHDQKMMq6yy3hZ9oM86nwN9pWlJMvOZs7QyU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YK4sKoAKukbloJ5l0yCN6Ypv/YltrkZUWHbXhd859M219oJHO5I4CwAsETIxblFyHLsxSLOVjDqJPNJpistoZ/q4pHdC/ATXDnYtAqdjQX0yxzq2gCU8RVZ0Q5k6KF8EtDSq/Ecolf4/LB+gR1sQcIgXWoEk39R9ENZZcSnAt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOdILd9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOdILd9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B77F1F000C5;
	Thu, 15 Oct 2026 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071243;
	bh=M9jc1Eg/rtxy3byuIa4pGrGPsbC4tnFY0WPsgD2JV7k=;
	h=Date:From:To:Cc:Subject:References;
	b=oOdILd9k8+CokNq2FMJQsSEgJXR+RPn5Y2lVOul132oLuA2T+QTS14pm+oj8sttOO
	 Kp1FQzCpH/ZGe0E1lbj6s6qM6B8MCw8RVORo7ccgCI3V7SIMDZEvfsn2U81iG/DysS
	 RZYyoziOll32i0n1o+DDhTA837zRF53m3uR2qxHwzJ1nhPS9G63cbujxvbVSG6f6dd
	 a/KGjqjvhVfA9WGOSmlp8CTVx1vOys1S2IZr69dy/P2qbL6iyOl7OOPkyswsMJBPp7
	 ojmloQ//jbaYW/+IB+CUlUNHNNgap58a9Pxbp5aYHtzGrcVts1qhus9eIyY26ndfwa
	 5xSdMbODSfajw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLas-00000000MaV-23PA;
	Thu, 15 Oct 2026 09:34:02 -0400
Message-ID: <20261015133402.296560555@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-linus][PATCH 02/16] tracing: Take trace_types_lock when dropping the buffer_meta
 reference
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: David Carlier <devnexen@gmail.com>

tracing_buffer_meta_open() drops the trace_array reference with
__trace_array_put() when ring_buffer_meta_seq_init() fails, without
holding trace_types_lock. Use trace_array_put() like every other open
error path.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914133506.4865-2-devnexen@gmail.com
Fixes: 950032ffcee7 ("ring-buffer: Add output of ring buffer meta page")
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..8645298579c3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5881,7 +5881,7 @@ static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
 
 	ret = ring_buffer_meta_seq_init(filp, tr->array_buffer.buffer, cpu);
 	if (ret < 0)
-		__trace_array_put(tr);
+		trace_array_put(tr);
 	return ret;
 }
 
-- 
2.53.0

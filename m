Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80449501F45;
	Thu, 15 Oct 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071244; cv=none; b=UXs9pijwp/XpKJEld24FpFmjWRT7Q2cKEB0d/uWcyADhskAC41p0oymmBx756Ozia/O608LafM0XsGJcGLcnV5cqitgrUPgtw4p79Rtb64AcCY3PvYwwsPD8okD1gtD/nRx8Z2ULSZQYF9PbmndZ6+NPp5jsVQlo1IBfrDi7GLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071244; c=relaxed/simple;
	bh=jLD8Q8vLrM7j+RAudcNQFp0ehpuTw0DH4ujxsu39hbM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oS71AaeSZdC2dMlEzEINX/oJ95caUJeL89xQtKerXsGkVRrnRn5GPGb8dL7Y2rzDDhcBE5vYMUFO48YjoRGIIP41I3/2gvf0BnUYEAiGXKqBw27RFXy5VDmJcvnTq4fLi604kF0pw/vAKMw+DjSJwxgehEvPMllrt6/k8T3XqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjTgcBct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjTgcBct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C8F1F000C6;
	Thu, 15 Oct 2026 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071243;
	bh=c3urZcT2n2z0ASdXCwrMB8MFTndefwF+qlh8RJCW3ZI=;
	h=Date:From:To:Cc:Subject:References;
	b=YjTgcBctogsRK9B+HOKIkTZDMeObrsjrFyNMf80jmvWenp6MNt8dDOGTGiPNJH7DO
	 Sya15STw1bm17LPddMfp0aLBXY0R6ny/OWqHvRPpKcAULkDibEcbefh1b595VyYUih
	 C90jXbng/iEC1YW1vRoEqHwpIQRIpKDoeAOnsCHi0Vo1tNU3G7uM2f0MSMb727LKKv
	 If0GCcYg29Dgm+Uu8taRg8k4z+q0l5aj70X4el/dt30odOAh1l4gcDVPwtK9QjihAz
	 2nLEPPKbsdIV8+jm3LUL20vTAzq9UQydRkf2ogsy0oQge/83N89BF0N/lRi1oQjKB2
	 I/6rUowaSMnEQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLas-00000000Mb3-2x6g;
	Thu, 15 Oct 2026 09:34:02 -0400
Message-ID: <20261015133402.510689146@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:13 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>,
 David Carlier <devnexen@gmail.com>
Subject: [for-linus][PATCH 03/16] ring-buffer: Do not show buffer_meta for CPUs without a buffer
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: David Carlier <devnexen@gmail.com>

The per_cpu/cpuN/buffer_meta files are created for every possible CPU,
but buffer->buffers[cpu] is only allocated once that CPU comes online.
Reading the file of a CPU that never came online dereferences a NULL
cpu_buffer in rbm_start().

Fail the open with -ENODEV when the CPU has no buffer, as the other
per CPU ring buffer interfaces do.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914133506.4865-3-devnexen@gmail.com
Fixes: 950032ffcee7 ("ring-buffer: Add output of ring buffer meta page")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260913134906.6E8A01F000FF@smtp.kernel.org/
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..ce179619e655 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2380,6 +2380,9 @@ int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, in
 	struct seq_file *m;
 	int ret;
 
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -ENODEV;
+
 	ret = seq_open(file, &rb_meta_seq_ops);
 	if (ret)
 		return ret;
-- 
2.53.0

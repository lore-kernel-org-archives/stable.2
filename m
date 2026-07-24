Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC44749CE;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935111; cv=none; b=ZeBxNpnuVLGzumiaanDcatdini1IKhFxV6vMEW4/dd9/FB1PIaltaN5dCZ/d3H1JCNAu6oBbUuyi/+nvQ84wrlUFXhu6MGq96JypSLabSSN9Rr99imvN91CekwbrbIKLMszhMnNIAlH97i4X82n2AiiEXS1eMMCb035lDBbEWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935111; c=relaxed/simple;
	bh=hiZniiTI5V3U8iIvSaUz+PUtQvP0z5PC+u3kETLwZfQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BsnHhzxwuw7YuOAJHbYbMNWWK83SN+J8c+HzILHOtNJkNsKGUE1FF2leUcc+C9telEcocmpt5Zul3946cCa4qsTVzaOobMU5yXLFMz91g1+2B+22RP9sdsKzEwiZpBM5BaA4+poF/q/LVGqxHj1RyQocT/Qf4dw2wv2Ss95p+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZzD8+cG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZzD8+cG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F11F00A3D;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935110;
	bh=OEJYOBTIQEkX1Alk5aUjmgd0ffsn8eNnc8yZtywg2LA=;
	h=Date:From:To:Cc:Subject:References;
	b=AZzD8+cGIVVbR7otrsGxIcfkwncjfGa2C0Vue3G4HUZmnL9bgYwJzutPLe0DVorPd
	 sqbHL4bE3PCkwdhwSn7dB6C0Bknopil22racBIxNMgXL3fwzc91ltsHIAfNd8aPFSO
	 jNQ/JUgSL4TtIyQTzPnt66rPmRwJ0L0l015fr/u97qjD9wnjnBOkiSXF/6cwUW5IM3
	 TG2HzbPrd/mGAm5m3XiHfWaYn+c3AkqNVjSlOBtN4akaUC5ilEqvF8DMLmC2lm4DK8
	 xgFJNNBj0CZtHknr6KQMA/9IjzLQsRJi9RXWO42KxYC00Upq74ZChLL2YqQGIzE8Lv
	 8rzqeWDvlKa3g==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnPAO-000000046sU-0JMd;
	Fri, 24 Jul 2026 19:18:56 -0400
Message-ID: <20260724231855.925138691@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 24 Jul 2026 19:18:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 deepakraog <gaikwad.dcg@gmail.com>
Subject: [for-linus][PATCH 3/9] tracing: Fix resource leak on mmiotrace trace_pipe close
References: <20260724231840.483353969@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: deepakraog <gaikwad.dcg@gmail.com>

The mmiotrace tracer was added May 12th 2008. At that time, resources
created in pipe_open() could not be freed because there was not
pipe_close function pointer of the tracer. The pipe_close function pointer
was added in December 7th, 2009, but the mmiotrace tracer was not updated.

mmio_pipe_open() allocates a header_iter and takes a pci_dev reference
when trace_pipe is opened. mmio_close() frees them, but it was only
wired to the tracer's .close callback.

tracing_release_pipe() invokes .pipe_close, not .close, when the
trace_pipe file is released. As a result, closing trace_pipe with the
mmiotrace tracer active leaked the header_iter allocation and left a
stale pci_dev reference.

Set .pipe_close to mmio_close, matching how function_graph wires both
callbacks to the same handler.

Note, if the trace_pipe is read to completion, it will clean up the
resources, but if one were to run:

  # head -n 1 /sys/kernel/tracing/trace_pipe
 VERSION 20070824

Over and over again, it would trigger a massive leak.

Cc: stable@vger.kernel.org
Fixes: c521efd1700a8 ("tracing: Add pipe_close interface)
Link: https://patch.msgid.link/20260715143604.14481-1-gaikwad.dcg@gmail.com
Signed-off-by: deepakraog <gaikwad.dcg@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_mmiotrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 226cf66e0d68..20812e7f911f 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -109,7 +109,6 @@ static void mmio_pipe_open(struct trace_iterator *iter)
 	iter->private = hiter;
 }
 
-/* XXX: This is not called when the pipe is closed! */
 static void mmio_close(struct trace_iterator *iter)
 {
 	struct header_iter *hiter = iter->private;
@@ -279,6 +278,7 @@ static struct tracer mmio_tracer __read_mostly =
 	.start		= mmio_trace_start,
 	.pipe_open	= mmio_pipe_open,
 	.close		= mmio_close,
+	.pipe_close	= mmio_close,
 	.read		= mmio_read,
 	.print_line	= mmio_print_line,
 	.noboot		= true,
-- 
2.53.0



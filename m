Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF6481FC5;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843364; cv=none; b=nD2mGEt4p7l/vMf1+QkKBtw+vEVjZwxXtqiNw4+v7lD7Owif584bWZatHfqXlt/K3WFcSYaMyJWBE3FQW0Jv+EvVA2Yk5Pg+5A1Np5Y7ga2NEBX3ViUqdx1DwA3vJjtlWDOMqAUmjCbbpwj0Q2IxVGsSfLFkO9RhRBITfSr3ksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843364; c=relaxed/simple;
	bh=BWP0s543Qo/7CIy8BPbQxMzSMaAR4+do1+amOHhUcTI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Mvn9ctL7eW1zuJmnfIqDDI0ns5TxQdiNSC0tVt8+ugY71KzNFP8Y67CjR/LpHMpVz1TQXKv7Pw0LXzULMgPmj8oHj06dE1H8+PrgcE07CNfVR24+EpU/2zpndFkPWpiIBbdk50mFn1V2Z140229C1pTP5mIvp1XD1AEtWLnSv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAPcRF9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAPcRF9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED901F00A3A;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843363;
	bh=ldpf+J78qH9gTkGAWHy50kOb1dxxwTC58VOBRS95Rzw=;
	h=Date:From:To:Cc:Subject:References;
	b=KAPcRF9CvdEJbQ3cheyGhqJneO5AUj46nGzx/9X9gszjaRM5N9O1vStnEBpl8IeDV
	 OQKRDYHmXC0V4lzHwpzpVWJ9BUB8BnE6x8mJS2AodxjD/oMsElqSh9OQm7m8+RNt4F
	 F2VsxLdLvRc6uudh+o3wDGHcMyw0N8Hsa9w6s1jBpX+o98LfREBFlZIpRQ2Ka/Qmd7
	 MbCS+xmxBFkf4R+o14Afe+NKZ7RkIt7zrFgh5ZWc8GQVFEIBI1eZCM3KqsEvSan6gt
	 Cc2ZrgCHvnbCzamDWVmx3B/T2gIC2Z6i+Vvcd/9DG1V6UHJoBBF6uIAxv1vIrHcpUA
	 6IM6wqTScB+ow==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wzbk2-00000008PEY-3dX9;
	Thu, 27 Aug 2026 11:10:10 -0400
Message-ID: <20260827151010.719796681@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 27 Aug 2026 11:09:50 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Deepanshu Kartikey <kartikey406@gmail.com>,
 Haotian Zhang <vulab@iscas.ac.cn>,
 Hui Su <sh_def@163.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 1/7] tracing: Fix logged instance name on creation failure
References: <20260827150949.304280511@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

When boot instance creation fails, the kernel incorrectly logs "(null)"
as the instance name because strsep() consumes curr_str entirely during
parsing.

Print the properly parsed name variable instead. And while at it log
the error code.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260807085423.4175161-1-vdonnefort@google.com
Fixes: cb1f98c5e574 ("tracing: Add creation of instances at boot command line")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 89dc1c0ebb90..740c5f358b75 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9726,7 +9726,8 @@ __init static void enable_instances(void)
 
 		tr = trace_array_create_systems(name, NULL, addr, size);
 		if (IS_ERR(tr)) {
-			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
+			pr_warn("Tracing: Failed to create instance buffer '%s' (%ld)\n", name,
+				PTR_ERR(tr));
 			continue;
 		}
 
-- 
2.53.0



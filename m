Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49893F5BD9;
	Tue,  7 Jul 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431981; cv=none; b=obUtlKnjn0v5Zx0CmbgR0HxeoH9nMuZZb9OM9zZwepYIu0mvffdJZDwoQf/7v4TEmP3LjLnSJDXL1NYFY0Q1Tl2jMA3774XwZbnT5uo4fJ39Mg+DnAm/lLjHVIQdh5hZGI4cqCa0KhcTFq5YeKtjeU/5Nt3Y7v8rHZZSRSy0o1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431981; c=relaxed/simple;
	bh=n4V1rpg5qgR5wxE4ngAQqDukPMurhhkQ7linxXM409Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Zruq9pp62fio/XbgsLBLZgZSXgKpC7xxDOhxeJOy0rytrcUz6uoi+vBCVFcQP7NbI8FCc3PeUGw7RgXdPQuGZBuPTwys8vE3xcuce4wRKXKZw2TquaiLNCi0nrc/NNBqipoNY6TNZK3zQCD3qlNMF7ZOs+gXBlyRw6JFpSgWVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go9yYE2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go9yYE2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680FD1F00ACA;
	Tue,  7 Jul 2026 13:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431980;
	bh=UcvyJXf5sN+q6Zk271pSdqPHJlaxLnJNBCDOccXHyTg=;
	h=Date:From:To:Cc:Subject:References;
	b=go9yYE2z3Ic4D0IXgSgYDlBMqsUppSGhK++W1ybZVqILic03k38JCxp/26skgTtWA
	 uVdpeHQdDTIQrFB6nAV7DWpjfQmh1b6m37EHIm6BT1/q2IA8QrkHr2+D7yHesQSPsf
	 x0faM1F+VsK90gAeK9zlqjn8k0pnZlRG+zUqhdwyaFhv3zO7Ac+diNnZYykdA3yffY
	 VZdamKelSVN6pe54oWv7arXVjtj5yPdpSK4l6m4iPlkimgwJd6Cp0gvwr/FV1Ya0FA
	 donNxJufm0EkgXK/Uwb8uPq0DKDkDEf2vNtzkkRgo7Gfins3c8Q3MzG5Pych3z5DXw
	 nv8XHBIHSrz5w==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wh67z-00000000h26-2xqo;
	Tue, 07 Jul 2026 09:46:23 -0400
Message-ID: <20260707134623.554037981@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 07 Jul 2026 09:46:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Crystal Wood <crwood@redhat.com>
Subject: [for-linus][PATCH 03/13] tracing/osnoise: Call synchronize_rcu() when unregistering
References: <20260707134604.275787924@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Crystal Wood <crwood@redhat.com>

This ensures that any RCU readers traversing the instance list
have finished, before releasing the reference on the tracer that
the instance points to.

Cc: stable@vger.kernel.org
Fixes: a6ed2aee54644 ("tracing: Switch to kvfree_rcu() API")
Link: https://patch.msgid.link/20260609045430.1589786-1-crwood@redhat.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 5e83c4f6f2b4..0e1265acd1cc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -179,7 +179,9 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu_mightsleep(inst);
+	/* Do a full sync to ensure that tr remains valid, not just inst */
+	synchronize_rcu();
+	kvfree(inst);
 }
 
 /*
-- 
2.53.0



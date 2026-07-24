Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4E4749FC;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935111; cv=none; b=SacgQbVAuxXvnse224KfQG7gjNitSblhk030lsAbkZYHmkJcWBGvWLqLhLQawBulHafSiF7p/SHoxGG7Tca882L/KY96/yHsc6toRC+3s2okaLCHxn2G5FjosBnanL/6GYyYgExU7ZOAtBfKNw7CPD4IuXGWPvEa2qENiMK2UIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935111; c=relaxed/simple;
	bh=5vXE0PhSNG6DD41aTyCfzaKSlB/mB2jHbx/Ufjc5BNY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rIhDm5CW97qGva+futo1ePbVac2x/o6FUWiRN+N4J483DjmiE4jJa8kVYYHbrSocWlB0vrahaN/O6uADH7qMu+33kHpjiYKN7bdSI+BUpOW8NmpNHk7LC6YGOpJ6PWP0l/A+T6iKxK+1B91Y2sm7zcQL2m5GctsAEqCvXO8wO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVdIC0BA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVdIC0BA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588801F00A3E;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935110;
	bh=FhZ/5Pv9AeXrXf4KLh5hTBTtjmg9+0RNyc9HRq1oARg=;
	h=Date:From:To:Cc:Subject:References;
	b=EVdIC0BATVMJcZMc0OsA7IS2T6mvDAmoDitSiWrcgPOGpyM+rLXbJTc415z/K4FFU
	 sdMGe7vWldFAY8OeXV6VJJtxcNauUK/PIdT766FKchcnD94I+vjRbG1oFwS/0xx0FS
	 ZgkLZ5SB+6/Om9gSD7wSIQBCisNaeUnA4DLEShwNqidx4Z82t6EIBvBTeoQQ/AwN5x
	 w6Ak1mBvnXCquoh55FpXlBNjgE2ggOaGOlxSdUrCDnM3DQjlFR5o0K7Vo0xJGSIih+
	 x9g+zq3r5gb7KW2vJb3HGFrBuYo5Nu9hkWoRq/D8h5+yWwXw6LPHPx7h5TBfMMlZg8
	 ZF0nlToBj82bw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnPAO-000000046sy-0yEk;
	Fri, 24 Jul 2026 19:18:56 -0400
Message-ID: <20260724231856.091344694@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 24 Jul 2026 19:18:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: [for-linus][PATCH 4/9] tracing: Fix mmiotrace possible NULL dereferencing of hiter->dev
References: <20260724231840.483353969@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If the mmio_pipe_open() fails to find a PCI device, the hiter->dev
will be assigned to NULL. The mmiotrace read() function dereferences the
hiter->dev if hiter exists.

Change the test of the read to not only check hiter being NULL, but also
the hiter->dev before dereferencing it.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260721211143.36dbd559@gandalf.local.home
Fixes: f984b51e0779 ("ftrace: add mmiotrace plugin")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260715143604.14481-1-gaikwad.dcg%40gmail.com
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_mmiotrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 20812e7f911f..b88b8d9923ad 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -145,7 +145,7 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
 		goto print_out;
 	}
 
-	if (!hiter)
+	if (!hiter || !hiter->dev)
 		return 0;
 
 	mmio_print_pcidev(s, hiter->dev);
-- 
2.53.0



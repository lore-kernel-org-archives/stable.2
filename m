Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6594756C9;
	Fri, 24 Jul 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935112; cv=none; b=iD4LtPw1qSloUqyvj7wq7RrEgwaFmClY/RQU4UZbJ1pzvrWAPkE5xyvKt2vlVMzmvOXrfH3aq4Ea1CCYhq2ymnVFT7hsW1agsqAEa5G+r3Np6FxWsxmc3PuZWtoA2iDRzYUE5XQNHV8eCAW2BSjYkt69xXbFa0uURucn9au7cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935112; c=relaxed/simple;
	bh=NmptBfjJ5/i16Abhx8EVMEBRg//W5xU3cpfWiq649iI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=t9YRpuytlqH2SlmxBJCq0KGUbcyuobCAgm+xVPwOcGCJsb394pByMGq9pSmMYtQE8ISGkDX6304t5+D/cl7JK+xggm/aTIprjxNMQxWasCfOtqpnYaF1Oy+MnmeKn0MfClY4pgIVtOzwtsinNW1lrgU2LLm2RzJ3HMGkQgiftwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV6puP4C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV6puP4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D0C1F00ACF;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935110;
	bh=cyB4fSlwRh7NlIQlttoqX2onDg019zsiXwHC97/VDfc=;
	h=Date:From:To:Cc:Subject:References;
	b=KV6puP4CbQLNEHJI8+H9unHOm7nQKiJH1oDRhNDk7sI8smF+C5jBYcaANxYXUJuyh
	 nOH2Xz1eSscKik+KoM2+lzbzDIsIkGLC6hw7x2yJRG1cbTwv0vfni1dJXiVfaodNxZ
	 k8gD8OmLpGghJ9VKQFwaln+RCo/jeFxb55tFEoxMfZ59ULvV4weUinhAMLIMJKjvO4
	 f1a32LgVnZkxbBjxFJS3z7SGQYlyIjQ0Bk6ry6elFmDG5MGTRxRGvzs+o+NGFXNFRv
	 JKhs/8fno0EfiMYxUmDblxhsZqXrlKPFIMnsMONk4eYm40ODvFHmYKxAa712HPL8DE
	 TuVoMe8Wjy3aA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnPAO-000000046tw-2JVF;
	Fri, 24 Jul 2026 19:18:56 -0400
Message-ID: <20260724231856.417111063@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 24 Jul 2026 19:18:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 6/9] selftests/ftrace: Reset triggers at top level before instance loop
References: <20260724231840.483353969@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

When running instance tests, 'ftracetest' creates a new ftrace instance
and runs the tests inside it. Before starting each test, it executes
'initialize_system()' to reset the ftrace state to initial-state.

However, since 'initialize_system()' is executed in the context of the
instance directory, it only cleans up triggers and filters of that
instance.
Any triggers or dynamic events left behind in the top-level instance by
previous failed top-level tests, are left completely untouched. These
top-level leftovers can cause subsequent instance-based tests to fail
or even crash the kernel.

Fix this by executing 'initialize_system()' in the top-level tracing
directory once before entering the instance loop.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/178425671889.84440.9477850701738666404.stgit@devnote2
Fixes: b5b77be812de ("selftests: ftrace: Allow some tests to be run in a tracing instance")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/ftracetest | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 0a56bf209f6c..8ad2c385407e 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -503,6 +503,7 @@ for t in $TEST_CASES; do
 done
 
 # Test on instance loop
+(cd $TRACING_DIR; initialize_system)
 INSTANCE=" (instance) "
 for t in $TEST_CASES; do
   test_on_instance $t || continue
-- 
2.53.0



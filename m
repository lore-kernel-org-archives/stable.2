Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545437;
	b=yvr7j2+8kmrTY7/PpbnhonEzeWYU1K9Qs2u+w9Fj9qqlJwP4Bu0YnZcjU/EwB5Cuv7Gq
	 qysiSJR77hZ1eBIr3V36jKmaJDKWfZ0iQm3oZfPll15uTLPCEOyZk7/Yb3r55/ApnK44Z
	 YgZGZ7iygYwH9oqkmqlDXGNGtyQmgSiyAFudOsrocIdmzpUHhU6o0DL2jQiPDYgi/ezGd
	 vBkQ7SGW6M3cA/qkv5gSP06ickYZMoslCK4/jfhnFG1P+dDhFlIi4zdaAn7TouC6+z17L
	 lZAl4buFfoal87ZJ6HeCC50tth77T9agO8Y1+S+6M/OlXHf7zBySg7hg3UM0gF9D8yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k2IlC6GjWldtRhqSIRBrMSiabjvS1fTm5+fT2QABfEY=;
	b=IeNl6HaK+W5YcxTgjfcdjG6jPFAcvkIMW41/8CX0LqmNLmDo9/E4Cv8BbZwLLBQJOaGg
	 SPQSKUL0Pl4OhIsYZQSRL0qqtmeM0cs/V3UeRmJmnrRh1Pcav+CZ015JMU2KiAcskCbKF
	 aGRoQWBq6Y6O/vj92FhOGOQBmxXPOI42meCm2orncc3ojItQ6iW5LNOxZ6fhDygvfuFi5
	 HRPyVX214fS35k+VOJIiWw34hXhQWL7hI2rsVjYTohhcGqGnDmWOBSEho9R1T3WanCKLb
	 TUz5a9gN9ULlWuFk/A7nKxcd1A4Zo8dP6JxNcPegd7HAE6rBT/zpKPoIQ0/oSbWiPOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omXV8YJN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98C606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omXV8YJN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6291F000C4;
	Tue, 24 Nov 2026 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545437;
	bh=k2IlC6GjWldtRhqSIRBrMSiabjvS1fTm5+fT2QABfEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omXV8YJNRdrU7C6n9ZInJJDtM1Pgl7uJ9gPhAIwNw3zaNB4numw9BgjYG1mBsKRre
	 LGfJUYsE7KVMnxMmFfazClNNjhwQD6i4N+m4Kers+XvX4FK+GfCET1mc1Fsv4kjgAU
	 2gJicGe+SP9oJDqSeA5PPFat3VcFUa/H2Q4Sw5HmX4Neuo2HlHKUPjqwcyJ9ZfHYJx
	 xmEj30SY8wo8YmxGeZPaxrGpOpu/taLGZct6dhDUMtRj1HoGVX4K6Z9pVPB2599GxU
	 ZsUpfsDFahgxrPuFmYEGd8c7L0wLOjLXl0a5wVhtQF8kWkTlBA2+JMpKwWovL8jHXv
	 Nq36saDroMdJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Jeff Layton <jlayton@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] errseq: eliminate special limitation for macro MAX_ERRNO
Date: Tue, 24 Nov 2026 13:37:13 -0500
Message-ID: <20261124183544.2213071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112441-ducking-trophy-90cc@gregkh>
References: <2026112441-ducking-trophy-90cc@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 3eff6a3e574c2f704f9be1f4867c3d0b3d804435 ]

Current errseq implementation depends on a very special precondition that
macro MAX_ERRNO must be (2^n - 1).

Eliminate the limitation by

- redefining macro ERRSEQ_SHIFT
- defining a new macro ERRNO_MASK instead of MAX_ERRNO for errno mask.

There is no plan to change the value of MAX_ERRNO, but this makes the
implementation more generic and eliminates the BUILD_BUG_ON().

Link: https://lkml.kernel.org/r/20250407-improve_errseq-v1-1-7b27cbeb8298@quicinc.com
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 94defd41d80f ("errseq: don't let errseq_check_and_advance() hide later errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/errseq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/errseq.c b/lib/errseq.c
index 93e9b94358dc6..13a2581c5a878 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -34,11 +34,14 @@
  */
 
 /* The low bits are designated for error code (max of MAX_ERRNO) */
-#define ERRSEQ_SHIFT		ilog2(MAX_ERRNO + 1)
+#define ERRSEQ_SHIFT		(ilog2(MAX_ERRNO) + 1)
 
 /* This bit is used as a flag to indicate whether the value has been seen */
 #define ERRSEQ_SEEN		(1 << ERRSEQ_SHIFT)
 
+/* Leverage macro ERRSEQ_SEEN to define errno mask macro here */
+#define ERRNO_MASK		(ERRSEQ_SEEN - 1)
+
 /* The lowest bit of the counter */
 #define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
 
@@ -60,8 +63,6 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 {
 	errseq_t cur, old;
 
-	/* MAX_ERRNO must be able to serve as a mask */
-	BUILD_BUG_ON_NOT_POWER_OF_2(MAX_ERRNO + 1);
 
 	/*
 	 * Ensure the error code actually fits where we want it to go. If it
@@ -79,7 +80,7 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 		errseq_t new;
 
 		/* Clear out error bits and set new error */
-		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
+		new = (old & ~(ERRNO_MASK | ERRSEQ_SEEN)) | -err;
 
 		/* Only increment if someone has looked at it */
 		if (old & ERRSEQ_SEEN)
@@ -148,7 +149,7 @@ int errseq_check(errseq_t *eseq, errseq_t since)
 
 	if (likely(cur == since))
 		return 0;
-	return -(cur & MAX_ERRNO);
+	return -(cur & ERRNO_MASK);
 }
 EXPORT_SYMBOL(errseq_check);
 
@@ -200,7 +201,7 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
 		if (new != old)
 			cmpxchg(eseq, old, new);
 		*since = new;
-		err = -(new & MAX_ERRNO);
+		err = -(new & ERRNO_MASK);
 	}
 	return err;
 }
-- 
2.53.0


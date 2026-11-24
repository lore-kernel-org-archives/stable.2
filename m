Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549636;
	b=u9BS5dObbH7aveo5S5qELv1wmcgWrEpw6C/FYvz16xynk/XWgFjiKSnAYdGT7Z87rxBW
	 WvT8p8+NSbG8P/IvipI8gaEuzP1U4SbcTrXqQ4ShNrtyZpCUd2H0CnUv7HF9A0Mr/AaLk
	 piZ2E/N46FiEDfrjVlaJtm4gSR/Y2oF2mRXFyTrM+As/X7fouaZvDVtjNXQVRQmFgCp0X
	 6P2vPxHzfoqNv9MnclJgZHbt5k10U1+2kZhM/i3UyCcOkGUUf7b6eJUZT0AFjKtEJWeoi
	 K10DrEuV5yTzH92auQ1GR0OYXS2Bg0Du6k765j4kAcJ4wWAKB8BSBCwNBHT8oPqJ0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549636;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k2IlC6GjWldtRhqSIRBrMSiabjvS1fTm5+fT2QABfEY=;
	b=ff77NsxaFFe6qIMo8KVT55ByavoluE3F2a0iipRUG7kcNpF5YWpl9zemcla+6kOkt+G8
	 s16srQEt8Aeng0ZyrZ0n501HGKZeKt2uMIDxwuiPmFlaQMD5Vta1XErhnHHuWl+P5AXpS
	 kqmY3zdz6EmLK64qNSDsx5/pozelAoDXnvYYZXuHDr1SFpdqWbGGjvrJbTeF1C2LssdNt
	 hiTcty+Cnv3twNB1kupdL6rCLr8aqlfqmk7IIspGo0i21ZhbgKEhgD3RB+BgKKS4OycWd
	 v2BwZRgHWqf58bvdZqp0wnvn3aGE2RflnBqu6lXvH8CzxclCwnBuxZWbDf+NBg7uO6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4G375Mh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5A606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4G375Mh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860C01F000F0;
	Tue, 24 Nov 2026 19:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795549636;
	bh=k2IlC6GjWldtRhqSIRBrMSiabjvS1fTm5+fT2QABfEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4G375Mh/wshg8OZUpTimAghyOqHrDpmuvq4FATRi0TpnvIZ6UR9NQLTRpEvNVeWW
	 Ak2ElI/IkI0A0fjUFmJgh7V2Hhhh+ViaFnKGgy6u3gAoN5B8hhsTqseoOB3zp/gx0l
	 IY4u50V9f5xIBgax97K95TXtXC6tCNkLNYM5N2OZSTo2vETUUvusUuO6aExXXFEmfv
	 /UG9EgwB/Bd6unGs0+C954k1dTqwG4NdgxTDBoRHMV5eNxkpdg0WYgmSPyXhdjDF83
	 vUXoptS/+WJqz8Y86rF57f0Vpe4/elz406OIDGF5GYKtqLu/2iJq7StARc9uaMPq50
	 d8029CIUFArvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Jeff Layton <jlayton@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] errseq: eliminate special limitation for macro MAX_ERRNO
Date: Tue, 24 Nov 2026 14:47:11 -0500
Message-ID: <20261124194647.2515886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112443-guileless-cradle-1a11@gregkh>
References: <2026112443-guileless-cradle-1a11@gregkh>
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


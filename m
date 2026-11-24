Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550555;
	b=oHdgdjKjJn/C/YsWZft4F4Oglnv7W/RX1ViH1/olCsCRaaeu7PjdR9b2/6GWyMkqesEa
	 uR2UcFKdz72fTipNVEePWlGnWcJE90PxaPT6JOvK58TelS446XaBI8h+UFOV6uCCgJ9yj
	 nQZ4N0finYejnh0kavr3lAiaguKNBMFoASSBqHAj8/uomcyovi/PJZuXH6CGBA+AnWAgo
	 fRvZXc5TSWwsAiVTwdKvi+cvH25lx6hkwprCKw42wA1Eoa1zLBoqCyr+dKCqBJq+Cx++7
	 oN39D5/89fNHnQYMTu5vJB8wqPyvEjihVuwVVtEJN3d0/DVfq3dXrbuWnjb88VRLRIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xa9ioU99jRs8QMmJqf8VPfD3uXpqKUyjdPJ22Op7B94=;
	b=3RwSO0OLUP2L4rwyNduOml3U1N1lIvhfyqbBL4ZIsfIbloVZ/ZdriSkh0FlgV+rj6++E
	 KIZW+Yr5bycyev9sh3EAL/C5uzt7fclD4IlmXcM0NI1g/tCDCJ9LevSJTITFXxNn5s/Uk
	 1BDyq1nGsQa7AeGqNKQldnKFLy4D+jsileOjHnDad4871iwrSKzRIalJ/L04GCjh1Z+Wz
	 TNJMsH2kBzcetd0QBE/XPcO4B8WePtKDsCV7jwIIkzAwDZljfgmFSsb/CdY8nmOcNxCvs
	 3NjmG0PL6f9St03hC5XngmcIx5OCKcaWhzCP6k0Gd2XQSDuJPSMCD14v2n/c/WTAODQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjdUJT5R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1421606A32C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjdUJT5R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA7E1F000EE;
	Tue, 24 Nov 2026 20:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550555;
	bh=Xa9ioU99jRs8QMmJqf8VPfD3uXpqKUyjdPJ22Op7B94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YjdUJT5R7T6JjCWYaFQcLsEUkfhEZWeaneDevNpKZoWWht+yjGRhcwLHxeQL3PfTy
	 6wPGQzCmTL3kAFNuQYCNTOW7kMiRoCKw7LgUs6ku1b8iZ3JEU2h2Yh5jeeqRrmj9fh
	 9i0ds63bwVzdbQz4r/ZYOwPaRrv++yWjIuFd77zNtdQ4PebXGlg6594lEvPmWilClI
	 fKQ8GqLok1KBgF5gJLrCQ99HK9lwpyHQoXBkvHzpPRlet3fWBkwLR/+LjcEmo8Z1ht
	 E00g1zCeKBK/XfS7fBx9YoOIBZf4+B/Nr3oIcs9K3rXBXCvwfAaDJDtEle3S2FwWNl
	 UsTq0oNKoCnag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Jeff Layton <jlayton@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] errseq: eliminate special limitation for macro MAX_ERRNO
Date: Tue, 24 Nov 2026 15:02:28 -0500
Message-ID: <20261124200034.2551100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112444-preschool-blaming-08e8@gregkh>
References: <2026112444-preschool-blaming-08e8@gregkh>
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
index 81f9e33aa7e72..63aeaadd71c38 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -33,11 +33,14 @@
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
 
@@ -59,8 +62,6 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 {
 	errseq_t cur, old;
 
-	/* MAX_ERRNO must be able to serve as a mask */
-	BUILD_BUG_ON_NOT_POWER_OF_2(MAX_ERRNO + 1);
 
 	/*
 	 * Ensure the error code actually fits where we want it to go. If it
@@ -78,7 +79,7 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 		errseq_t new;
 
 		/* Clear out error bits and set new error */
-		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
+		new = (old & ~(ERRNO_MASK | ERRSEQ_SEEN)) | -err;
 
 		/* Only increment if someone has looked at it */
 		if (old & ERRSEQ_SEEN)
@@ -147,7 +148,7 @@ int errseq_check(errseq_t *eseq, errseq_t since)
 
 	if (likely(cur == since))
 		return 0;
-	return -(cur & MAX_ERRNO);
+	return -(cur & ERRNO_MASK);
 }
 EXPORT_SYMBOL(errseq_check);
 
@@ -199,7 +200,7 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
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


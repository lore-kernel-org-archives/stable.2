Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147415;
	b=aBF1Zu375fV2rUItZcBo/FOO/w2XQIOmZXQY9zZGdFHuc8YRFzp5XyXh6rNQ/gxBv69v
	 0sxETt2w1jw8JulNFt4tbYI0OtmtUV7jp1HOf1+6etPNr1JnLsfBRsHZIvTadRbTOSGf8
	 gmEKUZBacEvI2KCMD7nPWD4IVFtGf55aaV0U0/HzJcGlrGx7/oqqnSVLmZUJlpk9XFbO/
	 JWEhaAcNI5OjYaHHZ7/4CPAzroFhaU+73fSuSXjxJDN3fZLQZas/WkdkxatOX2R0NwZF+
	 rQwdHIczKeNkJERN0sn9war1M+88cVSNzyInCUumBOczLuhjo3KxgTVRvNbQsoy5XOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
	b=RuJW64Q7KNbD4H6kIBWgqQLhHXH0r+heO2am/VWVptUDplfc1GVq07Z2oTzA/GLCYy6j
	 VthON/AIwvObffn9qwsU/hTk6xVY0exFuyGDOeV0W5QFbtOcmQR9HGJeCNNUU9d2thkHQ
	 Ij3bbmmL2bEbFYrDMIAGwCakE2YWfbcQuzS0d+kw4PxMzG/v1nQVfjPqbOOQx/T/GXXua
	 3ko7PbXzA4XcFZ8lcbaB82ZjHe2H5Y78dl4zqNjlNE3cMwssCJHSk1Yy3/0scUPDGzQWh
	 jS0n5WRsN91KPSznjAW4L8EGpzJc/Ju72lMzRSLOMqkjk6r3goVbAeY2vXOS4p9ZJag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0QMy9xVi;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D7606A330
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562D7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0QMy9xVi
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385d8a00598so230621eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 20:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147414; x=1795752214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
        b=0QMy9xVihzdqUeuC2tXf4jH6W6ojo/2tnNh0uAc4vUeSpaPgFdS6xiOpbsBHSlt0mg
         Yay4agX0tWmBpJH+LDsY8JPSD3DdwfTDKyi47L6e6U/yJffhpv4hAtU1c0u5CH+WRZhJ
         nCmYSSWnii/9995khh1tO+9eCQyaA09F61WuVQrg0f+FnK3b9RAYu+Si0dw9ezgBkHQ0
         sKxszHEFuTvPRF8GIUT3R2TsXRtvmFnGp5ZDfKTCEcu0dJ1mPQAUqzuTyL5/G9wwh05n
         2tjyPqAVrahlL2iMxNED5I4y1Jh0O9nO6Kpf0+yFnvD4+jXPXaXc0XQUbNd1ugq4GLJM
         4bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147414; x=1795752214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
        b=Xsudty8RyhCB0kGjrl8XbOatuycJWlKrmQBopznUYxZm2K31c9srigRE88IggdVpjw
         VkmQ5Yd61rRKaVrudmIkEFEmOZZioXYNkDe0kdDNH0PS1LmrNo2XW2qCUQLABtPLs6jG
         P2NtaZBSImqzF7Y6VYA3RKBkyZxK+Gcz/aL20QOlH1nt0o9zXAS+dBptBSxK1C08P3sM
         ehXOEyZoPhJaRbppdDUXtpV/tOCYsBZC/EOngJ3kqUptUwcf8BiKrmFvGuEHjMFmHzPV
         QnHXcdvp/U1POigEcni/fzMqtWl/vB1CBYv7EkstV0Lii0jJDx9Jv7r7eiHvgUKN6j3J
         0nHg==
X-Forwarded-Encrypted: i=1; AL+hErF0OXD4xGAeiuBIWBbXwDacA2fhLV8QCItfsCTYPnCghCZqslSq+a0LCSRfqwR/lvx7ixoixI4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HTStgYfub3wdiHUCLMd0980L45IwWog1uayJHhsf2uKI1Z0sh
	7IO4z06BaxXkcXClcRWO8mq/O7Puc+wCcCxiW362COa/6rLNWXfc15ey
X-Gm-Gg: AZFdTZfgH5uqpi2Hn1aaslMmvg9lrbt6NNcFxhTAuEcOEXiUJeW3mpNs2NWbKWXis4l
	YSqYqbS5pyEIYR/SwxXpoi+V5DcCODaf4nMGF/bMG7J0vDEm0uCU3MF0+E2r8GI0HZALZzA58r2
	bokKduTBcAE0fDqgHhphBZT9vrvQ5jsENMYhpxwjYHvS9HNQkU5tozYdI3mzOcniY6Op6LtO0sW
	0+Djft5RiwZAB+FOK0kwVfjU9z+txWEYBmZE7pFe1wm2GGD9PjqBtW059fWSgrZeyg2S1Ce2ybB
	h1bpVhJOemQueD4ngEMIYd7xwn/urMKlSMybzfrlPHsfW3jNTiBYbnGLZqY7wBFQ6M6TDu3eOog
	4GRL7LfuS22hwpg06Y9/CmVOqRkVBqQgg0KQXxASgEF5KkbejfZTTrBlHP5gCeFFuodQGGugNWY
	QOFV2+WeyNg5S/dfG15KPAsjikGidMN4ugynV36XbZ6Yq25716iSHPWkbX8LtkremTZUEW6gyLO
	ZTMvd48cQzKirNVnBOUxN4HfTiKufYiRmSp7zui1H/2sRS1q2qiD4Mmj+cUKyTi37vHg4/v9V2M
	YNDEmZ0WFTKBKj67MCZL8JvI8BSHONxr6w==
X-Received: by 2002:a05:7300:10e:b0:385:4fef:bb1e with SMTP id 5a478bee46e88-38570c361e8mr1625006eec.36.1795147414494;
        Thu, 19 Nov 2026 20:03:34 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:33 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv3 01/19] powerpc/mm/book3s64: unlock RCU before returning from mm_iommu_is_devmem()
Date: Fri, 20 Nov 2026 09:33:00 +0530
Message-Id: <c6cce4c4ad2b177cacfb7bfbb7bfd4a26fcd4612.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  iommu_api.c:380:1: error: __ctx_lock_RCU 'RCU' is not held on every path through here [-Werror,-Wthread-safety-analysis]

mm_iommu_is_devmem() takes the RCU read lock to walk the preregistered
device-memory list. On a match it returned true from inside the loop and
skipped rcu_read_unlock(). Hence fix it.

Fixes: b5952f8125ae ("powerpc/mm/book3s64/iommu: fix some RCU-list locks")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/iommu_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index 60d00c9e7f19..56d9aa6cc8e2 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -356,6 +356,7 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 {
 	struct mm_iommu_table_group_mem_t *mem;
 	unsigned long end;
+	bool ret = false;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
@@ -371,12 +372,13 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 			 * and the caller needs to distinguish this situation.
 			 */
 			*size = min(1UL << pageshift, end - hpa);
-			return true;
+			ret = true;
+			break;
 		}
 	}
 	rcu_read_unlock();
 
-	return false;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_is_devmem);
 
-- 
2.39.5


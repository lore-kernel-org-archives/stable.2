Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059571;
	b=be4QfdD/pguBDNi4Ub2cY9klmAaqyMuijQ6dnASqG7/zYH9WmgNHE+AGTl/WIz1r0FNS
	 sL0bklY0FPTsRUv9fZ4fo7uhbESGjQ1ULoD1vlx6VpIgvE/AGdeKca5LMdZ/r2h0PQg8/
	 UEoBON9IYZxNNxoVDXj1ut2S4Ttuy+uAI0QXO6Ls8TrwAjeMbVFsBYXSa4jRwmlNuq4Fw
	 GHd7bkuYRLYNJLS4KvgVFctymKCvOK8AX9xXkrLPVrTyNT5LNV+t49zH9gwx1aYYQeyTH
	 t3S9qE9QYL2tATp9RHLLqazRcaAVafK9Sp0Q846Lzt2nMWQHgpds6x9XnXfmYF1yzXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
	b=IycDjvlgDfdFbO6VSkMkwcD56+3NCu0vansqxUBX+ISx88g9y9xpTjHDX4v0qCkcpS8k
	 N13IJS+OJlTYS4u+tojDf1sBO4ERKw1iSkpZmyaC1s+v4ag9fmIccZXNIgFB3HjwQWiDZ
	 n9I0CkMEFAr46+01U3EIQUwZYmAKTjTxL3ULfs/WbXMBz+3zdS+RSGVp0u7cnLCEcKup6
	 3Wz4qnyUxe6wJVufzaxp1qcYL5+GBB8RU3m/WeNSvUxOdoUB3c60G8g2Q4vlDVlqJpGTz
	 /iawR4T9TkMn6/GQ8feTMRjW43Ve63CuprKc7rH6bIaZCa468Ccpy9J1pP52oVPC3KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cg4k+wH;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84903606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84903606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cg4k+wH
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-38431138772so483444eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059571; x=1795664371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
        b=0cg4k+wHnhNI3DTougAkFQgC3l2AHI8lRB0sPyv/gIjDnLnsorxKxP6Fvudat3iu/B
         gG3qKrXOCJWhv0AADhTB0Cld/9nvaXrphUKD4XqFU6P7dtDJnRd/d8E7wnun7Dg9Dx1V
         i5ZmgWCLef0d59vj/H02k4TCtMAUuwmja7i3UbKgQFetEDExGvKuTLFktZYBOnem04O2
         B0BDbZcbR58APvNQs7+m/delZuXjmqcU7ftNFLX4h/XRePo/9ho59uOEd2KKuwCyqU5E
         t90325AMVhhnmP53X61sfd6/RaRdvfuqObyKZG2ghX67nA7JJMyije38xrtpXohim7ut
         fZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059571; x=1795664371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
        b=osRWVHDDEM1kyzB6moHENBYKaZwE4V2pNdN79U0zInrIHABFzgs+P3jq89azBmnZEE
         hVrh09DOOBm5lUYgF6h8r5umUDvx8ia1d3eR+6I2ocAVvIJ2RVgJpeTZEgIoiOh2ET58
         rCw6tNVWGmatqa80KcgqWiOeiUaPLay9AhizkFcbQQUbP0B9Qc/z+1Iq7BgMxOoQv/gI
         jR8I68CHJshLU4PuJmp4UgbToQWLWA5h4J8sklZcWvix2xkzaFJl2Nf57vsSVW/mPdZK
         cuK3b+gNtCtdyy64BrKC4eAx++q3xFWKZddREq3UpUqv/S8QfMEuWRvTy+X8KNaSdVHW
         p7AQ==
X-Forwarded-Encrypted: i=1; AL+hErHtZv/ngytpb5ywNiubCrUCLPqTMy66hkQkf1g8sDBgP7sX0rhQS8FbgWpS7dckDLGBWSfPpIk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GgEc+tFgnoxscEwm0vv1yX/33QQuIpqr5mtI2AhKFWuLXtLqc
	GYVyGZrsH3iUkyQeChKurcRubNCcG2kBN/1qh5wyUrVPwcjyWa2wo21W
X-Gm-Gg: AYBFou2V/Qusn2MssMKf2dtbNxpLhxPIxxiylzO5eLTzYawlEjkxUYF1n5a47jQGs5p
	97wNDwOgSYIBZfRh05/lZ4dYwUI2z++3IT38Kr6KsEvpVLXZrNQ50oLqFxVcVeQLSYdfupwLuWt
	MATkBXSRbL5lHuD3GxjCDtybVFEvpvYtYsA5z2v2okSwP72t5Mh/QMRBECYrakFpxtjxwJN5iJp
	lPPW61Y8O8umF2xm7mY8Axjzapjur5AEi/ZtSaZzYEo0MPNd572ah7dTfkCsgu369UPYVmlneYq
	Poy/PwkOzifClvQJ7n93C0Y4BgbTE/P+MUw/2Cdc6rXJcQlX6Jf4XsKzx1Cabe7maUkc0mH2GCO
	5NarOt/cRqWTcYD5XUI34dbLd+y4T3Ca6sxGvj+6wTBkkj2uXaykMHB/8EJlUEdvF1JAP5jgtkk
	ksaXv/0GxlbFVUuZPZIe8E9BAaUixwXWVTkOeI/1lntp1OTGTSi0haHqjbCglbsB+q/9ww6NAfC
	ubWkDC2GPdjjbLliBF4YcUfn2ZJVEGx4cm6ka+eCJxRDf35icQ4UQlbP6bn+NQbZwcoxYDW861c
	Yt0g3oQAtitkqUai09687DQTPpPc3PSDOd1U9Yo5F9pQukZ+xvmBUBA=
X-Received: by 2002:a05:7300:f408:b0:369:f035:661 with SMTP id 5a478bee46e88-38280a3c1f8mr4556846eec.15.1795059570467;
        Wed, 18 Nov 2026 19:39:30 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:29 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 01/18] powerpc/mm/book3s64: unlock RCU before returning from mm_iommu_is_devmem()
Date: Thu, 19 Nov 2026 09:08:56 +0530
Message-Id: <c6cce4c4ad2b177cacfb7bfbb7bfd4a26fcd4612.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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


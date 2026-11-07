Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046798;
	b=Khn6insUbYqwd2K8APVxXpKQPuRasX62qsWl5rE7NF1JlZpSIqApvG9vhdxpiCWS+mjY
	 xxHdJBP66zyYlHa/B8wdBjsPE4LApINhtjDyhR6J+SpEpfIosS+fSUcVMFeUWVtrImv3H
	 fqr+9JszhWkXu3zErfxdbWcLl625qQSebC1pk/fWEQqFP9buMQKXyAt/aoh8Vko/nAjZh
	 S8c+rkluN43el+E19H/msDimHP7DF9HOYKbFGqAFBkC/qJIttfX6CSkiFN11rr8/1CjGT
	 V22TEiv43W8W19ET7YTGfwkilOWHxpEvnYsPm/BP4bVTboh4+J3PZ2i1uySuGrhqGUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XtMka+3aocDxWvBsrSANl7AdU2rr4DcfHX6XGP5XSKw=;
	b=07KwWfA1KsbqlvHOYL9ohsi0kHMv2ikfIA/GPJ1dUOzIn1mi/Q1+QBmbTArjpEKAVmpi
	 wi4hgpjvfXqeyEA4LBGL81CbHdh5mXjZu6fqHMiuTPQSn8Vsw3IzHvtnBMgX6aVz+R3MF
	 DxwDlQdmeKP43mHK8sKUHIyzrwUSaYoE+VEHCX+cSTRT6GhHtcTJ2pY9hehmUKneAU0M/
	 9Xxcx+Ju2GmqD4Dh20kPeJz8aRzoc92cuX1qCIsVP7SeAT8CLzsV++26FkDA9Cz5mO1Xj
	 iyBkyWhw9EzgwX+mKSHxl+/yiu3ygAz8G4xvB5DAjmIQVlCZz6NiQdXEpKY0k8I7C9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kayNcXVy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585D606D81E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kayNcXVy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109851F0089F;
	Sat,  7 Nov 2026 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046797;
	bh=XtMka+3aocDxWvBsrSANl7AdU2rr4DcfHX6XGP5XSKw=;
	h=From:To:Cc:Subject:Date;
	b=kayNcXVy804iczP8C4MDJQNTsDbfTxcXJRl2sHv/Lt45VPC/YY1p1IWWVia3nDLUa
	 n8AV8NrPRI+txZz+D3W/cWryRgN/Y4+8dbKuAmwtLjdCuqHzeRG3idjBRMtNvZ7BVj
	 8Pa7U7iSN5WlWDqQ3rKMvbRJgjsF6o6MaWkhCIFj8L0azETzZvE/OlC/6FUF2r3xcr
	 Cr1RAzCeHtdvOwMMGgOg0VQQKRYTS9e4vrf3w8a/wr707bwlZUv3zqj4S/bjdSzTr7
	 2r2KSwp9JZtdUcNp+P6BjtgbaOPaCpqOZvO6+iBGDPDXjo4SqlAxckRS4VpO+EQg9Y
	 mb82c1jSgsbOQ==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX-512 code" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:55 -0500
Message-ID: <20261107051955-failed-6.12-b82cf9e49c1b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051955-failed-6.12-b82cf9e49c1b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 31 Aug 2026 14:23:16 -0700
Subject: [PATCH] raid6: add missing vzeroupper to AVX-512 code

Since the AVX-512 optimized RAID6 code uses ZMM registers, execute
vzeroupper before returning from it.  This is needed to avoid degrading
the performance of any later SSE code that may happen to be executed.

Link: https://lore.kernel.org/20260831212316.213896-1-ebiggers@kernel.org
Fixes: e0a491c12968 ("lib/raid6: Add AVX512 optimized gen_syndrome functions")
Fixes: 13c520b2993c ("lib/raid6: Add AVX512 optimized recovery functions")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
---
 lib/raid/raid6/x86/avx512.c       | 6 ++++++
 lib/raid/raid6/x86/recov_avx512.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid/raid6/x86/avx512.c b/lib/raid/raid6/x86/avx512.c
index e671eb5bde63e..772bfc4af6dfd 100644
--- a/lib/raid/raid6/x86/avx512.c
+++ b/lib/raid/raid6/x86/avx512.c
@@ -78,6 +78,7 @@ static void raid6_avx5121_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -137,6 +138,7 @@ static void raid6_avx5121_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -208,6 +210,7 @@ static void raid6_avx5122_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -292,6 +295,7 @@ static void raid6_avx5122_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -396,6 +400,7 @@ static void raid6_avx5124_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -529,6 +534,7 @@ static void raid6_avx5124_xor_syndrome(int disks, int start, int stop,
 			       "m" (q[d+128]), "m" (q[d+192]));
 	}
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 const struct raid6_calls raid6_avx512x4 = {
diff --git a/lib/raid/raid6/x86/recov_avx512.c b/lib/raid/raid6/x86/recov_avx512.c
index ec72d5a30c01e..299a3f044d616 100644
--- a/lib/raid/raid6/x86/recov_avx512.c
+++ b/lib/raid/raid6/x86/recov_avx512.c
@@ -211,6 +211,7 @@ static void raid6_2data_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -353,6 +354,7 @@ static void raid6_datap_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
-- 
2.53.0





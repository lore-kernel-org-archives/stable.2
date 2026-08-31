Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5B39D6DA;
	Mon, 31 Aug 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211402; cv=none; b=LMQAYxwzzV0f6rUaEu36aUWxEPFxq+g5RJJL7880D9BERXuQlFIM9X4YcxVxJ+G48aiPUoNqkIZRZ3k94spCDs45ZxXS1lBZII6rvHRfiSOnnuhoMqJ4b39iymdqrz2ntprpRhbP7K8Z+hZeBoUOZb421axgddzAqpvcn3wbw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211402; c=relaxed/simple;
	bh=5QoDyQ6X4p1Atd3lG85mmroUjyxaVW/u+lq80I0PCyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6YhNrKjJ7DjsrTieeNtpP/doPdopjePPF/WuTmE6Ztaw74/1sE6vJf4OtPtnC+gs3gIQgL8gjy4RueBy6+tLgo5iQiL/fzare+Bd3M0A8Ph7i/SqIuwKCCsi8kkembBCnhRWofWDvN/1SSnUIckIn4kxymBuvf0o84IHoppmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7LbKsGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7LbKsGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF46D1F000E9;
	Mon, 31 Aug 2026 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211401;
	bh=uLdv8VH0cmD7l6Ogu0tEuQONezqf9xm4zh/RAWSkMGw=;
	h=From:To:Cc:Subject:Date;
	b=D7LbKsGj20BbRy6TuN8/LoWJvUHj6zDmoMY39cKj1SCt2Zgh1qq++RCPZ2lsvJ9Hf
	 fouHdwhq7ByQQj3Ay5Fg2uUAJLETLxig+nRbptMVj92qLJleY3oT+lcheb5cc+NqR6
	 JZvxISZJDiBtmUKl1nobFkEJaZpPIAF7WpwCIWt8Oega1YUMIZCWU8TjyUbuOtaUUo
	 q3CPKwcuHS2TyagHfKcXoeeeuzkCA/iisOTP0Z32zFv31cvJhlPDrlyzje+fAQDQJB
	 jHbNB3MzdzisWen9ORPoN0fMd6gcIy0dP0xyWSmNrADB+qfbzll+dC/36aeBzvSQSK
	 /P7I2pntonf/A==
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-raid@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] raid6: add missing vzeroupper to AVX-512 code
Date: Mon, 31 Aug 2026 14:23:16 -0700
Message-ID: <20260831212316.213896-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the AVX-512 optimized RAID6 code uses ZMM registers, execute
vzeroupper before returning from it.  This is needed to avoid degrading
the performance of any later SSE code that may happen to be executed.

Fixes: e0a491c12968 ("lib/raid6: Add AVX512 optimized gen_syndrome functions")
Fixes: 13c520b2993c ("lib/raid6: Add AVX512 optimized recovery functions")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This didn't get taken through the x86 tree.  Andrew, it seems you're
taking patches to lib/raid/.  Can you apply this one?

 lib/raid/raid6/x86/avx512.c       | 6 ++++++
 lib/raid/raid6/x86/recov_avx512.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid/raid6/x86/avx512.c b/lib/raid/raid6/x86/avx512.c
index e671eb5bde63..772bfc4af6df 100644
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
index ec72d5a30c01..299a3f044d61 100644
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
 

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
prerequisite-patch-id: ebf41d9b9e92708245f6ae0657896ff3f8ef7d0d
prerequisite-patch-id: f85f9c7e8bdd6fcfd394edb80f2263d7189e138d
-- 
2.55.0


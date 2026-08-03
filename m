Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C193FF88D
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756342; cv=none; b=Nw/dg4EaN5aanbqdcDodH+IEQu1XnqC1cPx0E6jhGYhERUwVl0mScsUvzr86gzz0Q7C/IwMJNZX5HjZ0lZxYhETIh/avWn/46vQNj4JbURS13C//Gp8lwkJBDoZw+oGSKFZ0C54+2VS9Rj5joa7GNQ21VeqxrtjIRLWzkeMXtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756342; c=relaxed/simple;
	bh=Sv49XeCz+zvRsKncftIKHLkr4SWJDrNLElmC9AiNb6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMtKDGlVemfzSn0UbhixV6Aum0+saiLAhZHWhMsV2GUmlW/aoU6ClJgvRfMegp4cUotArzK1I9S5rHDvqgxb1lQ+L4T/nIIosyoUyOzoDnGuTQ8IfR9u3kEtSa7SdXhjoDAE+vZ6mMSzCOP6waFIL9k5Xsz219mTx5wtQeNRvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYBNDD59; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYBNDD59"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc97653887so34250575ad.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756340; x=1786361140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dm8iv1zOENNE2/4OPaqxGyIJkWC3+aS57l3uyF+i70=;
        b=UYBNDD59RB0/ZMKLGrbAoa8X927gIhnznrGMDSJQvehxOexQQrm43S55D4doc/HQDx
         7ZFAFDQ9iK9q5FAPvjIO+IGO3JuiUHs89+PH350XdcAiHlSB3Q1waWDK5iMuD4PrTbKc
         rLHXZ9v4SRjYB+c8ENTTCYKerLznLzUkd3GTdGFaH4aANxicirjDfWjlM7NpFBS+bJvQ
         5KtbqoV4dNfB3VGj2N3OtgFC1yVqRSTox9vxl1quHfRgKgFeS0oU4ZDjkCuBZ+2rBUS5
         rL7mwegTifc5DegPpSsDAqXXVH7R1E4rZaErwwTaD2JpH/ETcuyJeaYyf1QOxvS9GzBB
         wySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756340; x=1786361140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8dm8iv1zOENNE2/4OPaqxGyIJkWC3+aS57l3uyF+i70=;
        b=k0+cE4FlAkpJOyPloY+0j0Q0V9jQVTWu9694Dv4UnZ0tg18boWrpTgaGoHV7QL9d40
         hHE8qOXXEyO5F3ajhgf1y/Yv2io+o4RAD31Fb66qUB86WOyKVa3JZi/t4GYU1t84Uvdt
         mwyvb27H5E4FeGOUxI0i88OjPOzyAgSK8w/MsByRm8Asjv9ell6WxkmKd/XTGS4TqAhJ
         IBQ+Mre/p/5Xp5eVgLmK03L187UfZaTOpqyN27YjIYaL6WoemZWUCFL7GZ3Y/hjr2drs
         ue+LN463DfMV0Ozm01gvnM9AU/cXRx5qFmhOpELMdUldoco4wJI982imcHEKI3Pv4hZX
         T78Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp3zgqV+HPLXiOECSo/WhkeJuC4jwGf+MEzb0oMlswGr1ChdfnTcLOtgLxQPAQ06FvHhzDj9Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwM23XpuUdw6uSXAG+K+ykeYZw4MkbUKTENEf5g+ztG1ivrAaS
	qEGmMeRkZSzOurhnh9lFugAMRm5Z+YB39L8viwcnVUp30xxcrAvYKNDY
X-Gm-Gg: AR+sD12Q5Dw4E1RdposNjDqOiXUwnTVSXK1bmZ1+nu1ACRJYkvxOkeCWBVPjmcDfq56
	lEJmtghsTEjCN/Vilz0Q4AZVYoNz34TRqT7xaEP8RNTMP/oK/ulXPCc40WlmYFCJGb8wBKs/Yjl
	kgEFmPpzeWhFdpCSrnQLiuZQ8LSJJmGzMLfEewVrcC3+G6xsCM18OktajJa9XXjDtOLMVthpNWK
	tFbGyUkhAFDNZrSj1QqDZlcI/bzKvUI6Fx0Exk+7DmPdcBO3W68j1+vSIm/6uwUji2Z2lHKXiL4
	S55jUZYs1HCoIHIaPSyluhaWUUjW6zb2cA/RCdY3P20+Ob0GsxtcEuY+RTnUyaSgxwzZtNrNTcM
	kKWYZHR9lVgcMjKffG6rnVV/89caFy0x9iPydIXSVymzTOOG6BSCXioDPiq6zQZ9mRzFlHdJOZZ
	t2PkNgM3GLyr99ELsmk7MFHOnUEo4fL2klo9wivY52L9uI65EN9cza0fKsAS7OAozjBKRjQkjdp
	GiGUFEqCO9fGy5A
X-Received: by 2002:a17:903:2f0e:b0:2cc:fe03:dc75 with SMTP id d9443c01a7336-2d05246fd98mr93329845ad.27.1785756340137;
        Mon, 03 Aug 2026 04:25:40 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a91asm36190685ad.21.2026.08.03.04.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:25:39 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	Ning Ding <dingning04@gmail.com>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 3/4] bpf: Reject untrusted allocated-object pointers
Date: Mon,  3 Aug 2026 04:22:10 -0700
Message-ID: <20260803112218.3361213-4-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803112218.3361213-1-dingning04@gmail.com>
References: <20260803112218.3361213-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

type_is_ptr_alloc_obj() currently treats PTR_UNTRUSTED pointers as valid
allocated objects. This allows a pointer that is no longer protected by
RCU to be passed to bpf_refcount_acquire(). If the object was freed and
its address reused, the verifier may acquire a reference through stale
memory.

Make type_is_ptr_alloc_obj() reject PTR_UNTRUSTED. Add
type_is_untrusted_ptr_alloc_obj() for the read path, where these pointers
are still allowed for BPF_PROBE_MEM reads. This keeps checks strict
without breaking safe reads.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 include/linux/bpf_verifier.h | 11 ++++++++++-
 kernel/bpf/verifier.c        |  8 +++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 39a851e690ec4..7014d62fe3d1c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1307,7 +1307,16 @@ static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 
 static inline bool type_is_ptr_alloc_obj(u32 type)
 {
-	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ALLOC;
+	return base_type(type) == PTR_TO_BTF_ID &&
+	       type_flag(type) & MEM_ALLOC &&
+	       !(type_flag(type) & PTR_UNTRUSTED);
+}
+
+static inline bool type_is_untrusted_ptr_alloc_obj(u32 type)
+{
+	return base_type(type) == PTR_TO_BTF_ID &&
+	       type_flag(type) & MEM_ALLOC &&
+	       type_flag(type) & PTR_UNTRUSTED;
 }
 
 static inline bool type_is_non_owning_ref(u32 type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c47328be2505e..8b35c63780798 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5809,7 +5809,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			return -EACCES;
 		}
 
-		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
+		/*
+		 * Skip this referenced-ID sanity check for untrusted allocated objects;
+		 * the access check above already rejects writes through them.
+		 */
+		if (type_is_alloc(reg->type) &&
+		    !type_is_untrusted_ptr_alloc_obj(reg->type) &&
+		    !type_is_non_owning_ref(reg->type) &&
 		    !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
 			verifier_bug(env, "allocated object must have a referenced id");
 			return -EFAULT;
-- 
2.43.0


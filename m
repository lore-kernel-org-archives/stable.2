Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DC3BED23
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807526; cv=none; b=rWDP0hJVF25YbU/ekfGlXiLZ/XMP7g/DqZT/Z+KDBYfchi+FvLAr5DnYJhsQ1cVLFRQrU81RxaM6f+YJ168lutY344rIoovnVA7444uRp0gRz54D9SsF+R/W26yEJ0b8gw2LFw3fKK9Q49ybmjbaFV/M/rhW4O6/6zchY/GcnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807526; c=relaxed/simple;
	bh=UOrrPjy9U6hTumnq35vaYDk2G8KIx536Lrz1Qem3k10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFNngSwiltRKsaw3d9Th9wCyNpuJUW7h8j0c05mMzJdC85fXewQg4NatV/jnCslioHoXcuXWtHCHB/gv71kUqKIl5e8VFlv1wl6OWE8biEB1JrouItA97N0l7ntEUG1/EcEV6ycL2diVwc96uywrZbqNldkdhajLDzL/xR/BiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/3er83I; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/3er83I"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso1405567a91.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807524; x=1790412324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVgf5x7BtLeIcBzEQmUKmsyxl9448TEEFnXHBSKRvUE=;
        b=V/3er83IjiJH53o3VXI38vv5HBzHOh8Fy4FODzq7BPGAD4jml3jaIZEYnkEu68gL4s
         qO9Mtl0NnGRKGPJrm7QWryKITQX+Q/EaQD7YbG1EEminCua7lMA/XEqrcQX/ku05UYHv
         vpjX6egqGoAB05IqKFWhSp6GO75XNsjYnv0uISR8cQqCdM45uINntID/NKjnXZSAkRQN
         rDFtwZRz63ZJnPcIRTG3mKcuzjhSnIalMYZZxericoZdlzQj5ZnnQunUCzgro1pGMdDu
         Jv4kgZFWKLxiqs6TlXUT5GeblFkBkFIXd5ntPi02Er6MxpPSDavPYNAXevL15V1Wu8KZ
         Fsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807524; x=1790412324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVgf5x7BtLeIcBzEQmUKmsyxl9448TEEFnXHBSKRvUE=;
        b=LnrNlIXWjFBw/PfAY2mXk2e/o3llqjP+AkIj3dbIxlBKEXJZGLTg6sXZwUbKpzHPM/
         GJhjAmQuO7pzH1ATvDeyOctJxFFDLrItjXSCiYdLfN/u5XZ5XOzNsdDaCOh5cy0CSd42
         DCPAf07qVxpJzDAzzpNpFhcIpmLd1v7EicOUuU7ScaLo3jIHrx88YAHVEUYzo192VOpE
         uks1hcwHLKmqAKEW7AOMfmPYzrZjXlBQLshNg3zcQXUoJlYgvswpv2nhixiHtdy9CJql
         nC4wKjeQJYvIYQ8OpNalX+LMPDLRkzeKhgkfwT3VchZJ/nqyE8npiphxn7MkQ6X1ItVo
         cP6g==
X-Forwarded-Encrypted: i=1; AKwUvBzBprDhFrxXYLy3gfYyhcx/d49F/vnXM+3yQrXsDFow9OPIHWiYA7UC3C0ESPv8s1NdGZqUme4=@vger.kernel.org
X-Gm-Message-State: AFuF++mgXRVNGopzBCClNf69O8yPu0A1woLGLF9EASRAwV15ylSf5h8K
	a1ctO9D7ZEFwePjZVNwpkRv3Ft+Em7x+iM2SLHk1Uzx9rXo+GLsTpIGQ
X-Gm-Gg: AYBFou3bqRtNh2z3JZ6sJdXdMzIGZuTu8jpyJvnX71ylRlxf9cf9gnpFP/gr8UeMgNr
	DFsL+Ee8QWXmPrdYoJPtOpRvr9tjpUHjDBBqzS0m7n32MRdEwrG9bbVu1j7/b2Egq5zvBLmjr/G
	atgPyScKdwl/rKoLDUUyI+CmOb3XKUSGDp0c1qatn7otAF4+kVXDYpWnaMstbCk4yaPYGTf+7nm
	f5YvwDDbbUS1AuqKPat/4Jw4cRwfsuHFNoRKhB8BZsZNDyN/avXw6bkq1NGkWNF3rUQQZ53L+I4
	H2OoUz6x3isgcSURSXg0+f4XmfZFNyDJQXM9goMsPBJ/Ll4NkRwdx1Ib7miAYjUIixIXbiKPK3J
	HuG5ALWdZBA/8QjF/VU2NcMQHfOVYor95cRb1Fsjoqz4QWGmtu8kkAAJQ8ai12GqaqbRkiJ+sek
	23aJ2FJiz3vPRE2vlAl2x/GUvfoVAbq6UFpeygeIGTkapvulr0vDwmQrDG1USP0KaGcXy0E91+F
	qcdDeWCz4kJVkt56Z/aiCMQN1x80WQf8Z6ycD58fqyLh/iVLbHaA87wJGzkG5LOV5gbxJbANpoe
	h0otkA==
X-Received: by 2002:a17:90b:5346:b0:39e:6c69:7779 with SMTP id 98e67ed59e1d1-39e6c697a4fmr4246853a91.34.1789807524517;
        Sat, 19 Sep 2026 01:45:24 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca4ef3esm3556837a91.1.2026.09.19.01.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:45:23 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH bpf 1/1] bpf: crypto: check params size before reading reserved fields
Date: Sat, 19 Sep 2026 16:45:02 +0800
Message-ID: <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789802413.git.xuyuqiabc@gmail.com>
References: <cover.1789802413.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_crypto_ctx_create() is a kfunc whose second argument is declared
with the __sz annotation, so the verifier only guarantees that
params__sz bytes of params are valid.  The function nevertheless reads
params->reserved[0] and params->reserved[1] (offsets 14 and 15) before
comparing params__sz against the size of struct bpf_crypto_params, so a
BPF program can pass a shorter buffer and have the kernel read past the
region that was validated for it.

Move the size check in front of the reserved field reads.

Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 kernel/bpf/crypto.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 51f89cecefb4..3f3fe2450fc6 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -149,8 +149,9 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
 	const struct bpf_crypto_type *type;
 	struct bpf_crypto_ctx *ctx;
 
-	if (!params || params->reserved[0] || params->reserved[1] ||
-	    params__sz != sizeof(struct bpf_crypto_params)) {
+	if (!params ||
+	    params__sz != sizeof(struct bpf_crypto_params) ||
+	    params->reserved[0] || params->reserved[1]) {
 		*err = -EINVAL;
 		return NULL;
 	}
-- 
2.55.0


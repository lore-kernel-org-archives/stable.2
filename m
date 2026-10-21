Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605011;
	b=XOUW7CFf8pfqzRIqfLo1/HQF6mQt8sLRumh+DlGnSe/dx1vVf7TuL9yCXXVs7ZiHhV70
	 cmyROTm0fyuc+hUQmDL1eVMYN5puxVtZe67k23R2/VLVj7X1CtMyt8DNCaP4NV6F+o8D3
	 phaTOAW423sWzMWU6H9ePNbQKsXOFT+oiw+agY+DDiedpWRu4S8lArN1+RHuHxUOxtAU6
	 t4pRvzzfDFsktDJ1dYy6v8B4swi79O0jJI+MLStchnIJJ5p3yxLfmYVDsoCJLleNVTtz6
	 6at1PeBeEhJ6rEWsXGWtRLejrUdOXPzT4a9CSnvjfziNOUUfpeUpjAzsqhN32y2Dzzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NCiFUlem6qW8F+mY1MeWMFDksPatkBHvYOmj1bKILX0=;
	b=JzGopViL+q7l95msfLz577UPfjtbi/dnqIqF1MIk4LnYHKiVzKI4PeZrAZ1QNXGeVSZ7
	 aOpduSr7tcq2sB+wuhfYBK/ada0WC5yAAmDGdEhzKVTQbyyHlb/l727RFzoEpz+sVa/5g
	 1CQVx39aqar20VDwNaQvHI56CB0l1/IWusK4kZv+dWmWhAoOZE5lVkR5MOCZyC+S1GA4L
	 HuJOD6CFIMQCxEabqZTF4xUJ4eQgLT/0g9j+P8W3ubsxOx1CLXf9mXtwVB6l8dst5+TJ6
	 Ga4z/31wlovEXP1ka9abKTT/OYwQ9dlgaRcxU7DOt1hs++S0Lu2PJZ5sQznpnvo3+GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=JknpP7YJ;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BAF606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5BAF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=JknpP7YJ
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-16079d54c17so1860763c88.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792605010; x=1793209810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCiFUlem6qW8F+mY1MeWMFDksPatkBHvYOmj1bKILX0=;
        b=JknpP7YJuHqK4K8JU+lEEevXFO0Z8hDPpOJEfVQ2tG7d2WjPMCUFv5PHYoIQSxw8WE
         nG8/1T3sApIfPTKf6r5g1HqBks6vEK2p6thndOk0qY7sL1QECx3lhjqY3NwIQPs/+q2Z
         rpwkpQFg6hXD/4u8LXJMUtXipenNIKBFmas3T1ToHPQ/HmS6XrqA0Jh4nmTX81FOR4gx
         s4Syr3pjelkDiFT4JaghhJ2UJEBDGM3y3l9EvUQWmDF64TZB8aa0jarD9CqxI/lFeHVa
         qoIE8Y2wsFXK4qdq8EloCuDg9Y6dSfKSWhpNK0q3l0zvjcGKOKJSitUaoyuPO3G2IlUj
         GQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605010; x=1793209810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCiFUlem6qW8F+mY1MeWMFDksPatkBHvYOmj1bKILX0=;
        b=nrxyigX+XNcquPOoxW4qilNRgD8r9dhFm42WNnBIl9r6kDklER8rQWYygU4FuJ5pQu
         oFzSRrSrmt0rRtU1TIB33mh03w8whLUuVS8V0G0sxssB8o/yo5x1CW7LUoO8sGier0YE
         IKOcSxwdwqy8EC0mVri8Ol9E6u5jfNBAEjUoWNRMeaPU16lD4fTDhsbEPbLo1BvS6nfY
         W0LCNVLRwWRAcscw5kH5yWkQWwQU3NRpYxtq4YRqqSWVmC93U5i7aco6u2yvM3VqFJe/
         tzfGg/YEOSphHZpB98NSfQYuDEXhp6sndMaSYlgUP5VDUgpFqg6uN1QOOhS1PJ9lvSaQ
         XTrw==
X-Gm-Message-State: AFq9FYJPPN7oRUfU97c56uNCwiLTGQCHVTR+QHGSYGwb9+RqzwNezcx9
	LMm/4r3s/PrDvdfoS/Ae3zzt7QDQF0wYF0twB51iu/6OxwNdy1mEx0Li5HptqNlam63BoBbCGXn
	CD0o/3H760Q==
X-Gm-Gg: AYBFou0RibncdpkFdkIapKmiNNYUIx4LbQ1YtqqIm4awZzSLhbB76VvGkfjgmouDYuJ
	oBkjn13JRYelkq4wLd7lHiqqA9e2EsNeyPx+PqWQyqnG9+KWeqtDrSTvUrXnKEKk7S7Yu9uiG3f
	IKUBIytzcj5UYaNs8hctSHm/q1GCoeU5QL9VTd7H/MCFiXlLpYNH/9Wo0gLqP+YohP2Cuw3J/Cz
	iH7clMaOB+BDpYDubjpjMndvA5YwHS7tJhXxvosagGZcV85autRuTzAs03hNiK3W+CWb+nq5p4A
	w31TTUBFugxdO19VF3CP1pZ+dQ1caaGYqaD5OjlWtyi2uJD7O4nQO2cWLKgkgTZnwiE7MAXkHu/
	LIwukjDvW0k9Mi8229zbgjeTMeqwppNL7hb068eKj4iQqLhVbIRivqONSv0douLcRVr70pBv9eb
	aSKJnbDd8yCubLj+SP/C/aU8PHPaRibmdZLmOb0stBtLZ6jH0YXRc0qeUWJigUwA89XwHCDsHQ0
	Eiwr6vMQq1oH+EItQXGMEdijU3EzHaClkPpXKZ/8k3klqHGeD0OXwtZ8G/JohvIDUp2X0vJs89y
	Z0zi/c+P5QANJE5cp6VM0zzyk54HvhNvuU3xbQdKxqdCgdN1CWzG
X-Received: by 2002:a05:701b:204a:20b0:164:8e14:4939 with SMTP id a92af1059eb24-190a4f0471fmr3741902c88.10.1792605009716;
        Wed, 21 Oct 2026 10:50:09 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903ca044d4sm8226137c88.17.2026.10.21.10.50.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:50:09 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bp@alien8.de,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dave.hansen@linux.intel.com,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	hpa@zytor.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	mingo@redhat.com,
	song@kernel.org,
	tglx@kernel.org,
	x86@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf, x86: Fix trampoline stack size for 128-bit arguments
Date: Wed, 21 Oct 2026 13:50:04 -0400
Message-ID: <20261021175004.1276-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
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

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 814cba835ef648e0c5eb79505c96c0493b29eea6 ]

btf_distill_func_proto() accepts a function argument up to 16 bytes, so a
128-bit scalar such as __int128 reaches the x86 trampoline with
arg_size == 16. But the current implementation assumes an __int128
argument only needs one register, so the register save area is
under-allocated and save_args() overwrites adjacent stack slots.

Compute the register count from arg_size for all arguments to fix it.

Fixes: a9c5ad31fbdc ("bpf: x86: Support in-register struct arguments in trampoline programs")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/bpf/20260729050204.2586457-1-yonghong.song@linux.dev
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Assisted-by: LLM
[ Backport to 6.6.y: Remove the struct-only guard from the existing
  unbraced argument loop; count eight-byte slots for every argument. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-90358 to 6.6.y.

The backport removes the struct-only guard from the existing unbraced
argument loop. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 arch/x86/net/bpf_jit_comp.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8028a5a4ab64570022c15bfdf220c4033ad0d4ab..3d33aafa2cc26541e64b37960ce20a06ce5fd2d8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2467,10 +2467,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	u8 *prog;
 	bool save_ret;
 
-	/* extra registers for struct arguments */
 	for (i = 0; i < m->nr_args; i++)
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
+		nr_regs += (m->arg_size[i] + 7) / 8 - 1;
 
 	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
 	 * are passed through regs, the remains are through stack.

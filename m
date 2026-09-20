Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639F3E00A6
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889103; cv=none; b=kIemO+45S8zzbFDECbxgSw56CGRelXjzCHauZDtNihedjnz2aniBGkARluEK/9gI96tVhLQwcfJ2JF7JGFXQA8NtfsI8t4QQut9Pq8AdhfcL+z1rpCoV16s0wkb7Jww69bu0unYP6Ul0kLFXFrQzkqvIC68PsaIfQP9C/xND7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889103; c=relaxed/simple;
	bh=ObADTlzoiTA6U2yvY2GshZzVd6tdDp6Ev6J9pWdWFpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oisx/wPf4Hd7Hq1YvZP+Wi4BE/U8sCwOTrYmnmxwMr/st/5AIRkcmWrkoIoRdUJDoXwcQktuANgBXJluynGSxcRcSeCgh34V0zCct/4z2vDYrXfOvXWqXCQgD+lJQ0HOrHjir6nvt32qhH+mKejFKXiHSdtjF3mI+KplNSZ+seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeJz9tJD; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeJz9tJD"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8631d0023daso1435296b3a.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889099; x=1790493899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gOTpVBg6yPuc/XTyIpDgsbvA7J2tB8bOdXuJs8CMv5I=;
        b=aeJz9tJDlgGqXDpwmg17rdebHsEgNeKwq56CrolZAU66C5Povl95IUNMoKEyA7kcaA
         DokxkG3N9QWO7QfzxbhDlAVPu4JMlTnXNXRpYtgA8x8EaMUjTXqus6Dgat+JL+Fevk3c
         rac9kaJ5SpDDLlfgXR0QzTcKGpc576/2chR+3skHz+/kDrMse/BaPVV5iVZnLPCFu1/c
         ReV1IxLvAEOkmov53j6O3QDKUtI69JFNMZFVD2qOdRQjp4UWDZbMo+h2vjQuAfRd++6v
         8OPXItDNSibKLfMMmre0nKQhJ5BkMbKYKNOFs3x+AR05r2jz410qscYXJI88YsbdhGuw
         mmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889099; x=1790493899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gOTpVBg6yPuc/XTyIpDgsbvA7J2tB8bOdXuJs8CMv5I=;
        b=DfSPRc7j3hicRxfIna3Y4E0lpq1MW91FhCh0RYIddT3M6Ne+DKPnLgX5gGwJvOFplL
         +Z22pI8wX8qGE8yAhnzYsW3RgbFNK7GbMbnBQpgbEBNF9vyzT7POt2HH45xiSUejPw/t
         sVd02VNJNqDyAc0pIW1yxAAnoUC6xrsh/0b++6EE7zKjU7DAXkj2BNHPLIGgBM80TYux
         Aplv4VghNinnRY9w+bwTELZpYTeDKu/hFZTuniWrSm6bsCjQSxB644zLQ7ElkIPt/ZHt
         p8Ryb0GiMLCkC5HAQ1c9FXbjbqnoYh3p1PYHBrh+Cew8Rn3dt5r7kSOsPvawbZd9REvK
         FgtA==
X-Forwarded-Encrypted: i=1; AKwUvByIuwBRgJLr347Pl3RlwLsm+A5jU16oGU/tynohXFwewvEXL32a5pHbQ9IPzQJ/optQeM69S7E=@vger.kernel.org
X-Gm-Message-State: AFuF++kBxLfJ96PWoPc36NbcmG+FMRoVeZ8Ga4cTd3yJ5f914YujlacC
	57wHZ9xF/nD2h00QXXTyDvKbSWaCDuQbSsWQOMVVxQlmqsx8m9MRgogE
X-Gm-Gg: AYBFou1kzh0Sed+P5JHResVBG/c7kMfPwFK5f6EWBHzTeIRXcY2t3hJo3WJ5DM+1fj+
	NihvZYTyHeOVl3Ku3PyAwZqGG97VzMZt5UulM2bBEZRnJNLoqeWfDxJQf1eR7nEwnUHz12H8D7+
	zuSka+himvEwKEniUVo1hb+en75M2Zot82tLaHbtFZb8bk99xDevOUQNQgUUXmWlJrz4VDnIqpJ
	vH6nNGPWfqurur95ygPsuTaYrI7TRYjiaoxJsfhK2rSS6fnEFlxpxiVsQrVO+YzCMpbcPnAbRpW
	ajDwYR/z6TZbkVXsduOhwQzLSwJuJjv7+2mIQdFspr7It7swg2u6I5GiBpUTTbmt3SK7XRCH0sH
	/9nQenC4eP4lB4gzg9W2BPivh/pNefEmzkSDBuctx106hw8iVuM9KjaWlskdyyw5wFEkhffTbHg
	R78FhgQb/S2s0KfrhVJZ01xAFeZj07D1s5Rgy1xdmBytJcU0KL0QBLUxHJig+qn2eRRpTIQcRmf
	kWHQ2Z8xef+XP7c7veh4VYWtQ/+0Ii+deoJkWBmcE0A3fX92RE=
X-Received: by 2002:aa7:88c3:0:b0:878:3783:8a4b with SMTP id d2e1a72fcca58-87837839351mr3593980b3a.51.1789889099106;
        Sun, 20 Sep 2026 00:24:59 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com ([58.247.171.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9b0d62csm1668019b3a.39.2026.09.20.00.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:24:58 -0700 (PDT)
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
Subject: Re: [PATCH bpf 1/1] bpf: crypto: check params size before reading reserved fields
Date: Sun, 20 Sep 2026 15:24:41 +0800
Message-ID: <20260920072441.60435-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
References: <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This note is about a Sashiko finding on the already-applied patch
(a11212910cf0); that review was not posted to the list.  The note
below is analysis only; I am not asking to change the merged patch.

> The `algo` string in `struct bpf_crypto_params` is not checked for
> null-termination before being passed to the crypto API. A BPF program
> can fill this array and subsequent fields with non-null bytes, causing
> `vsnprintf` in `request_module` to read out-of-bounds, potentially
> resulting in a kernel panic or leaking kernel memory to user-space.
> locations: kernel/bpf/crypto.c:165 `bpf_crypto_ctx_create`;
> kernel/bpf/crypto.c:185

This is a valid finding.  It is also pre-existing and independent of the
params__sz out-of-bounds read that this patch fixes.

The kfunc's __sz annotation only bounds-checks the buffer: the verifier
calls check_mem_size_reg() on the params / params__sz pair and checks
that params__sz bytes of the pointer are readable.  It neither zeroes
nor NUL-terminates the buffer.  After the size check in
bpf_crypto_ctx_create(), params__sz == sizeof(struct bpf_crypto_params)
== 408, so algo[] (offset 16, 128 bytes, kernel/bpf/crypto.c:33) lies
inside the validated region, but nothing guarantees a NUL anywhere in
it.  A program can pass reserved[0] = reserved[1] = 0 (which the
function requires) and fill algo[] and the trailing fields with non-NUL
bytes.

type->has_algo(params->algo) (kernel/bpf/crypto.c:165) then reaches an
unbounded read:

  bpf_crypto_lskcipher_has_algo()
    crypto_has_skcipher()          crypto/skcipher.c:666
      crypto_type_has_alg()        crypto/algapi.c:1039
        crypto_find_alg()          crypto/api.c:535
          crypto_alg_mod_lookup()  crypto/api.c:338
            crypto_larval_lookup()  crypto/api.c:290
              request_module("crypto-%s", name)   crypto/api.c:303
                vsnprintf(module_name, MODULE_NAME_LEN, fmt, args)
                                                  kernel/module/kmod.c:150

The "%s" conversion has no precision, so vsnprintf() does a plain
strlen() on name; it keeps reading through key[], key_len and authsize
and past the 408-byte region that the verifier validated, until it finds
a zero byte.  KASAN reports a slab-out-of-bounds read if the object ends
before the next zero.  That is the extent of the bug: the OOB is only
that strlen()/string_nocheck walk past the 408-byte region.  An
unterminated algo makes vsnprintf()'s "%s" read unbounded, but when the
return value is >= MODULE_NAME_LEN, kmod.c returns -ENAMETOOLONG and
does not reach call_modprobe() or the usermode helper.

The finding also cites kernel/bpf/crypto.c:185.  That line is a blank
line, not a second use of algo; if (!ctx) after kzalloc is at 181.
The nearby second use of params->algo is type->alloc_tfm() at 187;
185 is a near miss for that line.  A 128-byte all-non-NUL algo cannot
match any already-loaded cra_name, so has_algo() returns false,
bpf_crypto_ctx_create() sets -EOPNOTSUPP, and type->alloc_tfm() is
not reached.

This is only reachable from BPF_PROG_TYPE_SYSCALL (the
crypt_init_kfunc_set registration at kernel/bpf/crypto.c:393), which
requires CAP_BPF, so it is not an unprivileged attack.  Still, the
verifier-validated buffer is the trust boundary, and reading past it is
a bug regardless.

Relationship to this patch: the patch only moves the params__sz
comparison ahead of the reserved[] reads.  The algo[] termination
problem exists identically before and after it, so it is a separate root
cause and is neither fixed nor worsened here.

A follow-up would validate that the strings are terminated before
handing them to the crypto API, for example:

  if (strnlen(params->algo, sizeof(params->algo)) == sizeof(params->algo) ||
      strnlen(params->type, sizeof(params->type)) == sizeof(params->type)) {
          *err = -EINVAL;
          return NULL;
  }

(memchr(params->algo, '\0', sizeof(params->algo)) is equivalent.)
params is const, so writing
params->algo[sizeof(params->algo) - 1] = '\0' would modify the
caller's buffer; explicitly rejecting an unterminated name is cleaner
than silently truncating it.  params->type[] is only compared with
strcmp() against the short, NUL-terminated registered type names, so
it cannot drive the unbounded read, but validating both keeps them
consistent.

That would be a separate patch (Fixes: 3e1c6f35409f), not a change to
the already-merged commit.  Happy to send it if you want it.

Thanks,
Yuqi Xu

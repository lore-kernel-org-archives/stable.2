Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394B3DA5B2
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740300; cv=none; b=oTtGmgV+22b1Ci5wEuljapqtGXH+TDdPFSMhgt+hSWtTkYkiWRtYuepeyrryb8TezI2/yU+L1aG1ZhGuian7wvTOUN0x6GxMfKN5ncgQkjpckvabeSoc760YQpPOaRQjxHicPHXI+7vzOJr75Dwxf/h/gun45jx/TeTg175nxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740300; c=relaxed/simple;
	bh=emrVq9nfCYjua+ImV8ic9KvnWto6cw74R0B28dzshtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mogM0gkz3Wk4n8O22sn/aOxiwgK+RPFlzB9xwFrSwfhkQEE5aCbHIxLxYkHboJpcd58VkvKVj3/++QbVJG7raDF74X+hDYDYC4n1Avst/VDFDYD02Vku9gxhyxVad9BMbcqX5+FgXD4F/S00wnoptPcb78rAXUBt3322sfVWOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc9UhAr1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc9UhAr1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf50c6f235so18352985ad.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786740298; x=1787345098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ueMVV2CkE7S/JWoTeRcfcRk5CIhzAhibPReUJDsm3gk=;
        b=jc9UhAr1rqX10VP4kx0J4PsA6NvlhdXUX8EifGRFTMNdibbvOfqmSdc9rBmNAYA9BO
         2OYyhD6Gnh+STFO0NYqgzjTpuswNjKc6861t5wS9h5LpEZ98k2RntiomVHAOKCd9Zoi8
         OtD33NIyLhUoVi3iN2Xm00oYNfrooUi6CnwhozUD3a3Zcsvxz4SNj+s34U/m3RT0aphg
         BNptQQOkQNqKWzFxiH4vD69M04B3fHXjUNuFK/TZGUthX9I45X7Rrl1P9pWuG3wbI63g
         f+XpzlNr5PfPtK4fkDifZyquns/HZN4JN/P7PL5M7ZqwF/TkMz6G/1+TJLOTbRhyYQ+x
         Yr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740298; x=1787345098;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ueMVV2CkE7S/JWoTeRcfcRk5CIhzAhibPReUJDsm3gk=;
        b=C5T2sAbLMBJIajAuGTWyIBCvNuymnbor5lEmz0ZppKXV1kjwvfQGJfDHD2j2VNqh8/
         QGC/Ay1NdEMoQaqvBI1lMG1LwWTx85l+QHVc/IxqbzoimH0Nt9rw62X6MZ0rs8usCpAa
         T4nLQml125k7Hx5Qzc99WJB9Y4E6eGs/e6r5Cn634pOmPyeQNqT01tiXytMKEvt6Zgdb
         pi0KCgRDpYizJU7TVJnmfrZpVhwvjNw7Lz5vitkSOcBxq/S5sbJ5E38fXv8jhyCVqVbA
         kl3TimonUPJS8SMOVoPBPbfwQrj7M4hAixPoK8DLfaEU5W1rdroh83QFXiqVHgcKfgVb
         KmLA==
X-Forwarded-Encrypted: i=1; AHgh+RodbMnRf6n4LjeveImhDLQ9l+A+EhnIpkAXtwoL/TZXfYD33Nyaw6lH0lZOSTb49/nV7ZUdyM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzezq8jYONGGyYmKKzO7iJWSu1l/bLT5klIDXHoO3rmiaTR9i1T
	t5LNzriPO+5gEz04McF7IpYlcPQmgzJ+YX738CEk/igwwoGvCS72HlNn
X-Gm-Gg: AR+sD11BwxvuDRt+ROn07U9cIqReHKhD1V21tnlMnqLlTwD1H2Nbxd0mBRWwETwg18n
	KSMTArBos0d/hhuewuCgsyUkM/ajn8iKA394DsWm9oXg22MBr761DWp5+B1ey0u2Ul2u2t3c34N
	+IaJ0zHhqXyxbVtpVrQA4qRIfhE3bxO4UQqtWhzWikexCdQ9gE7GOZtzspkk4Ytup3L/ZibzZyT
	5+qunCGxv9/W0/q5I8NkOgOX77pgch7IAShGPUW+iufp6kV/JTMB9u7ubFY1RRvVkjSKexvCPgU
	ByMK78137YAEV8buNnAP2bl2HZqjJAEwrksjjSOvWSzModVscMgQuLqwhDvmhJiAXNAXuUEj2Vn
	rIEfv05qFVkEq85jorMB2BprOJhDPwvDMjs8a2LO5aYFYFp9wDv61ido16DNS0r9Bt5An8aXETs
	9VPaTYmZl1RlvsmGAJcrdAxYiv9g1D2x1H5OotWt8CRj01RSqBlNYzuBMoxpXU+rFM7M9oh3o1b
	MN0Vy5o46uYUOAEjIFG1FHnIfCOUVQT+6EDb13IApL397T5CFL6reNV
X-Received: by 2002:a05:6a21:6b16:b0:3c8:e0b4:cd9b with SMTP id adf61e73a8af0-3cc71eb5e50mr10363565637.38.1786740298372;
        Fri, 14 Aug 2026 13:44:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd918fsm7689027eec.2.2026.08.14.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 13:44:58 -0700 (PDT)
Message-ID: <3338fd93155ac14b3b824ce232ae7be288072608.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, x86: Fix per-CPU address resolution
 into an extended register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 	stable@vger.kernel.org
Date: Fri, 14 Aug 2026 13:44:56 -0700
In-Reply-To: <20260814203248.3714536-2-vineet.gupta@linux.dev>
References: <20260814203248.3714536-1-vineet.gupta@linux.dev>
	 <20260814203248.3714536-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 13:32 -0700, Vineet Gupta wrote:
> The destination of the per-CPU address MOV is encoded in ModRM.reg,
> which is extended by REX.R, but the REX prefix is built with
> add_1mod(), which sets REX.B. REX.B extends ModRM.rm and SIB.base, and
> this instruction addresses memory as disp32 with no base, so the bit
> has no effect at all and the high register bit is simply lost.
>=20
> Every is_ereg() destination therefore resolves to the wrong register,
> picking whichever one shares the low three bits:
>=20
>   R5 -> RAX    R7 -> RBP    R8 -> RSI    R9 -> RDI
>=20
> With BPF_REG_5, whose reg2hex is 0, the emitted
>=20
>   65 49 03 04 25 <off>	add %gs:<off>,%rax
>=20
> adds the per-CPU offset to RAX rather than R8. The destination keeps
> the unadjusted address and RAX is clobbered, so the program goes on to
> dereference a pointer that was never made per-CPU:
>=20
>   BUG: unable to handle page fault for address: 0000607e386a8894
>   RIP: bpf_prog_707837aafd2aa9ae_update_percpu_data+0x93/0xc9
>   Call Trace:
>    __bpf_prog_test_run_raw_tp+0x2dc/0x7d0
>    __flush_smp_call_function_queue+0x1e9/0xc80
>   Kernel panic - not syncing: Fatal exception in interrupt
>=20
> R5 is the mildest of the four, aliasing a scratch register and faulting
> at the store. R7 aliases RBP and would corrupt the frame pointer, R8
> and R9 alias the argument registers.
>=20
> Use add_2mod() so the register goes through REX.R, matching how
> add_2reg() places it in ModRM.reg and how emit_priv_frame_ptr()
> hardcodes 0x4c for the same instruction with R9. Encodings for the
> non-extended registers are unchanged.
>=20
> Problem showed up when trying to resurrect BPF_GCC CI (selftests built
> with BPF_GCC).
>=20
> This has gone unnoticed because clang reloads the address into R1
> before each per-CPU access, so the destination is never an extended
> register. GCC keeps several per-CPU addresses live at once, and
> test_progs-bpf_gcc panics the kernel in global_percpu_data/init, where
> the address of a .percpu variable ends up in R5.
>=20
> Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to r=
esolve per-CPU addrs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Please don't drop acks.

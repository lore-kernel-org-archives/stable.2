Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1F3E16A1;
	Wed,  5 Aug 2026 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913680; cv=none; b=e2PL+2KJa4RZvXNYznYZAeTQxWegG+xOkm37qBKgQaYiWq1owDnhHySCflQdiz3Ep6EvmmYHMnM/FSuWjIEhy3itHS+MEJG/goyOC46A+d6wHmMQxaKopj22BzeE2F/cXS4gK0Y6z/UJ4aE0F+uSHAWjRdxwe+DtS0YwpeWf+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913680; c=relaxed/simple;
	bh=xrbaMmJJNYG7seiLwwRB5i68DoK/oManmHvexbfmTRI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lHeP0fVI0TP1vHlRAEfbX6bbzSSjlhSsVNle3IrdwOgy/bJ+6UUtvdIn9paAP1mVEg11bbHBG61UjB2g/6qykOyAVmjurwOh6WxA0xdkcKvWhk/VsO6LrHfQ1YyXSY3uDWPOm7ce2QJ3yDg4eSn8whw4hgo/bqHsmxNwcItqQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8gTQU9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8gTQU9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6444D1F000E9;
	Wed,  5 Aug 2026 07:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913679;
	bh=UGMpfuT8snJ0tfEwGHyplWLK/i+F2oymMko+Mu78Kgc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m8gTQU9ZFMy92/rC16QxOHZfJw/kMrRJPhdx7cuc13a+8XkfbClmetnJiDjGw7kxo
	 alS0UTHx7Zct0mAfLYRN21R8sg8rsHliQJK+cqUNYdNGvdLNSqdG4BpJNi0AhAYa3+
	 uJJFTepTFDX1X6x0KlhKPBl/hXQ/SGkNAfL4euPAxrmTuerAXggUiBeuzn28O1J3Mg
	 wS8yQfmuqqIzrJ10TNlckzEIqCHt4qCYRsE5yT7oBdqNs9H5U6/linqwet6BEyEsmR
	 cByYnCYyCxjDPVrRhC906M1dHJ1/n07jkxltxBXLRcjgBpdiJbRxLKOZ14UT+0GoW5
	 Z8Ih6G8q7+1Qg==
Content-Type: multipart/mixed; boundary="===============7106082230189184574=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5ef8aa40184d48efe9c1fb0def756263a654c22e4908bc803d0d92426e07ef52@mail.kernel.org>
In-Reply-To: <84353363810b8d63e7933391f5c6a2ea46f348e3.1785906979.git.skb99@linux.ibm.com>
References: <84353363810b8d63e7933391f5c6a2ea46f348e3.1785906979.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v10 4/8] selftest/bpf: Enable verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 07:07:58 +0000 (UTC)

--===============7106082230189184574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftest/bpf: Enable verifier selftest for powerpc64
>
> This patch enables arch specifier "__powerpc64" in verifier
> selftest for ppc64. Power 32-bit would require separate
> handling. Changes tested for 64-bit only.

This isn't a bug, but would it read more precisely to name the new tag
as __arch_powerpc64 (matching the macro added in bpf_misc.h) rather
than "__powerpc64"?  The actual macro expands to __arch("POWERPC64"),
and "__powerpc64__" is the compiler predefine used in test_loader.c,
but there's no __powerpc64 tag itself.

Also, would phrasing it imperatively match the series style better?
For example, "Add __arch_powerpc64 so verifier tests can gate on ppc64"
instead of "This patch enables..."?

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 5eacf1b432521..c35359c97e44b 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -159,6 +159,7 @@
>  #define __arch_riscv64		__arch("RISCV64")
>  #define __arch_s390x		__arch("s390x")
>  #define __arch_loongarch	__arch("LOONGARCH")
> +#define __arch_powerpc64	__arch("POWERPC64")
>  #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
>  #define __load_if_JITed()	__test_tag("load_mode=jited")
>  #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 07807757b518d..221393f2a8ef4 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -378,6 +378,7 @@ enum arch {
>  	ARCH_RISCV64	= 0x8,
>  	ARCH_S390X	= 0x10,
>  	ARCH_LOONGARCH	= 0x20,
> +	ARCH_POWERPC64	= 0x40,
>  };
>
>  static int get_current_arch(void)
> @@ -392,6 +393,8 @@ static int get_current_arch(void)
>  	return ARCH_S390X;
>  #elif defined(__loongarch__)
>  	return ARCH_LOONGARCH;
> +#elif defined(__powerpc64__)
> +	return ARCH_POWERPC64;
>  #endif
>  	return ARCH_UNKNOWN;
>  }
> @@ -585,6 +588,8 @@ static int parse_test_spec(struct test_loader *tester,
>  				arch = ARCH_S390X;
>  			} else if (strcmp(val, "LOONGARCH") == 0) {
>  				arch = ARCH_LOONGARCH;
> +			} else if (strcmp(val, "POWERPC64") == 0) {
> +				arch = ARCH_POWERPC64;
>  			} else {
>  				PRINT_FAIL("bad arch spec: '%s'\n", val);
>  				err = -EINVAL;



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30981212698
--===============7106082230189184574==--

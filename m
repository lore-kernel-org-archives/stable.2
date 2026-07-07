Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C142C237C;
	Tue,  7 Jul 2026 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412495; cv=none; b=fIcjoM7ZiHilHY+8daXFrJE/7ZSJtNTGIhP/mJG75NCUVkGb0/V1MVaq6vY2FibrZIrpbQET0bhfTuAteVQQibpHOI6W//HFRVAY3H5IixxF8bth76oSB4/mAHus5aIDU2NP3qb2R3ZIGER2kY2qaRxwFbmaFrgfBjs910CPZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412495; c=relaxed/simple;
	bh=kETmYOc5Y5R2f+aEsC3VA7txJkkcZXPhwxFxo7VeYgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHJxDZHknteTMDCwaXblQ74DNpAxuTwMJRRuBBmCcXrpTA7RdZUqqFvuwaftiTtBQFliQiunB5LHYRMnrhZSi+qsVIMDnx/XT8BOV2bGSdnuz8gU5phUPi2+CkdPJCmH5sHtF0/v0bQCItCA5kIArxXm3oHFkzUESPPxwOo6XN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=aqC1KGd5; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="aqC1KGd5"
Received: from [192.168.1.7] (unknown [120.238.231.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0FE01408C2;
	Tue,  7 Jul 2026 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783412491;
	bh=aNNNIkpjkV4G09smVjhidBNe4nWgPtemlA8/+5cHQAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=aqC1KGd59OZwMJhjRE4DbAjRibf92EX59xnmALodD0cDdk8EFLYrkdf1Ygq58ewIs
	 GHVNCpxu8RCPQKgCoyx8CWBH4JxD/3mZUHssW+2DY1lQH+scILaUbMOEDRw1Mfh37i
	 Kxsc/U4pfFbocok68CzExkeib+qEDi9daZE/pGka5AOF4pdCq87mHZo+xPtyYkRnRs
	 5msOqP62nRO2Ce5J/RQzy3FrAAlYT2v9ie8IjhQPBEbxrusYuc6n9bfxhXFpk6RUnZ
	 IBi9Y1xV7SxEXk20nS/uD9C12qXrS9Ut/RsWhQhQkJmRaL8gA1mHoAmNDu8ps9VnWS
	 HAoUdTXbNtSqn5gGeBGZpPcZT3Ibrjd6FjqUWJwxDpbUf2WSFPFYIxMdIMoDNubsVm
	 RyfXysjq2G/TO7e1YFAIeSiYn0l7wSwwOVTyanJ2ZmqFm20ZdmAwtW2zkuLBOery4k
	 GYY8wx5ji7aNG/EdclB9KCm4dfp0GJlt2yClH9SMvfhFcFPxP5XOLPRBnUp3g8fWiQ
	 Fb3q+mQmhSDK33OAHEBPqEHcmpULMV+3S3Vn5d1h8irBTxx3u890x6VyPAy36WKvcB
	 Uqji0EFcWQbYzA/RlXmYW5IEnBJFwV2pPJrHu0BDZX5r1lWJdsuOGgsosMrou7an7s
	 b2IQJQkEmsnbDgrb75L7VOHU=
Message-ID: <881386ac-5a70-4141-9de3-cb9ef7a7bab2@canonical.com>
Date: Tue, 7 Jul 2026 16:21:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: NACK: [PATCH] selftests/rseq: Fix a buliding error for riscv arch
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, shuah@kernel.org,
 paulmck@kernel.org, boqun@kernel.org, zhouquan@iscas.ac.cn,
 ajones@ventanamicro.com, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20260707081720.36510-1-hui.wang@canonical.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20260707081720.36510-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There is a typo in the subject, will send a v2 to fix it.

On 7/7/26 16:17, Hui Wang wrote:
> RISC-V rseq selftests include asm/fence.h from tools/arch/riscv,
> but the rseq Makefile only adds tools/include in the CFLAGS, this
> results in the building failure both for native and cross build:
>
>      In file included from rseq.h:131,
>                       from rseq.c:37:
>      rseq-riscv.h:11:10: fatal error: asm/fence.h: No such file or directory
>
> To fix it, add the matching tools/arch/$(ARCH)/include path in the
> CFLAGS and derive ARCH from SUBARCH for standalone native builds where
> ARCH is not set.
>
> Fixes: c92786e179e0 ("KVM: riscv: selftests: Use the existing RISCV_FENCE macro in `rseq-riscv.h`")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   tools/testing/selftests/rseq/Makefile | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 50d69e22ee7a..aba6317f6cb8 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -5,9 +5,13 @@ CLANG_FLAGS += -no-integrated-as
>   endif
>   
>   top_srcdir = ../../../..
> +include $(top_srcdir)/scripts/subarch.include
> +ARCH ?= $(SUBARCH)
> +LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>   
>   CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
> -	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
> +	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include \
> +	  -I$(LINUX_TOOL_ARCH_INCLUDE)
>   LDLIBS += -lpthread -ldl
>   
>   # Own dependencies because we only want to build against 1st prerequisite, but

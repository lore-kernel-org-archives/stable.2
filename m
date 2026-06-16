Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C12989BC;
	Tue, 16 Jun 2026 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589495; cv=none; b=sZDBJ0Xrc+xHTsHtdpW6og1o8vrIR5bjBHe1fz/QwzccgPUqdxxpdPNCXuk7BDDUavp81H8PGhNR+qVgoXdOyDhm8NKLLoaJ9fDDJYdWLSCiCfHtiU8IrMObddBft4ijOgi0gLdcQ6eHqm8FJZHWIwW68J6B3CRacdHeGpQCV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589495; c=relaxed/simple;
	bh=YzdS1AaqstvHESZWhTNSv1hLaZrpNbBcJAKEHpYMOAo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSKpo1lQn5ALhm3gVEQ6nmYCvCYA2uQQyBrrgsZBQEIqVoJw3g9esRY6wkMrK7VOPdzLCKRgC3TY7q/6GyJeXpZMpmIcXqmXfM/8sxXy2J3ux6/lgj5LelHvR1phLjHFbSstZq+y9oFulpTmOBFcMx0FGrOSvQVC/7Iroz9CdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fNWrwowY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fNWrwowY"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8A0EA206B1;
	Tue, 16 Jun 2026 07:58:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oeA8a8_KeLtY; Tue, 16 Jun 2026 07:58:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D6B0920561;
	Tue, 16 Jun 2026 07:58:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D6B0920561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781589483;
	bh=1DWY3awXtSk9ndqt+ekuMDsPfsrs/4LErXVaruC/ZO8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=fNWrwowYUxZVCIxiHxSSXTkLxo4wKYNUXCsFgI/YKILlcO4Ki7Kc5Y4OCxsHtaZMG
	 uJPdP2DEplz08s2mo8qZsPy2U421uMvJ/CP9ZVuDGwfUdTzft+NcdDN9GAoV1erLRr
	 MqyDio5zevWPiMOlbTiJSg6VfgTV95zSaEa0b4n+tiz9wb4wLeXMDbcnAVNVeqcH+w
	 8Cms8d+lz2S4wQFW7FBnLjQVZoZ8E34vwZQwZ3hTMR2nPiXkoeBX3TNjWEYfAIb9Pn
	 OEUL9EvWyu+qdo+CxYcZv9PM0ImNqei15rjeDzXS/yHT2YFHNKuDLOP5rV9TEImxz5
	 PTQ+jU1MDvceA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:58:02 +0200
Received: (nullmailer pid 1674231 invoked by uid 1000);
	Tue, 16 Jun 2026 05:58:01 -0000
Date: Tue, 16 Jun 2026 07:58:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sanman Pradhan
	<psanman@juniper.net>
Subject: Re: [PATCH ipsec] xfrm: use compat translator only for u64 alignment
 mismatch
Message-ID: <ajDl6e90gDXnTC6u@secunet.com>
References: <20260607164726.1544435-1-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260607164726.1544435-1-sanman.pradhan@hpe.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Sun, Jun 07, 2026 at 04:47:34PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> The XFRM compat layer (CONFIG_XFRM_USER_COMPAT) translates 32-bit xfrm
> netlink and setsockopt messages into the native 64-bit layout. It is
> only needed on architectures where the 32-bit and 64-bit ABIs disagree
> on u64 alignment, which the kernel encodes as COMPAT_FOR_U64_ALIGNMENT.
> 
> That symbol is defined only by arch/x86. XFRM_USER_COMPAT depends on it,
> so the translator can never be built on any other architecture,
> including arm64, which still provides a 32-bit compat ABI (CONFIG_COMPAT)
> for AArch32 EL0 userspace. On arm64 the AArch32 EABI already aligns u64
> to 8 bytes, identical to the AArch64 ABI, so no translation is required
> and the native code path is correct for 32-bit tasks.
> 
> However, xfrm_user_rcv_msg() and xfrm_user_policy() gate on
> in_compat_syscall() alone and then call xfrm_get_translator(), which
> returns NULL when no translator is registered. On arm64 that is always
> the case, so every xfrm netlink message and the XFRM_POLICY setsockopt
> issued by a 32-bit task returns -EOPNOTSUPP. A 32-bit userspace process
> on arm64 (and on any other arch with CONFIG_COMPAT but without
> COMPAT_FOR_U64_ALIGNMENT) therefore cannot configure XFRM state or
> policy through the XFRM_USER netlink API, and cannot use the XFRM_POLICY
> setsockopt path, because both fail before reaching the native parser.
> 
> The translator series replaced the blanket compat rejection with a
> translator lookup. That made the path usable on x86 when the translator
> is available, but left architectures that cannot build the translator
> permanently rejected even when their compat layout already matches the
> native layout. Let those architectures use the native parser instead.
> 
> Gate the translator requirement on COMPAT_FOR_U64_ALIGNMENT instead of
> on in_compat_syscall() alone. Gating on the ABI property rather than on
> CONFIG_XFRM_USER_COMPAT is deliberate: on x86 with IA32_EMULATION=y but
> XFRM_USER_COMPAT=n, a 32-bit task must still be rejected rather than
> routed through the native parser, which would misread genuinely
> 4-byte-aligned x86-32 messages. COMPAT_FOR_U64_ALIGNMENT is the ABI
> property that makes the XFRM translator mandatory.
> 
> Only the receive/input direction needs the guard. The send, dump and
> notification paths already call the translator as "if (xtr) { ... }"
> with no error on NULL, so on arches without a translator they no-op and
> the kernel emits native 64-bit-layout messages, which is what an AArch32
> task expects.
> 
> Tested on Juniper SRX hardware: with the fix, 32-bit IPsec userspace
> netlink and XFRM_POLICY setsockopt operations that previously failed
> with -EOPNOTSUPP now succeed; x86 behaviour is unchanged by inspection.
> 
> Fixes: 5106f4a8acff ("xfrm/compat: Add 32=>64-bit messages translator")
> Fixes: 96392ee5a13b ("xfrm/compat: Translate 32-bit user_policy from sockptr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Patch applied, thanks a lot!

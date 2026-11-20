Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168980;
	b=zxw22LzxzToDLI5VgbUsy7P4uZy49qPA3gen6asvNwiHqTS9FFCqHoNHDSbLwIh2jBsO
	 JwRwdf52YEAl28lXHRr7+sEqNFxtgKRA2oi/XSMeRtksYHnl7CvCb73RDkMhztEfj0y20
	 WqKQJk82FWb72wwWgmSyTMGqOtSCg/EEGOZWXsp6wp3PffO9438zEDE62E2bKoednwryk
	 Gii7Uv6/0M+xx2YNq/yQMR61BlP/4tHFe2dBE2hCAN9hvuQ5q2OUpDgl8WUeYC1hCK6NX
	 sAMubvj3XM2TuOeqJGS9FLRHsyqeB1TmEaMaWaopENSMrVMrzVtPKuiBZqBuXXfTOQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168980;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2q3/QmVzfD4Z2ni+YyHWx7ZyhuowtZXCzNWmjrN2ByM=;
	b=jG91b0dRpPbOrQ71qVHnppKiENmGPJHa/VOk1J0379o21kCXLjxoh/6xXLahLmfj2AKY
	 fcQSxf5qaPNrwIoiJocI20O5iGHBAEsNpIUh4hDh9qGsz+OWP0xoajSHHH1og8exbzCZV
	 T/MqwYauTC/Lmitc7HxlJ25afTcDidzuTzDnT/lcLN/kJ6d3jfTUBS9mSoPytY95jJ2qO
	 5hF55+cN88jLG04N2a6zu/u1wnoD9wrBiT9HK9ubnYrqEqJEv8wVjJgTtpmQ5lAfxH1hw
	 g/KkTVlVWJqJaMnk06ZiHuGznxzRObc/mUFgTJ3rJi3CB7dI4KWPKpfVqDtqnBFZsPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UQReXKOc;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34E606A320;
	Fri, 20 Nov 2026 10:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC34E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UQReXKOc
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E161477;
	Fri, 20 Nov 2026 02:02:53 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72B303F673;
	Fri, 20 Nov 2026 02:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795168976; bh=i5/VLaDm62sfWrEYNnw69oTmhljFVc4In1rpcL1/1zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQReXKOcPsmse556UMpJd1uddleMWU/Zf2t83nyz8DoSdIrMjlM4AP4PfmWgxsciw
	 6Z7uDGEzqrx7PMqAm4DEMgNdFNwxS7F19NMhnWzwXvx7pZ0kFrLwnhCcS7srf0PwPZ
	 dxj1b9IB8hXltqntg9UxXeoadaybCgJQyItFG43k=
Date: Fri, 20 Nov 2026 10:02:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
Message-ID: <awAay4FFj1_wQtaL@arm.com>
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com>

On Thu, Nov 19, 2026 at 01:18:03AM +0000, Alexei Starovoitov wrote:
> On Tue, Nov 17, 2026 at 09:23 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> > The arm64 JIT implements BPF_NOSPEC with a speculation barrier, but the
> > interpreter calls barrier_nospec(), which falls back to a no-op on
> > arm64. Programs executed by the interpreter therefore lack the
> > Spectre-v1 barriers assumed by the verifier. Contrary to the code
> > comment, kernel-wide SSBD does not provide this protection, since it
> > mitigates Spectre v4 rather than Spectre v1.
> 
> Nack.
> In bpf-next arm64 has no interpreter when the JIT is built.

And what about current mainline/stable or when one disables BPF_JIT
explicitly? Should we force BPF_JIT=y as well when ALWAYS_ON=y?

-- 
Catalin

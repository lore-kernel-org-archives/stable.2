Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715920D4FF;
	Fri,  4 Sep 2026 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481362; cv=none; b=E9Ptg7pKgaiYs4P8S0c12xlNIRn+0PlXzOS8kgaRPoveX8vjfTZtBWdF8Y+CGudrPoFGnPpsqI3VLNFgL3E4rVSz7g1GAuCNK+OWgv5f+l0qdRVsBo3vonzNAtErBqR5hetkPEUiCXE+N/6+Vrs2MKKa2aBvRCZQf/cvCiVbTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481362; c=relaxed/simple;
	bh=KkqA4JfpC+qZOcDSnPV5aLKF2fE3aJNceKGtVymIhq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBt4JTXTACUvkYLV66uv61prYi+ilwXw+cbH9V8ilU5fudbZ0frLIPb26i6c3EtnD/+XzidDijfmpO0rzDv4ooCdbny3J7guvmCHM8NfEiuGdbPjGevuB2pnMld36m87GQqRH/ME6XS1klh+LVeVHMAxu5WydKo6/srU4UN0ibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KYh/XthK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KYh/XthK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30B2153B;
	Thu,  3 Sep 2026 17:22:34 -0700 (PDT)
Received: from [192.168.20.93] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 267F03F673;
	Thu,  3 Sep 2026 17:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788481358; bh=KkqA4JfpC+qZOcDSnPV5aLKF2fE3aJNceKGtVymIhq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KYh/XthKzWv3g/3lQJv5JF/5Ky5DX9BV4DT9cklnPx5jre4t8JO5Pqpx+ej9aRHLN
	 NpPWsHrFvZK/YnpCJdAcsJeVqhDgy+Ri1ycxSm4qBtaxcuMsph/jCVrcDsshkl44Gy
	 +hBfOkMhIuhYtnrGwBfwjTGS5+91RLTb2kIQ3tQ4=
Message-ID: <bbbc33a1-cfd6-4cac-82c0-253888ca933a@arm.com>
Date: Thu, 3 Sep 2026 19:22:36 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tools: linux/types.h: Add 128-bit integer types
 for arm64 UAPI structures
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 David Matlack <dmatlack@google.com>, stable <stable@vger.kernel.org>
References: <20260626141730.5976-1-will@kernel.org>
 <20260626141730.5976-2-will@kernel.org>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20260626141730.5976-2-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Please consider this for all supported stable/LTS kernels.

Without this commit, older kernel trees will fail to build tools on 
systems running newer kernel headers.

Upstream commit:

10a47fb67340 ("tools: linux/types.h: Add 128-bit integer types for arm64 
UAPI structures")

Thanks,

Cc: stable@vger.kernel.org


On 6/26/26 9:17 AM, Will Deacon wrote:
> The arm64 UAPI exposes some 128-bit integer types to represent things
> such as fpsimd registers in the sigcontext. In preparation for defining
> these using the '__u128' typedef implemented by uapi/linux/types.h, copy
> that typedef over to the private linux/types.h header used by the tools
> directory.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   tools/include/linux/types.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> index d41f8a261bce..b6c473b7920d 100644
> --- a/tools/include/linux/types.h
> +++ b/tools/include/linux/types.h
> @@ -23,6 +23,11 @@ typedef enum {
>   	__GFP_HIGH
>   } gfp_t;
>   
> +#ifdef __SIZEOF_INT128__
> +typedef __signed__ __int128 __s128 __attribute__((aligned(16)));
> +typedef unsigned __int128 __u128 __attribute__((aligned(16)));
> +#endif
> +
>   /*
>    * We define u64 as uint64_t for every architecture
>    * so that we can print it with "%"PRIx64 without getting warnings.


Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C046445AC1;
	Thu, 27 Aug 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830819; cv=none; b=sSveqGmZkkV0AFhjQeY3957YnXPMiKs8AOmGPWex4/sjwtstNcPBo0/3JD1IojS9qvetVYcA2OFoNepGyGCngbhlum/XSYCm4u9tAK0RzFkP8JcPmCU9MCvCHfp37Z3ncMqSexJBtfWRd/Osm6Tvl0zb9OmJdcclRf4vPgjDRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830819; c=relaxed/simple;
	bh=P0zyNeIAZtPBTyCCY2YhnIKir0eAEwMza9FTKf/SPrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRHoC/OiVcH86oauaiRla3RWhozQFKeSTh4b7e381MrShjNkBnnyTAnLg4NiiED0DiHB2JzK6/RPA5/X0NoM7HIEhChVMX5s0/lgdIcYoXGg6XGQYGlJdlSy1LOSiinmWN4ZduquR1id0PSBz301u4wbzMNWkwfPh6kITRihmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FFCu+v42; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FFCu+v42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1787830811;
	bh=P0zyNeIAZtPBTyCCY2YhnIKir0eAEwMza9FTKf/SPrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FFCu+v42kkQ1bre2fmgPLmoe2U3j2QCH67Q+OI8W9FuxjNdifVS3WNIe5bsIesGbD
	 NNLUy4UYMB/5GVrh808wQOXSRZbIQpfXFBxrr6KopM9Qg1PZlibXmb+t1Xc5LbkzTb
	 XUxWej1uHNdRx3WjvUcqM/sHVI3zlINQZhB2/1VHO4yD9rAQ8RDlxLqbVnTTgeAwdO
	 BkgNpiu00XYBxITPhpSJ8QBIGGOnCNNsJn418Oo5anoxNyB34FXuvdN4oqM/rdjWci
	 RIgs5fRiiwmLyB+Jd7cZraZETPROoGWedhQc7ZyJC30D06AdZWMkK9w5P2498bOP4X
	 /pdyUumNO+JjA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 873BE60075;
	Thu, 27 Aug 2026 11:40:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 5A889200DEF;
	Thu, 27 Aug 2026 11:39:31 +0000 (UTC)
Message-ID: <83c08bb5-7977-405b-9a92-d846fec8e9ab@fiberby.net>
Date: Thu, 27 Aug 2026 11:39:30 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netlink: specs: rt-link: fix ipv6 devconf doc
To: Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Felix Maurer <fmaurer@redhat.com>, Danielle Ratson <danieller@nvidia.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260824103816.40040-1-ast@fiberby.net>
 <08c53736-eaaa-47b9-a65c-b920d21b2993@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <08c53736-eaaa-47b9-a65c-b920d21b2993@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/27/26 10:55 AM, Paolo Abeni wrote:
> On 8/24/26 12:38 PM, Asbjørn Sloth Tønnesen wrote:
>> devconf is even odder than described in the blamed commit, where bpth
>> IPv4 and IPv6 are described in an identical way:
>> "u32 indexed by ipv?-devconf - 1 on output, on input it's a nest".
>>
>> There are two issues with that line for IPv6:
>>
>> 1) The subtraction is an IPv4 specific quirk, to avoid having an unused
>>     u32 at index 0, thus saving 4 bytes per net device being dumped:
>>
>>     - In include/uapi/linux/ip.h the IPV4_DEVCONF_* enum begins with
>>       IPV4_DEVCONF_FORWARDING = 1, so the enum starts at 1, which is
>>       the reason for the subtraction in the IPv4 variant.
>>
>>     - In include/uapi/linux/ipv6.h the DEVCONF_* enum begins with
>>       DEVCONF_FORWARDING = 0, so subtraction would underflow.
>>
>>     - ipv6_store_devconf() in net/ipv6/addrconf.c also doesn't do the
>>       subtraction in the output path.
>>
>> 2) Setting IPv6 devconf through Netlink is not yet supported, as
>>     IFLA_INET6_CONF is not handled in inet6_set_link_af().
>>
>> Fixes: 720447bd0b24 ("netlink: specs: rt-link: remove implicit structs from devconf")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> Nowadays net PRs are already too big due more-or-less security-relevant
> changes. I think this is better suited for net-next, with no 'fixes' tag
> nor stable cc, WDYT?

The unsupported input is the main doc correction, that I would like to go into
v7.3 and earlier, as Fernando is planning to add that support for v7.4.

I stumbled upon this, as I was trying to getting rid of some sysctl calls
in an internal provisioning tool.

If the PR size is already an issue for rc1, then I can resubmit when net-next opens.
(I assumed that you were trying to make the net PR sizes into an reversed xmas tree)

It's likely going to end up in stable regardless, it's just easier for Greg and
Sasha when it's tagged.

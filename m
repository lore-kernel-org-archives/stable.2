Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D88492513;
	Wed,  7 Oct 2026 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369875; cv=none; b=gmAYsl6MuvlhQZn98ACMxC2oNv476Ff7ArnhSd8O7hCEzTDKcJj+/ZIp4HQow0QOIResiUM+YZLsNmV320NuIiVxpfA07DYBN7NVhEySybalHAnUaxzb5Mqpx/xAdvjy3nr/n/okg2VN9DI/fDgh4eHs/JD1RpUv7cZHsTSEDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369875; c=relaxed/simple;
	bh=XUI4IBT1AHM+WS8afOBXSDy1+qMEJ7pG3D6us0CT6UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rp/tWnGkWQqwAcOyeDnSFhFT9cwt9rszebFJGRUW7EfFongT2/FGddnFfdJdlWtFdrxpxbsmIM0A5ep7qXLwNlSeW89YlGzjuyEuZsxE/J+NEFdxxozQYtv99cV9r8cMwBNtMxpu4sqCPst6B5uadQbcV5DArBdHyPd3AKdENEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aubZZp6H; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aubZZp6H"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4j08c06C9Bz3ypX;
	Wed,  7 Oct 2026 12:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791369216;
	bh=XUI4IBT1AHM+WS8afOBXSDy1+qMEJ7pG3D6us0CT6UU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aubZZp6HY1K4YPD3VvN/i5tMA47ouI7WJTsOh28rWzjH41zNSBpYq2fZlCnh3tjjs
	 V/iLSfqreDhYcW4W4agWUQ5Watt9bs939oAmM41/Nh3Vxm5K5ymB0mQncUqg3Ncr8o
	 C7V0bNpc401DdeR96o9n4W8y38xbHTTqdBw/e8tLoI38wdkFpuq4KjDj230pPn5QQk
	 yKOB7Z02AGUYMQ4+1s7RyktG2uZ/1EUKqa27m2YWO41Q3mdHwxQBBRbRh86gyMEiT7
	 oCis8T7Yj/clA+Sx9Mt6QcsY+3z2vm9HRC8tPXga4jlTCI/3cGk+vOxfGdgeHTvWlG
	 Jalh5UjN1FUUw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4j08c05V4Nz3ynm;
	Wed,  7 Oct 2026 12:33:36 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j08bz5ybqz8svJ;
	Wed,  7 Oct 2026 12:33:35 +0200 (CEST)
Received: from [192.168.142.51] (90-182-211-1.rcp.o2.cz [90.182.211.1])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 125485FA36;
	Wed,  7 Oct 2026 12:33:35 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 90.182.211.1) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[192.168.142.51]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <cce34174-a70a-4e59-9c35-fd74309b0fb5@leemhuis.info>
Date: Wed, 7 Oct 2026 12:33:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Sasha Levin <sashal@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Joe Damato <joe@dama.to>,
 netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 Stefan Fleischmann <sfle@kth.se>
References: <20261005145430.12777c2c@nargothrond>
 <2026-10-06-1-daily-reply-0020-bnxt-en-vlan-447cbe95@kernel.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2026-10-06-1-daily-reply-0020-bnxt-en-vlan-447cbe95@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179136921539.2615039.13155272119453694887@mxe9fb.netcup.net>
X-NC-CID: 3D5EpOl4fJDoODSbkXR/FVrrWtWpL+c30msiSWuHHrO1kgcezxQ=

On 10/6/26 23:35, Sasha Levin wrote:
>> I'm testing the patch on v6.18.55, and it looks good so far. 5 hours and
>> counting without any issues.
> 
> Thanks for the bisect. The root cause is the bnxt_en small-packet padding
> and DMA length bug Eric Dumazet identified, not 447cbe95ebb9 ("vlan: fix
> skb_under_panic and races when toggling HW VLAN offload") itself, so we
> will not revert the vlan fix. Once Eric's "bnxt_en: fix DMA mapping length
> for padded small packets" lands in mainline, we will backport it to all
> affected stable trees.

FWIW, better wait a little longer till a fix for another regression
447cbe95ebb9 exposed in another driver is fixed, too:
https://lore.kernel.org/all/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com/

Ciao, Thorsten


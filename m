Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.135.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343480;
	b=AbNQENtSbo4A3lg58Z7nMcAgmbtKkz8qsPVa9AJBpLVnee7ae4Adk3Nu4ryeBuYtiXH1
	 bazJq/pglayJ1oEgvf5FHmzR/oNjpKDo3iJYBYcDNVBvCPDgol0hVQzK+TpBP5A0W1QPS
	 J5gK+1zCC/i+ZT5U5XOPDyET4rtpVWZLaP23NzR4bieT5/u+1pDa1SKBs+bx6JDGCsiTM
	 cYuWv8X3y6WR/MoCXeZxRL+TJjsvCVFJjEcEU9JGlwuPn82zTlev6gaLD7UJ/F3T2yjcY
	 w7ZEHN6A4xxv3TBmNYRU+qubMaDF+vymj4rewKTwDoipDvIChBVbe+PM/+Jt11zMpXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343480;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=TVkADfHPDb8fnatWdNHa/qcNYZPeSgj3KMCf+wk+eQ4=;
	b=VtY/xmau5mc2UetIrMORJSBCfGN7JClgUwZgKF5045I7qSVA5tbVubZuGth5fPPbik2E
	 nl2meB0uagkIn0UBxc8/346xWhFIBL237OMnUxeVnvk0f0ncGuWAlA1MGPJ9IS89ukkOG
	 4X3nxF2uFoQowewkOhlpCuK7gaJ8N0nqzQCfaeExX46uoTu9GSEu3IE7atlTpDk6rb9uA
	 YRYw3LBOWgudpMTNMFes6J+R4DPaCp8rvBb+38PhSu65W5eblEyCNVw31mV1DWAkSbF0Z
	 hZ9SugyH4sTz8Oh4hxPHCNpsebpqPBIcHiOS+ZuaABUk7SGdMbjCzZyjyhMzxMZ9Krw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tsv-stahl-riesa.de;
	spf=pass smtp.mailfrom=tsv-stahl-riesa.de;
	dkim=pass header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=JrlpsY+K;
	arc=none smtp.remote-ip=85.13.135.14
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C79606A320;
	Sun, 22 Nov 2026 10:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C79606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=JrlpsY+K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
	s=kas202608160020; t=1795343478;
	bh=TVkADfHPDb8fnatWdNHa/qcNYZPeSgj3KMCf+wk+eQ4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=JrlpsY+KmQG061qviW2503HQFOjUQL+zGCrOFJ6rvCVMSsGvEHo8AogW9lZppTZ49
	 gHi453hvFNphyZvc74D/eX4OuBgcBgUZ7HxUbeEWHgEdQCDCKXUrqZg8qMvruQVS7C
	 LFEMRrQk4oXWVwkTY8Lq/NaobCniDpgwDwlAJ8T8VjSdXiSfSHvVcQPlT8TwEHwvCh
	 FFsP41QKphrNqmNYkx4LzW8P5RCj8GFl/ykuJU2VmrmFPs4JBVXG68XzaL/WSBxJ2t
	 dS7FSmx+XPQUd8GGBrQkIsul6Il5j83ncSlEYtxUOcaS/GkoXi7CKqnOo81HqnGWYU
	 xNRIr2Nj21+5w==
X-KAS-Sym: v3:f51bdf72230551df:qJ5uOu2tDOwck04l6ZZT5ZgS9yYs6RwmRLkVQ2e11W2Qg
	xi4Fjh2AYzKKX2gAyElm3p0uCqidYfZPAU5b1CzV46YKHzkqvcvF9ccxgCloMJKvslloO6MCVfr
	6QdObSfYmUNWJ/0ucr8ReMwDqZqTusb+gYriedhqiF3fS0N72iVo5FfV8U+j8sjgdQrvg+UEGp/
	pMFOz7n2SOuS/Di7sMFu5a52da6xM7KbRWb1W+CP2vGKw25C/j+ejlSDMMtN0jrrQDY3+AOavU4
	QcErcPgCm854wBnsoLaG1yVxs1QYz+HjGQnrwyrtb2YfxTOOrtB2rQBg75sAG60ujUMzYTiA==:
	LIsP67MWPJ6MktH5KhJU48vefOjvSstBjfJY1H6nciXf4jJp1vxhSecL1fYV0HM7ibACVFde9Zu
	PlE9k85to59F+lACpg/1k8DUXHzql4rY51YeGezHNMXjMR9/aJmOSei5eALdtMRElAWwetkLxiF
	8jEbT7kHCVl4VIjz00GvP3kwPSW3eInjBWKaHKpS3G/nyXvezCWFcOgyCUwaAE8Z8jX1aC0SIGf
	Hs05ehj7v8HywB61UFrg6OgEthVTe5EbGPYasumH1YRPG1g0QPRqDyo6thIF6vk7jH3sQWlSsv1
	mQsflKHl6FFhEhXe0jloZTlnEyxxPSsHAUOZDt5kQbUNKM7d36mggTu5YMgrAvt0i13wg/7cIrq
	8udI8DPo4xM4OKBYxqTCKFxi4DlDGofQuZtfIKQ9fMeJsEXbcVsn5vLtwToUico7vl1xlvTAR0H
	FmhFsv5wzX2QB6plCSY+mw5RGBAcTdQzG6zH8Rac6lI0ckapql6hg/grWUwth+P4P9hfRV4RZMM
	UcAxToDtR87z+KJxU4dvUdlVTp20ZNnpfjTddU54iJ2uXYPXAZesZlQ/mLEqFf0eqH5+lE7gOTv
	Y6J5M8pCv9Ssth0hL80/fQt9LA==
Received: from [192.168.2.174] (dslb-188-098-197-218.188.098.pools.vodafone-ip.de [188.98.197.218])
	by dd13108.kasserver.com (Postfix) with ESMTPSA id 824837821A5B;
	Sun, 22 Nov 2026 11:31:17 +0100 (CET)
Message-ID: <2b111b7d-7d1e-4872-a0b1-8f07b58492de@tsv-stahl-riesa.de>
Date: Sun, 22 Nov 2026 11:31:17 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] memory: tegra114-emc: Fix bus width and pad
 auto-calibration
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20261111-upstream-emc-t114-v1-0-54d9e1bceb6a@tsv-stahl-riesa.de>
 <179518240415.10624.13757193124982371025.b4-review@b4>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <179518240415.10624.13757193124982371025.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

Am 20.11.26 um 14:46 schrieb Krzysztof Kozlowski:
>> On a Tegra Note 7 (Tegra114, P1640) I had kernel panics, bit errors and
>> WLAN firmware hangs under load, and two kernel panics on EMC rate
>> changes from pll_p to 624 MHz on pll_c. Looking at the EMC I
>> found three problems in the Tegra114 EMC driver:
>>
>> 1. EMC_AUTO_CAL_CONFIG is masked down to the self-clearing start bit
>>    before it is written, which clears AUTO_CAL_ENABLE on the first rate
>>    change. The bootloader leaves calibration enabled, with channel 0 as
>>    master and channel 1 as slave. Patch 1 stops clearing the register.
>>    Programming the table values needs the channel registers, which
>>    patches 4 to 6 describe and use.
>> 2. emc_icc_set() assumes a 32-bit DRAM bus, but Tegra114 has two 32-bit
>>    channels. Every interconnect request asks for twice the EMC rate, so
>>    actmon at 312 MHz moves the EMC to 624 MHz (patch 2).
>> 3. Pad auto-calibration is disabled for every clock change, but the
>>    interval is only restored if EMC_CTT_TERM_CTRL changes, so it stays
>>    off after the first change (patch 3).
>>
>> Patches 1 to 3 are small, do not depend on the device tree change and
>> are marked for stable. Patch 1 comes first on purpose: patch 2 and the
>> clk patch mentioned below make the EMC run at a real 624 MHz on pll_c
>> more often, and both panics I saw on a change to that rate were with
>> the calibration cleared. Patches 4 to 6 are not marked: they need the
>> binding and the device tree. Patches 1 to 5 are for the memory
>> controller tree, patch 6 for the Tegra tree. The driver has been there
>> since v7.2, but the first in-tree Tegra114 device tree with EMC timings
>> (TF701T) came with v7.4-rc1, so the stable tags matter for v7.4 and for
>> out-of-tree device trees.
> 
> A bit confusing. This clearly suggests dependency on DTS, thus ABI
> break, but code does not look like that.
> 
> Best regards,
> Krzysztof
> 

Sorry, my wording was unclear. There is no ABI break: with an older
device tree that only has the broadcast reg entry, the driver probes
as before and leaves EMC_AUTO_CAL_CONFIG as the bootloader set it up,
which is what patch 1 is about. Only programming the per-channel
calibration values from the timing tables needs the two channel reg
entries added in patch 6, and the binding accepts either one or three
entries.

Thanks for applying patches 1-5,
Patrick

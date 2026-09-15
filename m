Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1093D6CDE;
	Tue, 15 Sep 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444820; cv=none; b=GAtSJuuGmu/kSBv8B+hkYsiE5ugvpUc5kstCJmAbb2wosz3r2hPiwIH50X1zrwPU3WorFrodvjwKjDpoqjCADAr4GRlhybrqR4j54h+gDLLDOAUbYkB5LvRkQPQliPbjHkxWm3giZDcJXXDWe4YL/NlOuf/qqNKISLOiM4FsGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444820; c=relaxed/simple;
	bh=fH8KNsTlhwxJVcCjqxppQyJG1OIc0ZghqeI32d3fg2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMgPaNXm8rWQjapWshJwLv7cCgz4ctX4RHZRM3e911HszAUicp1duSYK5BF0c7b09GiFXwOdV1tdMw8slqyth1Me8J4ddbztRFcgyBzYPg1M3NIqqwuAA+EHAiK5V6hJTeH89LoamhxGUybNDE2mOv4/zc8pqjsRIHDF7QzUyqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTz0/iKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTz0/iKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3DD1F000FF;
	Tue, 15 Sep 2026 04:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789444817;
	bh=bOGviD23LIx9itgkTZT1I56y223hTDE9oauoFAaTHLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VTz0/iKuOlxNIORnSR8CuhF+WTbfOZ9IQ6sNACa+BhbsvUi5Yjs3aXS1d2jc6z/eL
	 NyxLWxxKcByY9bs5VR74ChBQYe63zeaSbxZF6mZvAAGXP/PAL0zj2yYsJBA3hNbru9
	 u1S4c8nDC9un1+OYBLtAUkKDX6UxIbV09M5F8USMVdFcsi/jZ0kSUVa481hwsGkRCe
	 V5dernqc5o0A1SevCkPBWxECHJ4B1UJJJS4g9U33b/r7Tnj2hHBVJLcVjEzzkIPv/B
	 orGYptUx7f0KJTDg6MkHyp/JM+cWcrACFYHe5JstDNuix8qaU3APNSdtmziRqHcZ2K
	 xBMiaqXYvSY1w==
Message-ID: <4f4941e6-1e51-4fc7-b452-e7f77cfca4bf@kernel.org>
Date: Tue, 15 Sep 2026 11:00:11 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] ata: ahci_st: Assert the power down reset in the
 probe() error path
To: Niklas Cassel <cassel@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Tejun Heo <tj@kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>, Lee Jones <lee@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org
References: <20260910171406.131211-7-cassel@kernel.org>
 <20260910171406.131211-8-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260910171406.131211-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/11 0:14, Niklas Cassel wrote:
> st_ahci_probe_resets() deasserts the "pwr-dwn" reset, but the probe()
> error path of st_ahci_probe() only releases the host resources, so the
> SATA IP is left powered up when probe() fails after
> st_ahci_probe_resets() has succeeded, e.g. when
> ahci_platform_enable_resources() fails.
> 
> The reset is asserted by st_ahci_host_stop(), however ->host_stop() is
> only called through the ata_host_stop() devres action registered by
> ata_host_start(), so it does not cover any failure happening before the
> host has been started.
> 
> Factor the assert out into st_ahci_assert_pwrdwn() and call it from both
> probe() error paths. The "pwr-dwn" reset control is an exclusive one, so

from both probe() error path *and* ... ?

> asserting it once more from st_ahci_host_stop() is harmless.
> 
> No functional change intended for ->host_stop() and st_ahci_suspend().
> 
> Fixes: 76884cb2f7da ("ahci: st: Add support for ST's SATA IP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Other that the nit above, looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

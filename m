Received: from mta1.migadu.com (out-80.mta1.migadu.com [95.215.58.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295443DDB03
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890165; cv=none; b=tdX7yqkcqo4iz7xS/e2AQJkqbiTmfmWPckz4qsUr4Nbyuct5XveEgRSXb1Eob6QfFOMgBBJTPq/BlFCL4yG4jHfWtc5t7YCsMa+LSiVeVRtQYtkdSeYKT31VN/XCw5HZoZbgnQuU8Yjg9AF2BmQN4e12nqoCFcibrKHrDe8bV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890165; c=relaxed/simple;
	bh=XACIHRk7pvR3ne8CI5yYmGZaL8q2kgBI23W8AaJmnmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9lzKARHlnZw/VTp+TctTXEwTZxamJfsqwx9lAZU5DS/KRmCxGzLiHHDmcerw4SWifRTXf13lukMy+pN+PF2bOdvHXKPLrLMCIkE5mFQaIS/BtRakYRwA/rpBcMg9CY88HNQ/PawxT44L2HBas2ME5B0wO2uW7+U7R3nmu3Yce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hLqtI2js; arc=none smtp.client-ip=95.215.58.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hLqtI2js"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XACIHRk7pvR3ne8CI5yYmGZaL8q2kgBI23W8AaJmnmw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789890160; v=1; x=1790494960;
 b=hLqtI2jsb1Yi6iEZM0kP6YcXRZ/BParR6qhARgb/niOqQZdg4wc6QnflM31u6EHVwIXc4ayl
 kYHk6jsaJrF5Dabu9dPkmD3+TajvGV92MApTW9Eqj0yvYZjRaevpZ8PREQIlGreSTFbdbfKWMuh
 fidqhWWqbxiQSFU9sSHGV4kA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6ff25d7f64fa7a0b;
	Sun, 20 Sep 2026 07:42:39 +0000
X-Mizu-Trace-ID: 6ff25d7f64fa7a0b
X-Migadu-Flow: FLOW_OUT
Message-ID: <327d0a31-7a04-4ec2-b184-c801a95750e9@linux.dev>
Date: Sun, 20 Sep 2026 15:42:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] irqchip/gic-v3: Lifetime and range fixes in the GICv3
 and ITS drivers
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
 stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260908142632.2795308-1-fuad.tabba@linux.dev>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260908142632.2795308-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fuad,

On 9/8/26 10:26 PM, Fuad Tabba wrote:
> Hi folks,
> 
> Three fixes to the GICv3 and ITS drivers, from reviewing the GIC series
> floating around and chasing down Sashiko's reports.
> 
> The first releases the partition node that gic_irq_get_fwspec_info()
> takes from of_find_node_by_phandle() and never puts. Sashiko raised it
> on an of/irq patch of mine, and I said a fix was forthcoming [1].
> 
> The second widens the per-device MSI clamp, which truncates to zero when
> GITS_TYPER.ID_bits is at its maximum and then denies every MSI on that
> ITS. I couldn't find an implementation that reports that maximum, so
> this is one value at the edge rather than something anyone is hitting.
> It carries Cc: stable because the commit it fixes was itself
> backported, so drop the tag if you'd rather.
> 
> The third clears vpt_page once its_vpe_teardown() has freed it, so the
> NULL guard holds if teardown runs again on the same vPE.
> 
> Based on Linux 7.3-rc2 (df2908090cda3).
> 
> Cheers,
> /fuad
> 
> [1] https://lore.kernel.org/all/CA+EHjTx7eP_30vP47=UFk_wMAut-2uf+2DF-MZqn2SLE_k-8qg@mail.gmail.com/
> 
> Fuad Tabba (3):
>   irqchip/gic-v3: Release the partition node in
>     gic_irq_get_fwspec_info()
>   irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32
>   irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
> 
>  drivers/irqchip/irq-gic-v3-its.c | 3 ++-
>  drivers/irqchip/irq-gic-v3.c     | 7 ++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)

All look good to me.  Thanks for the fixes!

Reviewed-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Zenghui

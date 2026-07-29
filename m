Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FE25D215;
	Wed, 29 Jul 2026 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288886; cv=none; b=Y7KInAvYLRxY1jvSCrRMMcOGdrGApDlfO9HFMermcGQhjg+WJOHIMciVItEeGpr4lHN1Dn+DFHbMkwB7crx4CC7bRNJ7iE4F/gh/+FYm+Sr2VLVW9eKATQZ/y2ZKuqgk6XioZ3HSL57utrUz2C8x/IcEm82GhusljBHyM89oFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288886; c=relaxed/simple;
	bh=vIARaXCCSFuDF80uBMKFCFUJTb39fi5OYeDbjxvPuB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l2ANLMUkI8zGW1EKReZSGm6eHwzk0TZrE4gEuojUab4D1lbuKJstxy6PIeBVO0nxONKZjnp2mACj2st3H9h6RwJRkCXW7JHserr6McNW79itennpd+VnmcBXaDJLq5xGLBu1d9a88mmBmcoBVFv0rxTAV80Gs/OwSkdtjxgA16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=B73Ljcnt; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="B73Ljcnt"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vIARaXCCSFuDF80uBMKFCFUJTb39fi5OYeDbjxvPuB4=;
	b=B73LjcntGv/Sh+1VigVSU1HKzJCXEyTExQRV7X1hK8N4iztFGPvtV13o7SE/vFb7w/7VBAisO
	qZ6nmZ2UXhSl3lSfH1H8oSLB6kyhuRVvWPxMpRs7MMdIHlgnNn/Q3ntUp1JrchYMbuEfVrE4uqW
	u7TjGZw1AO9jcTZKYzsmnB0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h8vlV6LV9zKm4b;
	Wed, 29 Jul 2026 09:25:10 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E649402AB;
	Wed, 29 Jul 2026 09:34:40 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 29 Jul
 2026 09:34:39 +0800
Message-ID: <f4bf4615-d54f-4c08-b736-42b36d4645e8@huawei.com>
Date: Wed, 29 Jul 2026 09:34:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: acpi: Handle LPI architectural context loss
 flags
To: Peixin Xie <peixin.xie@linux.spacemit.com>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, Oza Pawandeep
	<quic_poza@quicinc.com>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <spacemit@lists.linux.dev>,
	<stable@vger.kernel.org>, <lihuisong@huawei.com>
References: <20260728-riscv-acpi-lpi-timer-v2-1-5a30e0021ec9@linux.spacemit.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260728-riscv-acpi-lpi-timer-v2-1-5a30e0021ec9@linux.spacemit.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/28/2026 7:47 PM, Peixin Xie wrote:
> Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
> broadcast timer") replaced the generic nonzero check for LPI
> architectural context loss flags with arch_get_idle_state_flags().
> RISC-V does not implement the helper, so it falls back to the stub
> that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
> an LPI state loses the hart timer context, preventing cpuidle from
> using a broadcast timer for that state.
>
> Implement the RISC-V helper and map the hart timer context loss flag
> to CPUIDLE_FLAG_TIMER_STOP.
>
> Fixes: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer")
> Cc: stable@vger.kernel.org
> Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
> ---
LGTM,
Reviewed-by: Huisong Li <lihuisong@huawei.com>
>

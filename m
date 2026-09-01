Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B727FD4F;
	Tue,  1 Sep 2026 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262364; cv=none; b=XApp80AheeHNlMPEzHEwsofeOhLksvIeCksU7dUjiMatgQWNzspoFp/ZuH0UgFoxZnUhSx4Z4BdHIYqqQVh/LkxQOW4wlTB10+efRi5T4vJQAXirzL54hYCQG8rOEz+OJI5CAj/surEGZ6ibUQqihLqHXT0GrK4hOK7xXukqKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262364; c=relaxed/simple;
	bh=0pLk5NXM3SHNIHP+858IYALmpGykK8YPMiFBTdO/fZ0=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=L2PW+PzXZm/U9vvl76rkkGJHJVIk3aFrBOFid4JqXGsInm/6VSnuVSq5zrffe11cdn1WzHqraFWJ7bMoaEyLtpd/N2iBUOqtmj0Mvg69UfByg26Riau7/EB/b52gUA196Tyd0W+OUYo4LyEDmc4wFVfNVBmoRUNrtNj8n9g6J/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KW8LK+xS; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KW8LK+xS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/hhdfcFtBwwr0ueqKB1oPvoZ0kalegTDXSO1ka8UvIQ=;
	b=KW8LK+xS88ERGHeItprKRzT88x2gIFIDOo67G1FWi+lRuAiHnKsOlpQXffdTYCBjIP/AdGlMr
	RD0SIi2rKnpmNB31YKjZWFRLN/W2+1ImpC7ByhJDHmgXnBfpLl+H7AUtQRQWCWaQcDc2NGw02O7
	QBXPPXybSNs34mb8D/wd4lk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZ3Md5NmSznTtT;
	Tue,  1 Sep 2026 19:21:17 +0800 (CST)
Received: from dggpemf100018.china.huawei.com (unknown [7.185.36.183])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F48E402AB;
	Tue,  1 Sep 2026 19:32:31 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemf100018.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Sep 2026 19:32:30 +0800
Message-ID: <c3a8cf75-ea3a-4d67-b30d-c6ba3b70c844@huawei.com>
Date: Tue, 1 Sep 2026 19:32:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <caina@uniontech.com>, Marc Zyngier <maz@kernel.org>
CC: <guohanjun@huawei.com>, <kernel@uniontech.com>,
	<linux-kernel@vger.kernel.org>, <maz@kernel.org>, <radu@rendec.net>,
	<stable@vger.kernel.org>, <tglx@kernel.org>, <zouyipeng@huawei.com>,
	"liaochang (A)" <liaochang1@huawei.com>, Ruan Jinjie <ruanjinjie@huawei.com>,
	<wangwudi@hisilicon.com>
References: <20260821091720.16665-1-caina@uniontech.com>
Subject: Re: [PATCH] Revert "irqchip/mbigen: Fix mbigen node address layout"
Content-Language: en-US
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20260821091720.16665-1-caina@uniontech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf100018.china.huawei.com (7.185.36.183)

Hi1616 is special hardware whose register layout differs from the other 
mbigen platforms: it does not have the clear register range fixed at 
[0xA000, 0xAFFF], on which the fix is based. As a result, skipping an 
extra node offset for node IDs greater than or equal to ten, as the fix 
does, makes the driver access wrong registers on Hi1616. The fix was 
originally introduced to address a real problem on the other platforms: 
each mbigen chip has its own independent set of clear registers, whose 
offset is fixed within the range [0xA000, 0xAFFF]. Meanwhile, mbigen 
allocates a consecutive 4-byte register to every hwirq for configuring 
the interrupt type, EOI and so on, so each 4KB node region accommodates 
128 hwirqs. Before the fix, the driver calculated the register address 
of each interrupt from its hwirq. This works without any problem as long 
as the number of interrupts is below 1280, which means no more than nine 
mbigen nodes. Once the maximum number of interrupts of a mbigen chip 
exceeds 1280, however, the node register addresses reach offset 0xA000 
and start to clobber the fixed clear-register range. The final solution 
will be worked out in cooperation with the BIOS: the firmware will pass 
a chip version to the driver so that it can take care of all platforms. 
Since this depends on the corresponding BIOS versions being adapted 
first, it cannot land immediately. In the meantime it is safe to revert 
the fix, because nobody has run into this problem for now: it can only 
be triggered on "new hardware" platforms, while all the platforms 
available today, including Hi1616, work correctly. So, let's revert this 
patch first. Acked-by: Yipeng Zou <zouyipeng@huawei.com>

-- 
Regards,
Yipeng Zou


Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F4155757;
	Mon, 24 Aug 2026 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787544060; cv=none; b=n+0ly59SWMO1PYQ1aY+uEkfWY0Yi1gJKNlOYjVbuPB25QD7MbMfuuT/8ZA3xTkqAQh1xMB7Sa6ccHNUnfc7Dxb14GEsjVk62gOFKa/pW0mWUD+0icR8gvDcEQZ/KmNjLzjtYW0iXKI9DdHGqZmisSksq92FyADoxtZtBuyoTxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787544060; c=relaxed/simple;
	bh=7SFbWN+6wWJSTq7w8WSG/y/A0lrYdNv3GaPbdlxM1AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VG48gzUHFI1hd6Qsglgxr0Js0tL1WsjxqgBJcbw3HBjzaaFM9QDAnNmha7Wy9YPa+R5hSu+9M+sLmPUo4Nz35oCWMe1s0p/AKLvXBHoqf/mA0PC/KzXujrYZzcYwUfkXoMMdGE0rjsbUQ4f1OJImmzwyhY5EKrHQ1j5Ygig6UFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6It6lyAt; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6It6lyAt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TqdonImzbWfKbjV2qUASp4Goc0MmeY75l3/0kCBSS4Q=;
	b=6It6lyAtst6TdjkO1asH9rqAGOwu8AtRigrIwHLFKIq9TM5lFA9PlyYfz6wDyxXPISY49eCxG
	EO8EwAZ0BfR1pqOEzNrPUJ+LwPVlF1X0Vc8CC7dYnb6n6wAutz4spG9bndtnKhGp0jjDJfOsv1i
	vBcojRZnAoJVzounJo2F2zI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hSxkg6yDvz1prQc;
	Mon, 24 Aug 2026 11:50:03 +0800 (CST)
Received: from dggpemf100018.china.huawei.com (unknown [7.185.36.183])
	by mail.maildlp.com (Postfix) with ESMTPS id 31E134058C;
	Mon, 24 Aug 2026 12:00:50 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemf100018.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Aug 2026 12:00:49 +0800
Message-ID: <dab9d7f2-d208-4dfc-b25f-8f46d6d44bf9@huawei.com>
Date: Mon, 24 Aug 2026 12:00:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "irqchip/mbigen: Fix mbigen node address layout"
To: Hanjun Guo <guohanjun@huawei.com>, caina <caina@uniontech.com>,
	<tglx@kernel.org>, <maz@kernel.org>, <radu@rendec.net>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<kernel@uniontech.com>, "liaochang (A)" <liaochang1@huawei.com>, Ruan Jinjie
	<ruanjinjie@huawei.com>, <wangwudi@hisilicon.com>
References: <8633w854yk.wl-maz@kernel.org>
 <20260821091720.16665-1-caina@uniontech.com>
 <49ae6e21-2ee3-8dba-f731-7ef17f793dd5@huawei.com>
Content-Language: en-US
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <49ae6e21-2ee3-8dba-f731-7ef17f793dd5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf100018.china.huawei.com (7.185.36.183)

  Hi all,

     I’ll send a patch for this soon. I have a fix ready, but I need a 
bit more time for testing.

Thanks.

在 2026/8/22 17:55, Hanjun Guo 写道:
> Hi caina, Marc,
>
> On 2026/8/21 17:17, caina wrote:
>> This reverts commit 6be6cba9c4371d27f78d900ccfe34bb880d9ee20.
>>
>> Commit 6be6cba9c437 ("irqchip/mbigen: Fix mbigen node address layout")
>> appears to cause a regression on Hi1616.
>
> This will break the new hardware :(
>
> Sorry for the incompatible issue, but please wait for a while, Yipeng is
> working on this now.
>
> Thanks
> Hanjun

-- 
Regards,
Yipeng Zou


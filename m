Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D03ACA5A;
	Sat, 22 Aug 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392538; cv=none; b=n2KYjnLk/S0ey9LtxS72v+ccrbRnrgN7OjZ6rvokkfXdkkAExEJCay4suUUXZ25p+stdjvM3Z2RGgMDNVa0+d6W2RWjQKWjlsw6kI30HIJvqp+zO2UgpqfABrk5cBI2NroB7W0K3dxQ8QSTGzEPnHuPvbR+AwAxY5UqKJn4roTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392538; c=relaxed/simple;
	bh=IE8vZ3j0rlM8nPup3d1lLQhzbsgNkYUDt59oBX1zYW0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bjrec14XKFXICVmpSbLwnOG8t5WcHT008s4yw5bejpXxT/fJYnfh4qrzeQp+eDFUBhpO1BU4MKpFENFNs/9EZquh9DMyTzh6xagvV94rYMp5pCVECN9tlEQQSzP1yCMwR3X4quGxrAKzGwvdclqPxzfOoQh66kRBuAB1hIxXg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=T6abYMGR; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="T6abYMGR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7GrDTnwMJgIVOmi7Xgbu4x5oIHUvk450gb1DGhX98Xk=;
	b=T6abYMGR4QiK7AVAlIzU4PyVqn23QXBlFdp79AF5KHnccYLZSIvo/MBLyYrE3//wAZHBMfaDn
	BeicWSfCYzwZp28RL6Qvgzt6mLfSf5Uo8mQQb4+DTnoo+cugIhgQ7fdaCN/WPNtzXpB/8Xq7AXy
	QcYt0EYZfwxx1mdd5gOBs3o=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hRshw1DRTzmV7C;
	Sat, 22 Aug 2026 17:44:48 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B3D14057A;
	Sat, 22 Aug 2026 17:55:31 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Aug 2026 17:55:30 +0800
Subject: Re: [PATCH] Revert "irqchip/mbigen: Fix mbigen node address layout"
To: caina <caina@uniontech.com>, <tglx@kernel.org>, <maz@kernel.org>,
	<radu@rendec.net>, <zouyipeng@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<kernel@uniontech.com>
References: <8633w854yk.wl-maz@kernel.org>
 <20260821091720.16665-1-caina@uniontech.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <49ae6e21-2ee3-8dba-f731-7ef17f793dd5@huawei.com>
Date: Sat, 22 Aug 2026 17:55:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260821091720.16665-1-caina@uniontech.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi caina, Marc,

On 2026/8/21 17:17, caina wrote:
> This reverts commit 6be6cba9c4371d27f78d900ccfe34bb880d9ee20.
> 
> Commit 6be6cba9c437 ("irqchip/mbigen: Fix mbigen node address layout")
> appears to cause a regression on Hi1616.

This will break the new hardware :(

Sorry for the incompatible issue, but please wait for a while, Yipeng is
working on this now.

Thanks
Hanjun

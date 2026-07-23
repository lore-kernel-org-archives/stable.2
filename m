Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56E2750FB;
	Thu, 23 Jul 2026 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772320; cv=none; b=YLSYQK7lGiS+d7M3SySz04xLBJ5TR58nyXecFiTUf/lXgTHd5Y7qhQMkNMbNx+Q9jOnOasan4twbrEc/GkPBDrZ02OOp1FLa29OMqqZgC7O8O9fkU51mzvTJ7wac+cieruRL6487e9v5fR3oIYXuO2BRA+nlnLMacbkuio9w/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772320; c=relaxed/simple;
	bh=hzYIGpBXbFZonwDEQCBbDgP46W9DkA6XzZteCy3etkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YtKSvUygg+pu0Wvqd3THT+z/9iMu5TI5enlMZvShqvPFB1fdAR84z5n2c2ft+k2KsSBxuPe2hYv225Z+gh6J3AfOCQe8xJ1jH8GKVlNmziuZVNxxoaHLyqc24u8f17ylQ2c3KQdk1dqRlT5KmExUkzdhtxQ0zUoZhRBq6/cudQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=j21Jbnt7; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="j21Jbnt7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hzYIGpBXbFZonwDEQCBbDgP46W9DkA6XzZteCy3etkg=;
	b=j21Jbnt74JDV9NCT72cBGojfiVTFeBkYsniDEPCn/vszEk51Xxy62OO7uzzzjhsOyN0VBrTjE
	8WcqQwo0IFxJ4fVzYbQHXRU5xLMiXyO2Zu3tLKDghEulrlrN1iV06FDO80v7dkdcDMTNoWTziJL
	2gvYE0V/Eqdn1V3W7kfskB4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h5Djc4m4kz1prlh;
	Thu, 23 Jul 2026 09:55:48 +0800 (CST)
Received: from kwepemo200010.china.huawei.com (unknown [7.202.195.178])
	by mail.maildlp.com (Postfix) with ESMTPS id C98C04057D;
	Thu, 23 Jul 2026 10:05:13 +0800 (CST)
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemo200010.china.huawei.com (7.202.195.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 10:05:12 +0800
Message-ID: <0adae468-745f-4f38-bb1a-151b91bb47dd@huawei.com>
Date: Thu, 23 Jul 2026 10:05:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] mm/memory-failure: fix missing ->mf_stats count
 when hugetlb folio already poisoned
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Sasha Levin <sashal@kernel.org>, Jane Chu <jane.chu@oracle.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>, <david@kernel.org>
References: <20260721121956.124887-1-xiqi2@huawei.com>
 <2026072119-facial-encircle-f1c8@gregkh>
Content-Language: en-GB
From: Qi Xi <xiqi2@huawei.com>
In-Reply-To: <2026072119-facial-encircle-f1c8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo200010.china.huawei.com (7.202.195.178)

You're right, I apologize for the misleading tag. This patch is a
follow-up fix for the defective backport 252bb328b36f — the bug does
not exist on mainline, so it's not a direct backport of any upstream
commit. I'll correct this in the next version.

Also, as in your earlier comment on the v1 thread about needing
maintainer acks — I'll ask for feedback from maintainers first before
sending the next revision.

Thanks,
Qi

On 21/07/2026 22:11, Greg Kroah-Hartman wrote:
> On Tue, Jul 21, 2026 at 08:19:56PM +0800, Qi Xi wrote:
>> [ Upstream commit a148a2040191b12b45b82cb29c281cb3036baf90 ]
> That is not what this commit is :(
>
>

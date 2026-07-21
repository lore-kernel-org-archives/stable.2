Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928436680C;
	Tue, 21 Jul 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640615; cv=none; b=hhrTkaE/x7Qibu4ECMeX6ZBxjNAUvcKquE5E8UXoMe/V94IpdZ8DYr82mskIIDlP020eZOaCNB/HIC+uq9tLYZ3L/U6GOYkQHVqcgeaCmFjjEtL06MfdTLnH1ge5oGfeO41O+lhlrEpxJG0RrfAa74EF8ME9dMiBGF+CNS3aYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640615; c=relaxed/simple;
	bh=LizSE8PjQwP9bFRM6MFQjQlF1mQYaBSLa7F5psPMWLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SMCbm9lR9T7BURuDjYGiaxkFkzsgN4dGrcR9kx6x99baipvY3CHJNyktvSIbeZm3QGslmkC3hB5OFWeOd7mO2OcYBmBnGvR3HKRkNh0dqp+mhoEl6LUyYjYw6nRHI1cP24aEHKfi1dOhaLfHN4F9G92SQXgQQrcpdU/cvVOMM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HEtwQgoq; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HEtwQgoq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LizSE8PjQwP9bFRM6MFQjQlF1mQYaBSLa7F5psPMWLg=;
	b=HEtwQgoqV9Hbu518/n/qfXaRWb1uBnGP0UHH2pS4GO8+ZkhymXIbFgm+CRL7roh9XaD3j6OJY
	GidcLfryRHPKNg0nD00S5/Ocy24D7FVabW5xvSwjutEb0jwHBZb/hGpn9dR7etI7JexX4MjIM48
	nbT8oWoxyjzEdtXQgsr47bo=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h4J0t1VXlz1cyQQ;
	Tue, 21 Jul 2026 21:20:46 +0800 (CST)
Received: from kwepemo200010.china.huawei.com (unknown [7.202.195.178])
	by mail.maildlp.com (Postfix) with ESMTPS id E6F3540572;
	Tue, 21 Jul 2026 21:30:06 +0800 (CST)
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemo200010.china.huawei.com (7.202.195.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 21 Jul 2026 21:30:06 +0800
Message-ID: <95b68d90-19b4-4020-a024-1fac3bc3a608@huawei.com>
Date: Tue, 21 Jul 2026 21:30:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable/linux-6.6.y] mm/memory-failure: fix missing
 ->mf_stats count when hugetlb folio already poisoned
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Naoya Horiguchi <naoya.horiguchi@nec.com>, Andrew Morton
	<akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, Miaohe Lin
	<linmiaohe@huawei.com>, Jane Chu <jane.chu@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <sunnanyong@huawei.com>,
	<wangkefeng.wang@huawei.com>, <stable@vger.kernel.org>
References: <20260706084118.1284271-1-xiqi2@huawei.com>
 <6a756801-f4a5-44a5-abfd-e9ae57432c56@huawei.com>
 <2026072112-lapping-turf-bf90@gregkh>
Content-Language: en-GB
From: Qi Xi <xiqi2@huawei.com>
In-Reply-To: <2026072112-lapping-turf-bf90@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo200010.china.huawei.com (7.202.195.178)


On 21/07/2026 21:06, Greg Kroah-Hartman wrote:
> On Tue, Jul 14, 2026 at 09:45:03AM +0800, Qi Xi wrote:
>> Add stable@ to Cc.
>>
>> On 06/07/2026 16:41, Qi Xi wrote:
>>> When a new subpage is poisoned on a hugetlb folio that has already been
>>> marked hwpoison (MF_HUGETLB_FOLIO_PRE_POISONED), hugetlb_update_hwpoison()
>>> increments num_poisoned_pages directly, but the per-node ->mf_stats is
>>> not updated because this path bypasses action_result(). This leaves the
>>> two accounting counters inconsistent within the hardware memory-failure
>>> path: a new poison event is counted in num_poisoned_pages but not reflected
>>> in the per-node mf_stats.
>>>
>>> In mainline, commit a148a2040191 ("mm/memory-failure: fix missing
>>> ->mf_stats count in hugetlb poison") fixed this by removing the direct
>>> num_poisoned_pages_inc() from the helper and adding action_result() calls
>>> in try_memory_failure_hugetlb() for the already-poisoned cases. The
>>> backport to linux-6.6.y as commit 252bb328b36f ("mm/memory-failure: fix
>>> missing ->mf_stats count in hugetlb poison") applied the refactoring
>>> (naming, constants, switch-case) but omitted the core counting fix,
>>> leaving the inconsistency in place.
>>>
>>> Fix this by adding a matching update_per_node_mf_stats() call alongside
>>> the existing num_poisoned_pages_inc() in the same block, so both counters
>>> stay consistent without restructuring the error path.
>>>
>>> Fixes: 252bb328b36f ("mm/memory-failure: fix missing ->mf_stats count in hugetlb poison")
>>> Signed-off-by: Qi Xi <xiqi2@huawei.com>
> We need acks/reviews by the relevant maintainers before we can accept
> something like this.

Thank you for the feedback. I have resent this patch to
stable@vger.kernel.org with the correct format (including upstream
commit reference and proper stable submission format):

https://lore.kernel.org/stable/20260721121956.124887-1-xiqi2@huawei.com/

I'll also work on getting the required Reviewed-by/Acked-by from
the mm/memory-failure maintainers.

Qi

>
> thanks,
>
> greg k-h
>

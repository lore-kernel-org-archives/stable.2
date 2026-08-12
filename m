Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFD3594A;
	Wed, 12 Aug 2026 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509397; cv=none; b=kLArcFHJydxsLl8SY7Zk4qlFypn7eQMcp7daaymAMOWIkmc9g52xVao5kNJd28Bxfy8OBCn0MWj5qg8ix/b+SgF0i8UZk7MKGEShTjnD4xFEwJ3Q6K4d44wHgm19foetiGv0CIV06lGrW+siIukOVGz2Hzu6tOhGbKoUTTyow4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509397; c=relaxed/simple;
	bh=D3KP4Zd2wMi/UkT6fc88M4LEJfhBc4djsYNCn/S9/cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O10fJq6SHXovLfc6uwT4WaDHzuZvOZSQreYe0zUbqpusiH8Ec1GgtulQSEFZ1AMZ0wf1YHbfMxwEd/JcRGZLfS/6BLlZnzsR+Eoi8y7UnT0OQVDBBcYv9A31aTZvoAFCmJDwm1LlN/xb39G171tYIKfwgrfXhSDgy6dE4zfe8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=h+cZ00si; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="h+cZ00si"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1786509316;
	bh=yn+kbEpOm0vOFVeNwn42hOa6/ynk5LnhCIBEUNmvrTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=h+cZ00sixZ0Blr+4Trt0WL+R0K/ppQdPHaujDx3Ew595nQ/E6dwGGg/PdKI0rQLtn
	 qnlThF+9/Kp2y69tvJB19qy5qBtFz1WMVHk+RElGiMf+XnFHL2nj3+Z6s+zJBRVfS7
	 LgEda0Hb5JxwN0jiFLEaqlBsaXwOYMlOj3S4yzlI=
X-QQ-mid: zesmtpsz4t1786509307tfa430f18
X-QQ-Originating-IP: 03F0sOU7Up1skoBgjoIOVNyl134LTicvsIYlVgvlN9A=
Received: from [127.0.0.1] ( [36.152.24.136])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Aug 2026 12:35:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5932359927016422449
Message-ID: <EB366C0363529CC0+1f720b7e-4256-4523-8e43-f14ace92f200@smail.nju.edu.cn>
Date: Wed, 12 Aug 2026 12:35:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iommufd: Fix NULL pointer deref in
 iommufd_ioas_change_process when racing with iopt_map_file_pages
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kevin.tian@intel.com, jgg@ziepe.ca, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 steven.sistare@oracle.com, stable@vger.kernel.org
References: <7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn>
 <178639198310.282103.12552740515074532170.b4-review@b4>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <178639198310.282103.12552740515074532170.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M5aznPMtO1XHq8fdpu50hOMQaQJNRraLg87OhHKc/Amo5FBnRkZRy3IZ
	zKgKF1ZBdCdRJckHr3pvWf1eMvYUe/LN3FVYqZRFYbZQpK+tAyIzmXGn8nK/MoEIp1mIML4
	doGo2V3ZhnvHlRrqrVe/n5kJtqyk3PDxp/a6N4r1x3Eqib6MqrKR9Xde8F76bjP07I8z0a1
	4Y7qXsXi3u/p7sRcj+kn8f1QPTae+jzvS/wkJSP5Pz5zuXMalLHBWCnp1pPBLEQfXjztjWh
	ScWbRGGhhs+6ner3WKION419sGS7NUx59qTigOY9uP1/N1mLSG+PRZixSX5GX0W7qHCkOEv
	W8X/ndcF805JY2s+b5vCcJuqqCPwxCk4xtIl/2ftmmB9EvMJ56D7NFvJjxVTIeWsjLPHFLa
	a3NumNVmCVy9oYE3PksbUGBDrmfTkRAx1h3gkPm8WtesVqyTOzner/1jEG90VKaT5k3NpaR
	A9nl2UCyTTbP2DtepN/NK4t9KNmagst68YaKnh5FTAMihEzyzbGOfiu3bwVyomABrVl07dH
	0Pfka2KkX2hRFuAPt27vJ7e2dFKZ4/Gdhry53NS0D1QQxNsr1UEgBqZI/Qnvxb9pI06291/
	BwVCeERKQXHp2xFfcwMUzFoPaCnxVUrtdv96v+dLLK9/+gOX4ZV16TqfpRj3cuq3Whccjjs
	B0YFS6t4GFA0hPnVTvSxvljwypCcCkNRr8dTvhK9yne4HXNp3oIzTWcoZN7C7mvuuRXELmk
	8tmAri/vZEg4sBF4r04Dy3nXbaRceirLTcm12EwwINbLQqwo/GD9gQc+mmBojL47ycwIT8J
	flfVNRwDSikNqY4cgyjacPghaqmRKMC4GUBRMxehzerfo069ZDpUBctqfwY5F6xHxLGM5m6
	wQ1litP+zFXrvq271n9fX1jAwudNl+ZDZ4BTjnOGnr6xrDyuJ1Gb/wJYhyQcOqZSENHXcXx
	BXH29iYmwi0EOWd7kCBfR/Goe5KtLmZ0uhjYr1tQkjI04DTFCxbREQywd6UOAAHbpV9QP3x
	Hx/27uuwQI+vLow4zyesv2FfBWIU4kfzWOBEx+mQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Thanks for your reply.

On 2026/8/11 03:59, Jason Gunthorpe wrote:
>> @@ -535,6 +535,10 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
>>  		return rc;
>>  
>>  	for_each_ioas_area(&ioas_list, index, ioas, area)  {
>> +		if (!area->pages) {
>> +			rc = -EBUSY;
>> +			goto out;
>> +		}
>>  		if (area->pages->type != IOPT_ADDRESS_FILE) {
>>  			rc = -EINVAL;
>>  			goto out;
> 
> If we do this then a concurrent map will get corrupted accounting. I think we

From my understanding, if iommufd_ioas_change_process() returns with EBUSY when
detecting a NULL area->pages, later accounting logic in iommufd_ioas_change_process()
won't be executed. I may be missing something, feel free to point it out.

> have to prevent map from progressing too. I belive the issue is we don't take
> enough locks.
> 
> Does this fix it?
> 
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -383,6 +383,7 @@ static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
>  
>         xa_for_each(ioas_list, index, ioas) {
>                 up_write(&ioas->iopt.iova_rwsem);
> +               up_write(&ioas->iopt.devices);

Should this be up_write(&ioas->iopt.domains_rwsem); ? It seems there isn't a devices field
in struct io_pagetable.>                 refcount_dec(&ioas->obj.users);
>         }
>         up_write(&ictx->ioas_creation_lock);
> @@ -422,6 +423,8 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
>                 xa_unlock(&ictx->objects);
>  
>                 ioas = container_of(obj, struct iommufd_ioas, obj);
> +               down_write_nest_lock(&ioas->iopt.devices_rwsem,

Should be down_write_nest_lock(&ioas->iopt.domains_rwsem, as well?> +                                    &ictx->ioas_creation_lock);
>                 down_write_nest_lock(&ioas->iopt.iova_rwsem,
>                                      &ictx->ioas_creation_lock);
> 

Taking domains_rwsem in iommufd_take_all_iova_rwsem() alone may not prevent the NULL pointer deref.
For example:
    change_process: take domains_rwsem for write
    map:            take iova_rwsem for write, insert an area with area->pages == NULL, and release iova_rwsem
    map:            try to take domains_rwsem for read and block
    change_process: take iova_rwsem for write and iterate the area

At this point area->pages is still NULL. iopt_map_pages() takes domains_rwsem only after iopt_alloc_area_pages()
has inserted the NULL area->pages.

Best regards,
Peiyang



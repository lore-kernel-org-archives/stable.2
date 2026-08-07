Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF935F5E7;
	Fri,  7 Aug 2026 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090506; cv=none; b=qxm3t/Wu875pXXJep0rvV7hMa2C5FbqVJrb/FDcIWOXRE1z6mlvB/LyYBxYaSEcWm5vvaVrrngMa7DIIcUOb4/KgReZOEzzrELZbdvwRoupt3QursrMyY2rZuocBfgbjPY65x+9Wxca6dZ711iNGgvl+SqwECiA8H1HbQzZ/0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090506; c=relaxed/simple;
	bh=brtJqvkH5N4l8frB7BEyjaykqG/7eLjdISwdakY1l4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEfgJDVTy4XoyQswAElkap03g/QITjE5z4sSr2wXpuwHaJdpAEnD6H17zVdx50+CnXH8rOMPuAPg0qKyTM2MOFxdL9JwK0+Tq08lnQ/5N/d9lezbXdaQ/IE5q6mRRVQuGwMuMvRLxKhEjeOvBT+yguSRJq2VepbpdcFyOIBV+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=cNNEKHw2; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="cNNEKHw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1786090407;
	bh=jcJWMKs45iuC9FOuQGvmQd2urk2x9JsUlgmj5DWO7oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=cNNEKHw272PCUGMYqvSCSxSeCOZDVQjieMJ0lnkjFLsTHF+P/9hr+DkZrlVAqzITS
	 XdlWP3+KDuQHXK/g9EJ+1hOP7YVuYRdlhWdzKC4Q/mxyroi7Mms2SPpQxF11sr2vD/
	 zRCtqzjGD+MNJf00DDq+gaxEVkN5q9yaBkPmtk7I=
X-QQ-mid: esmtpgz15t1786090398taf656d60
X-QQ-Originating-IP: XQ7nF9XrDIgf//oCekvwRZjPdaB5YnziDad6rEawQ18=
Received: from [127.0.0.1] ( [36.152.24.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Aug 2026 16:13:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10867504456286290398
Message-ID: <960F9D16F8809FAD+f9d9b36b-6f81-4328-b09b-85ccdc760dae@smail.nju.edu.cn>
Date: Fri, 7 Aug 2026 16:13:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iommufd: Fix NULL pointer deref in
 iommufd_ioas_change_process when racing with iopt_map_file_pages
To: Tushar Nimkar <tunimkar@amd.com>, kevin.tian@intel.com, jgg@ziepe.ca,
 joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, steven.sistare@oracle.com, stable@vger.kernel.org
References: <7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn>
 <054a8997-3578-4d8c-9e8f-2556e9999819@amd.com>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <054a8997-3578-4d8c-9e8f-2556e9999819@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OYZhNg8/tnrNjXPCrZ79QQT/maZX1zRvnI/IXsx9GHLClWtLZgaM7iwm
	WAzbHdFFkVMTOWg29Ov9HgSXQiqoB5LH6YGMcIgyBhyXdtGiaFhreti+cT2588w0ehLvg1f
	hcT8rvuT2GJy1vv16PA/2Gx/6q1fRfgAthHsjTes1r7COmJm/VqFkG+H7Nxp5VOriCMPww2
	9X1CROlbW8Ed+8wD6AewE3HyXLOif+G+0ft8K3JEBjOtQK7915ZTQ8GfsgFPa9Z1OQJTyzC
	vr29693j8JdTwMHaVe8oY43AajMrGRmp6Y1rT6m+eYq1HZL9oAqbo0RIbhgrHzbzqSKqp25
	R28AsgKe7SWsQbiF36qxjiiIv0nB9eOCpkQgYYwtU1NozdKtn4UbJlWQS97+jlzejluyvWy
	qN+V7eWAVk6RXyBqimMa94Dg12tsQy5JxExLijAh4/zjSheYVxIz+6XbeOcKQLKDH55CPYY
	NXjs1P16MyevF1mNTpD1HCiIcV7FZOSUfA4KOQLUDKlOSV5a0MG+2jeNZHQGhv3CTCeXJ3D
	GNohYlCLBj5Z8uJkHZZjcqUMqmd7DkWV3CK66dy8lMH7Pxj4Jj4A5q5aMJDi5/p6S7TbpnA
	oG9LjSuXNpVWT8F2kYPPavNl6Gp6y1EFhSlBUOeuNHEoN52kQaCX3Px5zLlrj5ZDTi+jfVS
	JpxoxlB6cAmlL93lgYQpjLVGysJFBFHi4dC2hGdhweZJIouxtpohw/CXOX0N8l8cIJOAX2X
	Y/ufDYFKpXJlbVM2MpM0+x3WdZicPEGScAlsBRCtDxGlP7iLoISGDS18qY1sBW/2RWhX0bf
	N7NAXSJTEhzXC/EPeDlWGCkd66CBDqvJAjLSuldmbW6PIAxkWR1rYpn/uuAI2zApR3l9mOg
	U8ixn4maXb1GU2cwCjmTk39Ww1hiT/Tu8IZPyTbJbGFWE8jf6KcCWx+MLJLY15rXAH/p2Z8
	PJHXR4qeDFe7QUrF8tm7JkbEQurSbepPCLjQB9zAnK9CRN6K4xQ1fHJx5musip4JhO5UPr0
	4K4vXglsqhbq9owBZwKirwlnNv3hPzHcKVflUYMsUZfXjd6/5YIcE+BcpBnHI0wvTdSbZUT
	1B19LA/Jqy12JN3b4d4JQzBksFlzBPyWeq3bX4BGx8ONgRs2oPS6pfzt5aY3DulKQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Thanks for your reply!

On 2026/8/7 13:36, Tushar Nimkar wrote:
> Hey curious to know,
> 
> On 8/6/2026 10:20 AM, Peiyang He wrote:
>> [You don't often get email from peiyang_he@smail.nju.edu.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> iommufd_ioas_change_process() iterates every IOAS area while only
>> holding every IOAS iova_rwsem, so it assumes every area has a non-NULL
>> pages pointer. That assumption can be false when it runs concurrently
>> with iopt_map_file_pages().
>>
>> iopt_map_pages() executes in two phases. It first creates the area and
>> inserts it into the interval tree under iova_rwsem, with area->pages
>> still NULL. It then drops iova_rwsem and later fills area->pages
>> under domains_rwsem. This leaves a window between area creation and
>> area->pages fill where a concurrent iommufd_ioas_change_process()
>> can observe the area and dereference a NULL area->pages pointer,
>> leading to a NULL pointer dereference:
> AFAIU, the flow must be
> 
> iopt_map_file_pages()
>         ->iopt_map_common()
>             ->iopt_map_pages() <- here it does create and write pages ..
> 
> 
> iommufd_ioas_change_process() <-the page pointer is being accessed..
> 
> 1. Why IOCTL got triggered before setting the respective functionality ?
> 
This bug was triggered during Syzkaller fuzzing, so iopt_map_file_pages() and iommufd_ioas_change_process()
can run concurrently. A normal user may not issue any IOCTL before setting the respective functionality.

> 2. Since here unlocked_ioctl() used which means driver should have manage locking as user space will not hold global Big Kernel Lock  (BKL).
>      We have pages->mutex - do you think we need it some where instead of "-EBUSY" return ? - if yes can you try and repro ?
> 
> snip:
>  *
>  * The locking order is domains_rwsem -> iova_rwsem -> pages::mutex
>  */
> struct io_pagetable {
> 
> ---
> 
>         down_read(&iopt->domains_rwsem);
>         rc = iopt_fill_domains_pages(pages_list);
>         if (rc)
>                 goto out_unlock_domains;
> 
>         down_write(&iopt->iova_rwsem);
>         list_for_each_entry(elm, pages_list, next) {
>                 /*
>                  * area->pages must be set inside the domains_rwsem to ensure
>                  * any newly added domains will get filled. Moves the reference
>                  * in from the list.
>                  */
>                 elm->area->pages = elm->pages;   <- maybe page mutex to protect this ?
>                 elm->pages = NULL;
>                 elm->area = NULL;
>         }
>         up_write(&iopt->iova_rwsem);
> out_unlock_domains:
>         up_read(&iopt->domains_rwsem);
>         return rc;
> 
Using pages->mutex would not work here. If area->pages is NULL, then there is no iopt_pages from which
iommufd_ioas_change_process() could obtain the mutex. 
And access to area->pages is already serialized by iova_rwsem; the problem is that iopt_map_pages()
intentionally leaves a window where the area has been inserted but area->pages is still NULL.> 
> Thanks,
> 
> Tushar Nimkar
> 

Best,
Peiyang



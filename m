Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB32DAFBB;
	Sat, 18 Jul 2026 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784350598; cv=none; b=ifwT+WHBJisbkPSg0RYIK1kNzDpBIyuiJ7KH3F3BQFVIaY34GWmhcDNW8/bKC8VhXQVi0hyeLybkaF9Sfnmud+tW9GsNKxqSaX6CWGIF2RAnNC+D9ohFx2bJgxMS963EZG0KTRaZa8r/toUplvsXNeW0A63LVDlHPSJSNCjzy7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784350598; c=relaxed/simple;
	bh=43j02/lHfdIU9W1w14GAjkVTT7/TUiKZk5i8QdLvw6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvKumoNTaVAHYCIZeEm3P2r7N+r6IXZxOX84yD+7lIbFc2mZLob2dazzBvc/5Xkla+3rRoBvBaL8+hvr8pVdV6y8tUCuJDGSTzSsWDlbG23KJL1K/WxkqCQBGoZrR3jvZmhE8imAh4eNuqEhHiTWbxfTW7oA4BPxsFxfCe1est4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=NUmhS8Z1; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="NUmhS8Z1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1784350526;
	bh=Q/pyZY0DdHNUC4u3NjOVXwZgQU9zqflnqZH/B/PFBV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NUmhS8Z1KjIO54y+5hWyizw3IATtUc6C+7RTD9QLVGRujdTnDGLoflbe4z+KK6+pJ
	 wKJnpTX8YDf4qqNkYmT4WIlLptHNCfLoDJXl6U8L1IiMcXQg9AdBF1QR04xN9M6m42
	 uqfCs1qpSY8Z2XDeuQWdrexNeiAaIyoeIJIiOz7s=
X-QQ-mid: esmtpgz14t1784350518te0b5efe8
X-QQ-Originating-IP: ZXM8ov0nZslofLfrmJw4Lk4AcNaqjgEVt+WRQllxOiQ=
Received: from [127.0.0.1] ( [36.152.24.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 18 Jul 2026 12:55:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7271053026370203753
Message-ID: <FCE172839ADB7A63+1133eef1-621d-4d73-ae86-f5039b6673ee@smail.nju.edu.cn>
Date: Sat, 18 Jul 2026 12:55:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iommufd: Fix IOPF group ownership UAF
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
References: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
 <9BE255A7A4AB5AAA+20260715042421.3148159-1-peiyang_he@smail.nju.edu.cn>
 <SA2PR11MB484486F27784FF0AA0C2D7858CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <SA2PR11MB484486F27784FF0AA0C2D7858CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NzOHSugmTg7XGPPDjG7j/6TlXNj2kVZ0pwrm/CxNsaRkItG/QHvo/0u/
	xdWutc/rcqcFeJWiCbc2J20+q+JR/714qn4iSA12Eh5CuU9SmGfBa6vFSU7lmN3QHQvL3mD
	CLAoPeVW/VCjuGxIYt+Oq91qtbKpUdwsjia9AByGvX6Tz5URsNNCVD1+cpDwaVCyfzGmHnH
	cD1yupOUDL75i2hcNfpJThpLZhSGN4QF/17AVo/Bp253qXyt6YFIBWGFVLGajnrtPro8Tno
	K2GO76uTJv+JqV5f8DxFlrXn5szZmhqqfi4sVKlh13w72Vd+crAf6YL+SzXYSEOP5cRZpsb
	MDPWiLAcIKOyOvgj7KSlXyUiiIefAgu62vqC2306lXk1pfW3HCF9E8wH9bCWpwLCzblkZZw
	jyGgPDTN6C9FRUK6um1wVjfLYDrqsWGP8N6DjVglxAeB4/9dQwzEu16o6nzFg3GxK4DuKKB
	QoprNtTiuIt/puPmet2npFtyHtHQj4zIoodzElEhRnpJE5CLbglaIbEl6AXC6URij0m0qg5
	1IuqFjIextrSRVSk06mdHjcg+kv7LBmMDTikDvzc5SDWWDlpFq/7/+WSjK23YOKWKReZbkI
	jihNIopdYLM8T601LTKGh34gcxuiUwVPUbVrXwdSbULNGU5w/NGfOjLnYHLyh/7p6spMMc/
	ep7vOL8MfPSR8kyjnPiOmygEek7UeFvkALlgGHY6JDJ3T8pNJHzhptWlZPEnaJICHvVMb/6
	++y/dJIctYTh84UYAsa9TVQEDlySRTK//herNphTKSHUu/L1wWBTfviqdASyzoHxY7YAw8D
	xc+dStLZLi7yAmA0ZGYYxC8E/38BJJlI+jOTYmsIXCfO14r/zvm529VcYDCoWapc1ZSWgNq
	wpgXgsJ4ctkyomyU/HGIYeDUONyrYYJTda2ZHjHTW8+gcD1YC5O2HDRqF2RxvY0nC/o3Bl+
	1U/l8S2WlIitbd5+84kjWIdPVYZ68lf/ZA/sB4/oV8x6ULeWbhDgnEARe5zmc1q00IwkYOg
	t+0+sXNeQlA42CLFWeosXiJZ/AJwtxAGFLkU3u1a6JvAA6z/EZ
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

On 2026/7/17 16:00, Tian, Kevin wrote:
>> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Sent: Wednesday, July 15, 2026 12:24 PM
>>
>> iopf_group_alloc() links each last-page IOPF group into the generic IOPF
>> pending list before invoking the domain fault handler.
>> iommufd_fault_iopf_handler() also queued an accepted group in the
>> IOMMUFD deliver list without removing it from the generic pending list.
>>
>> When detach or HWPT replacement drops the device's IOPF reference count
>> to zero, an IOMMU driver may call iopf_queue_remove_device(). That
>> function responds to and frees groups through the generic pending list
>> without removing the same groups from IOMMUFD's deliver list or response
>> xarray. A later read, response, or cleanup can then access the freed
>> group and cause a UAF.
>>
>> Fix this by separating response state from generic ownership.
>> Add iopf_group::response_pending to track whether a device response
>> is still owed, independently of generic pending-list membership,
>> and update that state under iommu_fault_param::lock in a helper.
>> Before publishing an accepted group to the IOMMUFD deliver list, call
>> iopf_group_take_ownership() to remove it from the generic pending list.
>> IOMMUFD then becomes the sole owner responsible for responding to and
>> freeing the group.
> 
> this is ok but could be simplified.
> 
> There is no use case in which we allow a group staying in the pending
> list after its response has been sent. Actually every iopf_group_response()
> is followed by iopf_free_group().
> 
> so let's just remove the list_empty() check in iopf_group_response().
> 
> better - move iopf_free_group() into iopf_group_response() (with a special
> handling in err unwinding of iommu_report_device_fault()).
> 
>> +/**
>> + * iopf_group_take_ownership - Take ownership of a group of page faults
>> + * @group: the group of faults whose ownership is transferred to the fault
>> handler
>> + *
>> + * Remove the group from the generic IOPF pending list. The fault handler is
>> + * responsible for responding to and freeing the group after this returns.
>> + */
>> +void iopf_group_take_ownership(struct iopf_group *group)
> 
> iopf_group_dequeue()
> 
>> @@ -582,7 +582,7 @@ static int iommufd_hwpt_replace_device(struct
>> iommufd_device *idev,
>>  	if (rc)
>>  		goto out_free_handle;
>>
>> -	iommufd_auto_response_faults(hwpt, old_handle);
>> +	iommufd_auto_response_faults(old, old_handle);
> 
> this belongs to another patch already queued by Jason.
> 

Hi Kevin,

v2 patch has addressed all these issues and passed my PoC. Thanks for your feedback!

Best,
Peiyang



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A022689C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027352; cv=none; b=QZApNs036V0inZlgbfa8PFggdg0UP8cksBHOkfQjsmsZyqIljWWEm7PxgiwHt5Yx+zkPHOKnpp6LAm1DJEgoa9973a7WO9UKBvYjou+zV4AfgrKkn3D/DXGZH2gqpU2uNPcvj7wF/9aMUIKf3MwOQ1H+U1SxrLFbb0JPTnWRQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027352; c=relaxed/simple;
	bh=AiKZOoqsdhscH3X5tTSOs7l/4l41JC6Fbu7L1hSJE/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGScemHV0meVrlr44mvLi2Hy38gQEtjJqiUn1ymxVuJhrMDoe+kN4d4E7nTKYDHAnS5pNaB7w7W9ownjMJtkwAxZTZ+KU7SkrugMUkBaK0BECNoR3tuwGrLZPkpWG0CtLR0ONmtss/zxRdgyFvZJsluuh/xgH5n4gQQy6lrnwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6wFlEz7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkuNVtRc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6wFlEz7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkuNVtRc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y8GfkU9TTPckwMBwt43hPKDhEB5BQFXtyP1DfYP8FF4=;
	b=K6wFlEz7STk1/cLfFKnA6JsVnWol0PJiaFedMnzifmn483wCxzwSsbL/hpRkbnUBOU42Cf
	NpLy7IQ+BBTa6r7XlAdlbu6nmfJWeHoTzlHbSKtL4zxpukx0AwetNpnltY2HxYGBui6CrY
	AvpRDNzomZ+0FmaFHp1T4iekQzOfLeQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-zSQk6oJ1N6STS4OvCCkqRg-1; Thu, 06 Aug 2026 10:42:22 -0400
X-MC-Unique: zSQk6oJ1N6STS4OvCCkqRg-1
X-Mimecast-MFC-AGG-ID: zSQk6oJ1N6STS4OvCCkqRg_1786027341
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15c6a68406so158352666b.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786027341; x=1786632141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y8GfkU9TTPckwMBwt43hPKDhEB5BQFXtyP1DfYP8FF4=;
        b=IkuNVtRcgcvEMxhC+7f/uCs/CWTyaTD9qPPc+nJaYwpNq6xaiHlOzT1EVBJEIC/oFi
         R+nB9CY7i07JQb6wWPSoNUTORXFIqriZtr03UWnF4Sz2rlyVQLIApWyvTDUhQaJLxWoA
         GTNlEJqhPutmF1rA0VR7dGwuj5FLMYRwi2pvjExp5NkK4n9RVEdrvuBOQIBvo2bFlSoR
         ySq2Qc2J1sxKEaAh2+dsHL4tuM6Uj/iMk4uCOI9HyiO+ILH9gOSIDDZu2P73f+sbPrXS
         BkvzKvmT5aKc4sf26RRlx8krP/R78un594x4BgICnXoEJJ3RzQQ+U2I2YftVO0VVn8kj
         t/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027341; x=1786632141;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y8GfkU9TTPckwMBwt43hPKDhEB5BQFXtyP1DfYP8FF4=;
        b=lweHmPo8lqY45OnWf1gxh79crk9fLMr7AsmCxkNkIKp1khycXZDrtnkrLnPggG0E7e
         WDXpJLbMehd0ndsVX1XPUG4dasOhMU2OGT2V8voe257Od73pfs9AiBUKwKp0yUuXmgbR
         XZIXo/TF41Viw4ZUpVU359nUd9yFFyP5TXaRZjO6eiSVWmVpPsjMNWZtHXIkLSyGNtZg
         xbTFesqHPIgzzTWTEoHAho3W3K7Tu+YZAgl9Qg4shdmKVJy78wAkZ/v66gBl/wubU3pZ
         o4r1v9YzSsYEHs0c3H7HL5rf9rBYoHoKJQQR0ExZdT+RveJFy+eXNk3zTSc9JCmTOLX2
         dajg==
X-Forwarded-Encrypted: i=1; AHgh+RqDsafi2i5whUuZsSsIWvv01NSOzUAPjyfUsPW1F8pUfnR66JNxmVJKUmyn3duLZ9lwPv5DflM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypK1e97wvGItBw0tNsP0mWIYUfCoddhp7lohFJuWznyDfGRxLl
	gpsEehBXimaqwU2BtFH304Y9t2xnUR5aG7uW9NGEnnbiUCbYEQRl16Jsq2vXXPy/TRAtTLsVLw2
	/K4D3XHd8VhT6RP0nvMrtjM8U1xa70brkfjP4uqcpAT2c3pRZAkJMO6XJ7A==
X-Gm-Gg: AR+sD13XDaLZpYz1TFvhbijbVlAcdT7mEYgfk+JgpjEITKP8BF47hS02zusc2BOEjkK
	/bujugpZvShY6kIGYVvAmhfgVLYxphmw18P8ECrELlTCfYh9vL+5Q1joEUotVD5jggBMyiqlPSF
	SaruEYUemzHiiRzcBtvbd4WX782R4/J2htTIfMNamE2by/wlgaHy3Cyx0e4Kywg5brWu7DjTpmV
	o0WHcmUHFhB3eWtEuIwgiG0taHovb4eumZLISQzCy1GuexT2mhEVZt605A0Cf6UU6qMcFSOW0nM
	XgA787tA7bIEUGPEWgFX1aksCB5wendenttp7rSUFFUwd/AXSajU69UKnfm+UWlvFVHZUWgxqGP
	r0IfR+m0cBv0QHLb8KDWe9pk2ctxodN3o5jXVBb0=
X-Received: by 2002:a17:906:d181:b0:c16:1a00:3feb with SMTP id a640c23a62f3a-c2073365229mr81915266b.15.1786027340798;
        Thu, 06 Aug 2026 07:42:20 -0700 (PDT)
X-Received: by 2002:a17:906:d181:b0:c16:1a00:3feb with SMTP id a640c23a62f3a-c2073365229mr81911266b.15.1786027340246;
        Thu, 06 Aug 2026 07:42:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20361312eesm272059666b.4.2026.08.06.07.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 07:42:19 -0700 (PDT)
Message-ID: <5b7e84f5-2007-458c-910f-7a6e1e3d3eab@redhat.com>
Date: Thu, 6 Aug 2026 16:42:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805055544.1568534-1-clg@redhat.com>
 <0e52d0b4-064d-4602-8e7b-5744b05f24ea@kernel.org> <anSZpAjt84Pn7O_b@lucifer>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <anSZpAjt84Pn7O_b@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/26 16:28, Lorenzo Stoakes (ARM) wrote:
> On Thu, Aug 06, 2026 at 04:26:20PM +0200, David Hildenbrand (Arm) wrote:
>> On 8/5/26 07:55, Cédric Le Goater wrote:
>>> From: Cedric Le Goater <clg@redhat.com>
>>>
>>> The global THP sysfs policy (transparent_hugepage=never/madvise/always)
>>> gates the huge fault dispatch path in __thp_vma_allowable_orders() for
>>> all non-anonymous VMAs, including PFN-mapped device BARs (VM_PFNMAP).
>>>
>>> DAX VMAs already bypass this check via an early return:
>>>
>>> 	if (vma_is_dax(vma))
>>> 		return in_pf ? orders : 0;
>>>
>>> But "special huge" VMAs -- identified by vma_is_special_huge() -- do not
>>> get this early return, even though they share the same fundamental
>>> property: they map physical addresses directly into page tables and
>>> involve no memory allocation, no compaction, no splitting, and no
>>> reclaim. The THP policy has no meaningful effect on them.
>>>
>>> This matters for VFIO PCI passthrough of large-BAR devices such as
>>> NVIDIA H200 NVL GPUs (256 GB BAR each). The VFIO driver registers a
>>> .huge_fault handler (vfio_pci_mmap_huge_fault) that dispatches to
>>> vmf_insert_pfn_pmd/pud, and QEMU's vfio_region_mmap() aligns the BAR
>>> mappings for huge page table entries. Both prerequisites are met, but
>>> with THP=never or THP=madvise, __thp_vma_allowable_orders() returns 0
>>> before reaching the "trust huge_fault handlers" code.
>>>
>>> The result: each 256 GB BAR is mapped at 4 KiB granularity -- 67 million
>>> page faults per GPU instead of a few thousand PMD/PUD faults. On hosts
>>> with 8 GPUs (2 TB of BAR space), this causes VM boot times to degrade
>>> severely, with 99.98% of CPU time spent in the VFIO BAR mapping path.
>>>
>>> Configurations that trigger this:
>>>    - transparent_hugepage=never on the kernel command line
>>>    - The tuned cpu-partitioning profile (inherits network-latency, which
>>>      sets transparent_hugepages=never via sysfs)
>>>    - transparent_hugepage=madvise (the RHEL default), since VFIO VMAs
>>>      lack VM_HUGEPAGE and QEMU does not call madvise(MADV_HUGEPAGE) on
>>>      BAR mmap regions
>>>
>>> Extend the existing DAX early return to also cover vma_is_special_huge()
>>> VMAs. This is consistent with how vma_is_special_huge() is already
>>> treated for supported_orders (grouped with DAX). The mm/Kconfig TODO
>>> comment "Allow to be enabled without THP" also acknowledges this
>>> coupling is wrong.
>>>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>>> Cc: David Hildenbrand <david@kernel.org>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Fixes: 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: Claude:claude-opus-4
>>> Signed-off-by: Cedric Le Goater <clg@redhat.com>
>>> ---
>>>   mm/huge_memory.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 58cabe6af33d031e48250e21db51506bc46c97b2..6dfef5500a054f09f9ece6df8bf7a0194624350f 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -139,8 +139,12 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>   	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_collapse))
>>>   		return 0;
>>>
>>> -	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>>> -	if (vma_is_dax(vma))
>>> +	/*
>>> +	 * khugepaged doesn't collapse DAX or special huge VMAs, but page
>>> +	 * fault is fine. These map physical addresses directly — the THP
>>> +	 * policy is irrelevant for them.
>>
>> emdash in a code comment?

There are quite a few of these in the code in fact.

>> Then I spot
>>
>> 	Assisted-by: Claude:claude-opus-4
>>
>> and really have to shake my head.

It's a one liner. Good enough to raise the discussion no ?

> Ha, I missed that!

Me too. But, you have more to add to it anyway. It should be dropped.

> Well all the more reason for me to take over this patch... :)
> 
> At least the AI is acked here (appreciate that at least Cedric).

Yeah. Let's be honest. Even if I understand what is going on, Claude was
faster at digging through the code and connecting the dots than I would
have been on my own.

The AI behemoth dropped my accent though. Cédric it should have been.
I wonder why.

> I think the _actual issue_ is valid at least. The huge pfn stuff did seem to
> completely miss this aspect of things.

It's a real problem indeed and to cover mix of workloads, it it difficult
to address without a kernel patch.

Cheers,

C.


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515676;
	b=39qdZvw1jf1I1QCTWnaenk0NLMF3iSGfc7YJIHsZHtrmlyJ/xOSR8fn3fADBdWkzyGVF
	 AHyIwqBkZCb92PP9haS8SzQLBa0uMZ4d36VFyVLFmQswkikDNbcDM6ZdNe6HziaPH8Be8
	 +xxiFMDgy/GFrI7YkhqQaTbQKEFjFPMI7KUF4OdS7jruKhCxneUb4FWHx05piAAOJpisq
	 BE1/SbR+4SrHS0YQV2qMM2zP6vAJ+1pJe94Gb8vKp8AZI38puT5d+ig85C4N/7d9D4zAx
	 13D8PZ3mqP4LbZfFDw0St+TXm6ymdPEiZF0X1vUnHLvSmM+moipBpoL7PH2h4+eeL8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515676;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3UDBONxAV7qAC85Qus8YvVWo/gg/JNgcRtoVu7utDiA=;
	b=SP8csAewwNeYCKisElPzpuyI/RBLjHGd1YQSBUmMQBhsFps26K2FZVJ+LBZlQKc8onNZ
	 dNsADA6Csf2SigmetkzY52TFX/FA4+04Fs7onXmoTV17sDZnjFlCtDRPXO0L6ErditOck
	 CxhnMBdceQkdsRWUwYIQXQIykrKwfuKhZvMS3dMCqRE8FXSwsL4Mrdk3a3VUR6xajFV1I
	 zSFZj/lbRI1HuPhfQeGSwyAsUcW3t3MwKzp4bp+TCjPtOAc2CFDYlnjvj/Qn6Q4Va64sg
	 vJ+Lm5NNlV8y+WHc+mBI6ly0BmfzTph1YBzrPWdTZILBHifMBSj5T/NC1zSnHH8qsXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hzeiUTXR;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92746606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92746606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hzeiUTXR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794515674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UDBONxAV7qAC85Qus8YvVWo/gg/JNgcRtoVu7utDiA=;
	b=hzeiUTXRb0e4hfZvBEU09aaB49xDmnrouxEhUKJhcAOYM9KFW9pvv2WvWww8Fbxl+PDAcq
	neQWV5EAdu4KYDfGr89McJRJYCQrpuG1+7ZrfBAIQ5XOZJU1ItJJGsYfQHuhCr/Thixc2A
	xjzs489L6Bk5QcHwyD58TQ2EE5PDySI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Fbz9Z9LUPleg-dMrU4sOfg-1; Thu, 12 Nov 2026 15:34:33 -0500
X-MC-Unique: Fbz9Z9LUPleg-dMrU4sOfg-1
X-Mimecast-MFC-AGG-ID: Fbz9Z9LUPleg-dMrU4sOfg_1794515673
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f6f4fe531so29362785a.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515673; x=1795120473;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3UDBONxAV7qAC85Qus8YvVWo/gg/JNgcRtoVu7utDiA=;
        b=1BQi/szxfcpEGsae7t9pl22A40c5vJO0BMuXmX9DtCJNj6TGGlKTeo6oKi3Jgc2kBe
         lEZQIAIU45Xsk6rAlBqsfjsLclcl5p+nZbtPFPH1ccKUdx+SSn+Z3HGpRarnSl5O6jtL
         xWMji+Zqep/LS227Zh0lWSvAToMjbTjb3bPzgdK58JT1rzgtG1vbS1d0FLeez+qUKbLI
         yThdLq1db7p7GTK1IEanZwCNwSasAuPLue6hErYO1u19+tjBA/Gxhm9rrndgrlviBAgR
         c3Nf7iO0f+pcPYxPAtS1UTUGveHnA+9MtDuOhOuExhz1lCtZy4YqHcHGXFVD2NjSy0ng
         7pAA==
X-Forwarded-Encrypted: i=1; AL+hErE26vNPPEMhJq5kKmrbOBaqz5wuVIhGVrx1fpIWCQe5RHFf699qKTQEtA2ussXxMWN/c+1oJ8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uMSr0cE88uVpDE5Fm205qZ2KNBdDSXsRm9/qfPKSQN6GsPvWx
	amlOoL8yj6PJp8D2T7B5AuhQm6bS7CBISTUTPPLdqNp7BvJ+r41qiygbdQDsQ8ps7WCyPtgw/s4
	pGOBAmPOv74oW96LNQ42S8K0sfgJ5mncR0sPb9W7PdkhuXbMRmFI+BHtOyw==
X-Gm-Gg: AYBFou1hZzHrmsCrOULRpxcGsWHBPKcYF7brjw76tlvKz8RTxPNTYfHABNNRox3GSWz
	OyH2yjr8R/yEL2Q+b7U3vcd5Hh1b9E8006BxksMBtj7+NLWQChGSk6sgcxrqXP23UjNsNUF88/e
	6ljqogOBmPS3ZOHcaXS70ZUraDhUgjU3CZbKtJEeL7L6O52ycMA9EE4T9g26O0+TSLrc4wlnspS
	P/76JNvLzupWhmHYbOC5c3mD1lX5aOurBzh16t0awZg6Y0EyFap/oRBT3Ix3gBsN2wbqvyqZqjV
	mjda1kd7yE0OG9t/jrulQHwqHREn6duudBimqHo7Xh1iTlH57Zal4tmBT5PUsSkq+5OsROGrP1R
	e7qjA+fdUgNT9GUZpr4vK5NMYoZwVowMSuuW/ZHNJ3eJiY88gkmjljFmv8XLJJu/pYub0kbonVR
	863xkXmGW0umPqgylFw3ZtxXhtcTzJRBepCYJDHyVUXA==
X-Received: by 2002:a05:620a:2b41:b0:93f:2985:40d0 with SMTP id af79cd13be357-9494bb5009emr100646985a.34.1794515672725;
        Thu, 12 Nov 2026 12:34:32 -0800 (PST)
X-Received: by 2002:a05:620a:2b41:b0:93f:2985:40d0 with SMTP id af79cd13be357-9494bb5009emr100642585a.34.1794515672205;
        Thu, 12 Nov 2026 12:34:32 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0107w-grc-07-174-93-165-160.dsl.bell.ca. [174.93.165.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c898badsm21287785a.30.2026.11.12.12.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:34:31 -0800 (PST)
Message-ID: <573db8ce-225e-4da4-a196-14759f4a174f@redhat.com>
Date: Thu, 12 Nov 2026 15:34:31 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, "Liam R. Howlett" <liam@infradead.org>,
 Jann Horn <jannh@google.com>, =?UTF-8?Q?Jakub_Mat=C4=9Bna?=
 <matenajakub@gmail.com>
References: <20261109201217-failed-6.6-8146c6478224@kernel.org>
 <20261112034659.1574521-1-sashal@kernel.org>
Content-Language: en-US
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20261112034659.1574521-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/26 10:47 PM, Sasha Levin wrote:
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> 
> [ Upstream commit 8146c6478224d8f6395c6b08a19c344a56d79867 ]
> 
> Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
> merging with expansion of mremap()'d VMAs, however it also unintentionally
> disallowed the expansion of unmergeable VMAs.
> 
> Previously it was possible to expand a mixed mapping which mremap() had
> already ensured was a legal expansion.
> 
> This is clearly seen in the mremap() logic, as it checks
> vma_is_fixed_mapping() to determine legality of an expansion rather than
> vma_can_merge().
> 
> Additionally, copy_vma() allows for a failed merge to result in a new VMA
> being instantiated if MREMAP_MAYMOVE is specified.
> 
> However, this is not attempted, as a failure in vma_merge_extend() is
> assumed to be an -ENOMEM failure.
> 
> Since vma_merge_extend() is used exclusively by mremap() to perform a merge
> and/or expansion, resolve the issue by invoking vma_expand() for
> unmergeable VMAs there.
> 
> Explicitly assert that the VMA is both non-fixed and a mixed mapping.
> This provides double insurance against broken changes in future.
> 
> Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
> redundant in this case, as a mixed mapping is not subject to khugepaged.
> 
> Also update the VMA userland tests to add a required predicate.
> 
> Link: https://lore.kernel.org/20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org
> Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jakub Matěna <matenajakub@gmail.com>
> Cc: <stable@vger.kernel.org>
> [ sashal: Adapted vma_merge_extend() changes to the inline mremap() implementation using the older vma_expand() interface. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I tested this against the in-tree reproducer and ran the MM kselftests
(which I had to hack to build). All is good:

Tested-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   mm/mremap.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 0739a31b54eed..a37bcfda29261 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1120,10 +1120,21 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>   			 * the next vma if it becomes adjacent to the expanded
>   			 * vma and  otherwise compatible.
>   			 */
> -			vma = vma_merge(&vmi, mm, vma, extension_start,
> -				extension_end, vma->vm_flags, vma->anon_vma,
> -				vma->vm_file, extension_pgoff, vma_policy(vma),
> -				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +			if (!(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND |
> +					      VM_MIXEDMAP))) {
> +				vma = vma_merge(&vmi, mm, vma, extension_start,
> +					extension_end, vma->vm_flags, vma->anon_vma,
> +					vma->vm_file, extension_pgoff, vma_policy(vma),
> +					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +			} else {
> +				/* Mixed mappings are permitted to be expanded, not merged. */
> +				VM_WARN_ON_ONCE(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND));
> +				VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
> +				vma_prev(&vmi); /* Reposition to start of VMA. */
> +				if (vma_expand(&vmi, vma, vma->vm_start,
> +					       extension_end, vma->vm_pgoff, NULL))
> +					vma = NULL;
> +			}
>   			if (!vma) {
>   				vm_unacct_memory(pages);
>   				ret = -ENOMEM;


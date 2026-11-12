Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515863;
	b=DSSopOrYsl+ofXHX7LrDgbw0UrXX08Au4NNqoANB0QwoJlHScuMXyhgy5ppRYkgs4Lwl
	 40HMQdMuFJTybZEKv010tL92KvnUQdRQeZB2r42AgDQyngqsifWHJQTR+jKQBrKtUxeob
	 o4Nmx+XaMa3cnBPs15NZqipX4L/eRCw9QUKPsRzr57jPlNKqEuYG+kXAMkTxI5/a77Ju8
	 6KVv1Clf80AExLCLUyo/NW6i6cV7xudmnKHMu1BIbx2sy8t5vjUQaVa3kwHf1rKr+Iko/
	 J0176/GAF4TrELPFcTZAtIkU25wZERamV7dyR/XvfkdibSk4PvX6GFPtEtVLlL+mn3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515863;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qJEbBwuPCaVa0YdSzCIL/hLyey2Fcrr739CkxCwTBPQ=;
	b=FRvOWfm0Wm1aPs1zRjj2TQAhV7WR6DDGoQuXkOXtQQNtKHQrGLOTDV7FYnxtW0DhxKmk
	 PeRWNqRe6OTyGZ3z66Aym0ow/nwO+jj/IZy/A+1IoE+6c9v/7crCsISqawXNCxh6I8zDi
	 UOKh0T7z14ei45GuBPjdLj/wmAjKxfA3AAxDQHd6vxFjRhRuhfpfsO0XjHD5CBb/FYacT
	 sMH4plOkozkB34LYE+i4NtQGxqEx1WlnG9Hl6aoO1sr4w1bOsmKNoJ7rJyM8MpzXJwLbG
	 dQXIpetVHPHNFqevVtod+GdqOnmQdT0g8NxSaka6z5gcoiU/qO7qg1kSSnlkYUquc0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cEqx9nB+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAE6606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CAE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cEqx9nB+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794515862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJEbBwuPCaVa0YdSzCIL/hLyey2Fcrr739CkxCwTBPQ=;
	b=cEqx9nB+0L3rYGjzRm2gTsVxw6wuHrR4n3l8j9nKmRHdBimrlAmTudzEoxLdxn9V2W6468
	yXhjSxfWN3XPNjuSHYju+yQLQWachbDNbLb3NwrNoW9W3vmEvxNpP0pMBin5KzmCF3Zktd
	6OpkQ3Ps2Ab91oMt9thQ0HGGVXC/baU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-DUYT0iVDOPGHZV6EEPvobg-1; Thu, 12 Nov 2026 15:37:40 -0500
X-MC-Unique: DUYT0iVDOPGHZV6EEPvobg-1
X-Mimecast-MFC-AGG-ID: DUYT0iVDOPGHZV6EEPvobg_1794515860
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91ea4a2210fso3426746d6.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515860; x=1795120660;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJEbBwuPCaVa0YdSzCIL/hLyey2Fcrr739CkxCwTBPQ=;
        b=hcra6lsY/i6duAi6FRPxA+ko2YRQ7rNwyz5qsXLSBOG2j7nMp1GXzY/m1AG8xsXGou
         tOdcNmSk5uTZFvcdJbisW+nNU4LeW9WfIhrohf+cG1a4/FX1+g2z7t2VEGJNXG26yq1D
         f+ZDTCnRga5jPgvCgspbXjQNT5R6RiduxIUMLnIt3IrlEg2zowivZFRmx3JdJyLC2Xos
         XANwBIM1x/b3ZvA1i3NAfTt6USdECe0tAoka6iCwPMXqpxdENd65NbLkXplYJazYDzL/
         XFxHEL8qGHh5bEQJrLS6vQ48gTw/kISPmyFsuDfIHTnfSCfaxlPNk0OyLBuAlFKrv1q1
         kvvQ==
X-Forwarded-Encrypted: i=1; AL+hErHro4zc6E7KVzdwIWHGwRiXN5v0S5ZyLYgP+ujuzjz0/Yi+sCoLEzfv9rB1IOuPUOoW0m3wGq8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9nLQ4JOoJmz9/D4o3vUCob0L3DpuSdIl4SA+ln3Gi3230tX5U
	XBRv6IUpPlw4y5icK/5OL0WOjx1LH+PR3uE8lxUZpy3yQ4FL66+8TSR2ptbl4L+2wqgBos+tZ1S
	GyKypwGOVOiGkHdNIFcW/1NqMW9wxv4mlT/QCriD9N8lqVtg2/eSVGLDAoQ==
X-Gm-Gg: AYBFou3OLyBOsvdAaqd9xo2bxNCzHpns2x/ir5CGY2BbrD1ygEdOrINCFY0EbJ5O9af
	j0VZd+uBDwtyee5Qw537HUHX61892RRE1kaH3DKtREF1jrsC8Dl+vtoXmeRMkbtY2DfuUIpIfQL
	ddqw19i50bACzquuLdRoopSC8dAjWZbt89BfETeu5YfpszQINHYhcQROVY6D2w/vOFLnEtQz/W2
	D0bKf7L1teouF39rA9mnrzk5jtD8tEGOHjQSTzT1XbpLyNqtV2zO4OBlmM8506YLDG0MyLnFcuC
	iotjU3y6R4T2YQZYdhq9jLPl+il9RpJPyMrITdkvoNWQ++Nj+uwQoygWOzUr7/1RY9L7KDN5TVJ
	hQKPkD64zYuMOuVaWfbF1ZFTRIGykT4XRm8oSku+vXq3SBNs26WsC2A48t50uSOanqB3NBgBQmA
	jmZkus4t3YM4gEeDr3gfo4m8rGW6fHnbXoGUEcJGaQQg==
X-Received: by 2002:a05:6214:618a:10b0:91f:1e9c:da2f with SMTP id 6a1803df08f44-91f2418f89cmr6153556d6.16.1794515860161;
        Thu, 12 Nov 2026 12:37:40 -0800 (PST)
X-Received: by 2002:a05:6214:618a:10b0:91f:1e9c:da2f with SMTP id 6a1803df08f44-91f2418f89cmr6153126d6.16.1794515859575;
        Thu, 12 Nov 2026 12:37:39 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0107w-grc-07-174-93-165-160.dsl.bell.ca. [174.93.165.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d6193esm4324036d6.19.2026.11.12.12.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:37:39 -0800 (PST)
Message-ID: <7aac6b79-6cf3-43e0-9c5b-cad10c1011b0@redhat.com>
Date: Thu, 12 Nov 2026 15:37:38 -0500
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
From: Luiz Capitulino <luizcap@redhat.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, "Liam R. Howlett" <liam@infradead.org>,
 Jann Horn <jannh@google.com>, =?UTF-8?Q?Jakub_Mat=C4=9Bna?=
 <matenajakub@gmail.com>
References: <20261109201217-failed-6.6-8146c6478224@kernel.org>
 <20261112034659.1574521-1-sashal@kernel.org>
 <573db8ce-225e-4da4-a196-14759f4a174f@redhat.com>
Content-Language: en-US
In-Reply-To: <573db8ce-225e-4da4-a196-14759f4a174f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/26 3:34 PM, Luiz Capitulino wrote:
> 
> 
> On 11/11/26 10:47 PM, Sasha Levin wrote:
>> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
>>
>> [ Upstream commit 8146c6478224d8f6395c6b08a19c344a56d79867 ]
>>
>> Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
>> merging with expansion of mremap()'d VMAs, however it also unintentionally
>> disallowed the expansion of unmergeable VMAs.
>>
>> Previously it was possible to expand a mixed mapping which mremap() had
>> already ensured was a legal expansion.
>>
>> This is clearly seen in the mremap() logic, as it checks
>> vma_is_fixed_mapping() to determine legality of an expansion rather than
>> vma_can_merge().
>>
>> Additionally, copy_vma() allows for a failed merge to result in a new VMA
>> being instantiated if MREMAP_MAYMOVE is specified.
>>
>> However, this is not attempted, as a failure in vma_merge_extend() is
>> assumed to be an -ENOMEM failure.
>>
>> Since vma_merge_extend() is used exclusively by mremap() to perform a merge
>> and/or expansion, resolve the issue by invoking vma_expand() for
>> unmergeable VMAs there.
>>
>> Explicitly assert that the VMA is both non-fixed and a mixed mapping.
>> This provides double insurance against broken changes in future.
>>
>> Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
>> redundant in this case, as a mixed mapping is not subject to khugepaged.
>>
>> Also update the VMA userland tests to add a required predicate.
>>
>> Link: https://lore.kernel.org/20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org
>> Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> Reported-by: Luiz Capitulino <luizcap@redhat.com>
>> Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
>> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>> Cc: Liam R. Howlett <liam@infradead.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Jakub Matěna <matenajakub@gmail.com>
>> Cc: <stable@vger.kernel.org>
>> [ sashal: Adapted vma_merge_extend() changes to the inline mremap() implementation using the older vma_expand() interface. ]
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> I tested this against the in-tree reproducer and ran the MM kselftests
> (which I had to hack to build). All is good:
> 
> Tested-by: Luiz Capitulino <luizcap@redhat.com>

I forgot to mention one thing below:

>> ---
>>   mm/mremap.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 0739a31b54eed..a37bcfda29261 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -1120,10 +1120,21 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>>                * the next vma if it becomes adjacent to the expanded
>>                * vma and  otherwise compatible.
>>                */
>> -            vma = vma_merge(&vmi, mm, vma, extension_start,
>> -                extension_end, vma->vm_flags, vma->anon_vma,
>> -                vma->vm_file, extension_pgoff, vma_policy(vma),
>> -                vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>> +            if (!(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND |
>> +                          VM_MIXEDMAP))) {

I think we could check only for VM_MIXEDMAP? Although, AI is telling me
the fix is correct and it makes no difference...

>> +                vma = vma_merge(&vmi, mm, vma, extension_start,
>> +                    extension_end, vma->vm_flags, vma->anon_vma,
>> +                    vma->vm_file, extension_pgoff, vma_policy(vma),
>> +                    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>> +            } else {
>> +                /* Mixed mappings are permitted to be expanded, not merged. */
>> +                VM_WARN_ON_ONCE(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND));
>> +                VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
>> +                vma_prev(&vmi); /* Reposition to start of VMA. */
>> +                if (vma_expand(&vmi, vma, vma->vm_start,
>> +                           extension_end, vma->vm_pgoff, NULL))
>> +                    vma = NULL;
>> +            }
>>               if (!vma) {
>>                   vm_unacct_memory(pages);
>>                   ret = -ENOMEM;


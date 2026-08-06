Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F311A683D
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040035; cv=none; b=DHqfVvi2j1sPMG7r0F4bWFu1M7Ir7MulSIIiUUh6E2KBjiyLfnaHgdH10mJP7DSrQU9jwXGh79mQCzseR/uhZm3NTHmoskdVEb9N1H9L3k8wao/z32allqXlTRgvdlGiu1HUcBT6UqDUAITY4Zo36JXQdiNJ5TTl+W+ARwvjroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040035; c=relaxed/simple;
	bh=MHQfaL1M2IKM3awQeLVb9os2j7/ojAX8zIZKXoQuB1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddM6c53lzbr6Vbs09parW/gYnM9L6DkMoH7tkuatITnUmFxOWEHedm+OGbBI+p0yKTjTDWJ1dD2TecgdphpdqhPeXQDvXm/JwysGNKFpS9FIlkaiJN4ftJZmMKBJwB0pmuDc27rttqA32VWz1n11/c4XapmuR4F+hX/RkItK8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z+/9cu7t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z+/9cu7t"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Hlmoa3355319;
	Thu, 6 Aug 2026 18:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fjOinF
	4B5R06Aaza/+rfmG8y3ygy1sRWXvjr4ahcXUI=; b=Z+/9cu7tkudN6gIhPBamtI
	w9ftsq52KCDxaX+AgnH9qe9hjyqZdTmZbhKsq+49hYB663bkTPtpcYYQOkxBe7F4
	Gp4kCX05SbExHJcJOQnay4SydbyKj/kzTtKa2ldlv8vGLPhYIs4kfZEVR+iy+e7w
	xsghhJpodiaBa62QJFVPX9aaxhKAFmIwySIOQOSBj9n0NqxP357G4EvaYaYyw0b9
	hzdyBy83N8a/45RjgGAJKRfted0IbZsQmxqAkc4LjopQQbtUZJkqoK05svoOHEzf
	WOZHDkGK35BKZU//Gg2WT9Lq5Khw4EuQdJqOfIleLCVROqzL1LcdacwYIKb6Nu6Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyr44g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:13:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HuJgV013134;
	Thu, 6 Aug 2026 18:13:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyv5sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:13:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676IDnZ964094690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 18:13:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F355805E;
	Thu,  6 Aug 2026 18:13:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82DEB5805A;
	Thu,  6 Aug 2026 18:13:48 +0000 (GMT)
Received: from [9.61.245.150] (unknown [9.61.245.150])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 18:13:48 +0000 (GMT)
Message-ID: <cc046eb2-6308-4a3d-96a9-74b8787a44cb@linux.ibm.com>
Date: Thu, 6 Aug 2026 11:13:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, borntraeger@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com
Cc: stable@vger.kernel.org
References: <2026080507-senior-manpower-f5ab@gregkh>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <2026080507-senior-manpower-f5ab@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a74cedf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=VnNF1IyMAAAA:8 a=EdsDdA-cVeZSgVbA-U4A:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzOSBTYWx0ZWRfXxsOxAy6pEYiI
 YtB0/zKMYlX9IqoR5nPQY/veVF6OdQ4sKRI6W4Cm16ts76CZwbq7ihqjK4DNvL0Q/o3WXGf9q1X
 qLQyWLrKdNipQWqQwNjTUhi5ePjD+nY=
X-Proofpoint-ORIG-GUID: uB6FdaRIEin8N5sTYOumwcIRl9ymnZpN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzOSBTYWx0ZWRfX3jHa2iwMkcks
 fkdZacxJVD5Y7231rIkmvBt4kHd8fY/oMJi9qDBsq9IDXVVR+9wPylZKGdZYP7T+Cigo/v0nL8R
 lWU2mSv4HCH6K7XuAxjBvBpx+NZuR/ea7lCtz9nNfE1lywYNUt1bF0wpTulfYdqBBv9rYLAlz57
 IEk4bPY0VSBbh3a+Mpq5oco79pDzTsK3gdqVx1qluhLdSLWI/n8UKs9QvK7ZB0GfV80pBMyUs9s
 TkfI/brDNi5KCNz0hQa/q21WumZ1tfxMsMdUwNPp9LsLuReX9BZqCzTUEe3SCYcSqapY/XXg9u+
 6C16fFOrLM2yZjqi/Fvk6d0PHM2nX4BM0pjk8Tc3DtToEFKckC0q+q3rcWMJp/H8nbWqlZB4Jxo
 LkGwOaEqdMIn7DlD0jHjn1pneRir4lfsKQufziV20mzuyVtFyrsiiWSEOj0b3kiI5mVilXO9Ypj
 QKL0KOfbZ5JVXMT9pYA==
X-Proofpoint-GUID: uB6FdaRIEin8N5sTYOumwcIRl9ymnZpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060139

Hi Greg,

This patch has a dependency on the following commit from Linus's tree:

5618c53d96d1 ("KVM: s390: Use try_cmpxchg() instead of cmpxchg() loops")

Applying this dependency patch and then cherry-picking should resolve 
the conflict. It's the same issue for failing to apply 36f6999ecde3 
("KVM: s390: pci: Fix memory accounting for pinned/unpinned pages") in 
stable version 6.1, 6.6. Is it possible to apply the dependency patch 
and try again?

Also there were multiple fixes that we wanted to backport, but I think 
only 3 of the patches were attempted across (6.1, 6.6, 6.12 and 6.18). 
The entire backport would be:

868d32ac72cb KVM: s390: pci: Validate AIBV and AISB before pinning guest 
pages
5580c9858f1e KVM: s390: pci: Fix resource leak on IRQ registration failure
8bf09b9b7d32 KVM: s390: pci: Fix NULL dereference on AIBV allocation 
failure
f86842e4d6c4 KVM: s390: pci: Fix missing error codes and memory 
unaccounting
36f6999ecde3 KVM: s390: pci: Fix memory accounting for pinned/unpinned 
pages
8fa01be5a614 KVM: s390: pci: Reject adapter interrupt forwarding if 
already enabled
5618c53d96d1 KVM: s390: Use try_cmpxchg() instead of cmpxchg() loops

Would appreciate any guidance on how we can proceed with this.

Thanks

Farhan


On 8/5/2026 2:35 AM, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 36f6999ecde3976731a8bfc0b8e667da6f593069
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080507-senior-manpower-f5ab@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From 36f6999ecde3976731a8bfc0b8e667da6f593069 Mon Sep 17 00:00:00 2001
> From: Farhan Ali <alifm@linux.ibm.com>
> Date: Thu, 23 Jul 2026 15:14:05 -0700
> Subject: [PATCH] KVM: s390: pci: Fix memory accounting for pinned/unpinned
>   pages
>
> The account_mem() and unaccount_mem() functions call get_uid() which
> increments the reference count of struct user_struct on every invocation.
> But we don't decrement the count by calling free_uid(). It also
> accounted/unaccounted the pages against the current->mm. But its possible
> the unaccount_mem() can be called from a different process context than the
> one that originally pinned the pages.
>
> Let's fix this by storing the pinning process user_struct and mm_struct
> when accounting for pinned pages, and subsequently free these resources
> when the pages are unpinned.
>
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> [borntraeger@linux.ibm.com: Fixed whitespace]
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index d2a11cdf6941..0741aed442bc 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -190,33 +190,54 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zdev)
>   	return cc ? -EIO : 0;
>   }
>   
> -static inline void unaccount_mem(unsigned long nr_pages)
> +static inline void unaccount_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
>   {
> -	struct user_struct *user = get_uid(current_user());
> +	struct user_struct *user = kzdev->user_account;
> +	struct mm_struct *mm_account = kzdev->mm_account;
>   
> -	if (user)
> +	if (user) {
>   		atomic_long_sub(nr_pages, &user->locked_vm);
> -	if (current->mm)
> -		atomic64_sub(nr_pages, &current->mm->pinned_vm);
> +		free_uid(user);
> +		kzdev->user_account = NULL;
> +	}
> +
> +	if (mm_account) {
> +		atomic64_sub(nr_pages, &mm_account->pinned_vm);
> +		mmdrop(mm_account);
> +		kzdev->mm_account = NULL;
> +	}
>   }
>   
> -static inline int account_mem(unsigned long nr_pages)
> +static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
>   {
>   	struct user_struct *user = get_uid(current_user());
>   	unsigned long page_limit, cur_pages, new_pages;
> +	int rc = 0;
>   
>   	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>   
>   	cur_pages = atomic_long_read(&user->locked_vm);
>   	do {
>   		new_pages = cur_pages + nr_pages;
> -		if (new_pages > page_limit)
> -			return -ENOMEM;
> +		if (new_pages > page_limit) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
>   	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pages));
>   
> -	atomic64_add(nr_pages, &current->mm->pinned_vm);
> +	if (current->mm) {
> +		mmgrab(current->mm);
> +		atomic64_add(nr_pages, &current->mm->pinned_vm);
> +	}
> +
> +	kzdev->user_account = user;
> +	kzdev->mm_account = current->mm;
>   
>   	return 0;
> +
> +out:
> +	free_uid(user);
> +	return rc;
>   }
>   
>   static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
> @@ -279,7 +300,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   	}
>   
>   	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(pcount))
> +	if (account_mem(zdev->kzdev, pcount))
>   		goto unpin2;
>   
>   	/* AISB must be allocated before we can fill in GAITE */
> @@ -400,7 +421,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
>   		pcount++;
>   	}
>   	if (pcount > 0)
> -		unaccount_mem(pcount);
> +		unaccount_mem(kzdev, pcount);
>   out:
>   	mutex_unlock(&aift->aift_lock);
>   
> diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
> index ff0972dd5e71..fdf8c7bf4ed0 100644
> --- a/arch/s390/kvm/pci.h
> +++ b/arch/s390/kvm/pci.h
> @@ -22,6 +22,8 @@ struct kvm_zdev {
>   	struct kvm *kvm;
>   	struct zpci_fib fib;
>   	struct list_head entry;
> +	struct user_struct *user_account;
> +	struct mm_struct *mm_account;
>   };
>   
>   struct zpci_gaite {
>

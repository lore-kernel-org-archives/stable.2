Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E7326928;
	Fri, 19 Jun 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781867540; cv=none; b=hReiJ3iFpaTCLuXM/0CkdPLvczhA3IzCowTsVNrX96Q/xgTP9fC2FtQoCuL6RKOqknAKupJXzSXp8G/Tmz/LZvgJ67hvfSAiAwkHIGOfMkZrbhDe+CF7ku8U1xuN59dy4vbRWa9yT2MCuxxQ62rFm7re0DQStIbnqxLu+dpzayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781867540; c=relaxed/simple;
	bh=xgM5RG8vot/uI8KCaaVJnKAbmu5siE6K6avY7Xb0Rb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJfEM5skW7RJX/cn+Z9//mP14dUoEuGNPe0IC7nbicJPN0Ls2n6+waHPePZjkZziKAd8tmXmiPhF7egwzewnMubZY/GByqGqpRbITSjiuKSQ0s073DOc4M9hOi5k5JlHgMtwkekHFupu2RUQjHHQ258WLfuqQWCfBHi+Ab4aKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=llfxBMjf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="llfxBMjf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mQEO1674614;
	Fri, 19 Jun 2026 11:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0dSnYX
	SW4fTSZmyefELvFggBGqLXgAIi+oiPzdTjNjU=; b=llfxBMjf0XICEEDUyPe3cL
	Am757hrniAMZexLHRc77JKDaihmtpI+hRi7J8tuWGVzpKx/RFDT1AxyoWv4v3XRV
	iKTdgE8VmXf6gfbwaIdsDWLYdJQRI2J2l9gb42j/YwIMxiS7yYCv5Ta42W4u13Ox
	B3KAKHczV5OGy2JrxTuIKnuks5OMU74grxyXOKjX7g9y1nn6h1YwH5exibDfDnwP
	wjx0jmuAu8yH3bXDHTGMReok5DohLdA6cSIrTBxrVKPmt7AXslh7HuejnoahdvoN
	KuuglZ5LBUdsrL2kL87zoUR3pvP/K0r4WD5tSsoXxs4VuD76LLmGBvFHaUuvk42g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw5741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 11:12:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JB4be5024284;
	Fri, 19 Jun 2026 11:12:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1728h8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 11:12:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JBC3e931261066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 11:12:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71AF02004B;
	Fri, 19 Jun 2026 11:12:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EC1120040;
	Fri, 19 Jun 2026 11:11:59 +0000 (GMT)
Received: from [9.124.219.178] (unknown [9.124.219.178])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 11:11:58 +0000 (GMT)
Message-ID: <30561ae5-1e6a-4cc2-99e2-436c88b2f11d@linux.ibm.com>
Date: Fri, 19 Jun 2026 16:41:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] debugfs: Fix lockdown check for mmap_prepare
Content-Language: en-GB
To: Chun-Yi Lee <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Chun-Yi Lee <jlee@suse.com>, David Howells <dhowells@redhat.com>,
        Lorenzo Stoakes <ljs@kernel.org>,
        Andy Shevchenko
 <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615104750.1000-1-jlee@suse.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20260615104750.1000-1-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfX2Ltpt4T61Rw7
 5+fFZ9BUEnNSoC3fWjiVWa2AECZ4hFnBEs4f6g+5WKgM7/VFnHlgFY3Jos6J8esDws6Qw5eMqLr
 MZ6uKWRbZ7ma3SW/32qdbq2rGMlIdoM=
X-Proofpoint-GUID: C64KMeHamkSssRkxLlB7VHdcLQgDKbDB
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a352406 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=iox4zFpeAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=9Rt4o3Z7AAAA:8
 a=ag1SF4gXAAAA:8 a=VnNF1IyMAAAA:8 a=3kR2PXdCzuXVfo5DH_oA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=jE01AiZSAJ7eki2zvjzZ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: FtCyyGXeGTb0hE4YmkpKhNq5SCHztS6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfX626r8NBrSrWZ
 awtwFxooPbmiz0pOj17ssaK50MzaW47nnvqos9uGDRVwehLgKQ5mD78yJWKIuV97YQR6uf7veog
 V38nXxWalSN+ZQ6c/Oia8UWwY4Dd8BK6eEvLYdRf4eI4TMKSWGV/0KKOlXVQRAE9bsCGlA5jy6X
 bnVTcU20VVWC1oDbUyCnsEeh00f1iphA8ZcCGRqbnFBUZFhKMI3doQuN2JuiBrA4001HMJzTbeL
 bxWgSkOFvdFC2/S+T63eqdk0I56hfManWQKs8/S0M1inB+FbJbWuSz7g943h7zVwwQ1kZrvy1Ay
 LZTOw3YBW+6TdH1yWViI73jGdTFGOk1nToVXvAASg89AjI3j9puKTkDpp+zKzbjwCtcBllGYV7i
 7i9nWhCrp8iTGRj1zvtaZAeDI+De3/HrXSmJXYwjjPEHj8UZN8DHdjXdf1bOyOZKLzadqRDFDjK
 7MCaWCWzoL3HyNwWcTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190100

On 15/06/26 4:17 pm, Chun-Yi Lee wrote:
> From: Chun-Yi Lee <jlee@suse.com>
> 
> Commit 651fdda8406d ("relay: update relay to use mmap_prepare")
> changed the `mmap` file operation to `mmap_prepare` for relayfs, but
> the lockdown check in debugfs was not updated accordingly.
> 
> This prevents debugfs from being locked down when the kernel is in
> integrity mode if a file uses `mmap_prepare` but not `mmap`.
> 
> Since the conversion to `mmap_prepare` across the kernel is not yet
> complete, update the lockdown check to look for both `mmap` and
> `mmap_prepare` to ensure comprehensive coverage.
> 
> Fixes: 651fdda8406d ("relay: update relay to use mmap_prepare")
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: driver-core@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---

Hi,

I tested this patch on ppc64le with lockdown enabled. It correctly fixes 
the security issue where debugfs files using mmap_prepare were not being 
restricted.

Test: blktrace/001 from blktests (uses relayfs via debugfs)
- Before patch: blktrace bypassed lockdown and accessed debugfs
- After patch: blktrace properly blocked from accessing debugfs

Environment:
Kernel: 7.1.0-rc7
Lockdown: integrity mode

Feel free to add:
Tested-by: Disha Goel <disgoel@linux.ibm.com>

> v2:
> - Add explicit From tag to match Signed-off-by.
> - Fix Lorenzo's email address.
> - Add Cc stable for backporting.
> - Check both mmap and mmap_prepare as suggested by Lorenzo.
> 
>   fs/debugfs/file.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index edd6aafbfbaa..08de6652a4f3 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -273,7 +273,8 @@ static int debugfs_locked_down(struct inode *inode,
>   	    (!real_fops ||
>   	     (!real_fops->unlocked_ioctl &&
>   	      !real_fops->compat_ioctl &&
> -	      !real_fops->mmap)))
> +	      !real_fops->mmap &&
> +	      !real_fops->mmap_prepare)))
>   		return 0;
>   
>   	if (security_locked_down(LOCKDOWN_DEBUGFS))

-- 
Regards,
Disha


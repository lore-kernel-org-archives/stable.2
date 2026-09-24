Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F38411FA4;
	Thu, 24 Sep 2026 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277578; cv=none; b=Z3oL9JaAXR2BF3QoK64SvV0Bs1oi2+MAzWBcJYOJjhv/y3pYNlQ2ghxFL2XbBVb6AVaKXYPtMrSNDqcpEOR00StIqLuZXHgvjyyk24v3DkLXjtAvFDLmqf0p3ul4riMmA954beosamgj4o+TYQAk12tcyHO0c3QL5mM73/l68uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277578; c=relaxed/simple;
	bh=SPHdUpVeDbmm/rG8+ZCd1nYzkslIBC/it2Ku7nwg6TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0pltzG4NRIsMHn1xotS4o5TE5xsROXQBNL4FnKepBnrfH57M2WYH1SyqtXszT0UDWWesJz8PBGmNt/PMyj/vcJnXY3NZPlkooL6Hvlxk6D9qkgNdiXQOgwWYHprdzIAUgCFM2J52VXQYEZW0fDBrPe1JEGT4W+6ijZi59k4aEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c80mv6+O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c80mv6+O"
Received: from [100.65.224.201] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 571A420B7168;
	Thu, 24 Sep 2026 12:18:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 571A420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790277521;
	bh=ra1ZNTMf+H3FfJz20jyeMOD8jL+yQijcig4CEZNAk8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c80mv6+ODE+85dIyYOpEix/sjPmj98S4Dh769y2PxC6UWPp/UmuOsd+aWej3hT+nc
	 q7JyQtXp5OvWznsptqEsf0oApOhiHTXFctO6EKw7Dsh6/puIpWBDOc136XP00eO4GL
	 d4Smno7vz+Npa1M7T2lOJpBsKdL2jo5ZXGXNH5No=
Message-ID: <06f970fe-ae23-4b5d-87fc-f2751bacc8bf@linux.microsoft.com>
Date: Thu, 24 Sep 2026 12:19:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv_vtl: Check per-CPU register page before mmap
To: Michael Kelley <mhklinux@outlook.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>
Cc: "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "namjain@linux.microsoft.com" <namjain@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260911175146.1370148-1-hargar@linux.microsoft.com>
 <SN6PR02MB4157E82658A24F00691EEC8BD4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E82658A24F00691EEC8BD4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/21/2026 5:14 PM, Michael Kelley wrote:
> From: Hardik Garg <hargar@linux.microsoft.com>
>> Register-page setup is optional for each CPU. If allocation or
>> registration fails, mshv_vtl_configure_reg_page() warns and leaves that
>> CPU's reg_page NULL, but initial context setup continues successfully.
>> Meanwhile, successful setup on another CPU sets the global
>> mshv_has_reg_page flag.
>>
>> mshv_vtl_fault() checks this global flag before selecting the requested
>> CPU's register page. With mixed setup results across online CPUs, the
>> check passes even for a CPU with no register page, reaching
>> get_page(NULL) when userspace faults in that mapping.
> I'm a bit late in reviewing this because I was travelling all last week.
>
> This patch seems like it is just papering over the real problem, which
> is that a global variable like mshv_has_reg_page can't represent the
> status of an operation that may succeed or fail on a per-cpu basis.
> I pointed this out (as did Sashiko) in review comments back in
> April [1].
>
> The only other place mshv_has_reg_page is used is in 
> mshv_ioctl_check_extensions() where its value is returned from an
> ioctl() system call made by user space. That's a questionable practice
> since ioctl() usually returns 0 on success, though the man page for
> ioctl() does admit that some ioctls use the return value as an output
> parameter and return a non-negative value on success. But even
> then, a single value can't accurately reflect the status of an
> operation that may succeed or fail on a per-cpu basis. User
> space would presumably have a similar problem to what is
> being fixed by this patch.
>
> Is there any reason that the real problem couldn't be fixed
> instead of doing this fix on top of something that is fundamentally
> broken?
>
> Michael
>
> [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157CF364DA2C0CC657A6DCBD450A@SN6PR02MB4157.namprd02.prod.outlook.com/

Hi Michael,
Thanks for the feedback and for pointing me to your April review.
After going through it, I understand that the NULL check only addresses
the immediate fault, while the global capability still misrepresents
per-CPU availability.

I'll work on addressing the underlying issue and send a proposed fix
soon.

Thanks,
Hardik

>> Check the selected per-CPU register page before taking its reference and
>> return VM_FAULT_SIGBUS if it is absent.
>>
>> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_vtl_main.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> index fc993560a45c..3296ab5c0243 100644
>> --- a/drivers/hv/mshv_vtl_main.c
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -912,6 +912,9 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
>>  		return VM_FAULT_NOPAGE;
>>  	}
>>
>> +	if (!page)
>> +		return VM_FAULT_SIGBUS;
>> +
>>  	get_page(page);
>>  	vmf->page = page;
>>

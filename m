Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D4D41DDFB;
	Thu, 16 Jul 2026 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203564; cv=none; b=FqkOrMKJR0VnxkWM5H8Hu5XSD5RnUx7ZMaGW7je5/FVVmJqOJIlSkTlkxDUkj9lWR3TdRRYuRykAHFDdmQL6DqcrvSMZ+CXSvzPoMLTW4/CLu5Xa6lZ4hCR6CZ3WMjG+mwDa5eidp6vXKgWwZPnMZrqLv/H62FyQC4y3pQcxdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203564; c=relaxed/simple;
	bh=/mFYnjr+W+GGLhCxediJonaDsPlqf06MZJN8QLoqaUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mibfY+gNDbOmKW5WTQvPj+dICsC0a6RNvGdl/enbSeqjMsWRUFsi12lljztkbiTQCuYWsknOY0sjCsp8uYGn3kU7XwTTuZJCYkxXm+zJ2i4htfvrOSi6giCI6Sz02y1QmgJZEmDe4sv9kvX9h20Nf4ySf8SbugKi5iZcyYsnwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fEp8RjkE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fEp8RjkE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E60901476;
	Thu, 16 Jul 2026 05:05:56 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D46693F7B4;
	Thu, 16 Jul 2026 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784203561; bh=/mFYnjr+W+GGLhCxediJonaDsPlqf06MZJN8QLoqaUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fEp8RjkE+6V5s/hpvJglRewSA35fmUZj5Mt0gaA5XnWwBcAgzygFjCUuOIGObqMAA
	 5dxih9o81mxuWjT8rVQhwpVEuOqzNdUI9yV7bpa5pnFbg0kLu6fDk8HSUHmXibekHh
	 8sjK0bNmDE0zOfNl0vSNXZr2v+5dX0E22Ax8J/wA=
Message-ID: <0f5ef1fe-7d15-4354-90eb-a7e42623ae94@arm.com>
Date: Thu, 16 Jul 2026 13:05:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Weimin Xiong <xiongwm2026@163.com>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, robin.clark@oss.qualcomm.com,
 joro@8bytes.org, will@kernel.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260716013229.91014-1-xiongwm2026@163.com>
 <20260716085313.207069-1-xiongwm2026@163.com>
 <6caf8ca0-8be5-4935-9766-10d21c71ac37@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <6caf8ca0-8be5-4935-9766-10d21c71ac37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2026 10:42 am, Konrad Dybcio wrote:
> On 7/16/26 10:53 AM, Weimin Xiong wrote:
>> Move the list_add() call to the end of msm_iommu_probe() instead of
>> adding cleanup paths, which avoids the dangling list entry problem
>> entirely (suggested by Mukesh Ojha).
>>
>> This approach simplifies the code by ensuring the iommu device is
>> never added to the global list until after all potential failure
>> points have passed.
>>
>> Changes in v3:
>> - Move list_add() to the end instead of adding cleanup labels
>>    (suggested by Mukesh Ojha)
> 
> I think this approach introduces a race condition, because e.g.
> iommu_ops->of_xlate() depends on the item being present in this list

Yes, the IOMMU instance must be ready to be fully functional *before* 
calling iommu_device_register(), since that can start probing and 
attaching client devices before it returns.

Thanks,
Robin.

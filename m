Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FCF2DB791;
	Fri, 31 Jul 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483134; cv=none; b=cjwyueiiZi3TB2dQcYrkwLzN2UjIf3KHxzkuxOHl4aW+sp/BpXrR/yrKpnMIarkli7cvT7a3t7whHdfigj3PugvPq1mNummQqXd2s9yEyChbi6r8Evtm1gnm07EXN6HtyqNaM30G9O0VhiV3zYJI8xijlD4mdiMQ23yAOnxJs90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483134; c=relaxed/simple;
	bh=ZF0s57b7k6e5dP90r8jkPEAojTmMsS7ee7l7SCFAQVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASHQXt+QoHN6HweStrdZahplAHljtk4fU7d6aNk1XKOVMyoxUEfLcsptenKy5ODcPlfIvnPmSdysa2tpdDY2c5rTWkQMRfHbAexFVbR/X9pGhZabrFHbCbp2p8aOkQi4ZhhoAGJDB50isIpQscaY0YinjAh2yi7G0KDGqbd+v3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QmdmE8Lm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QmdmE8Lm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD29204C;
	Fri, 31 Jul 2026 00:32:08 -0700 (PDT)
Received: from [10.57.87.104] (unknown [10.57.87.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04B143F7B4;
	Fri, 31 Jul 2026 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785483132; bh=ZF0s57b7k6e5dP90r8jkPEAojTmMsS7ee7l7SCFAQVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QmdmE8LmZOy1p44SMZM6kf1/Ccor+OsXQQ1WWsqax9C1Os2gHtE1PgT6/Lrg/jJii
	 nIlZT+HbHDflulV5FqL2zo+lSgK1ARWWn0Lkr8nFEybeVVqa7vP2rp4+UeQiknqvhm
	 /7MU+S1uAeJx/VkE7Pw1k346t1xpTrjDjQPcD8ho=
Message-ID: <2125ea5a-d878-4032-9338-d0cd0970ccfa@arm.com>
Date: Fri, 31 Jul 2026 08:32:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: snapshot firmware interface counts before
 loops
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260720135518.17927-1-osama.abdelkader@gmail.com>
 <amjH-v6-2POzmj1q@e142607> <amnrQq-IJzIB_kgF@osama>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <amnrQq-IJzIB_kgF@osama>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/07/2026 13:00, Osama Abdelkader wrote:
> On Tue, Jul 28, 2026 at 04:17:14PM +0100, Liviu Dudau wrote:
>> On Mon, Jul 20, 2026 at 03:55:18PM +0200, Osama Abdelkader wrote:
>>> The firmware exposes the global group count and per-group stream count in
>>> the shared control interface. These values are validated before being used
>>> as loop bounds, but the memory is shared with the MCU firmware and can be
>>> changed after validation.
>>
>> Again, you're making statements that need to be proven here. How is MCU
>> firmware going to change the content of the memory shared with the driver?
>>
> 
> Thanks for the review. yes, this was flagged by Sashiko while reviewing the 
> previous patch, but I agree the commit message shouldn't present it as a proven
> firmware mutation bug.
> 
> The useful part here is just making the validated count the same value used
> as the loop bound. since It's an optimisation, should I send v2 without Fixes
> and Cc stable tags?

I think the issue here is that Sashiko is thinking the firmware isn't
trusted. And there's some truth to that - we do perform validation of
the firmware binary and sanity check some of the values it writes. But
this is more as a robustness check rather than a real trust boundary.
The firmware changing values under the kernel's feet is more than just a
robustness bug, it's only really likely to happen with an actually
malicious firmware.

But the actual change is reasonable, as Liviu says it could even be a
(very minor) optimisation. So if you could send a v2 with a reworded
commit message then feel free to add:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

>>>
>>> Read each count once with READ_ONCE() and use the validated snapshot as the
>>> loop bound. This keeps the loop bounds consistent with the validation and
>>> prevents the compiler from reloading a firmware-controlled count during
>>> iteration.
>>
>> As an optimisation I'm fine with it, so:
>>
>> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>>
>> Best regards,
>> Liviu
>>
> 
> Best regards,
> Osama
>>>
>>> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>>> ---
>>>  drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
>>> index e2fcbd639c3c..6e6da98d795e 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_fw.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
>>> @@ -959,6 +959,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>>>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
>>>  	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
>>>  			   ((u64)csg_idx * glb_iface->control->group_stride);
>>> +	u32 stream_num;
>>>  	unsigned int i;
>>>  
>>>  	if (iface_offset > shared_section_sz ||
>>> @@ -972,8 +973,8 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>>>  	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
>>>  						 sizeof(*csg_iface->output));
>>>  
>>> -	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
>>> -	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
>>> +	stream_num = READ_ONCE(csg_iface->control->stream_num);
>>> +	if (stream_num < MIN_CS_PER_CSG || stream_num > MAX_CS_PER_CSG)
>>>  		return -EINVAL;
>>>  
>>>  	if (!csg_iface->input || !csg_iface->output) {
>>> @@ -990,7 +991,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>>>  		}
>>>  	}
>>>  
>>> -	for (i = 0; i < csg_iface->control->stream_num; i++) {
>>> +	for (i = 0; i < stream_num; i++) {
>>>  		int ret = panthor_init_cs_iface(ptdev, csg_idx, i);
>>>  
>>>  		if (ret)
>>> @@ -1015,6 +1016,7 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>>>  {
>>>  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
>>>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
>>> +	u32 group_num;
>>>  	unsigned int i;
>>>  
>>>  	if (!ptdev->fw->shared_section->mem->kmap)
>>> @@ -1034,17 +1036,17 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	if (glb_iface->control->group_num > MAX_CSGS ||
>>> -	    glb_iface->control->group_num < MIN_CSGS) {
>>> +	group_num = READ_ONCE(glb_iface->control->group_num);
>>> +	if (group_num > MAX_CSGS || group_num < MIN_CSGS) {
>>>  		drm_err(&ptdev->base, "Invalid number of control groups");
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	for (i = 0; i < glb_iface->control->group_num; i++) {
>>> +	for (i = 0; i < group_num; i++) {
>>>  		int ret = panthor_init_csg_iface(ptdev, i);
>>>  
>>>  		if (ret)
>>>  			return ret;
>>>  	}
>>>  
>>>  	drm_info(&ptdev->base, "CSF FW using interface v%d.%d.%d, Features %#x Instrumentation features %#x",
>>> -- 
>>> 2.43.0
>>>
>>
>> -- 
>> ====================
>> | I would like to |
>> | fix the world,  |
>> | but they're not |
>> | giving me the   |
>>  \ source code!  /
>>   ---------------
>>     ¯\_(ツ)_/¯


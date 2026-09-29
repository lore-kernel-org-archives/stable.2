Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D8E632;
	Tue, 29 Sep 2026 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643405; cv=none; b=VCPvr0j8NdtNBXWJKUTWhtxxjQvmyO+7JkWWL+m3iM7umHVnkwpz5IdT7jr2JmQyVEqjeboesrX8fejUYVSlZhpM6nFaxhDP1uoVWP7+WhjBPlQ0RlS5JTqQ63GHQmeAcrTBlCdm3hIqDhfMyWCfyZSXng6VqXW3OK4hETPthxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643405; c=relaxed/simple;
	bh=kOql9ef48kSmauF9b29iH4298MhH1lVV7If/MDsNPiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8MBYuWfDBL/DvTHwVJgXdzsGEDebe1P7kLIJAAj7PkYx66wADvuggiLygqKJ23C5tG2iNUWZoD3jFXaHPzwjtY4RNNHbOszoOvrvA9UjgP+CtedeVeOzP/wJMCticDw93Lhjsg55rfbRDDRj2Q2ovALwI1mPYU+mLXOlgC8AYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UtkDfbvA; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UtkDfbvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=3RP0bnqMIII/pg2ONC6Opo4xbcWoQQB6/I+wlhye0es=;
	b=UtkDfbvAzPIoQ1EEOd85g1MfunZokxLA2parXhp6dnZM5f87rdA8xY5jd96WzQ
	HdOhfTHQbOBziYufv1PyELXZMdJuzGLAcBeToOSTxx//5QdWfPldMlSabCMh/P0J
	MPR9q81X/F+CewOZ1XZHn0OTyCICAwRYMm4CxiuHviw3E=
Message-ID: <ee7cc693-864c-48ad-ac26-459396245c8f@126.com>
Date: Tue, 29 Sep 2026 08:55:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] ice: release the VF MSI-X window when
 ice_start_vfs() fails
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <20260928065306.1514795-2-xiaolinkui@126.com>
 <143280f0-1c93-405b-b03d-b6404893cdd7@linux.intel.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <143280f0-1c93-405b-b03d-b6404893cdd7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3j6qNDLtq9SOUAQ--.43551S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DCFyxKFW7WrWxuFW7urg_yoW8AF45pa
	yDXFy3Ar1kJFy3Wrn2qay8ZF95Wayxt3yF9340k3WSy398Ar1rtFyDtrW29348C397CF1a
	va1j9r43Crn8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcBMNUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQ6vhmq7DI6EtwAA3u



On 2026/9/28 21:08, Tomasz Lichwala wrote:
> 
> 
> On 28.09.2026 08:53, Linkui Xiao wrote:
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> index 95abc6704820..df84dbe12cba 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> @@ -446,8 +446,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>>   		return -ENOMEM;
>>   
>>   	vsi = ice_vf_vsi_setup(vf);
>> -	if (!vsi)
>> -		return -ENOMEM;
>> +	if (!vsi) {
>> +		err = -ENOMEM;
>> +		goto free_irqs;
>> +	}
>>   
>>   	err = ice_vf_init_host_cfg(vf, vsi);
>>   	if (err)
>> @@ -457,6 +459,9 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>>   
>>   release_vsi:
>>   	ice_vf_vsi_release(vf);
>> +free_irqs:
>> +	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
>> +
>>   	return err;
>>   }
>>   
>> @@ -490,6 +495,8 @@ static int ice_start_vfs(struct ice_pf *pf)
>>   				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
>>   					vf->vf_id, retval);
>>   				ice_vf_vsi_release(vf);
>> +				ice_virt_free_irqs(pf, vf->first_vector_idx,
>> +						   vf->num_msix);
> 
> Nit: For consistency with the teardown: loop (which frees IRQs before releasing the VSI), consider swapping the order here too - currently this branch releases the VSI first, then frees IRQs, the opposite order. Not functionally significant, just readability.

Thanks for the review, Tomasz.

Agreed this is only a readability nit. The two calls are independent and
the current order is functionally safe, so I'll keep v2 as is.

No v3 planned for this change.

Thanks,
Linkui
> 
>>   				goto teardown;
>>   			}
>>   		}
> 
> Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
> 


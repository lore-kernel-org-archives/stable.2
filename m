Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B83AC0FC
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084370; cv=none; b=ABn8lAvKalXQQZ5Or5ir8Ixvgb0hJUoE1/Xr9Jxtzfq7qdP809/dTzgElRi3ulVHg4p+XW7/31JYdcRK0j1smHoObO2s3uZSoErb/yXN7HwvHvt0jB/XfypFrM8h29azM5SoNzSLcNL0Fk6VAVvQPf078LsSHSV3RpjjqFnMTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084370; c=relaxed/simple;
	bh=pz5x7Uful+e4tpdXxod5EqSQ03Jk4ZCGvC9DnrUEPWU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g4S8th7SpWxQ6IDi6PL2MMtsEvquEOrkRb/T/XL7DzVx2FYBlQ4mxasbfgOxEbuVCRxkz8P1QzhTPMbXvB52L3FWm82QxhxDNneydvggD3f6RqRCZaq8lbWTPJpaioSG6YmxoDfi2JhF+GvwJbwcD/SPb2K5cplhnDhl6kiXN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fa4VIWrw; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fa4VIWrw"
Message-ID: <2a1e5d38-1035-4f09-b4af-5a63ec04f1d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784084365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xtif7wKWcaLEOyxIVo71CFUEZSMX5hpVYfkaAXiiXA=;
	b=Fa4VIWrwA70DjAtWZ6OLqi+x7I0FG2AAc4HkAt2Ya5VS11rRMFOUSxztd/U6TqXh40wKC3
	W3aJ3vLjjPPeywQZ6wUcxbDQtgpRROjdXaSBkI8LppJ0qCd3j9bNR+6gJfhUEqDtoCq9Ay
	MfIFCyr0D0BNc90gzhb3BTn2R2U+ANI=
Date: Wed, 15 Jul 2026 10:58:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, sridhar.samudrala@intel.com,
 wojciech.drewek@intel.com, piotr.raczynski@intel.com,
 michal.swiatkowski@linux.intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
 <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
In-Reply-To: <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/7/14 22:14, Marcin Szycik 写道:
> On 14.07.2026 08:39,xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>>
>> ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
>> port from pf->dyn_ports. However, it frees the VSI before reading the
>> index for the erase, resulting in a use-after-free.
>>
>> Follow the reverse of the allocation order in ice_alloc_dynamic_port()
>> by erasing the xarray entry before freeing the VSI.
>>
>> Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
> Reviewed-by: Marcin Szycik<marcin.szycik@linux.intel.com>
>
> Thank you!
> I wonder how such a glaring issue survived in the codebase for so long.
> Perhaps ice_vsi_free() exited early for some reason.

Thanks for the review!

Hard to say—maybe the window is quite small and the freed slab still
holds the old idx most of the time, so nothing obvious shows up.

>> ---
>>   drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
>> index 2a2e56777f9f7..3ede246490027 100644
>> --- a/drivers/net/ethernet/intel/ice/devlink/port.c
>> +++ b/drivers/net/ethernet/intel/ice/devlink/port.c
>> @@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
>>   
>>   	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>>   	ice_eswitch_detach_sf(pf, dyn_port);
>> -	ice_vsi_free(dyn_port->vsi);
>>   	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
>> +	ice_vsi_free(dyn_port->vsi);
>>   	kfree(dyn_port);
>>   }
>>   

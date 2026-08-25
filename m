Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A13D5673
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649071; cv=none; b=CsDF76SfnFpjsXjzFD1bMt2nhhKZLMbnYvotwnltr+nSyNqArByrX99OmyNU29DYqacxoUHdCNtd7BozH6bXUn/cBztRYsSRPo69AE+8g1pBPt2gEbA7i+DZ+JW8oeAeJMj6ziiW/9WNzVIjiyH/G4agvLVJ8mXDi/mywHXD8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649071; c=relaxed/simple;
	bh=JuWDoKHZ2bnsbiKF1lOc6Dz6iYhV+sugWR+1vGSNmVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7ErkrGnvQ/kycd+5U+QUMDiKSgol31kve5jXg9ff+oL3L/cdEZZq0r23l8uQRjVbuSmtkmjiJWDVsiFHO2Uv+fFBbBMuBvpjCVTxuNgvl2QJt+QdEz+TT9QqnBDZWsJK9NUSbgBCXg5hRBUPJe5jpDX8x9ki5sv4/OEEBmtS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rKljo9mL; arc=none smtp.client-ip=95.215.58.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rKljo9mL"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JuWDoKHZ2bnsbiKF1lOc6Dz6iYhV+sugWR+1vGSNmVo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787649066; v=1; x=1788253866;
 b=rKljo9mLXFN3QUIfmvt96IAq/u7jJv3ShL2fBmEaa1ASr9uXXCV0VxxxNXpfZYgO14TH/f7w
 oQ8xPF8JSVidstAoTrF2XeJY6xbzQEsfKXuLNZPyTdzWD1yopE9U9A8qSKHYicvuInt8Js1wB/M
 CXas1NlBLbQwxRWoKFAJgsYA=
X-Envelope-To: stable@vger.kernel.org
Received: from [192.168.38.216] (123.123.40.40)
	by smtp.migadu.com with ESMTPS id e89364679e9dc4d3;
	Tue, 25 Aug 2026 09:11:06 +0000
X-Mizu-Trace-ID: e89364679e9dc4d3
X-Migadu-Flow: FLOW_OUT
Message-ID: <d6fbe475-a5c2-f975-99b0-a0bd6b6d10e8@linux.dev>
Date: Tue, 25 Aug 2026 17:11:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [BUG] RDMA/siw: KASAN: slab-use-after-free in siw_accept
Content-Language: en-US
To: Bernard Metzler <bernard.metzler@linux.dev>,
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260821194704.835548-1-shuangpeng.kernel@gmail.com>
 <3702388e-3eb9-5f62-f2ae-cac3a01be716@linux.dev>
 <4aa8833a-ab7d-4034-a299-414c3e11ed1d@linux.dev>
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <4aa8833a-ab7d-4034-a299-414c3e11ed1d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 8/24/26 23:24, Bernard Metzler wrote:
>>
>> I suppose it is necessary to clear qp and cep before release 
>> state_lock since both siw_qp_llp_close and
>> siw_qp_modify->siw_qp_llp_close hold the lock during close cep, 
>> something like
>>
>> @@ -1719,6 +1719,16 @@ int siw_accept(struct iw_cm_id *id, struct 
>> iw_cm_conn_param *params)
>>                             SIW_QP_ATTR_STATE | SIW_QP_ATTR_LLP_HANDLE |
>>                                     SIW_QP_ATTR_ORD | SIW_QP_ATTR_IRD |
>>                                     SIW_QP_ATTR_MPA);
>> +       if (rv) {
>> +               cep->qp = NULL;
>> +               qp->cep = NULL;
>> +               siw_cep_put(cep);
>> +       }
>>          up_write(&qp->state_lock);
>>
> Thanks Guoqing, that should fix it. But even better if we
> goto error_unlock directly and remove the now obsolete
> 'if (rv != 0) goto error' below. 

That is cleaner, thanks for the suggestion.

> Can you pls provide a new patch? 

Sure, will do.

Thanks,
Guoqing

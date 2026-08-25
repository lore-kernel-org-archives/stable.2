Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4683DDB13
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646285; cv=none; b=FgHIPnSPc3vLHHNn+NiEBb104OuHeZ+B8TbIYG8JRFBtRHQsOWBhc7UB1YsEiC1mmUny5q7o9Oa5dGd3q6n/NCTKMKVumkFqYdNx3sEL0WNRJylw+Ru6H6xOCkEVBrtlKxqJReNMtO6hy8GTrxC071SOQ4JNblF/W14G0mi+XDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646285; c=relaxed/simple;
	bh=fMVBFOBVKoGOkj1z1iZ/OESzFrC4Hs4XMDXPGd9Ou0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vohbu0jZOcyqzIixkKG/U+YxLwvIh5pAA3yFohdT//YW6+X83gEkzkZSv5T2J3m2r5qlkLZCwzjLCooQzswZM6VVBbRlABQAgUnBkbnLFw6z0YXHalAoys02WZHYYz1GxVzSmCpJkH7c3nSs1YJWI6xpQR5zlx+m6mZngZgjZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W99Wy5lj; arc=none smtp.client-ip=91.218.175.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W99Wy5lj"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fMVBFOBVKoGOkj1z1iZ/OESzFrC4Hs4XMDXPGd9Ou0c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787646281; v=1; x=1788251081;
 b=W99Wy5ljfE/q3r3LrSy2MLvV1W13vGR28iqt52jIsdZe9Uo9UWGS8A6zl8nl6pMpkUnFw0cy
 JhzVV5eQI1Ledf3n3ubyzX0oJY2EfT0DH4INxPmFM4hSODX5gKYLikPBDvr9CX87MctUlnGq66l
 hMuc43A4/mLL8j7V5IufMBjE=
X-Envelope-To: stable@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id a3d3e90f79ae5f84;
	Tue, 25 Aug 2026 08:24:40 +0000
X-Mizu-Trace-ID: a3d3e90f79ae5f84
X-Migadu-Flow: FLOW_OUT
Message-ID: <cbf1cf65-6f80-45ad-8b83-4927dd49c53c@linux.dev>
Date: Tue, 25 Aug 2026 16:24:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] tls: device: fix out-of-bounds write in
 tls_append_frag()
To: Paolo Abeni <pabeni@redhat.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org
Cc: stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Ilya Lesokhin <ilyal@mellanox.com>,
 Aviad Yehezkel <aviadye@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 linux-kernel@vger.kernel.org
References: <20260823084758.20936-1-jiayuan.chen@linux.dev>
 <b1ede30d-5c03-4514-980f-c656acf3bc13@redhat.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <b1ede30d-5c03-4514-980f-c656acf3bc13@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/26 4:03 PM, Paolo Abeni wrote:
> On 8/23/26 10:47 AM, Jiayuan Chen wrote:
[...]
>> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>
>> ---
>> Hope to get capture attention
>>
>> netdevsim + tls (revised a lot locally):
>> https://lore.kernel.org/netdev/20260728125658.390500-1-jiayuan.chen@linux.dev/
> I must admit that RFC series have low chances of getting full attention
> these days, due to constant flood situation.
>
> Could you please re-submit that series formally?
>
> Thanks,
>
> Paolo


Thanks Paolo. Will do it after merge window.


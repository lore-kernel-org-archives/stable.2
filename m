Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999848124D
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163482; cv=none; b=DhHv8WlbIA2I4tpC0oba3jruDdkKM3tA3Hr1g14duzJ/MhZJpNI1EcSZJ2D/5b6sQNpFi2B7PWjmM0fdRhK6YQnapF63E97/fiR2KNXbG3fOTpw6/L8qdJO4MJm9w4JRYkqugHVw9LYhZTZzteQ1BhGyRbVlxrA9TxMv8KE0rZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163482; c=relaxed/simple;
	bh=50wBOnOXusYI9cgpo8V/8VLTMtK51EIxGKYQc1l6qJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSjiuQ1OOqVnPeDkpL5mNgWDGMhnD0amF80nFMi/bGfhMdDDqUA9q5kO6ZGwzMVe38AvSiNb4LqNu7y5/CjHwCbVoziUCbVnZq6AO/6VQBD7oK3/5OGtcmCUPCA5jDOHzG0J4AcJTC97oBz4M/5KmqQ3CsCafS32I/aCNOrC7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdW3vkS8; arc=none smtp.client-ip=95.215.58.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MdW3vkS8"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=50wBOnOXusYI9cgpo8V/8VLTMtK51EIxGKYQc1l6qJA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790163459; v=1; x=1790768259;
 b=MdW3vkS8n8YEcX8pGjbzY+eQPDBflofUw3X8Tkzb3IWuF8xjwSgxyvkCB+gp99GiBw0aoYDJ
 qk7FK+6eaaIJgWmdZ+w0Rw404f8fl5PHe9lVeFMCHsp93yxhimvYceSUxpa2oOEPIm48jqPik7+
 y5oomM5PkDVO1ulWj1QXf3ws=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cc9f7085222a17d5;
	Wed, 23 Sep 2026 11:37:38 +0000
X-Mizu-Trace-ID: cc9f7085222a17d5
X-Migadu-Flow: FLOW_OUT
Message-ID: <16b70ab0-bbb5-415a-ae1b-b68276f8046a@linux.dev>
Date: Wed, 23 Sep 2026 13:37:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] RDMA/siw: Fix qp use-after-free in siw_get_base_qp()
To: Leon Romanovsky <leon@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stable@vger.kernel.org
References: <20260916184400.2093106-1-vulab@iscas.ac.cn>
 <179015250789.3394760.13528866578642274394.b4-ty@kernel.org>
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <179015250789.3394760.13528866578642274394.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.2026 10:35, Leon Romanovsky wrote:
> 
> On Wed, 16 Sep 2026 18:44:00 +0000, Wentao Liang wrote:
>> The reference taken by siw_qp_id2obj() is dropped before the address
>> of the embedded ib_qp is taken from the QP.  If that reference was
>> the last one the QP is freed and the pointer returned to the iwarp
>> core is dangling; the core only pins the QP with iw_add_ref() after
>> the call has returned.
>>
>> Copy the pointer while the reference is still held.
>>
>> [...]
> 
> Applied, thanks!
> 
> [7/7] RDMA/siw: Fix qp use-after-free in siw_get_base_qp()
>        https://git.kernel.org/rdma/rdma/c/ef15197f81ffed
> 
> Best regards,
excellent, thanks.

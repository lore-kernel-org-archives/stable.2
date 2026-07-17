Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423653E9589
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281661; cv=none; b=pDswEdTUJN+AWx5XBIo0mG90mtDa2zk+V9fevCMpvPsqd+c75whM5LYT+laV767f4w386R/jeeVb4MvJJB3gXNj2SvzWOHIaDxZgTTOfoziGuOVyWRRkfhnV+iaCHUFg7bf3++GXvpRV9EC9bGaXDVYSNTsN5xUO13ynNDywZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281661; c=relaxed/simple;
	bh=SA1xMJwP+nvYyGy44ETv4g2iY2c92GT627gCU7j/mvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdaHiqcgQP276qpdtfq2y7hX9JLsKR12C6q9qQEZEVbRFCGK7ugqicY7HietjGHup5ajvEJnbxbKkaJ06JljrpH1jG1xoemX/hglKI7pYgPvNSK4/2MfofuIn9WoNnTmmry/bHaNX0mJm7sULYjHor7HIlvSbCcSpckbPTG8iYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UU7k55Gb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=itb+PeJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UU7k55Gb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="itb+PeJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784281658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UfOzvi3ApW9raJzhRo6rILl0ALfG4yRcSmV5u5K+uI=;
	b=UU7k55GbCcSkwBq5uFBCnKdeGSmiqvR6lew60/LXquZdfA59qwPQRi8PGY2l2etTvNMjbY
	y2akSSbghmrEn8yn177ChV45PfTFAGpjHrwVktKugfeqKqt+JZn/EnZdRT4XgcxdiNvAJ5
	Aevjkb/xrUqR9au4dQ1C9s5rfy2NqK8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-ZNsICBrKMR2hI0A-_vI-_w-1; Fri, 17 Jul 2026 05:47:36 -0400
X-MC-Unique: ZNsICBrKMR2hI0A-_vI-_w-1
X-Mimecast-MFC-AGG-ID: ZNsICBrKMR2hI0A-_vI-_w_1784281656
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493b54823bdso7654665e9.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784281655; x=1784886455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UfOzvi3ApW9raJzhRo6rILl0ALfG4yRcSmV5u5K+uI=;
        b=itb+PeJSzc6EZjwvg/qhcMyQ0i1CtsU6aXAZNGj1z5fB6qiMdxz8y893yYzTxgokoL
         g9OMYcRFMNCnsyVTTXVHRSsf254/J1JW1uFVGyRpZ9KQnH+abAiVfQZhcrtWhm/cipfX
         sSYzdUMEmzxM32TXpUu10CcGBmpTGYbPbAvG0I0DL2ZO7pOoIVbhsMfsgm5qngFxPhea
         4AFddnfu1QW5A7CgsgdZcOMXyyt6ORY+Ie7g0qk8ZsEFP1+pmAjzzppa/YRp2oPBa9DF
         +U4Dwigs19DXAtIRRoidbdQSBK1JBoPamZ3EO9xNJdyvh4TiZ4XFWKqLbInVSDj3aEjw
         rQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281655; x=1784886455;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UfOzvi3ApW9raJzhRo6rILl0ALfG4yRcSmV5u5K+uI=;
        b=adAkF+DypNM27fXfuqasZoEVIt/TDO4+CxyKS1W8SxrRx7THu/OIK7i5pV2l4HZ84j
         DPz0raAlW8XrcBqhr+QGNsgFOX0QxAPOZsvAiI8CmsR0eI0SYF4MlPwMBBDMTKTzA+PV
         jbwo0wUoMyYdq8LdakrLmuGxyFUz+ODaVhehetJv/gStne82e6l6IAoorc2u3asSyW+o
         ZMuwLkYUstXh8YIQ2EW+aXTloxTm2KzXknHLcuIKbvGwA1EShSl3v2bm6QjmnkqIl8tR
         u2cWeYuVzGgQF9uneLQVQwNhShBP5v0YsJrOEKQUr7bnV2glKBPhPUfwb5R27LsxxzBb
         gFCw==
X-Forwarded-Encrypted: i=1; AHgh+RoastD1atJm23PE4twEfUF5e8s7e0JR85pPw3d73yLOWWCPUDst08rmyY8n3bNY0++eETXV08o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpTe5chWhJ/M0hfIHe7QYIYAG1FDkukSJvTWWIRQhW96/MugH
	xjuWzUihv/5EMY4bYp4EtLje1oH/qpkV0i7GwPuwcS+ImwsriAh6VdDjJmQGPbugRa+iJmQfyve
	hqG5uBdAeq3uDug5xH/w1GBf/KhYKCt04V1Rsh9jTkWfd6agvXAqEObocxQ==
X-Gm-Gg: AfdE7clmdoN+wqC7bjiWNez6kuk9HBJLRC6o9VHv27vGy60XcQtS0NYKSjFxFkfzhBi
	LLXxGYtEE3daicXtfOGKsofsWEehkrtiAKKvQEcTlnW8OFH8pj++6PkG1cD1Rp5UlH8+/TSy4eX
	0Lk5yx65qW7IwNYasD77SV5YaOXzSbrzGPgI+wpgM3C7HX8+DMm+ZL2v3SXHXqDFWWtGn0+ye/A
	nBFNvPqHcioki9yxui0wD8DlJ9PfOV8FflK3rsv9CL4M9JvS8i0a+V9cyqKSeHCFh5+zJQAiZEh
	u1egIns8q1MeUirCM6pdX+U/E0cgJHRwQWW4D4Fbdol+p9fnXlMALCIAVM+BJ/4+QikaCMSn5Eg
	xCUE2uDkvK/SOhqDrCWYiJkdbxq45aKEJ5zR44q5lSjcX+nfieuyFOKzNYoMHLFt/BsPtoA+1QF
	zA8A==
X-Received: by 2002:a05:600c:35d1:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4954aa1a34fmr16278935e9.5.1784281655568;
        Fri, 17 Jul 2026 02:47:35 -0700 (PDT)
X-Received: by 2002:a05:600c:35d1:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4954aa1a34fmr16278655e9.5.1784281655105;
        Fri, 17 Jul 2026 02:47:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm35888375e9.12.2026.07.17.02.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 02:47:34 -0700 (PDT)
Message-ID: <62b9c471-e6a0-472b-a549-81128cb9a8ac@redhat.com>
Date: Fri, 17 Jul 2026 11:47:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: free mlx5_st_idx_data on final dealloc
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed Michael <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260702222507.1234467-1-zhipingz@meta.com>
 <9e4e455b-c10b-447e-9fe6-80672f26fd8a@redhat.com>
 <20260713080816.GA327832@unreal>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260713080816.GA327832@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 10:08 AM, Leon Romanovsky wrote:
> On Fri, Jul 10, 2026 at 01:25:45PM +0200, Paolo Abeni wrote:
>> On 7/3/26 12:24 AM, Zhiping Zhang wrote:
>>> Workloads that repeatedly allocate and release mkeys carrying TPH
>>> steering-tag hints (e.g. churning RDMA MRs) leak one
>>> struct mlx5_st_idx_data per cycle; kmemleak flags it as unreferenced
>>> and the kmalloc slab grows over time.
>>>
>>> When the last reference to an ST table entry is dropped,
>>> mlx5_st_dealloc_index() removed the entry from idx_xa but the backing
>>> mlx5_st_idx_data allocation was never freed.
>>>
>>> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
>>> struct matches the lifetime of the ST entry it tracks.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
>>> Reviewed-by: Michael Gur <michaelgur@nvidia.com>
>>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>> @Leon, @Saeed, @Tariq: just in case this fell under the radar, it's
>> waiting for your ack.
> 
> Tariq and I completed this on Jul 5 and Jul 6.
> 
> https://lore.kernel.org/linux-rdma/20260705141920.GI15188@unreal/
> https://lore.kernel.org/linux-rdma/0bb37f75-c94a-4a10-b115-186b71daf14f@nvidia.com/
Thank you for pointing out and for the review. PW lost track of it,
likely because there are multiple copies of the same patch/revision and
only one of them landed on the netdev ML.

Applying right now.

/P


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D490419313
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682759; cv=none; b=AnLJJC87UuaaJDLF50BtD2+yxpjsS9XejKuBiWRhcKROniRNExb6zlf8t2UPnvP0eJ3UEB4f4DmEYeUPvLGwxcnS8+rh3uy9yMs8BcZ1YDfAS5oLE4Mm/i5OcFugUYas3m+NtKyCtolIQkqp70IRVxOmTA4XQ1BDDdaeRkvbTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682759; c=relaxed/simple;
	bh=+O+11YFkdR9m/DePEM0XGB3bOHAzHPG87B7si8jQV+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQUo5B/znPb3Ad5y4OnXF+3aF9CjfegpHuMO3WTBjvqJQbhwl+wv80npNkPAM4Zt3qnkQv/k6qFEbJgpV0tVdWAdaBX8o1NYlTv56PG8QSQ+oHcvjkDmPIZn/X5/bbX1m8woGtBnjhM68dsAi4iTM+0yd32A7RKWwq/QgSsQvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzcaPLYd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/KvVqan; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzcaPLYd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/KvVqan"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783682750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnpNr4qDyHoNfCA9ul8yyjujzs6stkD93LOWV1wBtX4=;
	b=GzcaPLYdk8gWU6NHu4Ga3NABE6sGenZl+2wRYIXJK4mUrDlxcrS+wOyWWLagycwQnxzEPQ
	dMr5s1rBx5Q1Uz5e1KjTNASaWPihY+shC9l0t8uFrMd4tzjdE/2hjYEZgBmRik80jF0Rzz
	AEtBhagqXwpoEZatLUOort3pHcCrBy0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-0xnAWNcZPEOcmKUoDsUtsQ-1; Fri, 10 Jul 2026 07:25:49 -0400
X-MC-Unique: 0xnAWNcZPEOcmKUoDsUtsQ-1
X-Mimecast-MFC-AGG-ID: 0xnAWNcZPEOcmKUoDsUtsQ_1783682748
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so7518825e9.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783682748; x=1784287548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnpNr4qDyHoNfCA9ul8yyjujzs6stkD93LOWV1wBtX4=;
        b=U/KvVqanNrJvUDoGPkv6jPbxvd9cenAPVqwmR41CQlt1xPFWD6t22GK6q7mA2fC2zz
         wkT7CMlIrjsDgQj9jqnIXgtDGD1XbG9hXWzmfL7zyu/DaX0fYCi2WWa1Oi+AFT0aNyi3
         CKb0sxctn+8K3mUILhDuoAv8xvOFq3Z8wD8NWC+k4sYZB3EnC/kdxQ5S3Feo7lqoCc/N
         U2V+dJrcSxuYQ2womTf4h2b/GAoGd7Ryga/lsqs1IDxkztE1h8yeGz4Lh/xaJNAgYnuM
         MfGWDlYapVbpIixP6VTYD1hnO5x+QPnFAKrWAoJjl1pBlBo2YqR43hh5d8IvNHqRAR5g
         F7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682748; x=1784287548;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnpNr4qDyHoNfCA9ul8yyjujzs6stkD93LOWV1wBtX4=;
        b=RAQTUcsXTX2T2Xd+NNK2/MixdlDTaSuhFeh7wgNyC1+xQ8srIERUzrSoOMpgVoMlab
         Wa9FovK/g2az0d6GEFAUT2ReXu8HxCM3tZ8S07pfdce88BQNcmDyD0EHFN7pQe1XsEle
         0DEpeCnpZPIE6SPwIPH5iyXuFePwS376+zsOwQB7Ml0o/ereTdg8XnRU7WmWj8k6JbV6
         1pgYe7a0M+DNiH1a/hBwWYWOxNs6/JSvAzHC/5/WrUMFcZPNIqaBT//gD43EGGQ0lKy+
         CoLeMwM3OkFt3P8NJOteNhoNjXW1GP8y1CoJNCXOFFaoubjwUSpR0re1TUhaqO83L0kV
         wBDw==
X-Forwarded-Encrypted: i=1; AHgh+RpkZ1vjxulUtyz0OfiEzYi9djwV2gVZGYhVrf9Vm2TF8lyLtGERLvObZ7AkH9JjUZyFQfXWXPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEy1yuETNx9L/WahukSMmHJtq0e+A3sWVfnGYllTPL1AGBwsS4
	ttVsv69HlcdCV/VbZxN/FEm78HJUSYFlumzuKnTfx5I6rALaDMIBPwmL9outers6jFD1/dFWkl/
	0ic/qMhMJvKCE2t2H8L4DR5Dy4apN3upqZXTyVV3xxJpA1D2wM2PLbHQwCQ==
X-Gm-Gg: AfdE7cm5tSAIuapSQxeXTpbwJW8SvfLQCmrDXgkT7R4IE5kD5PkmR7KWbDUAR195M+W
	bgSo9wiQmeQIIqPTscRNDITR1Uuhe5Y3U3pI1HqGQ59uWQ+9SuKrnZA4xuRar1HxF+z1UyXgwtk
	nI7uLjTEcsyq5bIMh8H2VLoim5DKu6LzY7tlUxL0VlFMEt9cIFRZ3WmJFovibLiggdETqSUo2xQ
	tdaioLt55VBrvT54LUicZZW3HaqkrycMv90ewLAfcjOro+lbj155gJCK/xjwuivW5Ltte5mSWnl
	XgLrEDUN3x3ePtpg6LPYo87A2pc5OvNopTxTSyPOI7zdQ5BtsWkmjTb9aILTxR8kraEISAU0XEb
	T22ggiEaoHoT4tQCpAGCeoj8XzB1HVCPkCNw2mXKamMl10wuEfP9KK0nIBXw1/es4Hez/AQNL6C
	dnqqvwssb6G4Go
X-Received: by 2002:a05:600c:3115:b0:493:b4a3:5ab0 with SMTP id 5b1f17b1804b1-493f2b3fe2amr28786165e9.13.1783682747871;
        Fri, 10 Jul 2026 04:25:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:493:b4a3:5ab0 with SMTP id 5b1f17b1804b1-493f2b3fe2amr28785735e9.13.1783682747323;
        Fri, 10 Jul 2026 04:25:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d4f9fsm131494035e9.4.2026.07.10.04.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:25:46 -0700 (PDT)
Message-ID: <9e4e455b-c10b-447e-9fe6-80672f26fd8a@redhat.com>
Date: Fri, 10 Jul 2026 13:25:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: free mlx5_st_idx_data on final dealloc
To: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed Michael
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260702222507.1234467-1-zhipingz@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702222507.1234467-1-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 12:24 AM, Zhiping Zhang wrote:
> Workloads that repeatedly allocate and release mkeys carrying TPH
> steering-tag hints (e.g. churning RDMA MRs) leak one
> struct mlx5_st_idx_data per cycle; kmemleak flags it as unreferenced
> and the kmalloc slab grows over time.
> 
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but the backing
> mlx5_st_idx_data allocation was never freed.
> 
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
> 
> Cc: stable@vger.kernel.org
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Reviewed-by: Michael Gur <michaelgur@nvidia.com>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
@Leon, @Saeed, @Tariq: just in case this fell under the radar, it's
waiting for your ack.

Thanks,

Paolo


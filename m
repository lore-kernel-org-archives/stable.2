Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D86374E55;
	Tue, 28 Jul 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235441; cv=none; b=YMsnulEVFj9Yu+ZJuCX3/z4U21SyhqHEUJJbGIJMFU2nWpz0o0qabKV/AeBLTgjRqTPDS4SO6yldugsZhPWnfluAIxf1bRSz177aEzZZZkEi93fwFW48cOXPnG4N0BJvinXSAdwnIoVOcB4bAK4787WvTNOIG3pob2BWWGxoYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235441; c=relaxed/simple;
	bh=2MEGsjiVUWIncw7bHEtjrSMP6uHCi3QJemaFP6ImaFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XI1m/TNZ2iE+p+b1wp3c85xwm+tvygJftvhbiG0btWJ5iVwkTdk8yGzmsxGhYK2wkMGuXo48JNt+e+lrm053Yel1as957hthxN0EQD8XOgpb9VGCdBfCF/Ck+P8vdiCAaRgZZu9p2jGe4krx0jXSs9iX/YFaCcGwvLFUEiZM59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w5me3cRz; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w5me3cRz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785235434; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3hYXxIfCvmjZNqGEczvEGUPv4Yuv4qYqFUL8pqGAUA4=;
	b=w5me3cRzIlaywtqDYKwbDOKI4nAbhgRKMmKjFjVQuI2ITr+DI32Rt0I3P/rFJlcOAFGF6Hn83QKD5zA7RCKY++If2Bu49ZbD5pvE0wmuTvHy7v5MFpG+gtO9vXvxscVqZ7Dio7k0g6mjqx5QUqFWBLvZyMKni7HSUXELFcMobvQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X8-cwzV_1785235432;
Received: from 30.221.129.64(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X8-cwzV_1785235432 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Jul 2026 18:43:53 +0800
Message-ID: <74589286-d967-4fc1-b044-1f9b2376c94a@linux.alibaba.com>
Date: Tue, 28 Jul 2026 18:43:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y/6.12.y/6.18.y 0/2] bpf: Fix ld_{abs,ind} failure
 path analysis in subprogs
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: daniel@iogearbox.net, info@starlabs.sg, ast@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, mykolal@fb.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, dust.li@linux.alibaba.com
References: <20260722073908.72382-1-lulie@linux.alibaba.com>
 <20260724105500.stable-0001@kernel.org>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20260724105500.stable-0001@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/26 7:22 PM, Sasha Levin wrote:
> One follow-up: the Fixes commit 09b28d76eac4 ("bpf: Add abnormal return
> checks.") is also present in 6.1, 5.15 and 5.10, and the fix is absent there,
> so those trees are affected as well but were not covered by this submission.
> They likely need a further adaptation. Could you extend coverage with adapted
> backports for 6.1/5.15/5.10?
> 

I've posted patches for 6.1/5.15/5.10. The 6.1 one is identical; 
5.10/5.15 required minor adaptation.

The selftests patch can't go into any of the three trees due to missing 
dependencies.

Thanks.
-- 
Philo


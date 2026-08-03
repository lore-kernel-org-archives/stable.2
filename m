Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C034DB72;
	Mon,  3 Aug 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774559; cv=none; b=fI2YYv+F+C2bJ3u+VnAQlDGr7Rvh+Cka5xPzZzvtTGNI8OQRwFfdYaOTaDOcFuvdEQULRLzImJs4jOoqr8vg+bpFP1xENpuTYcYY4ND56dO9wso38kdiViLjCgFk9PLl/0M5GMuewpSgVH+K+6z9V3zz8w3cPyxNoWRSpIeKX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774559; c=relaxed/simple;
	bh=faOivm577K9+uwYplagHcU5WqGset1aBEvOPfnSuMB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=solF7ajvPmoJOyihwGx6lQoM+U0KoAJ2adfElUYtT3fCU9jtg6LJ4XH8adZ0OVoPPl9R4plHPBvR7+DbOTbCPxN6/xvpuuGsCVmgPfFDbOGeIhljN8jlXqSuPoOO919yIxdsARhq9xekkIEB9Mc4pJ7EOkgqANjWECk9vrnMH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBwa89Tu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBwa89Tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877411F00A3A;
	Mon,  3 Aug 2026 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785774558;
	bh=VTJEjMglHaP3Q9CuRwRgsauX04grHbmCrNe5pDLVfwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RBwa89Tux9uVDlpeeU9GdrQNagoRxTsNuISbe+nJLtgIepv7UdV7FwX1a6HG0Pq5h
	 dB7BYidFVRrjPaR/+0nLyin2AIKyBNLfvQv+ws4IAdW8pa4dftP7NRg7HiXMGgy3pK
	 4NpZZYGTjSGs7v2l3gFgBXQj3uRXmPOA83DT/D5EytoZdqOf1bVQ58/UBhP11ZZYAf
	 XlOMUj0cbOD7sP1pB55xXRUVczObxKLQXu8ri5gqDP8XpFI9D+c2wFoLra0F2qtsW3
	 klhBp2haG9mvTiNtPFTPA4+tCuzaYSfMha25EunobsT2nB5CMeBPFdsrEjrlzrXiVL
	 29tOEkICjtCMQ==
Message-ID: <c746110c-6ac4-4500-a4f0-491a06838173@kernel.org>
Date: Mon, 3 Aug 2026 10:29:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Avoid uninitialized reads in topology sorting
To: Ali Ahmet Memis <ali@iusegentoo.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "John B . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <7fa98ba5-6790-48b4-b102-c1193685822f@smtp-relay.sendinblue.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <7fa98ba5-6790-48b4-b102-c1193685822f@smtp-relay.sendinblue.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 20:07, Ali Ahmet Memis wrote:
> 
> get_cpu_topology() allocates core_info with malloc(). If a topology
> attribute disappears while CPUs are being hotplugged, an error path can
> leave core_cpu_list uninitialized. __compare_core_cpu_list() then passes
> the field to strcmp() while sorting the array.
> 
> Use calloc() for the array and ignore entries without complete topology
> data when counting cores. Besides avoiding the invalid read, this keeps an
> incomplete entry from being counted as a physical core.
> 
> Fixes: f89cb9cba7a2 ("cpupower: Implement CPU physical core querying")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
> Tested with a two-CPU topology mock that makes the second CPU's sysfs
> reads fail. Valgrind reports uninitialized reads before this patch and
> no errors after it.
> 
> Build-tested with:
>    make -C tools/power/cpupower NLS=false CPUFREQ_BENCH=false

Sorry I am not taking this patch.

Please note that build test just verifies that the code build which
fall way short of testing the changed code.

thanks,
-- Shuah

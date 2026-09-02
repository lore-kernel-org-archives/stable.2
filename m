Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195347799F
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351718; cv=none; b=bh+YdHdJf7RXlOsfhhoqDiQ/EYpMCo/oZTOJAqaSBpJmBHcCXgt2v74xkef6l9oO4v/+VSxBaSfuFbJIc1VqdXe8bSdBPAB0Qka2mYyLXoMBslR2hKtz/Y8NxxH7pUU/4WSLxhw4cqffUOSq7U3XG4Owod/RZw9twGobYWDVGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351718; c=relaxed/simple;
	bh=rlu5Rd80uDj5OZSktQzoh4LfD072PmuNHzuswlgtrcM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WIan09yvqGYBufM+8pCTgUcjqDr+2bdWGkuSEyxUZRJ/55J+nvU5t4dH042+n5fi0V+rzPWacx0uHZCaGXO2IpMpsB2iGsvlZReo8bw9QRgytd7YqZd3My0GnyNcqIHHPSGxmAlN2FNDoPHMTx7Nt+IsjEUtZNb5ntlJC8TZ7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZTjz5kIL; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZTjz5kIL"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rlu5Rd80uDj5OZSktQzoh4LfD072PmuNHzuswlgtrcM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788351714; v=1; x=1788956514;
 b=ZTjz5kILiP0V5T+ye7EjXR4ulNpqA/Dc7pL2tdoevGXaGEzHDdlPD1yU6NUpHZ07Xz58ZT7J
 BdggT0cyMmPuoV5fZhl5mNpsUbFq2cYnXB8aZ+PqsBh30Chp9qcFQ7VGFniTrk3lIdwGd43GsgN
 ndszh0vX1w3s6G8fd/o+1IYs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 672e099c2adfd448;
	Wed, 02 Sep 2026 12:21:44 +0000
X-Mizu-Trace-ID: 672e099c2adfd448
X-Migadu-Flow: FLOW_OUT
Message-ID: <5e86d83a-425f-43d9-91d3-06821ec670ae@linux.dev>
Date: Wed, 2 Sep 2026 20:21:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] LoongArch: KVM: Fix PC double advance in kernel MMIO
 read fast path
To: Kaiyang Wu <wukaiyang@loongfans.cn>, Zeng Chi <zeng_chi911@163.com>,
 zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name
References: <20260723111552.1623996-1-zeng_chi911@163.com>
 <D7B309C007238053+3831de19-a2c3-4f17-9281-e4e355c6c464@loongfans.cn>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <D7B309C007238053+3831de19-a2c3-4f17-9281-e4e355c6c464@loongfans.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Kaiyang

在 2026/9/2 18:12, Kaiyang Wu 写道:
> On 2026-07-23 19:15, Zeng Chi wrote:
> 
>> In the in-kernel MMIO read fast path of kvm_emu_mmio_read(),
>> kvm_complete_mmio_read() already advances the guest PC via update_pc().
>> The explicit update_pc() call right after it advances the PC a second
>> time, so PC moves forward by 8 instead of 4 and the instruction
>> following the MMIO read is silently skipped.
>>
>> The user space MMIO read completion path in kvm_arch_vcpu_ioctl_run()
>> calls kvm_complete_mmio_read() only once, and the MMIO write fast path
>> advances the PC exactly once as well.
>>
>> Remove the redundant update_pc() so the kernel MMIO read fast path
>> advances the PC by a single instruction.
> 
> Hi Zeng,
> 
> I have tested the patch on Proxmox VE with the environment below:
> 
> - CPU: Loongson 3C6000/D
> - OS: Proxmox VE 9.2.11 (LoongArch port https://github.com/pve-loong64-port)
> - Kernel: 7.0.14-15-pve
> - Guest OS: Kylin Linux Advanced Server V10 (SP3 2403)
> - Guest Kernel: 4.19.90-89.45.v2401.a.ky10.loongarch64
> 
> Without the patch, the guest system could not boot with the 4.19.90-89.45.v2401.a.ky10.loongarch64 kernel and there was no output in neither tty nor serial. I can confirm the system boots from the same kernel version with the patch applied to the host kernel.
> 

Thank you for the testing, this is really helpful.

Our test setup is a bit different: we were running a 7.x kernel on
both the host and the guest, and we confirmed the issue by observing
that the PC advanced by the wrong step after an MMIO read.

Your result is a nice complement to ours — it suggests the same issue
may also explain the boot failure of a 4.19 guest on a 7.x host. We
had been debugging this boot failure for a while without finding the
root cause, and had assumed it was some kind of version
incompatibility. Your testing gives us a good lead to look into.

Thanks again for sharing your results.

--
Tao> Best,
> Kaiyang


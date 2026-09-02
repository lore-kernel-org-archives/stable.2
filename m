Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA0430CE5;
	Wed,  2 Sep 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344001; cv=none; b=Hob/3dPkt82mtvTvBWKJ4hIqjEeqrdt2mUU/LMD47F8+kkjsIPRMDGUTAT7mEVHzRRuae8eAaYIpgRuYOx4j2+dwrkfgx29Ai5B2+Of58Y2cQaLJESz5oWVgxkIji1OpnTk3U3h+7o7SdymZSNQfv3kj5cpGMz1ojwujAjtG92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344001; c=relaxed/simple;
	bh=ZUoMNsOCoWo/VAeuw4DjeREE/aycd6GLB/a4qUZb4VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaKEwOp7JOo1zSgccK4ou2RHCj1exl7mwKDracdUm3N53+7uOGXa0LPQsFvSVSyLUB41K93Fa09ay3A8u3oZUIpMpo1vHk3s981ZikiGEb1w4g2odERqqtP7V9OHgsj7CTtWqrTcD+SWIuJykpfqZwmz2qjJqtwArAhdt0AUgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongfans.cn; spf=pass smtp.mailfrom=loongfans.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongfans.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongfans.cn
X-QQ-mid: zesmtpgz4t1788343956tfea4d5c6
X-QQ-Originating-IP: nx7JF0Fpqcfom8ip4fdPrl+Ybn0XJOHnooR0QK7t2OQ=
Received: from [198.18.0.1] ( [223.104.163.80])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 02 Sep 2026 18:12:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14151464018762602530
Message-ID: <D7B309C007238053+3831de19-a2c3-4f17-9281-e4e355c6c464@loongfans.cn>
Date: Wed, 2 Sep 2026 18:12:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] LoongArch: KVM: Fix PC double advance in kernel MMIO
 read fast path
To: Zeng Chi <zeng_chi911@163.com>, zhaotianrui@loongson.cn,
 maobibo@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn, stable@vger.kernel.org
References: <20260723111552.1623996-1-zeng_chi911@163.com>
Content-Language: en-US
From: Kaiyang Wu <wukaiyang@loongfans.cn>
In-Reply-To: <20260723111552.1623996-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:loongfans.cn:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NbnE26TzD42gdhQUAYDIttMSR8YjVJp87rIeOE8+PsZ/VPsL/0doFYGg
	ReTaPOF7MRc7n3BSJFw9uzrfU73CZQKFaDLK029sOx50+O5yp+MoKc8FugLmRak516QK2xc
	Kz5APbSQp4lCdvXfDusgB7VCh+C58gsWWncpwvId40hE3WhDSZSXV3q2r48ygHaE2AA3gQE
	Kbco2v049QzNYiUqniGv7v2cuOQOWw1PR7ZhJPmOk+jRyft776DvsBPjQVKSG9qY+l3imBF
	E/rguPTE1oKHaKoJ0clOMpoMiKbiz4Rf1axeLTdcP54tvXDPHzho31FKjcN7JPmD4dAyC+V
	RJJc8OhJWM//6IoaMi4Pi6rgMT4TfLMeH5hzXZKFzmE7HTyQhdyE6l3igGaEjDIdycxlhny
	ohCdd2MxT88PSvmLW8SXrLXWjcymiHKdhNk6kBfxskng8uB93bw+HK+ObQNBdqvxHtA1nZ0
	WzxwXgmyl2TqnxXQzpvm6RRQ4Wmexj04PAX3rX3fJ8129dqOAnmXdcRC3BoEzhKO4Cu8/D5
	n425nenpoO9HLaKSYmhIdmGOWigfkECQgmVfPLnQUCSXrooKtsShHOtSQf2nicyRn5lG5gs
	0j97OWR9nRlSN2OS73aixdg0YSR09Gns2P/ALIwhhlpZitYRxWJ3sQUcv3KlNnsfZmHD52R
	FGetfIpIJFwD8O33HfkblgNsNk16QE6ybmJZbO6aZ6ajFjuNEj8TJajPbwfbpAg067TFGeN
	LtCZctGvnXfQtt0Bx0ejgT2feu0pYy183k7biDdy8Mv5BcIbVmszYf/R+6UZa63sFtdaNSw
	TDIkicn2mlrIN/LhZgiVeLQ5WyNcedzX1mEqyg5jDz30aPuKdaHXT34xNnckMwHziUgxq7V
	E/Z3yZGOY4cArWJ70YAEMEej9lof0MG1e2Zw+57v6xR8Gc2hqS0U4U17b24rp+Xp846x8CD
	7w42ddn5y7UHfl0aSFT4DUHd4bjzogoKDp2X55eamld47bRJNH+gBzcLwCVOpG8xGYz/7rz
	rqTKZfr00LXwEjTwLF0KiO2+cxcJTo21nyRE77gxfnu73jb+/CjF8j6badzOxdoR9XcG+4h
	Bki2XsnHBsoArlDNqOd2BLPKQEJ5CV1Gj/pszhOFMaw
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On 2026-07-23 19:15, Zeng Chi wrote:

> In the in-kernel MMIO read fast path of kvm_emu_mmio_read(),
> kvm_complete_mmio_read() already advances the guest PC via update_pc().
> The explicit update_pc() call right after it advances the PC a second
> time, so PC moves forward by 8 instead of 4 and the instruction
> following the MMIO read is silently skipped.
> 
> The user space MMIO read completion path in kvm_arch_vcpu_ioctl_run()
> calls kvm_complete_mmio_read() only once, and the MMIO write fast path
> advances the PC exactly once as well.
> 
> Remove the redundant update_pc() so the kernel MMIO read fast path
> advances the PC by a single instruction.

Hi Zeng,

I have tested the patch on Proxmox VE with the environment below:

- CPU: Loongson 3C6000/D
- OS: Proxmox VE 9.2.11 (LoongArch port https://github.com/pve-loong64-port)
- Kernel: 7.0.14-15-pve
- Guest OS: Kylin Linux Advanced Server V10 (SP3 2403)
- Guest Kernel: 4.19.90-89.45.v2401.a.ky10.loongarch64

Without the patch, the guest system could not boot with the 
4.19.90-89.45.v2401.a.ky10.loongarch64 kernel and there was no output in 
neither tty nor serial. I can confirm the system boots from the same 
kernel version with the patch applied to the host kernel.

Best,
Kaiyang

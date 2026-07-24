Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58DE4908C9;
	Fri, 24 Jul 2026 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856241; cv=none; b=pjcvgnR+5VvXaRl+Onnp/5aegTmrQoCqeeSYZSlf0x+2AJ9Du58VC4psQqIAbVklJBbfQTA33CsQJ4YeLAPEQ+fPyJVVXjd0dx8KPeiGKWmFlo2933gwlTVJ0K64iuSySmu9UaB3fKwl17Fte3Se1aUugACntXwGasMr8NJOzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856241; c=relaxed/simple;
	bh=taN91dFcLCpwpbFxf+d9rzxKsaivBEyRJUX8U5ebtpc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RBlKOQlYjgxExIvifI4dpHzfa2TaRbz7zodGeTNCvZ4t+a8LC6C0ge8cVdvwIQ3FgH9vsmJ+LSlNzXsZLKkDF1gK86xUidMfXbqdujKgHykmLNDTikFmp5w78fA163C6WacVeJNY83hcuR2Y47c3ZomteJLwGagUwWBnOIZ0G9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxKfCpvmJqycQGAA--.25239S3;
	Fri, 24 Jul 2026 09:23:53 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxq8ShvmJq__MWAA--.3360S2;
	Fri, 24 Jul 2026 09:23:47 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: KVM: Fix PC double advance in kernel MMIO
 read fast path
To: Zeng Chi <zeng_chi911@163.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn, stable@vger.kernel.org
References: <20260723111552.1623996-1-zeng_chi911@163.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c7d6c9ab-9df2-89fc-0a2e-1389b6f5d3ed@loongson.cn>
Date: Fri, 24 Jul 2026 09:23:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260723111552.1623996-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxq8ShvmJq__MWAA--.3360S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry7GF4kAFW7tFy5XFyfKrX_yoW8Wr15p3
	45Z34rCF48Jr47ZwnrJ393Aw42v3yrKr17WF13tFsaqr4qqFn5WFyFkF4DuFy3KwsYkw1I
	q3Wktas0ka1UAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2026/7/23 下午7:15, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
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
> 
> Fixes: 80edf90831a2 ("LoongArch: KVM: Add sign extension with kernel MMIO read emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>   arch/loongarch/kvm/exit.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index 8572b63478bb..482ba17bcd3d 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -481,7 +481,6 @@ int kvm_emu_mmio_read(struct kvm_vcpu *vcpu, larch_inst inst)
>   		srcu_read_unlock(&vcpu->kvm->srcu, idx);
>   		if (!ret) {
>   			kvm_complete_mmio_read(vcpu, run);
> -			update_pc(&vcpu->arch);
>   			vcpu->mmio_needed = 0;
>   			return EMULATE_DONE;
>   		}
> 
Hi Zeng,

Thanks for finding this problem, it is a big critical potential issue :(

Reviewed-by: Bibo Mao <maobibo@loongson.cn>


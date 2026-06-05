Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6E37C108;
	Fri,  5 Jun 2026 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623893; cv=none; b=jPwG2qr6c+PFhtfV/K2/iq9ZxFtTr6pltdH7hm3MuuwVpH6E/ypxmNBiPE//jmn6KaBryoQy8AexsY8ESFXcOyj5D9hqvJXRybPz6YTUSDX96tsQBiJYU3cnN67Xy2Oe8WrgYrJtKPj0DmsSUdHE1+lTh6B2OdrNsMiCmo6hNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623893; c=relaxed/simple;
	bh=R6w7HRslqNWOn2idpFVjzHryPc8448YIPtHxHthf7R4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qx82vsz7csLTCWqQ2LjfSuZfgC5mpP7blXi0UQfW/+x45pPskAVDg+sHYK91Quo0zSc1WCW5q3iA9klTJG3/zFCVZyenq1PX65ljbUMPS4dN07IktFi7PI0yo57mpk+0BpQ8ie1ONz7BUK4mb/FxDuqGJzGVRLBQK0yEECsnK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxncAKKiJqd8gQAA--.22245S3;
	Fri, 05 Jun 2026 09:44:42 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCx2+AGKiJq+2ycAA--.34930S3;
	Fri, 05 Jun 2026 09:44:39 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: return full old CSR value from
 kvm_emu_xchg_csr()
To: Qiang Ma <maqianga@uniontech.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604123433.3182173-1-maqianga@uniontech.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <08d3b817-9de6-746d-2b2c-acc4a578f95a@loongson.cn>
Date: Fri, 5 Jun 2026 09:41:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260604123433.3182173-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx2+AGKiJq+2ycAA--.34930S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4kKrW7ZF13Wr1rCF4xZrc_yoW8GFWrp3
	y3A3WUCw40gr48ta47Wws8Xrs8ArWDGryIgF9FyFyUXrWayFyrXFnYgr98WF1q9w4Sgr1I
	qrWSg3s2van8t3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==



On 2026/6/4 下午8:34, Qiang Ma wrote:
> The LoongArch CSRXCHG instruction returns the full old CSR value in rd
> after applying the masked update. kvm_emu_xchg_csr() currently masks
> the saved value before returning it to the guest, so rd receives only
> the bits selected by the write mask.
> 
> That breaks the architectural behavior and makes a zero mask return 0
> instead of the previous CSR value. Keep the masked CSR update, but
> return the unmodified old CSR value.
> 
> Fixes: da50f5a693ff ("LoongArch: KVM: Implement handle csr exception")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>   arch/loongarch/kvm/exit.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index 3b95cd0f989b..264813d45cbe 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -103,7 +103,6 @@ static unsigned long kvm_emu_xchg_csr(struct kvm_vcpu *vcpu, int csrid,
>   		old = kvm_read_sw_gcsr(csr, csrid);
>   		val = (old & ~csr_mask) | (val & csr_mask);
>   		kvm_write_sw_gcsr(csr, csrid, val);
> -		old = old & csr_mask;

Hi Qiang Ma

This is correct from the manual. Is there any test case or problem in 
practice?  I want to evaluate severity about this problem.

Regards
Bibo Mao
>   	} else
>   		pr_warn_once("Unsupported csrxchg 0x%x with pc %lx\n", csrid, vcpu->arch.pc);
>   
> 


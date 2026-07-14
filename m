Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E696B3033E6;
	Tue, 14 Jul 2026 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996354; cv=none; b=rUWESPC7+sYin7HNuaA06/VEFFNrNHutiKvvZk3mb2DWqQyJrUCPWmDaKWMrLY3+5LCjsRfrHKmgpVTcKru8ufdOAiGHJBpEhCoqM2AdT3l3At9m/aDAPLjMNh2H/H5DdXp2BCHHlFC8PKHCD+Y3sD+0NHvoEaI1wa8bChk8uXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996354; c=relaxed/simple;
	bh=x+h1ubtG+2wZwiufM4mHMA8AtNY8oxjrGB9PfBbtfbg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JgALy3NQlUe41u9pgwd8CM7sH2ZSEcNw0HNGouejs6mACqRpTI8UxySWMDa4SyalZLUYK2f1kTVXcaU57/d6GtJOVxGfT041k6jCfPA7e7arPnj1sGUYfERjaZ7kP6PM4Mr/S3lwAm5dPGZqCBna2/LRUKTb6uQOwvk2/EDCJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxNOq5n1VqBkUDAA--.11901S3;
	Tue, 14 Jul 2026 10:32:25 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxPcW2n1VqZlcMAA--.57755S2;
	Tue, 14 Jul 2026 10:32:22 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: KVM: EIOINTC: clamp ipnum to valid range
 in INT_ENCODE mode
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org
Cc: kernel@xen0n.name, lixianglai@loongson.cn, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260714012452.1021833-1-cui.tao@linux.dev>
 <20260714012452.1021833-2-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <69470d5d-6c67-c42d-b8f8-8c115599703e@loongson.cn>
Date: Tue, 14 Jul 2026 10:32:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260714012452.1021833-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxPcW2n1VqZlcMAA--.57755S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF15Xr15JryxZr4rXFy3KFX_yoW8uw4Upr
	W7Aa1YkrZ5Jr1UJay7ta15Ga1Yk3s5t3yUKF4jqa4xCFWrXF1YyFyrCr42qFyIkw48KF40
	qFW7Ca4ava1jv3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc-eODUUUU

Hi Tao,

Thanks to catch this, there is similar modification which can be located at:
https://lore.kernel.org/lkml/20260709082109.1361767-5-maobibo@loongson.cn/

Regards
Bibo Mao

On 2026/7/14 上午9:24, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The IP-number decode in eiointc_set_sw_coreisr() and eiointc_update_irq()
> clamps ipnum only in the default (1-hot) mode. In INT_ENCODE mode the raw
> ipmap byte (0..255) is used as the index into sw_coreisr[cpu][ipnum],
> whose second dimension is LOONGSON_IP_NUM (8), so any ipmap byte >= 8
> accesses the array out of bounds.
> 
> The value is guest-programmable through the EIOINTC virtual extension
> (VIRT_CONFIG enables INT_ENCODE and the IPMAP IOCSR write is unvalidated)
> and is also restored unvalidated from a migration stream via the
> LOAD_FINISHED control attribute, resulting in a host slab out-of-bounds
> access reachable from an unprivileged guest.
> 
> Clamp ipnum to [0, LOONGSON_IP_NUM) in INT_ENCODE mode as well.
> 
> Fixes: 3956a52bc05b ("LoongArch: KVM: Add EIOINTC read and write functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/intc/eiointc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
> index 2b14485d14a7..0c34d7ab264d 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -17,6 +17,8 @@ static void eiointc_set_sw_coreisr(struct loongarch_eiointc *s)
>   		if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>   			ipnum = count_trailing_zeros(ipnum);
>   			ipnum = ipnum < 4 ? ipnum : 0;
> +		} else {
> +			ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
>   		}
>   
>   		cpuid = ((u8 *)s->coremap)[irq];
> @@ -42,6 +44,8 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
>   	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>   		ipnum = count_trailing_zeros(ipnum);
>   		ipnum = ipnum < 4 ? ipnum : 0;
> +	} else {
> +		ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
>   	}
>   
>   	cpu = s->sw_coremap[irq];
> 


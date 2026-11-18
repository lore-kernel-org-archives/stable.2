Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996090;
	b=2pwKFeT0dYlYY0wIvZpJf9yE1WXEYpItr33NwwDRC3efymdmsVVUzpSaGO+b+EKIVkbZ
	 D1IEbMgj1KJMiIzCD4GIkeNYzL7ZRen5LetwLQGLKAhekrADRLpmy3Rs/RkAAQ4Gl2Knx
	 3sFCpQKRB+4z3Z71FeBGO9MUYmb3Hdx93DHQV3h1wdoCNN+b+oli9H+MEAdOLXeD5LnnX
	 UmtPk8Qn7ZDk6m7ySgivwOhPMEg4DwqGJETK22vOKqszga9Pl/Zi6NTl2pu401v78MmS0
	 2oGH5cizIB7hREzagzU+dHjQxEfZoYnaMnps+uNGi0+WYzxOIgJl8D41OUpJ0Gc4ROQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996090;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=UKWjVZpbhwfl1kXwmyPrP7TMuw/VD84DqotItrop890=;
	b=SZ7pzLHu4Wjh6CoJTZRQH4t5KWcMtBqV8tvmx78ZPhRFzgFnHP0nP8xO0QyAcfeIN5vY
	 pabucS6NAwT6kErqn68/wQdBiDy/Dq7jdHY+CgH7bu1EjE1/B6VSrQ9bYyy2W9o2pm0Ib
	 e7HBtWEl4AT2qddj24r0yvIrQ4oflpBG7Z52Aeeoxxcesvs9RVquBIqukC6MBP4eUuCCq
	 9JaaQl/9tssDhxcTPXtrlh3c7KDAg1DS62JCgbSSdARt8WhrPSwE5177l8DFBaffVxG7/
	 W/OgfgbW/NwfG9CfnpAk0AEal3n3gT0lHteNMLdnVMGGE9lrVacdNvBAOTHaRnB28wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B47606A895;
	Wed, 18 Nov 2026 10:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B47606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxntJ1d_1qJscgAA--.28616S3;
	Wed, 18 Nov 2026 18:01:25 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c50d_1q0JQ1AA--.41976S2;
	Wed, 18 Nov 2026 18:01:24 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: BPF: Fix the offset of stptr.w and stptr.d
 stores
To: George Guo <dongtai.guo@linux.dev>, chenhuacai@kernel.org
Cc: hengqi.chen@gmail.com, guodongtai@kylinos.cn, bpf@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261118071444.10258-1-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <25a0f5b9-93aa-7d80-423e-b283efcc4b89@loongson.cn>
Date: Wed, 18 Nov 2026 18:01:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261118071444.10258-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAx3c50d_1q0JQ1AA--.41976S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
	AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_UUUUU

On 11/18/26 3:14 PM, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> When testing bpf selftests "jit_insns" and "jit_insns_blinded", the
> "ldst_offsets" subtest fails for word and doubleword stores:

...

> Cc: stable@vger.kernel.org
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu


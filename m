Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794975291;
	b=L2qLWxUunPE3Txwo1sHMMClIrTQtMHrP15tNSMfi+0bo7BZtDjLFLdxUt3XKPD4KxsfJ
	 oquALALr1wAXa/kCnQnPQr1SqekbszYkHx5AeZqlAIdiPBEq9MviEWL52guN8KS3iRFXu
	 Vc3kVSIlWNJyB6gc5yiTAqdSs2rIsgJINEshHwca9hTZj7H9gcpLyBNrMjwfevAewntOJ
	 ZmsVYN9PrRly2RVMXT5SvyCmrRZqmOKjZLR/v+KWQ+7FgZr8bIG+/OJWj3ftmKQ7A/vV9
	 pa0GE9Dtl7M3s7mWdeJjF/H4OmMVozK5sEJKlFGEaDJmoCvq5BJI3LpfIo3X+76Aoeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975291;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=YaOJJ7N+YdkFsLd9dYhGoiJMuptcbuFjKbt7Cq4JOQQ=;
	b=jZosjV5xXlunOtgY+9tX7jhiJHIuxzDRZQxk1drDumrUEAPIDHHD2TSLLX9k5e166UmT
	 K6oVpS8fiT4y69wU9h5xkkJRsmT3NFSMUVjpIp9o3gtEccOTjbeO63PiBwhJ1E1tnBq+r
	 KMlZq30udrgiIYV/55950xGnfn25UW7JjC8xxzxabcDsBVo2kzb4Ejq3qIXsX3uJKxPvi
	 YWJvJcXSC/9WniwQLtScbY67GxMC5+RqkKrA2B+8RFV89dgY5kKqDvhf4gpVErC1RUr5C
	 g/Mn2OVaavilYNvAe2W9d4ds+F3DmuqmYwVgEt0j95YZyZpZyXB7XZC8CNAcUh7J4Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22CB606A325;
	Wed, 18 Nov 2026 04:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B22CB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxhvAxJv1qorQgAA--.28330S3;
	Wed, 18 Nov 2026 12:14:41 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs0wJv1qSII1AA--.65343S2;
	Wed, 18 Nov 2026 12:14:40 +0800 (CST)
Subject: Re: [PATCH] LoongArch: BPF: Fix the offset of stptr.w and stptr.d
 stores
To: George Guo <dongtai.guo@linux.dev>, chenhuacai@kernel.org
Cc: hengqi.chen@gmail.com, guodongtai@kylinos.cn, bpf@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261118030219.6230-1-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7226bf46-05e3-b52d-af28-aabf1d504929@loongson.cn>
Date: Wed, 18 Nov 2026 12:14:40 +0800
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
In-Reply-To: <20261118030219.6230-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBxJs0wJv1qSII1AA--.65343S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur1kur1DGry5Cw1kGF18CrX_yoWkAwcEqw
	nrC39rWw1rAayDJF17Kry5Jw4UK3WrAryrCF1kWr17AF1Y9r45XFWvgryku3y0g3y3CrWa
	9ay5XFyS93y2yosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU

On 11/18/26 11:02 AM, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> When testing bpf selftests "jit_insns" and "jit_insns_blinded", the
> "ldst_offsets" subtest fails for word and doubleword stores:

...

> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index 2bd0dc5b911c..5207ad30fade 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -52,6 +52,15 @@ do {										\
>   #define is_signed_imm52(val)	signed_imm_check(val, 52)
>   #define is_unsigned_imm12(val)	unsigned_imm_check(val, 12)
>   
> +/*
> + * ldptr.{w,d} and stptr.{w,d} take a 14-bit signed immediate in units of
> + * 4 bytes: they reach a multiple of 4 in [-32768, 32764], passed as off >> 2.
> + */
> +static inline bool is_ptr_off(int off)
> +{
> +	return !(off & 3) && is_signed_imm16(off);
> +}
> +

Please use a self-documenting function name and remove the redundant
comment:

static inline bool is_aligned_signed_imm16(int off)
{
	return !(off & 3) && is_signed_imm16(off);
}

Moreover, please remove the unused is_signed_imm14 macro in bpf_jit.h.

Thanks,
Tiezhu


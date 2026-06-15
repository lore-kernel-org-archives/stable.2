Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFCC21A447;
	Mon, 15 Jun 2026 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486978; cv=none; b=oVzw6frbwz6RuQ6mLZSkTf1Z2PZ15H2wHr1WqMwhoywm6AiVaOqUpBEEIBD501irrdF2ybJtwbMK3+e6547QhICXCFe62D3MmSClTAsIcei57vfpMDiXeQx6gwvMuZZ8P+irlFSKQY8DwOI/eAc7Z9kmmz2PswyW+JY1J8Wvgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486978; c=relaxed/simple;
	bh=tiuiSeIm9AiWzjJNxtY1e8JovVLBdhymd0dx4YMDESY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J+ZdDWnlqhBGj+uTbkBbKR5yHrhtB7kRawnQ+qVK8kSQSZJSJCjHnGhCwnGrcTWz0rdDm+6bGLLEyputQ/Lzf98jVtlTxwc2QB+7YNToxxoDevU9kPwwS3IQUyELzivcVYSZeyq9BZlgZztDJGIIFr75fhgd/8l6lI1yitdbzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8AxvsB+VS9qaCcUAA--.29234S3;
	Mon, 15 Jun 2026 09:29:34 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJCx98B8VS9qR5imAA--.40429S3;
	Mon, 15 Jun 2026 09:29:33 +0800 (CST)
Subject: Re: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
 stable@vger.kernel.org
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
 <20260608024533.32419-3-wanghongliang@loongson.cn>
 <ai8o9vxUX6rbZNV4@zenone.zhora.eu>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <338facef-6893-c8d9-0efc-b4fc3aea756b@loongson.cn>
Date: Mon, 15 Jun 2026 09:27:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ai8o9vxUX6rbZNV4@zenone.zhora.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCx98B8VS9qR5imAA--.40429S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF45ZF4xGFy5Xr15XF4rtFc_yoWDJrg_WF
	Wvyr1UCw1UZFn8Ga93tF43A3s0qayUKr4DWrnrAF15JrW3tFZakF18W39a9wnxWay29as0
	vry8Aw47AF1a9osvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U

Hi, Andi

On 2026/6/15 上午6:20, Andi Shyti wrote:
> Hi Hongliang,
>
> On Mon, Jun 08, 2026 at 10:45:33AM +0800, Hongliang Wang wrote:
>> The i2c-ls2x driver supports dts and acpi parameter passing.
>>
>> In dts, uses clock framework, by parsing clocks property to
>> get i2c bus reference clock, and define the div of reference
>> clock by device data.
>>
>> In acpi, by passing clocks property to describe i2c bus reference
>> clock and clock-div property to describe the div of reference clock.
>>
>> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
>> and div, calculate the prcescale of i2c divider register. The
>> calculation formula is
>>
>> prcescale = (clock_a*10)/(div*clock_s)-1
>>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> I think Huacai has not reviewed this patch, his review was only
> for patch 1. Am I right?
>
> Andi
Sorry, it was my mistake,  I will send a new version later.

Best regards,
Hongliang Wang


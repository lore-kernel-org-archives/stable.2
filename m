Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902639DBD6;
	Tue,  1 Sep 2026 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263008; cv=none; b=csHYH0h67h1fV5zRBxyRUlFjx8YuTpVkKH79jsRsWTZaa2NXJuVRpalq1N2iyCu9YXVdL/lyggnWx6jIGRBRVccSImTRW9EC/e3fGSKwdO8za8ClxYKmdTjdBI/Qsqg4SR0uCm5WP4AfxRkH1n5P9qt9KaHR38uP+Q/o0TbNEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263008; c=relaxed/simple;
	bh=39ITq4Ff+c+FJRIAtgkzR/3Yy9O8cOz2fIYexbHY64o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PQhrGBmSfO9DNoD7lt14QCB+2Fj+NgxKrHpkJSt88HTibPLqoSILpqflLj1dpms0qHruxToKkTfH0XpszRAFaiyKkyLbA/ttD2I1AlqP41nWntjHR3LM2/la0HzOJ5hLpQADm9gpSa/zqDYYX/tjI1iynzDQ5GkVWVTj+XJzIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3WCLVJ/Q; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3WCLVJ/Q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jVFy6vmRTrlaHy1nJIJgeFKjh2QY1a0llw9oeQ2GpfM=;
	b=3WCLVJ/QUY/dalOUg3y2No3BSYtFDEAEem8rPz++4Q80iySAl3yWGYQ2UxsSal6T0WWl8CWEr
	V84iMd5t1g+plSUv1YDwAow+nc6NIV0tY2t/r1OMfUEfKFMjGj5T1zOgK6FhcfCb2Wc83soM7U0
	L7T78noz9RIp97/+mJx0B+4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hZ3bz3DMsz1T4Fq;
	Tue,  1 Sep 2026 19:31:59 +0800 (CST)
Received: from dggpemf100018.china.huawei.com (unknown [7.185.36.183])
	by mail.maildlp.com (Postfix) with ESMTPS id B649540579;
	Tue,  1 Sep 2026 19:43:19 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemf100018.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Sep 2026 19:43:18 +0800
Message-ID: <5c4e30cf-3742-4d25-a209-25498c73f1f4@huawei.com>
Date: Tue, 1 Sep 2026 19:43:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "irqchip/mbigen: Fix mbigen node address layout"
Content-Language: en-US
To: caina <caina@uniontech.com>, <tglx@kernel.org>, <maz@kernel.org>,
	<radu@rendec.net>, <guohanjun@huawei.com>, "liaochang (A)"
	<liaochang1@huawei.com>, Ruan Jinjie <ruanjinjie@huawei.com>,
	<wangwudi@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<kernel@uniontech.com>
References: <8633w854yk.wl-maz@kernel.org>
 <20260821091720.16665-1-caina@uniontech.com>
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20260821091720.16665-1-caina@uniontech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf100018.china.huawei.com (7.185.36.183)

Oh Sorry, the format of the last email was messed up.

Hi1616 is special hardware whose register layout differs
from the other mbigen platforms: it does not have the clear register
range fixed at [0xA000, 0xAFFF], on which the fix is based.  As a
result, skipping an extra node offset for node IDs greater than or
equal to ten, as the fix does, makes the driver access wrong
registers on Hi1616.

The fix was originally introduced to address a real problem on the
other platforms: each mbigen chip has its own independent set of
clear registers, whose offset is fixed within the range [0xA000,
0xAFFF].  Meanwhile, mbigen allocates a consecutive 4-byte register
to every hwirq for configuring the interrupt type, EOI and so on, so
each 4KB node region accommodates 128 hwirqs.  Before the fix, the
driver calculated the register address of each interrupt from its
hwirq.  This works without any problem as long as the number of
interrupts is below 1280, which means no more than nine mbigen nodes.
Once the maximum number of interrupts of a mbigen chip exceeds 1280,
however, the node register addresses reach offset 0xA000 and start to
clobber the fixed clear-register range.

The final solution will be worked out in cooperation with the BIOS:
the firmware will pass a chip version to the driver so that it can
take care of all platforms.  Since this depends on the corresponding
BIOS versions being adapted first, it cannot land immediately.

In the meantime it is safe to revert the fix, because nobody has run
into this problem for now: it can only be triggered on "new hardware"
platforms, while all the platforms available today, including
Hi1616, work correctly.

So, let's revert this patch first.

Acked-by: Yipeng Zou <zouyipeng@huawei.com>

在 2026/8/21 17:17, caina 写道:
> This reverts commit 6be6cba9c4371d27f78d900ccfe34bb880d9ee20.
>
> Commit 6be6cba9c437 ("irqchip/mbigen: Fix mbigen node address layout")
> appears to cause a regression on Hi1616.
>
> On-board hns NIC has two ports, enahisic2i0 and enahisic2i1, both
> behind mbigen-v2.  Port 0 works; port 1 cannot pass any traffic.
>
> Their interrupt pins fall on different mbigen nodes:
>
>    enahisic2i0: pins 1152-1198 -> all in node 9
>    enahisic2i1: pins 1200-1246 -> node 9 (1200-1215) + node 10 (1216-1246)
>
>    (nid = (hwirq - 64) / 128 + 1; pin 1215 = node 9, pin 1216 = node 10)
>
> /proc/interrupts shows the break happens exactly at the node boundary:
>
>    enahisic2i1-rx0  pin 1200  count 102   <- node 9
>    enahisic2i1-rx5  pin 1215  count   1   <- node 9, last pin
>    enahisic2i1-tx5  pin 1216  count   0   <- node 10, first pin
>    enahisic2i1-rx6  pin 1218  count   0   <- node 10
>    ...all node 10 pins stay at zero.
>
> Port 0 (entirely node 9) is unaffected.  Reverting the commit restores
> normal operation.
>
> The commit assumes CLEAR occupies a full 4 KB page at [0xa000, 0xb000)
> and collides with node 10, so node 10+ gets shifted by 0x1000.
>
> But get_mbigen_clear_reg() uses flat, chip-wide addressing -- it never
> multiplies by the node ID:
>
>      *addr = (hwirq / 32) * 4 + REG_MBIGEN_CLEAR_OFFSET;  /* 0xa000 */
>
> Over the valid hwirq range [64, 1407], CLEAR only spans 0xa008-0xa0af
> (168 bytes).  Node 10's registers are:
>
>      TYPE: 0xa000-0xa00f  (16 B)   overlaps CLEAR by 8 B (0xa008-0xa00f)
>      VEC:  0xa200-0xa3ff  (512 B)  no overlap with CLEAR
>
> Shifting the whole page moves VEC from 0xa200 to 0xb200.  The hardware
> reads the event ID from the fixed silicon address 0xa200 on interrupt
> firing, but software wrote it to 0xb200 -- so the hardware gets an
> uninitialised value and the interrupt is lost.
>
> The only real overlap is 8 bytes of TYPE.  It can only trigger when a
> single mbigen instance has devices on both node 1 (CLEAR 0xa008) and
> node 10 (TYPE 0xa008).  On Hi1616 those nodes are on separate mbigen
> instances, so it never triggers.
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Fixes: 6be6cba9c4371d27f78d900ccfe34bb880d9ee20 ("irqchip/mbigen: Fix mbigen node address layout")
> Cc: stable@vger.kernel.org
> Signed-off-by: caina <caina@uniontech.com>
> ---
>   drivers/irqchip/irq-mbigen.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 6f69f4e5dbac..12919836dadb 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -64,20 +64,6 @@ struct mbigen_device {
>   	void __iomem		*base;
>   };
>   
> -static inline unsigned int get_mbigen_node_offset(unsigned int nid)
> -{
> -	unsigned int offset = nid * MBIGEN_NODE_OFFSET;
> -
> -	/*
> -	 * To avoid touched clear register in unexpected way, we need to directly
> -	 * skip clear register when access to more than 10 mbigen nodes.
> -	 */
> -	if (nid >= (REG_MBIGEN_CLEAR_OFFSET / MBIGEN_NODE_OFFSET))
> -		offset += MBIGEN_NODE_OFFSET;
> -
> -	return offset;
> -}
> -
>   static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
>   {
>   	unsigned int nid, pin;
> @@ -86,7 +72,8 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
>   	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
>   	pin = hwirq % IRQS_PER_MBIGEN_NODE;
>   
> -	return pin * 4 + get_mbigen_node_offset(nid) + REG_MBIGEN_VEC_OFFSET;
> +	return pin * 4 + nid * MBIGEN_NODE_OFFSET
> +			+ REG_MBIGEN_VEC_OFFSET;
>   }
>   
>   static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
> @@ -101,7 +88,8 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
>   	*mask = 1 << (irq_ofst % 32);
>   	ofst = irq_ofst / 32 * 4;
>   
> -	*addr = ofst + get_mbigen_node_offset(nid) + REG_MBIGEN_TYPE_OFFSET;
> +	*addr = ofst + nid * MBIGEN_NODE_OFFSET
> +		+ REG_MBIGEN_TYPE_OFFSET;
>   }
>   
>   static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,

-- 
Regards,
Yipeng Zou


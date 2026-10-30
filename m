Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381931;
	b=1GosbZFAe7Uyyk1L40ATmFe4Yb04evJnPF4QRxgA4XRvVQPNFKTQsM7IJfYR9WjySirX
	 9QmvdKNBiUIshKm/EYr/oROEecGJpLalBpMSWNnHsxWHDUS1DAWqblZ9uhStJU5RFEpnb
	 0ewfk3kGPUxZH2zFb5AhuXXviLMv88iUYt5hTefnY+i39JYPJ15S/t0nCcTdIXKPL4UXt
	 zT6xmKNNxV/ykL/ruVK1GIZH3Q0DXR5bmXK3AQiVrp9wDIdKIBMi/l2jUDEzrMjUMbI2+
	 ulEf8DOmjXk02phmoVfxN7+HKzWRT4ZQ/sB+l1mr8oOviDnu1bwOHYSV89ap1Jr0szw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381931;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=5QrMtaadB01ja5QUxNpwn6WttY8QR0YjgchVxio8Pbw=;
	b=Hz1mqPaJzmbbO0klAQ4AcPIXDCExbxm1MRaFlPWRG3J6O6PB3SW6jHOzjMYx2gwEX+1+
	 mXSeSRhDY3mQWosrWgj557Bpd9CHW0Ciiar3guEE+gZb7G3CQmoruw52pnzqB7CXGoLaD
	 tQWt4uha/ErcX0VtQYfnvR2ywudLFUuzGyeCygmHC/VbOW4VlMldaowqWTtDESdTQm7/I
	 vQOpkTtF37T4ASY48NyyLujKs85ohUV4/XhW/MJJzLFcLPI5DUV9X0dAADLRv4jwq0U45
	 xg/bTmGT7U1qmWsfmPuWpTOfVOxKjEHm3jV8fR+7QYlh8aLl4+fOXaaMVvyg3il8VJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB4606A31A;
	Fri, 30 Oct 2026 17:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5BB4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=5QrMtaadB01ja5QUxNpwn6WttY8QR0Yjgc
	hVxio8Pbw=; b=07udqYsUhf3YOzAgN/h0b630lhAlEwlcIKxcIt0demPXJRcmAE
	bjbyyugN3oKHPI3cO7ej8PcUA4eVRnKSBTjiNNuSKMdCKQlXoJZrCZJ0/TzDeCIg
	mecyihZ7vxiwKz4FRF84dmB/rK6OnvqgIfRbd+Uacnk5KxeRg+05eosqo=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCmrgEe1uRqEyMMAQ--.11108S2;
	Sat, 31 Oct 2026 01:38:39 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH] wifi: mt76: usb: re-enable the rx worker when resuming fails
Date: Sat, 31 Oct 2026 01:38:30 +0800
Message-ID: <20261030.pref-12.ed3d9ff5862d42e5@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261030021247.8032-1-25031212351@stu.xidian.edu.cn>
References: <20261030021247.8032-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkCmrgEe1uRqEyMMAQ--.11108S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOb7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GwCF04k20x
	vY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxUIJPEDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUCD2rkstQVtQABsA

Hi Sean,

Could you please review this patch?

  [PATCH] wifi: mt76: usb: re-enable the rx worker when resuming fails

It re-enables the mt76 RX worker even when RX buffer submission fails
during resume, avoiding an unbalanced kthread park.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261030021247.8032-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe


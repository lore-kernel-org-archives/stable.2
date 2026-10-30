Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381886;
	b=BH1hy8sW+9VtnGf7Gsh3BFV8bbxGV2/jX3aIr8+qvSaFDdHvBb+rd/NWW07+UuZbLYh8
	 4BH4KV9vEsantJOw3it+OVN3iA3GelZp/crguTaK+5Wvasf7c2OSxs/J2+4sil6R5fscT
	 +9JRgd1/J0jfnElmpzuEVcG9PASkGCfxsBlf2XQUUd0gakbChLjm5x2zj7PemAD8UpJtG
	 Oo4SnTXBQTLwuW6PV61dTqdhuZlwxPHTmt0L6f7RgBCeuVVvdp8LzvagwXwYP0OxG5BbE
	 BFC4SyQEqa+fLI3oga0uzQpvrYJ6MzQpPz10jstesfU3FAQW3I8WnvtpqaC677a2TCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381886;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=a8VD+A9NZmyG+/SXVtDSXtCTgJcaPcPwhDvH+I7MDdM=;
	b=pieqsWveGDtaotHeZCXURrurrTh/wIXeJG0NpDIO5wtZWVAZGqD/ypeY8BsZ2grsCbj5
	 wXtBeTiL8A3jDxL3FuPg0bMUD9NJlAnF3UU7Dphw09M3yYPo2G6/laYi1wAqmvthIGD+e
	 /zUUTOk4OLljCgxWvIKZaIOy63wCXSYjuhbWXNwGTckAI0mR0a/pLiGxg/ysP+oD3mR2A
	 /m5BC/WGvLjZ6pewHpg4dgVe01JM9Ckw8fDcZhp0fbbJ089EbPahhc+2uMQlKGyQ83kqP
	 HyQxMI8aAPnDrqI2lb9fMbz5WURFjUtzpGxY/Ogv76xFw29nipr7meP0seYrXGUi2vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B3606A31C;
	Fri, 30 Oct 2026 17:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C1B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
	Content-Transfer-Encoding; bh=a8VD+A9NZmyG+/SXVtDSXtCTgJcaPcPwhD
	vH+I7MDdM=; b=2dC7TzmTh7x8Fe8wXaT3cKpqauYLtLHS2gafgA4g8XtVdGGRP5
	bUeDTR2xcZleXyE3XrUjB8cVNcBqvp6Igggw2pZpE/BuIbWx/83c6sWfeP4GJADx
	G6vn9GZfTRkIp7KNEJkRtpeqaIsvGiRCnxR7vD3Lq4iPyQ0Htt5N3GuLY=
Received: from localhost.localdomain (unknown [113.200.174.17])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBGagD51eRqracMAQ--.11350S2;
	Sat, 31 Oct 2026 01:38:02 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] media: dvb-core: wait for a running frontend ioctl
 before device removal
Date: Sat, 31 Oct 2026 01:37:48 +0800
Message-ID: <20261030.pref-09.63b2bfe82fc54bee@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261027022214.14345-1-25031212351@stu.xidian.edu.cn>
References: <20261027022214.14345-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkBGagD51eRqracMAQ--.11350S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYl7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262
	kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxj2MUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUCD2rktUIS3wAAs+

Hi Mauro,

Could you please review this patch?

  [PATCH v4] media: dvb-core: wait for a running frontend ioctl before
  device removal

It waits for a running frontend ioctl before device removal can free the
driver state used by that ioctl.

The patch is unchanged. I am copying this address for visibility.

Original submission:
https://lore.kernel.org/r/20261027022214.14345-1-25031212351@stu.xidian.edu.cn

Thanks,
YuanZhe


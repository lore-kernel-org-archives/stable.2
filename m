Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E8409139
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540364; cv=none; b=lTX2S0Pu75kchdGBbV+B44dxjy9+8GNF8xurVyanHwuZcV8VOnJr982ByTunGfuShsmzY0Yu6M9Ef37XfyGPccFRNjhNF8h/R+5OywF9RAuDKNuIe/YZYIhm/h6jmA1D5NNew7r2i0yC1Sgh7rv0rMbOrbyp/4FftyEGE541Z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540364; c=relaxed/simple;
	bh=7QOl0baV//09jdK85RZ41ArwmFSYrP/yQKGL8mlYvbE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wi8u8JM2MjirQ6IgohemrxBPrNGGcn1/Qc1vK4dDh03lelu98vH2j5z6XSbornuhh7j7IumRtLrqSCZOaworvy3nVCdOS82nTEhEAhsEAxWkYA7HAEyikbSowEHUacFeU0GJIGk0ueWR9e9+8eDxmSLHYpqO5tMhKMo2zZOJzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=mXmGjvt1 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="mXmGjvt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:To:Cc:From:Subject:Content-Type:
	Content-Transfer-Encoding; bh=po1F5BiTs7L3Ey/ZTbCyJrFoKJPlLpuXmp
	dDJd3M33A=; b=mXmGjvt1m3wjIwNRKVSSd7BuSPXYwH+bL/J59+f9BIe/yZ7s7n
	kjdef5BykQblcQ3NOTg4b2xQxSVJPPSFDUPI+M5vFQeMGk5HSez4hcMs0HEHf+0w
	gfD6a6nWXC30oZqTHBMFD0kb6RDeNF+VE2AFj6gtZbmb4J4VRnmGjhcUk=
Received: from [10.196.180.86] (unknown [113.200.174.80])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkA217ICJjBqWlW2Ag--.44222S3;
	Tue, 16 Jun 2026 00:19:15 +0800 (CST)
Message-ID: <d161697b-7c51-4ad7-b697-7ae3a3a78b9b@stu.xidian.edu.cn>
Date: Tue, 16 Jun 2026 00:19:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, sashal@kernel.org,
 brauner@kernel.org, jlayton@kernel.org, w15303746062@163.com
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Please cherry-pick commit 00633c468382 to stable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BrQMCkA217ICJjBqWlW2Ag--.44222S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYB7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Jr
	0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcVAKI48JMxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14
	v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUI9NVDUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUFEWowFvEJQgABsk

Hi,

Please cherry-pick the following upstream commit into active stable trees:

00633c4683828acd5256fa8d5163f440d74bbe71

It fixes a SOFTIRQ-unsafe lock order deadlock that can lead to a remote 
Denial of Service (DoS) via crafted TCP URG packets in fasync signaling.

The patch applies cleanly to recent LTS branches.

Thanks,
Mingyu Wang


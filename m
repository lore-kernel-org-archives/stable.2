Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8961332623;
	Fri, 17 Jul 2026 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301208; cv=none; b=aO4x5TLuMkXUWfMQppMo4ju0cX7gGhMuc+4dlv34WHr6QgQCuRlPQGuN01RpXGW28A+maMV/aFXTicfwvwph9BTY9jAytPV056W5Ec91CC8nxqOgUY0GfsegBG0uKUMRmiTJJ6ztmkuM5FpgGd2WLkKXqiJSG6g+v0ij4coJfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301208; c=relaxed/simple;
	bh=G8/dYAZVpYEIOj199o+HNZ/PA/eEghG3BmHh067Kv08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbYbR5fvGqjXUjBjOtnohnZ2sf4YFUhtOCl9GRFM0PZXADzV2+nGqsH/lfugJVgx9CKC0DuhyZO//pjzactDljcDPkzVQItta6eJ3BcTaufT1kGdtfnJIQhWO4uxcySPcsa1StTdngyPk1rfX2gzN+0jEymsadlByPyBe1xnaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=mq2e6jEX reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="mq2e6jEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=G8/dYAZVp
	YEIOj199o+HNZ/PA/eEghG3BmHh067Kv08=; b=mq2e6jEX+0lijFYiV+L0GdS+G
	R6zQff5dHgQbYXQaRgvVmBYqc8gyguIGQtg/mUe5ZivyowRV/ZpPeK57SamUJ6jH
	yaSYHsFsdzxdZuMdH6upRbkOEC2wuafDTSXXF6nPf7KisCY/2nOLunro1N1hxDXA
	R9h0xQhrwLw9jxD8f0=
Received: from [192.168.1.109] (unknown [115.53.187.216])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkC2HtiORlpqyGcSAQ--.23162S3;
	Fri, 17 Jul 2026 23:13:19 +0800 (CST)
Message-ID: <3761aa02-0b65-4335-9f21-1f24186504eb@stu.xidian.edu.cn>
Date: Fri, 17 Jul 2026 23:13:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO
 access via malicious MFA
To: Greg KH <gregkh@linuxfoundation.org>, w15303746062@163.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, kees@kernel.org,
 stable@vger.kernel.org
References: <20260624032425.384325-1-w15303746062@163.com>
 <20260624032425.384325-3-w15303746062@163.com>
 <2026071745-bamboo-aerobics-7657@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026071745-bamboo-aerobics-7657@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkC2HtiORlpqyGcSAQ--.23162S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYd7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JMxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262
	kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFZXrUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUREWpY9eq+kwABsF


> That is a big function to inline, are you sure it's still needed that
> way and shouldn't just go in the .c file?

Hi Greg,

Yes, agreed. I have moved get_i2o_message() out of line into
lowlevel.c to avoid text bloat.

This is updated in the newly submitted v5 patch series.
Thanks for the review.

Mingyu


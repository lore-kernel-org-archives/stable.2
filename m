Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F44308F2A;
	Tue, 23 Jun 2026 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216035; cv=none; b=CHJ8y7P4PhriOSJQhN2CUxMplgZZCHQnlFtFMbuSy0NgWWM4CEaGUVLcxurzOA/pLgIMwrIsLpvBNzyPrHfNsYWTM07d3PXdYPzr4Omt+Rp4gWFigeYNgkBpET5eb3b6iQ2tqVdv0xDZ/U1g7iXOI7bdONLWQIAK0oR9A7suPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216035; c=relaxed/simple;
	bh=X2g2Po6EjGl8IaUtYZNpXHAH8+FFhBI4fe+OnuVmigc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjKLbG60taQYHnHjjvWjWVeHhEEQKxNqzDx+k6mkPyDamqDUvm20SrG8aAO98s6qI9DTFsSFHRbxEZxhTCgR4aBciKFEmOsyZP0ytYhLIPdBmiTPfj1IiuE9261SbK0VRYkusPCkysoCuaEmDkKBUe+Ljch6Y6RswIVdSAljbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=gMHEXcMU reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="gMHEXcMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=skdyKb1EZ
	y48Ro8jFkX3XE4S+UQ0yRqq3vVNyv9/7u8=; b=gMHEXcMUFLRuwh/9Mj5iCSeOC
	KGNMhAivZ79VrjfwwhQLs39NGiYkTIjiqgJkGJTLmxta7ST99pM0s9HSxj4puh3G
	MiHui3cHLhb9+3NupZNcYJAdRqnTQfoRGMyJJM/hU5bQXfUlQ1yT6pwWT1EMRJrS
	cfHZR8/GCnmq7pB4jo=
Received: from [10.196.180.86] (unknown [113.200.174.80])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkAWvLdVdTpqKUARAw--.53347S3;
	Tue, 23 Jun 2026 20:00:22 +0800 (CST)
Message-ID: <0a6ee8f7-5487-4963-b2f0-eed6466d7bd6@stu.xidian.edu.cn>
Date: Tue, 23 Jun 2026 20:00:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: ibmasm: Fix static and dynamic out-of-bounds
 MMIO accesses
To: Greg KH <gregkh@linuxfoundation.org>, w15303746062@163.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, kees@kernel.org,
 stable@vger.kernel.org
References: <2026062354-crawfish-t-shirt-d45d@gregkh>
 <20260623114046.368089-1-w15303746062@163.com>
 <2026062354-quote-lullaby-85e3@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026062354-quote-lullaby-85e3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BrQMCkAWvLdVdTpqKUARAw--.53347S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYd7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JMxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262
	kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j01v3UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUNEWo5Uea5mQAAsc

> That's a lot of different things all at once here.  Please split this up
> into a patch series, doing only one logical thing per patch so it is
> easier to review and apply.

Understood. I will split this into a 2-patch series (v3) as suggested 
and send it out shortly.


Best regards,


Mingyu Wang


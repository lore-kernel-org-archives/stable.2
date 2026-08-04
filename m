Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C01C23EAB0;
	Tue,  4 Aug 2026 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785824836; cv=none; b=YMlSKc/oupGjY/wfZ1AIy37SputZsFgJ5Z58SNtyCgTPgrk/qn0Xqm9Bk7QVFdlxdMCSYV1FywpFC3OpaNfmgw5pd139pRU5GNmArOl1SnXpPCNxZ+gX7aXXgBguTlcgfLLd7zRcPTwakVOy3pOLA6kDu36LLkFULjXdTjA+rAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785824836; c=relaxed/simple;
	bh=GZw+V1zr6GJ+fFmlwMN9cGDcnrj9DC3erOpXhpi1qdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr9BGmEdMrGaqLjs1+VFCTzDOvgNnk/YYWu1yhYhHNiJQ+bfJkeg3ge1ZucvRg01bT937/xeGYw7pDHIt+ht48RAMBgbezJEe5q4uLolyhEX4og5acK44pfQyWS2ERtzej+Avcv9KanAX4Q022ezEDfvZ7WuegjhxXgldpqcads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=bzLrhpra reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="bzLrhpra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=GZw+V1zr6
	GJ+fFmlwMN9cGDcnrj9DC3erOpXhpi1qdA=; b=bzLrhpraoh59nOUwD/6K6ofme
	IBgkMlABKu/dc9gRaEPrQtu1DWLXiKLEabbMfc4ilx/Tp77cpugcypB9IlK8UlpY
	0wj6uOLcngxIqHft43MCKe5ruNko26RiPCM+KOWCo9GLg+UWvV2Kojoqo9rXGnnB
	5EEqpDujOvNBlgCAFA=
Received: from [192.168.1.110] (unknown [115.53.189.222])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkD2WdM2hnFqWlDbAQ--.59253S3;
	Tue, 04 Aug 2026 14:27:03 +0800 (CST)
Message-ID: <461151f7-9474-4856-bf5c-d5145d9bb9dc@stu.xidian.edu.cn>
Date: Tue, 4 Aug 2026 14:27:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: i801: Fix hardware state machine corruption and
 stack-out-of-bounds
To: jdelvare@suse.com, andi.shyti@kernel.org
Cc: wsa@kernel.org, hkallweit1@gmail.com, djkurtz@chromium.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260627111749.482415-1-25181214217@stu.xidian.edu.cn>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <20260627111749.482415-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkD2WdM2hnFqWlDbAQ--.59253S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYd7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262
	kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr_-PUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUPEWpwsH1obgAAsI

Hi Jean and Andi,

Just a gentle ping on this patch.

It addresses a critical KASAN stack-out-of-bounds issue that occurs
when a transaction times out or aborts, and the hardware fires a
delayed or spurious interrupt after the stack frame is destroyed.

Please let me know if there are any further comments, or if it
looks good to be queued up.

Thanks,
Mingyu


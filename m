Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B17B19D07A;
	Sat, 25 Jul 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942190; cv=none; b=Ca3uvZ6VYd9MKyJxhS83UNISPaXOHQtMpTFZMJaN4wb3+ni9gzUfrCHmvBLl0J4ADcJ6eP7bs/lYXuZweIhYbyvjrHfzlPSOlTGFvHYtbuqJBIInPygQr2MGRdHXvySveaWJTaMIDJENbpERvTq/ENzufDZczEJpVQk0l6nwdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942190; c=relaxed/simple;
	bh=iwEk3kkgTGHHJCCelUOaKx7UpanA3TG91XR6QN9yAxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeAOsxveb+kHz5GBwl5nlvJ9xaKzxTmZPIsrMQmHc+CaGLjVOt1JuYxbOc3gKxmFmbkWqSCvEwuoSWAGY+f3ARn/Pp97j4AiHZhFBckb1eHqyTUXkvzAigjP1VE+pQuAfSlH19CG9bOCjCyQLTaRLq5oCtV1aw10xNAGX5XvBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=F/XwVEk+ reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="F/XwVEk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=xmUYPvi32
	T1uurAIi9LSAnx0uzTTiR/ExGW/8cnA/Rw=; b=F/XwVEk+QoKnxtublNoptqCy3
	lONlM4ULNsgHYbO2Dzv+2UIcV16VSvmkfe6ugxvPDduKjuNy8FDOZrI/Y7QYPDFx
	tLaBaNAvAYghRKvsCQWk+v6F9cD92vuW28fxxwTBZS0P7ekWq7sKcvzdQyh3xaMc
	zjfod2CikSmI4gZtLE=
Received: from [192.168.1.110] (unknown [115.53.186.114])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkC2+S5eDmRqwM5wAQ--.14099S3;
	Sat, 25 Jul 2026 09:16:15 +0800 (CST)
Message-ID: <0fbbc160-a599-4384-b78a-bf8e6afd963e@stu.xidian.edu.cn>
Date: Sat, 25 Jul 2026 09:16:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: i801: Clamp adapter timeout to prevent system
 lockup
To: Andi Shyti <andi.shyti@kernel.org>
Cc: jdelvare@suse.com, djkurtz@chromium.org, hkallweit1@gmail.com,
 wsa@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260723034331.116690-1-25181214217@stu.xidian.edu.cn>
 <amPinh8c7GwQx4Le@zenone.zhora.eu>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <amPinh8c7GwQx4Le@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BLQMCkC2+S5eDmRqwM5wAQ--.14099S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYT7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjxU7RpBDUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUFEWpjgew1bQAAss

Hi Andi,

Thanks for the review.

I agree with your points. Silently clamping the timeout violates the 
userspace API expectations, and adding arbitrary limits to restrict a 
privileged user is indeed not the right approach.

I will drop this patch and handle the timeout constraints locally in my 
testing environment.

Thanks for your time.

Best regards,
Mingyu Wang


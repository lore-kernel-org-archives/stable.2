Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459443C3F5A;
	Mon, 20 Jul 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533011; cv=none; b=UksZGAMhEDJ6eR0w5/a3+6J/xpoYKPfC0PLIx20foUlJ330nxhiY/gQ5bly9VD8q/FrNMKUFjAVjOPUA1oFcNcChaT6XLJeCzP/2wzaz9y6nHorx3Y4AqOmVsyYJvGkmyBjzPX9uSjvHX8gZvqt3oHixL2kt3AO5yTxlH0bM6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533011; c=relaxed/simple;
	bh=8hwjNnwLKpnumFPZh9M+rju/imzsqPT3ZcLHJEUGbF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvE3h1nQIaA6xLf5wQ6eSzSSdZhDgMucWTpwC/cZJ1aKfNBdk6JA6mly4kOO7/6oNlKae9zjIccxQLtd2mF2T1ir/DVDKXznTgvO7aIdF0QPrCf79s+F3TNK7hW8iChzQWeeAmwkRMopIhtdW07JXmo1FibxmJp/JIOo/O0Fl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=sRF131Ir reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="sRF131Ir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=8hwjNnwLK
	pnumFPZh9M+rju/imzsqPT3ZcLHJEUGbF0=; b=sRF131Irvt7k+pF+k9Jr2V5+S
	vSyZBtI7H4VEerEFTl1lJpJcLGWJPV8UPJBhaoPirjgXS/LK0FJSVODLJjg3Kf16
	VIaouWhEBKJCbkgwFwSRY5RbCnsqtJYg67Wn8E0gnt20aHe4KgI04rmZfqB5NAoe
	uMo4xAPLMEEuAFgfao=
Received: from [192.168.1.109] (unknown [115.53.184.107])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkB2nhT9z11qxqU5AQ--.48305S3;
	Mon, 20 Jul 2026 15:36:31 +0800 (CST)
Message-ID: <ea98a7af-1a7f-4703-a5e1-f800dc6f5e36@stu.xidian.edu.cn>
Date: Mon, 20 Jul 2026 15:36:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: validate iomem_base in
 serial8250_verify_port()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
 john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com, stable@vger.kernel.org
References: <20260720053733.102186-1-25181214217@stu.xidian.edu.cn>
 <0d58c9fe-7aed-43dd-8d00-6edfee9e2876@kernel.org>
 <706101a4-abf9-403d-a2cb-778a12338d99@stu.xidian.edu.cn>
 <2026072015-ammonium-dismount-7af5@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026072015-ammonium-dismount-7af5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BrQMCkB2nhT9z11qxqU5AQ--.48305S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY67k0a2IF6F1UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43Mx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7xRCwZ7JUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUAEWpc6mteDgABsz

Understood. Thank you for the clarification. I'll drop this patch.

Best regards,


Mingyu Wang


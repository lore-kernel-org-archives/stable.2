Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FEB2288D5;
	Mon, 20 Jul 2026 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784529880; cv=none; b=B5atns65c4rmqOthH/ldBaL7TqMQzn8oZMT9YNhOQUYNKVZMOfHOzJYVplsB3SsQXqFB4S0WKD/ZmIArJxQVkR9mVb+HcsIAJN6QCZBh70Z+sTKTIRad7fixN0mnZSfWcpYkCk4w5OnJ1mgh0du2ad7+Hp0d7fxem3ZePKxyUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784529880; c=relaxed/simple;
	bh=sRJC3ADCLu7gf8dHSb3MbjdXNVOCnghxm8nmTTSpM9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7shOD8Om94orFze/AzHU3HxbnJ+Yl7WVOwHpAYNL+4WOHTvLGBIK6v/SNWibgevQ4o3dyXU2dd79DPinvsXxoGYziUSu5Fkmr0IWlwz8PxlUz7QRrWbN53v/v818J1nUefwot17DTeeLX0yXmyIRPTVnDKqkTg/ePSvczOzPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=33LZ9yZ4 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="33LZ9yZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=iygIwyYQs
	tN8+85NunkmgtCek3mcLlpP3iY3wOzNQXA=; b=33LZ9yZ4CeBZZeIB+4tyNXX7u
	R/jlNMZroJlgh2sPAg08/YgS9ZvMuTLL2Uk3qXunj/fU6jeme5VgmRcn3MnLRwaq
	TYaEKfCPrIsGTugldDNzfX7xLqOrp8g9FMCPgA1JY1FGEiHgV88y8+hdS9iU2D2o
	gVW1QGeHZEgWsJEl/w=
Received: from [192.168.1.109] (unknown [115.53.188.159])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkCmyxHFw11qnwo5AQ--.16552S3;
	Mon, 20 Jul 2026 14:44:22 +0800 (CST)
Message-ID: <706101a4-abf9-403d-a2cb-778a12338d99@stu.xidian.edu.cn>
Date: Mon, 20 Jul 2026 14:44:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: validate iomem_base in
 serial8250_verify_port()
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: ilpo.jarvinen@linux.intel.com, john.ogness@linutronix.de,
 andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 stable@vger.kernel.org
References: <20260720053733.102186-1-25181214217@stu.xidian.edu.cn>
 <0d58c9fe-7aed-43dd-8d00-6edfee9e2876@kernel.org>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <0d58c9fe-7aed-43dd-8d00-6edfee9e2876@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkCmyxHFw11qnwo5AQ--.16552S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1kCF4kCF1rtFyUGry7GFg_yoW8JFy5pF
	yjgw4Dt34kGF92qFyxXr4qkry5K3Z3uFW5JF9Yq34Fkr1Y93yjyrZ2ka1UZay5Gws3GanI
	vF40qrsxCaykZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
	c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU08wI3UUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUAEWpc6fla1AAAs+


>
> Pardon my ignorance, but isn't TIOCSSERIAL intended exactly to change 
> the type or mapbase when needed for ports without UPF_FIXED_PORT (and 
> under root)?
>
Hi Jiri,

You're right — TIOCSSERIAL is meant to allow root to change io_type
and iomem_base for non-fixed ports. My patch was indeed too restrictive
and would have broken that ABI. That was an oversight on my part.

The issue was identified via local syzkaller testing. It reveals two
related behaviors:
1. Root injects a bogus iomem_base via TIOCSSERIAL; opening the port
    faults in mem_serial_in() because the mapped address is invalid.
2. Because the fault happens while holding tty_lock, the mutex remains
    locked by the dying task. This leads to a cascading use-after-free
    when subsequent threads try to acquire the same lock.

While (1) is effectively "root shooting itself in the foot," (2) results
in cascading failures beyond the initial fault.

How would you prefer to handle this? Should we treat this as wontfix
(since it requires CAP_SYS_ADMIN), or would you prefer a more targeted
check to avoid the cascading UAF (e.g., ensuring basic validity of the
mapbase before ioremap)?

I'm happy to drop this patch if you feel the risk does not justify
additional checks.

thanks,
Mingyu Wang


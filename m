Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89B37DEBA;
	Thu, 23 Jul 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803549; cv=none; b=blNIpRnBNJ7pm6SkXrBdc0ZpBnt9yaio7mJctnAokLO1MaAzng1rwUNHQ39xYRKi+7NizHuMXfubjhj2qfRMZKlt+ltO0OAxgRTlSTDHENSXI+r5Vc6/s1xEeSuJszgnpEZmpBiz30AOpsq4j/Lj9vBk9+CY1DPnyEKT57nY1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803549; c=relaxed/simple;
	bh=Gz005ieLvK9dObluVsyW2SqrwIOHR5jl7iq/dbnRCqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHipdevxqCr1l8KZVCc9LsKH9usZSiveHCIQSKL5UfxwxiGRTSodNZzITxgkmRiy9uVHHcqSKZxSusYByMBSSqAT1FO6X6obTHP0wCAblc2clNzgMASupr8r9UK/ZXxHXWcEbt4/o2yW3GWTeiyhGGAH43tKW7JaQBBOOjlk1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=kRWahvqe reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="kRWahvqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=EZip6LaA/
	xvT1L5mojIJnKqvQ/N/D0K7lb/jwkol7Eo=; b=kRWahvqeMxDx1EuS48NEh/zNQ
	BfefCeOGMEXEm/C2DBy39v3GEgyFck9uS5v8qtLTAW+bbIGh4eKCSeB0+qjIgkq6
	Lvr1EGksOfzdmw7nI0oHJqhM+gZGbBZYn0lOnRw6pVLrfLQnDQzJ0m+si1PU2g4H
	9D8p2sMa46zHPlezZw=
Received: from [192.168.1.109] (unknown [115.53.190.49])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkAGadLF8GFqtfpdAQ--.36551S3;
	Thu, 23 Jul 2026 18:45:26 +0800 (CST)
Message-ID: <88f9ac58-8079-415d-902c-3b9455a9d17c@stu.xidian.edu.cn>
Date: Thu, 23 Jul 2026 18:45:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: vt: fix memory leak in vc_allocate()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable@vger.kernel.org
References: <20260723070530.117552-1-25181214217@stu.xidian.edu.cn>
 <2026072345-copartner-shrink-9596@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026072345-copartner-shrink-9596@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkAGadLF8GFqtfpdAQ--.36551S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw13Zw1kXr4rAFW8XF1kKrg_yoW8XF1rpr
	Z5K347tFZ5K34Ika4kZwn5XFy8Ka1kXFWUGF1DGrnrZ3y5ur92kF4S9FWDWa48Krs5uw1Y
	yrWY9as3C3WDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5J5rDUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUDEWpg3uulyAAAsE


> How was this tested?  And how can this ever fail given this happens at
> early boot time, right?
>

Hi Greg,

Thank you for the review.

Regarding how it can fail:
While vc_allocate() is indeed heavily used during early boot, it is also 
reachable at runtime when dynamically allocating new virtual consoles 
(e.g., via the VT_ACTIVATE ioctl). The failure we observed happened at 
runtime because our fuzzing environment enables kernel fault injection 
(failslab). The fuzzer intentionally forced the kzalloc() for the screen 
buffer to fail, which exposed this specific error-handling path.

Regarding testing:
This issue was discovered using DevGen (our automated virtual device 
modeling fuzzer on QEMU). While we do not have a standalone C reproducer 
to run a dynamic runtime test, the fix was derived directly from dynamic 
execution evidence: we cross-analyzed the precise kmemleak backtraces 
and the fuzzer's execution logs.

The kmemleak traces clearly showed that when fault injection intercepted 
the screen buffer allocation, the execution jumped to `err_free`, 
permanently bypassing the cleanup of the unicode screen map (which had 
its refcount incremented earlier).

The patch has been compile-tested. Since con_free_unimap() safely checks 
for a NULL pointer internally, adding it to the err_free path ensures 
the elevated refcount is safely dropped without introducing regressions.

I hope this clarifies the context of the bug and the fix.

Best regards,
Mingyu Wang


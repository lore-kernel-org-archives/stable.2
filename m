Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8C2D63E5;
	Tue, 23 Jun 2026 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215282; cv=none; b=gOPO9JakYw1YN6KAhS/ZxubEJw08XpG69B3ijTgR0+bgaqmny3m9tlw6G0uXHie9JNfSD7N3Z4WeR5lwFjbfK4nokEFdLLqbDRUstdmUt7bFVd1H0vBJvOmU7Kts28czU7EXuAMEsGkT0M5XwHfw5zsD4hcfmBQnG6MQjKMlIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215282; c=relaxed/simple;
	bh=oaYsPIiRr7O+D3CaQD7H9ELKJrE/yqkcdbXvz2dNA2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnQIjaTachobW4GCBrJMm4EPAKsqKeRMVSVXHR+LtgC1t5Jw+Rg5Lvx9bXboQdbC1IqSxnjThm5IbSt4GzwY+MHDBel7XMJsk159tp3oVAuU1RGv7wYwohIWQi6gDW0hyd6mOEst70q2zo0kjbBifv4Z7WO1SetyUd58fihHiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=fvodauGg reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="fvodauGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=riT3aCfBg
	TqpJw4wns4sVNKZ8p18asVLyO8oYAD4aAE=; b=fvodauGg7nCWuaCTVO3YLh04Z
	bHSz12BJFERC8lfPrpQ1f1Vs4KaAmFvO03QRTpQqfi8j1oF8c5OqWcQD6iBMjuIO
	fXplDULp9/J6UIQglT8Z3Tgo1F1jHHOQHJGE6MYk+uvuK1kUa/7VY4NO9F3ttQNW
	1XeNs3fRUUbFYAGmnU=
Received: from [10.196.180.86] (unknown [113.200.174.80])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkD2GzZfcjpq3ZsQAw--.28590S3;
	Tue, 23 Jun 2026 19:47:44 +0800 (CST)
Message-ID: <62e6c81c-a904-450b-8e32-7861e41412bb@stu.xidian.edu.cn>
Date: Tue, 23 Jun 2026 19:47:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: ibmasm: Fix out-of-bounds MMIO access during module
 load
To: Greg KH <gregkh@linuxfoundation.org>, w15303746062@163.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, kees@kernel.org,
 stable@vger.kernel.org
References: <20260623070909.362260-1-w15303746062@163.com>
 <2026062354-crawfish-t-shirt-d45d@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026062354-crawfish-t-shirt-d45d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkD2GzZfcjpq3ZsQAw--.28590S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw43Gr4Dury3Cw4kXFy5urg_yoWkCFbEk3
	sYv3srGr4ayrZIv3Wag3ZxZFn2k3929r93X3y0qr17X34rXrW7uF4DXr1Svryft34ktrs3
	Ww15Zrn5Aw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07jFpB-UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUNEWo5UXK2FwABsL

Hi Greg,

> The kernel trusts the hardware to not do foolish things like this 🙂
>> When evaluating the driver against emulated hardware or during virtual
>> device fuzzing, a malformed device may expose a significantly undersized
>> BAR 0 (e.g., 4KB). In this scenario, the readl() in enable_sp_interrupts()
>> crosses the mapped page boundary into unmapped memory, causing a page fault
>> during probe.
> Are you sure this is the only code path for this type of issue for this
> device/driver?  Why just worry about this one?

You were absolutely right to ask. Prompted by your question, I did a full
audit of the MMIO access paths in this driver.

I found that the dynamic MFA (Message Frame Address) reads from the 
hardware
queues, which are used directly as offsets in `get_i2o_message()`, are also
highly vulnerable to OOB accesses if the fuzzed hardware returns malicious
offsets during runtime.

I have just submitted a v2 patch in this thread that comprehensively fixes
both the static OOB during probe and the dynamic OOB during runtime.

Thank you very much for catching this and pointing me in the right 
direction!

Best regards,
Mingyu Wang


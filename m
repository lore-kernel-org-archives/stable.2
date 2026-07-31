Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D593876C4;
	Fri, 31 Jul 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506250; cv=none; b=fYU/U7mQY0goPNBqvnv2wbClA7kUyRV+Xn6x3GDabxXJFVsc3m5U1syhmDgxn8KeSzW5Bg5MtrLil/8/eM/wzyos5JI3HVE8PdLyr5+RuvkPJIoVQY5elKugZd+ETs59X84bm/vhABnhvRzgUZP1eifTqnzpG6YHW2brbBCNFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506250; c=relaxed/simple;
	bh=RF4gQibbNYQM93ofDKbzJHGEby+1aGDIE9WNNvrQux4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8A3CKsXfOwGYZYKSxhRbQpke51+8af9ML9A4pghZpq69MT15SyduLAbTsOPv1VscIDn3vnxJmLkoN4fEiLMtofuAjItDIIs6rQWceK+pxSMczPw2C1PGvt/e1L6ditR66/Dgn2aiwV+HtJdrzItZDcVq7Ac4fg5yqlCm2areh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=p1XIxtBY reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="p1XIxtBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=Xyyi2kubx
	ElrW2y0Rie66jPa9SfugC/hlsmExibnon4=; b=p1XIxtBYByt2p2fmLthuxcGyq
	z9Yf85HYrFRe51AJZ4WY6SE6JmdPP2QXtPLezi9FTlF/pb9VkI3fCa2ApuY/IARS
	Jqvl7IiomfLcfDCAv+F6Mg1ZRFGp2AnBgPg2pHoYMiKJJmw0euq1KqTXiw5sOTvx
	aUjjUAEpDtVaF3CQOM=
Received: from [192.168.1.110] (unknown [115.53.181.245])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkBWv9i7qWxqNQmxAQ--.27891S3;
	Fri, 31 Jul 2026 21:57:16 +0800 (CST)
Message-ID: <ce868846-52a6-47d7-96d5-1f14f1e9b5f9@stu.xidian.edu.cn>
Date: Fri, 31 Jul 2026 21:57:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] misc: ibmasm: Fix static out-of-bounds MMIO access
 during probe
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, kees@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260718073253.96741-1-25181214217@stu.xidian.edu.cn>
 <20260718073253.96741-2-25181214217@stu.xidian.edu.cn>
 <2026073120-deplete-bronzing-481c@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026073120-deplete-bronzing-481c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkBWv9i7qWxqNQmxAQ--.27891S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1kXr4UWryrtrykuw1rJFb_yoW8ZFW8pF
	WSgayFyr4UJr4vyw18u3yUZFWrCan7Aay5GF98GryFgrn8uFyDAF1xK3yqva47uF4kKFWS
	kr4jqry8Ga1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IUYj9aJUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgULEWpranyjYQAAsI

Hi Greg,

Thanks for the review.

> In thinking about this some more, isn't that what the "authenticated
> PCI" spec is for?  We trust this hardware, right?  If it gives us an
> invalid BAR, bad things can and will happen.
>
> So does this ever happen in a real device?  And where are these real
> devices?  What types of systems are they and are they even still being
> used?
>
You are right, a physical IBM RSA device would likely never expose an
undersized BAR. We found this crash using an automated QEMU device
fuzzer. In a traditional bare-metal environment, the kernel's trust
in PCI hardware is well understood.
> Where did this value come from?

It comes from the `display_depth()` macro used during ibmasmfs
initialization (`drivers/misc/ibmasm/ibmasmfs.c`). It calls
`remote_display_depth(sp)`, which reads from:
`sp->base_address + SCOUT_COM_C_BASE + 0x1fc`

Since `SCOUT_COM_C_BASE` is defined as `0xAC000` (in lowlevel.h),
the highest fixed offset accessed statically is `0xAC1FC`.

> I feel like if we start taking this type of patch, you will need to do
> it for EVERY PCI driver in the kernel, right?
>
> Again, Linux trusts PCI devices, so is this even needed?
>
You make a very fair point. We definitely do not intend to patch
every PCI driver in the kernel.

We targeted this specific case because of the severity of the crash
during `probe()`. Since the driver unconditionally accesses offset
`0xAC1FC` (approx 705KB) without checking the BAR length, an
undersized BAR provided by the fuzzer causes a page fault while
holding the `idempotent_init_module()` lock, leading to a global
soft lockup.

However, I completely agree with your core argument: adding defensive
checks against untrusted/fake hardware into obsolete drivers is not
a scalable strategy for the kernel.

If this hardware is truly dead, maintaining these edge-case patches
is unnecessary. Would you prefer I drop this patch series and submit
a single patch to remove the `ibmasm` driver entirely?

Best regards,
Mingyu Wang


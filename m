Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5130BB8D;
	Sat,  1 Aug 2026 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553158; cv=none; b=j3Q8rDirA/vi9CQe4A3jNWdPDXsMCWXUnNdxzLodqnT7fWD6CisElt9gGSj9nC6k6tO/mcIpYZa7/i9WqvntjX4Q59Qnuc9azZh52yccG9AKjUH9X20Cg6hRF4qtLOEy7yptSTn+/QaVM/JBziy1leL/XIuxr9aTKFghJROjZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553158; c=relaxed/simple;
	bh=VxkNUX/+n1uVqnGf7OU843YK2qDnuNQ3/ImdmTxlnVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyGBFJE7gz9c+JoVb2ZipbdXm9QEhxJ5D56eUTHGY4cJlI3lBeS+vIrG0L9enJMPZHRTV6bsWI2AVwACDt+IeX57PIG7v/4ZUlNDvBLU0LQBVlPDiNqzp21stgEO39GW8dbywgQpD6nw+AtDSFg7vhK20AZccHU7mZvUi87Lcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=JPIk//WM reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="JPIk//WM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=DBovGv1rB
	oO2ZUpQ0Xqr48xsilwB3e0TVM9b1zjY3wk=; b=JPIk//WMMA80xJEDVnbMg7Kvm
	lZbWvLuJoloAUSgb1PnoubsLExyA0/tlfHvvMwNWNTE/aksZ6H0NrjbO5BOpF45B
	kjgrnbPuO2pyS9UdOoIdawhPCBPLFCNNH7QwTiH5IoXr/z90F4xky2yO3EHyc5VR
	cL14UeLNHK9OzES4GQ=
Received: from [192.168.1.110] (unknown [115.53.141.84])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkB2mA7wYG1q3pO2AQ--.34228S3;
	Sat, 01 Aug 2026 10:58:57 +0800 (CST)
Message-ID: <4b8fc5e2-8965-47a0-8be8-b12337398fe6@stu.xidian.edu.cn>
Date: Sat, 1 Aug 2026 10:58:56 +0800
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
 <ce868846-52a6-47d7-96d5-1f14f1e9b5f9@stu.xidian.edu.cn>
 <2026073114-staff-turbine-9864@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026073114-staff-turbine-9864@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkB2mA7wYG1q3pO2AQ--.34228S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF45WFWrZw4ftr4xWw1UAwb_yoW8WFWxpF
	WUCanrAwn8tFyFyF4v9w48ZF15u393KF15KF90gry5Zan8GryIkrs3Ka1Y9a4DWws3uryj
	vwsFqw10k3Z8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Yb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7Cj
	xVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjxUyb_TDUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUMEWpsu-w+oQAAsE

Hi Greg,


> I do not know.  Do some research into when the hardware was made, what
> it runs on, and try to determine if it really is even used anymore by
> anyone.  If not, then yes, let's drop it!

Thanks for the guidance! I did the research on the IBM RSA hardware,
and it indeed seems to belong in a museum.

Here is what I found regarding its lifecycle:
1. The IBM Remote Supervisor Adapter (RSA) and RSA II were early 2000s
    management PCI/ISA cards for ancient IBM eServer xSeries machines.
2. IBM deprecated the RSA family and replaced it with IMM around 2008.
3. IBM sold its x86 server business to Lenovo in 2014. Modern systems
    use entirely different BMCs.

I also reviewed the recent git history of the driver. Aside from
mechanical treewide VFS API updates, the only recent activity I saw
was another out-of-bounds fix in `command_file_write` a few months ago.

However, just like my patches, that recent fix addresses a security
vulnerability (a userspace-triggered OOB) rather than a functional
bug reported by an active hardware user. Keeping this obsolete driver
in the tree just leaves an unnecessary attack surface that forces core
maintainers to endlessly review security patches for dead hardware.

Given these findings, I believe the driver is essentially dead code.
However, I want to entirely defer to your judgment. If you feel it
is still worth keeping in the kernel, I can continue refining this
OOB patch series. Alternatively, if you agree it is time to retire
it, I would be happy to send a patch to completely remove the
`drivers/misc/ibmasm/` directory.

Please let me know which path you would prefer.

Best regards,
Mingyu Wang


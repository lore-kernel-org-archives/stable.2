Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72172236EB;
	Fri, 31 Jul 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506302; cv=none; b=FGad9kdL0dRO73J0U/JLgyerQaq3N1ruNUwsJmYq125TFTKRNq1Fc8uAOVGsre3rQ4aG82+T/lxPFQg+gDkywo4+Y26MyPrx7ofTnDUlmnrPzSL3XGyGngokoUZdUc3nvPDQ459x6lvX7aEr4rfwakzypt6/bsblnmufDh5995s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506302; c=relaxed/simple;
	bh=oZjCRdueaPDs7hoizRyRHgRHSvs7DkIzz2QgncWH1RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUsggRmSC9KrimxA7E4TOwoPRFU/ar798cxwXrzPAI6yNjCsvNYwvwVtohyfxjtn7yVBCBtMIw7/b4XThD3x2Og26iNcCHu10o7Zbg9VyG4fhO/uv9tH8lyyWQxHTFbjctB2VqqBo8ZVWEUGqW4dnRGtey2kP921exPsYvIsekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=w5CLDXaI reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="w5CLDXaI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=6GQ+vMLqZ
	Ceol9jN9OnswiXkKCRd8fxCf4sKIaBGSW0=; b=w5CLDXaIUrwBdGkPb8+hhVajB
	qDzeQTruzbfXX6eRV4+rxuU7/qCnlplAXoHDZ+L7nqYFSeq+aZjucI0SKTdhyz1O
	l/TVZPLZEUI0NKJTahl4hprIMU/8nD4pkBIDTQ9sTo8Mbpeab6u//qZRFFpC5vAw
	DOdDh7v5umHUlD6E+Q=
Received: from [192.168.1.110] (unknown [115.53.186.238])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkCW3DH1qWxqiQKxAQ--.42869S3;
	Fri, 31 Jul 2026 21:58:14 +0800 (CST)
Message-ID: <c6e161e2-3ba5-4384-ab43-ef9a802052fe@stu.xidian.edu.cn>
Date: Fri, 31 Jul 2026 21:58:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO
 access via malicious MFA
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, kees@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260718073253.96741-1-25181214217@stu.xidian.edu.cn>
 <20260718073253.96741-3-25181214217@stu.xidian.edu.cn>
 <2026073113-defy-shortage-2005@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026073113-defy-shortage-2005@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCW3DH1qWxqiQKxAQ--.42869S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFykZr18Cw4UJF17ur4xCrg_yoWxKwb_Wa
	4kZF9Fgr9rG3Z5uF9IgF17Z3yUA347Wry0yF9xJrZrt34fZFsrua1DurZFk34vkayYgr12
	vw45u3ySkr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07jF1v3UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQULEWprau2lZQAAsY

Hi Greg,

> Ah, this is I2O hardware.  Wow, I don't think that's even around
> anymore, is it?  Do you have access to it to test this?

You are spot on—the hardware is ancient, and I do not have access
to a physical device.

We tested this exclusively in our virtual device fuzzing framework.
By modeling basic PCI/I2O memory interactions in QEMU, the fuzzer
injected a malformed MFA (Message Frame Address), triggering the
OOB access. The patch was verified to block the malicious MFA
within that emulated environment.

Given how old this driver is, if the community decides it is better
to remove the driver entirely rather than maintain patches for
emulated edge cases, I completely understand.

Best regards,
Mingyu Wang


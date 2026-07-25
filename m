Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBED2E414;
	Sat, 25 Jul 2026 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993046; cv=none; b=NNh5nrKGssUYwOFyA3Cf5tsEEUb4X9y1DlIgsNfWx5jm6+Ghh9+IPZCPR/3TSN/q8fJNIe9cgY7Y+pRCteP5X6WyDr3PtAov1Z3zxCcLXfbI7zyffiFLJpyllLfEE4zF+1IcMcHT7hLI3VZvpWkHze3KjlXHPhktI8L4UTTIlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993046; c=relaxed/simple;
	bh=BnZzoWN2mJ37wDH5vXCtYWMrjPsWh+wDtKl76/2rYFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBz+QBybRaH/ivp0/5YGkTPDq8iMkFvK073JfZ/mj6IfSaTd66+O+t5Vs8OaqQR8gZwhqkZaj60UA23aOLfNcKXlTJPIgZ6pvTQCAiiGpJCQH6vWJyM3oAAQ3jLuormv54KL9o1tY4qBxENjAPQ1bfGvNtGxYTUAjDY8UjD4Ko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=oPrIcmaH reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="oPrIcmaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=jWYYLigkY
	acoL3r+VozmhhqscJLLFMITzsgSs3ZOLZo=; b=oPrIcmaHsSkTjeqkfE4O5mwB2
	uB+dp02RwY9+5NVsf6OxrkTBTRdOJOv/NMeWV7tuFrSbMQ6xEQKLwTdy7kOedqBf
	yJEMac7Y4hDhPvKQbGRWd+vC5HLdWci6CWchD+lcnCBj0EPzjeAdUMzMcnm/1OUL
	vBsc0pxYJPVMfgfCoY=
Received: from [192.168.1.110] (unknown [115.53.190.134])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkD2PTP41GRqe3x3AQ--.21553S3;
	Sat, 25 Jul 2026 23:23:38 +0800 (CST)
Message-ID: <8b900197-f633-4917-b1f4-5c8cd46f025f@stu.xidian.edu.cn>
Date: Sat, 25 Jul 2026 23:23:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: core: Fix pointer desynchronization in
 fb_io_read()
To: Helge Deller <deller@gmx.de>, simona@ffwll.ch
Cc: tzimmermann@suse.de, sam@ravnborg.org, javierm@redhat.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260721081942.107024-1-25181214217@stu.xidian.edu.cn>
 <86a0387c-b704-4ea5-8117-02b30c4faeb3@gmx.de>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <86a0387c-b704-4ea5-8117-02b30c4faeb3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BLQMCkD2PTP41GRqe3x3AQ--.21553S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW7AF47KFWUJw4Dtr4rAFb_yoW3Jrb_Ka
	nYvr4xC34DGrn7CFna9F47GrWqyF4kur4vvw1xWrsIga47Aan3ZFZ8CF10vrWft348JF15
	Jr1qgw4S9w1S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07jnsqXUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUFEWpk02wAiAAAsp


> Thanks for the patch!
> It seems correct, and I've added it to the fbdev git tree.
>
> Did you actually ran into a problem, or how did you find this 
> optimization?
>
>
Hi Helge,

Thanks for reviewing and applying the patch!

To answer your question: this wasn't triggered on production hardware.
It was found while using our DevGen virtual device framework together
with syzkaller to fuzz legacy fbdev drivers.

DevGen triggered several OOB crashes in fbdev, and during the manual
code audit to root-cause them, I noticed the src pointer desynchronization
in fb_io_read(). It was a clear logic bug, so I extracted it as a
standalone fix.

Thanks again for your time and for maintaining the subsystem!

Best regards,
Mingyu Wang


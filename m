Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE13ACF17;
	Thu,  6 Aug 2026 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979865; cv=none; b=tT0BaFiw0Zr99a/JUGCXj4lhOG3bx32Px+E5SYM2g+4o9v3Fsiygxlup9xK4LOLhYJ7/VblHQ/tu6F5jEl+J22GZBMtKEh/ec1J5YJY9QlZtlZMvNvD5RwqhRzQd72L8NsuxntUHcGvHm8UV8YIdndFgpWlkBY0zXOlHalxGUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979865; c=relaxed/simple;
	bh=Gm133SdNSU5loWI6t0dGujNfsaLWX6SzhkSafhy/m2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7BYRWkYsCuDe/G1wu3LSEkta+WQlPqrwernH7omB1tzBtsOpzFzNNQvsBjKelP44lkRzkdM1vthUZ0LVXCHVLfFZFzhqmkJPgBcBhmbcgKvroZ6zxqdqojyQ1uNTVMmDDNrsZFYOscrOgJdeHaaHIoJk9SQ7/ZfmMlKZZYSK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=7F8WrUdF reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="7F8WrUdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=Gm133SdNS
	U5loWI6t0dGujNfsaLWX6SzhkSafhy/m2U=; b=7F8WrUdF6bA8aLKbfX98fHgjh
	LHg18AmHuZKEFRyyJCTlAFY46hWCp+GDaO8N6LYzleDqRefDbOzzPNWnqod17Xuo
	Wx9qe7MpSSjBSnXtug1L0pY73XLjOYHh6xaDAlkMXzR8Wlu+dRoWYI/cY+j14qpi
	FSfVa/zRFEiHdjNzL8=
Received: from [192.168.1.110] (unknown [115.53.185.89])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkD2Xde+43Nq0xnqAQ--.40654S3;
	Thu, 06 Aug 2026 09:30:38 +0800 (CST)
Message-ID: <cb04f43b-c86f-44f2-ba13-d172d7e03783@stu.xidian.edu.cn>
Date: Thu, 6 Aug 2026 09:30:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: fix UAF and GPF in idempotent_init_module via
 heap allocation
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Johan Hovold <johan@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
 <8d507b50-b5a2-48a8-a4bb-f196ac28b5e4@suse.com>
 <f79bc014-a606-4ab5-adfd-1b56dbdc30ba@stu.xidian.edu.cn>
 <1951733c-0d8f-4d1d-9da1-fd71d23781de@suse.com>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <1951733c-0d8f-4d1d-9da1-fd71d23781de@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkD2Xde+43Nq0xnqAQ--.40654S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyxXr48Gw18uFy5tr1xuFg_yoW3Zrg_ur
	WUKryxKw17Kaya9w43Gr1fWFs7Ka9YkryDXay0qFZxC3s3ZFs8AryDt3yfWr43Wa95Krn8
	Jrs8J3yfZ34j9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z2
	80aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x02
	62kKe7AKxVWUtVW8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7IU8a0P3UUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUPEWpwsH2dlgADsG

> An oopsed task can leave behind various kernel structures in an
> inconsistent state, such as unreleased locks, incorrect reference counts
> and leaked objects. It is expected that the kernel may behave strangely
> afterward and this can result in subsequent problems, such as deadlocks
> or crashes.
>
> Loading a module is a heavyweight operation that injects new code and
> data into the kernel. If it ends in an oops, I think it is fair that no
> additional modules can be inserted. I don't see that the module loader
> is doing anything wrong or behaving differently from other kernel
> components in this regard.

Makes sense. Hardening the module loader against a post-oops state is

indeed unnecessary. I'll drop this and go after the driver bugs instead.

Thanks for the review.

Cheers,
Mingyu


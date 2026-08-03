Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04330F52B;
	Mon,  3 Aug 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768005; cv=none; b=gOYiP/ThitzNbErHOWmfx0MicBSrh6uNpG7gdAVwjKrGA7SCeewYG2T3xZ1k5evPamzEvIWxTq0JuxnnI0U2/KuIt5OxaokU/bxT4P8AEYd+4zRUALI41JLT0b2UcXnqTEWo5wF2W2nsE8myEAb9TcnjYFcAV6n72JDf6lMwTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768005; c=relaxed/simple;
	bh=vB+JLyRZfqkypQxs3bd+09E6Vb40JbVt60BfXZfh56s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB4XBFoe6FaTkAYDEbf150b43Tl4rc+3NfI8EkKY1i1GoHpQTjdVrNtyykh0SY8/3PzMUtP1n6J+0mNlE1+b8STGdn5+tS0URWYd2u8OeV4X/1eHV9Epk/xVaFOHq/PMX6IolqTJJkOT/xSJQRuvxCF5mxN0skoJ7er4kxHVeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=rRIhaz9E reason="key not found in DNS"; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="rRIhaz9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=zikC+lXga
	ySyf9v4+Joz+DRFET+DATnOMZ1d30rrZfw=; b=rRIhaz9EiuIjWRrQaUvzKH5U/
	487IYE359D4as/6APUD+Hy43rB0Dsmuvo/3HJFq4CRDzCeuOwZKGIB1xPQtiDt5e
	hyuM+0na+jyJZDBb8AnGtX5zgcc8+egfEp8/fnXB9XjwQOHxV8sRRpYeuPM+7DGh
	qiwrGPxd0whSPJmtGk=
Received: from [192.168.1.110] (unknown [115.53.185.209])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkB22NEhqHBqEWXTAQ--.18132S3;
	Mon, 03 Aug 2026 22:39:30 +0800 (CST)
Message-ID: <514ebe5c-4867-47e8-9500-0b0cab9eb243@stu.xidian.edu.cn>
Date: Mon, 3 Aug 2026 22:39:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: vt: fix memory leak in vc_allocate()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable@vger.kernel.org
References: <20260731024550.158801-1-25181214217@stu.xidian.edu.cn>
 <2026080339-proofing-catsup-bee9@gregkh>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <2026080339-proofing-catsup-bee9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkB22NEhqHBqEWXTAQ--.18132S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4DtFy8Jw1kZFyktw1xAFb_yoW3KrXEg3
	Z5tFnIy3s7CF4ktwnFkrW7ZrZrWw4fWrWUGF95uwnxKryUuanrZa1DWrWqvF4xGasrWFWY
	krZ8ZFWftw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07jF89NUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUOEWpvXvycTwAAss

Hi Greg,

> Shouldn't you be checking vc->uni_pagedict_loc before calling this
> function?
>
> Right now we have callers sometimes checking this, and sometimes not,
> while the function doesn't seem to care, but we should be consistant,
> right?  This will only need to be cleaned up if the previous check in
> this function was correct.

Thank you for the review.

Yes, the previous check in this function is correct. It acts as a
conditional initialization, allocating the default map only if the VC
did not already inherit one during visual_init().

While con_free_unimap() safely handles NULL internally, I completely
agree that keeping the callers consistent is better for readability
and maintenance.

I will add the explicit check for *vc->uni_pagedict_loc in the
err_free path and send a v3 shortly.

Best regards,
Mingyu Wang


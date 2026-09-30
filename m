Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FC4D0CFD
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770511; cv=none; b=QXgC6CQvHkiXZfQYBTI66ajn6Fx/VtA3u/ikLC3AImhbNPsfTF/iRR+xVfpf72djrVoSk/izKnQIP9AA57f3qBlBghhyYe5Wf9GCfx/IiUSd4PmZkaHHAegUkjt8PtqvpcFW9wXury5cx0IeHsdHbUYi6oAkDV7AuasqrHMYnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770511; c=relaxed/simple;
	bh=7nR7ToxbmF2vXPy/2r05JJLxk0ahQyjYyzObpufFnqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWB+8XdhXl5yfPyqJ/td4a/KT6XgFebBo7KbbioWZgLRfdTFJIWzcq4gKijCih3P7kUcRE+OPgLBIq7X1LnE2wMqy5hCrdH3i1RxOayXDzJUqogkRzPbtRypgzxRtPiSowe6dFzOEQvPbbmvQ0MbZX8csdt6OyQ6j7JW79T5uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=KqMgfzH9; arc=none smtp.client-ip=62.149.156.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="KqMgfzH9"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id Bt6Jxwm5xxUh5Bt6NxVwKy; Wed, 30 Sep 2026 14:08:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790770080; bh=7nR7ToxbmF2vXPy/2r05JJLxk0ahQyjYyzObpufFnqI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=KqMgfzH9MBaLdaPI+QSpYJj8Qa0DG8KfPVPdFedn+oOScNZwn9I7TOUOYVOU+VEc2
	 cS6LUtg5sO+R2VwpkEq40txU0R5pIEy9gcZ0b8Uabzyq1yeSsSwtwpB01PHU+vp+3q
	 3PMeA6847XxU0/dGh96pltZ7IHacryJS5HsYQrENVK14Ac4E4h4X5NkfkE36cFRKTG
	 zhOXULpKdtJeDoHqupRN7fHfeSLLxS2zClYTXHc5bxbLXZZq1+MMZBgHsbAWv+VIkf
	 RmhhqS0bzceThGfT32PcLQkSCcrRH4C8NwydgSuZ6Ouj4otXUYoBTaUSSyx6/PxJmI
	 N9rDjFYfibEig==
Message-ID: <83bf278d-ea13-4e1a-b6b2-a114051cd62c@enneenne.com>
Date: Wed, 30 Sep 2026 14:07:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] pps: generators: fix use-after-free when closing a
 removed device
Content-Language: en-US
To: Danish Khateeb <danishkhateeb03@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Calvin Owens <calvin@wbinvd.org>, Yibo Tan <lhfff@tju.edu.cn>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260929124937.51114-1-danishkhateeb03@gmail.com>
 <20260929124937.51114-2-danishkhateeb03@gmail.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260929124937.51114-2-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIreEbdPnEpmxLjwIvayXYXH1yNzYXWLnxwLxBdlnMMVtLV8N7qkiM2+XxIaTkkRj5woJV7Gm76gb7bFp4F30EiZby5bmdjqsPobpCq43ZN6Es9lju7x
 lBwOwKXPl/t4Vp2Bu0Xdx+ZneV14Q4hi5BYKLUS8E95ZVKWCuik/+Nn9+jjwMS6XJLMlspzcj6AjcZl27jBuMtoI6eqDfdqfZs2iMMEmLa7xksCg+h2Egf34
 CmnaiHX4EM9T+T6QZuWG17WeGJfhoVUSacjE4k8BIotggX7ZaZjiUM4SeNlCN3UrFcisj4AFAH4dBVhKPSYA5NoAfjuD7KiyoFyQhh1dRtiW++1UQAW1dn0L
 1h6ZoI1QUtqgyiJTLaqZ9WYQ8pFTycF6ZhBepbGvzqfOr1ScvbbZZV34VuhWa5iHy0S8J10C

On Tue, 29 Sep 2026 07:49:34 -0500, Danish Khateeb wrote:
> The cdev of a PPS generator is embedded in struct pps_gen_device, but
> nothing ties the lifetime of that structure to the cdev: pps_gen is
> freed by the release function of its device, and an open file holds a
> device reference only until pps_gen_cdev_release() drops it.
>
> When the generator is unregistered while /dev/pps-genN is open, that
> put_device() drops the last reference and frees pps_gen, and __fput()
> then calls cdev_put() on the freed cdev:
>
>   BUG: KASAN: slab-use-after-free in cdev_put+0x53/0x60
>   Read of size 8 at addr ffff88801383e138 by task ppsgen64/149
>   Call Trace:
>    cdev_put+0x53/0x60
>    __fput+0x745/0xad0
>    fput_close_sync+0xd9/0x1b0
>    __x64_sys_close+0x86/0xf0
>   ...
>   Freed by task 149:
>    kfree+0x25a/0x6d0
>    device_release+0xca/0x3c0
>    kobject_put+0x169/0x320
>    pps_gen_cdev_release+0x51/0x80
>    __fput+0x36a/0xad0
>
> pps.c had the same bug, fixed in commit c79a39dc8d06 ("pps: Fix a
> use-after-free").
>
> Fix it the usual way: embed the struct device in pps_gen_device and
> register both with cdev_device_add(). This makes the device the parent
> of the cdev, so the cdev holds a device reference until the last file
> is closed.
>
> Fixes: 86b525bed275 ("drivers pps: add PPS generators support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

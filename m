Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCD305698;
	Sat, 18 Jul 2026 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784405088; cv=none; b=Q8J6/J0F2YtTBk/t+5AEIcSnPFwS1N1Y7F8onZ2Ha1/4TB+Izw+4AWfVxWxI//l+ZJcjwsUH3JALOdfDou97kWg+yOZadqVr0whzh2wflfvYRumkMqqbGVlt8RoXq+GbtRklubFcuP3x2hjvdphSFyyzHsEY9w1AjimK+IOzVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784405088; c=relaxed/simple;
	bh=Cro+eJnG6VDs6syJcTGQ7LTnS5fPdvuYbQVuPcRvVMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pI6x4S0+5jSWtPBNPVxeOnInt4+hfJp+W4rvjunh20teeGZTgJFiqK+LlJIXngSCv5g5JE9rb15uQq3ACSwYnq+koeYWZJz/nI5ZCn9j4n3AgmrNmZO++Of4FEcHFdVGO7KKSAmInToFtuPG2BNjwfCGN9Vu7ZhWMwK3J/xRvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=jjY1vkV/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="jjY1vkV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784405083; x=1785009883; i=deller@gmx.de;
	bh=+dehz8b8AGbwSVNS2nOI3aoBYLnLrTWhHrus1KN9fHQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jjY1vkV/h1b7EEa7Q6M5PCQrW4gN2xuHKmdteLLJDWVDFoJ0G/7f1UMp16FuDCmW
	 UMD9m7QxtKYdTJjZoOWLobo5DdkHy31wdyZJanL9e4ueWvpKN4W5vL77NlVcu8cHJ
	 PBMlKD06GyOSchWpoR6ssGMTcwvzMni5x1v1N3Yh5mqIwVt+06FHMhpc2N0UbTafi
	 1sfTWBMKZhf0mDR8ztENr1B62+isqzP2M0Le+O+LmXOLdkEMw8mQm93zkXtJIK6JZ
	 3kprPoTl9KkXE48PRHm2SYvdSZ9hTi5mV45IGOsn3s2NrIG/oo252PPavW5ldXZ3H
	 EkkGXC/BWmKNo2Qypw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1xPTqQ2Fld-00jj38; Sat, 18
 Jul 2026 22:04:43 +0200
Message-ID: <87e31377-e20c-44b8-93f3-9f7eb2165e52@gmx.de>
Date: Sat, 18 Jul 2026 22:04:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fbdev: bound mode sysfs output to the sysfs buffer
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
 <20260701234248.236023-2-mlbnkm1@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260701234248.236023-2-mlbnkm1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sfQxP2W5hSWDYJRoBEnOl5bqyZhP17ow85nAEnsjk8Ib6+htIbe
 UbZSBjp3hqDSVwRoMjdPPeLJ83uLOAgwzX8emY83Bs3LKdDdshtKNrAbfLbSvoYtjAhT0tN
 0xAeo8DNxf2krg2jEjd3qY/imTm8Em6n8DSUQ6FOZxNBdc6GKO6h6Hk6bd1eZ9wYULhRf25
 jGthssNdCkgff8ktAwLog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+eVVULaW0PA=;+EYBWEpze9e9kN/KbGOEw3GlpML
 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
 1OXypV49L9L+F3WCGipQU

On 7/2/26 01:42, Melbin K Mathew wrote:
> mode_string() uses snprintf() which can return a value larger than the
> remaining buffer space. show_modes() accumulates the return value into i
> without checking whether i has reached PAGE_SIZE, causing the offset to
> advance past the sysfs buffer if the modelist is long enough.
>=20
> Add a size parameter to mode_string() and use scnprintf() to return
> only the bytes actually written. Add an early return when offset
> already exceeds the buffer. In show_modes(), stop accumulating once
> the buffer is full.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> ---
>   drivers/video/fbdev/core/fbsysfs.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
I've applied the series to fbdev git tree for further testing.

Thanks!
Helge

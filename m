Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206883;
	b=cHLpNst7ngg1yEZFy5a0Jem/MfBger4ZhnI3GUhUFI5YrZAaP9x2VnK7BLYc99+5BVPY
	 sqhA5wIqZeVvutftIKq+hEU+QcVlOGsgWiutoqhIHyGoTEQKtJXCEeC8exdVhoeCaJCRt
	 xvk2l2kGuPFuVBL2SOM4h+bLINEytnEf0iZa1U0y1YSsyXGRyg77JpYl/yWRvx8ucrn72
	 AEortzLJDvu79vYgj289u9sXiKBQihqInpHoXot4xtLvAFuHo5xqkctGHXagMpVBnqWsQ
	 Khh4kNMg5vNbn67h3SKLkZI+EspvfmAQAYA34KGX0/WmlldeqX/llw0VXJK8LN2nymQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=qtEU8b+Rw7oaJsWf+sYIPuoXL8GdHMocWcBYKlWujUQ=;
	b=Nh4txi9JNM/gZhDcQKetaN24a1v6UAmBPyXwMadiP+v/lfP8VIcBMqus49x14+cve7W9
	 2nNeUDAyouDWSEIR+R+iaUCKbbtU14RXnM4ZzpltbBC2WGA8aECod1h/kdzeuPZW3vmsP
	 nv3j/mu7KmKJ/ZaWfeVwP1+BWyQq3A7S2N4vB+ssLMEw+NkTW/xZNBXTwpptH8BsAFeQt
	 5gF+B1CytWQL9+t7a8noSlg1ja3i1QwVR75l9wJ3MGoFOXzTskOt1ygx5O86Fuh+/1Gfx
	 gG1klKH9eF504rafq7JmpwEgUKKIgkoxQcUC3z6wXGfIrMxjDdHW3s9oiD4DYxWP6AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5yeIS2J;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49732606A6DF
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49732606A6DF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5yeIS2J
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-55d846e884eso4127991cf.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795206882; x=1795811682; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qtEU8b+Rw7oaJsWf+sYIPuoXL8GdHMocWcBYKlWujUQ=;
        b=q5yeIS2JOBZN8SyUZivBafXJ5weCfBqketjq0eLDKLrN7YZ2N6gR0MhBibsYavzWKn
         Xe9K3kyC6GDMe4ASXmusLzO6cObMlo7JgOQb0MTVxP7sB0Xk9qz4THLnTU1Atze6HCLu
         ckY6hAPQXY62JFVKV81+brWd3wGIQQZ1nCHZofTLRe4aHHo5WvHvIAbo5mzkZ1XJrv9E
         X5KqaS+8FI65FlF9mm48fUb9Ks1ShjexokRsIq+aSICvVEdu7Sti8Ha/yFb3H7ZALz/R
         a+eEJUcPqupQcPO4y9CawPOhtI0i1T/as35JX8fDYOsjurYeArNxBQKygKvO0eCRlc1o
         9+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795206882; x=1795811682;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qtEU8b+Rw7oaJsWf+sYIPuoXL8GdHMocWcBYKlWujUQ=;
        b=k0/HSd/NyO3sQyVNPz49FlEM9dTgJ9IyNxhVFGSvh+hygsqQl8ICV5ZI2bnitZZlXf
         RF5DxZ9YL6lW8hYu05v+DFGI6U4A7TkxmxxWnPuyuttAeX6/C+tYP8a/LQ/9mU6nT2j1
         LukllKVktc9Ulg/aQwUcYOGSo4RYAqs2lXQDj/KUa2MfNR+QMQV3wVuOFKDkqSO3UNHL
         ofCC5iEy3HV9Xq+2/dK1LbGhy710AtDTztP6NJ1Pba5IsQbUaVMf1uvLT2nzPDqIUptg
         PRA9mKhSPqwhOH0KwzAcFmS10lus3TVuh4OUBk428r/wRGkQf96itVmkpeRx5J5Ept+s
         rjTQ==
X-Forwarded-Encrypted: i=1; AL+hErGGn9IbfRrU63mY/vN2UilU10cFzgUEOHUz7FWXaPnW9pPBdeaerPgtmgZLfTOzgvHoaBEVnRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SC1tGnSwOVFg8GWBINpj22QmduUTRPUnP1SKGhWn619pWinfs
	kjkvrycNHeR2t9cC6yq2UsJwnpsFQbKJRkjusZBExAnkjcWY/g3BW195
X-Gm-Gg: AYBFou2C/5LUby6PQchCE2LssNELhoYoAIjLsmVU9ChTqyOOIhyjooNMJdh4mfr3f5x
	V1EwBCAcxPX3OUlDCmQeJx1ITt3cxM9ZDOE77m9jI8R2dc+gtn1i7jOWeoViCocSyx4BcpNo3vj
	lUNuD6vNjI6FSqmSyMqDqpSxNhk1/KvfXykf7fTmhBVJhHOlt2gsIlr7RjkU0FqP1lsZj+d5/rr
	lToL1B/LdDE3VLSvE+Sbuk6GafuFB3BWl5nY75HpbnQqNPLruU5etQ8TeA86idS6SLhGQt+1+C8
	s6gdxRvlowej3O7hKFobOtjJxuTFBA1DWjVQ1ljw5TAh5yhxTBbHxLATlN+KxN999gRDz7CCVdG
	PVCaUVz/DwrRmpMrLHa9UZxKU3xbd45hZ99P4uLD/MyGFCeXbmV/JWHxd3xEMhNMRFUQhkv5gW8
	fDzFSgHavUeLYE5C+Y3Ay90YFeY1mPhSo8Hal0mHP+Y0RG1CUsQN0/BlYirYwzRt0XS7gTzoq8L
	HV/PXQKOMmfzNqk86NW2GMocgEaNddl8mb2O+36jHqzSIDB8SzAXHAnRozxjfFwxcybPmA5+1OG
	qMlkvLpwiQ8C7yoo/Aepvg/8ajcneQsiMQw2YZu/7PZ8l14uFnX/3+IbesGW
X-Received: by 2002:a05:622a:1901:b0:536:6856:f590 with SMTP id d75a77b69052e-55d76a269dfmr80867651cf.18.1795206882285;
        Fri, 20 Nov 2026 12:34:42 -0800 (PST)
Received: from smtpclient.apple ([199.30.143.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7844f9bcsm32619781cf.1.2026.11.20.12.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2026 12:34:42 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] usb: gadget: f_fs: fix use-after-free in ffs_func_unbind
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <2026112053-skating-swimsuit-9c33@gregkh>
Date: Fri, 20 Nov 2026 15:34:39 -0500
Cc: viro@zeniv.linux.org.uk,
 r.baldyga@samsung.com,
 balbi@ti.com,
 linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C24E320A-EF6F-413E-A618-FB7FAF023F79@gmail.com>
References: <20260815013818.39466-1-shuangpeng.kernel@gmail.com>
 <2026112053-skating-swimsuit-9c33@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Nov 20, 2026, at 05:21, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Fri, Aug 14, 2026 at 09:38:18PM -0400, Shuangpeng Bai wrote:
> 
> Are you sure this is ok?  This means you now have a double reference.

The get is paired with a put at the end of the function, but taking and
dropping an extra reference isn't the cleanest way to fix this. The real
problem is the ordering: ffs_func_unbind() keeps using ffs after
functionfs_unbind() drops the reference. I'll send a v2 that moves
functionfs_unbind() to the end of ffs_func_unbind() instead, so no extra
reference is needed.

Best,
Shuangpeng


> 
> thanks,
> 
> greg k-h


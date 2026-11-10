Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287482;
	b=GszuOzKsMWRmrDqOm7Z+y/x9CmzWA3i0CfuprDUpckggdHqLOKcXCqyLaUAPpqQXBOg0
	 QlYOZDJCSU3VsNIpRbJb5664nZ5Nq9fYmmWyblTSg1kcH+L0RIlX3Lhz08p7aWkWvFEMB
	 cIN5oID/8D7JvLCxcPEvwGUUjmhq5sXS+C6Z8H94bEgOLw8aSmUWliGjmpkez9zoAKFxr
	 1T9XaHwz1zgYin25CPgyhQQ+vqF6oquApY/v3fCHdW/AqnO16oBxSQjcOwpQ63917US9D
	 CUY4Q8hqA7mZXLv9GA/Tx0pnttF5dHCJcit/2RVp8BClsz9Pk4vW8e2XIVe1jcafYmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UPqJGVV4jp1LmqkmUXYB895e79jFhk7s8cA2OJitgaQ=;
	b=Sg3gYk81v7LfZZHz0V10vGEMgGCoffLWBAwzxpipB79vlF15DpBzg1j8Ff2rcyJoM2mL
	 Cninbs3jmaLmW4B8g3vtcOieygEqmuDxpV+QmRDRu5vneQzZcWYVO2mbPVzJK+HL6A3oK
	 s2QIBTT0CwLLL+wTxTXvrBaMg5fNvU1KoZ1De2dTa/0mchCNvCJLyeP6DPsDYqWBF1un3
	 Rw9BXm7T1Un85j502XnVgHeeXoirXl6mVRDAvg/WokqNLRaluMbJ3p/TLjYwO+uu8ZPFN
	 Nlpl2cF17XJT/V6b3pb7Y5zgJweQqYFMKbXC1nbP2QuYRtj34xuieCyNYzDOJyS+Mzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bV+1yb9P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6360A261E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F6360A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bV+1yb9P
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91eed03da8bso11240346d6.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 21:11:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794287480; cv=none;
        d=google.com; s=arc-20260327;
        b=HC9syWKqadzKIN56DbtZROJLOszJYruCUrMXPl2+lB4KzgEW/kyJVvwPfOlPBSOyS0
         CAuKtE/u7ciPls/LkRo4bWqBlkYcyjRIWq8mf8OVG/5GDwN994udfANDFM7lWVxtGrJZ
         TblG6SuWDqIPfHnpi1tBHsbJMOQVf03gKWF91hypKp6shn0LcgoupctYJQOrjdcYmATF
         jsAVdGupYd5xTxRDz/sdmg63Dv8vdOlS93vNb/kQ8TS+br62vT+HAUbdLaXwcLYgczay
         NhfsG6ufkKIPxv+yfQLr04KZ5FuddZKY2zhsM4u5MWOpJDrGJGXe31hBHxm+VjuslN00
         Vd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UPqJGVV4jp1LmqkmUXYB895e79jFhk7s8cA2OJitgaQ=;
        fh=+XzNqVsqYLruLQMzqlHCCusgoXSdKzookF0frXPqDhQ=;
        b=Qxk/sjzhWO5nbNIT8y5Mk+uVVuKggvXKILhaFW9DvjIOxNBZWrm0Q/phOmVNDEJN6d
         /3YBuY8fgsGS0w38qXFWJMatYWwHnFpQ+oUdqNNWHqhk7WKyC7KUFy6XXOkOZLzSJWu6
         BL/C/PeW50E3SIezPGThdpmLo1Q0j6J9N+oK7BFV/PEdizIZH+YDjzvTbqiRE5EIXttI
         E5e4vsSEHIPWmwlQEE1XPL2KJVUUz1Enq0GLF99lc6VKXv82EKFPpxEf6Hvo7y60705X
         gX+S1YEmVwZlVACBEN9CYGoaZGeDBlYdOP1ug3bSTViBhJ78RCYBAJaaFcbE0QRmAM5T
         WQgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794287480; x=1794892280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UPqJGVV4jp1LmqkmUXYB895e79jFhk7s8cA2OJitgaQ=;
        b=bV+1yb9PfRgp1o24sh5uZQeKCdtfcEjk8NX/TAclKxSmq0Qn8P2KBRX/LX//N/Y1Ps
         OIaXLMYzRM6L/2i9eEgVptKGlgezm5/t81zlPVHAw/xC88B+TaG2OZKM69cIcDGqOxL/
         DMdP6pu1a3tM9vhfiTMdTejq9xsp03LDWD1AvC/9VRZrdArV6g+B4lmUOmkIwcReWF1w
         rPxBAU0XA867cVyTYWPH5k99p7vruESu+VgylEhIuAS2NN0onm/qcbfrs+TOVAJGBTqT
         Oq6UsToLoLMpLSQjGzhoH+AoCyqyLMT9ndH48xGdiVxRaN7KhUR5eeKuUVhtVs8DLI3T
         ZhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794287480; x=1794892280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPqJGVV4jp1LmqkmUXYB895e79jFhk7s8cA2OJitgaQ=;
        b=vZjcbLbAfXWBTPOJdYKvq0fqbfR3vZFpss6c76cbws/hoAGnQiImApmgipjQfmrAoh
         P4GBcm4cwX5cpLmMdKt6q7lqVKF8kRBda2EBgIz4+T6AdpnPk+ZAsyzjbiCBzZqLAS/u
         wngaBNRaMjP75XbRiaL6bqozwbXu13AvwzkJJNQSqqb3YE3NrMi5t1jKZ5pepJZ0ux4i
         IKHD1Kw3b7dIUIflto9lxRbjL1JFSZjRolLB8sY13DEr5/IHF7x9BDhXnBCKMjlKpr+p
         2u2aSiOBxwD7+bLhpZHZ+kVCr2kvQJyagv2QGex2f2Sub8mYcIkETBQhGpWMHnJMPluw
         LJWw==
X-Forwarded-Encrypted: i=1; AL+hErENnDhozdYj7yqe/bobDSsQ9fsHZhkvTozLHLdL1SQJJnLUW707gMl8R21wySu59fTCaybaoXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KfmlzrnqT5TIa8yodqzr2ZdNNnkUghOjp0kp+ED36QL7T9p6V
	lj17+Z237CRQXnA3u+YHhLHaqFPlGqNsiCRPYZgskVVRvGoJud/bR4zUa3Zt80qpMxWEWBFHR3R
	Jxg23MA/vFmydvFnG2v4UNTbnBKlnJ7U=
X-Gm-Gg: AYBFou1g7SZ6cpbbEFT6Z7YhHVZCLgpf1rIutR+a1GzcFZ//SmieKrlzg6kFKMHdojq
	yZKYRUvXI1+SjZZ5RwWUIkyFsA6tq+oWfkRdrUwqQOWmWz8zTvtLv128JXWx86ardeg6rYp2gUZ
	xgkE6iWzOcWTQomKIuDAqe1Dmcq3Jyrqyjeeo3Lywv8hWMGmIEuF2uzU7ydQ2Dt2kZFp/jvKJR5
	GLVmhnGjB+5dwHo8NCcmBokgsRRtrEbneQz3UKb+hCD8TtF59Ca8z1m3lrecqG62txuHpGDUoEl
	9OGLLXh+Qvlt/b+zkZAb69ivim8hWtOt6mwc+32fcEfjEScOeAK2XcE63sMQE3jP0nMId9l5BuK
	q1a3HjU7f6PG+cu/eUUMd+FJSw4senj51NGmyBdOi5CAph2rIwnXj+Xbu6jFK3SHb
X-Received: by 2002:a05:6214:4019:b0:91e:ee6d:753c with SMTP id
 6a1803df08f44-91eef813853mr29247916d6.41.1794287480464; Mon, 09 Nov 2026
 21:11:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105160209.1504867-1-ekffu200098@gmail.com>
In-Reply-To: <20261105160209.1504867-1-ekffu200098@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 10 Nov 2026 14:11:05 +0900
X-Gm-Features: AclHuK8ikjvdRd9V8RuwzVdKjIe4FAsRE1P8Lc2SAhOxv_fN0Jy7rtPk86DfVSw
Message-ID: <CAC5umyj1FkS5ZTQKhPsG3-6FfnjxwgKvgSnr6tpbtjxfriVnYQ@mail.gmail.com>
Subject: Re: [PATCH] fault-inject: fix boot failure with fault injection boot parameters
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B411=E6=9C=886=E6=97=A5(=E9=87=91) 1:02 Sang-Heon Jeon <ekffu200=
098@gmail.com>:
>
> Since commit e9bc360b105c ("fault-inject: use prandom where
> cryptographically secure randomness is not needed"), setup_fault_attr()
> calls prandom_init_once(), which calls kmalloc() and schedule_work().
>
> But setup_fault_attr() can be called from __setup handlers before slab
> and workqueues are initialized, so any fault injection boot parameter
> leads to boot failure.
>
> So use DO_ONCE_LITE() instead.
>
> Fixes: e9bc360b105c ("fault-inject: use prandom where cryptographically s=
ecure randomness is not needed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Thank you very much for fixing the problem.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

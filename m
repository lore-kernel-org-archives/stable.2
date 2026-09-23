Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D444839E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145790; cv=none; b=s+zFkWXEJPlWi9Bv9vVJSJHJEopYakhg93Zo51Gwp798SBmKq/4uZIIqv9WiPo0jQCLb/bv9J5dymmSC/C/eYaTirFiY2Y4izfGv25wAzHuzIeXB5hiLDK4BjU0qCy9ANm+M4FfquAREKG5mJuPkiZUNC25IeHwq/KYhDnrh+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145790; c=relaxed/simple;
	bh=onJ3LfZHXM5TccZdOtCipqT84Y/YNc95VAbG1f9eJAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eytvry5pCAQfPtS7cx/jslmW8nZlCjYZr6kPrN/E02p+7XEIRyNhD9paUmTKhH8xAhJWyVtf/ceMqEUHyJ8z1/7THRerPX8FWb67QjPDhz9+z5wfOKPCTGqdFcAFDBXoULVY8moJ79GMjvCebvsvxeYoOdZD788ICc8a6yrdic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZHQ9Muo; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZHQ9Muo"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so3624025e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 23:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790145784; x=1790750584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5lddRRedq6bhlZyqKs7quxCdrfUc0s1t4+2l/QqC+sc=;
        b=lZHQ9Muot/5qm1KmYGRJdz611H0rNXQ5Q+7x/em9fl2+UJat2BcdeV0u8RQXROkJri
         e7Xlzs194V1VWI9uES2/nU7pWH5S5/klzEO5F9KC2ptCFnd/9GtefqD9WyQLzJ2Orav7
         /qkqYy3Nyw2EolEoxW3pXwsta7OXk9MA9DyBvVAOhiHr+8Sh4W3/FevptDQMkzcjOWQm
         sBKhR7A7X5jBHVIhQHDtiKB8jv2AFfgUjbAKIHkr3kcgWGx/g/F06EUj1Yv1XX4tiPNP
         jRzlGj/ec0TNwV8hOFWcINLA5kTs57dnhyWhimiUF37rgikGPYoC1Kg4pdBC6OXZiVok
         6pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790145784; x=1790750584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5lddRRedq6bhlZyqKs7quxCdrfUc0s1t4+2l/QqC+sc=;
        b=eU3SG66q1MsIhgk+ewDio96YhmKH2y0LSO+e6Q76+4xvgxbnOaGNKYLEHrxYoxlj+1
         QVQyDkwbmuimne+uYeudpmHEae1a7JzfBF21s/2To9lSDvR0ps6Tlp8DY7WpZYYOXCnP
         a+fuykTYGbmOtIauStIPmYT6grJjm2uO6Z5WiK+L2hIHHfNyCvpQ0i2JoSCA4n2vbfkW
         yVvyqPD0Cx9Ywhq5CxklHExQeKf+uIsU/6TPm0e45HkU6bSU5tD1O/62jbZnWfw2O1CT
         lSWG8+7GYp0y4wQ3G6e5aGEtc4aUlqGNJBMfjgHhm+IEKXelCsCu0pvi4Eb4P8DikLpF
         4Zsg==
X-Forwarded-Encrypted: i=1; AKwUvBwhDpqwC6NG1ZoH1OrVk3+5e7wgvV2bbo0tndbrapbDmlHG76e/JNZu3DCe++PqC83zM2xcJQY=@vger.kernel.org
X-Gm-Message-State: AFuF++kJUioY1x0YkpY3M+XOgQCAaErSw3WnDEm+ttmEb2VDqJx8ycyC
	4FJghG6WXWSo4zb8BwMDVrWmfNYtDzkNrUuLbCykA892tPjcvBmXcR73
X-Gm-Gg: AYBFou3j1tPhB/Ol+ky+/+vRSBuSR7dISFQoTlVjldHcnWBlYAX8LMP9nnEHTFzZxcR
	E9pOAL6SuvvdOpN8UC0Vxo3MgX3IaV/QZ/nz7HRwrDZ9YPcVV5gh/HPrYfVqjJQcj8zzBBWq57v
	4XZgA2T0vJ5jOiDBPyxlWxnjsQcDc/BDXACJg9zK3BkDag9VHmVCPlAtZ59VB8Quneq3vcRbxmT
	xppM4T79uLTH/4UOdQs+AKlfqQXNR9bllFlZ5KgfBJ1oD/lcliDDDL+9uHSkIqeQKzO4BNlas4N
	eRKGPa4qg4yhQK/Fv+Sy7ILwVVwmQbrzUDr82lTlYkxVLHrUNBPtOyq/o7g0D0GrWYKZVVXMSqQ
	7wofwOhVVo+VxVGWWorD8fVsd1aFfQGoP5LneVIXu1JINKM76b2FqfiLngqLIWzarKmL+w5nuRm
	cDIpzSnNtUDmo6o5jDuXYzM4j4IFAL9l2FY4za7mwspTFAB0kkLEnwM2SmMNjKaQunz6oD9gqYW
	84C9g==
X-Received: by 2002:a05:600c:4e93:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49fdee0a952mr18172255e9.3.1790145783894;
        Tue, 22 Sep 2026 23:43:03 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3731fsm37103685e9.2.2026.09.22.23.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:43:02 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:42:59 +0300
From: Dan Carpenter <error27@gmail.com>
To: Vladan Kalaba <vladan.kalaba@gmail.com>
Cc: gregkh@linuxfoundation.org, ovidiu.panait.oss@gmail.com,
	gustavopiazdasilva2102@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fix integer underflow in
 tx_fifo_depth
Message-ID: <arN08yVxjhAAyZ4S@stanley.mountain>
References: <20260922215849.16739-1-vladan.kalaba@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922215849.16739-1-vladan.kalaba@gmail.com>

On Tue, Sep 22, 2026 at 11:58:48PM +0200, Vladan Kalaba wrote:
> Fix integer underflow if tx_fifo_depth < 4 in axis-fifo.c due
> to check in axis_fifo_write() subtracting 4.
> 
> Fixes: 52ff2b840bc7 ("staging: axis-fifo: fix maximum TX packet length check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vladan Kalaba <vladan.kalaba@gmail.com>
> ---

This has been sent a number of times before.  The information comes
from device tree and we trust the device tree.

regards,
dan carpenter


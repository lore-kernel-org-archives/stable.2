Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B603A3546E5
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114343; cv=none; b=g73B/5KV3GI66Kuh0bNyh/9pUguWjljWTnHS+fweEle59SxbDwmRqqiEaZciAJfldia3rwcge8BKrcIC+0wYtE4aYpB3k6dfll92S4CUsWtBSSLmf2Llz56maRwKtbnUou+jT9pz3qkzMFQoB9hglriY9o00XhwMEJ6hT6arC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114343; c=relaxed/simple;
	bh=rjDwk63GlpD6IcSyJ6iGWBTG0j4qGvoDZhdWCYjXdCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBBWTsI8nweDX+2SQODrj6frfT9Qo95eZ5etWQZVU0nldfomaEtYtqdMv1kZTh5cVCRRNIW2njKl9xtnTI3VgOwFW0gmqIWnTe6ZGPWdOqFoF745Iwm8R9Uh1f4oWXTKFzeGnTWAhjBvMvmiMm81xwe9D9LWYpqDvWcI8nTLoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQdS6bnK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQdS6bnK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf22c18ad3so13315ad.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781114340; x=1781719140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDcoxqooq3aEAqC8ohG0LuHtDb4TZolRXl4+Rn70IsU=;
        b=eQdS6bnKf8OFjYdZWTGgi6/DB/Hk2p7zbEYwc/MsYJpMNpd5U/+hJIeUFJMhgboGdC
         qIEibdadVSNL99aVgECMz5I666Z/PbQYqOi2NnWTsve9F2964/SBEquLWuJiSEjTgZQK
         fC4FvZCzWIZPtiImHSf3QQvzaM72vUWxewuGI2j4GP1aQjoTtSRNPtEbLbdZ3qjLWaEW
         0doAE+5G0hN30YpVfya2FQ/6/pNCRtxqQjgJ0hRRG/Cyn+SQzmAEiS/R8TwXkCT7WEtV
         DnMXQ7eQxGfwQi+Sh+TiylbqIuI9t9Z2EUdnzzX0tGJfPv3dYpbyaoI0qG1556njWiIE
         +Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114340; x=1781719140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDcoxqooq3aEAqC8ohG0LuHtDb4TZolRXl4+Rn70IsU=;
        b=cUgFFOY3JCLtmxs8X0l1bDvOdmmrawC5x9+xSxQnLm+KZcxLK4DJ2PVlu1mEww0zNK
         4PN5Ee456tsfMwtRVC7Q7gIFIgz04a7y8gs2CrZxvzZkjP226Mw4yMm32N5c3DjvJWn5
         6Ttq375B5TzJGclEGqWEEvVrgNlwcN6hYHgUYyakb9gt2LpEi8gDGDYDMFFCXdeSk5TM
         W8RuSf6l9rDNaLfQxG4LkJ2SW1zXFIj2ufuJD82m/XaORcAeN4cBAX1xBXStSstvKCZR
         SDqOQ15bQApXBNmUk2UwCiaaFLoekGcLta0CdDUpOOW0ywtjMQ2B4U1JA0hchIhHdeY0
         JPbw==
X-Forwarded-Encrypted: i=1; AFNElJ8YroP8Iz21BqZX5sC2+017ZIshGNxRJZbw2oBSCi6LK38cvZJsa0cTI0AlOh4XWlwRrkAh7yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxepWwt762TJTeVD9n+GcNv2TRAb3Z2GpCdC/tyG8EJeNwwD3hZ
	8dsr4YOXvK1bKjAmvC8UXL3E8fR7HTkIyHg8uyZe3vFwj+ZFRk3iSmuFRfrSGKiLJA==
X-Gm-Gg: Acq92OE1xMGuJFDqIhiXv0jiq0ny/KuNqm5rtskfYKpF9uBxottkVPRACfK/0WBvhMM
	A5wLdfkMvXXOm44SW31gerAU1O1ePkv/LN9oBYYqy4NhvuYUUBYcNYA4JprVLLc8F9Yyd5cLreC
	baceDXKsOLRR/cnK9/66pufbygqfu9PaeZVmbgXmeTv/IW5+aa1KEWwRvFMiJkhs+lM+Csymgtq
	Cpx0FYfLjUKKrZ+VnHXPOU997areb8oPfK3XbX0u8HpFl3xenc/N0pWBkax7Irqo8YM4RtYfCJf
	X1u8cfdbB1dIjhrYFA+lPUZONI6nGLz6P+48KQjGp0Ckc8YowhYnhy1vvhm7gxvfET8d+u6YCCT
	99yMvKKuiV7tC6o4oMnJHt/OA4hXvCxT0v+I1SeQREiupnGLOrqCDxtMDxMs5wYhmeF5Y2DeF2K
	mMfv57beCyRazyFSWSvnXuU8tz0SPhRQq3pcaCkg84Q91++e1tmbu41X+IMqgMQxc0kwcbVuimF
	YTkFmjnAIXDM5NcHYYM+IQwd6uaGZRAizr6lACUiYlthYXHvnw7DwXY
X-Received: by 2002:a17:902:e84e:b0:2bf:749:551 with SMTP id d9443c01a7336-2c2d93c9b9cmr564445ad.22.1781114339342;
        Wed, 10 Jun 2026 10:58:59 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221a7e9sm33046676b3a.11.2026.06.10.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:58:58 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:58:54 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, khtsai@google.com,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	raubcameo@gmail.com, andrzej.p@samsung.com, balbi@ti.com,
	kyungmin.park@samsung.com, linux-usb@vger.kernel.org,
	Jianqiang kang <jianqkang@sina.cn>
Subject: Re: [PATCH 6.6.y] usb: gadget: f_ncm: Fix net_device lifecycle with
 device_move
Message-ID: <aiml3pDOjudjX71j@google.com>
References: <20260608053636.2797024-1-jianqkang@sina.cn>
 <20260608-stable-reply-0013@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-stable-reply-0013@kernel.org>

On Mon, Jun 08, 2026 at 08:51:59PM -0400, Sasha Levin wrote:
> > [PATCH 6.6.y] usb: gadget: f_ncm: Fix net_device lifecycle with device_move
> 
> I can't take this one (6.6 or 6.1) on its own. ec35c1969650 alone opens a
> userspace-reachable NULL deref in eth_get_drvinfo() that is later closed
> upstream by e002e92e88e1 ("usb: gadget: u_ether: Fix NULL pointer deref in
> eth_get_drvinfo"), so applying this commit by itself trades a UAF for a DoS.
> 
> Please send a complete backport that also includes e002e92e88e124 (as the
> follow-up patch in the same series) for both 6.6.y and 6.1.y, and I'll queue
> them together.

I just ran this patch plus a cherry-pick of e002e92e88e1 that you
mentioned through Android's CI with no issues. Same goes with 6.1.y, so
I can send Jianqiang's backports with the fix added to them.

Cheers,
--
Carlos Llamas

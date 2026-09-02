Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D048D874
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356807; cv=none; b=spassBTAkl3xpLqxCsRkqgZCy/bRjoMpBEQjhX2nAOMxCaQmioq8TUiqBF9n778fjJRSw1+RO6SVGXIRULKfLsOh5RhGisYHSbyLZ18PhWhFO6Ea09QmGd0NsVYN5UuFZTvE8yx1EpztP/vrvFwT/DZnMI1Qy6DpT8P6nN8pL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356807; c=relaxed/simple;
	bh=o0rlClM5qugEx/ua4/bp1yTHz7f4XBumez11VDdWuWE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EVuG6hYWYrKNxyN1eZZ11pqv0LYmkEYrSe7Kdzit5eFblca9dv88+xC1rK6Kv4oU01muQWkBTUH7zyqv75xEgDDDwJspn5OMVIaB6zUnuFc/TSYOAu3GGI6MA3T/SWFTLJmY4xDHJWmxsV5FD9BMcReyg61aZ7JJlbZo30WYu+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CypwyhgR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CypwyhgR"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so8332755e9.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356804; x=1788961604; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uung8BThZMwxg0EHYvlAQa0fyS8hJUcosA00cBSikLk=;
        b=CypwyhgRM1ZFUYjS2MpVnnyMySCGr4NbQqIVQUS+SavmPxzA+9aB1WWxfFNf6a7FoM
         qOT7Z1xYlC+Vjcj+zJhOp3T0nOv/zPZkVEiC11jc1vPMQcKOFabv1168pEm7lSz+YlLu
         SWuH5GHa9jbXysXxyW/GFIxkQVqGIyzWYoksnChwtckcByqaHh5/7ttC5D4zkTpFSBij
         nIbaYrBman9sZ4Ufo2M9uOqmTnLCqt/mg0ziTIR7+L+gu6yzdr12Wrl7fyMRwgyASH3k
         aPBQmgRjoFGb8xtJ4D4UFqC/GDwQUQwp24pF1R01QtR/Vp8mI9Zji46NH94R9Kc2K4W+
         AjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356804; x=1788961604;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uung8BThZMwxg0EHYvlAQa0fyS8hJUcosA00cBSikLk=;
        b=BRepeGq9FNZhLJpOUBrKbcff9WrdX22/Nl1pB5Xsw+KFqpR3cCjimUDNJZCUg+oH1z
         qrtvAyVW/xQkMurxkLSJ8qRkaM+4fetRPUnevd9QBRIU0o+i1A5yofFPYYzNFkOD8ZT7
         UgBZ0v9U4uUEwotWXcT6WOo5zYUQl2PvhBOjF+742r5w3otgIHeEJOXQyizGxZy6vpWu
         eKpygaImtVKmX22473snAd08NdlrwFVbPWtwbh5H1lpI2bGvxUgZxNduLhpajNh7QO1B
         +by+RIL5S4d84jdmlGUmYPZd0w05wCQPEO3kKND4t/ALxfEpkM967Mxfk3tAvxQ/TDr/
         ebrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7b/JzUeZC8wuaDCdslHGFZXxn7DxGwDosxh3D9JVw+npr8yjKSpWJ/rZYpUvuBCpm/n4bJEM=@vger.kernel.org
X-Gm-Message-State: AFuF++nllIfNX3EH46bzaZs65xFrSkjuhcbbgjc2d/3VVwQFrdwoOsp7
	bHTfy0Ak75BrYDdVC7/iIdsuLFnQAsDQ+QwFg/s2kRkthv2izpLh0Uv0
X-Gm-Gg: AR+sD116USjEw0AmgiEMm7SFOCkVZ/iruKX2PY7BJ6t+INbByfYR6w32RJo2SDbu6P2
	m4sAdI4PDLV4qkvXRNd7RKyR1pMLqFXjCrPR/LWdAeqDbyThtfuTyhDdlP1szq0Qdo+nIamL/f1
	P3ES0mkY8749oVaMvD12avlkIC3ywneRwYQEVNpYOWMjMGj4M/YgfzXhGUsvdDTLAPImTyRsYqm
	a/ylyfSJBHOn36Ydt2OxDtqdbS3jVxybW+bwZWTWG3kjtCUdb25RlxZP+goofU/5w2OGBGHojv6
	pTEhQ42UFvF0OOEGKGttTtgpXZwI9WCTosa7pO6j/WYP3KrWeeExfshk4WfZwefocylgFRHT/Vl
	jw82Y7mR3vdia+1E+Wqkskfy6rEv+uL1P6UCQ+EH3PP7Q0/yf8Zu/iCkJ9gba8Nr4Hjsf62dWKz
	j382t82i9L08GFNfrcO44OXNC/3B2XXhph01wI3clxyl9qD29INI4L6SPoso4VkNnAupw7Hl+B0
	/OAkpkswRqdIFcGfuEu1lvCT0obd/ixjlzLMYPCmAEfKkIDuNGOW7KEZfJTwQ==
X-Received: by 2002:a05:600c:621b:b0:499:dbae:86be with SMTP id 5b1f17b1804b1-49ce58352ccmr101662915e9.14.1788356804024;
        Wed, 02 Sep 2026 06:46:44 -0700 (PDT)
Received: from valmpani.valmpani (athedsl-11462.home.otenet.gr. [87.202.45.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce7dd5154sm39216155e9.2.2026.09.02.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ihex: Fix 16 bit truncation in ihex_binrec_size()
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vasileios Almpanis <vasilisalmpanis@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <2026090256-posture-affirm-f40f@gregkh>
References: <20260902-ihex-v1-1-67fdbf8d97ff@gmail.com>
 <2026090223-napped-nerd-790e@gregkh>
 <178835312958.943169.5134885168571622868.b4-reply@b4>
 <2026090256-posture-affirm-f40f@gregkh>
Date: Wed, 02 Sep 2026 15:46:41 +0200
Message-Id: <178835680142.947452.6844220046489942180.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788356802; l=1143;
 i=vasilisalmpanis@gmail.com; s=20260731; h=from:subject:message-id;
 bh=o0rlClM5qugEx/ua4/bp1yTHz7f4XBumez11VDdWuWE=;
 b=ZTa9yJ/mRy2fMWTJjmNTZkItUoMtxrHg0VZhvXOTrk3eYHYzwubnhdUl5eUntVDto5gGr/+bG
 68ahcPXnkhnDZI93/XaVX3vvM8juXzAGqTb7qRzysPYIsAfgMXi5aOS
X-Developer-Key: i=vasilisalmpanis@gmail.com; a=ed25519;
 pk=gn5Uo6yL8Tlpq5uATxA3nqoq+U8eWLRbjD+bOk0qSpU=

On 2026-09-02 14:56:48+02:00, Greg Kroah-Hartman wrote:
> On Wed, Sep 02, 2026 at 02:45:29PM +0200, Vasileios Almpanis wrote:
> 
> > On 2026-09-02 13:06:27+02:00, Greg Kroah-Hartman wrote:
> > 
> > I used fake images. 14 bytes long for the out-of-bounds bug and 6 bytes
> > for the infinite loop. I passed them through the sysfs fallback loader.
> 
> Cool, so root only, fake firmware, not a real issue?  :)

Okay got it, i'll drop Cc: stable

> 
> > Out-Of-Bounds bug image:
> > 00 00 00 00 ff ff 00 00 00 00 00 00 00 00
> > 
> > Infinite-loop image:
> > 00 00 00 00 ff fa
> > 
> > 
> > Yes its root only. The attributes are accessible only through root
> > and it also needs raw-gadget.
> > 
> > 
> > It does, but the value tops out at 65535 + 6 = 65541, so 17 bits, and
> > size_t is at least 32 bits. I chose size_t because sizeof(*p) is already
> > size_t. If you don't like it I can send v2 with u32.
> 
> Let's be specific, otherwise people will trip over the fact that this is
> different sizes.

I'll change it to u32 in v2 shortly.

> 
> thanks,
> 
> greg k-h

Kind regard,
Vasileios Almpanis


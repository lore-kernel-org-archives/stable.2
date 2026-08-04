Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0CF374A14
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812698; cv=none; b=lXoAGcdpuAZRvhQ4qyuEYAl16p4mS4QP05bMiRMFzzd+/1yJ5Jfb18SCDd1tKCKasMJlG8uIyL+stGfv4WgELgGdxUqpW5Xix0b6QXx2EqpvZ/f0L3LsNBR0e2gl7ryAD+sFoDYSM5zq2SQBH8ipakrJvxaZ2UUiAJ18C5W8P7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812698; c=relaxed/simple;
	bh=oSkTDAAzn04o7bEaWOCaoupEriQumY6yq5NDH62Wu6I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H3lSr7gynS8fcr12WTpejAbQPK0+RQ/YKg6Z+4pK5V+yfBvzyQaQKjvA0ULWwxqxzjYZ48X9IbIckQqMvPktvdWyV/hKis+0dLnToij1o7AmQPR1h1kZMajeAxkDQiTnNfqf3PJE6fLOlC8n2lQxqj1kSZoGFHeJsaTq00c3rDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St8PMMpP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St8PMMpP"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8114a4542b2so60931807b3.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812696; x=1786417496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HUlwf4K4FmOZKVZvEIHJGfsyTp9ZANuX8LKy5jCQlRk=;
        b=St8PMMpPZVNaKMdoZchq9sISerwSIVmR0oxSh8rtf1dQLNkgCIxFyUtXRqCnZbBHkU
         SRNoghnDS6gZ5w0aYAOGwJ8/A1m6A1usoUXtwDnth9GibtvF1/b/SeIuCOKNxznfS2mt
         3Cz7/yi79zyBdiqL36QEJUV1vLvaRHCda/5hIkkIf0jSJmDY2JS8c/7fs+uyyJZ5rRZp
         RwGWBakEPw2hFEf7UzZpOKbJkjuaJxyWPG7KNIqARbIhUKnNRWnB2cz9lVGu4yW9wOMG
         +dh8jIoFOdnDN2/iF/Fq2gS/fz21qyKE3rRDUMTJlM+74N0rEfPEF77rLOV3FZQ3E5Rf
         cyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812696; x=1786417496;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUlwf4K4FmOZKVZvEIHJGfsyTp9ZANuX8LKy5jCQlRk=;
        b=Vg3eJuFeOVCGJUxc3ateT3OinScKulaecb0kaWdU5QoFdwoDGlJFkcAIUiPYPDY/ET
         2ErMVxJV4VixuRC9ZBuK2PWwjPR1IMZ6rpOCGX4ZhSWUxSmcXVyRld88T4YJGDCbBA2L
         VWt2/pDMI624DH+cb7VC9ByjxwYJaa1Xj24AxnrNZSO2g3pOKZhoYPH+hwHRzZ/eiM5t
         VVQK8muUK7/KheNIohPNZYqPcGjOYoZ+JGEnq1n8VGzBRbAcZ+NA6hEcoUZ4THmGXDFD
         M5ss8c3p6BsU6WpJGQVMaa/aLIQXchh3JbMh5rgD0gysAb3KxBiqkMvBipOZri372oMl
         CJtg==
X-Forwarded-Encrypted: i=1; AHgh+Rr85rfipfxHmodehvjmKAh51Qg5wob5ntL7Jt4BtPQjowRV6I3Mblq0Gmv/1n6PA6yVS3twKiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIeK2S6ONs6u99ge9lSNO8JRa6ZTX+o5vfxBFddZ5dzuSKTwT8
	fO0yVVAyyawSR+rvOmjAMxhvdyXn+snkpu+d7RizarchWyyItxP2k8dv
X-Gm-Gg: AR+sD118V+BNzgKAVbGFnfkz0mKdpgkIMDvfOEQjG+MkitMUxFPMsriEuIuh0yRQerv
	1NTBLv+CTzpnOHeEfFfWfavlMDXd//jXgvauplKbDAqOq0NdL3nZAuStPWgZN9VkW62kEoqnpMG
	xN/a3IwsAcFeUBI6YOsKRZs5971lUUgKsaaAmWZsoxc2oD9MVNcnYZXH67clb+Bi7/WfWKsV/vW
	Us+8bXp2ZCHO4LyOx4vapF2kViUsrscWeTVU5y/I/fa/L0xIjg62jCqhcCJRXtO3wuvA236NRWI
	bhLYklFBosO//Af2BKff5e1YFAwW89UWPK6PKUfcO0Pjt2K2K2kPi1pAcS7oHz1e+8ugkvVePBl
	QpDDQuxsVuLrxRg1BWXbZ6j2aoARUOvA+nwXTaUr8gz5QYHVOqRieVa8ODqmvn9Vx+1aqGpXhpp
	Ohm1ddhG64fgE1djyFL7Cq1KSlk0VSPfH3WoxFdTHC26icYmHolQA8vpVpdon0rhUfvZzsIpy0S
	HSyl/nFcOlm7TuThTeD+Y3+GNDLfU/brtpA
X-Received: by 2002:a05:690c:a9a:b0:80b:9114:3b7e with SMTP id 00721157ae682-81fd4a2d85amr160196937b3.12.1785812695758;
        Mon, 03 Aug 2026 20:04:55 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82006078e91sm13105417b3.41.2026.08.03.20.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:04:54 -0700 (PDT)
Date: Mon, 03 Aug 2026 23:04:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.ad7f187edf35@gmail.com>
In-Reply-To: <20260803192228.49a49867@kernel.org>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260730082925.93759-3-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.f39af6152c60@gmail.com>
 <20260803192228.49a49867@kernel.org>
Subject: Re: [PATCH net v5 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 30 Jul 2026 05:22:21 -0400 Willem de Bruijn wrote:
> > Qihang wrote:
> > > tpacket_snd() reads dev->hard_header_len independently for skb
> > > allocation and header construction in tpacket_fill_skb(). Concurrent
> > > netdevice reconfiguration can therefore make the reserved headroom
> > > smaller than the amount later pushed, or make copylen - hard_header_len
> > > negative.
> > > 
> > > Snapshot hard_header_len once before processing ring frames and use it
> > > for the frame limit, headroom allocation, copy length, and skb
> > > construction. Pass the snapshot to tpacket_fill_skb().
> > > 
> > > The separate SOCK_DGRAM consistency problem between hard_header_len and
> > > header_ops->create is not addressed here.
> > > 
> > > Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Qihang <q.h.hack.winter@gmail.com>  

I missed this before, but Qihang is that your full name?

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Willem, does the *shiko feedback look like false positives?
> Both instances seem to provide different feedback, if I'm reading my own
> tea leaves right Claude discarded the Gemini feedback about a panic
> as a hallucination..
> 
> https://sashiko.dev/#/patchset/20260730082925.93759-2-q.h.hack.winter@gmail.com
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730082925.93759-2-q.h.hack.winter@gmail.com

If I read Gemini feedback correctly, all reports are about the current
solution falling short of fixing the instance of this race condition
with dev_hard_header(), which reads dev->hard_header_len directly.
The patch indeed mentions this limitation.

As well as the same issue with dev_validate_header(), which the commit
does not list as limitation. But that one is only reached with variable
length L2 protocols.

Side note, in net-next I can probably remove header_ops.validate now
that ax25 is gone, and with that all of dev_validate_header. No other
variable length L2 protocol ever implemented that callback.

But that won't help older kernels, of course. I think it's fine to
remove that CAP_SYS_RAWIO branch in the fix, which never had much
value anyway. It was there to allow testing purposely bad input or so.



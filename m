Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794419371;
	b=QiOxFVguRjMwWHmAFYAj9/K48zVAJAPEDQV+5h2F3rRFfTPehhefn0DrvKxXoZomzniR
	 j2FPQyyliOQfzdOeFVdladza5y2afdK1kB1j+y4y8KZvRwFF5BbJW1l0mGQsjobM6QSsk
	 JDTd+MnvdZ+QwOXoZwk7Vp0Dj4Q0/grpN/Qr39azi7ytlsqUPo3eEu2TcwR9pcUG4KkNU
	 yh3EdCyoqD+EkdyryAIvVNgBtccfgtw2zaPaaj4HlTQ6aKmyMY8qX6QlcEDTYRXQJa8iQ
	 zmIplPaPFzjtU38p2/vd69B8IlYgyEiQ6pcsLYXpxHdqn6zKFOV7AZ/YOB2NzaKHI2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=P0LlEVmtKbYkhBHowVJUvrAVEwB7x6mCjbop+wAsjGs=;
	b=vtLaOxOANgyptU0wyvQqQibomb4H+m+mF5tnlmHE7wG4qKPfOWWsoGp9A7/BLt46FTF7
	 Hy9tdMuMCFU59PKujrvvwvV0kRvbJLB272oyMBK2nlSt5G7cdlv/5QBr6YZTTYMN4GOii
	 P6uRwNEv7GYGrSNKGuu2EA8iw00bg5LPQQ5ZWJwWXzB+8XZ0KnZT+xmVcdntUAOd4R6RM
	 FfeBjZqgYKfP9mpbV9hhtyfHmGIDZpnUShvTTtwIAXWfSNmY/Lm5kmryY7sH8b4E7yShG
	 +d+U1yn72wFN/3IzeZn8+vuID9kUXXcqv5xMG/waBJOcyPtsyiDN+6OzhCssiqjg86A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmWdrLTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD1C606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD1C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmWdrLTA
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36f8cdd30beso6052479eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794419370; cv=none;
        d=google.com; s=arc-20260327;
        b=K8WoulxERzaefQ5bfRDaTnNAZ63icpJefOMfNZmnqOJB70n50RjmOhLsD69d92rmHf
         a6Lwmeej7vPmAFX4tcJHOKNzOQKa5ZRVUt21chFUeNPFwIhJuw+jL5GtMyC2+T6xrSvp
         FCrWF7P3Q97wVCHvV40xXmK+aJ1cx6JE6hXGS7UGgVMTw7msHpl4QTVaTbuC51j7OXW3
         H9boQjXV0vhvD6O2pZka8QsYsSLxzcfRwJ9zH6XgDWRiMkez7y37PD79TYp+h97KwbJT
         FGAntzoEyXWDtq5LgKf4INRKNT60BeZfxTKaHaxx3XUBIzt8PbmYyXkuDc+e7qavrVkG
         7U4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P0LlEVmtKbYkhBHowVJUvrAVEwB7x6mCjbop+wAsjGs=;
        fh=VMXA4VojjXEEb5aFIz9DxwumyFPWewyAE9X/zrcunOs=;
        b=fLt1eaVeKWZBS1n/+f2Z2Ncle9OVWAXdhvF4qBugGvHRJOybfAZSWD9GaIfxywi134
         3gJCEoTEcXCK5bVktqmYz+9oosdPhlOCMiKz+ahHOc8tZOdIVbn7cjW4MgKE/gWX++vA
         2CXWRsy4MYjUCgJur3zWtWLQxpfZMpIQnA4yJOlrgVc1zuAhQY8J6DlryglcPKp2HLGb
         V49XfHmJ5Gvj1y2kqix/sVQGLlRaUGRZOqoYWcDWSsHRt/JAdKuWo1Juy+AKeoUkEh/3
         NlWRNTFMEPOrPLMrFlhtz7XbQKeQpWy8g4LjdbH67unB8s7xDUypmSMQ4f5c6j4Ro2S0
         fZig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794419370; x=1795024170; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0LlEVmtKbYkhBHowVJUvrAVEwB7x6mCjbop+wAsjGs=;
        b=WmWdrLTAMz51OJvfqBlkxREe8w5ZZlX9pq5Mjk5ePhW52XUz38wj54Wyp/6Cr+DzGx
         JE+M3cZnUA7GzUAg9Mh11pxcBWfvK8CNRumwG+ZBobsrVgMVIhNFrioxpuuNf611MGW7
         M/9qJ5zDbvTzNUbDPk5V4iaDpMjLnici/uUiv5ZleuEg0UHmdhIDV2GKxkU8+12wPyr5
         E5xPiVS+YqxcGj9LWIPoOdIkVgnjzm4LBAupubZHdmjcSeDd6e4k4H00WJsHnKyUW8Qu
         7L6pqAG2oymoUQuCLLlGG4XYXywN7E4TsjOwfyhs0yMcG1W1y9TlGPeW6JUpjOVrSddl
         M79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419370; x=1795024170;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P0LlEVmtKbYkhBHowVJUvrAVEwB7x6mCjbop+wAsjGs=;
        b=ro9y19NMgJXXfFPHxDKH3UvzKPm6xW+O/IYUXFcUNVvVwkIX5waFzd+gEaxBrHTWmg
         HVF55Gt62svyZQXf5C1WoPzpXlbefYqNBUAOaedb3F0cKS4AC8oLvDkY4HPoq/4DYcMn
         iwJpEaolyF17XjDPuOVLdcZYyPwQL5Pz30vSbv9MSI7FdSvnsrbxEm0ek/93qmP3p6GY
         874QrO6rl+A5TdTMdXvduRuCCzfNyBln/OUyBkmZlHBI8rvQ/YAzEO0/HYjtmxFiyI9I
         p3Pvyex1uhItfS4eljYJuZcFV+j9mRkldCvfOyHzSnQe+yMOVLIl3FJe6xSTooTy1KGN
         fixQ==
X-Forwarded-Encrypted: i=1; AL+hErE9Xm7Sd7xxR//rBJq+iED3IvIoWoJevCPuiN7LNmJHmqO9kocQh4y461I6dJANF8xN5RsmHbc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iABCaJxEPOSxUP5nlLf00veH9c3C6OLv130nc41PTFYr3giRf
	gASSYtrSIT+V29ZLQDx0lg9W0KelPk9h1hRv8d4btC/w8OjsxYjdVTsYiltRz8reXhhtap+wu1c
	YnoPKaZulWtuJ34HV1/6blwIrQhcOB4+TIlJBwta3fA==
X-Gm-Gg: AYBFou0sF2PPr/i77DifUlHL0VjgtKf0OF+gYnVwaWzKGFd54ALCNalMObIyv0Qqv2p
	RN8L6cMSi6a6iH9gwmBpTRuy4yar78Yg3+yBshXyF6skrIk46EMXnOkoXSeogEpuPqhJpkiez4V
	Oe68mSL/wVccmg+kQio2FJNkW6oWXRox5AbhQ9dhGNSVAa6O9VwgXrNa4K7svq2C+/fl3y1qO+S
	MVBVQlZhhLrdEUN0bAs6itCL5/f1xUcfQO1/S70V/K6kJYxQJLyOSaaGKBNJj7l4iAFPWKO5Fxr
	Fjmp5XNJX8tDI7cz2uSHC/88cAur5t32rSDslVeo6UHNvh3dacNjDh3VahmUpqC7DalRlgXWODF
	fLb9Oiv/0JVwLytA8pcJ55ySF5E/L2FPxrehxzAkDNWRXLzpALXcRgicCKS5S31URaN0SJ5vY2Q
	3Zd0NeWfBAMtxq8puDqFDlkqFIsg==
X-Received: by 2002:a05:693c:65cf:b0:375:fb27:2c59 with SMTP id
 5a478bee46e88-376861744d2mr3628461eec.20.1794419369880; Wed, 11 Nov 2026
 09:49:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-smsc75xx-rx-fcs-v2-1-216a5f26842a@gmail.com> <e4a20579-2576-4c2e-9120-b675a175a1da@lunn.ch>
In-Reply-To: <e4a20579-2576-4c2e-9120-b675a175a1da@lunn.ch>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Wed, 11 Nov 2026 14:49:17 -0300
X-Gm-Features: AclHuK9J4PRZYynpn60Trwp0oScnHBsKAesx94T00Mrc6mS2wm4jqy4_tDb4sVM
Message-ID: <CAOCBhwE84F8ZTAVXwxKEpZz06q3KvD12FkeXp6Nn+MXoUYOWfg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: smsc75xx: reject frames without a full
 header and FCS
To: Andrew Lunn <andrew@lunn.ch>
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What is the value of FLAG_RX_ASSEMBLE in flags?

It is not set, smsc75xx_info has

        .flags = FLAG_ETHER | FLAG_SEND_ZLP | FLAG_LINK_INTR,

so usbnet counts rx_errors when smsc75xx_rx_fixup() returns 0.

> Should rx_length_errors also be incremented?

Yes, I will add that to the new check in v3.

Thanks for the review,
Joas

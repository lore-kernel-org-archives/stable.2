Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317763;
	b=Aa8itJkWwIneIu/4gWTJqaI2A35m5Fy1NT/x7P72h2t4Qn3Vds/DT9ItLqbBALXOkOMq
	 J1R3zAeEKHK2NNCKFke7yaC5hFYvaeQIVKbTjx1BIdEQ+vaDj4bXjlx+eVqcueKwaMXUz
	 CmDtwfBsH7kMSIhrnRnppeMlepC9W9+JAw7qFzN1R9pjuzmaHQWxuvdQ3OaFy0mFRJzR9
	 ToHyq0K8S9t5S00u93Sl70Pr7ZINAypESWDghk8iDys1Q7RQA2hPg70eQxVx+HvEeVUDt
	 wAW0qqlIbpmwEqlz+Y8QJ+JalcVANAfAZ9GmGb0Tu3v59N1PZ2GUvjifzK/ev3Z7S4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317763;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=BePlmUzazBil0jZOyafds1nHUSQqBT9o0NsepsGpMCY=;
	b=Xlv0GQwRp6+kNz6RbxBgay6HO5BXbtR50ycW3uovO4Mv4QVWAcQo1t+KQY/iRjb3Fc12
	 0uYBtis4TA/szJPdiSVJdhD+CBIG9z7Qn6qYgqKeM+xHArh0fNxIUQyonjdPpFfxErwRr
	 kJqULz2QTW/JIuZJUpE/+0+HZPSfcr7gJW9xh/Ld4k/g45CMT73FIXqs1N13zBwx+ca63
	 7xO2julqwiwgpAW4nWYy6KXWimgqJMXjqkPMlP6Ce3XfKSZzvY5Pi36wVgrJDGfdvGc/f
	 SVu6vn5BtrUghfu4Pi07WHN/dou+3YYLQX+c+XShTcKUO1e6jJowceE49JRfWMeCthA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B3606A752
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 847B3606A752
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c40f29667e6so297654466b.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317762; x=1794922562;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BePlmUzazBil0jZOyafds1nHUSQqBT9o0NsepsGpMCY=;
        b=ZLvAI1xDNSJtLqN+GlrJXbK0zloV8rfBbApdgt33rN/TMK96J2eKCvXmeng1U8LVOa
         GwGfxcoxvkJ+2rVsi7T+K/LVeE0op5R6vfNxDKekisvSgLuWL6jd5FPXwSpiYu65zJtb
         qbcC57RksDrKLrqxdBdB9MFS23KmghxXFYvh3yyMaNphBUu5JcDbuCiRivY4jbmjJDsI
         cbGS77KLlEXoSZRRbJqvo+gTyzpgT5hbKtP8JJ8mNFU5OBqP4URpbgC83IpPlaONmHVy
         CMP/riwlzqCJN52+cEVfVVefD4F6Ou2QUJgcFwyPu6EGQNV3GjmRC5WlNhMJg23VmfzK
         Kk/Q==
X-Forwarded-Encrypted: i=1; AL+hErGcdx1HGDP0Hn/1qsln0iaoXgggfn2CBdbJRmVIJhPNvsSOVIXDGMd1TCF931W+6PDBuNvt4r0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uKKuGz15oxFSGZW2if6uVLvw34kbKwnu5+fGScoLGMWjm+N8w
	mQenU+h49rbeW756u4mQVYrWjVaXasrUw7/lV6pg8RFhXrnqnXTpofIQ/cCRv7EMLWA=
X-Gm-Gg: AYBFou2OggJGGk9V6iR8MOiNkw7lxZJkdBaJ7LIwd7kS7WR+IB9cJzUG1L1fvQimBMs
	ck7UFc1AbeVNT3PJM6NSJigBbaUtCu15Qzbnm4eHSb73rKxqYxmokc/p6Yh94QnLcobzuD15FrN
	WkYsRpQNMBqVnQRvAsVXkWlSBYVwstztRY8oxES/oDQSDwU518HH2HC4F4GPlFnOrzIM9HXN87n
	Xk4kUImdcwAxL2LpXkiUUAlc7teqVjawSnECLMpZMltfgaeafMTx0Dvq3RDbBb17CfO9oeEYc2S
	ftv8aaUecTztdw7Ya7VXwF315HNUPh5BBkEkqjupPanl+/u1uP8EIvhFwE+6O/bdc+KHpTw3Lxm
	8hMpwCp5FW5zzYJoS9tj/pHGEBVa+kIUYA8fSykHBbgmdORBuY+YCE63l/I6oWqQUdQCYAkx8KU
	7DHNyoe/Mw4JvX7/p4DvzhiuLOsKUTVfMukftbitKjbAuvU7Wz9sjx34fJNsPwgCYCFBTJNQRsa
	Qk8qV+WC2zzHQByXpRkpStEujH52FwsDHoyoVq2C4jo+Xp5cTJHv53EsfuRHqKj7dtmFatGVU+V
	3NOEdf3ZjtTZTY7IyY0oWzObT946w+4w3wBLkghLwjimhbKilyeKzmNSuTUwVQa0miI=
X-Received: by 2002:a17:907:3ea4:b0:c41:61b9:6ef6 with SMTP id a640c23a62f3a-c50495c8f3emr215661166b.27.1794317761828;
        Tue, 10 Nov 2026 05:36:01 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578ed17asm1127354a12.26.2026.11.10.05.35.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:35:59 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b750e40ce2so1456878a12.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:35:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEjZr2OWFNHQemKjJ5p+SmSlEkiaZsTpufat7qFvRbI7cJUULqlyFoULjnpubbUwlOYTu+VfvI=@vger.kernel.org
X-Received: by 2002:aa7:d853:0:b0:6b6:4dcd:968c with SMTP id
 4fb4d7f45d1cf-6b756add2aamr1624928a12.16.1794317758591; Tue, 10 Nov 2026
 05:35:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-gpiolib-hog-stack-corruption-v2-1-c5b28cb8dc8e@oss.qualcomm.com>
In-Reply-To: <20261110-gpiolib-hog-stack-corruption-v2-1-c5b28cb8dc8e@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Nov 2026 14:35:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHw5mbe8LY_t9zWW2VK9TuDDJYTQE_Y5GmjNpLzOB-zA@mail.gmail.com>
X-Gm-Features: AclHuK-0srTXKsnuWni1-CcV0btL_Vd3sgu665FN-7w6sZ24vTtXz1uHDKMnXqg
Message-ID: <CAMuHMdWHw5mbe8LY_t9zWW2VK9TuDDJYTQE_Y5GmjNpLzOB-zA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: fix stack out-of-bounds access in gpiochip_add_hog()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 11:01, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
> In gpiochip_add_hog(), parsing a device tree with an excessively large
> "#gpio-cells" property causes a stack out-of-bounds write when populating
> the GPIO specification.
>
> The value read from #gpio-cells is used to copy the values into right
> places in struct fwnode_reference_args but that struct's args field is
> an array of size NR_FWNODE_REFERENCE_ARGS so a value larger than it will
> make the loop write past the end of that array.
>
> If #gpio-cells is 0, we can trigger a divide-by-zero later when
> calculating the actual number of hogs.
>
> If #gpio-cells is 1, we can also perform an out-of-bounds read of
> the "gpios" array.
>
> Reject #gpio-cells larger than NR_FWNODE_REFERENCE_ARGS, lower than 1
> and make sure #gpio-cells is larger than 1 before checking the
> active-low flag.
>
> Cc: stable@vger.kernel.org
> Fixes: 802c51a83e9a ("gpiolib: fix hogs with multiple lines")
> Closes: https://sashiko.dev/#/bug/linux-fdec1c0e-c6e3-4eb6-8746-d68a3f951374
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v2:
> - Fix a potential divide-by-zero bug too (sashiko)
> - Fix an off-by-one bug for #gpio-cells == 1
> - Link to v1: https://patch.msgid.link/20261105-gpiolib-hog-stack-corruption-v1-1-a47af9c51965@oss.qualcomm.com

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932579;
	b=21ex9djkxpcueZlaPwW9DQlvDS65tpgyihQTVmwAJzo3d5r8ck6dSmZf+V54csZp3NwR
	 8UBtUh6LXMoO+Ai0lCSmNCsJJNRVK41gbaBAZtwxoTIuVlbmg7LUsaVrTZeUUDAV5ooBy
	 eVZvGt1ztp3suqBPi0SuR4TD8EWMOyxIZnwnKzDzZb2X/TnyiGNmX7zrDdYB7KFEU5/gY
	 ab7aohLbXOXH/KqlAHEaNapRCXy8rl2vhAPvpp88X0JKc2N6a04ly5I8j3SurqC8aX7J3
	 s4+zdMuAEXI5Md56qZRqduyJc7RP72LKNnohF8Xazj466o3lIliXuuGwN+ca87YtjiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=grJoK+18+h3lRgJDxuY0z4u1arzCjZYyT36BXVitrDQ=;
	b=0XvJOBF1OAxdlIQr9dVhFLOUn+Ox1uylMDwxNb/lhUbXuDIwhYmi8KZZRounn6VRb6TO
	 KSimZQqJjcAoZAVp12Eu0rktorwCl4+1Nt+MiAybgMTKMg8V6Z9ZDu9WZyowDwHAy5d3c
	 a5XuHkAneBfqOrGjzxXPmFNnJttmN/Rb8IJ5zkHqWVqDWD0vBDc52soTFezulzWQc5Mo0
	 lUiQNPVmgFZoh50mMwR4Jmb/xdCXPtyszon7rj8DhmkMsxQSWbQT4Lll7CbRboee+DXkA
	 /CKQZGjXmvlguFKVfO2JOUkZGg1oHn2dwU9cvKFexyIJyyB+xlmEjM2vcBwcgYZGnmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HrIrtnyc;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9053606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9053606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HrIrtnyc
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c505186727fso338587366b.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794932577; x=1795537377; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grJoK+18+h3lRgJDxuY0z4u1arzCjZYyT36BXVitrDQ=;
        b=HrIrtnycQbJ4pEKl3LHGlVybSSzT9qwQfQjrXbJ3GRkwYtSdrwYH+gpypeIALJR7t1
         pyrlJNPG/1O9c0wzjUvbIpFrtwqxWDGA+B1zQXojtmgzxlm6ZCiWzAN5J6UgTIdLaoAi
         J7G9s2lM39dL6W1RpiWdkd61GuIMrrgr6SzyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932577; x=1795537377;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=grJoK+18+h3lRgJDxuY0z4u1arzCjZYyT36BXVitrDQ=;
        b=quKu10foL0peIJIV0p94XCG5fj+U746ZWRevL23I8A1CFUor/vsQL0VcU8oZFwGoey
         9nT50ukiElFjw3XXFIhosfDFOyLZfM6K/h+4+HFeD3utG50G1pbwTPw+2cMzJn3iZqgO
         bGRXyg98dUmjQujcD72WLU9/fqHV77GFRlzIHQir+4o6hHqqSJiTorneWPU4v12hX4g8
         QnDNLaYqskwx3/O1y4oYewIF1CCArw6S16aBlC8K+oEP7AsZjxw7ZFy/OoQaG6UcPonv
         kq0Me4Aavuv6zcUMvs4MMngiKDUJDN8fS4SNm7O2znE6Bg95rGTmfMWhz7M2TeF/jvIE
         8b/Q==
X-Forwarded-Encrypted: i=1; AL+hErFMbfUqCWK+8pAcq+6lm64WDA1mtPSAV4nBf10R7Gi9r0CZS3aaESAT74d1X9nN7dE74DQZ+X8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dovmP+9Nvexd/fndIuo0OMDiMs9EkzVfiQFoEN24OnX3m0u9H
	+hjP6TClagDC/35BWhXoMnzMDlI2z05nzGnajIOC0F/ZUDX7+PIof37W/EpCKEnLSpeWLlzGoyO
	qqbqizjRuxg==
X-Gm-Gg: AYBFou2WjOQCJ9/Tn4eJLOfpKHM8SHIWJ1avrwP/d6oA5w+zRS40tXZ1xQlSUWUjfZo
	3J2kjhdMN3sE0Dk4hfk+3xEVhp7QjbH7VufoP33qR+XiiMySezVpPaUt/6lM7D+sTzg2H27cy+F
	FVb02RekytioeJv8HikgNUu1EYcvmkS1vjqpIQrsi2HH1gVgC5YtBUEW+PCxPTBKFBwJ4gDS7uN
	DWnJRYr/IIv1n3VD8sVqam21Rk5GL83/GW4MGO1cnJ8xnDTOLjDG8ycN5k5Lqu0fFW/vdEYAFVi
	Qb8n3HXPArRBQC4IG/qnqxR+yLQ5gZq17G4E3bD8J2KWvY3FgiJFIR0cSBs+/M4GKMblMAdyERg
	0zGwU4XameiFYgs6HqBMla/2BQq1mievF5tk7hG/OiQMt1d7P5ZQQq7nnmRlbDJ3musbzJ0BCHv
	J1icO5qZNqm0Vf4POtqqcHaavjj65ok2qZ414zhaiAxi6FAq4an7UbGRxuFqvMxoffyuKPQo2Ts
	dhaJV8m7VfeRHnJDieI6ILohpCvrCeOS+Nn6qfIzqzo2f+/ff5UkEGgne4rYUQ/ujjnK8qAoLpk
	Z1rzMbeRA7otp9L0b4N1BuZL4epNq5jaRMOn9gqCjFenytd73pYjjnM7paK0sSfd+75PkMzkeWh
	Kvi8=
X-Received: by 2002:a17:907:2d0b:b0:c24:4128:c19f with SMTP id a640c23a62f3a-c5096327391mr1273669166b.11.1794932576917;
        Tue, 17 Nov 2026 08:22:56 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab3955sm1450566b.63.2026.11.17.08.22.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:22:54 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c50abd5b4fcso480041566b.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:22:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEqJ0spgUgGZWG9SfANTS16ozok57m8K7lkwaRRhAJuVsh1kfdrWt/9WkZDlo5lWH0HAE0CuGs=@vger.kernel.org
X-Received: by 2002:a17:906:7955:b0:c46:7ec3:fdfe with SMTP id
 a640c23a62f3a-c5096369c4dmr1218639066b.19.1794932573142; Tue, 17 Nov 2026
 08:22:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com>
In-Reply-To: <avxWKI795DthE8Sb@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Nov 2026 08:22:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
X-Gm-Features: AclHuK88r0MdvPyPBWEFngj9XAj85-331AH_Da3bLeV6HCZQzC7nMHyp9Qr3R6o
Message-ID: <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 05:27, Oleg Nesterov <oleg@redhat.com> wrote:
>
> However, EPOLLEXCLUSIVE breaks this logic. ep_ptable_queue_proc() does
> add_wait_queue_exclusive() if EPOLLEXCLUSIVE is set.

Christ, how I hate epoll. It's a pile of stinking shit.

This literally violates THE WHOLE AND ONLY POINT of exclusive waits.

The rule for an exclusive wait is that it *will* act on the wakeup -
either by consuming the data, or - if it can't consume it all - by
waking up the next waiter itself.

So it's not that "EPOLLEXCLUSIVE breaks this logic".

The logic is fine. EPOLLEXCLUSIVE is broken beyond words.

I really think we need to just actively de-emphasize epoll. Starting
with saying "you can't add EPOLLEXCLUSIVE, because you don't honor
it".

               Linus

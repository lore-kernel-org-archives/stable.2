Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017701;
	b=WTuz0HUmyZrNnyGZ/2YGVpQIxwJbZ2FwSeUp6Ii3tR2gLPDGXuAH1yi0JvfuXwoBJlyS
	 LUOgQhP4dnp4qnSj6OuYuecz0rAm7T3f8woQsJiMmGimv8Nj+iYPjpOpkFFCYmIV+2J5n
	 9pCDru/4t8ldg3dqMauKVk8SacDz2XkQGw8k0kGLq0045ROifK0iCNdoSPCBRD87rgu+P
	 6qfbA3oX74F96KlZwBE1bQ5sUOjIDmDGyayMq8Gq5ZiGAcWv0C6fpDh+lMLcgng8eKhYF
	 GplYsgDg3OvLP9u+FF1AD+7MKBd8/USH9kXZ1M7RRg+o0YlW4QgIhG3DGZd5F31BXFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+2RLaCA+CTvvhLn9hoYoWmbd8XvuHHvjif/znAEqg5I=;
	b=bv39hUKCJtlpDH1gQBG0CbfymgZQP4qeliQe4zT19ZwjaClg7rcMaox5n3JN3Z58MJg8
	 v9smtSF0ryXCLKsCM21GNWfguwLU9N9pBtypaGCixD2AzrUC0QA1YSj/xD3DPrrCvxjWU
	 tOW4mYdhtO6a5h/1sMYD27FacVUacnZHm8D09YdYzqV0JkBW3A5dU/TkH76aXt9ZYdi45
	 v8XqsENhXO3hEiJodHnpareH8hOKK2uuIM4O8mG5q3BxaOIL/RZW9iSofOw2CUw8bzNXa
	 h+xm7LTtHP4SsXsLXt+s2iWbCMRsPox+j0Wkgzxm6TKEKzoSfhFEL9oYNCk1vo0mqyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FkUyYAAh;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479B606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D479B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FkUyYAAh
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c51249fa8bdso9142566b.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795017699; x=1795622499; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2RLaCA+CTvvhLn9hoYoWmbd8XvuHHvjif/znAEqg5I=;
        b=FkUyYAAhaw7xBnz3AIlHyO40fGm4JohW3nNn6SQ164hbyqNEjCtyEdZjRcoYshIbGQ
         4vutcmfeu1fM18Iob62km67g4ywxGW/xTL5fiMusIhTiY13m4fxBndoVffqTT4wP07JT
         wtFBIvrluo3EyJ3Is9wBLVNvX4Ycr5t2h7OAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017699; x=1795622499;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+2RLaCA+CTvvhLn9hoYoWmbd8XvuHHvjif/znAEqg5I=;
        b=EI7FKyMK+ZjNbCHts1i3AMOCfmZ6DQSP2/zDUtyl2IBKbHBiISz9TjnJai1bd4ILVU
         KC66NeuhjCKMsOyuyghGxEhesC0Ibll1E9Wr301naxqRgVU9+ksicntLpNlNce/vsjoa
         G5vqKkaJKx3WLq8gqVXLw1DlNdokfqQUzNN5HtiZLrgIH6imbPoPnz9kafhOCxE+xGUD
         fPh8V9prsv5uh/LTcYw6A5no3akjvaCbABL743YwX7Ii3pCRefRKhYd7Co8rntNlkoD/
         HvIMzVLdGPlyMa6DnD4pipcn4ETH4cKp80L3/IsHNGIMssVGc7OMNUQTDGdhdrnYOI9s
         Hf7g==
X-Forwarded-Encrypted: i=1; AL+hErEDbwmvFVYxXtfgbJaMbvcfFy/I+SWffHy7aFfr3MhzPDUb9ewA5OkAfO2+yzEflLLD3+msnmA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8zytNPp5nm/frN9XNT+DTblLk/lxsugUOYf/AWaxPEkOcq29y
	EAXobHcGQEUiA2AANmhNGjM5polmCEpQLV4f8uoIYQbjEFqezTwz/jep97FfrDwhk46zqz3xK4b
	/c9Qnyfo=
X-Gm-Gg: AYBFou3ohKQSA5ylRVrUM4gF11e05ZSY3R+ykB6Ha1h/zfVaDTG61jtFAysHCPEKkf1
	U7fCOTNtLF0DR4g90Kg7uIQ6H86XkGT2XOgk7WfXTsnAm+DJJtmjFuXrH5bDbSAmA+Dyiyf3uQT
	cXVrNmkNFIZDa7HMG1264fvVKkz7BC+S5hyQPN8TA+MmyyVVj/AqJCrD0uVZHWYJbpbGQng3EZr
	Ifi7QMSxIpz9hd5No+FzUg+3ALcbBcY0uH4Gm93RzYoxZIWgpbNiPzRmewQIXNgBBWk6Uu3xmd+
	wiznLu8xam6jY5npglGb/0emXqX0F7zOTQBfkFEx2hTAkSroa8U218nlrkda0KOfKSJCFT08Cbw
	ZDEUx9rTfqpbG+qBhX43ngpciwDUYLI707qt71BhuFrT+lU5XPXOey5Xcb3CaGdj2QN4v0Vyquj
	LYO6mLPY86KzRMpUzhD9Eq+gOYaHrS5bQYSxYdI5wsmFqLf7a4ek6vSdr5wjzNDEwzCVWnMtIg8
	w4gWNp0YghlXvESIQrwae03U8kgVhEYteS9ah8/xNhOqOQVSQnM2I51AmKw8oeap1+iLkR/+ghv
	7lvo0ty7fyS9KgT5L4dzyp/yQtkl06dGP+6gNAEu+T0XqeF65kMy82xpAHRNYSiqb3yK9sEBXZX
	/vYiJ
X-Received: by 2002:a17:907:934e:b0:c50:73bd:ed25 with SMTP id a640c23a62f3a-c510e52bde8mr297799866b.49.1795017698849;
        Wed, 18 Nov 2026 08:01:38 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512346fabesm17376766b.62.2026.11.18.08.01.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 08:01:19 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso846871a12.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:01:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHR95ifhjxQAD+itny8Nj9UT5OuzYJ/D7CzNUhLzM/UjavyL1BlM7zaNRGnzNX+sxDZTPV+zbY=@vger.kernel.org
X-Received: by 2002:a17:907:cd14:b0:c51:24e9:c474 with SMTP id
 a640c23a62f3a-c5124e9ca9emr12311066b.16.1795017678422; Wed, 18 Nov 2026
 08:01:18 -0800 (PST)
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
 <avxWKI795DthE8Sb@redhat.com> <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com> <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com> <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com> <av2juQijIISJAgyf@redhat.com>
In-Reply-To: <av2juQijIISJAgyf@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Nov 2026 08:01:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
X-Gm-Features: AclHuK-jO2btqFqtri5NH0SNA66TSaufpqFn40OH8HLtU3lTATNZK-kccXjyNlw
Message-ID: <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Nov 2026 at 05:10, Oleg Nesterov <oleg@redhat.com> wrote:
>
> What if we add, say, WQ_FLAG_LOCKED and change prepare_to_wait_event()

No, I absolutely detest conditional locking. It *will* cause problems.
Particularly when based on something like this where the locking
depends on not an argument and a call chain, but on a (potentially)
long-lived flag.

> Then we can trivially redefine all users of __wait_event_interruptible_locked()
> on top of ___wait_event/etc.

.. *if* it was passed down as just the argument, I might be open to
it, but honestly, even then it's just nasty. I *much* prefer to have
statically visible locking, and have the pattern of one single helper
that does the core work, and another helper that just does the lock
and then calls the first one.

Some duplication - with explicit naming of the locking status for the
special cases that are called with the lock already held - is much
preferable to dynamically doing the locking (even if the compiler may
be able to then turn it into a static choice at build time, if it's
not obvious from the source code it's still "dynamic")

No locking hacks. Locking - along with memory ordering - is special.
Locking is *not* a flag.

           Linus

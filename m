Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A427478869
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117004; cv=none; b=T5qUGNp+BmmuieKpg+LTa8phbO6X7EYw28p/YdHTyn68Rpnfeo8RQ9us+2UM6YYldlYAvrqsgnKgX5rzcbBa4r/tozTD4SlMbDpksqCfqpWtuQCvs9I6D7ypDh7CWMt+jc17ZX1uichh5WC9ZQEG/jW809eVvYqMgbUIsskXvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117004; c=relaxed/simple;
	bh=4TSlx9Rq39zc+bj4owBqeNtFiuxLW7yShfkrfxfpIFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZnES7Y9giQYf96bo7o0m9Fmdwa4fpc6uuDhCggTVnDvT8vW3/F/sR3SsIuwaZtuv7B48Sa2Lla0SuB1Gn9UuXHeac43hZ+dfsr+iF7TTkw2gsgvcbZBrtb+cUb+dQwIV+4Jip2xy7kWqbSGveVDP5rDepbo9qVQm8LJqA/rj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJxOALYz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJxOALYz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84eb992a881so3155412b3a.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786117003; x=1786721803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=orKmMDii3iur25GInRUkU/0zkQpFIWVbuBQH1MjKlUY=;
        b=EJxOALYz5gJkcofqekC0YjKeItbZEgq2JH4Lx6D4qaiYcFnBBsy9ao23T6e7VIGoEB
         BE8n0ovr0k+x9XrLQ90F+4f7zWi/QbILe0XppuLvIPwLr9uzk4zUBeoD22r0bvzeUE34
         Yqg6AF9c1Hq4ojtGPFEUiC+tPd4xJuBmkL/gekR+m3mnTzaxhRaSp/Uixs/I09/kNOrf
         Zgwda8wxannm4/M3Q2KTITNjs3G8Er1BFm4i+EJTIDYfuYTr4ObpFnI16YBLESYexuq0
         YBLYmmbL5EcFq16i8JR5AWfBzgRqXR5gxkhYnz5k4w604GnwbejFOj4gpLcQALKbQrix
         xC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117003; x=1786721803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=orKmMDii3iur25GInRUkU/0zkQpFIWVbuBQH1MjKlUY=;
        b=kGY5TNJt63hNNswe+60CqpYroBBtrBN1LVDJk7BfC2z2NNXRTXmUtpDF43dyatuoHn
         6nUYPMdfv97oFmrUFdjpW/9d/tJMkpAzHUbH/6INhZ8ZamVp6DSdM4BPIP0NGHGLH4np
         ED2sQMtzV83qNyxY9g4E4YLy0fIqDjNEeRqCHxu1jDJZN/FxADpRQua0dOb7lOPPC4yn
         JUoOnS3S4Sk7+XxhfYWGREep8txTgM0YPDP10lsoEAh1opNj7nxr6yhi21+//cC6PE6v
         ES8xP9GV9f8jdMwB6OjYu+hV4rrSvphZiZ2+RVDV/twccFspZbtw0a4K4x3ubBABMJhQ
         iJsA==
X-Forwarded-Encrypted: i=1; AHgh+RrPUBBmLDT4MM9TcbxAfxHtS/h3ukVc8fSAKa4rKq0mC3Q+Yt3fCS9dTo7oFOVbmt69opVZ/yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfc6UQ/RTTqddkJBN+xlLZjjuqQbx4v6pz/6MqRZIDt+vUs4u
	TdnSnAXZ7emvbt+nbh4y/fTle9mXLymHazahzNWAS901V30zVLbV/fJB
X-Gm-Gg: AR+sD10MACiuY3P03qSAambtDi8NZsIlS0pcm9bn/IJULyktAdXWJ7/kd0aqdcmaQIj
	8GmD4Ljx6PYBOfOqoAJaL8ZjhAjsJQ3ygxfG9zNNiGrPh1J3AWisLA7PIHLB6oOgPP27M2MOfeK
	0w4gQ8A3L7peOiukWzhSu/BXJc4//xWz2Eirk7vFmyJSYf0MQMExOG9pgJAJjMjndUPKd6DCug2
	gdJMddPP9ZeEeADXnfgRpeMiOFZxFWky3tXkME4iw19RJ6JwZlpCa4uvYdBjscy25ecA6a9OApi
	aKPplsUpIUTijbLAnB+tpqCKXwraA48iDGxL4yeeiEsJO9jamUyDqxjWLLZ2FQA/1AL0tl+te+e
	YTcghJEkZUPnY5u8zzPTMBf3q9J81XfcZt9zytFosIkKNROcJr1UfCclASj1VLb9kiEAuNuGuy8
	XQeGZpiI7vvv2p81BjORSPUAVnKjMFZIe2XF7pNo+tiQKHygUusnrf+w1ZfDBxdBR4
X-Received: by 2002:a05:6a20:3ca5:b0:3c3:a31b:3949 with SMTP id adf61e73a8af0-3cbadaf4a67mr12699652637.11.1786117002650;
        Fri, 07 Aug 2026 08:36:42 -0700 (PDT)
Received: from Default ([2409:40f4:100a:3aa1:aa28:a2a6:7085:c9e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb877b4sm10275229eec.19.2026.08.07.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:36:42 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: i@zenithal.me,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH v2] usbip: usbip_host: fix null pointer dereference in
Date: Fri,  7 Aug 2026 21:06:25 +0530
Message-ID: <20260807153625.10405-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080737-drank-trodden-16e4@gregkh>
References: <2026080737-drank-trodden-16e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 07, 2026 at 03:09:56PM +0200, Greg KH wrote:
>On Fri, Aug 07, 2026 at 03:48:22PM +0530, Jeffin Philip wrote:
>> On Fri, Aug 07, 2026 at 08:00:31 +0200, Greg KH wrote:
>> >On Fri, Aug 07, 2026 at 10:07:59AM +0530, Jeffin Philip wrote:
>> >> rebind_store calls do_rebind which dereferences udev without
>> >> checking if it is NULL. If busid is registered using match_busid
>> >> but the device is never bound to the driver or it is never present
>> >> in the first place, it triggers a null pointer dereference when we
>> >> attempt to rebind the device. Fix this by checking explicitly for
>> >> udev first and returning -ENODEV if udev is NULL. Add usb_get_dev
>> >> in addition to the null check to get a reference to udev to prevent
>> >> udev from becoming NULL after the check. Drop the reference after
>> >> using it in do_rebind().
>> >> 
>> >> Reported-by: syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
>> >> Closes: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
>> >> Fixes: 4bfb141bc013 ("usbip: usbip_host: fix to hold parent lock for device_attach() calls")
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
>> >> ---
>> >> Changes in v2:
>> >>  - Addressed concerns raised by the maintainer in v1 discussion
>> >>    - Added usb_get_dev() to get a reference to udev preventing
>> >>      it from becoming null after the null check. Drop the reference
>> >>      after using it in do_rebind()
>> >> ---
>> >>  drivers/usb/usbip/stub_main.c | 9 +++++++++
>> >>  1 file changed, 9 insertions(+)
>> >> 
>> >> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
>> >> index 79110a69d697..c911626427dc 100644
>> >> --- a/drivers/usb/usbip/stub_main.c
>> >> +++ b/drivers/usb/usbip/stub_main.c
>> >> @@ -256,12 +256,21 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
>> >>  	if (!bid)
>> >>  		return -ENODEV;
>> >>  
>> >> +	if (!bid->udev) {
>> >> +		put_busid_priv(bid);
>> >> +		return -ENODEV;
>> >> +	}
>> >> +
>> >> +	/* get a reference to udev to prevent it from becoming NULL */
>> >> +	usb_get_dev(bid->udev);
>> >
>> >So what happens if udev becomes NULL after checking it and before
>> >grabbing the reference?
>> 
>> I looked through the driver and could not find where udev becomes NULL after
>> checking and before getting the reference since we do both of those under
>> busid lock. There is a small window between releasing the lock and
>> do_rebind, is that what what you are referring to? If so or otherwise, 
>> could you please advise me on how to move forward in correcting this patch?
>
>If you do not hold a lock when testing and doing something based on a
>field, it will race and is broken.
>
>Again, step back and try to determine what you are trying to fix here,
>and how that can be done in a race-free way.  If you don't know, that's
>fine too, I sure don't!  :)

We could add a new flag(in bus_id_priv->status) that would prevent probe from
scanning or any other function from nullifying udev and that would prevent race
conditions. But I think that would be an unnecessarily large change just for a
small issue like null udev. We could also use a local variable to store the udev
so it does not become null after dropping locks. Apart from these, I don't have 
other ideas.

>But we can't take a change that doesn't actually fix the issue, you
>wouldn't want that, right?

Yes, I don't want to send bad patches either. 

>Why are you looking at this issue anyway?  Did someone assign it to you?

I am relatively new to usb subsystem and have been wanting to learn it for
quite some time. So I got on syzbot where I found this issue, I wanted to
learn the subsystem in practice, that's all. Nobody assigned me this.

Thanks,
Jeffin.

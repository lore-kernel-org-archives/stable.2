Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42CC3B47E0
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909356; cv=none; b=fSRpU5wdu0x3H73phOJqq9upH2u8XIEN8MJXd4+NZnktyFnwFFjCnwDde88ekqXvK979ZvpVh3J5bycjXjHqz8mK/BotY4B89XtYkMbJG5+YxUL83JyZda6OkkHiC4n7cm8Na9KXlStedDtHieBCVi9t0/HLGeJxhyuY1I2ePJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909356; c=relaxed/simple;
	bh=CJEOArTPXr9IotSUugi8Bp0zmzyD0BwH5RCY+dd1pVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFekk9X7hqaBa1Uy0DNFYqTdH8TiCwwV/QxHhiRr5foD7IxNCyfQwINscpD7H5xT/BYLQjhR63hoLSMjdTNCYCKoXhXhqe7Hxsq5MFbfRhT6N5/DSoj5AoKKESkrh2/xbJdJ1TXJqvzVptEg11ggfZ4YR11J3wF60u39utmvFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Eoz4oPN8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Eoz4oPN8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so6959855e9.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1784909353; x=1785514153; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZtmyGupOuxHpf7w+P2LHQSdMJrugU3vHyUY919jK2Jc=;
        b=Eoz4oPN8MhOz78YJPvdyq8ohO2wlZbJAL/HhNxVSMAEV2Ach60m9OVI7d7prqhr32t
         SYeBb7xF2l6kOZZD6drM10D6eVzI2zONh+gvL2lzbSxaMxKVP3WQOytC7I6xoJvAKaa/
         v4rp3JNl3BPQ1HwrH3LJeLCNQf1hFY6EPlSwBmLUaOzgyzsQzKoHe7tlfPCWUk99jO5J
         /arjQ7pCh42VrdWzRfgqdYMKSr3hrMVbaYhHnr1kfJm/cmm/shosyjE3gKx3Iqtbay0j
         H+WtfoswcA4JyC/b3z+FWhaIVazQZfdcNkvwNVIqXzhU0Ydkj/4pWq1OT/O83Ws7WdSl
         NEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909353; x=1785514153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZtmyGupOuxHpf7w+P2LHQSdMJrugU3vHyUY919jK2Jc=;
        b=sEBYo7VULrRBTzOi0OVoAGPeCVgaiG+v8xIx2uCvZzRFzeliRVyXfGZZ3Jz38wQ4hn
         2rZI/g8pfpyWpFQ/xTkL/bD+Rb58RZbvras3dkz2SOgWoqei2d1jRprH9lf9+9dmflzw
         kO63uQjlWGI9ZV2K7E8a2zkvlYw8EHchtVtfwqZjEUgaPi3s66eRTQGCTrEWe188S+lt
         W+eVeny0Yu+l4nINLYc0LMkWpa3UsG30Og5qAKHRkBhzAPAO3eDfyiy/mYo/GaFv2zr/
         3yuLVu4iPb/fI5ftYGnyozDNkSE3XYgl+9Cigl3HI7nM5v0cyFe/XldGtmV9tjNRIkk8
         HYCw==
X-Forwarded-Encrypted: i=1; AHgh+RpTp8bEcZRxyPwnuMMCY11O2mljn2okdleK2xLh0JnkBClv7oLBBYtpVsJsN3KSUxKDrAeTXz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FmHYBBss+WEpEqjA7BRlqwjuanqdrSwIpo7ld0zARVa2n2so
	ktRvDnS5uupmacsixaD/ygyW0nSYRgOtuAY2FlrUC8R0C2fI9/V+i7A8SGvIYRsOkgg=
X-Gm-Gg: AR+sD11Rhs4oGg0iy40AJuYU3X8ZY32C9hFJaWTZlIL/xvJGEaRIAL6IcISm/bpEbZL
	GSMNYjHyaA+QQFEhpPqpPXOTWLDi8QIcMyjgDqeikbV7PJqYRvyTF/yzk9O4h/CnTDZu4W+ClXf
	Mdwc6a9fahgzyYTcZJ3ki5GAlJ8TCtOeitQ0cxAT1DfKUOB0FkD+KSrQd3eB7v/wYoAGrk8oHOd
	9AL2q9pPSyVqH23vhrAnYWrQnEU1h4fghAHJKs5++si6H3mWGDNmOo7V4V4nvuZ4y+KTL8+ZjN2
	i5zyYWjv8lxh3QQGD56rPq32Y0d3iADxdGfbq1xttbXqSgRdDOyuaTILsOt87Y+CyoITQFALgSq
	QikLFet6Aos7m5laA8mXFlUL75wF7ORS5pj0I6XhTh1NS62kql77nlv4LEnCjrGpRgDDryEnEGN
	r3O12sve6ZVq98ud6/gxvjpxH5vzyaXFPm2AuYHqto1FaeMA==
X-Received: by 2002:a05:600c:c05a:b0:495:63f5:7a4f with SMTP id 5b1f17b1804b1-49573d03068mr100199985e9.33.1784909352938;
        Fri, 24 Jul 2026 09:09:12 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm25103899f8f.23.2026.07.24.09.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:09:12 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:09:11 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, 
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drbd: Fix double put_ldev in receive_SyncParam on
 fifo_alloc failure
Message-ID: <amONUAJL4EZZTFKF@linbit.com>
Mail-Followup-To: Wentao Liang <vulab@iscas.ac.cn>, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, 
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
References: <20260625150417.69968-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625150417.69968-1-vulab@iscas.ac.cn>

On Thu, Jun 25, 2026 at 11:04:17PM +0800, Wentao Liang wrote:
>In receive_SyncParam(), when the fifo_alloc() call for the resync
>plan buffer fails, the error path executes put_ldev(device) at line
>3790 and then jumps to the disconnect label. The disconnect label
>also calls put_ldev(device) when new_disk_conf is non-NULL, which
>is always the case by this point (get_ldev succeeded and
>new_disk_conf was allocated).
>
>This results in a double put_ldev, causing the ldev reference count
>to underflow. All other goto disconnect sites in the same function
>correctly rely solely on the disconnect label to perform the single
>put_ldev — the fifo_alloc failure path was the only one to
>prematurely release the reference.
>
>Remove the spurious put_ldev(device) call before goto disconnect
>to fix the double put.
>
>Cc: stable@vger.kernel.org
>Fixes: b30ab7913b0a ("drbd: Rename "mdev" to "device"")
>Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>---
> drivers/block/drbd/drbd_receiver.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
>index 58b95bf4bdca..f618d03fd2a6 100644
>--- a/drivers/block/drbd/drbd_receiver.c
>+++ b/drivers/block/drbd/drbd_receiver.c
>@@ -3787,7 +3787,6 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
> 				new_plan = fifo_alloc(fifo_size);
> 				if (!new_plan) {
> 					drbd_err(device, "kmalloc of fifo_buffer failed");
>-					put_ldev(device);
> 					goto disconnect;
> 				}
> 			}
>-- 
>2.39.5 (Apple Git-154)

Thanks for the patch, the fix itself looks correct to me.

The Fixes tag points at the wrong commit though. b30ab7913b0a is a
purely mechanical rename and only carried the existing code forward.

The double put was actually introduced by 813472ced7fa ("drbd: RCU for
rs_plan_s"), which added the put_ldev() to the disconnect label.

So the tag should be:

Fixes: 813472ced7fa ("drbd: RCU for rs_plan_s")

With that fixed up:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

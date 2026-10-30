Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396074;
	b=A+z/aeQLyiljSVfaIyhnD9OlXZTHbF7BqyRyrjlNwunjEqP5cd8D3qKixqZh0i//cr7S
	 AauKlKLY+spc+2gG5GJnOcPdpukyrpz5t9E4VZH0F8BQJZvv2njppEDPUg5yPso22V5sj
	 fARHvMc+7RcycBv/46WQNZQEdROCc35jyg/MqF0wW9Z/pHbOnvUTIaakrCIuqfZauMv3Y
	 QcCJz7/klkiFUDOx/T1Fz+YdfjB66bh64FNKBRVfrNYaae6p6ReQjzffIRG0S1ogJyiyl
	 7c2rJLlhBEEYBF8KqJyXNC6DliM6w9fzcTlBN1zz9m0/N9vVPzMMOd5PweWyZRaFEWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pfyuaHVWliYihnuN7VxgyTXmn4J3zXZExhdUzMnnin4=;
	b=MRbf+VW6V7HzUExsnIWgRxcJvls5+Re1aU760MA9Z36RyTjGwUd53ahFGzhMwhbXT2Ya
	 StPU9dTVHH2NpcbPPeL4q/yJySk+yJFgY4UpyEhxYg1pPqb767Mqv/JcwVqG9uCQxC6/D
	 yYg8Q1itxOQ7AxviITye/teIc+DP/OEcoMpFGOUw/0KjrfbBlu2mntEu1Pqx19ZxLdJcC
	 lb6pAmDX4p3Q8iQEjKp+u4KmgAf9gBQ7snhm5Ans/arDjkoihETcFnXWedJAp0m9UiIuo
	 2r5mjHsxFILq40xvu5FWs7f3quifWT5Hm02ZjOWMgbeCq/u1eXS3tu0xl4Rwq1dJV8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Us1b9MPK;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF34606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BF34606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Us1b9MPK
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1257051a12.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793396073; x=1794000873; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfyuaHVWliYihnuN7VxgyTXmn4J3zXZExhdUzMnnin4=;
        b=Us1b9MPK2UkdFkcu8FM3bwwt0idTT53OhPJL2rsEaQj/4F/vgFNF26WjmBSFnyq4v4
         MpfN1SoSaQygsuMoDR5WtCIWphUmN86VvhGEQCkY+DFQiKoildphuWY85vKqM0Dh4yqG
         1DUTmVa2NxREgzm0rXCanf/YexfUlUokBAEyyzLnUmW1NWbgpdFhuRsSkOp98zAu9XT9
         KXj3Vy0l1Msk7esBJDjWmYWdx239d7IZYG7ds/Pt4hcfhwy91zZCvpryWM1X6kynDvjF
         jAiJ8j5AJTf17Sa7OntEuJ2E0VXmTzYTru6vIGA8l9h1q755yD+m7vbUtewBmXNo20LM
         Ay/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396073; x=1794000873;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfyuaHVWliYihnuN7VxgyTXmn4J3zXZExhdUzMnnin4=;
        b=GtwrmihF5fmTIO4FIpfYsa5DQKCAIcaaCHGoTYA+M6bMezpl17SrC6tgFo82m0tgVH
         nIUiVULSa4w7dmlicEwO0bvIDLCHWwVg8c/nYT8EjpvJqTgrHzIqOenwNzdkWg+/fF+D
         kNkixhw6ZSWsckOtS1lV56+/Fe5hnF3Vei/xx3qCBJXGaxUTuvuJt2KmzKtex1EGZo+N
         rVOWM/LUSAGJUSXcYEzUCHI0maZwhDCZ9zKwm+uO9XB/g3+RToAq748lFg2xhmuupo+a
         Ipr2ZMimB0VLnMTlZmXn9XK+Hu3hRupUAgLlfd69kW2ILluiz2izirXvTgWYpzcbBjk+
         f71g==
X-Forwarded-Encrypted: i=1; AKwUvBxCIm8W+rq95EpdEJB129rW0FlEBEijR/ADiFVS9zgzP6VqX7qMyx2YFvyPqCNtXrIyo8HZk2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM48X/DMQ7yqiBMpaK8dDhbNxPFFEXcf9VM7UofV9onoErsEoN
	MNVPY1oLhO8iGB2mnyMicHjy3ajb8Uo7sUg6vDRdjC9yQFoSe2N3sHohq028HIi449HaugVImbv
	LFBfjzRKRfQ==
X-Received: from pfbfo7.prod.google.com ([2002:a05:6a00:6007:b0:89e:861c:6b1f])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2583:b0:3e2:86b6:9be1
 with SMTP id adf61e73a8af0-3e928ac6de9mr3264932637.70.1793396073279; Fri, 30
 Oct 2026 14:34:33 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:34:28 +0000
In-Reply-To: <20261020051446.92179-1-yuz08559@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020051446.92179-1-yuz08559@gmail.com>
X-Mailer: b4 0.17-dev
Message-ID: <179339606875.2659781.13239690891562364438.b4-review@b4>
Subject: Re: [PATCH] usb: gadget: f_hid: avoid copy_from_user() under get_report_spinlock
From: Neill Kapron <nkapron@google.com>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

> f_hidg_get_report() copies the userspace report into a freshly allocated
> 'entry' before taking get_report_spinlock.  When the report id is already
> present in the list it then copies the same userspace buffer a second
> time into the existing entry, this time while holding get_report_spinlock
> (acquired with spin_lock_irqsave()):
> 
> 	spin_lock_irqsave(&hidg->get_report_spinlock, flags);
> 	ptr = f_hidg_search_for_report(hidg, report_id);
> 	if (ptr) {
> 		if (copy_from_user(&ptr->report_data, buffer,
> 				sizeof(struct usb_hidg_report))) {
> 
> copy_from_user() may fault and sleep, which is not allowed while holding
> a spinlock with interrupts disabled:
> 
> 	BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
> 	in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3481, name: hidg_getreport
> 	 __might_fault+0x4d/0x60
> 	 f_hidg_get_report+0x155/0x310
> 	 f_hidg_ioctl+0xbd/0xe0
> 	 __x64_sys_ioctl+0x120/0x170
> 	 do_syscall_64+0xf9/0x540
> 
> This is reached by issuing GADGET_HID_WRITE_GET_REPORT twice for the same
> report id (the first call inserts the entry, the second takes the update
> path).  On a non-debug kernel a userspace buffer crafted to fault (e.g.
> via userfaultfd) would sleep with the spinlock held and interrupts
> disabled.
> 
> The data has already been copied into 'entry' before the lock is taken,
> so reuse it instead of copying from userspace again under the lock.  This
> also drops a redundant second read of the user buffer.
> 
> Fixes: a139c98f760e ("USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 3c6b43d06a6d..520892bbfbef 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -668,13 +668,7 @@ static int f_hidg_get_report(struct file *file, struct usb_hidg_report __user *b
>  
>  	if (ptr) {
>  		/* Report already exists in list - update it */
> -		if (copy_from_user(&ptr->report_data, buffer,
> -				sizeof(struct usb_hidg_report))) {
> -			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
> -			ERROR(cdev, "copy_from_user error\n");
> -			kfree(entry);
> -			return -EINVAL;
> -		}
> +		ptr->report_data = entry->report_data;
>  		kfree(entry);
>  	} else {
>  		/* Report does not exist in list - add it */
LGTM, thanks!

Reviewed-by: Neill Kapron <nkapron@google.com>

-- 
Neill Kapron <nkapron@google.com>

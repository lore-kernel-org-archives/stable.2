Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA84DDB38
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070477; cv=none; b=Gbbn/Q/ThxlDigrraXVAw04un5oD6zRywBJm3Fpx8MPLgZ6p+oUq4dbl27P2lKcbgeINAKgkYZpubQhADQb5ylRc0a0hi6rtDKpMVcDmO3pLxg/BXKY0MEqKtt5p/r9ksPR3d1oYa3os//8ef1RgosQL/c3V7iAhIYJK/H0S6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070477; c=relaxed/simple;
	bh=vKmZX7j2+UMDbTs0prpQw63eYE6eWd25yIxQG7e+2sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5xmoTYL4/Swyt5wnR0FSDKfvLNTn3XohuEuHgICBn5SgWlre7I3Lzmq0ZVXf02+loGQHxWzHDvlrXcrmKUA/I9K4RKZt5qzXYgJKNRv6GeSbC0IxT1hD48NvdC2rOd+qnAlC5XZxTyEH6zPOjBVQeZassOKEEmn3r+0J90xv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yel9d1Yi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yel9d1Yi"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c294ad260fdso116394566b.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790070472; x=1790675272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFnXezMJTHEfGOyaUx+BGn6Bkr0k5HX/YPJ63ltM7lY=;
        b=Yel9d1YiUWKckQm9siMITV06DzQmcD/aNeLvSHdUjPGvXWzq+kyZTunnQpLKnaGrsT
         qVSzU0HV6IpPXWHTimLAwW5zOLVQhbOUsGrZ+OhgnKvFwh1M2OmdCMmUXTOZbyLy1jO8
         awmbrkjFw5OW+TUapkgRxvaZ0lFclGxbiVTXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070472; x=1790675272;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFnXezMJTHEfGOyaUx+BGn6Bkr0k5HX/YPJ63ltM7lY=;
        b=F0X2y7VVNbycBYDQ4TNIsXVl1bOLQgd+o+wEzDumcN2G5HmD+VASh3Cf6jVqKJajTm
         i70DCA5+FB6wVVA+ODlRZH6A82tsKaFVHt9CZ/eSxcO0IeZ+YSWdkKvc9lLL8zRKffsS
         B2TprM4nX9nzZ+pa5diDWspR6Ofes87H66h0CSNebMwYr8CvxB4ubSKbANi+4uq4CiXd
         dn5UrL7v6lDgEs6ILL8ImC9TAhpxn5E72cadm2liF9tqpB2WO+5dF052T8GXEKUfMigB
         ZWsjfSoqTakMUrIC0h7jFxzXH+ksDa94ZQ4XWCPgy6KqXU51VNSR5F1Lw6bT4DkJ7uoS
         geog==
X-Forwarded-Encrypted: i=1; AKwUvBw9/xEKwzB+QxPvsWeACbJkEIFMUD35XmprcJ+eaL8zX5/e+CqgGfEYO5Y8PE6rC76a+JIQjw4=@vger.kernel.org
X-Gm-Message-State: AFuF++lBA+zO1BltxTbga6hxfT/KANatoC74GVf5liR3HrqxQJ1393eS
	yhmvsGef27OpJofc3fy8O2jK8iahdZtwxDaViYj420SGn2EkNGapkGq/dZ96RQakxag=
X-Gm-Gg: AYBFou2U5Lg7tB1NH5EqXnjRqqmk32+l8M501FXeAoJHjSfq0fr3maWZNxvEShgfDvx
	JI3OTBW3o9YuqpDlSIZgBOgljD85Tnmd/iQcWmwJZpEREC2WGPXtS8YSk3mcjqr01LHn3RzCT7z
	yfCBcXmIAcNPXo/ACqgEiZUd5rjPK//thvmf66uh6GvOf02kBvI3PDGIONkvWAkh3fqWF9JSzMU
	jxbs2cGiEp+xl0Psl0/sz9zYxALHtk756cmVxyYplzKCHI8WYyQ5JkRWAw4AHzU5+nhCLP5RFQW
	HnPLE2Bbs/+QrAZyak497pCuMvgjiwj/TWap1dwlqNo8b0NC2x5UXTv+7ENTFrZMse5GCRbx1TI
	47LlEAAD1bh7O+YfEtQMSOlflMaaVmbQgP0jPAlMCmF2PZGvFtlO11jAoA4MKsXLdwaAcvsNatr
	tCj8MZ6VR7S7ZTEEbaiCROs6rwsybhPLu34NgaYX5myC2yLpeSmPDWuwHMCJFLkbxERuv/K8JJ5
	I1A78bNympI
X-Received: by 2002:a17:907:3fa0:b0:c25:f7dc:2d8 with SMTP id a640c23a62f3a-c2a8d762753mr200948966b.25.1790070472034;
        Tue, 22 Sep 2026 02:47:52 -0700 (PDT)
Received: from [10.214.128.75] ([38.97.137.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c5ec614sm55899666b.45.2026.09.22.02.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:47:51 -0700 (PDT)
Message-ID: <e66371e0-5e8b-4e31-b8ad-223ef399b056@linuxfoundation.org>
Date: Tue, 22 Sep 2026 03:47:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbip: vudc: Prevent transfer timer rearm during teardown
To: Myeonghun Pak <mhun512@gmail.com>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ijae Kim <ae878000@gmail.com>,
 Michael Bommarito <michael.bommarito@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260921224130.492681-1-mhun512@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260921224130.492681-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 16:41, Myeonghun Pak wrote:
> Commit d96209626a29 ("usbip: vudc: Fix use after free bug in
> vudc_remove due to race condition") made v_stop_timer() delete the
> transfer timer synchronously before vudc_remove() frees its containing
> struct vudc.
> 
> That does not close the race with the receive thread, which is stopped
> later through usb_del_gadget_udc() and vudc_shutdown().  The thread
> calls v_kick_timer() for CMD_SUBMIT and CMD_UNLINK packets, and
> v_kick_timer() deliberately calls mod_timer() when the transfer state is
> VUDC_TR_STOPPED.  A packet received after v_stop_timer() returns can
> therefore enqueue the timer again before the vudc is freed.
> 
> timer_delete_sync() only drains the current timer instance and cannot
> prevent such a rearm.  Use timer_shutdown_sync(), which makes subsequent
> attempts to arm the timer no-ops.  The transfer state no longer needs to
> be updated, as it is freed along with the timer.
> 
> On a KASAN and DEBUG_OBJECTS enabled x86_64 QEMU guest, repeatedly
> binding the device, submitting a request and unbinding it produced a
> "free active timer_list" warning followed by a slab-use-after-free in
> v_timer().  With this change the same harness completed 4000 iterations
> cleanly.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.

Were you able to reproduce this problem to test and verify that this patch
fixes it?

> 
> Fixes: d96209626a29 ("usbip: vudc: Fix use after free bug in vudc_remove due to race condition")
> Link: https://lore.kernel.org/all/20230316180940.1601515-1-zyytlz.wz@163.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/usb/usbip/vudc_transfer.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc_transfer.c
> index d4ce85c4c6a2..4146b746a320 100644
> --- a/drivers/usb/usbip/vudc_transfer.c
> +++ b/drivers/usb/usbip/vudc_transfer.c
> @@ -441,7 +441,7 @@ static void v_timer(struct timer_list *t)
>   	spin_unlock_irqrestore(&udc->lock, flags);
>   }
>   
> -/* All timer functions are run with udc->lock held */
> +/* v_start_timer() and v_kick_timer() are called with udc->lock held. */
>   
>   void v_init_timer(struct vudc *udc)
>   {
> @@ -490,8 +490,6 @@ void v_stop_timer(struct vudc *udc)
>   {
>   	struct transfer_timer *t = &udc->tr_timer;
>   
> -	/* Delete the timer synchronously before teardown frees udc. */
>   	dev_dbg(&udc->pdev->dev, "timer stop");
> -	timer_delete_sync(&t->timer);
> -	t->state = VUDC_TR_STOPPED;
> +	timer_shutdown_sync(&t->timer);
>   }
> 
> base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5

thanks,
-- Shuah


Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346D331ED1
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910800; cv=none; b=oAn4pxGdQ3p4Nys62ghWM3pR6cSfWNAlH6bx0k8JMhrMsvOyyExrot7C8MzKpyFIzTCupObE8IrpHDScUujpRk5IX0oxkG3RWaXZsVvNstmLMQBLefS/7ezywNBVuL1B6+RJpS9mgrIr+hYV1qjqpTxOGruTe9HaX6+DnN+cEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910800; c=relaxed/simple;
	bh=b0wibVvqA6LqIzvcm1tgZk01l9v2eVHtKm6xtaR5h8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ8bpZkw6c+e9+NSAjJUwBWo989b6F/9ICE8ZelRE89SwgDXvGWtZ9WeUbBe2irMEKYLvzdKbx9Sz2iOte0GnxscZ3m+WZ10wjDkREDQsHq4D9VaSbCTRKolAo46gpYAKQTz0Pm6l2XuvDTlUDGKJjtKglZDlhnYNEh+3MOLGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=ZXSCdPWQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="ZXSCdPWQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so6039155e9.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1784910796; x=1785515596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=73zYw9m2TECKXo+uu9AFah83IICDtXG569B44CjRriI=;
        b=ZXSCdPWQqze3Gt1FjL19HR+pts/iOLfMBPNoFoCs0wwdSBcpro5UJiRaPLKhXn/ggj
         5xIfHoFPlaVVt/KEtzTR3ZpMm3HRnNYWVHCm7u8GYMy6Z+cg4sImTXi2rrOZ0EGdqa77
         JxJxEQ4mKA1p3oqPPeNWLEQhzjrxq8KnX8JC7x4ZKsc0JH/wQo6NmnETgBrHQjyFFoyP
         hV8MfxGsRsOssPmePbKYj+Icg8UemBG9Hv205sf2ktMlj1SE64MMtZxcTZuwuJi1/qyk
         UC+5hy0+3KuhfWGMQ+spyePBtm0VSUut5QUri8tMoTGzBnhiJ65W3D9kKt+0gqlh5euJ
         xpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784910796; x=1785515596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=73zYw9m2TECKXo+uu9AFah83IICDtXG569B44CjRriI=;
        b=C8XwnOxgSaYP+b86gyJ5/BSevoW2Fh7VMiJ37BHBHmc8yyzOqDf4ePE1dWxhM/PsmW
         02ayNjxPAf4CDBxxZT7ryvWYOibjPCeRSpQExO1SkanodTlpTfxp7rpd0BkZP8hXaRiN
         fwQumQJF1So1PTDX6My1RtcXEKCVPlHpJYxwbOmLuoIxVf9rnlYsM/mG7QzKuONG0amh
         bNCa62DiHChTHnLHr7eXDykvkdCw7g9nKhj+ScSGfTOZLT1OVD+BDY4JbO/dgDwyB/vd
         lh1OSWBdA/htF/kg4ZoI/az4R5U8exh7HiFYWT5uyCr3xeNFCr2fqIj0bSHMftYzta2H
         xKOw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6EDBQCzEUoogoHedGd01+INY87qG5a5uzEMytg/pR6D8r8SX/Iog709w9cq/izHyiMKN4/dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuGLVDRL5uG3279lpz9Q+eeAshxjFyrW7FEUUj5BdNCsSdN4WY
	/wjcogexaTQeZCtsKI9cdnz6eqS2/3Oh4lbX+jO4cWgbEJyAGHCM1dHKSmAHReHP8AI=
X-Gm-Gg: AR+sD1034D72IMF1Hf7nUXHJJ2hyjNcq3tmkzgxhjUhe3p9YH80LaeD8+pOAhg+0tqS
	yX4rmmFUXHavMJOqHjArg3HxJQahSAViNoMEEpIeOQBIjAngb9LmIxkMllSuIQ+Y3cSreaV8WNU
	6fy8Xezcwg1hyQbgIZbuHEWMp8MfTavagc3Sd4fBLBRcm6F7KxcuWQRkeiVtSecR9Cr65gwtHLV
	eebhKkTY5u3wo9VwT3dAhK6uJeoLDcR6ot1ePCJ5vjKLkESLhRv/JQYUSbeQ8W2uQTlO0aSCsRu
	GSriIVXb47dkPnpsak0ZCyxWFu/+RyBVvGn3ohtc7f/NlBv5plJtnzgjc1b9t7tTyhCKQLtu0NV
	kVZywCeY08YxwubdP0lj2iUKgqvunkYu1WXqqg5wTrwvn06pk0G5gGAXZcDAbFZPhd21Nisp7aA
	va7trNtkb3Qb4IDj30Z4PuTLx6lRPWTsnzgOCDEfLzNEVtmA==
X-Received: by 2002:a05:600c:529b:b0:493:e404:3727 with SMTP id 5b1f17b1804b1-49573cf6d94mr95354345e9.23.1784910796360;
        Fri, 24 Jul 2026 09:33:16 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b48632e7sm2798035e9.7.2026.07.24.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:33:14 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:33:13 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, 
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drbd: Fix local_cnt refcount leak on ascw allocation
 failure in _drbd_set_state
Message-ID: <amOR6AGwUp6Blsdl@linbit.com>
Mail-Followup-To: Wentao Liang <vulab@iscas.ac.cn>, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, 
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
References: <20260625151636.72599-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260625151636.72599-1-vulab@iscas.ac.cn>

On Thu, Jun 25, 2026 at 11:16:36PM +0800, Wentao Liang wrote:
>In _drbd_set_state(), when transitioning a device to D_FAILED or
>D_DISKLESS, an extra reference on local_cnt is taken via
>atomic_inc(&device->local_cnt) to prevent premature destruction of
>the local disk. This reference is normally released by put_ldev()
>in after_state_ch(), which is called asynchronously through the
>after_state_chg_work (ascw) work item.
>
>If the GFP_ATOMIC allocation of the ascw work item fails, the work
>is never queued, after_state_ch() never runs, and the extra
>local_cnt reference is permanently leaked. Additionally, the
>state_change object allocated by remember_old_state() is also
>leaked, along with the krefs it acquired on the resource,
>connections, and devices.
>
>Fix both leaks in the ascw allocation failure path:
> - Call put_ldev() to release the extra local_cnt reference when
>   the transition matches the same conditions used for the
>   atomic_inc.
> - Call forget_state_change() to free the state_change object and
>   release the krefs it holds.
>
>Cc: stable@vger.kernel.org
>Fixes: d01801710265 ("drbd: Remove the terrible DEV hack")
>Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>---
> drivers/block/drbd/drbd_state.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
>index adcba7f1d8ea..68e273c6d5be 100644
>--- a/drivers/block/drbd/drbd_state.c
>+++ b/drivers/block/drbd/drbd_state.c
>@@ -1480,7 +1480,13 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
> 		drbd_queue_work(&connection->sender_work,
> 				&ascw->w);
> 	} else {
>-		drbd_err(device, "Could not kmalloc an ascw\n");
>+		if ((os.disk != D_FAILED && ns.disk == D_FAILED) ||
>+		    (os.disk != D_DISKLESS && ns.disk == D_DISKLESS))
>+			put_ldev(device);

Thanks for the patch. The logic itself looks correct to me.

>+
>+		forget_state_change(state_change);
>+		drbd_err(device, "Could not kmalloc an ascw, state change %p -> %p leaked\n",
>+			 &os, &ns);

However, this error message is nonsensical. If anything, we should print 
some halfway human-readable identifier for the state values here, not 
the pointer.

Also, the state change is precisely *not* leaked at the point this
message triggers, since we free it here. What actually gets lost is the 
effects of the state change, so if anything we should point that out 
here. But I think just keeping the original message is fine.

> 	}
>
> 	return rv;
>-- 
>2.39.5 (Apple Git-154)

Also, the Fixes tag points to the wrong commit, that was just a 
mechanical change. The actual breakage was introduced in commit
82f59cc63538 ("drbd: fix potential deadlock on detach").

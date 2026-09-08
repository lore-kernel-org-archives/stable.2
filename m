Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42B5328DF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868993; cv=none; b=p7JW2sIUSW2U/87vC/+A4pwBlQ/T3+FHwQ1UDoddYXqxRiT2Zl1Rnj9z0A6uFaBKEE+cOt0PckGGPGG9yhz2iBLnWOFrNDSuWctDcyo2Hqzu8k+HUM7lgEbCCnHPv1Z2cEEHW+DECBKDQkumqyu6K4R95X7Q/kkqTRLo7qkNBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868993; c=relaxed/simple;
	bh=1sd+0mDaPiDEg6aYpJLTjM3Gkd5+jpv0L8nVKSfw9gA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nst0GcCBAAhDEXfzM5Pi6/h/F93LjOAfkV+x54QvNLfDcxb3EqHjnvyHhOfGRNBRPCdejYE2VS9UJ/5HmtST/Tye2mttxF4kx+knhIB4mk2fMC1kEgsGZTLXAlnvVb+gtf84SvI5O612PyuQcAvBkbq93DO+nI9nRXTW5CqaCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FA8tqAUW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwVEZWM9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FA8tqAUW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwVEZWM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788868986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lje7LxotFN8OQu8fgaVYYDvIYFBd+T6ZwNc+aWkYRdg=;
	b=FA8tqAUW8nn/lkVv9xJvt91QWURgGmGLZFx8sfBtbgWJrMCGmJ0/o8VlfROri23K2msMQD
	UKvvxELmjcaMPi7rY0KCcKZsS+amCFJ7g+Xb+e4QdGyXmtEUB1cZ0cKlfZte3fDLTPvpiS
	jYDGdHocQC6FT0UKX0LQxUg4EGJe1Mo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-RSMQgsJHPn6DNf9aQdMwoQ-1; Tue, 08 Sep 2026 08:03:05 -0400
X-MC-Unique: RSMQgsJHPn6DNf9aQdMwoQ-1
X-Mimecast-MFC-AGG-ID: RSMQgsJHPn6DNf9aQdMwoQ_1788868984
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4957287363bso36580475e9.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788868984; x=1789473784; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lje7LxotFN8OQu8fgaVYYDvIYFBd+T6ZwNc+aWkYRdg=;
        b=UwVEZWM9FbjcLRGmFhBo1XtlatPFGfp+L6jptaNukmCn9AHxl6mAH9YIgxvN5g+fDF
         zWl0khCCGqf3ymbCGjv1q/UjK4nlv0dE256Ph5dC7bbtr/RA0qUC/QvOyno5v0ndCcdr
         4Vb/u4CPtS4hBJThMR5fH3iODyeRGcWj5NtDJCpyd/5NV3Q7msBD3IofNN+2N4iU/KeM
         6mjTcUoePHx0f4H5mN1DDGRWRnJBGXzCNlNbD6/DSdEcCLOXwhiFrv3/n97zRFxJPkE2
         PZc0nD27N4CKktViTPUfNYBGen7svtDXLxogHcJDQpwdfQv4dsxOhggjYsgCf7ADqXXV
         h/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788868984; x=1789473784;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lje7LxotFN8OQu8fgaVYYDvIYFBd+T6ZwNc+aWkYRdg=;
        b=qLkL2LtNA80g6IGpGSP2VLkXm5WZ6bha8PppQDclam0NlHDX6Re2hA1Hy7buGyE0aN
         fHaF5L+VE7Jq05HLmzXz0QwrVQtfEUGN5B6XtRmY8+NKqvMTXL5C3sxvr4Fe/r/9fILD
         3oniC/2b3/JSaJbfX2KAa8cDCbDN/n7hVikZ1lPdHqhGi8J3ASP63Sa1RbhWOC//PNe9
         u54a795gUXvIdVxPcj+hgcqQqzNmmFFGlrKozXpbrksUkocHr+AMM10RIhh74lqCTjIH
         n+MQefcT5t+VK1WC7tiL9LHG5Pw1qe25IScXba/iHPLeIuf1YjOt5Z+hU06AFv70CD4W
         yRbg==
X-Forwarded-Encrypted: i=1; AKwUvBxH8mfNHc0tBX5LKJOwNEOsKoMfw+2rQjN416MmzxLgI4ameSpBHx4S0ysqo9093nVw8dbD5xc=@vger.kernel.org
X-Gm-Message-State: AFuF++n+GeUzd3gdHHTQjbTDMfT7DiQxQPcgspmdqdtdDNBDKNPpq5f2
	HfPecE0X6jANyq7NJAPvVp80t041j5hodFLubgRXiT+dq+1XlLXI2uM7In44haJHR5sLaZxyf/v
	D3LNc9SO8p5TdoM0nwzsUvk1qnBgSAne2VPqyQrYreRYXh/BfKi+zxl/msw==
X-Gm-Gg: AYBFou10Q8RkZO4Eo7L06Wux1qpns5/cxYcxL+ZjZwLnZL/jb+Mvd3QwwGMCXZCsbtP
	h5yP6SI4Abwb3p2tnqKD3S6m6dAD3iIKJm6tu6mS1lOFICp+ZouK53VQ/7vWJPBXoeKmrsMtCoe
	RDtceYNrYEYFy97wkvBgxvMbtWceQWEccauciDlNldPLek9i2WV5dICkZaXr493xJPAFyKoHUCz
	x3xDFLhuWo0DGufMEd3DnwQ/iqjPmgr8p77YZhABTyix5PruSKovqN35nZdiJ40dgDObyczsfO8
	L353RLYsjJRS9kiQcWkdwn/PxpBZ3isp4536GeT/q4UCmkNOobiKwcO7zxMLduq6dEWhc5+bepC
	ATFPCyOzUfzN92BQuws3gqaJ8OcGf/q7OjfwObKK3bOcom3IqbMPHHYusyw==
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49cff19cbf4mr224225175e9.30.1788868984191;
        Tue, 08 Sep 2026 05:03:04 -0700 (PDT)
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49cff19cbf4mr224224635e9.30.1788868983804;
        Tue, 08 Sep 2026 05:03:03 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07a23e85sm273590305e9.5.2026.09.08.05.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:03:02 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Fabio Piparo
 <holofermes@gmail.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
In-Reply-To: <20260818083143.37939-1-amit.barzilai22@gmail.com>
References: <20260818083143.37939-1-amit.barzilai22@gmail.com>
Date: Tue, 08 Sep 2026 14:03:01 +0200
Message-ID: <87v78glzm2.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

> Hi Fabio,
>
>> ssd132x_clear_screen() sends its zeroes without setting the column and
>> row ranges first, so they land in whatever window the last
>> ssd132x_update_rect() left programmed.
>
> Good catch, I noticed the same asymmetry. But as Sashiko pointed out and
> you confirmed, ssd132x_clear_screen() is not reachable today, so there is
> no user-visible bug being fixed here. I don't think this should go to
> stable, and I would drop both the Cc: stable and the Fixes: tag in a v2.
>
> There is a second reason the clear cannot work in its current form. The
> driver does not override .atomic_commit_tail, so
> drm_atomic_helper_commit_tail() runs
> drm_atomic_helper_commit_modeset_disables() before
> drm_atomic_helper_commit_planes(). By the time the plane's atomic_disable
> runs, ssd130x_encoder_atomic_disable() has already sent DISPLAY_OFF and
> called ssd130x_power_off(). So even with the !plane_state->crtc guard
> fixed, the clear would be writing pixels into a controller that is
> already powered down.
>
> None of this makes the patch wrong - I do believe in making functions do
> what they are supposed to do. It does mean this is a cleanup rather than
> a fix, though, and that it cannot be verified on hardware until the
> disable path itself is sorted out.
>

Agreed with your points.

>> +	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, 0, columns - 1);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, 0, height - 1);
>> +	if (ret < 0)
>> +		return;
>
> This duplicates the window setup that ssd132x_update_rect() already does.
> I would rather see those two commands factored out into a small helper
> (e.g. ssd132x_set_window()) and called from both places.
>

Indeed. For ssd130x we have ssd130x_set_col_range() and ssd130x_set_page_range()
which do some sanity check before sending the commands to the display controller.

Maybe instead of a ssd132x_set_window(), we could add ssd132x_set_col_range()
and ssd132x_set_row_range() ?

> Note that ssd132x_update_rect() cannot just be called from
> ssd132x_clear_screen() the way ssd133x_update_rect() could be from
> ssd133x_clear_screen(): it takes the R8 shadow buffer and packs pairs of
> pixels into data_array, and clear_screen() only has the data_array from
> the CRTC state. In the SSD135x series I have in flight,
> ssd135x_clear_screen() does call ssd135x_update_rect() with a full-screen
> rect, but only because no pixel conversion is involved there.
>

Correct.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


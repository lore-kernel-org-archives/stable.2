Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B8413D93
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682030; cv=none; b=Vc5GXaawZ/SyIjjGkRrO42TFlS6m5qDFMmcMzCGYN+GJefdlf/x2CPloWI7Fua0YmY+81hkFqCMFwfW4Uc5Rno8b44R1XyHRw+X2YnX6K1jVHmim396wjX/If0TtPbiPmEQs3YqW5UR+U3VNKpttdJHTLl2HBA+yJpOoB2z1eU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682030; c=relaxed/simple;
	bh=c4OVHU38z7vfkatYPQKtn8vnc7akYZidlGLsN81aP0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwD2c4AqKvnv1v4hx62l3gJ3AQxnAz+irxB2NXl6pt2CIJSWfqkpcf+M0vT+f7wKjie2sj9tVqxGm6HayTQAsmaaRmX9iCzXmHMy98HNxBwlbk37EbLhUxh6f5P2w9npccZLmK15J5E6HmEFZ8dJOP4m37pq0zfoncCSyqQyPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Gu3tOBcG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Gu3tOBcG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47640541585so413129f8f.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1783682027; x=1784286827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ODgufXz1PhelMlB2W5pp8vf7ivTLwxqDccyqSe9smQ8=;
        b=Gu3tOBcGf3T0pnU9ybwJ1OIj0sxHVMkkaVxMCpYU1p+VQfXrRcf8t/tZq4Nl9iRgrb
         jedOKWmhfFdqNIBXQuF27OcoYXMobk5QXFhM/CeFArNDEzILbQscmFisasjsQsFVFmT6
         n70WRs3rocq8pj9uCxgEYoqUVecNlXWK5WWyrBfZ7lkjY4imeN5GobWtbADjQSazOER3
         zUJs1w1n/cUWM+k/n9t7cAxyAF708wvv8Xnfq89Gg4VZfqLCP1u+Rx3xLeuUA/C7xYCm
         zzb/QmgHnpBVTyUyOFFkaIipLq1JCIf3sFKPvgz9iaSMXmUSp5WOzTOHyJOLhFw5Fixc
         BOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682027; x=1784286827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ODgufXz1PhelMlB2W5pp8vf7ivTLwxqDccyqSe9smQ8=;
        b=TCrUztd7llm0YpFx3FcHFgqYG64AsTdMoD9F3kJfyq8msm78/ysRIJk8XUS4+Cw5EH
         3Njg9wvJiaWEKQYBrnBX0ttDCs0tQ9/kyeAi3G+yIYOEXkYK0C19ofFKeA2VlZEt/mXW
         uXvyxM1C6hL/5N/EH9lViwJYfNqoLAAM/U9YZdQBwU6Xw5NmzajceQm9FMvWW7qAoslM
         LKo+Eb9D0+r2ih8JeIbaGKvOn1DvWcmuw0or2XmSYhpQNWEdewdRClaJrXS5Ste8B/hQ
         KMwh+Vn5DZA/MNSmQL4ChPoLTejScWCycYtYO99UiOZujKei2Lrvz//9TD128a7fT9dq
         u3yw==
X-Forwarded-Encrypted: i=1; AHgh+RpiZHxIq2bRU2ucB0rFI0qs3JAYCDfgXksWWfp07aXTQh4fUBGApe8qtfPQp3ZVeaHzDGZi+O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZoMSD3zpKPTtiHEBV3EOIN0ntxKGJHafJIgug23aTIlPwW9hV
	Gjuf12ZVLKh+olDk5JdjAvNZKPPGykW/9nMM7t9mX3tX4zlj3oBTrlpaAkaYTsDACGw=
X-Gm-Gg: AfdE7cnhA0Q6JZ8gq5cMrc3YOcsOphvB+XkcxD75dRTa8u8xV/veeD21+kI7xNN77EN
	kGDrdBlKGSFCn7Tj7aJ5jMzbyfwuB+fA61JKYgGtP6sR9am+UxSfIwaxdxroLmY3Ke0TvHnRWmo
	6BYEdWhJ0z+TWd7LNF+uHij5d0k3OktZFFL82Ang+zTw9uTUtYxG9Dclbdkyu/65mMNDdv12c1t
	wGLf7JuNlEqKTEcS9XDy6b8tVai6Wraw7s6Y00nRcxlyyPY722YOB+tT381aPEKwkccOqlZx93I
	pO3I9st1jaEe9ZTBhp2ce22cYd9XPEPjBkKlds8d91uGrMciMBTZwHTau4CbOshcYQiBFU9U5ra
	idzueg/P43hG2dBKtWMwGDKMg67W5ICV/BnOhIrzbfcXORpqyO1a2BS26X3/Hk6cXK06kGWFwH3
	09uKgIxGX4GstNPj347jhsNC5NYUwbruE/cz1QkLaU09ORIcrGUoyJxeZ4
X-Received: by 2002:a05:6000:2482:b0:477:6874:5415 with SMTP id ffacd0b85a97d-47df074605amr11973058f8f.26.1783682027154;
        Fri, 10 Jul 2026 04:13:47 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6e4csm56399132f8f.10.2026.07.10.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:13:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:13:45 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?= <a.vatoropin@crpt.ru>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, 
	Andreas Gruenbacher <agruen@linbit.com>, "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drbd: Fix potential NULL pointer dereference in
 _drbd_set_state()
Message-ID: <alDRuDisKeheSGc8@linbit.com>
Mail-Followup-To: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?= <a.vatoropin@crpt.ru>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, Andreas Gruenbacher <agruen@linbit.com>, 
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260625050016.12004-1-a.vatoropin@crpt.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625050016.12004-1-a.vatoropin@crpt.ru>

Thanks for your patch.

On Thu, Jun 25, 2026 at 05:03:06AM +0000, Ваторопин Андрей wrote:
>From: Andrey Vatoropin <a.vatoropin@crpt.ru>
>
>The connection pointer receives a value in the _drbd_set_state()
>function, including through a call to the first_peer_device() function.
>This function returns a pointer to a list element. If the list is empty, it
>returns a NULL pointer, which is later assigned to the connection
>pointer. Subsequently, this pointer will be dereferenced.

Can the list actually be empty at this point?
The peer_device is linked into the list in drbd_create_device(), before
add_disk() and before the device is inserted into connection->peer_devices,
so no state change can reach the device earlier.

It is only unlinked again in drbd_destroy_device(), after the last kref
to the device is gone.
The connection itself is created together with the resource in
drbd_adm_new_resource() and lives until the resource is destroyed.

So for any device this function can be called on, first_peer_device()
returns a valid peer_device.

>
>Add a NULL check for the connection pointer to avoid dereferencing an
>invalid pointer.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
>Fixes: a6b32bc3cebd ("drbd: Introduce "peer_device" object between "device" and "connection"")
>Cc: stable@vger.kernel.org
>Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
>---
> drivers/block/drbd/drbd_state.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
>index adcba7f1d8ea..ea982d48017e 100644
>--- a/drivers/block/drbd/drbd_state.c
>+++ b/drivers/block/drbd/drbd_state.c
>@@ -1281,6 +1281,11 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
> 	if (rv < SS_SUCCESS)
> 		return rv;
>
>+	if (!connection) {
>+		drbd_err(device, "No connection to peer, aborting!\n");
>+		return SS_ALREADY_STANDALONE;
>+	}
>+

Also, even if the condition could happen, its handling here would be 
wrong. Since this check happens before handling hard state changes, 
those could potentially be skipped, which is not allowed.
For example, after a local I/O error (drbd_chk_io_error), if this 
condition would trigger, the detach state change would be silently 
skipped. So in that circumstance, this patch would be actively harmful.

Also, SS_ALREADY_STANDALONE would map to the error message "Can not
disconnect a StandAlone device", which does not make any sense in this 
context.

> 	if (!(flags & CS_HARD)) {
> 		/*  pre-state-change checks ; only look at ns  */
> 		/* See drbd_state_sw_errors in drbd_strings.c */
>-- 
>2.43.0

In summary, unless I missed something major: NAK.

Thanks,
Christoph

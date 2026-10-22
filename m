Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792634342;
	b=FjynHf5gCTSS7tGkO6C1TzDHyKS+pH/A2oSQ1XAdmCQggMW5UHf/laXW9dZdmZnLfJUD
	 bhRNSFfvSJaO78hneiEWd7PEm4sDlBuOTrE1hJO8J0OpIsF4eP2+nKZJeOsNzqV/B5un0
	 l1cTzBYdjxlvgxIppbsJYLCLZrowsBv+c3c1nP0akS/65PQxZ1T30GtQzDaR9Ttmj21gU
	 COkSkZ5HXPXbb8U8RpU4o1C+y/NUCwt8lemDq0EXtYqFnRv2ibXb9iHsG7EI4MmJ1FqIk
	 6mYbJN2qglPbNh4XvN8HPZLOtO1/C7fFu3DLFLAWGvlXkvY7S+obxcQU7fy2hCwHU+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
	b=I6QVwBUtjWKl08XK/HfZaoX4RDr1HOQFvlg5OqzeqmzLHu6cRw16I5cuBiDio4wXg46P
	 t1OwrygDfhWqMOdn3acvdVwcIYx37Vto5aq98snItpzweRgEl2bQX+wBUpkDCqnPUzKqp
	 bHND9TvYP0rQFdMUl7Tl28WnFy6wy0Kc91+u6BHnELfjhQctxNnmViGxFiUfSWVtz59fw
	 CrF0AKloOvBO/uySClrZJg2X5zp2CkHgFo7GDT7b6p1idRa3LonD57lLIEuetgqFSkxU2
	 qIv45ssmtVjMDNhblpOoa9xe3nvLVdatr9ht2dolG3n7iZ2iombEizceU/kCYT/CMgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=murgatroid.com;
	spf=pass smtp.mailfrom=murgatroid.com;
	dkim=pass header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=Dn22YTWF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9B606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8D9B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=Dn22YTWF
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535a54bed9so1914052eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792634341; cv=none;
        d=google.com; s=arc-20260327;
        b=gmbGMgP1cTQBhRL8SiGUvtXjhT5z/0HxhHhNdM61UH/8BUN4QjFpye09Ovl/04tNrU
         jnn5T6fKEIfGoWN63GkdZ1CzJi2fqLq1G6NqxVx6L8AhpexN6kufmGpZcSl7VVRirkee
         OUFXet6H6I7OR8A06p+nrstHwQX6xaMZ3KP9LF7fiWQ/sBsHjQkdLUfJOfOb8kdvWH2e
         +RrDrknlu8WTwRqWDL+cSTLhpTMYi91Lfg54paxBw4+zvW5xp/jAU2FtEAOLpdJDurNZ
         eBLY4ci/0p6t5uSjIvCNDaYhyYwYafW7J1R1Xc4GEXR7qgjRJpMJWd3nutAAaqKwRolU
         6d7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        fh=Y6bq6Qb4Wg0qmnWX33oLNRgPcS7HpRw+pYXTBEXlQTo=;
        b=jzwp79oc3pkSuc37DejXztwXoSlJiNzLY5htshxnE+Jw92R83ZxaVw213b8PjgH/rr
         dSJE2wBReq5qQR1OmaCULyAUDg819gwp0PsewHzznuHA6VI7YLRMBfL26nz9UyoD/xcI
         2g/ADbg5hR80z3eyh4iAc1sXKLBrjzDA2DTAsVzd1Mpax6HPhQE69VfSI/VSyBgwfYDw
         a7MwH/dy/1ojkwfZbX4Rl4XC0ONWJYvhtNJ5pP/3P24hPZFNFV0InArrHkqFDOQXNKRo
         tPOrF3RaDc1kNJXhrrFJ/IAVCERLQmZ8XmhQBfJd4DIAcTXviikmvPWK5QUPti/rCZ97
         +jAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=murgatroid.com; s=google; t=1792634341; x=1793239141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        b=Dn22YTWFHXuz5eBGAfgcXhBaSngAcdqW6Ktq+DQbZGylcggyWaChglRW/PsuJhLKQg
         ttkF4JCIZP0NHjN2sKShcr4i3TjPFg+AUESLvr8tjPomsIvOO3VHDGgnFbu7HXRmkwJz
         kImqDIsxFiYu0K537EdLnpNStdF056NaZPRo14LbHN/aqM0mWS4rIhbcixaBq8jovoA8
         W6w1+JotaqCa3STOt6xyC2CdQVdq2ylm+m5PNfmvuVoXH0WeS7zIEsdTk6dsJR64Fv2s
         xW33Ws90oMWQ2mjlNcvVNYalCROvgRUMnn1KIjCqem8758v8B/qRmxfeeJxCtX06kTx/
         cZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634341; x=1793239141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        b=sS2+vsntN5ka8bJ95p7zJFsgzaBFFr0nEtpgt0SYzxlxI2D36Avb1O0OI1zHY8WsvX
         ueOumT4ksWy48zMnwYoH5Hw/KDZmQCRS+t21DafKToTFmCAl6wcq4WCM3E0kD59g5+fC
         l+Pegc7qGT0gXiSAqxVU8TFQ8Wnsh/ddw8/TezeKYHAQR/LZULVqNZ9XUrADV7hBBk/S
         a6yK20E737Ip4jFneXdoelfLfEm4Ibui7xbKK0HJLVhB0M9ypyYGCf0O8m6+8WObPbqh
         kkCc2jfgu2rgB0342feyFojwkEHOkFSEq37Xh0wUxxUiW4de/jxar1AkuoOlKPATc2Zk
         pRfQ==
X-Forwarded-Encrypted: i=1; AKwUvBztj7Hy1DT2Bw5gZGoOxWIM1NNfyYv3MUM8WOWZFTivylIk1eEWj8krwLgI4ZblNpnH+K4I8UA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbmuEAICVobjlrOX9tba9NFc28ipkfLCetIUpk8SBnuB27lj4L
	ZAcEZ3Iys5z+3ITwTURKud+YQehEOYoEOcdktsQyipttfL4DJzm62FyI4iEoMQ2TOp0joEW0ycV
	/lAZxAjkO4ukWB3rNJ0u4a3ZaLuBxPz4WKCSSlNhE
X-Gm-Gg: AYBFou2fRvlipr7DIMJ4iQeuH9bSYQBsQSnafq+wp0vYAOd4TjYfy51bnE9rzZC2Zpb
	ztzXBMRCUwX2R/Cl1DgcebHC+ILULayP1XhBUx5OA5PHwqn1Z0lYjJJoOJYGOi22sTkXoVocsE/
	EfzGZlGGruheTikxCH7jIYk90+pe9H5MKeY4c37lq26+USEDQdfQXqrDIM8MZ7yPa3hugwNzxpB
	ODmNMkS+qq40EVKarVvfLi8PpynzL76IswZfdRfpcy6WvnY/6+DTMXevOnqJzIoT+r0AV4d5cUd
	LlqV6QnccRBlsYM9i6rfxltigU5ntaHz3p1fmlKtk/elXZW0oWNEFAKXf6s6C82YTdaHFSzQ7Sz
	OqKXQLUNLKLoBfTQzTMEEk5gbsreoFh+BTpBSIkPxtVRFif3vFpgHqsTNDxUzxCRu6VOLJ2B/6N
	LC+fXQDRzEK5jRPw2RWlGl0Mpm/DCLZ22bCsc=
X-Received: by 2002:a05:7300:e70c:b0:351:1bdb:e3b7 with SMTP id
 5a478bee46e88-3674cb37bb2mr5335214eec.15.1792634341036; Wed, 21 Oct 2026
 18:59:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019023420.83976-1-ch@murgatroid.com> <20261019023420.83976-2-ch@murgatroid.com>
 <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
In-Reply-To: <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
From: Christopher Hoover <ch@murgatroid.com>
Date: Wed, 21 Oct 2026 18:58:49 -0700
X-Gm-Features: AclHuK-UlpT4QZJ3hk8thqk-ORABl_Te8RQcU0z-w1fijnZP-8kQdVwWN9ZtSy0
Message-ID: <CACw0PsaJr6E0Y3AXoGKDUiKp4vsaA+GEJjPqEhYuSoKqDp1jUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback removal
 with raw events
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Lixu Zhang <lixu.zhang@intel.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  Is this issue actually reproduced or it was found by some AI tools?

Real life.   I wedged my kernel several times with an MCP2221A usb i2c brid=
ge.


On Wed, Oct 21, 2026 at 6:22=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sun, 2026-10-18 at 19:34 -0700, Christopher Hoover wrote:
> > sensor_hub_raw_event() holds pdata->lock while it looks a callback up
> > in dyn_callback_list and calls its capture_sample() and send_event().
> > sensor_hub_remove_callback() takes only dyn_callback_lock, so it can
> > unlink a callback and return while another CPU is between the lookup
> > and the call.  The sensor drivers remove their callback in .remove()
>
> Two spaces before "The".
>
> > and keep the struct hid_sensor_hub_callbacks in memory that devres
> > frees right after, so a report racing an unbind can call through
> > freed function pointers.
> >
> > Take pdata->lock in sensor_hub_remove_callback() too, outside
> > dyn_callback_lock as in sensor_hub_raw_event(), so the removal waits
> > for a report in flight.  pdata->lock is otherwise only taken in
> > sensor_hub_raw_event(), and callbacks are removed from process
> > context.
> >
> > Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christopher Hoover <ch@murgatroid.com>
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/hid/hid-sensor-hub.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 6470a290ebfc..7cf9f398592e 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -173,7 +173,14 @@ int sensor_hub_remove_callback(struct
> > hid_sensor_hub_device *hsdev,
> >       struct sensor_hub_data *pdata =3D hid_get_drvdata(hsdev-
> > >hdev);
> >       unsigned long flags;
> >
> > -     spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
> > +     /*
> > +      * sensor_hub_raw_event() holds pdata->lock while it looks
> > up a
> > +      * callback and calls it.  Taking it here too means no
> > report is
> > +      * still using the callback once it is unlinked, so its
> > owner may
> > +      * free it as soon as this returns.
> > +      */
> > +     spin_lock_irqsave(&pdata->lock, flags);
> > +     spin_lock(&pdata->dyn_callback_lock);
> >       list_for_each_entry(callback, &pdata->dyn_callback_list,
> > list)
> >               if (callback->usage_id =3D=3D usage_id &&
> >                                               callback->hsdev =3D=3D
> > hsdev) {
> > @@ -181,7 +188,8 @@ int sensor_hub_remove_callback(struct
> > hid_sensor_hub_device *hsdev,
> >                       kfree(callback);
> >                       break;
> >               }
> > -     spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
> > +     spin_unlock(&pdata->dyn_callback_lock);
> > +     spin_unlock_irqrestore(&pdata->lock, flags);
> >
>
> The patch looks fine. Is this issue actually reproduced or it was found
> by some AI tools?
>
> Thanks,
> Srinivas
>
> >       return 0;
> >  }

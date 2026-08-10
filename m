Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30083C3C00
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362734; cv=none; b=bK+XzQRq4/VP8gnEeGAdYT8KwyE3FNCmCCX94OYj0k5Rc8381tNO8158q8Tm8FFXCqJkkhfPLXQd3/WYWy2/WIlym7iZ30vxMV/oU7Lgi4En3yJzukKkW5Xls/9p4Cb63qqjkOF8Un442/KiAHx5Ax6H4d9+ywrhqzJ8/SQ3lHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362734; c=relaxed/simple;
	bh=cUCOvrwZNYJ93TzzjPduqckoiYdf5scoI91GjA688Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Evzt+PakPqDUSqm1FLtA+cj1mYTEzm4AtE/twOj2phbzMD12NsFqn/0Pq6YAQGrWJFcJyLAPXRB4uNxUdIXLK86WG+S+2wBujBPTublMnAz/M0plXz7Ty8qYC+wGU67vrRcPwWlLFIMDMGhF2sq7yvtMNFSLGSIvhhTLaEvEM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HA9EzXKf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HA9EzXKf"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a1f7f42510so1545173a12.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786362731; x=1786967531; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vt26899TwVMjSklpB6JL+ciaOvdGQnhVp8YZLTm+78U=;
        b=HA9EzXKfvxj8aYHwxPH0crUrGZa3BK4l/m5djair5Xq6x6m0+D0LMtWcV7tEwgxbU+
         4TM0eWo4w8eem2i3fz8YWsyqlqRcPE2ec6IVfATeZyOcisDNqU7EjM7bZggc1hfLZPvI
         OwdSyjSxndSWVBaGaDZ38tJPzZA39d/FfBZFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786362731; x=1786967531;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vt26899TwVMjSklpB6JL+ciaOvdGQnhVp8YZLTm+78U=;
        b=rBN/2XhaxvdH/sE3f5XzyElFAAQjxEagsvwBGty8pvuZXt6d+1Cnk46xqe0WOBJvfI
         KwcSGeFrl3jRPYVeMcKkn6p0Y6CdQTmRTrBzMije9nrHkcussd0g831AHNrTZg1iWZdV
         HhJfu2xL5cg6l5qscB7n1ffxc1GxctAqthdh2dsF1CvHBBLS5/8H72H6gfYDbllIaU0a
         JI1a9KueNB1EnS5xmYiFWmtG2ey/3Fh+9xQroZODYci8b2T7BVy678NwU+fI+6HL8IoM
         gM9Y6Z3Ki4iVe0386UbKXwWoyK7B6APCBP5o4D6DM2Crjj20mauzk2XtIQurFEdDqwWL
         d1Fg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/it4JINIJ1x6GlyqHb3VgM0KMPMZ6HZ5Sbn7J9URAcuNUL65hF4JFHUg236vGscgNEwbwSRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIll3se8x6K0Yr3l6Yj2iP7JHqap2slDx8XN2OZ2FiVn9ALF7
	Ay9tjArlGaXtrl8iSGxs2cs2ldaKwFisoOK9FYKdl9tYMKlS8V/W6ZgWvCu2qc4Wb3x5hgMwnFn
	Srql+Mw==
X-Gm-Gg: AR+sD11OJ7LIr84EGZoPOf8tDCuMbgI1OmGYdbiRHh5LudGh/57vmQm2ecg6DpqOnQk
	mgZSeEF5pUvCcFiUBZit7K1cNsOVpjbLNbB8XlhN7HGhOH0qNkZRjTzmqDrA4+UXk1n9M1ONUF1
	OcJ+zzkTnO05mze5GQik7d7ftZUL4jgAlJiVb7QCbH3iC73IdfjjDBuVBVIIuTHoqxtMOuVivLy
	q6GCpBPPC/T0iNf0psk2ShfFsobxkBszobu+/eIPtcGrP5t8VEP+ZH1RT1qXUGSzjKXleFTsRv8
	S+lk2mWpMcaQjNfrbPjcy4hy1WKnoEYNiIW/3Lp7I3lIN7aSRbx90nq/uWtrOiAEUljbzoZu3kZ
	+hA0tnYBWWSG/K2rpbt3VepGzZnq18+F/j/dVd1uruTzAkRJFQkh6zgsjJhxCT1mTZHEShc1iby
	9cgqZIf5kDlGvWT2D+DH8yzPNrSIZ45uVd24dE6QqxR3dBWL+EwdVHzlASNJdIyhd5EXCENi0+T
	x+qDEc5YAAl7xjoza0BRPqeP+jW6Sm+kkADxA==
X-Received: by 2002:a17:907:db15:b0:c16:71:d9ce with SMTP id a640c23a62f3a-c2039b6ecb3mr1793411566b.8.1786362730967;
        Mon, 10 Aug 2026 04:52:10 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c90494sm376066066b.36.2026.08.10.04.52.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 04:52:08 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c160420289bso178276566b.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 04:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RodQZ1jjI0C9Do5mEH5ZPOOD8usmY82nyYAkgLb85zbLqbceB/b1XRFCLolberxpxlYWdLP2Bk=@vger.kernel.org
X-Received: by 2002:a17:907:1b04:b0:c15:d4f8:dade with SMTP id
 a640c23a62f3a-c2039b394abmr1947856466b.2.1786362726960; Mon, 10 Aug 2026
 04:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ABE1FC11603F6BBE+20260810091624.2159038-1-raoxu@uniontech.com>
In-Reply-To: <ABE1FC11603F6BBE+20260810091624.2159038-1-raoxu@uniontech.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 10 Aug 2026 13:51:54 +0200
X-Gmail-Original-Message-ID: <CANiDSCvUBV-r7a7d7AbU7aXJ_kJYg80_y_7+8Rk+Wt7FkwaJAQ@mail.gmail.com>
X-Gm-Features: AUfX_mwC-JQgjX08GvfbcVU9ul_-OLbokBaXSXTZzsWHxoVjvht1T8b4uZt44Dw
Message-ID: <CANiDSCvUBV-r7a7d7AbU7aXJ_kJYg80_y_7+8Rk+Wt7FkwaJAQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: fix output terminal type check for ID namespace
To: raoxu <raoxu@uniontech.com>
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Xu

Good catch :)

On Mon, 10 Aug 2026 at 11:21, raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> Commit 3d9f32e02c2e ("media: uvcvideo: Create an ID namespace for
> streaming output terminals") added a separate internal ID namespace for
> streaming output terminals.  The namespace is only valid for those
> terminals because their descriptor IDs are used by streaming interface
> bTerminalLink fields, and uvc_stream_for_terminal() intentionally masks
> the internal namespace bit when matching that link.
>
> The parser currently decides whether to use the namespace with
> `type & UVC_TT_STREAMING`.  Terminal types are values, not bitmasks.
> Since UVC_TT_STREAMING is 0x0101, standard non-streaming output terminal
> types such as UVC_OTT_VENDOR_SPECIFIC, UVC_OTT_DISPLAY and
> UVC_OTT_MEDIA_TRANSPORT_OUTPUT also make the test true through their
> 0x0100 bits.
>
> Those terminals can then receive an internal ID that differs from their
> descriptor ID even though normal UVC descriptor references still use the
> 8-bit descriptor ID.  This can make later entity lookups fail or hide an
> entity ID collision that should be handled as a regular UVC descriptor
> collision.
>
> Use an equality check so that only UVC_TT_STREAMING output terminals
> enter the separate namespace.  The issue was easy to miss because real
> streaming output terminals make both the bitwise and equality tests true,
> so the devices targeted by the original change keep working.
>
> Fixes: 3d9f32e02c2e ("media: uvcvideo: Create an ID namespace for streaming output terminals")
> Cc: stable@vger.kernel.org
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e289cc71ba98..acfc5797a1c2 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1130,7 +1130,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
>                  * so limit usage of this separate namespace to streaming output
>                  * terminals.
>                  */
> -               if (type & UVC_TT_STREAMING)
> +               if (type == UVC_TT_STREAMING)
>                         id |= UVC_TERM_OUTPUT;
>
>                 term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
> --
> 2.50.1
>
>


-- 
Ricardo Ribalda

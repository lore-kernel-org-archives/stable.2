Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABC25B0B2
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129667; cv=pass; b=dsJC2YmsgryAAYAPSgZShKj3tTpXUFLurbIQbKFEI1ZhehgNEFTsC4FsNvQd4csNzAGMF3pDWCoSTEY1Pla5JruUInYF/BZmZwf7kptYjjpBhqLNw+qu8I44Xff8npnigxchH0+/2CLdfvY+dBk/Acc6p+YBhMGaJ5dBtrnTgHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129667; c=relaxed/simple;
	bh=ZD9tGJJOmrxjp+XXPfu98euctPfzwVJyhsLLMYaGrfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbIbV1pQbXO4gR4o7aFe+LNhghGvD6d20gArA5gzJe5AIZAQVCkC933L9frtwmb3WODs9GeJ+iADpfYennTqckn/PbJlTIUWk04q9wMLDzdK8Qi5JHW9U0bnTkJoznqlceWsUMMDWYxynOvElURY7IhNpO3UuTK1RBV545PfDco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP4KpAFv; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP4KpAFv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bdb3fd39045so577833766b.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782129665; cv=none;
        d=google.com; s=arc-20240605;
        b=cS9IA46O94sIHsiHiG07kCgHlLh3Bq8LbBDEBaZyLsEEmzlCyjF4fYTjejkP6JKmmW
         X1MggGg8oWiWMw6D/Rj0+7+38WZOrU+opTxIe74vUg/WHpR5wW3NPf5hufvSxkjqAIZV
         BvN5IWojbTS9StezbEDd2HieHjZfwmHOi7DOQQNrsZbV6PlmdXk0S8ITHIzceerD/bty
         O/nyn5hbFmej6GznE0/UsvX+zRD89ZyAJHpvRxCoZRP1YpGqarYXs5D/iGMsHgETIMsE
         C53hX64Rx1LCCOgdpkcpX8KaXLM2giTkJ+5Jdf0aiuaGmdgHguQEJNg+Ittiz2NTcQ5+
         HEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z/UQd6gAiCKpdO/qT7NweWYk9EmiL69nd3YrHKH5p+g=;
        fh=D4EoJiXlyLZOMcFoqFYixno/3/3jeCII1Co2wXUZ3q4=;
        b=fAKp63edqSAV0hGIuTxiIiFoVw/KrAsfyKwF4JpncmyC4JPBKgsn+dze7ZWzuRzsjL
         mqzhennonWaukKjJUMA/bQDUS1rdtw8rr8P8EyAZNr+3H3L6Ol0tFE0RWDJZAFStMGb9
         KyKlPivIoGHpHrT4gOQfMJsRgWw6Yxz3GKOlEpZk+v4DMQyki1J+wLMw1LeTAxD8ZImb
         f9DOrl7wdeAxasvDEHIiiMf89YcVKjG5xAmwBgcbsFl/BeDEgcIJg655wCAN4bvRcWwx
         YbEFRb388tZZ3B5mCbUUY5oduyqN2eb0YnMONsJUxNeeOEplmjXJhlvx3CqSdSOMolvN
         PMsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129665; x=1782734465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/UQd6gAiCKpdO/qT7NweWYk9EmiL69nd3YrHKH5p+g=;
        b=HP4KpAFvarJ30i0m1IA4XhHGf1JN2cGmHG5/RhBR3LagblBMwkjj+tr6lakX2UZHZK
         4RbofxocXuRFYKOl69z7vnjO+wL6xjYeXctfiPTy7WcFgss35WTLCRFC2jkgByjK20Z9
         pXOpd+nYX8928hmJIyTgjFX2B2elcCzL5xtojmV99Iql3d20pOsfrkAm3TYupJASixdX
         wLOhBgs1sBEQe7he9eKquT04Q62aUMmWCtC85QBDIWzgV4CJh1hZJQdEShQY73fX1DoA
         iK+74c21kqX2OlRSKN6kw4iqtRTfuJYcXeP/9vam8dGf2OCioWSqtb2AFHBxqeCh0iEJ
         dAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129665; x=1782734465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/UQd6gAiCKpdO/qT7NweWYk9EmiL69nd3YrHKH5p+g=;
        b=rjm9W2CruYSA2ADQevbp8O/PD2yZWQMjMCE8qfZjzKU6SF8plola2/uXwcX5fHcKa8
         HTF3nZeDvjbH70vUWiOHR6p83WZhoaNsOllTnGmOfa53ZMkkLk2oUlKOOMY5ychm+uId
         4GZIH+UCQc1pIMoLrKQ9rNjSKZNkJU7gU65qbfh8U9uDgjpF9tfbqmpt3YWWd13JBPCU
         0vhO+xZLbsE4FjLGZt4hWFHa0OlGdbOFMm63li0zHUZg/NY6ECvULw59qtM3q98q6Naz
         basfPdjPmbBlTr286+bIb3puSJrm0fCsd1QQUHLKEvw3oSuid3UC58wqucljNr3A/LRW
         C0qA==
X-Forwarded-Encrypted: i=1; AFNElJ8bg7PsX2oA4IIFlEtUs6Mp8yc3bBbr4cf7jZZHazzxdXmjehunhH1IPbvJqBZ10W8ME9oRVJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxWWXKMpinfGvhSiEAMjnIQsag98tuds/jaw7FDuzkqnl9Vsq
	1Z0JBOwrOnxtJIAi+BCO6PaRH+uHZtr7RCVCUAUA46skEd1agm40WAzjjGm2zwqU4UP9Q7JSOYD
	QklyjhpTqOaEO5s7ISavMxziubXynqg==
X-Gm-Gg: AfdE7cmOeQ8ZMPmp2gNOFCVaRaaI8379PS7rg8pobMpJuakG7UXYSMPJ9CR9sbSXKix
	fcnw/b1yqxCUv1EDL13pGJr04YQoJawqpJScR9cPOgkQfCQ9Vw78NGGflYIPqb/+Chh0IQEn22X
	Q0xKPHgDrLz+/ywn9ZaZIHJkOXigCQeDwDEFplZVbb3LU63vmFFNNH/NwFPSEhsZVnjNdDaZP6/
	/eK0+crYB9d0GGiPvix6x2vjf3G07p1BRsd/5wid7/lPEaD0D3V+9YQTdubxeRNwrIkJplY3yzZ
	QjeyU50kD2oPn7Z0nEmx1+xw
X-Received: by 2002:a17:907:3e8a:b0:bec:5264:e52d with SMTP id
 a640c23a62f3a-c097ae2dba6mr734296866b.11.1782129664281; Mon, 22 Jun 2026
 05:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424165238.31333-1-mhun512@gmail.com> <c9c20bce-a1bb-4932-bfa0-c87f7156ff82@foss.st.com>
 <ajPcKcJfbIdPKI8-@kekkonen.localdomain> <02b07f43-3c90-4e89-8747-7fd424d87dd1@foss.st.com>
In-Reply-To: <02b07f43-3c90-4e89-8747-7fd424d87dd1@foss.st.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 22 Jun 2026 21:00:51 +0900
X-Gm-Features: AVVi8Cca7UOWphF8HJsSk1WcZ5pnlyOtgCIPMzJHRCDI7-laXJTy-z3xZ9jXfvM
Message-ID: <CAGEsz8F3P8NpOPr_7wCcr+KOLHjYOXu9=5k3-EaiAvb3Eirvrw@mail.gmail.com>
Subject: Re: [PATCH v2] media: i2c: vd56g3: clean up subdev state on probe failure
To: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin, Sakari,

Thank you for the clarification.

I agree. The missing cleanup is on the vd56g3_update_controls() failure
path after v4l2_subdev_init_finalize() has succeeded.

I'll send a v3 that keeps v4l2_subdev_cleanup() in
vd56g3_subdev_cleanup(), and routes this failure through the probe-side
err_subdev path instead of adding another v4l2_subdev_cleanup() call in
vd56g3_subdev_init().

I'll also add the appropriate Assisted-by tag.

Regards,
Myeonghun

2026=EB=85=84 6=EC=9B=94 19=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 5:59, B=
enjamin Mugnier <benjamin.mugnier@foss.st.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> Hi Sakari,
>
> Le 18/06/2026 =C3=A0 13:53, Sakari Ailus a =C3=A9crit :
> > Hi Benjamin,
> >
> > On Tue, Jun 16, 2026 at 02:49:54PM +0200, Benjamin Mugnier wrote:
> >> Hi,
> >>
> >> Thank you for your patch, and apologies for the delay.
> >>
> >> Le 24/04/2026 =C3=A0 18:52, Myeonghun Pak a =C3=A9crit :
> >>> vd56g3_subdev_init() calls v4l2_subdev_init_finalize(), which allocat=
es
> >>> the subdev active state and requires v4l2_subdev_cleanup() to release=
 it.
> >>>
> >>> If vd56g3_update_controls() fails after finalize succeeds, the probe =
error
> >>> path currently skips v4l2_subdev_cleanup() and returns an error. The =
driver
> >>> .remove() callback is not called after a failed probe, so the active =
state
> >>> is leaked.
> >>>
> >>> Route this error through a subdev cleanup label before freeing the co=
ntrol
> >>> handler and media entity.
> >>>
> >>> Fixes: 87aa97fc3157 ("media: i2c: Add driver for ST VD56G3 camera sen=
sor")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>> - Use a lowercase subject summary.
> >>
> >> Please keep the first character uppercase, just like other commits on
> >> this module.
> >>
> >>>
> >>>  drivers/media/i2c/vd56g3.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/i2c/vd56g3.c b/drivers/media/i2c/vd56g3.c
> >>> index 157acea9e2..43f792288a 100644
> >>> --- a/drivers/media/i2c/vd56g3.c
> >>> +++ b/drivers/media/i2c/vd56g3.c
> >>> @@ -1427,11 +1427,14 @@ static int vd56g3_subdev_init(struct vd56g3 *=
sensor)
> >>>     v4l2_subdev_unlock_state(state);
> >>>     if (ret) {
> >>>             dev_err(sensor->dev, "Controls update failed: %d\n", ret)=
;
> >>> -           goto err_ctrls;
> >>> +           goto err_subdev;
> >>>     }
> >>>
> >>>     return 0;
> >>>
> >>> +err_subdev:
> >>> +   v4l2_subdev_cleanup(&sensor->sd);
> >>
> >> v4l2_subdev_cleanup() is already performed in the caller (i.e.
> >> vd56g3_probe()), but as you noticed it is not called from this path. I=
'd
> >> rather have the return value route correctly through
> >> v4l2_subdev_cleanup() in  vd56g3_probe(), allowing to keep a unique ca=
ll
> >> to v4l2_subdev_cleanup() instead.
> >
> > Is it?
> >
> > If vd56g3_update_controls() in vd56g3_subdev_init() fails, it'll jump t=
o
> > err_power_off in vd56g3_probe() which does PM related cleanup only.
> >
>
> Exactly, I realize my sentence was poorly written, but if I understand
> correctly we're on the same page. The problem being
> v4l2_subdev_cleanup() not being called in any path if
> vd56g3_update_controls() fails.
>
> Now if vd56g3_update_controls() fails, instead of performing
> v4l2_subdev_cleanup() in vd56g3_subdev_init() as this patch does, I'd
> rather have it done in vd56g3_probe()'s jump back so we can keep it all
> at the same place, instead of having 2 v4l2_subdev_cleanup() in 2
> different places.
>
> Tell me if this is still unclear.
>
> >>
> >> This patch looks like is LLM generated and sparks my curiosity. If so
> >> you must disclaim it using an Assisted-by tag [1]. Sorry if I=E2=80=99=
m mistaken.
> >>
> >> [1] https://docs.kernel.org/process/coding-assistants.html
> >>
> >>> +
> >>>  err_ctrls:
> >>>     v4l2_ctrl_handler_free(sensor->sd.ctrl_handler);
> >>>
> >>
> >> --
> >> Regards,
> >> Benjamin
> >>
> >
>
> --
> Regards,
> Benjamin
>

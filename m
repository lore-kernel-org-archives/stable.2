Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0848381A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211867; cv=pass; b=DaiyzexKJ6SOHBBjCSjFtXNzxEAJkRpysTHWyCl/JxE8At39sumgQ9TaDEzRLccg2oWIBgAd2jSwB8e+2+2yzUZZAjWe4xgOiemhs5QDtuLgFHorToqR62CzRPn1hijXRKgP4IhSn/niGkJudqmWbCL2hhlAZcLxINQSn2smltw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211867; c=relaxed/simple;
	bh=YrLe/bgyFwpgpqiHffOcUv8w8epm9xRDZev+pTSWF4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHadohaLf5CgxhgRir2gW4CIoG3g38fA+CmsPGp1f0vmr6JDrG5bwI2E/J1H51o2MST/KsHwntUF5taJpkSBnK7wWAEDSnx7/xJQ6rXu1ovxNXKuXchUI5nEvhGh/8bZn2fb41eM7Cq8i30Y6qW1mcxGhKG7itslYxMO9Z866NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AKaOuyIw; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKaOuyIw"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1190422a91.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 07:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791211859; cv=none;
        d=google.com; s=arc-20260327;
        b=M5eJCQ/UJg8b8GiEt7LRzyCnS68VkSKmNliXLpBCglJRku/H2iCDs5DTp76OYIOST9
         4MiRtTKwb9X+sLaTfTbTT7Jm4ElQixnvZUFikgg2Q2+2Otm7KcrghJhcr8uWc/FxOt99
         A8/Ls2lXTN3tdw4yszeBTmFo5Uq5q1JzZvxJoOuNkM9vBa4Av2QhNs/XE9nYX34cG6th
         gVHK+ZjhqQbDhah7Fob1m0HYR8h4uLkQxKzLuooNgts1RM19pWTUNgjgyUmsrgqVVF2o
         r+ta3uEpupyV2b84SGVuI0MgE1dHAA3tfuyMCTTTaglfiYXs3YBqDVXCArtHKYtCrjA2
         Eqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wzyxtCc/xljY4tUYv36NHbjTq6FZebesi/It17iHYVo=;
        fh=j515ANXRbSbYOUj9/Q6dFnYmBY4zaFHvgI/QQ5P2iMA=;
        b=l9NXkKUpvj5iq+jreKe6gpUM/Qp8mNB/1VKhgZJxevn3zYls2bPiiD4OhQNq34tR2D
         WOkv2DnhnvcwzEr7xjFdp+NP62VpS9ap3bleGkglMl628Bril/sOZ92eF6XhvTIBQGsR
         nVt6s4yHarbnC9MzOiCQyuGRi0iT1Ez1AcMd+wVFvKE8XSGPbjgAbEzslQDjt4bn7Lvj
         txYHkUCoIkzdTG5t/IGVm1DGrtOa9cEhYuPGyM6dBePKV/HYI2fo14T2gkirpNa7Izki
         V+o7gFfIJTNoJQzlAm7FE5qQcmwkB52KNVtusKN6iqBGxNigVgWFP1bqkg4h4CxaLqvs
         xetQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791211859; x=1791816659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wzyxtCc/xljY4tUYv36NHbjTq6FZebesi/It17iHYVo=;
        b=AKaOuyIw9xtWePTbrp2gtdG/GwFA1317C6uISMvp4MkcuVRlYNvt1c8Yvbo0s6ZDZ+
         5QwB0hWzePNcowvxJCsGd3OrFJZS8b6fKOvcl83qkYHP9XrOX6SfFvcapDgNr55JsC5U
         E5DV0kS7T5oo9y3zLW9pb/svLwACR6NFk0HIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211859; x=1791816659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wzyxtCc/xljY4tUYv36NHbjTq6FZebesi/It17iHYVo=;
        b=FYHzFn3i7gQdWy+vyIWfk7warvbm7SM1mMr1JVP6RcjwyC+MzbPlGAwkq68iXnIU3P
         sZXBWRecrw4W7OdlrIblHsLSOlpNh2sAUkc1WlnSAvwsXcavpM+osKjKsPj/rMQIwFkT
         CT5rYrSIv3hEN6TeWMrl88sNI6qzofiwzjO6K+E27jmi4nY5Gzag7hmduoROZaNtNbOV
         7vbW899ImdA89f9aYsFwhsC7zTql7YgbyG1QlZtN9bYx7UMMlOgcqL6/Ua2Wy5W1NeRV
         XsC2CEl6KPtfOu6ID/+l8U0xMj7afGdvddiH4WqoCFmf1owMIDrQ+jx06bSltS1DWWU6
         cxWw==
X-Forwarded-Encrypted: i=1; AKwUvBxZ30UcNvZrdUmBLQU5VY6CwoQTM76bTqow/06i6kidR2EsYBhxzU7jOXCSmZgs5i4cSwLQ/oc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLamvxaXyN7rWxPYD3I0XjOMfgU7HAMcyIfJquf8HgfZ3DxLF+o
	clfvkud5KX7r9aSyir+n4zH9VfKE9XOxpxTzCNUIvYXARLbeB80W3NUM3v7/c55iK/4xFLJpR3n
	hoYSyxnHsqawO04lRZdGXuvcnsxOrgpxZtp4Z1tZM
X-Gm-Gg: AYBFou2JhB/qMRMocJNygyIyttrKqIOCeVDXcbUeDrctNxROjxnTRboARazHyfKmyJj
	XD6kuieHpetYlNGvUWdq8eJUMP9KeDOsE/xYRzwHLMl/IldKtTCxRYuS9IidkrThgqNT+tOBXnq
	ipQdoZnFevoIl9WDJ+vwaXnsXWh5R/vCvE3hxm1aZBga6Id8y6wUYVlh58YRhgS3+VvFo0s+ZuG
	6vjtpM9LZrVtLapNJiHoeedAYXyDDcg6F1x1IxZCMcyPplrEj0c6QzNgUEo6Fa9mmyBG6Akzc7E
	SIR1UOkOUg5c6rySiQzPN5v7bpn54JuncTl9+5NvNPj4PI7czse0AN6QG9a778Jp5Dm5fGzWpv5
	f+tL2jVnjx9GYlBYYDg==
X-Received: by 2002:a17:90b:1c12:b0:3a4:9f7f:8cc1 with SMTP id
 98e67ed59e1d1-3a6ce75d149mr10175210a91.24.1791211858800; Mon, 05 Oct 2026
 07:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002200108.399258-1-mhun512@gmail.com>
In-Reply-To: <20261002200108.399258-1-mhun512@gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Mon, 5 Oct 2026 14:50:47 +0000
X-Gm-Features: AclHuK_mpqiutglUoj4b9ypzT5hG7wQQ6C7TSD5Rqh4e7VfHWJcwxGbEsSCz5v4
Message-ID: <CAMMMRMc7ZfanRcM_i8dCS+51Q5-dpTKnMvFJuEsvgF5V80iwHg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Stop altmode work
 during partner removal
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 8:01=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> wr=
ote:
>
> DisplayPort and Thunderbolt port altmodes queue work to deliver VDM
> responses. Partner removal and port teardown do not drain this work,
> allowing it to race with partner driver removal or access freed port
> altmode data.
>
> Disable and drain port altmode work in the common partner cleanup path.
> Partner drivers can still queue responses during removal, so keep the
> work disabled until they are gone. Clear pending response and DP status
> state, then re-enable it for the next connection. Cancel the work before
> unregistering port altmodes during final teardown.
>
> Allocate list nodes before registering altmodes so allocation failures
> also use the common cleanup path.
>
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>
> Fixes: dbb3fc0ffa95 ("platform/chrome: cros_ec_typec: Displayport support=
")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Quiesce port work in cros_typec_unregister_altmodes() before removing
>   partner altmodes, covering disconnects and discovery cleanup.
> - Re-enable work after resetting pending response and DP status state so
>   port altmodes remain usable after reconnecting a partner.
> - Cancel work in cros_typec_unregister_port_altmodes() during final port
>   teardown, following the review suggestion to use cancel_work_sync().
> - Allocate list bookkeeping before registering an altmode so allocation
>   failures use the common guarded cleanup path.
> - Drop the v1 Reviewed-by tag due to the reworked cleanup paths.
>
> Previous version:
> https://lore.kernel.org/all/20260917204209.97699-1-mhun512@gmail.com/
>
> Validation: apply checks, whitespace checks and static source review.
> No build or runtime testing was performed for this revision.
>
> Remaining review point: an in-flight port active sysfs callback may still
> queue work after the final cancel_work_sync(), before the port altmode
> is unregistered. Please confirm whether that ordering needs additional
> synchronization.
>
>  drivers/platform/chrome/cros_ec_typec.c      | 27 ++++++++----
>  drivers/platform/chrome/cros_typec_altmode.c | 46 ++++++++++++++++++++
>  drivers/platform/chrome/cros_typec_altmode.h |  9 ++++
>  3 files changed, 73 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 50a68819ceb7bbfbd888ca919d678d4c75237c26..2d6cbb7f51445fde4b4e83390=
81e921a9a143a92 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -282,11 +282,19 @@ static void cros_typec_unregister_altmodes(struct c=
ros_typec_data *typec, int po
>         struct list_head *head;
>
>         head =3D is_partner ? &port->partner_mode_list : &port->plug_mode=
_list;
> +       /* Partner drivers can queue port work until their removal comple=
tes. */
> +       if (is_partner)
> +               cros_typec_altmodes_set_enabled(port, false);
> +
>         list_for_each_entry_safe(node, tmp, head, list) {
>                 list_del(&node->list);
>                 typec_unregister_altmode(node->amode);
>                 devm_kfree(typec->dev, node);
>         }
> +
> +       /* Port altmodes are reused when a partner reconnects. */
> +       if (is_partner)
> +               cros_typec_altmodes_set_enabled(port, true);

Have you considered fetching the port's altmode using
typec_altmode_get_partner()?

        const struct typec_altmode *pdev =3D
typec_altmode_get_partner(node->amode);
        if (pdev)
                cros_typec_enable_altmode(pdev, true/false);

This allows implement cros_typec_enable_altmode() eliminating
unnecessary checks and the additional loop:

        struct cros_typec_dp_data *dp_data =3D typec_altmode_get_drvdata(al=
t);
        if (enable)
               enable_work(&dp_data->adata.work);
        else
               disable_work_sync(&dp_data->adata.work);

>  }
>
>  /*
> @@ -366,8 +374,10 @@ static void cros_typec_unregister_port_altmodes(stru=
ct cros_typec_port *port)
>  {
>         int i;
>
> -       for (i =3D 0; i < CROS_EC_ALTMODE_MAX; i++)
> +       for (i =3D 0; i < CROS_EC_ALTMODE_MAX; i++) {
> +               cros_typec_altmode_cancel(port->port_altmode[i]);

That won't be necessary, as the work queue is already canceled in
cros_typec_unregister_altmodes().

>                 typec_unregister_altmode(port->port_altmode[i]);
> +       }
>  }
>
>  static void cros_unregister_ports(struct cros_typec_data *typec)
> @@ -901,24 +911,23 @@ static int cros_typec_register_altmodes(struct cros=
_typec_data *typec, int port_
>                         desc.mode =3D j + 1;
>                         desc.vdo =3D sop_disc->svids[i].mode_vdo[j];
>
> +                       node =3D devm_kzalloc(typec->dev, sizeof(*node), =
GFP_KERNEL);
> +                       if (!node) {
> +                               ret =3D -ENOMEM;
> +                               goto err_cleanup;
> +                       }
> +
>                         if (is_partner)
>                                 amode =3D typec_partner_register_altmode(=
port->partner, &desc);
>                         else
>                                 amode =3D typec_plug_register_altmode(por=
t->plug, &desc);
>
>                         if (IS_ERR(amode)) {
> +                               devm_kfree(typec->dev, node);
>                                 ret =3D PTR_ERR(amode);
>                                 goto err_cleanup;
>                         }
>
> -                       /* If no memory is available we should unregister=
 and exit. */
> -                       node =3D devm_kzalloc(typec->dev, sizeof(*node), =
GFP_KERNEL);
> -                       if (!node) {
> -                               ret =3D -ENOMEM;
> -                               typec_unregister_altmode(amode);
> -                               goto err_cleanup;
> -                       }
> -

Do we really need this?

Thanks,
Andrei

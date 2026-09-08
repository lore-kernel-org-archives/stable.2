Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA257C72A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906079; cv=pass; b=kDcMT3P/8tnH2ZnUiZlc76QM8JbkRttRTAhSGsIxYzWrnmNPXQH0QbsajoAVONULUQyLQCJHQHOChpnwrwY43EqXNmsuIhaAIfHtS+iL5gSkVRTkfJK5WRP74zMNNby3ieXOCAZr9xrNaabxttT87IT1hcARafeGCeW8sffMiWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906079; c=relaxed/simple;
	bh=PkxK1hRJN11m8LSNX96hQF3MGEKXyL4gSEwSGL4thvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPr/7JIGqfYCI3OqjkfRz6oMwnonR8rg1C7GhjMvy17W8kU+zVqqUqHmE23aN0HCQ+UcK/NRJMRJsF7dQD6tREdjWPhtCZtaClqkPg1Y3p6Mx5HgiRyulTZ1lxt2g+5sNhxeUu7sGP+pGyhifY7k9hrwuloT/J28ZegAiBeN4+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2ZgyroH; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2ZgyroH"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c255c58156bso1046425566b.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 15:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788906076; cv=none;
        d=google.com; s=arc-20260327;
        b=DCh7rIJcFTi+pojOvCh4XjQVfbzUjTqMIWvs9oPM+O2XMgDogFBwflPSCUx975tZJM
         aBAExYRTupXa+PC9Ue+ZKMzKmFJ6uPUCLFZddo4S5RniOMf/XZzkS4Ul1JO104cWZ79J
         6RHWsfSQOsXUNRVzaDFBLd9WaB/XD4VzJxL99YnPTzSsS03Ufqzls5ME/J1qsFP7XFfd
         jhSthyp3MghmnZMUO4ig0rCvzUbP8i2rWZklHKp5z8YjqmIMfTsidnvY4T4H+0egtMUm
         QMie3rBA75cQebJlrS2noMQmUyV0F4xSV9ZRc0W0btgi3k20Zp5oQhW4I+ZJa/o3Zm6n
         42Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qjq2CIi3STsQo1+yNK5BNbmq6h6MKRnygZeJmqARTMs=;
        fh=p5iQxMOAwvkYnb1y3bXz/5W5NYM663ui2viL96d/b0g=;
        b=kOPNokzaa1ePrylGYiZOnfNpApTXHBhuINlex+DTNeK3e+FoRNNh1NWTzZeL+ceXuc
         L7m43kEJPeMQ8LGcsVFLHSieEtoGWWVQB85z3CJrZl0qh2Ilu9xJNP+PItfWjRhY0cTB
         B+Cp1GMS3uKV9PBBAznKkB/oanr/hnCfWfTa7TpOjioyh9c3IuG8qwFeAXf/XH8Lom4I
         xphY1wvyDjg/3Yfhns2hkelqIfI7Z2MbHVJqMj/LiNujs4+pqx84w9tuqOYfNiaYmYF9
         0Aj1alrUokQe9Cn36rE/dXwEZXZcpB6SqXeqG/JlMViPlh2BQzUajt8hz7QdKFWJHJqu
         uWLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788906076; x=1789510876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qjq2CIi3STsQo1+yNK5BNbmq6h6MKRnygZeJmqARTMs=;
        b=e2ZgyroHVZJXmeiiqHTsJrKypdDpICBPVHM2DlMI35IDmW/c8B+pHucUQaI66jAFVd
         G3iE3kLiGC/ipSldj5/beofrESRsHrCjHsDEwIGHhGrdkVyh+yZFyAAZgqvFzFSktK/y
         F7Anzpc95uwQYWpzXh8jYgzctuX0eHBYn+xGNr3olFBiqV0scfsVerObWHxsLUqJY0xj
         oI1bTgs+YVtHIYgYCSAQxapFSn8auhI/3muEA6z81u84LTOO0jQ1/eSyZwUKHv6lLGqC
         B/YPSCBXvZVP410DkzEiZ1+PLFB/BNle0Fr+Ddrp5j3dQaF1YCviBXND1/qSRq114RLt
         zm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906076; x=1789510876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjq2CIi3STsQo1+yNK5BNbmq6h6MKRnygZeJmqARTMs=;
        b=DeKK9PxisGL1ObZfL7EWGlLMw60DGwPz/lz+GNOW/FQCsRnZMhSUcg6U6DbJNaeq9p
         gEOGS8NApm+LOuqdpIDhM0PncFtfkaVw26Yxp/Vhgi8BmJIRWEYhJVmv/6/7psAA4p3i
         7zgWjN7ZQd0IPUgdwxPgyznpcomX06qg7sCN7gMwZ/bgRyMUL4PpR/uyXDlYWULO3LCn
         278gyijgqtGsgLcxZH2oy06jLq/cD9o33N9cj8bwL52N4M0+ixUvjN2z4UNJHVJ1vCGS
         l/pHSbIcCH2TEZp7mqc01RkYM2zQW3FzSfsJSzD+AYHNaVhVRp4uAYuP0ask9vc8tDYM
         NQQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBuODCt2nNZYh5ExaeV41yYPOnGOMnFsUr4xKSv2EDclyPxRD0sJy2262EAtYussDl+AXnoJA=@vger.kernel.org
X-Gm-Message-State: AFuF++lzcG+Jps01vTpg8z619JAFhVLKWpseAQuBde7I4q8Q2vBBp7wW
	rShOJV/4N8Imi/oUwOHVMx9qnDCh9D6SK3bNeynGDf9PZuG5RRpFhlu4qcQosUXwqTTNwTLIbnm
	RokBHX4qwyXcwiE/DsMf1NFzt/hOFMJg=
X-Gm-Gg: AYBFou18FY9oxg0ltPyPTnpxvsO5jT+OVs3/x0f4QP5kr2vlXcCuioGl8hLPK0h+GjK
	fUB7LAapahDi97yfcok6IlQvVe+rLbP7YqZ1HvY2g+CjP2O4E2oDCxU4Pit/jWuxew/BPTy/pp3
	UXs84KguE6+asQHLe/InX29HOGYhyh4B4DETWpeh+4/DLfKxYg43ij+j/dpINfEYPqHDxrQo9BM
	tZiz33EEhQLqoH42OnxYT8PAk6+zXO3xZzv1KucUDjV/YxZLhrVeE54fgChXN8NONSfDXDJ/nOL
	EuXSCuq8YGG+nbu1LNGuLLiWloFIkiR48W/xr4lGbhk+N7H9DHI+CbODVbIuB8fk6aotK66/1lg
	aAg==
X-Received: by 2002:a17:907:720f:b0:c1c:4a80:30c4 with SMTP id
 a640c23a62f3a-c260c988d9emr1294985866b.11.1788906075748; Tue, 08 Sep 2026
 15:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902134417.1270552-1-lee@kernel.org> <20260902134417.1270552-2-lee@kernel.org>
In-Reply-To: <20260902134417.1270552-2-lee@kernel.org>
From: Ping Cheng <pinglinux@gmail.com>
Date: Tue, 8 Sep 2026 15:20:17 -0700
X-Gm-Features: AcwNN1Wp-SB8HDOgT9DMxkuas3yoEcqiqAhEPsH8sFiI8oT1AfpfDmoXm_j06yQ
Message-ID: <CAF8JNhJTZ8t_MaopSihkiDZgadhdphKJirDzqjNb9+5dTeH8Nw@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested the devices that I can reach, mainly the ones released in the
past 10 years or so. The tablets all worked. No crashes whatsoever. I
am comfortable to give the whole set of this version an acked-by and a
tested-by to help it move forward.

Acked-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>

With that said, the SW_MUTE_DEVICE capability assigned through a
softkey is not properly recognized. I've figured out the root cause. I
will submit a patch after this set is merged. The main value of this
set is to resolve the Use-After-Free issue and the redesign of the
shared sibling data lifecycle. The individual softkey feature can be
addressed separately.

Hope my testing results make the maintainers feel comfortable too.

Thank you,
Ping

On Wed, Sep 2, 2026 at 8:20=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Input subsystem guidelines require that device capabilities are advertise=
d
> before the input device is registered.  The Wacom driver was violating
> this by advertising the SW_MUTE_DEVICE capability post-registration in
> wacom_set_shared_values() (and duplicating it in device-specific setup
> cases).
>
> Resolve this by moving the SW_MUTE_DEVICE capability setup to
> wacom_setup_touch_input_capabilities() for all touch devices that support
> it.
>
> For generic touch devices whose capabilities depend on mute switch
> usages parsed from a sibling Pen/Pad interface, defer registration
> with -EPROBE_DEFER until the sibling has parsed its descriptors and
> initialized shared capabilities.
>
> Cc: stable@vger.kernel.org
> Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's reque=
st
> v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch devic=
es
> v6 -> v7: Only advertise SW_MUTE_DEVICE on composite USB generic touch de=
vices
> v7 -> v8: Replace heuristic with probe deferral until sibling Pen/Pad is =
parsed
>           Split out 'hdev->product' cleanups into a separate standalone p=
atch
> v8 -> v9: Fix TOCTOU race by assigning shared sibling pointers in wacom_s=
et_shared_values()
>           Support Pad interfaces in sibling deferral logic
>
>  drivers/hid/wacom_sys.c | 68 ++++++++++++++++++++++++++++++-----------
>  drivers/hid/wacom_wac.c |  4 +++
>  2 files changed, 55 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f7..026a6be467d3 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -912,14 +912,6 @@ static int wacom_add_shared_data(struct hid_device *=
hdev)
>         wacom_wac->shared =3D &data->shared;
>
>         retval =3D devm_add_action_or_reset(&hdev->dev, wacom_remove_shar=
ed_data, wacom);
> -       if (retval)
> -               return retval;
> -
> -       if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
> -               wacom_wac->shared->touch =3D hdev;
> -       else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
> -               wacom_wac->shared->pen =3D hdev;
> -
>         return retval;
>  }
>
> @@ -2343,10 +2335,7 @@ static void wacom_release_resources(struct wacom *=
wacom)
>
>  static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
>  {
> -       if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
> -               wacom_wac->shared->type =3D wacom_wac->features.type;
> -               wacom_wac->shared->touch_input =3D wacom_wac->touch_input=
;
> -       }
> +       struct wacom *wacom =3D container_of(wacom_wac, struct wacom, wac=
om_wac);
>
>         if (wacom_wac->has_mute_touch_switch) {
>                 wacom_wac->shared->has_mute_touch_switch =3D true;
> @@ -2359,14 +2348,54 @@ static void wacom_set_shared_values(struct wacom_=
wac *wacom_wac)
>                         wacom_wac->shared->is_touch_on =3D true;
>         }
>
> -       if (wacom_wac->shared->has_mute_touch_switch &&
> -           wacom_wac->shared->touch_input) {
> -               set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> -               input_set_capability(wacom_wac->shared->touch_input, EV_S=
W,
> -                                    SW_MUTE_DEVICE);
> +       if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
> +               wacom_wac->shared->type =3D wacom_wac->features.type;
> +               wacom_wac->shared->touch_input =3D wacom_wac->touch_input=
;
> +               wacom_wac->shared->touch =3D wacom->hdev;
> +       } else if (wacom_wac->features.device_type &
> +                  (WACOM_DEVICETYPE_PEN | WACOM_DEVICETYPE_PAD)) {
> +               wacom_wac->shared->pen =3D wacom->hdev;
>         }
>  }
>
> +static bool wacom_sibling_pending(struct wacom *wacom)
> +{
> +       struct hid_device *hdev =3D wacom->hdev;
> +       const struct wacom_features *features =3D &wacom->wacom_wac.featu=
res;
> +       struct usb_host_config *actconfig;
> +       int i;
> +
> +       if (features->type !=3D HID_GENERIC ||
> +           !(features->device_type & WACOM_DEVICETYPE_TOUCH))
> +               return false;
> +
> +       if (wacom->wacom_wac.shared &&
> +           rcu_access_pointer(wacom->wacom_wac.shared->pen))
> +               return false;
> +
> +       if (!hid_is_usb(hdev) || !wacom->usbdev)
> +               return false;
> +
> +       if (features->oPid !=3D HID_ANY_ID && features->oPid !=3D 0)
> +               return true;
> +
> +       actconfig =3D wacom->usbdev->actconfig;
> +       if (actconfig && actconfig->desc.bNumInterfaces > 1) {
> +               for (i =3D 0; i < actconfig->desc.bNumInterfaces; i++) {
> +                       struct usb_interface *sibling_intf =3D actconfig-=
>interface[i];
> +
> +                       if (!sibling_intf || sibling_intf =3D=3D wacom->i=
ntf)
> +                               continue;
> +
> +                       if (sibling_intf->cur_altsetting->desc.bInterface=
Class =3D=3D
> +                           USB_INTERFACE_CLASS_HID)
> +                               return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
>  {
>         struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
> @@ -2444,6 +2473,11 @@ static int wacom_parse_and_register(struct wacom *=
wacom, bool wireless)
>         if (error)
>                 goto fail;
>
> +       if (wacom_sibling_pending(wacom)) {
> +               error =3D -EPROBE_DEFER;
> +               goto fail;
> +       }
> +
>         error =3D wacom_setup_inputs(wacom);
>         if (error)
>                 goto fail;
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 4436faf2d2bb..a7e3817aa2c4 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3965,6 +3965,10 @@ int wacom_setup_touch_input_capabilities(struct in=
put_dev *input_dev,
>
>         if (features->type =3D=3D HID_GENERIC) {
>                 hid_dbg(hdev, "generic touch setup\n");
> +               if (wacom_wac->shared && wacom_wac->shared->has_mute_touc=
h_switch) {
> +                       input_set_capability(input_dev, EV_SW, SW_MUTE_DE=
VICE);
> +                       wacom_wac->has_mute_touch_switch =3D true;
> +               }
>                 /* setup has already been done */
>                 return 0;
>         }
> --
> 2.55.0.966.g6673acef38-goog
>
>

Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD2599A4B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066407; cv=pass; b=USADnR/UylYNII/N5A+VJ7wOdDt5HqyTnDSjje2ozmbuoKljMlHroAmFHflqZnB3uHG8OHrt01m+N8YSN0lz/wo36YGXizuBS8fFDNZ6MJPrqeRugpPwhGl8QEJLV52Du/OnuufqbR0dqTUqgY3cTo2Lc1H/c3cfL0J5oP12iGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066407; c=relaxed/simple;
	bh=VvXoNF3sMeo2fpv2qDY0aBbxOZBUbISC5Fqd+S82nYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4mWThniIZXrMeCkp262c3KdroyHC8Q6X0SmCCXQPDTEV4pcLGUJmb47X+iu5VDZ4e4E/WhVidOyrurake4KdlmrARfedzkISOlRwGR7HuOxMEQTG7ub3Dt3WL5Gng6XQ4wYaI7Yxa/Qtu0Cwrs6+yHzhQTk/07K/IM3eAwZkgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMdhZ8K3; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMdhZ8K3"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso26933266b.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789066397; cv=none;
        d=google.com; s=arc-20260327;
        b=c49LKDbosUaED+2ExJWfJ65zaMl6BrdBzuAZK2BC8ZEzhXmKXOPyscrhTABN8p47sn
         ZzEhak89k+WnPgkKBQZtKvsYorUkg4juj7oGa4RoZe1guxYWdliiQ6xvvdygANMRfPy8
         iYcSIKx7N/R3x4zngOGPGjIxiEyA/m7X3CBhhZBP7VOIo2mqvcdkZ7mfSrV/yTCc9Z+P
         IKp2JKtB+MCvryCFMRD43PhMfeDcEO0+DKcm92BrK35bdQsBxf0jaHIYh1RYo/enlFOL
         uQ+a0F9l0j2lv+vA60DBjbHFlrF3U5IbpZf4oxK/PrvFGtdXT96+xARPqGZS77nphr5U
         ynWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJedgFbA0a5dZ7UM3Qt2A8RF0LRRqtbYOuDEXTxhdkg=;
        fh=0DUqw9ArmJvNusF60JCqDoNH/tSSekXj8HXW6kZUbb0=;
        b=p+Yj1td1T6rB6izCNtqvJVez3uVuSRkaIUn7uY8A5Zlr3QcKnDcKEF//G+A+uasHLn
         /kI9NNoR8klikLN79leY0FZ6EMPXitFJ2ele0jpWdHRtFBDB2JidN635iGaD7tw14a/Z
         nFvBAdMlYMgPhuMK6zTfyoJ2ngM+BK8AMqz1ddWMZNGdhNWwhyDuXeywcpOCh+oKsBMw
         hiNY16g3p9iFOQxdLX7er573zKcon3HfMhkCXC8x12A6OUwUJs/9zTe900/bXhYliU58
         SaQH7dsOpcmbjs0JI7AVSsEhscHMiMakkm6bE2DqzzQgvlwj8XP6T/x7WD2TdabxbZX6
         t0rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066397; x=1789671197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJedgFbA0a5dZ7UM3Qt2A8RF0LRRqtbYOuDEXTxhdkg=;
        b=AMdhZ8K3Z/qcyQ0KXyhN9VufTLn54TfCpOZV4MHMe2MQRHj0s/b9KJqeT7sPyQOIXo
         JkfnshlGeOLSvYdZwn8fz/lJebqKRGPNrew5AgwQ5umh6X5l967lgkyFw2sL/YdifmNB
         0TvZM9pgkKlcSmH3UKZdfIN5n4qt7eU9xMgOC4xdsUxaVvqUFlxvItUShsN3bRi0zhFS
         3igpwt5MFVmLZ8D0Ub4qa56ngpjr/XI9iBaj09BFtWvflQTl0SuKE/IrW3sfJZnKmPQb
         Ftds0Vt6lKiyz5bSYtefWcfLqtbHBI6Ch/7OrwVbzAQcJCpR7ZfFjUelGEtgjTAb+W7k
         PxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066397; x=1789671197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJedgFbA0a5dZ7UM3Qt2A8RF0LRRqtbYOuDEXTxhdkg=;
        b=WZcVGtwsl8P036lE25i2Ra3D2uOH4dbXI39DvW2ftDE+ox3Clq+V0Ie6NKk16p1wBi
         lny9bsJJRdueZZr+IxutxexpeRheZWQQpjeAICH+fAubdqVBdznyWhCukpze+5dRi0YP
         XnRPdj/yMYwlbz0iaz9m+A5Oanp7G4eyPMD2kAB2X4Q3O1LwMiqk7rNH3/sYI+pyNkx3
         /83YekyRlE0VRiRIXWAWUNCGYiDaP2Fipa6Cj1bSAj1TFxOeAht7XOzE9MTn6k+Zw7l6
         hfbgSq+5SMrun4SoWqX36oR+42nFNkmzTkAWfSK165g1Wb265URkmOCHdSejN5vGugu7
         LE/A==
X-Forwarded-Encrypted: i=1; AKwUvBw1PQhpHw47fZgggi9iueMLc73zik6XpRzB/pQXIe+OF10AyKkFXW7gp6v+lVLxM45X+a0nYaY=@vger.kernel.org
X-Gm-Message-State: AFuF++kJnehf4TwZuauv0VfkCjvjYtyOW2VXhydVtPvhJZWGu6DXpMnc
	dKCPzHH4flaf9czSADUchCFMJx7O9jvyl27dTlKbwZ+Uz4KGAW3+IJMmAGevx7OC4AoVQmBPCbx
	5QmnxljpB3xBjbH+0czvELbu0wJuR8KA=
X-Gm-Gg: AYBFou2D7gCZ3Ljzvs+KTqj6km1OQy82Cf9tPp+sy6juZTIsSpPSuoaStGTEa1q+sxY
	xJx8LuO8ZGcxVhOFZxVjRl2o+H9w2KPylZiZ8nx0cb9QtfXIy2KX0+YLdNENBVC8V40ubchlYvD
	Y5+1fcnHeUbge5ovDmKXranPnWtBt12MWbj91tS50tN7n8OMWYnowUEQyIh61DeExyntA2yEYY+
	cALfAZCazNg5n+x/uOb3yLoSdLtAfLkO1BqCr2zmHWeo5ZbLxf3lw9IP0KEeJM9NrniBw4IgvWv
	YVIkUcjw2Cug6Knknn+E6l6onddL3H9bpD30IKKZGafTAacoPJk/ofXMVj32daX+1Z7Tz1tCXzi
	N02BM4jaAAW6W
X-Received: by 2002:a17:907:97cd:b0:c25:b706:e59 with SMTP id
 a640c23a62f3a-c29666f49e8mr191366b.17.1789066397017; Thu, 10 Sep 2026
 11:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
In-Reply-To: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
From: Ping Cheng <pinglinux@gmail.com>
Date: Thu, 10 Sep 2026 11:53:05 -0700
X-Gm-Features: AcwNN1WtBzIj10yYVWNSv1D2MgnrM6PZMOlbKADR-R4JWexEKJoN-9DMVJ_y5ok
Message-ID: <CAF8JNhKJES5xkXd4VQxwp_sV_jUsgLsqFz+OJADL0-neY-W1Cg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Aaron Skomra <aaron.skomra@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested the whole set of v10. Status stays the same:

Acked-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

On Wed, Sep 9, 2026 at 4:27=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Replace the lookup-dependent 'wacom_wac->shared->touch->product' referenc=
es
> with 'hdev->product' inside wacom_setup_touch_input_capabilities() since
> 'hdev' is already available (via container_of) and represents the touch
> device itself.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v7 -> v8:  New patch
> v8 -> v9:  No change
> v9 -> v10: No change
>
>  drivers/hid/wacom_wac.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8feb8027be95..7cf2b4de52be 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3966,8 +3966,8 @@ int wacom_setup_pen_input_capabilities(struct input=
_dev *input_dev,
>  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>                                          struct wacom_wac *wacom_wac)
>  {
> +       struct hid_device *hdev =3D container_of(wacom_wac, struct wacom,=
 wacom_wac)->hdev;
>         struct wacom_features *features =3D &wacom_wac->features;
> -
>         if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
>                 return -ENODEV;
>
> @@ -3976,9 +3976,11 @@ int wacom_setup_touch_input_capabilities(struct in=
put_dev *input_dev,
>         else
>                 __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>
> -       if (features->type =3D=3D HID_GENERIC)
> +       if (features->type =3D=3D HID_GENERIC) {
> +               hid_dbg(hdev, "generic touch setup\n");
>                 /* setup has already been done */
>                 return 0;
> +       }
>
>         input_dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>         __set_bit(BTN_TOUCH, input_dev->keybit);
> @@ -4010,19 +4012,17 @@ int wacom_setup_touch_input_capabilities(struct i=
nput_dev *input_dev,
>                 input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
>                 __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>
> -               if (wacom_wac->shared->touch->product =3D=3D 0x361) {
> +               if (hdev->product =3D=3D 0x361) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 12440, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
>                                              0, 8640, 4, 0);
> -               }
> -               else if (wacom_wac->shared->touch->product =3D=3D 0x360) =
{
> +               } else if (hdev->product =3D=3D 0x360) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 8960, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
>                                              0, 5920, 4, 0);
> -               }
> -               else if (wacom_wac->shared->touch->product =3D=3D 0x393) =
{
> +               } else if (hdev->product =3D=3D 0x393) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 6400, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> @@ -4052,8 +4052,8 @@ int wacom_setup_touch_input_capabilities(struct inp=
ut_dev *input_dev,
>                 fallthrough;
>
>         case WACOM_27QHDT:
> -               if (wacom_wac->shared->touch->product =3D=3D 0x32C ||
> -                   wacom_wac->shared->touch->product =3D=3D 0xF6) {
> +               if (hdev->product =3D=3D 0x32C ||
> +                   hdev->product =3D=3D 0xF6) {
>                         input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
>                         __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>                         wacom_wac->has_mute_touch_switch =3D true;
> --
> 2.55.0.979.g7e5102b832-goog
>
>

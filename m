Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBA18DB26
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581727; cv=pass; b=uPOHxP2EMSUbF7f54x6a4w7akwNoX338aHmuwOuQ29w9ZVEtAY2dq0BX8DH00jhAiFwbp2FgnDDZv2M8zZlEjGVc1RLVwsPVGphVsuTATCbS3Rsye/UjsIXk8CFFnsWRBwPojrJ1ORPELBHF6vkpC3qSDRS2qtGKSvG115X3QZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581727; c=relaxed/simple;
	bh=jXSal8mmPLMLYM3sucEZPr6s4xK+MWEBsNqwtDllzlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXqBhTRN89iaplOYKdJGM+U0OC9oWlSVhTRWWTBT19NSr18XJNYTontO17LPXF0JflOLdYaPDRTtq9laeeXcinAcwEIB6SwcBabt4ExDPUpFWO+SbIytXRkSQxm2UpJ/BBsNEBIv3Chjg1FOZmzS/1cN+DGrY0dvCafaJjLBFxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOWwZcin; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOWwZcin"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66d0c8d0d6eso531949d50.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 07:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787581725; cv=none;
        d=google.com; s=arc-20260327;
        b=Ft9poh+a8rwPCD/D1PfCwsE/Tqt0BHUQZZEvnVOeWPPHQmuhcHShjWfrpX9PtBj63Z
         i9LzQ6em+SZV4HIfNY3Y8VeiddnfKBKd1DpU/cDBtnzlUhn7HMw76D/iMvBWGSeOq8/O
         fV+CpSqFf1CGEL08lWkD/pRS3ubXF9olB4ZNHsZXR7jAIsZRG5RyhORikSpRndo1pK07
         12U9nsjKKR9BKO4V6Xd8bOfqdL9vGueON7DEgvZVmWGe8LywxlWp4+tYLGOD5E/FLEOA
         wprbaclT1enuVorDVCQwKdp9F1JFbVObBi44vV/QUyVr0jW5fCgZQZlqzStaApYxuhps
         ZSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CQ5UQMtAkeiSiALFgG4dHFcznmeucSwr2O+KBNTV3xw=;
        fh=YqaTp4PUoagPbi+cVoy0btJLxdyBHQt3FEIyhh6iNlI=;
        b=FDl0Jz2nEz7ifPijj+bMKp25Yig9/qLqD45PIEKRDa+MG6l3N5xg/yY1hmY3wQoW5Y
         KwPYqR5Ddhq8V7SHXvEN9o5xL2zcV9aCZ75fskokua+TxaR0smrxT/fdCjx3PqJW6yaq
         NgBg23rXoW+KnmoVrIV7yB5PEYksc7b+u9nCQ3J9Ys9yAhY5VLyoJNN2mgTUt2AhX9rN
         KnZxgbJhX8e0+Pc/yx35hS4JBiWZFcmoRn9iIiQGjeMO6k6HCIRS2eDxJVfSMgwXWNFM
         ZHL4WPiHzwJsPsSa3JgR/gdQx0rvA0ucCBCU/80nyB082blcGORwuSjkPYamDQIAUL3Q
         UuTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787581725; x=1788186525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CQ5UQMtAkeiSiALFgG4dHFcznmeucSwr2O+KBNTV3xw=;
        b=pOWwZcinI363Px96KWrOTgCAOwAYrap3suD/bIY5ImUcR99LmaO9BvkZbAnav10QVz
         XJGxUZ+qnbwKkm3obkLwlNULCYFIJhwDb2AWs5x11dqXp74u58kpZTBsO5OBtd6cqRuv
         ot6ILeVEFskt/xq/tjiFIWpd0ku1+Pe5/SOGsicmdAroTLmlS553sN1Hdyx5uaaSVooP
         JvMfE467OYlFayUKBWy5MhX7alOVPsX1wjkxh08hVf8vIZVE57LwaklkJcIypB+xfZkP
         hpU9+7q1k8I8i0QpM9zPOJgbGM+j2h76GfIrb8oAWciByo2cYGzhI8GmUs80c3ZgXj8a
         AgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581725; x=1788186525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQ5UQMtAkeiSiALFgG4dHFcznmeucSwr2O+KBNTV3xw=;
        b=d3FlLzXQ/3g8byNI3GU5Zbz81v/8zo3JVlB4SaocH1dAZhRvAxjD+gaTg4vR6m+sdH
         sXB4EtWvmq9WeZ4Jp8zEsdtyLJlpPPF7cnQWEhgtQ0QEERJ0f7LkNrExf5K+s4Cr8scE
         +UGJSv5b+42lE4ZSN7iwXBOo5LXgGC/p9RCmuMlK4Kyf+qY5N5L6ntUEcsolrjbZWh2d
         I82f7SNlx2+t3dJqG2rTsmyCbSdInWutJtP2ZZHTFDnu5UJxppKF62ujiQhbTi0K9wB7
         z3Hs5rQM2nAbtmlYpT50MaNJKTCYum96f6U6wh0/n6Htbytx1xUrK0D+dcy/N6X9Ld9G
         kyBA==
X-Forwarded-Encrypted: i=1; AHgh+Roo94/nDNUQTIgd8fcgxb3koU1v8URa+Q5r0k9caQN0224Vc3x+WfR5Xmoszzx8sA+3p4zgC/U=@vger.kernel.org
X-Gm-Message-State: AFuF++l6VWvNykQ+yYIfKngFKFjBBkFufaguIv4mY0t5aEeVBDn84TAl
	0ockZNc/1xS1Y+0TDC9aPGK4ftv6trzoFVn7ipNg1f7kqdt9UX+t7uJEK6SgoMIyol3SQAU4WX8
	Xb1SIPkN1MgF5DY7Vjh7L1ZambivJ8kA=
X-Gm-Gg: AR+sD11e+99tQEPVbh/SZc1Ax0TNM9SmD66pw6mbr8ko6MWyX5HMGFKUnYfbwvcySpS
	QBJPdzUH+Adhup/RIXmq74VyjaGdItFGp5oQn9IQ9tOh88HEYRttIT++3xk/ncx5WJDNE+iQPAa
	XpJIIbc9j3zIyVtM9YvDEBMM/QttYtye0F+z/+z4g3YjAbatwf4BTY/OfWbRBW68mwcHFS92x+d
	e5bh3t0ZvPlxqRJBSO8CzacdoZo8YZYXOYSs1HulBXwBhiavSscT3lwn0xy/P7Qv/JTrohU/4BK
	OCccRM7DxNuCPJJt1tsJlOZ/xLjEHlaBtlFZdj7uo31yt6QSx4PhEbnoMzi4Tu0QufNu+I6ct7v
	S6+gxmlc2+85slXNYG5FbuMyU1MM1
X-Received: by 2002:a53:b851:0:b0:667:e855:eccb with SMTP id
 956f58d0204a3-66ce4a63badmr6512693d50.20.1787581724681; Mon, 24 Aug 2026
 07:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Aug 2026 10:28:33 -0400
X-Gm-Features: AcwNN1X92HK-jWCscnHRPBBP8bYoNeBGWBlJBbzIRxHgThuSAl_NogVENm2OBlU
Message-ID: <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laxman,

On Sun, Aug 23, 2026 at 12:16=E2=80=AFPM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:
>
> The Read Local Supported Codecs parsers consume the variable-sized
> standard codec array before parsing the vendor codec count.  Although the
> initial reply-size check includes a vendor count byte in the fixed layout=
,
> it does not guarantee that the byte remains after the standard codec arra=
y.
>
> If a controller reply ends immediately after that array, calculating the
> vendor codec array size reads vnd_codecs->num beyond the skb data.  Requi=
re
> the vendor codec header to be present before using its count in both
> command variants.
>
> Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cach=
e details")
> Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Cod=
ecs V2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
> ---
>  net/bluetooth/hci_codec.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
> index 5bc5003c387c..99394a3348c7 100644
> --- a/net/bluetooth/hci_codec.c
> +++ b/net/bluetooth/hci_codec.c
> @@ -165,6 +165,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
>                  + sizeof(std_codecs->num));
>
>         vnd_codecs =3D (void *)skb->data;
> +       if (skb->len < sizeof(*vnd_codecs))
> +               goto error;

If Im not mistake the following code already validates skb->len:

/* validate vendor codecs length before accessing */
if (skb->len <
   flex_array_size(vnd_codecs, codec, vnd_codecs->num)
   + sizeof(vnd_codecs->num))
goto error;

sizeof(vnd_codecs->num) is equivalent to what you are proposing with
sizeof(*vnd_codecs), so this doesn't fix anything it just duplicates
the testing for the minimal size.

>         /* validate vendor codecs length before accessing */
>         if (skb->len <
> @@ -233,6 +235,8 @@ void hci_read_supported_codecs_v2(struct hci_dev *hde=
v)
>                  + sizeof(std_codecs->num));
>
>         vnd_codecs =3D (void *)skb->data;
> +       if (skb->len < sizeof(*vnd_codecs))
> +               goto error;
>
>         /* check for payload data length before accessing */
>         if (skb->len <
> --
> 2.50.1



--=20
Luiz Augusto von Dentz

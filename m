Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793112716;
	b=jd4C6jjLP9sj37sDAMYCFBfiMglcxVpef9U1HFg1e/wkN7hKRkfYsonHxXaCrw325aJS
	 33nqAoM4ZrZ4FRWlo/NUiM2hNOAI2OWT0OyaR6KT7hZb6cJ23Z3ssNIHnrF609YhKAhpY
	 QnLp567h1KpKcqI9/VxNHpH7flBfRKD4PJPRKf5uTCGWNn8o12uyT3mXUwtWqwFzRYGdW
	 5j2V+ETXr6mIQ+Ntb8bHfI7Tusgh3Lug3CtQPHd//CkYVxhpRZ4E8UbhHx9qyuinkcK+k
	 SmzbvEJjj4DOf1Zlv+EoRZMUJuvtZ37aGUU+95yELhpa5wI4HjcBhBMAyuQQhPiFVrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JsUBZH84qc3OTom1l1zp1cwnDHudQ8Nvi9ycgLruS7U=;
	b=XUdYXE6MNv/btUKPDfrXlIdcax6J5wcqkxioNkTznO8k8qsZJYVeFYSGj7vl8naqzdsV
	 sulcPkeUA/3CjIWCAi1F2YO2dm4nMK7gxb0LnIYK/ZfsSwo1uI00E0gsJITaoeB7zq2Mj
	 Rmj6Svm2NR/qWMDQiKrnLIgsaERMCBeZvFXIw85MHB0Tk2cmBD5IbzI1OX2w5hk7CpUJ8
	 SUY8TKeA8+CEI+QDAuowwW979EkWkvztaOiOl4QXE44xFt9TdhmEES327jR22wN7iZ5P8
	 owAFP6RZvsfJLVrsEAmWghppW1TxGLYwq+mTEyypePfJ4Vzh7LckTRtwo4ftawijtIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Te39WAmY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3264606A326
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3264606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Te39WAmY
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd61a2dfd7aso5307a12.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793112715; cv=none;
        d=google.com; s=arc-20260327;
        b=Qtz+m5KToTeO8vqdCLLT8JUo7t1KQAISBvYu9pROyD+N9cNikR00jMdrOnAG/Zj35W
         HCS3/UCSjXgZuD2opAZhTBZ+1nrEK27DPgAVPEp937Qf2u3nzDif1wUeCDRCo23Tma67
         MqqOQM/y3P+evoArtrLy3qmqV4CZCyPJ6705n4MdoXqNL1SaWRGhBBtHziv2nUM7Let0
         a9DYh33EChnJsbAgKLErqXNzj0RPhLP5mABTJlVSlnAfEmRoOeUVH088H6UMCJv1a/oK
         0cu718HDzbW+nGzo2ewqZp/emhOm4rkS6/LiABGWCfI9vy33w+YNE7ggUjoUHsHHzckb
         g/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JsUBZH84qc3OTom1l1zp1cwnDHudQ8Nvi9ycgLruS7U=;
        fh=L8hlGtjEKYoD300e1/T9qnO7vxywNlEmp5swBFbvPO8=;
        b=A3uJ4/3KXxNRhTq8y6WEATnYf7akvArWcAF01vamlpypI2z1Q8P2oUFHxAqGGJHpSz
         4IfWZLOpNMfBCXqjWhOxVxs5cwby5jO+Ifh8mNgUqDMiCMRVTAm7NoytWvU4qP7LglBd
         S4XNmVSAsG0nehvRi+88jdN1hE7PAqX62aFYTQG+eBVAxG0N839xon7+thI+OO8VXyLf
         wxRR6fZufac00F2h1vSgsL2EK/GSt3/d9R3bWdm6/K86lebSMweLvVgxp0HQO1O/LCF5
         9jnoBX2nUg9ZZaCQYx7T9ZUzyDQQPsfozPXJryCFLMvxcvT9mH/VYei/HZLKb0kGs0jP
         X8/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793112715; x=1793717515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JsUBZH84qc3OTom1l1zp1cwnDHudQ8Nvi9ycgLruS7U=;
        b=Te39WAmYF30d17Btsn801Hht51R6mjEgjwIp66srMOz1Qwq45/zM8y6+ICBh6SshdT
         Tv5nT8WD+8K1U8SuES0LRWbil5RWsa3/q7b2Wxq86f5nHDSvYeqtz74prXV/rtXCeJgL
         TdVg+HMO9o8xpky2lkWcG2RaDuziZ6mLAgiA+5q9cmxYoYLqXIHFe8QlkstyxTyQfYUp
         UrgEhoNCOOV7vLnHT53MC8JGFy0p7ERYkHEuTo2IZFiIYjVcbY1G+NyQXdB0VRCbXKV4
         5rDZ1P/ZlbzOwnIjFfPdw1jo4eWtm0KiYZ5oydMuk/+7iJrGVunxVnmkwnPHI8apV7yP
         9CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112715; x=1793717515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JsUBZH84qc3OTom1l1zp1cwnDHudQ8Nvi9ycgLruS7U=;
        b=Siu5h5wDWmWmnlI/88mabr6PI48tmu+wIirP6aY6Pxu70eX0TmGLrfza1p/xj2H2/w
         g0I+yXJ1wuU9oszebYatlnnV5s2RYeOVerSX0U1PTziG9BKnxIxzNCojI7eYPg7nAfQY
         Ya/ER/XfnmlQtIjDLBtMrVv7eEOtKukGxH2lK5aJSsg/F9l4GMP+hayGfkEfF4BzV+m2
         7cd7nEcD4pCvY/ZRe/lxGy2+MzAwoUmxzdPQca9NRq9dk9PtbIXCzUWz5u5r9djZMpXa
         oy5x+IKjgfsJTEkDg0Po2PznY9VIdTLjr6LiSe/ENi8oQ2Kyw22XIjUjk4EvIuDEQfS9
         hr3g==
X-Forwarded-Encrypted: i=1; AKwUvBzPVSc60g2pmUgvQ8REDvymxDVsISuUVjUyObObAI73QUBkVJHLGdodwDy7oMBKQyPl+vZhOdE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCroiUDSm0v89aUSEFeYWjWJ+IS7h/1Nd/sxE9U7IrNGJ9Qr+n
	OZvTt6cezdDMk0tdnTJVr5RPxe/JZBWfo/yLq7Y3Rd9rFNCOYQrcfXq2sKzTpBgxheGPb0s/3SW
	Xy07v2NelqAV9akkK1s+qx+U4bID9QpvMd3FCbijf
X-Gm-Gg: AYBFou3NnAn7+h7m6bzXzpCggz2jGc58+JEsaTffS2UVR8cfnYEj9ty5HzjHjv/hdiE
	eS/LH0a7jLaAwt7c3u6PNb2ZR1UxGtAkBgjiHT1IvmuKpWzhUvUqw4KSeyy5Vg5WYbGYVEbYrnR
	BQwRcMfnhU0fbXh/AjFo2VLyNp869aaQHe2SklJwARPF6JYtfewuVVrTiMJSejGF1bDhc/Kuco7
	C5XdF7yD3drQaSW9p4d2xut1At78iBeqhtx2KvJXLzLAEfsTL5qv56O+DeFT0gJDerykMuSBemK
	lIaoMwHaJ9PLvGSukMQye8ZWaZ3RqSWqherVM69uailsaV87zIQbwo7jER8egq/31C/KAlyGRUk
	8R3dTDdN2TaJ+/77cRuLkXpn4gscbeK/F/Q4tQxQvNV/01F2hpg3rOvbRjNodScfmANtWIV7P
X-Received: by 2002:a05:6a21:a518:b0:3e1:d997:e1c8 with SMTP id
 adf61e73a8af0-3e7bfd0ceeamr7820354637.30.1793112714335; Tue, 27 Oct 2026
 07:51:54 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023204706.3112215-4-hramamurthy@google.com> <179306532757.3134.16501377800126286936@kernel.org>
In-Reply-To: <179306532757.3134.16501377800126286936@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 27 Oct 2026 22:51:42 +0800
X-Gm-Features: AclHuK-aAAS9K6XbqeKJ_G1eib3xbVZPcm0WEWowmR7QGbK-_ZxkhSUNyi4ymwk
Message-ID: <CAHwYsiqVPz4ifYz5yUCFAStitr0H_hKNDz8mfYJxGdZJ7ET6MA@mail.gmail.com>
Subject: Re: [PATCH net v3 3/4] gve: Block invalid ring sizes when device
 options are 0
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, willemb@google.com, 
	przemyslaw.kitszel@intel.com, nktgrg@google.com, maolson@google.com, 
	jacob.e.keller@intel.com, pkaligineedi@google.com, yangchun@google.com, 
	patricion@google.com, awogbemila@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:42=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] In gve_parse_device_option()
>   (drivers/net/ethernet/google/gve/gve_adminq.c:194-197), the new=E2=80=
=A6
>
> Pre-existing issues:
> - [Low] gve_parse_device_option() (gve_adminq.c:177-197) accepts
>   MODIFY_RING options with option_length 9-11, because it rejects only <=
=E2=80=A6
>
> --
>
> gve: Block invalid ring sizes when device options are 0
>
> When the MODIFY_RING device option reports a minimum RX or TX ring size
> of 0, this patch makes gve_parse_device_option() fall back to the
> driver's default minimum ring sizes. The goal is to stop ethtool -G from
> accepting ring sizes small enough to crash gve_tx_alloc_rings_dqo().
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 8b215fca9c1b6..2c848f0c23dc2 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -191,7 +191,9 @@ void gve_parse_device_option(struct gve_priv *priv,
> >               *dev_op_modify_ring =3D (void *)(option + 1);
> >
> >               /* device has not provided min ring size */
> > -             if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE)
> > +             if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE ||
> > +                 be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) =
=3D=3D 0 ||
> > +                 be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) =
=3D=3D 0)
> >                       priv->device_info.default_min_ring_size =3D true;
>
> [Severity: Low]
> If only one of these two fields is 0, should the other minimum from the
> device be kept?
>
> Both directions share the single default_min_ring_size flag. When it is
> set, gve_enable_supported_features() replaces both minimums:
>
> drivers/net/ethernet/google/gve/gve_adminq.c:gve_enable_supported_feature=
s() {
>     ...
>                 if (info->default_min_ring_size) {
>                         /* If device hasn't provided minimums, use defaul=
t minimums */
>                         info->min_tx_ring_size =3D GVE_DEFAULT_MIN_TX_RIN=
G_SIZE;
>                         info->min_rx_ring_size =3D GVE_DEFAULT_MIN_RX_RIN=
G_SIZE;
>                 } else {
>     ...
> }
>
> Take a device that reports min_rx_ring_size =3D 1024 and
> min_tx_ring_size =3D 0. Its RX minimum would become
> GVE_DEFAULT_MIN_RX_RING_SIZE (512), not 1024. Before this patch, the
> non-zero value was used.
>
> gve_set_desc_cnt() copies these values into priv->min_rx_desc_cnt and
> priv->min_tx_desc_cnt. Those are the only lower bounds that
> gve_validate_req_ring_size() checks:
>
> drivers/net/ethernet/google/gve/gve_ethtool.c:gve_validate_req_ring_size(=
) {
>     ...
>         if (new_tx_desc_cnt < priv->min_tx_desc_cnt ||
>             new_tx_desc_cnt > priv->max_tx_desc_cnt ||
>             new_rx_desc_cnt < priv->min_rx_desc_cnt ||
>     ...
> }
>
> Would ethtool -G rx 512 then pass validation and go to the device, even
> though it is below the minimum the device reported?
>
> A per-field fallback would use the default only for the field that is 0.
> Could that fix the zero-minimum crash and still keep the other limit from
> the device? For older devices that report both minimums as 0, as the
> commit message describes, the two approaches behave the same.

The gvnic device either reports both minimums or both as zero, so the
per-field fallback would behave the same in practice.
>
> [Severity: Low]
> This is a pre-existing issue, but can these new reads go past the end of
> the option payload when option_length is 9, 10 or 11?
>
> The length check earlier in this case rejects only lengths below
> GVE_DEVICE_OPTION_NO_MIN_RING_SIZE (8):
>
> drivers/net/ethernet/google/gve/gve_adminq.c:gve_parse_device_option() {
>     ...
>         case GVE_DEV_OPT_ID_MODIFY_RING:
>                 if (option_length < GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
>                     req_feat_mask !=3D GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_R=
ING) {
>     ...
> }
>
> min_rx_ring_size and min_tx_ring_size sit at payload offsets 8 and 10,
> and sizeof(struct gve_device_option_modify_ring) is 12. With a length of
> 9 to 11, part of each read comes from the next option header or from
> unused descriptor space.
>
> gve_get_next_option() only checks option_length against the
> device-provided total_length. Also, total_length is never checked
> against the GVE_ADMINQ_BUFFER_SIZE allocation.
>
> If those out-of-option bytes are non-zero, the fallback does not fire
> and the bytes are used as the device minimums.
>
> The baseline gve_enable_supported_features() already read the same
> fields in this case, because default_min_ring_size stayed false. So this
> patch does not add any new reachable impact.
>
> Would checking option_length < sizeof(**dev_op_modify_ring), instead of
> comparing with =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SIZE, close this?

This is pre-existing and not changed by this patch. The gvnic device
sends this option with a length of either 8 or 12.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023204706.3112215-1-hramamurthy%40google.com

Regards,
Pin-yen

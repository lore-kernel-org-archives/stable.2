Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA449370AEC
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585518; cv=pass; b=hmSbXGhxhhF00NeboSaqHY7WzdCSfiV4qXYAsV/CguRd82eH4qnZFuy1pd7G/V1uPWW9X1wP9sD576K1wC9zS2s0SV49z9hljAO4N9PjIgzq/cISiQYxrm2U2Pu006YN0uikjcRPzYc1B6HhlpDZpPn0C1SDAcxiQ3dm149T03g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585518; c=relaxed/simple;
	bh=6cibgC5Kqhomu5ObIzPSmO5OQgWZgOkrevI2tgyQYGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljaHJFofolct9W+WNHNYrF8sQ8gbLWSerK9cj38sLmuHqdIHvypjkOuDaJFi2cNKg5SCWE7keK9posUvEZUdP/pWnuvSGVfqY73jLWq26J3nyK/Qf5WJ4aGnIvP5EH2JNtQnbYV3A01Dse4XsoOM78hEcyOOg71h7beNdfJKSeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miuSdYTq; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miuSdYTq"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-836cda225c1so50842497b3.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585516; cv=none;
        d=google.com; s=arc-20260327;
        b=Rw9Nl4DYUk3S7aUlbPF/v7l4wObjC95ouD5cHVjG5hZyT2r7MdI591mxmbKfQrYViY
         J3wbSpsUc8bByKtmHSXCzhoJ6I9EmP8FPu3aNsfwFUJuPTjfjQlikyPj8JcJWjBW5IdR
         grlzDCBHUnxAvM8XbDiBBZ5+2slk/ZV4/4bNWG0k2a8zJRmfNTOIyBUwpp7ESLAcmHgQ
         St2iMJa6wpmvuaW5Tz5SJpgIcx2nMW7B4Gqa2niqANclpJqfpbdzffQOEaEdHHYHZH3w
         EHaqgUERYosCTb/2Z8FvfUwPFW0ZL83I2rZIGAKMvFXD+SlVl8t98EqCuIr6Tm8RuKMx
         Pkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cBlBG7m5w/OxgVHjTqJeo0x+CeFBP55NY7fQpbKTqZA=;
        fh=zRZ8YvcbRNSw8JEZeYZ55dKPpNRXLjrE7OlYB2b/JPc=;
        b=l7vFfH43tsObIjEN0OiVKLTAKs7q6XLGV2jk2EOYxR5qALLqyjESNUGpbKXOxZzwV/
         wwEWq+1ZzqoWoiDNed/QJOgT2ND/vz775iLKS0w/dLDcrMpCy6WM7+vK2HYYD4YxJoMl
         uylR7kLvPHn0V1Vx0/TS9WAa8uBuyZmyNYZp97veIsbsSs47h2EKYhcyzi5EiMaVgOlT
         IhQeoPPVoQIVMNN2KgcwYSVVKw+lAXgD0v+f19jvW7hcEMRaEIODEu9JeQ1r27KAPNOr
         trSNeBfKffdY/uGSE5q8SbM2P7NlEZ9CxEnllBewF0Qs2WrK4kCpsPdwOchpOKjZDNid
         y6Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585516; x=1788190316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cBlBG7m5w/OxgVHjTqJeo0x+CeFBP55NY7fQpbKTqZA=;
        b=miuSdYTqkxNCiwJuuAkoCyPamVG2LrSEImMIiuUobbMn6/IXEc9zkWai69jmn1BtqR
         vSEw9CgM4Dn9a3qT80yVDcIgBma0d7jXEbOXdM9AJleM95Ce0ysLQfZLNM2Sc5UfOPqP
         DdG0Qqw8P8QNOjwvkS3fCVUg5Cooj1bS6UoMWHegbChGAU+ZEtsyAOTiQ1/NPhoKc6Ia
         /vgnyz9NVEsE8sNhrlsY5SoL/GkKGHt1y6qWiyMwJ2M099DwfU/DKNuWqlCtnNUzcwPM
         vcWs2sg+x6D1eXD2j+7OyCxEE8F3A+G6Pcynx+sGwFAgSbZEtmOjk1iyLjLk9Xhe0Ekb
         aGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585516; x=1788190316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBlBG7m5w/OxgVHjTqJeo0x+CeFBP55NY7fQpbKTqZA=;
        b=Qgg4aqb6X/81qg/ELpg2jYj2VjKsBw+VZIPjK1SSzI9kyI/GrMJC4clCJ/D7Qva+fF
         TWGA2XAMeLmi9QG/YdZoRTV9u+5xEEVaBLB9Bzy+JX9M7OKfNYADOyQsXfebbBGWiiKm
         bb+Ewgybhm5e0WfK1uWQD6ZaZP5HQWct2JP40dx4LJSNoCBpGTsd8mIEGBZ3F/x3fk7L
         iZSTbDD/17i5dfaTW+ZRkz/L95erf/Lv5Sr+KU0fCn93PFGYCI8O7CXkd/3VnWaBOcH5
         tjg3O6kiVYbU4vjekz2H2TN8MO1SaPeCb1J9z16VEQOU393pYbTc50OKddEzN1Rc8pCl
         i6Ww==
X-Forwarded-Encrypted: i=1; AHgh+RolXwlmwCn07btfdshBLO3WN8RqEbO1MCE+Td/HRDEX89i+X8+SXQVsHJA+dBImgMTPwy8IA34=@vger.kernel.org
X-Gm-Message-State: AFuF++mPikPK3HBaRsFBv5T4qwSTPJtuwqKr8VgdzAmVOB2CbFHXDvdi
	qA0X7Z840FnAXHQHqSTc4sHMaqxE/phmesNMV1dK8jCp3GSL4fhGpK7KqLN6AL40xjqZbJadrOs
	8UMqAXfxTbP2vQCzVoszes4ktgpXWau4=
X-Gm-Gg: AR+sD10DwN92i0j+Lb9hcRbpDfOlHM8jVHMh3BFtcdI6FcrPwS619JXAidQaV6ZGKIJ
	ZDxlYWU8CHYmfYw4wTBm9yJ2aMNavpfBjxIGrGAaLkHeFoA+uB2VsB4j0GD7Wr7phLJwheNGobI
	n1ChG+0doBMubp7dQpefjmL4EBuPg/DBxtVKqqJMgyH6ZvyspoK1nP1X0F8xghKzEJs4GhMJDtA
	rNHh5MTZN9SNpVv1zywoyJgGQ1DPWhSrYDxT2X9cd19hk6chd/Vkp/qR9es5FqdSl0RI8L1+KFe
	qczmlSlX5v69q86TP6zl1BpdpItu1qs65voe0EMaw84T5zTxDkQ5AUZM+rK+rOsF3YdmNLT8/c8
	yjGZFtJqUzD4uUbU1FfbuOMHdlIdVTgI=
X-Received: by 2002:a05:690e:4090:b0:66d:c8b:7a3f with SMTP id
 956f58d0204a3-66d0c8b7cc5mr1403347d50.10.1787585514807; Mon, 24 Aug 2026
 08:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
 <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com>
 <20260824144051.50010-1-acharyalaxman8848@gmail.com> <CABBYNZKJ10anQiThzYturqWyRxhnKY-xOMKhKHF5ysx37VmHkQ@mail.gmail.com>
 <20260824152029.51492-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260824152029.51492-1-acharyalaxman8848@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Aug 2026 11:31:43 -0400
X-Gm-Features: AcwNN1XczF39o0A7vrGeYMV1ixP8GZ98t523rpCKBGJOS0onrtI26gHpY_aCQks
Message-ID: <CABBYNZJxXFt3N-hNQ-RPSe379uw9qfwvKL9yncQ4a034_9d6hQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laxman,

On Mon, Aug 24, 2026 at 11:20=E2=80=AFAM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:
>
> Hi Luiz,
>
> Thanks for looking at this.  Sorry that my earlier wording was unclear.
> I agree that the uses of p inside sizeof() and __must_be_array() are
> unevaluated, and that sizeof(vnd_codecs->num) is a compile-time value of
> one.
>
> The runtime access comes from the third macro argument, count.  Here that
> argument is the expression vnd_codecs->num.  Since it is not a constant
> expression, __builtin_choose_expr() selects the size_mul() branch, which
> effectively evaluates:
>
>         size_mul(vnd_codecs->num, sizeof(*vnd_codecs->codec))

Opps, yeah that indeed access the ->num.

> Evaluating the first argument reads vnd_codecs->num before the result is
> compared with skb->len.  Therefore, if no byte remains after the standard
> codec array, the read is already out of bounds.  The issue is this count
> load, rather than any evaluation of the sizeof() operands.
>
> I also verified this with a minimal reproducer using the same macro
> expansion: the compiler emits a byte load from vnd_codecs, and ASan
> reports a one-byte out-of-bounds read when the pointer is at the end of
> the buffer.
>
> Changing the trailing sizeof(vnd_codecs->num) to sizeof(*vnd_codecs)
> would give the same size, but it would not prevent the earlier count
> load.  The added check ensures that the count byte is present before
> flex_array_size() uses it.

That said I rather use skb_pull_data then:

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 5bc5003c387c..fdc9652dad29 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -145,11 +145,12 @@ void hci_read_supported_codecs(struct hci_dev *hdev)

        skb_pull(skb, sizeof(rp->status));

-       std_codecs =3D (void *)skb->data;
+       std_codecs =3D skb_pull_data(skb, sizeof(*std_codecs));
+       if (!std_codecs)
+               goto error;

        /* validate codecs length before accessing */
-       if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
-           + sizeof(std_codecs->num))
+       if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num))
                goto error;

        /* enumerate codec capabilities of standard codecs */
@@ -161,15 +162,14 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
                                            LOCAL_CODEC_ACL_MASK |
LOCAL_CODEC_SCO_MASK, &caps);
        }

-       skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
-                + sizeof(std_codecs->num));
+       skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num));

-       vnd_codecs =3D (void *)skb->data;
+       vnd_codecs =3D skb_pull_data(skb, sizeof(*vnd_codecs));
+       if (!vnd_codecs)
+               goto error;

        /* validate vendor codecs length before accessing */
-       if (skb->len <
-           flex_array_size(vnd_codecs, codec, vnd_codecs->num)
-           + sizeof(vnd_codecs->num))
+       if (skb->len < flex_array_size(vnd_codecs, codec, vnd_codecs->num))
                goto error;

        /* enumerate vendor codec capabilities */


--=20
Luiz Augusto von Dentz

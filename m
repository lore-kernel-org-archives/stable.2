Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B914B7A25
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596523; cv=none; b=LNJQl1cWEMLV6nA713KwKppIlxLu1SZ4hiW5jv1O7+Npa88fdpKw/bUBeOepdQudKVwdK8adYkYIxj4JoVBUY3QlUFpVkZRx4B4vgmp+/lfk2Pr94ROrZ2+rUIibsbxrkkMen1KsXViCvYpe1bQewYJt5rfOyyJD7gb0JOoVSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596523; c=relaxed/simple;
	bh=cQAChtepgMpC3QAC/HxIQYzzUCwW6JkrFd27BgpOpRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF9wYIvU6x0k4Cfg3YW06BlFcYlj112t6J8m8BeRTax399hANvSfIA2NO7A0t3X4c/i2S1VgQdz/H6ie1RANz/RqD2OSyP6ydnzuH+FiU7jS+rPA/MbP5p/wDUf24hqcFbEm0iROitR3aD9A9U1rw1GvmE/Al930tqW28+NoALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6fa788e6so1570836a12.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596520; x=1791201320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRj08SUQ00B6c/vwfuBc/4g/UNksF46V58efjI36W1s=;
        b=hrisG8rY1ZNhOEAh/v6WLbttc/zCSwggKDUevqvprka2dK8wNWD7e98EjoCO8bvSEx
         vWFYZYTu6RssL5bOkF4tSGyAl7NvVspfO/5CC8+DfHHmvk6gJTE0ioNgzPub/0mIZbbc
         gWEHMLk/kPTPZeCjA5UCHMZrZg0jNWzxLkr61BTEPxUJja0mtmoAmD23jfJNc3Hb4yNM
         sRQ6MBLuFIYiW40bOrGuBGq5xvBqKP5sf4RDfBZwq6q43xrFLzJiDDQbMMM25zF2ezOe
         xnKTC/emQ8n4MCvf2ifR+IDiD9mVD2XnHYYT3t6fxDMY97ZG5bZ7//S5WCqx4hEqjMUa
         5QdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFXZoV7FuGi9OoJGG5Y3Ra47MDUkc70IdsXN7zjqAYrYOMbIRfNBdAJCGK9R6gcGLMLuo/3Wc=@vger.kernel.org
X-Gm-Message-State: AFuF++kW8sOWE6x33zkvu5m+iw2m4K9dLZ0Vr9bB5RgVGtRz/ETmeZWJ
	t6H2cf8M3s3rWLfQHA8P09SoruYn96Q8lxuncR9S//ytvqdn4KiD5I/B5IL/adI9qx4=
X-Gm-Gg: AYBFou3ezurJahAApXs0qw8lCEXIwTH2Aybe9PTvPgRCrWh/l4dqtZPFNmHmFlYehYw
	nVrUgF6xPjO97r8WUDxLU9ghafA6yPwnox0pGH8yLUNPqL+L3/rjLBU1Qd7GZzOZz6Y+ogZ/HSB
	WKdeZFZJipMc5Sao8BBLP/+0pSMJMABGn832zjsMlmT0GSZb9g18ipQ3eAXWSN9VwyTgp+rCt6j
	xRNipVwHQSxoERq4YIgsbRBkexRCMo+oIgaDgdadN1y1cyH16af08CT00RIJEC0QaiEdr3y0V11
	jokJggQZwT5X1qe210uqY/JQwJoBrdxCu8cFhaau78wAuZ15u1Se4TkeckYO0VE1tB7vW8qGgn2
	HvKLkYHPEvkB35i8WsLwikpj/A70AkGbkROW6SWtXGMG/8KjaqXkhThbdXj1t6eXz154TpyeVEh
	4MosXw7s3fjffB+I/yTbNWoWT23dFpvnLG5hn0MXTnqZVloT2XqSnNkPxYhEMZmVKPAhCuhqjIL
	HYsqirrXBhaVVZypsNO+J3M8mH6Hms=
X-Received: by 2002:a17:907:970f:b0:c29:d31f:7d7a with SMTP id a640c23a62f3a-c2ac52c828cmr1030865566b.21.1790596519716;
        Mon, 28 Sep 2026 04:55:19 -0700 (PDT)
Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com. [74.125.228.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2b769429ddsm323351866b.51.2026.09.28.04.55.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 04:55:11 -0700 (PDT)
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2b40e4744eso239810366b.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:55:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzrmPgeykShd4wMh54WeOktTk7NYNNwjk69jSnDpp9HufKY0vqeAs4TQbw2a6QFcohVjLV2UZw=@vger.kernel.org
X-Received: by 2002:a17:907:c308:b0:c28:ec7c:27ae with SMTP id
 a640c23a62f3a-c2ac5396f65mr1010475866b.25.1790596507876; Mon, 28 Sep 2026
 04:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a0b2e00f5cc62c173a01fec2f56eab1b04d70bb.1790568982.git.xuyuqiabc@gmail.com>
In-Reply-To: <4a0b2e00f5cc62c173a01fec2f56eab1b04d70bb.1790568982.git.xuyuqiabc@gmail.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Mon, 28 Sep 2026 12:54:56 +0100
X-Gmail-Original-Message-ID: <CAOs+rJUaq6W_TBh-rThhd_N4Aj33sndvYhEA6=zOVGBbz7NP4g@mail.gmail.com>
X-Gm-Features: AclHuK_Wg6kgdXGN_cBEZ2B8n--Ssk5P9tVcVa6IjqC_p1OFoCo87o4XkTq72pA
Message-ID: <CAOs+rJUaq6W_TBh-rThhd_N4Aj33sndvYhEA6=zOVGBbz7NP4g@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: Account for asymmetric key payload data in the quota
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, 
	Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, 
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:27=E2=80=AFAM Yuqi Xu <xuyuqiabc@gmail.com> wrote=
:
>
> add_key("asymmetric", ...) preparses the supplied blob and then
> instantiates the key with generic_key_instantiate(), which charges
> prep->quotalen to the owning user's key quota through
> key_payload_reserve().
>
> pkcs8_parse() duplicates the attacker-controlled PrivateKey OCTET
> STRING with kmemdup() into pub->key. pkcs8_key_preparse() stores that
> object in the asymmetric-key payload but hard-codes prep->quotalen to
> 100, so the quota records 100 bytes regardless of the retained private
> key size. The ASN.1 decoder accepts blobs up to 65535 bytes, so one
> key can pin about 64 KiB while consuming 100 quota bytes. With the
> default non-root limits (200 keys / 20000 bytes) a user can retain
> roughly 12 MiB instead of the 20 KiB the limit is meant to allow.
>
> x509_key_preparse() keeps the parsed public key, its parameters, the
> signature and the authority key IDs, but also charges a fixed 100
> bytes. PKCS#8 later repeated the same fixed-100 accounting. The same
> add_key() call reaches the X.509 parser, so fixing only PKCS#8 would
> leave the bypass reachable.
>
> Charge the size of the retained payload instead. An oversized PKCS#8
> key now fails with -EDQUOT instead of being accepted for 100 bytes,
> and the same applies to an X.509 certificate that retains an oversized
> public key or set of authority key IDs.
>
> Measured on v7.3-rc1 (10396a2d6d41), 2 vCPU / 2 GiB QEMU guest, as uid
> 1000, adding PKCS#8 keys with a 65000-byte PrivateKey field. Before
> the patch, 176 keys were retained (about 11.4 MiB) while
> /proc/key-users charged only 19712 bytes. After the patch the
> oversized key is rejected immediately, and a 200-byte PrivateKey still
> loads and is charged 264 bytes. A small X.509 certificate whose only
> large object is a 26000-byte authorityKeyIdentifier is likewise
> rejected, while the unpatched kernel accepted it and charged 109
> bytes.
>
> Fixes: c26fd69fa009 ("X.509: Add a crypto key parser for binary (DER) X.5=
09 certificates")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <weir@nebusec.ai>

Reviewed-by: Ignat Korchagin <ignat@linux.win>

> ---
> Changes in v2:
>  - Move the bug details and the measured quota numbers into this
>    commit message, as requested by Ignat Korchagin.
>  - Sashiko (High): "keys: integer truncation in key->quotalen causes
>    permanent quota leak" on pkcs8_key_preparse() and
>    x509_key_preparse(). Not changed. The truncation is real only past
>    USHRT_MAX, the unprivileged maxbytes is 20000 so add_key() fails
>    with -EDQUOT first, and this patch does not widen key->quotalen.
>    Replied publicly: Message-ID
>    20260920073515.64399-1-xuyuqiabc@gmail.com
>  - v1 Link: https://lore.kernel.org/all/cover.1789801335.git.xuyuqiabc@gm=
ail.com/
>  crypto/asymmetric_keys/pkcs8_parser.c    |  2 +-
>  crypto/asymmetric_keys/x509_public_key.c | 23 ++++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_ke=
ys/pkcs8_parser.c
> index 9dd1c181789a..fa8b142a8e14 100644
> --- a/crypto/asymmetric_keys/pkcs8_parser.c
> +++ b/crypto/asymmetric_keys/pkcs8_parser.c
> @@ -150,7 +150,7 @@ static int pkcs8_key_preparse(struct key_preparsed_pa=
yload *prep)
>         prep->payload.data[asym_key_ids] =3D NULL;
>         prep->payload.data[asym_crypto] =3D pub;
>         prep->payload.data[asym_auth] =3D NULL;
> -       prep->quotalen =3D 100;
> +       prep->quotalen =3D sizeof(*pub) + pub->keylen;
>         return 0;
>  }
>
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index 25cf8ac7f257..f2bdd0244262 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -163,9 +163,11 @@ static int x509_key_preparse(struct key_preparsed_pa=
yload *prep)
>  {
>         struct x509_certificate *cert __free(x509_free_certificate) =3D N=
ULL;
>         struct asymmetric_key_ids *kids __free(kfree) =3D NULL;
> +       struct asymmetric_key_id *id;
>         char *p, *desc __free(kfree) =3D NULL;
>         const char *q;
>         size_t srlen, sulen;
> +       int i;
>
>         cert =3D x509_cert_parse(prep->data, prep->datalen);
>         if (IS_ERR(cert))
> @@ -228,7 +230,26 @@ static int x509_key_preparse(struct key_preparsed_pa=
yload *prep)
>         prep->payload.data[asym_crypto] =3D cert->pub;
>         prep->payload.data[asym_auth] =3D cert->sig;
>         prep->description =3D desc;
> -       prep->quotalen =3D 100;
> +
> +       /* Charge the memory retained in the payload, not a fixed estimat=
e */
> +       prep->quotalen =3D sizeof(*cert->pub) + cert->pub->keylen +
> +                        cert->pub->paramlen;
> +       if (cert->sig) {
> +               prep->quotalen +=3D sizeof(*cert->sig) + cert->sig->s_siz=
e;
> +               if (cert->sig->m_free)
> +                       prep->quotalen +=3D cert->sig->m_size;
> +               for (i =3D 0; i < ARRAY_SIZE(cert->sig->auth_ids); i++) {
> +                       id =3D cert->sig->auth_ids[i];
> +                       if (id)
> +                               prep->quotalen +=3D sizeof(*id) + id->len=
;
> +               }
> +       }
> +       prep->quotalen +=3D sizeof(*kids);
> +       for (i =3D 0; i < ARRAY_SIZE(kids->id); i++) {
> +               id =3D kids->id[i];
> +               if (id)
> +                       prep->quotalen +=3D sizeof(*id) + id->len;
> +       }
>
>         /* We've finished with the certificate */
>         cert->pub =3D NULL;
> --
> 2.55.0
>
>

Thanks

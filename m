Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989426;
	b=r1fwX3rA0z9M5tnzsmg8UGZAwgWxjPaxipPxbusaQlN1G7gCquSclAi7XWdlzhJCRcqH
	 WgVZ1iRYfopbriIbXDtVK02MOi3KvPUu0Cn4dVylwppKDYAhEUge8wDJVZbvFgUwYTJzK
	 cQ3fXJhIjjQ0jaIb+KF/W5tkTfrpztdjQNDROVaf8SPlxhuBnamYrJPaCcRZNceZ4TgbI
	 VgHz9l91LZbN8XXfzA+irmlVl94D9McZBxPoSBYfdqEUajSoCnnxvrdsY0kq9ePkQtDuO
	 Gi0RejJDpuj64P2dF2Rcfs2LjlNZJ0lEzmakH/7fJ2Ol85rG3boJBHyPdbU6TkSeT+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989426;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aNrxcQ3EqzspHqBIrIiO9tnG/RBY6rmNXDWaz9X6PEg=;
	b=vorHKykCG1JCyyKcbC2g5vQRQxt9bp70G+GwQX8igihcxcn6zIZeI+6UllizPH7zKCJ4
	 u70NPGEXIh83cjqlL1aVg0cVFeqZNkted6lNg/gxAIOFWvNQHl8FK+t0eg1VGdPYoKhGh
	 hA8az9U3Og9YGyZR8VhBecvM5+osFBtD4Ot7taLrz/W1NWebagzDLZnoeieBJTK82dW1D
	 NYAX5BIDkheSdCuOQojbHQBtFPEAmEEAQvijP0HPdWlUEIHSmmVcJKV5fxIz9jVVwFeTK
	 FrenIYaoBviX5sZZyffcgf4RglBLzx5oAjgVm+jQMWTK6djtBfGnbSceL1I3L59so5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BA606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008BA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1431872a12.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989424; x=1794594224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNrxcQ3EqzspHqBIrIiO9tnG/RBY6rmNXDWaz9X6PEg=;
        b=ldFYS2lR3dUP6QvRWusR5ke6+KrekWGsba6cfNzkzxmUnw+7Ckv4vEu9vKbH95CV8G
         +aellcUX2jYx/It8i6mO5l8E1AgQVvYlH58CcWmBEEu8k9vHBG04CjWdrc0bO81zIHiO
         ZgDOvuoO66MI859inBgxUxgoHg0GUDzSRzgxbg21XHLDbdkp6zLwtpHpVM/Q45+hCASn
         iDAQzkTKgAQRJD+APCEffGhBtQfCjR3aO9lW00fwRbxQjhDvK3Qe3jbid+jyr3LZJ93M
         mw2kbaQrZYyywk0icqg09MxrenmIDM9NvXIsufhE7U6m3dJ0Pow4toE5RDtjlpiGsRHn
         Hjnw==
X-Forwarded-Encrypted: i=1; AL+hErF6me/iMXGEE4SRSq/MZsG1EoolQU2x+VBwJXG+twE0bCUGgImLz35q9FAfrSynXIV+oTVwllQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/s+yubOT/YlDGRdgQ2HEfk/thxEobdrC3DoNwczVED+FWfhasr
	LqWtHSP3hWnJ6S/89ESXT2Pjr7lyoZ8gRwWtyOaEQsgniUUClyqmCJyiJt1BhYrE+bU=
X-Gm-Gg: AYBFou3Kq9Fok7fs/bTE5zEYhfxtZlaeLv25idtr5wVAHrmSp+8MDnG5OKluo1x3Z4E
	C2/+Ue9enDsE+jkaC18N/dHJqi5lgYprq7IpdEX1V0l476qrF7/JYCFbZZSehzR/zoB7X6gDoYB
	T6dTVHBHYenKGqn9RRvjjqy+urX+TEaVKKNrGUY5XxsUUPQtgmv2Za1OUHM/i6CpYUCpkvDkZce
	4XB89A5gyBNE2nO2B4ON0syCElfqILTchmvDv0zQqOJ+7TpvCKyhoIZR0dxdFuNYgLP5Ri/6dLw
	/WMiCxvByZwSmA4Ptu9afMgaYA6ckbQ/OwvmQU4ZR8gl/6KeFYPbv5Xl/UqjCYXejSeq7VhPT57
	0rLB0QI4D4oCHBNGEYmQmRCQhtqxq/TgoiK4QqSqj6cDPugLC1gLfen+Fi6CAskRHwvc5+Y22rl
	cdOrEGImq2Sjd3C4vgkpk1hMJafaJbSFYpX1P1t+JGWSvxR7NzojiyE+PYIwdNmhsA1PqZy02lw
	vLNcxjnKEM1VKwShomRdlYdaElTkyiAmyWU+hfRfJARCMUduNoaSjLKf0R2gMvbzyx2TxKekDVC
	O3RawvSt8h4Sbzoc/ykDD8lZQ6VHHC3DRBm96YqO8gCuat7XIurEQ3JRQUk=
X-Received: by 2002:a05:6402:a50d:20b0:6b4:2060:8a4d with SMTP id 4fb4d7f45d1cf-6b59783f17fmr1652098a12.33.1793989424235;
        Fri, 06 Nov 2026 10:23:44 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664b19a79sm947121a12.31.2026.11.06.10.23.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:23:42 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso150402666b.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:23:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxuTS50i7wk994tjhpE2Thch4jes1StAUc1n90lVYreq9oEwEB7LhprNdL9n6WmmGiNOBg1Hww=@vger.kernel.org
X-Received: by 2002:a17:907:6ea1:b0:c49:903e:1e19 with SMTP id
 a640c23a62f3a-c4d354e89acmr271729566b.26.1793989420455; Fri, 06 Nov 2026
 10:23:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026024840.23482-1-xuyuqiabc@gmail.com>
In-Reply-To: <20261026024840.23482-1-xuyuqiabc@gmail.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 6 Nov 2026 18:23:27 +0000
X-Gmail-Original-Message-ID: <CAOs+rJWf5JEMD7UC-4YS2ayAX5f2SUgr5s9DCwmWXExBhqaEJA@mail.gmail.com>
X-Gm-Features: AclHuK-C3Nt3Bae-E0GNpd5wrE9zs0X4WIFo37tTe1DY5jHnZaQm4KTY5Zirqa8
Message-ID: <CAOs+rJWf5JEMD7UC-4YS2ayAX5f2SUgr5s9DCwmWXExBhqaEJA@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: Account for asymmetric key payload data in the quota
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, 
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:50=E2=80=AFAM Yuqi Xu <xuyuqiabc@gmail.com> wrote=
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
> public key or set of authority key IDs. A charge which does not fit
> in unsigned short is rejected with -EINVAL before the payload is
> installed, because key_payload_reserve() keeps the full delta in the
> user counter and refunds only the truncated key->quotalen. key_alloc()
> also charges the key description to the same field, so include the
> effective description length in that limit as well.
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

SInce we touch PKCS8 as well, missing a relevant "Fixes:"

> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <weir@nebusec.ai>
> ---
> Changes in v4:
>  - Sashiko (High): "keys: integer truncation of key->quotalen causes
>    permanent quota leak" on key_alloc() and key_payload_reserve().
>    Include the effective key description length in the USHRT_MAX
>    limit. key_alloc() and key_payload_reserve() add the description
>    and the payload to the same unsigned short field, so checking the
>    payload alone was not enough.
>  - v3 Link: https://lore.kernel.org/all/20261019041314.48569-1-xuyuqiabc@=
gmail.com/
>
> Changes in v3:
>  - Sashiko (High): "keys: integer truncation of key->quotalen causes
>    permanent quota leak" on pkcs8_key_preparse() and
>    x509_key_preparse(). A payload charge above USHRT_MAX is rejected
>    with -EINVAL before the payload is installed. key_payload_reserve()
>    keeps the full delta in the user quota and refunds only the
>    truncated key->quotalen, so that charge would leak quota.
>  - Reposted so Sashiko records a review against this Message-ID, as
>    requested by Herbert Xu. v2 was posted and Ignat Korchagin replied.
>  - v2 Link: https://lore.kernel.org/all/4a0b2e00f5cc62c173a01fec2f56eab1b=
04d70bb.1790568982.git.xuyuqiabc@gmail.com/
>
> Changes in v2:
>  - Move the bug details and the measured quota numbers into this
>    commit message, as requested by Ignat Korchagin.
>  - Sashiko (High): "keys: integer truncation in key->quotalen causes
>    permanent quota leak" on pkcs8_key_preparse() and
>    x509_key_preparse(). Not changed in v2. The same finding is
>    addressed in v3 and v4.
>  - v1 Link: https://lore.kernel.org/all/cover.1789801335.git.xuyuqiabc@gm=
ail.com/
>
> diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_ke=
ys/pkcs8_parser.c
> index 9dd1c181789a..db2d57489d96 100644
> --- a/crypto/asymmetric_keys/pkcs8_parser.c
> +++ b/crypto/asymmetric_keys/pkcs8_parser.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/err.h>
>  #include <linux/oid_registry.h>
>  #include <keys/asymmetric-subtype.h>
> @@ -136,6 +137,8 @@ static struct public_key *pkcs8_parse(const void *dat=
a, size_t datalen)
>  static int pkcs8_key_preparse(struct key_preparsed_payload *prep)
>  {
>         struct public_key *pub;
> +       const char *description;
> +       size_t desclen, quotalen;
>
>         pub =3D pkcs8_parse(prep->data, prep->datalen);
>         if (IS_ERR(pub))
> @@ -144,13 +147,26 @@ static int pkcs8_key_preparse(struct key_preparsed_=
payload *prep)
>         pr_devel("Cert Key Algo: %s\n", pub->pkey_algo);
>         pub->id_type =3D "PKCS8";
>
> +       /*
> +        * key_alloc() charges the description to the same unsigned short
> +        * field that key_payload_reserve() later adds the payload to.

While today indeed only the asymmetric keys hit this I wonder if the
fix is better to be in key_payload_reserve(). Something like a fail if
key->quotelen + delta > USHRT_MAX. That fixes all current and future
key types.

> +        */
> +       description =3D prep->orig_description ?: prep->description;
> +       desclen =3D description ? strlen(description) + 1 : 0;
> +
> +       quotalen =3D sizeof(*pub) + pub->keylen;
> +       if (desclen > USHRT_MAX || quotalen > USHRT_MAX - desclen) {
> +               public_key_free(pub);
> +               return -EINVAL;
> +       }
> +
>         /* We're pinning the module by being linked against it */
>         __module_get(public_key_subtype.owner);
>         prep->payload.data[asym_subtype] =3D &public_key_subtype;
>         prep->payload.data[asym_key_ids] =3D NULL;
>         prep->payload.data[asym_crypto] =3D pub;
>         prep->payload.data[asym_auth] =3D NULL;
> -       prep->quotalen =3D 100;
> +       prep->quotalen =3D quotalen;
>         return 0;
>  }
>
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index 25cf8ac7f257..4a9c85277ce0 100644
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
> -       const char *q;
> -       size_t srlen, sulen;
> +       const char *description, *q;
> +       size_t desclen, srlen, sulen, quotalen;
> +       int i;
>
>         cert =3D x509_cert_parse(prep->data, prep->datalen);
>         if (IS_ERR(cert))
> @@ -221,6 +223,36 @@ static int x509_key_preparse(struct key_preparsed_pa=
yload *prep)
>         if (IS_ERR(kids->id[2]))
>                 return PTR_ERR(kids->id[2]);
>
> +       /* Charge the memory retained in the payload, not a fixed estimat=
e */
> +       quotalen =3D sizeof(*cert->pub) + cert->pub->keylen +
> +                  cert->pub->paramlen;
> +       if (cert->sig) {
> +               quotalen +=3D sizeof(*cert->sig) + cert->sig->s_size;
> +               if (cert->sig->m_free)
> +                       quotalen +=3D cert->sig->m_size;
> +               for (i =3D 0; i < ARRAY_SIZE(cert->sig->auth_ids); i++) {
> +                       id =3D cert->sig->auth_ids[i];
> +                       if (id)
> +                               quotalen +=3D sizeof(*id) + id->len;
> +               }
> +       }
> +       quotalen +=3D sizeof(*kids);
> +       for (i =3D 0; i < ARRAY_SIZE(kids->id); i++) {
> +               id =3D kids->id[i];
> +               if (id)
> +                       quotalen +=3D sizeof(*id) + id->len;
> +       }
> +       /*
> +        * key_alloc() charges the description to the same unsigned short
> +        * field that key_payload_reserve() later adds the payload to.
> +        */
> +       description =3D prep->orig_description ?: desc;
> +       desclen =3D strlen(description) + 1;
> +       if (desclen > USHRT_MAX || quotalen > USHRT_MAX - desclen) {
> +               kfree(kids->id[2]);
> +               return -EINVAL;
> +       }
> +
>         /* We're pinning the module by being linked against it */
>         __module_get(public_key_subtype.owner);
>         prep->payload.data[asym_subtype] =3D &public_key_subtype;
> @@ -228,7 +260,7 @@ static int x509_key_preparse(struct key_preparsed_pay=
load *prep)
>         prep->payload.data[asym_crypto] =3D cert->pub;
>         prep->payload.data[asym_auth] =3D cert->sig;
>         prep->description =3D desc;
> -       prep->quotalen =3D 100;
> +       prep->quotalen =3D quotalen;
>
>         /* We've finished with the certificate */
>         cert->pub =3D NULL;
> --
> 2.56.0
>
>
>

Ignat

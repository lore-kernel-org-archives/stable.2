Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652610;
	b=ZsNwncsqi84++H/NKb14JphfPes4gxvLWbJL5ivWzpe+dSZMyoaVEY0yRvEWT5MnhCwg
	 ZSe/I+mwQ4Hr9q3SebRB4+ayKiLPsuL1BrRcCiJIkoMD51jDm1/VT6OMt6H9msdji6zqT
	 tY10e47F6aRLEhRiJF4DjHDBiXKBmlDwQWcSF1gYX3PqfPGEW+/o/bnYguZkak5dqP/MM
	 YnypfDCdqrb2phB43sYVv31zffhKM8ILDrlWGdZYbRfBd9Tu2tnQnTN8HNt6Z/T/nz8li
	 jV52BmFxBeHUdgaHuZxEq+jxSu32rxday0UZaA0MIgQBZxlbeXYV9oY9ZzKyDtvGpIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652610;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YZHqs0S+0eF//NcnMf6waWSJNb6hMzfVqF5rDbvKzzE=;
	b=1yMAz3SWGPYCdfF2AoRF0Na9Om75K4doBXozrwOJjJgoDzMEzKIOi9Fs89UgkVQNLx6P
	 XzGprH1OfsptwSw2I4BX5NDi33M5gvnYgXB2oQ24VhF9jP4gDfK6FR+VfMWENFPUkj+Xn
	 wBj3jqYdg1h2il2EumBpm0pdolbh8pl8iOw6WhhBKShxO/XKaIKcqCo3B3IEUBls4oHT+
	 3+6dJt1NASiXICaRxmH6wXwUk8rixH47JhQbaG79aWhRghMjfxcXNVf+KrwmvrLSokwOo
	 rIDMqap0m3o5pVSyzL/QQ0Clsf9Ih4tIwLdJgyKjTyxmFN19l5wbt7aZrXLJyBBbzZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2106606A32F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 20:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2106606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so5286825a12.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 12:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652608; x=1794257408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZHqs0S+0eF//NcnMf6waWSJNb6hMzfVqF5rDbvKzzE=;
        b=zDAuS6k69JOTwyXspTr/mhDW0rSb4nTg7e7HmbhcTtpyFtRIh97wmoV9q0uo/mG0M1
         OI9yVvk5ibS0UyzAWGbAxltAeIoddP+AWaCUrKOBAhvqOU8CQ2ki5IVsG2YPRUfm6/IQ
         JXEgG6UtZ5QucSii3iV/MaBLoTtmUG7J7lZIjRYwCLJ4JKfbvXZWxBtzMS1t5FPYcsHk
         BM8d16zAhXSoHToHhqNX3JxIb2iJjDH8H7D5zoowdXTjNsYVqxCZCpJX6xeIn4AioyJL
         yUZ8eu1VueC6wzmBQB3YwuayhxOFv5jFCKxNhd6LC6TuxmJBW3gnrJWq8wFOk3bNY7Rg
         WdUw==
X-Forwarded-Encrypted: i=1; AKwUvBzb1vZ3zEccFfzf7bPkI94AqgX77iIhpq1hlEj9fsKKwA3dE4P8++uWLBkKD/I14a7/QM8F7yU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WMWG6uWLnMO8YtANF7CQuG536Y5tOMWm10H9G44q1fgrPk+Vr
	JjCgX3dqytVJlMFhuB0mhthFilBLaf9vkvqiIC9/6uaAC4D8AVXLqPtVa8RPp9tLN7U=
X-Gm-Gg: AYBFou21usKRSTVXzLP/lSGh2yRaM2jkk/1VPHOV/etMz+ykTL0bYsK9Rlvjdl6+TCc
	5V82QmY0gzaN7fnghJa8WK827yE+oK0LqSMEM/3Ti+o52n3dGwk38Xx2qTlfnd3rJXSed0wTMFb
	Qg8N22BHg7HpC5OF9bNSA3RkGxKR/9QJ8hVSFeALbTpeTstCqg21rL30N9609+CuDZCY0BkfhZC
	apRVHUeAus6IF/fME8j/0rypNFffCTwCfeVyS62zlupIWaMrcUoKUNNgji9rME5IjviXVJavRvT
	M9XnKqgVRXK6qEdVzWh6eA1mA6bzFrbK+yDJ9ZaoQcAu5c3HKlzsJktTEoPLN+eHYftj4GrHvpj
	iS0zXXwUEZNRuxKaU2480q5BrK+JEYMdfiAbcqnOZergoV0INSpIFMqVPNyJxyOGLau2tgIG9wX
	DUtq7BiAB0pZadTpFepNTeTKPT78OvK3U6Cqp++XfLPoAv+dNtg2t/7e5OmSSePeX9Dy0Nboexx
	apb9d7m19blWlCFsb/xaZ0qMYy7c24VDV5L7apqknITUs0JikGc/DX5l34vnhmcsy+FwjX5lvg/
	aikbBEpz0PM15BMIMIlkQFy5A+w9+f+Ef/H+FvoztSyXHKq5X8K2KPFjBE+F
X-Received: by 2002:a17:907:9341:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c4ca7a09978mr945538966b.17.1793652608087;
        Mon, 02 Nov 2026 12:50:08 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebefdd2csm22681166b.41.2026.11.02.12.50.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 12:50:07 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so5655309a12.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 12:50:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy5eUsA14TGn6IqTbUvjj1e8Ujl4DmVySG/y9KwPRoDmvkS5BUr1nkHOXru0Z8RJNiMNBBlODg=@vger.kernel.org
X-Received: by 2002:a17:907:930d:b0:c46:9ee5:eeee with SMTP id
 a640c23a62f3a-c4ca79357a1mr947048866b.6.1793652606765; Mon, 02 Nov 2026
 12:50:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102074934.2925339-1-gubowen5@huawei.com>
In-Reply-To: <20261102074934.2925339-1-gubowen5@huawei.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Mon, 2 Nov 2026 20:49:55 +0000
X-Gmail-Original-Message-ID: <CAOs+rJWjCTUwuYQMcBcbiUk8K_NQQtYGVFEBDEMZAKHWCLv98A@mail.gmail.com>
X-Gm-Features: AclHuK9uKtGwMBZoHntdWHPm90lnYY-0KuyQanxDFP3TVplvFnPCOByhCba7eNE
Message-ID: <CAOs+rJWjCTUwuYQMcBcbiUk8K_NQQtYGVFEBDEMZAKHWCLv98A@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: asymmetric_keys: verify_pefile: fix integer
 underflow in pefile_strip_sig_wrapper
To: Gu Bowen <gubowen5@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:32=E2=80=AFAM Gu Bowen <gubowen5@huawei.com> wrote=
:

nit: the subject line looks malformed: weird "-next" suffix pointing
nowhere. Otherwise:

> The pefile_strip_sig_wrapper() function validates the win_certificate
> wrapper that precedes the PKCS#7 signature in a PE binary.  It checks
> that the wrapper length does not exceed the certificate table size
> (``wrapper.length > ctx->sig_len``) but fails to verify that the
> wrapper length is at least ``sizeof(struct win_certificate)`` (8 bytes).
>
> When a crafted PE image supplies a wrapper with ``length`` in the range
> [1, 7], the subsequent arithmetic::
>
>     ctx->sig_len =3D wrapper.length;      /* e.g. 1 */
>     ctx->sig_offset +=3D sizeof(wrapper);
>     ctx->sig_len -=3D sizeof(wrapper);    /* 1 - 8 =3D 0xFFFFFFF9 (unsign=
ed) */
>
> underflows the unsigned ``ctx->sig_len`` to a value near UINT_MAX.  The
> following ``sig_len < 4`` sanity check is bypassed because 0xFFFFFFF9 is
> greater than 4.
>
> The underflowed ``sig_len`` is then passed to verify_pkcs7_signature()
> and onwards to asn1_ber_decoder().  The ASN.1 decoder's own
> ``datalen > 65535`` entry guard can be satisfied by constructing a
> PKCS#7 length field of exactly 65535 (e.g. ``30 82 ff fb``), allowing
> the decoder to proceed and attempt to read OID octets beyond the
> allocated vmalloc buffer, triggering a page fault in look_up_OID()::
>
>   BUG: unable to handle page fault for address: ffffd1e986cb2000
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:look_up_OID+0x14/0x100
>   Call Trace:
>    pkcs7_note_OID+0x33/0xa0
>    asn1_ber_decoder+0x363/0xbd0
>    pkcs7_parse_message+0xd9/0x1b0
>    verify_pkcs7_signature+0x24/0x80
>    verify_pefile_signature+0x7b/0xf0
>    kexec_kernel_verify_pe_sig+0x1b/0x40
>    kimage_file_alloc_init+0x1d8/0x3f0
>    __se_sys_kexec_file_load+0xc6/0x270
>
> This is reachable through the kexec_file_load syscall on architectures
> that verify PE signatures (x86 bzImage with
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG, arm64 Image with
> CONFIG_KEXEC_IMAGE_VERIFY_SIG), requiring CAP_SYS_BOOT.
>
> The oops occurs while the caller holds kexec_lock; if the faulting task
> is killed, the lock is never released, leaving all subsequent kexec and
> kdump operations permanently returning -EBUSY until reboot.
>
> Add a lower-bound check on wrapper.length before the subtraction to
> prevent the underflow.
>
> Fixes: 09dacbbda935 ("pefile: Strip the wrapper off of the cert data bloc=
k")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Reviewed-by: Ignat Korchagin <ignat@linux.win>

> ---
>  crypto/asymmetric_keys/verify_pefile.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db14129..cfa85ccb1cf7 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -146,6 +146,11 @@ static int pefile_strip_sig_wrapper(const void *pebu=
f,
>                         ctx->sig_len, wrapper.length);
>                 return -ELIBBAD;
>         }
> +       if (wrapper.length < sizeof(wrapper)) {
> +               pr_warn("Signature wrapper too small (%x < %zx)\n",
> +                       wrapper.length, sizeof(wrapper));
> +               return -ELIBBAD;
> +       }
>         if (wrapper.revision !=3D WIN_CERT_REVISION_2_0) {
>                 pr_warn("Signature is not revision 2.0\n");
>                 return -ENOTSUPP;
> --
> 2.43.0
>
>

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592045;
	b=dLfBqsV+L3O+qc17uX2v7cvIXWXRNjjbSjWHyfcGOc2xKXAO0GHIFfQBYUiM48EqpeaD
	 ARelvAk9QpI+WzUAa7EJlnPYtlqw3KJvwK+0Az2RJbT9yT3T1zZYfe3ZKMvmC3lfKaZoV
	 H23zNrH5hq8kpi68RephieD4ubR/JlgcsjhwbOLWMGBVPhU6efrIQkJHV6tZ5sxso0T9B
	 rsw9ztPak6ivs42gGsyCVxiC42AeLjcVKTOfhSZkpNfPQKcN2dDkmFRsbvgYSO6xK7Glg
	 srTDmaRW1eXX2OitutgCWHc5rmYoIqcx+plxeNtB5Yzvf3q05MzT+WtXfd5tsQJ5IrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UJ/A60pshTDV64EOc8/U0dsozGI6wHG2kt68wdBZvGk=;
	b=GIup+aV2dRIj2AMIduKhphvUR0FV9RW1DqVIBtBS/cfwKArAn2qZT57Hv+Ntk8UCgtYl
	 TvovlHlbj16y7KMg42L+ect+J4xFcgsvK8flJUhFQ7djK0Ri3SBhDFeNh5Zmq6AL0QrIb
	 3woPLZpNhRvkmh8l6MGmnztzwW3k/2N+6u3RSi3sFxNt83aUJ6lwDl+zW/REfubhTjO3q
	 kP29pF4LMVZoFVCctDqaEVcibLs+XDyyn/fPdBI3hY5v1ta8VxrzuRCp2EWUh9jL3l+JD
	 3YWhoxXvR7dLo3Zs9IydVJtfSc3MNM8/veJziPlg1SBMc/VYHw9l7IGtGg5RwXlCmcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="P5i/ZeyD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6A606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E6A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P5i/ZeyD
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9908e3cd939so355583241.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592044; cv=none;
        d=google.com; s=arc-20260327;
        b=St9mV7wjyRJtrDdxC6qQp+MclCd8Iee8Q9BFl2zUtHqxgMi/JuccGWwFY1jk83o7+f
         AxIlJlI4MozCrNHhAwUCB37OIM+cyhSJjL4TfwoFsqmrK8MYrUxWJoZ+ZLgcz8hkbNkV
         86ZaAqIvMyPl22H1XJY7m9MTrONy8nExbcznGSrD5ghVJxVUhyZpYupKAmjr95p6iSxc
         kM3n2RGhfKXT/+erk3EO6ckAa/CUterSEld7qyYcy6u3vze2AdgvJEuiqx4X7tyw9anv
         RMTuXCa43KAhcb+tLMZdrSo46hdE6vlfbYpDWqwPg5RnSlemeZatQPQ9JUAl7PZwamL4
         ADUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UJ/A60pshTDV64EOc8/U0dsozGI6wHG2kt68wdBZvGk=;
        fh=sGlYDpVEajosZ3helnEJaIvkvHXOZKQt1KpHcVgtNII=;
        b=MYuO3CGlQMtpDshgKlrA7hC57P3CDDZ9DiIzOhXoQEndjKGLT3o8EdBWoU5bnHC+G7
         n6ldPxeRTg5d8FiWZtXPmliRAasfo44WUb0/M4tg/CObHwPpXzoiyU38ZoF6hjfVGUaS
         4uIxn6auTob/hvSFsdsA2/VMy64qQ2Ay++GYez0ldJOntyQn+duIqYwVyuSEW0q8Kdfv
         ZPIseg+VoiQVUu0xwxeAesMfSqeuw+rlMrUqAPeZ+arnhcX8SeYj6kbum51pSIzbZ9j3
         HcBE0rIcUSh/wKA7oJ7If3i4xSvXllqDzGgUn7tpXQYBYB4RaV8wHIENrZWE/j9y0ieR
         GHVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592044; x=1793196844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UJ/A60pshTDV64EOc8/U0dsozGI6wHG2kt68wdBZvGk=;
        b=P5i/ZeyDVBkMIGuohnrHggiD4vso5z6e9mLwAvvqbmg+cZfeSijP9feo9Qf6rDuRXp
         yE7xHqSDNb0plAIhJWaSoLmsG9DZGbbb/JleA2EBPdBaDHp3wh1dG9pOwnkdcdRj9IN8
         XbO4rKntCjlm2Omf8PK8MgaxoHOrYKq9q9l9umfreEaTRiOK7FWi8O/KBGFQXg5jMVUU
         Ae9XbUO6K7OKbak/sOYq3aqvGuZ2rHWPfjtGFIyqlfFdhWZYF3SlTaatsDppaPHVBxc7
         gNQ6bF/72WNKa6B0C1ppZULgcMk88NNG5Af5kotLPdpjfSKAuXUC/8S/spHwWZC0jvqw
         8yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592044; x=1793196844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJ/A60pshTDV64EOc8/U0dsozGI6wHG2kt68wdBZvGk=;
        b=oTNz8oQgCzc4sVCC4H3OhN0SXZu1mxhsrSgnnbAvtvqZGd4QJDm1NWnnO3Dd07uKcf
         KCUhCuL465M3h2CbjTx/qnGJOq85vzJzRvKgNjc94QwnzqF/XlMx+gOBAmyxwcDMvKqd
         NOFgplrxr/tUh9rNej4Cd1Hi+K0zFv1jvsDaI7EKUooAkXGxvmIlBxL2zg1QgD+Vpkq4
         6nn47RCI96+yV69Af4GFyv7u/yNnFGXlP2RCT91SS58IR+vK5nPHEm1XHXfZHpakp2Lh
         GyhZaAFRlrpZcTxB09wOJ2/cnTQ77u0aLIZ1fQ2KaIFqJH5Uyopwmf7V1Zr8w9LA7mL8
         pY3g==
X-Forwarded-Encrypted: i=1; AKwUvBzSVKXvT5rwEMjRxdYLgczXH2wLNv4zAXRFEWjQhS/Ec2ddHOU481qiR7/RwjupHIxASigHSrc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPs+anXmigqw9BRcfgiR4qC+thdFpqooxPP378vuMhm/ppPLhG
	ClwrcI2MyxdTLkzXEMLQOpDVO60NWJ4mb2e+v+3DKMpM5X2AY7JmbPLBw/Hq2Txwe4cwdbGoEaX
	wpX8vAS5MkLpk+BH420bYcECJ0I1S7OY=
X-Gm-Gg: AYBFou2znTiYcCZlR90stzk0qsDT/iwXI4V73sdC1CdtWGelHO+TrFoBK6Prl+qgr++
	08VBctsFqY0vVcDez8F2aSTxfIn1TKNaX75JpLqkdSk56t1OiGLBridevq82C++7xeOZ0tEErue
	smTSjBCNJPWqf9NffsNB/mSMiXai9mSq8WGz7dhn+Cw2ndcYBg2ecSAkAE1O1yIyBtJ+X7+NEa2
	M+XJhF8L9bZLbWHRHE615hHsJXmUjA7Vd136pxmxOM4mgcIBbVJj0iUP3rPCc2x9za1LLtyC5lj
	n20oh3onpz1yziRVAkQRceXTpfXmNr7qwAfN6gxo5IHh/jLq5szfFs70uh/vPIIeQEkKIhz3Jrf
	6BuwQK3X6zz4ZvUhQE2kkOdoGXbbGIYkVF5CTINxrb9CWy8eYUa2/Zi+ZpK86tdZfzkgMCA==
X-Received: by 2002:a05:6102:3588:b0:7a1:f980:e93b with SMTP id
 ada2fe7eead31-7cc926b0bc6mr656524137.23.1792592044313; Wed, 21 Oct 2026
 07:14:04 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021115400.30885-1-mike.michalo@gmail.com>
In-Reply-To: <20261021115400.30885-1-mike.michalo@gmail.com>
From: mixalhs <mike.michalo@gmail.com>
Date: Wed, 21 Oct 2026 16:13:49 +0200
X-Gm-Features: AclHuK-nUd4UmTxE9F3RBMXljFNNhLJJZePwWHLxIeXwrSoZlz9LU3TXba0QmGI
Message-ID: <CAO+rqLj5rF8MGMTRSav1n43NqLbazwyuPsPKgiQT2qtP+EDxeQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: restore Kerberos logins with released ksmbd-tools
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The ksmbd-tools side is up as
https://github.com/cifsd-team/ksmbd-tools/pull/347

Michalis

On Wed, Oct 21, 2026 at 1:54=E2=80=AFPM Michail Andreas Michalopoulos
<mike.michalo@gmail.com> wrote:
>
> Commit a47634cd729b ("ksmbd: expire SMB sessions when Kerberos tickets
> expire") added a __u64 session_expiry field to struct
> ksmbd_spnego_authen_response, growing it from 156 to 168 bytes.
> ipc_validate_msg() requires the response to have exactly that size, so
> the 156-byte response of every released ksmbd-tools, up to 3.5.7, is
> dropped and Kerberos session setup fails with STATUS_LOGON_FAILURE.
> The other way round, kernels without that commit, including the stable
> trees, drop the 168-byte response of current ksmbd-tools master, and
> ksmbd-tools has no way to tell which layout a kernel expects.
>
> Pass the expiry in the reserved area of the embedded struct
> ksmbd_login_response instead. ksmbd-tools releases with that area
> (3.4.4 and later) allocate the response zeroed and never write to it,
> so they send an expiry of 0, which ksmbd already treats as no expiry.
> The response is 156 bytes again, so it works with those releases, and
> every kernel also accepts a response that sets the expiry. Use two
> __u32 halves, as the reserved area is only 4-byte aligned.
>
> Fixes: a47634cd729b ("ksmbd: expire SMB sessions when Kerberos tickets ex=
pire")
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/CAO+rqLhpPvY0NLrAnZjFXz0gOXnA6zsXxK8x=
CgtA42XUkSsAeg@mail.gmail.com/
> Assisted-by: LLM
> Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
> ---
> The matching ksmbd-tools change (struct layout and mountd/worker.c)
> will follow as a pull request.
>
> Tested with a local MIT KDC and smbclient --use-kerberos=3Drequired:
>
>                     3.5.7      master     master + tools change
>   7.2               login OK   fails      login OK
>   7.3               fails      login OK   fails
>   7.3 + this patch  login OK   fails      login OK
>
> With this patch and the tools change, smbtorture smb2.session over
> Kerberos (including expire1n/1s/1e, expire2s/2e and expire_disconnect)
> and the 190 smbtorture tests run by the ksmbd CI over NTLM give the same
> results as 7.3 with ksmbd-tools master, with no kernel warnings. NTLM
> logins also work with 3.5.7. A test-only mountd that overrides the
> expiry (including values above 2^32), the response size and the length
> fields found no wrong session expiry and no kernel warnings in 313
> logins.
>
> Current ksmbd-tools master needs the tools change to work with this
> patch. If you'd rather the kernel also kept accepting the 168-byte
> layout, I can add that in a v2. Only tested with smbclient and
> smbtorture on x86_64.
>
>  fs/smb/server/auth.c          | 3 ++-
>  fs/smb/server/ksmbd_netlink.h | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
> index 1b24eb3f3998..8e5a1b10db6a 100644
> --- a/fs/smb/server/auth.c
> +++ b/fs/smb/server/auth.c
> @@ -464,7 +464,8 @@ int ksmbd_krb5_authenticate(struct ksmbd_session *ses=
s, char *in_blob,
>         memcpy(out_blob, resp->payload + resp->session_key_len,
>                resp->spnego_blob_len);
>         *out_len =3D resp->spnego_blob_len;
> -       sess->kerberos_expiry =3D resp->session_expiry;
> +       sess->kerberos_expiry =3D (u64)resp->login_response.session_expir=
y_hi << 32 |
> +                               resp->login_response.session_expiry_lo;
>         retval =3D 0;
>  out:
>         kvfree_sensitive(resp, sizeof(*resp) + resp->session_key_len +
> diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.=
h
> index 2673522c76bc..fc6af757e45e 100644
> --- a/fs/smb/server/ksmbd_netlink.h
> +++ b/fs/smb/server/ksmbd_netlink.h
> @@ -148,7 +148,9 @@ struct ksmbd_login_response {
>         __u16   status;
>         __u16   hash_sz;                        /* hash size */
>         __s8    hash[KSMBD_REQ_MAX_HASH_SZ];    /* password hash */
> -       __u32   reserved[16];                   /* Reserved room */
> +       __u32   session_expiry_lo;      /* Kerberos ticket expiry, SPNEGO=
 only */
> +       __u32   session_expiry_hi;
> +       __u32   reserved[14];                   /* Reserved room */
>  };
>
>  /*
> @@ -286,7 +288,6 @@ struct ksmbd_spnego_authen_response {
>                                   * stored in SecurityBuffer of SMB2 SESS=
ION
>                                   * SETUP response
>                                   */
> -       __u64   session_expiry; /* Kerberos ticket expiry time */
>         __u8    payload[]; /* session key + AP_REP */
>  };
>
> --
> 2.56.0
>

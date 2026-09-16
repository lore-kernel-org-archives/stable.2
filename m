Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D24D0CF5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576236; cv=none; b=KxoRWkHWTouhxrP1mDBvmxwQThbu6X0nCEBojfNTeelC60bUmHT+8uLACv/W9sU4kNlKOtj/C0y+7+cPYOAYF3ns5NiztLnIjtC8uFVxgfOoLXX/wc49QPIvKr/aG6WwiTRZY0seArCdbTqy1KJhrSLhVVoaoWYiqMKbWk4T8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576236; c=relaxed/simple;
	bh=Ox544Vsbfo/QHOyeKEGPY6gQVJxwBLb5ycIVERZXEtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbRFDarFhs+cqNLsOQykgiH0RMtTVMzpg2m+/cMZZcuiYeKcPdS+p9Ki5Gdv7tiktzVAgiPB1hQL2y6oRoE9r/ur5DRNqUUIWwodpjg/VGnocQaR8XMspcXLcbFQsfv4vaTxpOg8ACQldAyQ3kYP7GbSw4WtKEmDqPLzBe/HZ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NyU+Il/X; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NyU+Il/X"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so1995859a91.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789576233; x=1790181033;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4KWrmgW+jcd+uGNWqzhxdl18Pn4sBNlAfNbUcpFs4o=;
        b=rbabFErz44luG4lYwqCek/uPqIYUF/NANCR6GYWe6EUzzB7HBb0u2l1mTvtkxFPTEw
         1tc5oZjC+RevKRYn52SI1J7AP8iD3jj+p0AtenyQD/hITGtzlfkBraVBm5WVy17CBR5O
         6MLpkDIZPz8+W6TtPwiz0mayCU+aX+Vw9vVvw7wZ4UAyRE50zHy+Bz79zfsIhsCSC24f
         R3EmpTOvGLNS+vJy8aTabkdUDnUkEJTmkKm5G6TxEA1CWE+PD+IjfkuooQiJhv+BrL4L
         +dwFmHRqHOkibI9t+mJ/qZ8XpPAGdipixFtrlKHKAt+9041XOkAJzo5+m51Dg0fV3nir
         dSzg==
X-Forwarded-Encrypted: i=1; AKwUvBxNvteUgbnyohlDEkbkO+OeVnOHHlKOnxZKBipwRB6K8pVeSobgby09DaL/dfDC4ftq3S099Cs=@vger.kernel.org
X-Gm-Message-State: AFuF++kUnvfr95xdbpCqLLlEqFnJYyr3cUq3sM9UGFRdp49o3UNzzCWr
	kkhMHGn4W2ZwIo4L3jAd8pZ4cgQiuxazzpkYaDHY0uWV6d0LnaUjyVmbC6YmgqyX6mtivnK0Coi
	QNowmRLdxzSZloeML826rHXQCdmiDLF/JvKPhrs7taXp/cGjqowZdMRRF+oGYHt+mcHyPtMDX3d
	2QvsRhbOsLYHFHtY/KyjGnpYl95PQtEFrNd86/XxY7RPOpWRIJ4DFypDvMijmG9yxdVcJ4kX0RT
	Gj1/oZ5fjWek2uxUA==
X-Gm-Gg: AYBFou393KrItXt8hTPBAjPNW9tJ8vgkb3qJF/8I48MRO0Fia4FjNfOGVDZoLRZzi5E
	QfQg1s4OMtvackBaGc69CarCuAdH/JwRbaxUKsuEQi9EJLyDn7mLo3GmAGG729bz5tRJn8CGDtg
	k53bH/fw5O0r88CEpTHVqkb8N0b3Q0Gahb4gUpMTv74og6TQWTQX0BNxpqTxesXkdQm7o2UpDpM
	QyZRtFPJMaFxkTMeah2MzSLy51d6ZwqR/am8nzaQfJqHGLol70MgXJV0RBMLhudRJI6HUealCTd
	oc6GcNthSrbtRqPvRqfZK3m39cpk9DOCkqPJkLeSQUHupewLdlV6MlRef/x3bTx3UwZOMzwLXH5
	2QojFVQO7/Rv2yCRgsVIneoRqH9d8ZLUuZAJREWgmfzbzSKRPnnwKzhmULKzYh2rgfkuybb2g3F
	Lw3CqHboMc+OaqatV1LdLb1U0w8Y7WQYR+2VEO1Rk=
X-Received: by 2002:a17:90b:2648:b0:39d:f70f:f034 with SMTP id 98e67ed59e1d1-39e1e2f4d41mr9606311a91.10.1789576232585;
        Wed, 16 Sep 2026 09:30:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-14395d60fc4sm115198c88.6.2026.09.16.09.30.31
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 09:30:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a98e5d6e49so7340372a12.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789576230; x=1790181030; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4KWrmgW+jcd+uGNWqzhxdl18Pn4sBNlAfNbUcpFs4o=;
        b=NyU+Il/XN/iKaC1BjOPFvlPXrxra/thedhEFRy09gxJj2j02jKaOVnXYBchOn5aPd5
         OLorulIy0UPIpBbFgZogZ4Z1dMZTMuLtyjkVg20JPFDLjQvxbPINSrpN+5w96zwQRQHl
         YBJ5YQH9+qhbfDxH5zSWNbpINuYd8Ui9spOvE=
X-Forwarded-Encrypted: i=1; AKwUvByBhsN29s98VYc9nBt4P+FZR5Uh2ocexlCVskNr3aJ8DoFHP3lRlDhc9Fflx/LEjT13xyD3FVE=@vger.kernel.org
X-Received: by 2002:a05:6402:450b:b0:6a6:32f5:90b1 with SMTP id 4fb4d7f45d1cf-6aa22433a12mr5727912a12.19.1789576229874;
        Wed, 16 Sep 2026 09:30:29 -0700 (PDT)
X-Received: by 2002:a05:6402:450b:b0:6a6:32f5:90b1 with SMTP id
 4fb4d7f45d1cf-6aa22433a12mr5727846a12.19.1789576229274; Wed, 16 Sep 2026
 09:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825191619.2326087-1-danesh.petigara@broadcom.com>
In-Reply-To: <20260825191619.2326087-1-danesh.petigara@broadcom.com>
From: Danesh Petigara <danesh.petigara@broadcom.com>
Date: Wed, 16 Sep 2026 09:30:16 -0700
X-Gm-Features: AcwNN1UI2rn9CuIcapnWbtjF0yW7-pc0JUcoRwAuIIKv4HjYApcFiqau8nGwTHQ
Message-ID: <CADvvoPnp5cWDj8ogLAuZR_=mDi78K5uJFLUXrvo-jo8ctPKasw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: bcm74110: Cap rx_svc_init_list growth to prevent
 PMC-induced OOM
To: jassisinghbrar@gmail.com
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com, 
	james.quinlan@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007ef6d2065b9c2fbd"

--0000000000007ef6d2065b9c2fbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

A friendly ping on this patch. Is anything else needed from our end,
or does anyone have feedback?

Thanks,
Danesh

On Tue, Aug 25, 2026 at 12:16=E2=80=AFPM Danesh Petigara
<danesh.petigara@broadcom.com> wrote:
>
> From: Florian Fainelli <florian.fainelli@broadcom.com>
>
> bcm74110_rx_push_init_msg() allocates a GFP_ATOMIC struct for every
> BCM_MSG_SVC_INIT word received from the PMC co-processor and appends it
> to rx_svc_init_list with no cap on list length.  The only consumers of
> this list (bcm74110_rx_pop_init_msg_block / bcm74110_rx_flush_msg) are
> called only during probe and at shutdown respectively; after probe
> completes, PMC firmware can continuously inject BCM_MSG_SVC_INIT words,
> exhausting GFP_ATOMIC reserves and causing a whole-device denial of
> service.
>
> Add BCM74110_INIT_MSG_MAX (16 entries) as the maximum list depth.
> bcm74110_rx_push_init_msg() now checks the count under the existing
> rx_svc_list_lock before allocating; if the cap is reached the message is
> dropped and a rate-limited warning is emitted.  The new rx_svc_init_count
> field is decremented by bcm74110_rx_pop_init_msg() on successful dequeue
> and reset to zero by bcm74110_rx_flush_msg() on shutdown.
>
> Fixes: 52436007b862 ("mailbox: Add support for bcm74110")
> Cc: stable@vger.kernel.org
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Assisted-by: Anthropic:claude-sonnet-4.6 cursor
> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
> ---
>  drivers/mailbox/bcm74110-mailbox.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mailbox/bcm74110-mailbox.c b/drivers/mailbox/bcm7411=
0-mailbox.c
> index c8709d509912..bec138d76914 100644
> --- a/drivers/mailbox/bcm74110-mailbox.c
> +++ b/drivers/mailbox/bcm74110-mailbox.c
> @@ -97,6 +97,8 @@ struct bcm74110_mbox_chan {
>         int                             type;
>  };
>
> +#define BCM74110_INIT_MSG_MAX          16
> +
>  struct bcm74110_mbox {
>         struct platform_device          *pdev;
>         void __iomem                    *base;
> @@ -105,6 +107,7 @@ struct bcm74110_mbox {
>         int                             rx_chan;
>         int                             rx_irq;
>         struct list_head                rx_svc_init_list;
> +       unsigned int                    rx_svc_init_count;
>         spinlock_t                      rx_svc_list_lock;
>
>         struct mbox_controller          controller;
> @@ -148,7 +151,15 @@ static void bcm74110_rx_push_init_msg(struct bcm7411=
0_mbox *mbox, u32 val)
>         msg->msg =3D val;
>
>         spin_lock(&mbox->rx_svc_list_lock);
> +       if (mbox->rx_svc_init_count >=3D BCM74110_INIT_MSG_MAX) {
> +               spin_unlock(&mbox->rx_svc_list_lock);
> +               kfree(msg);
> +               dev_warn_ratelimited(&mbox->pdev->dev,
> +                                    "PMC INIT msg list full, dropping me=
ssage\n");
> +               return;
> +       }
>         list_add_tail(&msg->list_entry, &mbox->rx_svc_init_list);
> +       mbox->rx_svc_init_count++;
>         spin_unlock(&mbox->rx_svc_list_lock);
>  }
>
> @@ -225,6 +236,7 @@ static int bcm74110_rx_pop_init_msg(struct bcm74110_m=
box *mbox, u32 func_type,
>                                  list_entry) {
>                 if (BCM_MSG_GET_FIELD(msg->msg, FUNC) =3D=3D func_type) {
>                         list_del(&msg->list_entry);
> +                       mbox->rx_svc_init_count--;
>                         found =3D true;
>                         break;
>                 }
> @@ -248,6 +260,7 @@ static void bcm74110_rx_flush_msg(struct bcm74110_mbo=
x *mbox)
>
>         spin_lock_irqsave(&mbox->rx_svc_list_lock, flags);
>         list_splice_init(&mbox->rx_svc_init_list, &list_temp);
> +       mbox->rx_svc_init_count =3D 0;
>         spin_unlock_irqrestore(&mbox->rx_svc_list_lock, flags);
>
>         list_for_each_entry_safe(msg, msg_tmp, &list_temp, list_entry) {
> --
> 2.54.0
>

--0000000000007ef6d2065b9c2fbd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
GLYYHVIFsNlNBk9ehmbzaNAGKDZQL2g6yMMOyfvt2s5Y4jecunfY+Sf5c3Ptg5X23fqYpno7w5us
Fyf9UX0AfPQxXj3xOYXXOmW3wHsEwXQ/ix4BSk+9TqzVwMiNm1pyqJUxPMdUwUzCVHZBhftOjpfn
FV7xK09ekAS7/FgXzG/fp2YRiinLawP/OAq2Jso3/NzsEOjKVDyQp9NjKBvnT2KPEG0EQ/YHKXaN
G0nhKAI9CNoSnLc+L6668zqiuyfY+4GBwm5fx3YFPlYZHr0JcusCAwEAAaOCAeAwggHcMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNy
dDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2Ey
MDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8E
OjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5j
cmwwJwYDVR0RBCAwHoEcZGFuZXNoLnBldGlnYXJhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUYZsdWn6M
L18zay5xy95GDwiowUEwDQYJKoZIhvcNAQELBQADggIBAAO+GZJHoHFGjKzRRmPg8zMhqkUoAurb
EVL1A6UGmL2cSAOuQcZdI5ESkaDFKYuhsSB3dEr6ZWVhQk5p+AP2MxVJ8SViEV7NP3DVtFwqaE3I
VongrfkM+43NJTKEUBTJHYFGsANIUubqC3I69Dw8PxFghAU6M6nJxqAvNgxjMR0GRlJUR9eRR3GY
QszACooBBuGtl8VM9fZKqQUuu4ypKu4coRSbwWqKKuJXfElWpqakEjgK2szPloPPAvrfXN4//ilz
Rcgf+v6s6tPvaP0Kuf8Kvk3qLxHGVFzFdzLcwKEm/H28pKAXxd7nHiUQcddZjwhYtLahzfF0PCxP
W+RDL3K2gf3KD5nDX7Fx8bsYFQDrDWJa1cpuLVjzhkuWx/k+6hJ5NJLRB6OnHNnggQADstvnT4Z/
FdAzNY/Cppgsu4XfgsPmrDAoXyiFvcjHRS7J5hr0ce7W57bdKVlEVdeK10o1/23F8H37kp0V2mYj
7gmkwjbisZjfklj55cFq9czwyMyedkz0EW1u4CNRfwSZ/a6tZ1dwGPSe4CJcUdbKR7N3tnOwPzO8
gWuU54A5ADxxRL34dPcj7LevtZo+7co9qIEdODq3zfJRjEmnKnHeWLRzV9HrM6rn3l47QP3YlxjV
hbZundqE7qI4+OxL2uh7uYgN4JIdKmzkZRYIcWa/uPc1MYICVzCCAlMCAQEwYjBSMQswCQYDVQQG
EwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0Mg
UjYgU01JTUUgQ0EgMjAyMwIMXIDSN3UslytorZSOMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3
DQEJBDEiBCCHSgxVZBXAaBgixHARt4ZryEaa2kU/LlfhvydETRHpYzAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MTYxNjMwMzBaMFwGCSqGSIb3DQEJDzFPME0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA+a78NLV7/tcKupzG4d0k21TM+
nlhPYUxHSltjbQD3psqsSp05xE0CZxXIPxjivj2+UQ3R5s0gP/0G3DiurBAosqs8f8kxZf0Xrdea
wFTbhVPn8+cfgBhD+FKAyCdK/4rCke49zgn6QmJijfrhpqFzKGv9q0HM8GOsQ4OLEja8o3iXQg3M
iMy/0ilZP+k28kVsF8JWCH5ZZxHPO2GuLOdmi4pEGX5AdaSVA9o1IBqNgDxpCj5cNhi0V/ziGS5N
HBlhBubqRiR5aAylQzwlkm5yNTJpAnaz8bh8U48BrrrV18cqxn6E64Ii0BD+4vCx1/KO61Xnr66v
oWT9fch/bVZr
--0000000000007ef6d2065b9c2fbd--

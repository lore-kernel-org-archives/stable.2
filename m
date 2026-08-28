Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE022083
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875490; cv=none; b=jSscZltOCQf2l8bF/WUba4LCH7Dd8iIYl0YKZD8RGszlOkqe7o8Qihl2UovpSIwD2bpnRe9bW9bF6gDxpltNVmnytq5XNyv9xn460xFT9XNi7QHR7mhltLF0JESA2n6xEIaMBGov/DpBOyMwpB83/xOstVYNLanWfZAqXF4AWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875490; c=relaxed/simple;
	bh=9j5omQk36QDURWU8B0XNaSqxfLh+2W9pm41xdsF0v04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSk0+w9H5SuJSTJNqv1v6tB8fQd9YaviKaE64zIUN48Nr6SazcE8goK1iWO1hgjeP9jX0el9cDOjBFM6G/XYxJ83c6MxBXptbpqbS7iIBsTSvlRS0rxlPehhXll5InPC+iqzZz/0FW69Nudgr1dBCgMXp7QbUbX/d/0Y6AyPxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fmzzqfc2; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fmzzqfc2"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-39652a6e963so1487534a91.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787875488; x=1788480288;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wd5+C+BK634kHGFN8JKEvF9EOXyO3v+xfFXg0PDZT9g=;
        b=sa7Sas3sort4Ilqhfa5rJx5CfYVbC5NxJwnrtmDuForhoCHv6k2jA1F4dN/SmGdzXR
         03VO4hdU/jO6iwPRroSwysA+Ll1ssnYHh4ctQQydTyGhe0xCmAc5q/Uhx6zOLWCk3NDk
         S07I/eJuWehFRyTCmmOg23ms1aAm48zUiUIUOEFRXQOdyQMVTdaiJHC5WpZJ3JA0+Hpv
         8kSsfORABB2rXsQoi2YlSbfoVBt7mjFsMKEM3yoSWCKeiOluxWmndOJbIZ2QNlLrkA9W
         GgBbQsIvSylou25fdnHQyta1znr1YxMvN4OUlqnxrYDQSOzV3DY+pFmBRSw3PPc18zkv
         YiEg==
X-Forwarded-Encrypted: i=1; AHgh+RpbqkmM4mnUbFuLIKfGjlOZROqWT1vu1fu3tm8m2D8PvrkuZLMiokMnFJorm0YLoiq+LNF/3Zc=@vger.kernel.org
X-Gm-Message-State: AFuF++mEnwsyVitlo3UpW1EiQPiTr5pYdqz0rpbfyBLIy613LyDGSO1I
	D60kRZDbyJJCi3SWllRW0ti2X872yebnkNRstrfwdBGBOqLD2vghnVJ2kPX5ozcg1G4E237W3wg
	PrI0p9H4xz0BOnK+LEAqjIWclOoRcJgW9sS66kROXPNV6XwrI85cc4Qe/GnBtnycPTm01JZBx4v
	fFlyW4N7VPg4Q35Bj/COguW0qEh6fINRDGYGdVPB92Tj6RlX7H8LYaU9QDgoyOX1YmgIlKF68BG
	Y2rV3adkOzM+nlWZQ==
X-Gm-Gg: AR+sD11QnqN9p7cJa/k2TIdDLd5dyiYbQtNz5ly+V1Jog/FUPBhWT2uEB4Ri1PeRvHp
	2hzijvuNNzMhHUSxKRnWqNlyUAUkIGJvYdekXMUVIh5nsHCSqbzIvxusv6d7GTJq/eNIm10gA8A
	WSctk+WeMN6aXBkICe4c6qN+V5epiaQYJudsPdqx0yfLELsZ3af0sKy9IvTQkSIqKZHg121twjw
	u3w/drqaDxpBnWX81iZz6CDs9xeAYxGr1/m1lOQrX1Brjw3Xo7OAxGKLu2WNHR0UOMj5mFctNl3
	cuDpxbKWqmQyhPAAj/1J5QFbUCz5F+753DEZ7sJCIuslGlvLZ4ufMv0CT00LPnIb9MZOTkvR2dK
	tFlZ0o9c+mwySztCl0VuRinofDRFK5fk4JuHRl7h/wzkMy2JD43jytcnSy+0PwLE3XzPtAqtUFW
	ZVPSDJBwatLPEuqELdaGKOtpr0QGdSoeMG6kQ1xV0=
X-Received: by 2002:a17:90b:574c:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-396d0d8fcd6mr3040432a91.3.1787875487680;
        Thu, 27 Aug 2026 17:04:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-396b0d3788esm1538719a91.3.2026.08.27.17.04.47
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2026 17:04:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a17c83732fso297205a12.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787875486; x=1788480286; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wd5+C+BK634kHGFN8JKEvF9EOXyO3v+xfFXg0PDZT9g=;
        b=Fmzzqfc2CKjfhSK2WRIYAN+unq3dS962QrntcvuWwTABxcZyIe7F4qVoH9c7QJ7XaV
         EH4zFflaJJhvL0fwEovWl1q9H4g+RyzmZ4OeMSz6sbYmY2xIAgMOk7df+PdaZRmgunfo
         tAo7KUOCj8C++Tm7g/Dnm5d2neLfTouQINl4g=
X-Forwarded-Encrypted: i=1; AHgh+Rop6dtpLtTB4cODeAdbrBLfBWXTQIqAfhl8CCTBQSMujF8z6o5skgLSmyk5jxPrTO5Afjht+FE=@vger.kernel.org
X-Received: by 2002:a05:6402:3223:b0:6a1:2efd:8687 with SMTP id 4fb4d7f45d1cf-6a60d3fb582mr1361123a12.14.1787875485733;
        Thu, 27 Aug 2026 17:04:45 -0700 (PDT)
X-Received: by 2002:a05:6402:3223:b0:6a1:2efd:8687 with SMTP id
 4fb4d7f45d1cf-6a60d3fb582mr1361098a12.14.1787875485255; Thu, 27 Aug 2026
 17:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
 <20260826201500.3000125-2-danesh.petigara@broadcom.com> <067b7e2e-f2b2-4462-96f1-3a1e35bd25e8@kernel.org>
 <682b68a0-03b7-4ec9-9d17-698fe134b57a@broadcom.com> <e21a7302-44db-4e20-805b-5c1de1f59c56@kernel.org>
In-Reply-To: <e21a7302-44db-4e20-805b-5c1de1f59c56@kernel.org>
From: Danesh Petigara <danesh.petigara@broadcom.com>
Date: Thu, 27 Aug 2026 17:04:33 -0700
X-Gm-Features: AcwNN1XUceWGwVwlW2dOau8CzdU833EI-wCjdUdMcHAYLRgGIhobFHSxU9_Pxm0
Message-ID: <CADvvoPmQ2nhfWSHGvAVyFyK4FoA3p1juWETOohSpCeGiKBGKWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] memory: brcmstb_dpfe: Fix out-of-bounds access due to
 DCPU offset
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, mmayer@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003f51a1065a103361"

--0000000000003f51a1065a103361
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 2:31=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On 27/08/2026 19:37, Florian Fainelli wrote:
> > On 8/26/26 23:48, Krzysztof Kozlowski wrote:
> >> On 26/08/2026 22:14, Danesh Petigara wrote:
> >>> From: Justin Chen <justin.chen@broadcom.com>
> >>>
> >>> On API v1/v2 boards, the DCPU coprocessor can steer kernel readl_rela=
xed()
> >>> and writel_relaxed() to any address within 256 MB of the ioremapped D=
PFE
> >>> dmem or regs base. The DCPU firmware provides a 28-bit offset which t=
he
> >>> driver adds to the ioremap base without any bounds checking in
> >>> get_msg_ptr().
> >>>
> >>> This allows a compromised DCPU firmware to trick the host kernel into
> >>> reading or writing arbitrary memory-mapped I/O registers in vmalloc
> >>> space. When combined with a root-writable sysfs file like dpfe_refres=
h,
> >>> it provides an arbitrary MMIO write primitive. Similarly, world-reada=
ble
> >>> sysfs files can be used to leak other devices' register contents.
> >>
> >> If someone can compromise firmware to provide different addresses, the=
n
> >> what stops this person to change DTB with completely different MMIO
> >> ranges for this device?
> >
> > On our platforms the DTB is part of the boot loader which is
> > signed+encrypted and customers do not build any UART driver or
> > user-interface so changing the DTB is somewhat difficult. Same goes wit=
h
> > the Linux kernel, it's also signed+encrypted. This is defense in depth
> > at this point.
>
> Ack
>
> >
> >>
> >> Isn't better just to drop root-writeable sysfs interfaces, since they
> >> are the insecure parts?
> >
> > Yes that would probably be an acceptable move forward. Markus do you
> > remember what was the use case for the dpfe_refresh file to be R/W?
>
> That's in this case separate solution, worth anyway investigating.
>
> >
> >>
> >>>
> >>> Fix this by recording the resource_size() of the dmem and regs iorema=
ps
> >>> at probe time, and rejecting any offset that, along with the largest
> >>> field accessed (DRAM_VENDOR_ERROR + sizeof(u32)), exceeds the recorde=
d
> >>> mapping size.
> >>>
> >>> Fixes: fee5f1ef6cf7 ("memory: brcmstb: dpfe: support new way of passi=
ng data from the DCPU")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> >>> Assisted-by: Gemini:gemini-3.1-pro-preview cursor
> >>> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
> >>> ---
> >>>   drivers/memory/brcmstb_dpfe.c | 22 ++++++++++++++++++++--
> >>>   1 file changed, 20 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_d=
pfe.c
> >>> index 08d9e05b1b33..66343205f585 100644
> >>> --- a/drivers/memory/brcmstb_dpfe.c
> >>> +++ b/drivers/memory/brcmstb_dpfe.c
> >>> @@ -182,6 +182,8 @@ struct brcmstb_dpfe_priv {
> >>>     void __iomem *regs;
> >>>     void __iomem *dmem;
> >>>     void __iomem *imem;
> >>> +   resource_size_t regs_size;
> >>> +   resource_size_t dmem_size;
> >>>     struct device *dev;
> >>>     const struct dpfe_api *dpfe_api;
> >>>     struct mutex lock;
> >>> @@ -401,9 +403,14 @@ static void __iomem *get_msg_ptr(struct brcmstb_=
dpfe_priv *priv, u32 response,
> >>>      */
> >>>     switch (msg_type) {
> >>>     case 1:
> >>> +           if (DCPU_MSG_RAM_START + offset + DRAM_VENDOR_ERROR +
> >>> +               sizeof(u32) > priv->regs_size)
> >>> +                   goto bad_offset;
> >>>             ptr =3D priv->regs + DCPU_MSG_RAM_START + offset;
> >>>             break;
> >>>     case 0:
> >>> +           if (offset + DRAM_VENDOR_ERROR + sizeof(u32) > priv->dmem=
_size)
> >>> +                   goto bad_offset;
> >>>             ptr =3D priv->dmem + offset;
> >>>             break;
> >>>     default:
> >>> @@ -415,6 +422,12 @@ static void __iomem *get_msg_ptr(struct brcmstb_=
dpfe_priv *priv, u32 response,
> >>>     }
> >>>
> >>>     return ptr;
> >>> +
> >>> +bad_offset:
> >>> +   dev_err(priv->dev, "DCPU returned out-of-range offset %#x\n", off=
set);
> >>> +   if (buf && size)
> >>> +           *size =3D sprintf(buf, "ERROR: DCPU offset out of range\n=
");
> >>> +   return NULL;
> >>>   }
> >>>
> >>>   static void __finalize_command(struct brcmstb_dpfe_priv *priv)
> >>> @@ -858,6 +871,7 @@ static int brcmstb_dpfe_probe(struct platform_dev=
ice *pdev)
> >>>   {
> >>>     struct device *dev =3D &pdev->dev;
> >>>     struct brcmstb_dpfe_priv *priv;
> >>> +   struct resource *res;
> >>>     int ret;
> >>>
> >>>     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>> @@ -869,17 +883,21 @@ static int brcmstb_dpfe_probe(struct platform_d=
evice *pdev)
> >>>     mutex_init(&priv->lock);
> >>>     platform_set_drvdata(pdev, priv);
> >>>
> >>> -   priv->regs =3D devm_platform_ioremap_resource_byname(pdev, "dpfe-=
cpu");
> >>> +   res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-=
cpu");
> >>
> >> You cannot use devm_platform_get_and_ioremap_resource()? Are the 'reg'
> >> entries flexible/random?
> >
> > IIRC the names and indexes are stable so we could do a positional index
> > resource lookup, but maybe what we want is to introduce a
> > devm_platform_get_and_ioremap_resource_by_name()?
>
> If the bindings enforces strict order, that could be a way, but I do not
> want to push towards new
> devm_platform_get_and_ioremap_resource_by_name() because that could lead
> to long patchset with bikeshedding about how many wrappers we need...
>
> Approach is fine then. New wrapper can be brought on top.

I would like to confirm that the patches are acceptable in their
current form, or if
they require additional changes.

Thanks,
Danesh

--0000000000003f51a1065a103361
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
DQEJBDEiBCCO3wrjOyUyfp2jEIyvg45N5IAaISVn3/wJDjaYKU9w/TAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MjgwMDA0NDZaMFwGCSqGSIb3DQEJDzFPME0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAHYlHT3rH44NTd991W2KaGblzy
3Sgmp3vm94XSfkwNHnCb7JFUVeRwhzO/jiVvWj6xPM2cIfrLeuCMmQZY36ZWSu8HpIK18XkbaPsE
ROy7pp6p4ZJ1Hyei2CObJHVG+5TdKRc6vWsfZCCoX8eZ3R/6scKeZ7Mcg+40VNxQ0DErZ+5IeAcS
7QjorOmxKrzqjgtQ8owJgJYSl7PQgErLSMS96m7AG6KR9nMk7QRu/gRRkgeDvqLgLAcGCsWIWHNX
xoGfEOHOjV2xFQXLCAGHvf6Y/nkLQl3vZ8Bp15Bup6Y0WzpVao1N7ON0hxr2a/es/kINtQKs3aIH
styQ+vKjuvSZ
--0000000000003f51a1065a103361--

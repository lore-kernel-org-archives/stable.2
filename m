Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73AF4B44BF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673643; cv=none; b=H3lQPKCsjMjL2ohDE6iCAf3KxzVx8aEd6UxTsv3n20ota9/NBbGaBGL8dfGVoNa/znWhM+z3FvrOszJuQfPA1PZM3/UnqnbqNH/dbHlIFgpVFdHA606hJWaWk2Mz8Gn8Ui0S9inlTnKfMyBRT3kB1atHTjRVRpXrCzFyuQLKD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673643; c=relaxed/simple;
	bh=+i8aPijUuJSgO/cNsu7ogh2G2PIYcX8borjvX6sSgns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii5Nr0fd5Zjw2khMeO8muaAmp2yY8e2En5NNaMuIvPxjdYt84Pj95jUf3WxDiUXl6HXeLnEjCWsGyxBiewC3QcU6ChiiOFa8pPrirC7GUIuRU5m4vnwJh3iLjs2QNDGQYcd8m4oSj3thxnff8jc+A9QC3oqYuAu5Lr0RHAmQJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V4gskZB5; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V4gskZB5"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2d9004f39d3so23915ad.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673641; x=1790278441;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2vVDN0dJVpXD0q9quxaARIQFSWAvNkdJUdopPPukK4=;
        b=Qf/wVf8P125SncX8p33l4F4Ryk+7tZmGimYg7WoKI+QIoq6xNHP9rXIOrZyF5kVLp0
         L8Fk4Ypxy9vBXlJ0TErJGgfbCc7Oel3YygxUsEOtMho39JN0UWU90yIku3Z1bKZPYNbn
         2HbTe6PkxlleOBGi0zRCTPWCvZqcF1jboPbfokUnSQX6F76An2Pu2uym33AjRNs5zrqP
         XAiJ0Y25CC8Fg+g3jTL25PLhi1iRIDTSvfX6dpg66lKdjLkvdZx1xlAeM0G3vGZ7mujH
         3zCBnTAV6OrUQ/HlfFZVwY62Ys7nixZ00M/92BoCY4XTP+WmKOGDIWvcZ9oFnM3Jb7Kt
         kCBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYDug4f6spiMbwbWN3Xl7E2/EuSM5Hg3NXTk9+knockirb/bg3U4itE6TEXbGPeBOZF1JT9fw=@vger.kernel.org
X-Gm-Message-State: AFuF++mmi8GagoCbSMFI+g1Ku87a6M26HPb/6ggdwO296PF8jwDeLJCF
	cxfBa47WgMAQ+SI0atF+i8l63leoM8/vQkEs53e1dVDRcrogvatZzPJ51XqF8ixAi9J4KG20GLf
	9hEPEuvzHI5p6toKpJtzfaR6WXmMN1TZ/nNUj2kJJGXv5hTmJbIvW1cVQbV4VsogAeXhN0SNH8p
	hapqB5wczy9V28ZcZ/GJSVPGBnlpEFz98Lan86kjfrjEM4Cu+hWnCyrNsX/GE2YZZALuRZDqRPq
	xj97Q==
X-Gm-Gg: AYBFou2/a3hA0mUVWp/SNadzIXxJUOYSv8lSfEJYRgwwURvxQ/8l73VFURBzHHi9nc4
	6qWwCod9cY8wwKX8zIBm7D+1CjpHTZEOD3Oe5MFRlD/7nRSFtAieqs2fFoIy2UJpAXV0prLm7xc
	nvBBwi6jQbVFbvHA1Ux4qs/MVt0FFOaupigCz8s5ZP2Cwt9n3KW5gkX9wlygUuKZuFVmdWwwNqi
	o8Nwo4aODcop2jBfPlg42r090DyCGGecotWPBsiOWfcYyde3+uvsIk00VVtyfPKAD66llPIYCwb
	OiK4SHCKCYyW4/xxG8KJUZDK6czRaOs6S68RwvoGrTa15fZrrItARWGU4dBK5XmKIz82TsB673j
	8cAyX6Fgne+xHj0dfQQ2Q36GLatD9FdNU+4lm14ajv20viXfjk2tyWPgS/Rezm9vCFWUeSpWfVc
	CbpJTqEUaaElOeyTWKVBgkF5/Ko+WaCP5V
X-Received: by 2002:a17:903:2ec3:b0:2dd:68a4:16f1 with SMTP id d9443c01a7336-2ddb1ade65bmr5012295ad.11.1789673640961;
        Thu, 17 Sep 2026 12:34:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2dd89f02fb4sm2896595ad.43.2026.09.17.12.34.00
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 12:34:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6713ebbca2dso44406d50.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789673639; x=1790278439; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2vVDN0dJVpXD0q9quxaARIQFSWAvNkdJUdopPPukK4=;
        b=V4gskZB5xim9gppPVgyaR2peY5ZjxQTfTdOEAI1GQEjrXt3aYY5rcLaUSCj8ubt+Ul
         EgNpNkuAeMEiaXaE8bJHvX8I2JhuCOplWUshv7L8ZR3KL10gdnGeUM4bhNLSAgWZpMVL
         EtPQ41onjjop6DxqdntbDJKeXzZmH5EypR3l8=
X-Forwarded-Encrypted: i=1; AKwUvBxZoV9O71GCRx+eipGIt9vllvsTbr+MZVud4H4qI105UxwIIhMgQ+SYGGpyaAGc9HMbmBisaxc=@vger.kernel.org
X-Received: by 2002:a05:690e:1248:b0:66f:c1bc:8800 with SMTP id 956f58d0204a3-6717fe2682bmr48214d50.89.1789673639650;
        Thu, 17 Sep 2026 12:33:59 -0700 (PDT)
X-Received: by 2002:a05:690e:1248:b0:66f:c1bc:8800 with SMTP id
 956f58d0204a3-6717fe2682bmr48208d50.89.1789673639203; Thu, 17 Sep 2026
 12:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917144330.2157527-1-vulab@iscas.ac.cn> <CAEQnVQ=4BOue0djLgtBG6fukuqjvcBknL9EXnSs6R0eYd4jybw@mail.gmail.com>
In-Reply-To: <CAEQnVQ=4BOue0djLgtBG6fukuqjvcBknL9EXnSs6R0eYd4jybw@mail.gmail.com>
From: Paul Ely <paul.ely@broadcom.com>
Date: Thu, 17 Sep 2026 15:33:47 -0400
X-Gm-Features: AcwNN1WrUxjfknpHF_DNHu4FD_QQwisWhKImRf7bB1Eed0nUVQ02cogBTvU8xSw
Message-ID: <CAEQnVQkcDdS=hZ66TBETxs=FguYe8EU8kyu2mCup_M4AnUKSGw@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Fix use-after-free in lpfc_els_rsp_rls_acc()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: James.Bottomley@hansenpartnership.com, james.smart@emulex.com, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	martin.petersen@oracle.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000925d6d065bb2dd59"

--000000000000925d6d065bb2dd59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixing bad email address list.

On Thu, Sep 17, 2026 at 3:32=E2=80=AFPM Paul Ely <paul.ely@broadcom.com> wr=
ote:
>
> The ndlp has an initial reference when first allocated and the
> lpfc_nlp_put moved is for the outstanding LNK mailbox.  Unless there
> is a driver bug with premature puts on the ndlp, this bug can't really
> happen.
> I would like to test this change before Acking it.
>
> Thanks.
>
>
> On Thu, Sep 17, 2026 at 10:44=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn>=
 wrote:
> >
> > lpfc_els_rsp_rls_acc() drops the ndlp reference held for the
> > MBX_READ_LNK_STAT mailbox command before it logs the ACC response and
> > before it takes the reference that keeps the node alive while the
> > response is being sent.  If that was the last reference, ndlp is freed
> > and the log message and lpfc_nlp_get() below touch released memory.
> >
> > Take the reference for the ACC iocb before dropping the mailbox one.
> >
> > Fixes: 12265f68ae92 ("[SCSI] lpfc 8.3.18: Add support of received ELS c=
ommands")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/scsi/lpfc/lpfc_els.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.=
c
> > index 4e3fe89283e4..bdf8fe3e77a5 100644
> > --- a/drivers/scsi/lpfc/lpfc_els.c
> > +++ b/drivers/scsi/lpfc/lpfc_els.c
> > @@ -8782,11 +8782,9 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC=
_MBOXQ_t *pmb)
> >                                      lpfc_max_els_tries, ndlp,
> >                                      ndlp->nlp_DID, ELS_CMD_ACC);
> >
> > -       /* Decrement the ndlp reference count from previous mbox comman=
d */
> > -       lpfc_nlp_put(ndlp);
> > -
> >         if (!elsiocb) {
> >                 mempool_free(pmb, phba->mbox_mem_pool);
> > +               lpfc_nlp_put(ndlp);
> >                 return;
> >         }
> >
> > @@ -8824,6 +8822,10 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC=
_MBOXQ_t *pmb)
> >         elsiocb->cmd_cmpl =3D lpfc_cmpl_els_rsp;
> >         phba->fc_stat.elsXmitACC++;
> >         elsiocb->ndlp =3D lpfc_nlp_get(ndlp);
> > +
> > +       /* Decrement the ndlp reference count from previous mbox comman=
d */
> > +       lpfc_nlp_put(ndlp);
> > +
> >         if (!elsiocb->ndlp) {
> >                 lpfc_els_free_iocb(phba, elsiocb);
> >                 return;
> > --
> > 2.34.1
> >

--000000000000925d6d065bb2dd59
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
iId6lRoDnFAsEvnaOMvg29iSc9gZaFsMAV8NLrmVgatBLqETEHgQ4n1BrE2+pRoymE80Zf+Qe5W6
GF5zYMjxe2smznZoexz/BISo+5QDZaKZKtmoZ3ApyLjKz1G5Q2hUhmZWHvMu/eGSXP59UaUUmelW
ZlVs3E0h345YpaGuBNlquYm35nQ3ehYjm2jqaIh7F7K0+eF5TPjcMLpqnpak12xIx6BCxmFi8Oqu
Gb9+KrrAD+KPgqzjyZZxdVcCAwEAAaOCAdkwggHVMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8E
AjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxz
aWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDov
L29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EM
AQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIAYDVR0RBBkwF4EVcGF1bC5l
bHlAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroP
ry1QLdugI4UYsKCSMB0GA1UdDgQWBBTc34vK15RY7h33segpWeDeAloTGDANBgkqhkiG9w0BAQsF
AAOCAgEAb0hABkNonbsXXPrDOwB9B9lRtVhdRszakaT0zWubTTtHAV/XTebY1b4caUC2iX9AJvr0
XTJrFAiLtJ6eeP6yQOjD+rBprWauwPUzydJWEftECpX/lbPgZLBSHx22euCSnIm8HNj8o0bMi+Ii
plCW6kU56G1krQY0jrqDJCFgH4Wmp1TrKi36iVTIXyYLDtPOcSXe9hLmeUlQuL4nAoB8EsI45w4a
5Wi/xS7vGQLXzXAQ2SY6Yuseqhh+QcXvzeb0uVB54edC4HFrVX9DtFzHXoyB9s0C29MZm2zpFPNS
DgwnsmTsvpPuLELuuaJvIKnSHHR9FKrmQZbmz/i6KyBt0enmjNk7I7vAKQa8IqZxSrjvR6tYExiq
BP9ZuiXJnuqoPujFE7kphkUjmK76yv8904eZNflTvcEDpthD1boifOzT78iQ3fbuytR8LKx7tzGV
Ga9+dcLBcR/eP85Vmc9NW1frtO3dRd26+DHs1lXX96Em5AAlvBgDw8b1GfyEvfimBkxTIWxR3mBB
jAMkNKrfvV7NxS9AfcFu4fvxuBJc+t2FN1zBc8VyVyn9ZBeJ2DYS9uQ2x00QPXMHqVlAT5fBanmS
n1fgcSTdHEy1fzVZIAtM1XMIWy03bJKNBwUebgxHKHSUCZ7VSMHE4jyERMCqkvTxU6h4JJ7YzRrU
jhXYo8oxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgx9OiWw8dVRSIkn
L+YwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPNIcm8D/CSfwkQtqgK7NeT6Q1Qb
nOW5NExJdfvU2ua4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2
MDkxNzE5MzM1OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBABVy6CJofERxShyMSwXkumOAvzIPyFAxlhwYwwKXg5AEUcirsWbDwN/8lUwx3eMQ
87uBeDqZ3UdIuxuDXJkTmJ8aH9je4VXDRow/TtdzR76ejJ4S6/Z6fw7A1lw4eN1BvBbnlFESG/h/
mf9prVOrm48yOrqFfIAlDAdaiDdi6oZsMmDSl2OzBnlPXJ20cJ4BAkYTMo/srjmy3YbHh83ojJF8
p962zaAXDqucs8qJBTt6QPiVPd+vRXOfkIbexRspwbq/8ZXOF7Fq1OFOVexUp2FLLazm8PgSm9qS
AYZO2uIKpZ72upX8N1YlAmKipwNNX1/KdrCZevHkmu5d2r0MF7Q=
--000000000000925d6d065bb2dd59--

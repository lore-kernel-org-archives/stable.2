Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD68383987
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321683; cv=none; b=K8P2LBqM7WZoVq4NQhxoV4tsiehiZMGVci6f83QP0DLaZcqQQejomuhzgxc4OPekGas8PbYJNjbR3jcZh8diMp11SXGPPNMzcYDT86/TCTMiIfAlkZgp+qFwRrUlwOlkVRG7YDuPh3jKaqExFDF4rwl+VqW8sFivStd+GCwOPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321683; c=relaxed/simple;
	bh=Kt9S1rOHx6DtrZ9QKEvBMZxXNXwwRK2DDPIZxqW/8Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYM5M9rZVVmx6YVCR2xGs5x4dLZV1azWqRVHK9OvMe/AxQIAy1Ju5TpW500oz73nKGCxE6fQNafC7HD/Y81n5wV6abDuNyM+3jbg0y338sKGTMj2CTHad7otQZHXJTYIkhmpUJo+u7cDW/bbeTGhv+JDB3psm2gUc7U00Z39Qlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OmS5Esjq; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OmS5Esjq"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso1219616b3a.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 14:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791321681; x=1791926481;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8F9xVMyUK/KZLnbbJvC/82/057OHfkSk8ZTc4/dUVuM=;
        b=z3MyBEe1qKpkeq2XtTlY5tK2LOb4oHpE3QT1f8u89dxWglDu4Edryqb7r6O5l+dtwO
         LfQ1oKxODnnSZi7lF015Qn2Ce2Gc+tciqsvffRazeRsXMd4FCkgAf3M+zXF//JqJaPup
         EoHGPW2bDcGJPeJpqdyvFW0x5BlLQKBDLHxDmd0sPVLkYQHfNffPRFHp+fvz8u3vDJCY
         K8mceDh21GBKJKhVlUFupRUG97WZzexpjptm+StuBkjdZUKlhgb5BJS/c7ah7JGRjdDu
         mH9N6V4CHNDFBb9ptpv6DDYp+KBSjjMDyiy0/DUJC88HGkMogFKekadvFEPtN940A7Y+
         YlSA==
X-Forwarded-Encrypted: i=1; AKwUvByrvN0xl+cqh3L6dCTguSVhIrjgiH1hCiJRWubl1b9PiPKKTX89XUtME7YJg0ifA5ENKSP0DiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++laettmAr8RhI7SPAo8Rot82y3785xPbRddC7RJpHPynOnFOlKz
	3uTmR9wiopWtZrEQhOgUk8AOk7BzVfzK5EN1mQqvxl/LUWtIvnVOXtOL3YewbrIa6Q3SgfrrZwR
	x0+V3W5GU8gYF1bUWcOk6Y1KAd4VT2+jgAvGnCpmq3MHb3Z79Ny7/sD/4y5f8RtEoJ3SHHfBFmE
	KLsBsS0s7y+kRioOBZ2m+oe9rgzYz9A7Peptf8JbIy7MSp7hDQyD4t45Bpu90JjocRLlYtCK8Mb
	uSXHg==
X-Gm-Gg: AYBFou0zY1ztQHI9DhrSs8neyieZT59ITOinvSwhKxCHLDT5zPlZV3gqRuSFSjeuEr1
	mnyiyGInrkAYBdUlmV7TM3uZ5kJmob2Mp7gnrM8qqfn9UWxUSVy+LU9OInSLP0o11SmSo9QraDX
	qYiAw7vux2vF0hwj9Gamvcinu50CkK9rim6cMFWflIoIXC1mjgtvB5MzX6MANt6XPwvvTTydJAU
	Jmrf2Im+v5zkWw0luP39lRZBUvutu3nwbEIhrwcBzW0mbQrD+Df0mJjeHZsD5QMtTDBiq3aTeXY
	VoD1q8VoNNFoz+7sIxrcWC0ZCBWXU+VtyoYuMQx6S0XZmI01HLLGaJvAxQxi4YnuH550T8TR4r1
	JiLRzc973CySM8ZLZKZW+PbBzIlwiYk1BXrSd16gheHlb1ECypg7UknKylTctoQvyoKey2hcAhs
	SZ5lMHlh1/ubPf3WZ5LQHoNGQ9UWiSxF+L
X-Received: by 2002:a05:6a00:989:b0:874:708d:b620 with SMTP id d2e1a72fcca58-891b41241c8mr313003b3a.30.1791321681375;
        Tue, 06 Oct 2026 14:21:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8919152149esm76659b3a.6.2026.10.06.14.21.20
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 14:21:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67697e6dfdcso6662287d50.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791321680; x=1791926480; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8F9xVMyUK/KZLnbbJvC/82/057OHfkSk8ZTc4/dUVuM=;
        b=OmS5Esjqp//UCKs7rOP4G5cCdi9vI7etqIMV4gC0OqaC7xHr75cBonpa+VcWniTI5R
         RocjIyrJ7JGx4L2gXxXdb1ERWCO8OCOU8s+FieFjSqvMTeieVzuh64/aU9yKrOh9TCUz
         z0ahYTKG2J/TlFDew0XO6Cin7BvwIs4vhCfXw=
X-Forwarded-Encrypted: i=1; AKwUvBy+QnKjlnsrw/LDChD7aUgJL06bGErfrbuglt/7LkIyXEOvt/Ut56+/WZ2rAU2HpeL3+JVskcg=@vger.kernel.org
X-Received: by 2002:a05:690e:bc1:b0:675:37b1:931a with SMTP id 956f58d0204a3-6790a0c3183mr204469d50.12.1791321679849;
        Tue, 06 Oct 2026 14:21:19 -0700 (PDT)
X-Received: by 2002:a05:690e:bc1:b0:675:37b1:931a with SMTP id
 956f58d0204a3-6790a0c3183mr204450d50.12.1791321679271; Tue, 06 Oct 2026
 14:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917144758.2157707-1-vulab@iscas.ac.cn> <CAEQnVQnWk2ADAvLEVCrgNE=dtf3D4DJ-UcosUQgGDj8=AMnA2A@mail.gmail.com>
In-Reply-To: <CAEQnVQnWk2ADAvLEVCrgNE=dtf3D4DJ-UcosUQgGDj8=AMnA2A@mail.gmail.com>
From: Paul Ely <paul.ely@broadcom.com>
Date: Tue, 6 Oct 2026 17:21:07 -0400
X-Gm-Features: AclHuK9ZSfOlyGbY5h0Kfvrv-muwnCR6dEPA3TUbGjoEl17TCh4tSpsHX0vjPvA
Message-ID: <CAEQnVQn7fpgpm5zY=8ne0G5M_KXWg4qjecMK6smk-q+_0j1PEw@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Fix ndlp reference leak in lpfc_release_rpi()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: James.Bottomley@hansenpartnership.com, james.smart@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	martin.petersen@oracle.com, stable@vger.kernel.org, 
	Nigel Kirkland <nigel.kirkland@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006c3c18065d3294e2"

--0000000000006c3c18065d3294e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since you are fixing up the return values, could you also fix the -EIO
in lpfc_sli_issue_mbox_s4 to return MBXERR_ERROR?  The patch will work
in case of -EIO return but clearly lpfc_release_rpi isn't looking for
a negative MBX return status.

Thanks



On Thu, Sep 17, 2026 at 3:35=E2=80=AFPM Paul Ely <paul.ely@broadcom.com> wr=
ote:
>
> Thanks Wentao,
> I need some time to read this one and test it.
>
> Thanks
>
> On Thu, Sep 17, 2026 at 10:48=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn>=
 wrote:
> >
> > lpfc_release_rpi() only drops the node reference and frees the mailbox
> > memory it took when lpfc_sli_issue_mbox() returns MBX_NOT_FINISHED.  Th=
e
> > SLI-4 issue path can also return -EIO without submitting the command, i=
n
> > which case the completion handler never runs and both are leaked.
> >
> > Clean up whenever the command was not handed to the port.
> >
> > Fixes: 4430f7fd09ec ("scsi: lpfc: Rework locations of ndlp reference ta=
king")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/scsi/lpfc/lpfc_nportdisc.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpf=
c_nportdisc.c
> > index 9c449055a55e..055f44ec7b94 100644
> > --- a/drivers/scsi/lpfc/lpfc_nportdisc.c
> > +++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
> > @@ -1142,7 +1142,13 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct l=
pfc_vport *vport,
> >                                  ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nl=
p_flag);
> >
> >                 rc =3D lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
> > -               if (rc =3D=3D MBX_NOT_FINISHED) {
> > +
> > +               /* Only a queued or completed command is handed to the
> > +                * port; other results, such as the -EIO returned by th=
e
> > +                * SLI-4 path when it cannot submit a non-polled comman=
d,
> > +                * leave the mailbox and the node reference to the call=
er.
> > +                */
> > +               if (rc !=3D MBX_SUCCESS && rc !=3D MBX_BUSY) {
> >                         lpfc_nlp_put(ndlp);
> >                         mempool_free(pmb, phba->mbox_mem_pool);
> >                 }
> > --
> > 2.34.1
> >

--0000000000006c3c18065d3294e2
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
L+YwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHANuGyVmHVOHyCjuIiMjdOiGnkT
z5wZCibE7zZ3gFVPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2
MTAwNjIxMjEyMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAINMDkgm/zyuoNNATN4GjTHWzq31u8uBw498sWEYQoFeFdgctlGgZ/vjVRF/Jm6z
35X/6r0vi5tEdamZQi/5LZUIYvlCgAHOKD+KzDWTIWXj1HqDg8fBpP34RJXsLS+bIaM6fZcpGCrg
f2I/KSJc424gvlfmwf2uK1veK/uZHQkhURMUnWZ1u6OD3UkAQBK4wiVgjJbEaaLaYeDxXtHP5vjW
iJGijF+GNxxrqQ7vaMRiIGOm1AUVyqMx+0MzGzuEtQZsxbP845ujdtVPrvFKueEuTpgkNhbrXQvx
6625bV5s5J564bHcR3mLJAM6kQU3MKbqAk2hamGx+LqnSAkYxw0=
--0000000000006c3c18065d3294e2--

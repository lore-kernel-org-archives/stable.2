Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE05221C1
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570807; cv=none; b=KEw6xXSmvdkrY3bVmRiOfMUMRYWZJD526WEihwuPZuhBkf4S2TBA2q4/kMM3aBr5sFmJx1F5sQmVauiS4beX8KjmiXvKLaZkyz8oHPfk+KNu6Z9/9D1YCJRkyC+NrJjXDApVihWw6r74FZ+Pqx0F5h7taDkwp8j/zOeqBZ1fGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570807; c=relaxed/simple;
	bh=yvU9oHb+hFl8FwijxSaqFg7lBzrCsu4dip8LTxE/sFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VgHf0tvQFsILzUeRM8B8HLYg2Txo4IlwRg8fyb/UNVCRGuMRTh7BTBCCTBMtdRE4dOcs5mL+9vsyJA9PqX+omt39y/P3R0WNBr8c5UD902mTfW9zJIB7f3lvBd8PguKsjAC0kBxafcZxS3BLYihtNBXqGcv/WYCO3fLFDeFjy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LWF6N8TQ; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LWF6N8TQ"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab62a8250aso572739a91.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 11:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570804; x=1792175604;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=moNJTzsnyEw30BK2pKOVipkU2KI1iBHtf1ufqL41E7M=;
        b=rnOIfAsycVXBYVp4EwKAqKbOVmkJg0JcntRk5M8BPv98upu9Dwtl67rtk8jpmghYiC
         0BFmC5TJ+Xsc2beF2dathpezDRYAE+KP5/RDMWd2TkdKNDWlUl/S3d193iTyNVfvmxL0
         FwCYDKbzYnYN19vbdGVbzN9/hIdZo8OWID6lkIxydSolgYnjgfjJHbm8kN9SYdVBU0BF
         qDgiBK/VD5hWCJvCUQIhZguRUlBmBbIrnEbtw5k1jA/i0gxk1wTXnvEdDNTyEkbUFMxy
         wXEBgXo17SghyHi3prqVFaz8XQSB7qwaFztVJNPlm9ZlETEaP61+II5H4/FLaUpV0v1s
         CA1A==
X-Forwarded-Encrypted: i=1; AKwUvBwMSFP/eWqlC0utD/soiGUPpyrZeD3p7rf55Y4EgM9Y5hKO+kBwgmYof04P+s9R8RU50pnoLIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhjY+vTEWGh5nHGThzrkvVQu6E+RFHwmNNJCldbjM++GMT+9U8
	/US5ZpjTJ6GwPPJPzD4ddNwifPuSRJYmEH6AnaHfg0lT/0n8sfJm1Kksei9OhZU9lMw1xOfel8o
	58/EPF+c8pqI6F9GnjMUEOSrc3b20GuOP7uvDmS8GfnYkccgOBczxw0jYgZ4UXKrV5vDld1Olbp
	G8XI4ccEwhUKmm0K8B5z1STOoTyL/q8nFx4HBF3xWOk+Ljjxz5JtTJUbFuUSNpqiWWwqWIvWhXg
	+BOGb1uWQo=
X-Gm-Gg: AYBFou1OGahlI+R/z7FxCJ2X+iJekya2LN1C1Z/zH5xNFCyXBQQJONDG4R+MPqg4at+
	9K4e2X0ksZzwIVD99fpSkHSiXtZx3196usXop2dQshigRugFsad7EWQDXGDtxJgSMaW751FN9IH
	eegeUWg5Vwfv19eAfHGOHJc82XykK/JECUrAIKa/DO78o1mVvUJCdhS0D61WPWEd1GX/4oAJYO9
	Bg+KZAmAU/wOjtMp+O5pOZ7PSJ8UK4kskzwdk3YbkmlZ9ruljcr2C+pSMMH++9MZGfhfDYwqjyu
	2vRgJ+RwZGK//wJ4/aIclAJJWh5Eaqf0Uo6qdCYrMhF57R30v0zidLLFSR/v+EEbg9HRuZPNEbB
	UVI4Er14Fk+zsQ/Hl5dezyUNU1UMXiR18mfp8CSS3g8MxZJk2xi6wnYWZgwci7ol1VUYbFP58TK
	MGnwjLypbb0v7D1DODaExMzknugAUMiwmzSxqvQA==
X-Received: by 2002:a17:90b:5346:b0:3a6:f90b:20cc with SMTP id 98e67ed59e1d1-3ab3ac9dc3bmr2245723a91.61.1791570803576;
        Fri, 09 Oct 2026 11:33:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36d7945fsm1403895a91.3.2026.10.09.11.33.23
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:33:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2942fa0995so11509266b.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791570801; x=1792175601; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=moNJTzsnyEw30BK2pKOVipkU2KI1iBHtf1ufqL41E7M=;
        b=LWF6N8TQNv0tawgUg7T2CDKXNYKu3oJzF0Iqszt7J2M4GkJjlp7B2makdVS67RiEpu
         Tn0uX7XuRuKJB9hRhwvyZPf9rcW7HemJh8bsJjBaJyBKOyarAjOXRDFKHQTEKHt8liTB
         srjcXl+YwU0EzBQ/CgKX8ljioKldcfLnwUBS8=
X-Forwarded-Encrypted: i=1; AKwUvBwTXCqMQt92GRLfsZzGXCfFMarLcPdrPE6Tr/wTXnVKz8+0WGk8HydCXPazGOJCmgyiyJzksmI=@vger.kernel.org
X-Received: by 2002:a17:907:c23:b0:c2e:4e08:19b5 with SMTP id a640c23a62f3a-c31a9d08813mr281694166b.8.1791570801091;
        Fri, 09 Oct 2026 11:33:21 -0700 (PDT)
X-Received: by 2002:a17:907:c23:b0:c2e:4e08:19b5 with SMTP id
 a640c23a62f3a-c31a9d08813mr281691166b.8.1791570800296; Fri, 09 Oct 2026
 11:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008191114.3736826-1-joe@dama.to> <20261008191114.3736826-3-joe@dama.to>
 <CACKFLikWkH6QaOG=EO_zu8cqCFRxGqtA2-+R-btp0TwUbJjVBg@mail.gmail.com> <asklVFvUJx8P/k1d@devvm20253.cco0.facebook.com>
In-Reply-To: <asklVFvUJx8P/k1d@devvm20253.cco0.facebook.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 9 Oct 2026 11:33:07 -0700
X-Gm-Features: AclHuK9FtRnLD_nfOhaQMng8h30I5kdneNNuwRzA5OSlVD4L05fTNXRGnLjZC94
Message-ID: <CACKFLiksRwZm+Zy74G_u59yEpY5BK+xRv=r6f9Wpo6WgT_TwDQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE
To: Joe Damato <joe@dama.to>, Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, edumazet@google.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003deaae065d6c9580"

--0000000000003deaae065d6c9580
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 10:33=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Thu, Oct 08, 2026 at 10:26:06PM -0700, Michael Chan wrote:
> > On Thu, Oct 8, 2026 at 12:11=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
> >
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_gso.c
> > > index ef04c9d08066..f87e02ef3033 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > > @@ -82,11 +82,14 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct =
bnxt_tx_ring_info *txr,
> > >         if (unlikely(num_segs <=3D 1))
> > >                 goto drop;
> > >
> > > +       if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
> > > +               goto drop;
> > > +
> >
> > This looks redundant since you already have the same check in
> > bnxt_features_check().
>
> It's redundant for skbs that go through validate_xmit_skb(), but generic =
XDP
> doesn't AFAIU. Not sure how else to handle this case, but open to suggest=
ions.
>

Did you mean generic XDP turning around incoming packets with XDP_TX
actions and transmitting them through the software stack?  This path
cannot generate USO packets, right?

> If you agree and are OK with dropping these, then I could add a comment
> clarifying this in the v2. LMK what you think.
>
> > >         /* Upper bound on the number of descriptors needed.
> > >          *
> > >          * Each segment uses 1 long BD + 1 ext BD + payload BDs, whic=
h is
> > >          * at most num_segs + nr_frags (each frag boundary crossing a=
dds at
> > > -        * most 1 extra BD).
> > > +        * most 1 extra BD). The last segment may need 1 pad BD.
> > >          */
> > >         bds_needed =3D 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
> >
> > I don't quite understand why we don't need to add 1 more for possible
> > padding here.
>
> Re-reading the code, I think the +1 was never needed in the first place.
> Payload BDs come from at most 1 + nr_frags DMA regions. Going from one re=
gion
> to the next adds at most one BD on top of one BD per segment. There are
> nr_frags boundaries at most, so I think the math is:
>
>   2*num_segs + num_segs + nr_frags
>
> which simplifies to 3*num_segs + nr_frags.
>
> I would appreciate a double check on the math :) but I think the +1 from =
the
> original code was actually unnecessary and so for this change we can use =
it
> for the pad BD.

I think the math is right.  If you have n nr_frags, you can only cross
it at most n times.  So the +1 was not necessary until we now deal
with the padding. Thanks.

--0000000000003deaae065d6c9580
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBf0CNo
H9STtc9ZBYWhgtiRofx7SFc/0dpfP85ZfcaG4DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDkxODMzMjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCJLTJHitjZ+35k2ErOsYokWJ+B4jDnuE5V+3dP27cb
hMiAU9cQxEJr8qs8ElwOulqkZjFtauArxOMU3HwKPL25I1v+NEIJbuzMOc4OyS5KuMlZA6FxIbfF
vkj7RVW1aLYGTHRVVP7YuDgC+ukJC60DLURwgtpTtzQmKwMxkRzqNi7G3FQl4Dgzy3GWVIu8Jluv
cWhxm6AvvgLZnAiANOJUVV7DoJUJU2nWh0AXtCsCrt9pvi+vD+TnV5KGxiIl8z+Ito3EfcEzH1AL
GAunK5I+5AA3mZEvRTKDxNOKkhZlLAKi23BZRqJPPOdiEpGdrYtGTQzWDpjTHczl2EQA3sTV
--0000000000003deaae065d6c9580--

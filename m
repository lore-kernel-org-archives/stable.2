Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1F3BED56
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747428; cv=none; b=Gf7d9H5tDGX+W16ntNX1Bso0EefNbJJVXzGd/5jdJIoAgbsh7UmZiieEAxRVLCkd2qdD8w39YAv3GMndFq5s0JisAGFnOTTV9pxmxNdpiGrgKn3mC7qprUrg+FTFcnt2XgD35gFBgA/ZTDNZZYZlQ/anhGqvsRGxQj9G5jjbO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747428; c=relaxed/simple;
	bh=V2umITYyrBvcxXHzc0X86/dZQau4wYLVyRD1gb87xqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/v0Nrrjke+9PtyoxxGg8T8STvn6wGGMNvazOnOiNp5hKEKfQKYcsoRUXmSF21bmn3I7QlRDs1i384Ih2iBwhEIVxWO5bqQ5Glsq5MfZOKUX4LRWBfioC4C0DC2nGrpFUKpMdj5YS892K017VjWZIpyRA79PUx1wfnaPnbKI9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NrX52TsE; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NrX52TsE"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38511175ad3so976063a91.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 05:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747426; x=1788352226;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2umITYyrBvcxXHzc0X86/dZQau4wYLVyRD1gb87xqM=;
        b=FIHUXiGG/xjgtUTOc6nGDY3R+CDPKOvS0ScPMltjyYP05m9f/vKM0pJQEjTzgADf7B
         EehQYhYeZqmiAA2evIeN/8wWOCq3LnkfNpely+LIKl1xn1X0afRMJHCX4qPpVOGquJmS
         IVMBBTjPasyz0cAorho/a7eGGYXOaYtJrfmqAOaOtyN8AORUNJOHOvXgb2uyav+eyCbX
         DYvTslEpRtH4aiYt7nuVoaynbezwROK0Xp5XtT63vO5jurwyiqfovtduVoRQjCOB0xTg
         DYX51sFK35j/B0Ph6MHkztT9GKyQZH6J5i1pUlILQw7ybom7BqZjYL4zi0lRCqJvbDeb
         BhVA==
X-Forwarded-Encrypted: i=1; AHgh+RoQb2qboEQ1e10Z5wMpYkODh+wrYbOZtVFA3VvnEdpUhnLC5JYURXjh+Nysg8yhw/yKfb7p9/w=@vger.kernel.org
X-Gm-Message-State: AFuF++mCnPT3vaZ8tDwUkVDLmvlBzYn3zcUaLBDKvWNpYU/1BRIyMYgV
	U9ENQlR7mV5VGC4s2fUZo5rKEyVGRMk8bcaYXn0/+HOGumQwzSqkFBRGcuZA7rfAIqSl+okDjQu
	dg4VdqQ9o+7FxNJICMmMPDYxiQxHEUXGJwcsSUUtOFq/+NXiIzbmzXIrLaPLydWWOODBg8NgPQM
	sRjImb6E/GFfPzJzC/r1OyHT5HQ/k/kVu4P1/WXmNgBtCv7aC8/RSzQaA19Hz65ahV5cUTsrk0O
	e10UFBTzSMj3w2UNg==
X-Gm-Gg: AR+sD13rOX8v4DlEnK4X/5fW+esQPsd4lZN/6SyXPFV5vY/S1S4ERw0/ufU4sD7y1Q4
	38rO+UMuooACMpdsneojRKZMu6PBz4IPed6Pn+jBOupiT9CmpXX3ArbcF1+gJIRqi1R8jZ8TVYc
	pWNnRCMD/PTlGp8njQDVw6g1O3qracFP/OYDw3v4f7DqrcGCVL7CundhXtxBzjOoFJW9OzD4vOb
	w7HkqZPsFinKzGYQxd6XZw7eZHQF87P6qFFMuwoozD63k8jJjCxxrsOMhLhEriQRmCVTMtfvNhE
	Qkg2pzJno00dKJ+MM6Ral9VftUZ+CPjx33QNZAqtfV0nX2Aq0+G1cymU5+k0/D6LkGr+U43/Wv3
	/wd+GhaEOOVKuGiy0pPCP5Zx0qCmuDyVe6RsSxJK9rdgX6jBOFysJUKtJMIAoXxlwHk3xMRwcz0
	I4Kcspu7xY/63ShSLSyFjmnGeEK0Rz1MtIFGmz3m/SQQ==
X-Received: by 2002:a17:90b:2247:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-3966d1847c6mr13110304a91.5.1787747426005;
        Wed, 26 Aug 2026 05:30:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39674dc6c49sm1169439a91.12.2026.08.26.05.30.25
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2026 05:30:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso307159f8f.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787747424; x=1788352224; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2umITYyrBvcxXHzc0X86/dZQau4wYLVyRD1gb87xqM=;
        b=NrX52TsE/kj9bgdGa4VDxncRY1gf11UaA7dXLKqq7n52TBWhVnSiKXWCilK7ItUaSJ
         fIZwGMxcWIq6+4I+poMwLRdjadLYOZUTcrrijRpOf/sddqtbbQ4icrJ678oeoBdgADKs
         rtPoQe+zu9ESd3Mj1Ri+5/V55tvrM2UGkMML8=
X-Forwarded-Encrypted: i=1; AHgh+RqHvJM6xDUtfg5EQttHjE0fftM9t5gw6+tI7xJ2vslwE0S4xsokVkkl+J6oALHx76BkCUDFOP8=@vger.kernel.org
X-Received: by 2002:a05:6000:4a14:b0:47f:9096:3ef1 with SMTP id ffacd0b85a97d-482e26899efmr7531865f8f.9.1787747423873;
        Wed, 26 Aug 2026 05:30:23 -0700 (PDT)
X-Received: by 2002:a05:6000:4a14:b0:47f:9096:3ef1 with SMTP id
 ffacd0b85a97d-482e26899efmr7531799f8f.9.1787747423437; Wed, 26 Aug 2026
 05:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826000234.2031564-1-joe@dama.to> <CACKFLi=gFqMz2nu_6gf_pX0JBXxsygcuzUwXAdqL=8XR0Jogng@mail.gmail.com>
In-Reply-To: <CACKFLi=gFqMz2nu_6gf_pX0JBXxsygcuzUwXAdqL=8XR0Jogng@mail.gmail.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Wed, 26 Aug 2026 08:30:11 -0400
X-Gm-Features: AcwNN1XkZ2TeVi02ehUP9iKyMms2IsgfGsNkChcO8ZQtYv2Be7FwbhxsMjxfah0
Message-ID: <CACDg6nWtE+0tcHqEgd_+=kHKpFGf-78Rc3ALyzJO9ZZkV2g=uA@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Write doorbell when linearizing skb fails
To: Michael Chan <michael.chan@broadcom.com>
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Simon Horman <horms@kernel.org>, 
	kalesh-anakkur.purayil@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002afd190659f262ff"

--0000000000002afd190659f262ff
Content-Type: multipart/alternative; boundary="0000000000001f6f520659f262e3"

--0000000000001f6f520659f262e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:00=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com>
wrote:
>
> On Tue, Aug 25, 2026 at 5:02=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
> >
> > When the driver is handed a burst of packets, the doorbell is deferred
> > until the end. If the last packet has a huge number of frags, but fails
> > to linearize, the doorbell will not be written adding latency on TX for
> > any packets in the ring and holding their DMA mappings until the next
> > TX. Note that the queue is not stopped, so this issue would delay
> > pending BDs until the next TX.
> >
> > This issue was discovered by Sashiko and reading the code verifies that=
,
> > while unlikely, it is possible.
> >
> > Fix this by jumping to tx_free, which replicates the same pre-existing
> > logic but also writes the doorbell.
> >
> > Fixes: b91e82129400 ("bnxt_en: Linearize TX SKB if the fragments exceed
the max")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joe Damato <joe@dama.to>
>
> Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Looks good to me, too.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

--0000000000001f6f520659f262e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Aug 26, 2026 at 2:00=E2=80=AFAM Michael Chan &lt;<=
a href=3D"mailto:michael.chan@broadcom.com">michael.chan@broadcom.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Tue, Aug 25, 2026 at 5:02=E2=80=AFPM Joe Damat=
o &lt;<a href=3D"mailto:joe@dama.to">joe@dama.to</a>&gt; wrote:<br>&gt; &gt=
;<br>&gt; &gt; When the driver is handed a burst of packets, the doorbell i=
s deferred<br>&gt; &gt; until the end. If the last packet has a huge number=
 of frags, but fails<br>&gt; &gt; to linearize, the doorbell will not be wr=
itten adding latency on TX for<br>&gt; &gt; any packets in the ring and hol=
ding their DMA mappings until the next<br>&gt; &gt; TX. Note that the queue=
 is not stopped, so this issue would delay<br>&gt; &gt; pending BDs until t=
he next TX.<br>&gt; &gt;<br>&gt; &gt; This issue was discovered by Sashiko =
and reading the code verifies that,<br>&gt; &gt; while unlikely, it is poss=
ible.<br>&gt; &gt;<br>&gt; &gt; Fix this by jumping to tx_free, which repli=
cates the same pre-existing<br>&gt; &gt; logic but also writes the doorbell=
.<br>&gt; &gt;<br>&gt; &gt; Fixes: b91e82129400 (&quot;bnxt_en: Linearize T=
X SKB if the fragments exceed the max&quot;)<br>&gt; &gt; Cc: <a href=3D"ma=
ilto:stable@vger.kernel.org">stable@vger.kernel.org</a><br>&gt; &gt; Signed=
-off-by: Joe Damato &lt;<a href=3D"mailto:joe@dama.to">joe@dama.to</a>&gt;<=
br>&gt;<br>&gt; Thanks.<br>&gt; Reviewed-by: Michael Chan &lt;<a href=3D"ma=
ilto:michael.chan@broadcom.com">michael.chan@broadcom.com</a>&gt;<div><br><=
/div><div>Looks good to me, too.</div><div><br></div><div>Reviewed-by: Andy=
 Gospodarek &lt;<a href=3D"mailto:gospo@broadcom.com">gospo@broadcom.com</a=
>&gt;</div><div><br></div></div>

--0000000000001f6f520659f262e3--

--0000000000002afd190659f262ff
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGozCCBIug
AwIBAgIMLAiVyur+1MRjdDgxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDMwNVoXDTI3MDYyMTEzNDMwNVowgeYxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKR29zcG9kYXJlazEPMA0GA1UEKhMGQW5kcmV3MRYwFAYDVQQKEw1CUk9B
RENPTSBJTkMuMScwJQYDVQQDDB5hbmRyZXcuZ29zcG9kYXJla0Bicm9hZGNvbS5jb20xLTArBgkq
hkiG9w0BCQEWHmFuZHJldy5nb3Nwb2RhcmVrQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOP/A/G3pTTF6D8/BCAHpxJpQjOueWirQLqbjFWJTHsh6ADFdvKs+izD
0snfZopX+ZSMfR+NKl12zoJaZy/HTGiXvyeLACXBAP5i8J+smf3H0UZo+ztl9s/CLIxDfjquoQYV
UHAKWXC5euJvZ4N4/n2E35/OV6VV3JeKQHAiSOXhljrejDS6Wk96WYaQKawDm0jYH6OoXDnR/CMn
3bcNBRgaGW5VtJUP5jpTLrsQFC25kFf6fA5/HWLsVdOwkBWic80s6HCG0ROnFWnbLPL49NGItRmc
Cndhx/wUdeIk/qDpB3NiaC0IsvVNnZLIIbEl5kBojwkZV0jD/VicntRDJ78CAwEAAaOCAeIwggHe
MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEF
BQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNt
aW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoD
AjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBB
BgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNh
MjAyMy5jcmwwKQYDVR0RBCIwIIEeYW5kcmV3Lmdvc3BvZGFyZWtAYnJvYWRjb20uY29tMBMGA1Ud
JQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQW
BBTQMVctYYJaUBLeJgZz6cT67l9WmjANBgkqhkiG9w0BAQsFAAOCAgEARE5k774M2TzT1K6LUDrm
HBHxHxe8rQpJrB59lyOANT2BjSITyUXPC/Up9ExGhYbioibOJALdaBhATnMgqw03EJLpr7Sy/mY9
g/LlaPMSHU0vcuhuU15DAwQfJ9Liw4K9AmTo0MnPKgiSDLWT8yuphPFiXATg1x8+K1b/KEt8t3Cx
3pY6cGPUH4iJXz801q7ka38emkBlMKS4i7eWgwCSHR/9c7JvlrVYT5+wqYCbmPasbv3jNS0MfEdY
qNLhtJABTy1ePhWmAzFMlbexVyN3FeWCOtxrnnD6tFhYt9dMX2kSvti9voE1cPJfyHj7IhvHVlUc
aBR5GY5F9netDgPvbqg1YpqYZwxblN6i91QhywTGSydHpbgJAmVEEp9rKvGJirwRjORPt0wXb3b6
6BzJD4dFfmqoXVKRl6WHOOICEKWVcD0OnPRdCJEXiSW6y1xobGpElvWmB7lGIE+W9V/Efv17PdJa
/u6hPkFWZBhzmFzEWDSaWvsfJpk3Jb+8oHhOk0IERLc4VLhPNhyMOQq+aL30GjEej1lqr79p5a70
/+WaRxxlypFBMj2V0384P2ACDsYAayPdKSx5aoEJWmW2cc/xR0LxENIsNWeqUBvEjcA6Qud56l66
dGBNtVCEGdHfKttDlWel93rPRa77UmnqEt+6YNFCXnuhaSUJGOA0yxQxggJXMIICUwIBATBiMFIx
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxT
aWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwsCJXK6v7UxGN0ODEwDQYJYIZIAWUDBAIBBQCggccw
LwYJKoZIhvcNAQkEMSIEIP/GfMYdSFfOvro2wLfibX5OVZyuw2VekzDiBMjw5O7HMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDgyNjEyMzAyNFowXAYJKoZIhvcN
AQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0D
BzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAL2jPtcRDa6ohKYQ
xqaUsbE7JXJw16nK160EYpjLkdB1s88T33oMEBxxCcq2aKqFVmG5kEeW8jY1r5btV3FWICd/hCil
R2FjqceyDyHOiI6EXt57f1PgVWMU9ge2hpgD41KQ0YTBm7uMJE1k/Okh5UsXfZVAsiGYG4YPQnve
SNJf6PlZaL9kdssPQDExo1p1FgnR+S/qEhiq4isXBUkFd+ddghQJORu5Kreva9tY5JYXK7tfJBBA
MpGqrVs+iKefppRf8Hjlilpm5BYKqnKG8M3mkm/pPzr2RjP/RkzmXEyUrPjC+yXHCP0oCSkjph02
HgerUADjJUYAfg8dFdZULYQ=
--0000000000002afd190659f262ff--

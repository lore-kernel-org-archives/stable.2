Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647242;
	b=qG32OcQ2ZM6f5QWz356Ywg6+T+zghwe4q0citXSbsg3Hn3FIBYiiqoljopymfN81r3C5
	 CaMBRZkD1P+yCQPapyW6fF4af6W5vvlsrBIZSM2lSXUffSu2VrmFvcblmbieZglPXWSqt
	 h7WtjoGh0Ec00GsYLz1GS3w0HVGvqp7rj7QYM5vx2dAAe6EY04oOTOw6I/qFvqyatcm/k
	 T2HK2JDWBsJsGEvS/LMg0NYN6Yjc6/poGRS34zLpIoFvFWKKkNo2GrSWKHHdoMc2xzQKj
	 ova9npT+qgqWR/iNLG5O0d3yVYcvK6krOpMx/9DqW9IpKDIsd0C7MNjLNIB06eTMRIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647242;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=SAZ3nonOrrN34SwjaYpvATIBke7R/Q97oSkEj0Eda54=;
	b=Pz9RBZ55hHEkfyjMpUBkDA6Mvafs8mRl29M6BVAGr9gC1Rdt1hAEDnbMHnFXyRDIar2H
	 szE529JJFdAuI8r5ILvbf3L5v1uB+0XuljoErcu9dr0UNKkzHNU4rOodpn002YbiGCojH
	 9OrkG0fOg5rpt3z7GjPY0avYpjkRSqzruQ+jZBgMt9k/6ZDcU4VC4dTaXRDwfFb+Uky5o
	 QNB6XolN7jUq1YvzGk2zrmzLsJJXpjZcJXD3kyLKPFe4xinXAPXs9lc3KxsY375gxSqLE
	 3rHPZL60IzeiwscYsgTrSKvqblXnTMJ3cmTza3aNyW0KNglLjEXVrpaKxoh16Frkk+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=V9J+LHwL;
	arc=none smtp.remote-ip=209.85.222.228
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157E606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3157E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=V9J+LHwL
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-93e635220b4so338795585a.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647240; x=1794252040;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SAZ3nonOrrN34SwjaYpvATIBke7R/Q97oSkEj0Eda54=;
        b=1foTCGlQwvG9O8oMVbGPPICkIJoaeuog4fGuDUA6SqxAXFEkv8oQ68Hq5Ij1jD8VF5
         WegNDKoCMtx230h2sTUasFiApdqkVuF47qqfRZELVOv/5oOyozQJ+QbCO9ODeDszfG3C
         SFrJaLnzIFttGhKnS8gqMkKHe+okniuzW9frUR3rzc8urQWXM1MsPvTUDhEQlxn0T1ia
         YTzYF299sXsM01VwstupixZ5TXpHF1H2GP3knnfFFE+743XLMMqMXpot7fHmIxZAxMX5
         K1GbRYRSGO7qEBaThCrFPoROfcZ3kgLnGvs9niILgVsW5cR406gf5+1cBLRwZ4BkFpk9
         xRWA==
X-Forwarded-Encrypted: i=1; AKwUvByP+K6IpI3pCP5IdfYJAAQ29nlQ/CKavl/tL9hXO/YE0F5fNxcjEFHZgD9kXzmc4bgM8eZP7nk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/qFsUi06EaY0lNjxDSY/DgCGV+CNB0gM5s3QG8Y0GkvSxtHBf
	ioQ+8MBiZGG4GEkKuki8D0XkTaJywiliiE9ZKv8wbaeSq4mh/7O2J09aPrRd1VZsARwIOZkH/La
	UHFPuPtJXsVRYNbDyp5JyFlwY5q2pCqWJerXbzzqRLcntvqlM+xWeYSiHlTdtiekrwJqR4t7qVD
	6XPnZd89OyvgcRFictXT0rkb/QHjn2V7Yn1NuvQmrhlaSsRNXO2nefUIQVluECdCz6T0HWH1QYL
	oG8oOfvXTc=
X-Gm-Gg: AYBFou0T4QjDe2cIXZxTp2tMR8UzIZizvFuUpCWhQbPi/hji8R4b955UB/ZamdicPmP
	d8bfO8Dcpf20XzTyh28t6XH5qmwsSM8WOuNE9mUN6R1X9DyOQqyIrI7vJbiZjipWr9hdENNMvkA
	VLWq8fjw7x314VIfqZYv5izyIs/1+snf3W+gtnHuKbT7DSbIux9I1fSrKZxDU7mJzHztFhkg3sz
	zRVpRkdJniqWm7RTUVO+L0kmVeWGXLOoBQ5L/5uQUX+FdTZ+J0EbNrg9/PhwK8AiIDhdRQ0LIQy
	ox2FjwxLPG8NcBEN6H+3FEyXezE+L9TXlPA0BQ2MvlIZtQS+2i5tLEyLZWbVTAVtJqCSTbaIPhG
	vbxv7LdPFKVOY57H+kxSThHj0epssozACFx8hypVmPa70E+HdqJOh4QVyGfuY5PVEyD0Y1U7v45
	UpezL5OKgvC7j3q5A+GWBRbWcOLEClIe30Yik=
X-Received: by 2002:a05:620a:2a05:b0:93b:bc51:b40 with SMTP id af79cd13be357-944214dc4bdmr1816617685a.2.1793647239691;
        Mon, 02 Nov 2026 11:20:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9442585c6ebsm90219885a.19.2026.11.02.11.20.39
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 11:20:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c40aa03ded8so239732466b.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793647238; x=1794252038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAZ3nonOrrN34SwjaYpvATIBke7R/Q97oSkEj0Eda54=;
        b=V9J+LHwLL4wuUuq7c/iynOHbdw6j69M/IMAJYE4eMQfoazozSzUDDERtfD5+KB35wf
         WY/FSmettnp8bB+Ab/OsP3B2KzJsM8NKOUYwuDxiyoE7ueA+PwHLYrplS9bt9wl/mUT4
         KzhlaLl2+c5g0gRVa374nK5OT55UtyIjqcyF8=
X-Forwarded-Encrypted: i=1; AKwUvBySQpCy435cXP3my3NDfTz30g+EBlLkJxa8Xub1CmBzBaGFT8E7Syjf0QReX/aFIcD+GxOaFhE=@vger.kernel.org
X-Received: by 2002:a17:907:969e:b0:c41:8e21:4d5a with SMTP id a640c23a62f3a-c4ca793c08emr880251666b.5.1793647238073;
        Mon, 02 Nov 2026 11:20:38 -0800 (PST)
X-Received: by 2002:a17:907:969e:b0:c41:8e21:4d5a with SMTP id
 a640c23a62f3a-c4ca793c08emr880250466b.5.1793647237724; Mon, 02 Nov 2026
 11:20:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029032832.1511180-1-bcochrane@google.com> <CACKFLimgKYe9Ow6UKivoyXaFU5UGEKB7Tb2VEUQ83=5Dghyw7w@mail.gmail.com>
In-Reply-To: <CACKFLimgKYe9Ow6UKivoyXaFU5UGEKB7Tb2VEUQ83=5Dghyw7w@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 2 Nov 2026 11:20:26 -0800
X-Gm-Features: AclHuK8EO6z5qqqZMv9IXsN9W1_-JzKAVx0EtVnZVi_zqy4EeM1iiqQFl2bYuRU
Message-ID: <CACKFLinnoPdJs=TLv_OOxXcWez-zfMX9Q+L+s8ponqvjG3Yshg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Take RTNL before netif_close() when aborting
 FW reset
To: Bryan Cochrane <bcochrane@google.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007e6fbe065f500ac6"

--0000000000007e6fbe065f500ac6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:59=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Wed, Oct 28, 2026 at 8:28=E2=80=AFPM Bryan Cochrane <bcochrane@google.=
com> wrote:
>
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 0682060b048c..0f37639b70ba 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -14798,7 +14798,7 @@ static int bnxt_get_registered_vfs(struct bnxt =
*bp)
> >  void bnxt_fw_reset(struct bnxt *bp)
> >  {
> >         bnxt_ulp_stop(bp);
> > -       bnxt_lock_sp(bp);
> > +       bnxt_rtnl_lock_sp(bp);
>
> Thanks for the patch.  This isignificantly increases the scope of the
> rtnl_lock to cover the whole FW reset sequence.  I'm concerned that
> with a large number of VFs running in the same kernel, the rtnl_lock
> contention will cause some of the VFs to fail recovery.
>

Looking more closely, I think the case that requires the rtnl_lock is
very narrow.  Only a PF with active VFs will need it in case
bnxt_get_registered_vfs() fails.  For example, all the VFs now will
take the rtnl_lock for no reason and will cause unnecessary
contention.  I suggest fixing this bnxt_get_registered_vfs() failure
more locally without increasing the scope of the rtnl_lock.  Thanks.

--0000000000007e6fbe065f500ac6
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBvZkXz
PgehN29Jx7JoPvvf6W+RZ9/dspwvECHZaRgTyzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMDIxOTIwMzhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBh9xWDr4S6VHI9DM6fk7/Qe8TSPkyNI599NPPMt0Ud
p3nZgvv3aK6B7v4ZxeUf+AeAU6iAyp8nZP1T0yFMBh9Rea0Y0q3g7ant0YyQro0lpRm2ZqFX9zVU
HwOh8hAvrL9IE8RFYFo66Yn/JeM/oO4hkdHUXc/QOkFPF+fdpONErOTAmvYdEsxLhbDdwdUaDPp1
8tVdx6lhmEC+0/h2EWOre+ImrjD1Z968PEWlHxx2rBK0oadThzugEYI3kbZDlpLaSPYY/KzW0ZlS
2WuFScQqljIc4YwH3zUFsZ3NNtTC6AyRlEO7BGq9QBCkRaOP5VA3fV5FMfmIql13wqwD3QV7
--0000000000007e6fbe065f500ac6--

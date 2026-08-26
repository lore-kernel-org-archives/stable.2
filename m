Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F635A39D
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724034; cv=none; b=qYPXe6KAqWFa6cT4yk6Q/6QB6vh1jq3EfWbw/LUhtf/4tGb1e+GLAxYRuPV5i4LRQ95rZLBduqBrNZlxq77kpSfbrLgYKFnlLRiyzZ0PrIaQWldEFJIKXEJYj90gB3YOsmYhVbcLAp4HtNdLzQSrobBuDK39UWbVxUKJdYqE9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724034; c=relaxed/simple;
	bh=/03E9qPJCkZHg6C4Ukr2tPSsEnSU+yy4VMXSgevrjeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHNxB3qwB4uFmqeKSouNRLuKPiuvHIXg5PKZW1qRvz3jo7h5OvKmCyN2tpKoRZx9uYV1duUXpaxdxP5QAQihij2FPQQtjZw9cDaSnAkyZI36hSqQOMEwQGYj2T7uym6zE3iJJ26vPEDTE43FDHhZvYmwCpAyNBHzrPSJHEIcGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gwaZLei2; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gwaZLei2"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1266125a12.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724032; x=1788328832;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/03E9qPJCkZHg6C4Ukr2tPSsEnSU+yy4VMXSgevrjeg=;
        b=EcdE9NRt734oq6S8vH5tGGih6bNklNEKrxbNMavqmfNhK4fAq8CQQXU/IYGy2kIXSi
         lghVD1cybw0dHl2lHncbyYqzjDpXr/xaucPLiG9oMTlBBvZ26L7AMorKShhuN29tuNpA
         OyAg0SRcet4OPEHUdZHwEyulJTleJwMMvBK53v5F0NPS50KzTxg/4/m5Jy6/aR0XQcyZ
         N/e5JnsVb1/TjfKKN7qSq8PWgr8u2NKhnDDE8855eWrLVBPXo3fFIW4/S5xNTYSnxyzN
         h+D0lFdiFBGQstRBpbDDzRZFfHtosAhWmcnmOPLGMxV1Eb2/oQ0NE0QVf6Qx6zcVjlJW
         cuWw==
X-Forwarded-Encrypted: i=1; AHgh+RqeTW1+07S6ZXyuiWXahtH7Gu38tYq/49/pWMXqDf87IgKdCxF1vVHsv27RxqnXjcRoHpR78ek=@vger.kernel.org
X-Gm-Message-State: AFuF++mnKhEioqu/trmkOq6hqtOPC3O8yZC6NUyw3TAAHd+gsQJLAXso
	4N5ud02FhAQ63OYnQA0IaG6bTZ0ZY9H/E+3q0tyPyuQMAIT9u9qdIy83wnCx2KuyZ8EqscPD7jC
	LENHW02xuzZkt/egYySXmELh/uvFPAh20gM4SenTdy19zWVsNlcq8JA3YQOSQ/QFZEYIWbViO2/
	/MqMlmGXb97Yxe0Lb3YLTtFL3KF3KT42H69L4YhDDzjFggU3G/I2DVBkW9ssWjfwLSzEDlUfXyS
	fsTK30SKIM=
X-Gm-Gg: AR+sD11b1r+ausKmlYZccZ4Y9FW7wl/zqsYNBLv206agLzNzVVD0ImWpusX3QVRVhJq
	Hpg6lkpZmQPOWSuvCQR2AQvmLTmrZ1jjBvBJC46rTX976kYz7Yhgp4BKeD7obHKsnDndwI425ZU
	1yz9sGYpANroSr18F7KlXWIB6hY4Ydc787Qcu2k/q6l5w3gbjYLUTnZunEvdNHARG2nbUfmLz+K
	Y+wjO9VcY4q3zGjjp/QOo05Dq4rUJFX1/fMZ4PqiCsT8HZuBLyWkYOjd0a7K0rc9QlTi0uZHwVH
	IZksELk9FQpy9E5yZc/qaP7mgW7Y8ZZQpwELO1BlbgBUi9l6AyTY8k0cgHqMAOeFWWQYigiIT+j
	+s9eD7BFrlVx1zsrskoIkTn7577x7I4H01MShd7ndg//3kwJj6Xsf15Fd6PxGMLqK4JQI30gcDr
	+Va6JV2SFYVTvy2K8C/IZ+KMOwdKXyMNm63Co=
X-Received: by 2002:a17:90a:d407:b0:390:84db:888e with SMTP id 98e67ed59e1d1-3966d8528c7mr5064164a91.7.1787724031687;
        Tue, 25 Aug 2026 23:00:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39670882607sm189807a91.1.2026.08.25.23.00.31
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2026 23:00:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1c4715cf0eso40757766b.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787724029; x=1788328829; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/03E9qPJCkZHg6C4Ukr2tPSsEnSU+yy4VMXSgevrjeg=;
        b=gwaZLei2zJpqCjcNSOHZh/eqhuP8BbjbDRHDORiT0UuFM3TfXo0vZbc51H+oIlWSUL
         RjSlcNIQhehS8HpXIpH3wuwE8dPhXDN3IP2j3Q+SlOsxrJ5Z7f+Rl0vZOh6T7WvaUOYB
         oCLaESSergqyGfcq21i6tz33JZdPyqcQYbfUw=
X-Forwarded-Encrypted: i=1; AHgh+RqQJKrNInvs262LAvKKNmAtoGysOs3qBhADiDVQPRvYEQURq1QThDpmMtbvOG1QT1OTp7pfWlQ=@vger.kernel.org
X-Received: by 2002:a05:6402:254c:b0:69f:b1d3:3903 with SMTP id 4fb4d7f45d1cf-6a5df5e323amr4311725a12.8.1787724029421;
        Tue, 25 Aug 2026 23:00:29 -0700 (PDT)
X-Received: by 2002:a05:6402:254c:b0:69f:b1d3:3903 with SMTP id
 4fb4d7f45d1cf-6a5df5e323amr4311680a12.8.1787724029028; Tue, 25 Aug 2026
 23:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826000234.2031564-1-joe@dama.to>
In-Reply-To: <20260826000234.2031564-1-joe@dama.to>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 25 Aug 2026 23:00:15 -0700
X-Gm-Features: AcwNN1XAZjuKdusXt6itn2bCc7U00eI4K7uSAlUfRadA6niLgjcm49ikVttr0RI
Message-ID: <CACKFLi=gFqMz2nu_6gf_pX0JBXxsygcuzUwXAdqL=8XR0Jogng@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Write doorbell when linearizing skb fails
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	Simon Horman <horms@kernel.org>, kalesh-anakkur.purayil@broadcom.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000beb1100659ecef9e"

--000000000000beb1100659ecef9e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:02=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> When the driver is handed a burst of packets, the doorbell is deferred
> until the end. If the last packet has a huge number of frags, but fails
> to linearize, the doorbell will not be written adding latency on TX for
> any packets in the ring and holding their DMA mappings until the next
> TX. Note that the queue is not stopped, so this issue would delay
> pending BDs until the next TX.
>
> This issue was discovered by Sashiko and reading the code verifies that,
> while unlikely, it is possible.
>
> Fix this by jumping to tx_free, which replicates the same pre-existing
> logic but also writes the doorbell.
>
> Fixes: b91e82129400 ("bnxt_en: Linearize TX SKB if the fragments exceed t=
he max")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Damato <joe@dama.to>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000beb1100659ecef9e
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBki4rh
J0JV51mLTkEPG0pOvrHLce6SXlxeyZkWuHJHSjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MjYwNjAwMjlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB1kTHlpOO0vCMjuhVTX6nXmhlfE1f4KzZZ0gi7Q4LW
mywyonIWehX6Zgz+lz7e26l+QUH013RXroO/xITFd9LwjuT1hVzwOIOtYZQzhlQUNKSbxYZkIH81
0Ophc+dHvTe7+uzGQiIJP54UT7zhIFPBZ/Hjf5NP/RstD0v2+QNhhBzQqCuYjWONrwHRocEyo3DJ
/R6jxlDcZUlvVJUH0OVfzgWjMfgbcs+UoztRL9FUExwK722pDUDJOv2R9hioI5tICS2ZA530OEKl
VNapsi8JQFw1Fl5GAMkd/gfB8MjKLzlqz7rAupEiFMW3Pep/5WY2Uwbi1u6/HAhavxr1ECN1
--000000000000beb1100659ecef9e--

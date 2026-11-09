Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251803;
	b=1V6M5lSJFMv8piovcZsYDhdeLs/0IuEUlCMfm7kNcE5pnFERuthjaqhR03AcwuA99sN8
	 ItPQMpwIWgHtxumsdqPA84O+dU2xFskOaaE8LyO0+lLvHlbRhSk9AjIYyjCDOSgBhhNCD
	 M+cM6F3A35MxoZs+eD6l2t8nAd+wYDzaOJeZ9DkilGy07ZfQs//c2+WoNq6Jcx0eKwJXh
	 WWLWvNP06xGz0EFwcDM3QRRj+AohTvOlulTPX1a96tBs17GyYcneFXupo0ZyQYKv76YKJ
	 VdS0Q/mP21T1nHMInp3tD19sFFpIj35oV6wInMdH3UcQMQoJqIMCWVLmsAs43VtbU/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251803;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=ECmbxQIu0medjA9fJoU3hHvNwYis+NHeVpRg/oNyqQQ=;
	b=eEtEkn6KehgLQOyb8FLig6j8YESaPAWnthsp/nrRNQgnePpTZ32kFYwu8N8ZzRlaNhs2
	 1RlUf+zvS9fc/gVvDc1ryZVxKgU7HL9kGR1pNZFVALFxh9ExCfrmF8Mjljsn9idD045Go
	 A0RHqpwBpvOHPKE9n1K/lRf23iJBWbQljSiq2ZGKnch66ofpBPB/27BzfM8WaCDHr4e04
	 Y1xI3k5IEjDBHRy6X9TvV9T+66Kkpc+NAu9KwAxc1sFQNeZQTB4ET6Y+EueplrJGFBoIj
	 rGr1u7RKV+IzS2cZ7wxwurdHdt+CPwp7M/suNBcq0IjmGdPLhwnA/nLGNIPTJ6tdP2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PxAi64JZ;
	arc=none smtp.remote-ip=209.85.222.226
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB78606A33C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AB78606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PxAi64JZ
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-930c0f9c1b1so122917985a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251802; x=1794856602;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECmbxQIu0medjA9fJoU3hHvNwYis+NHeVpRg/oNyqQQ=;
        b=RPA8Ftwo10kEMBSCkNi+Uz6pFs1Zz1td7e4dc25v+koqdsG2lB8D3DkgNAfy16LfJu
         sxDzZfjRT/uTxV263zuCzMQbzZ0AyNL7KzdGOq9cviW+ME8cgJsb2ebY1YXzlFKG1Rir
         RXBPI2SeTTlmMa8XNskLImiHWIm6HpcxUZ92G3fdoDXlzIYS+cVHyftnVju7b9N1RHIq
         8xw+O6qPqM8/G6+aSjTBaotmL/4dyT85tZpvOhr/GzNh3yqMhzL+CULFWeNrLrXw5N8M
         ew25juWP8zGdiLgZhTcJriV/PWxPZ8HyZITWPFoxo2P2ItRiNKYJH2nU/sXGTdevq37P
         JevA==
X-Forwarded-Encrypted: i=1; AL+hErFNWUwm5rLbZR0A9qGHzEJY6B1+k8Xe6zpZ6K65+P22/F6fqiww/mOPVU6V9mDoBhXd3o9bcD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uQo8pBfOXTgOnBxbXo8xhyeifxByig93EJNdIsr2+/D5gN8+H
	MVYrqjyl5gNIU7r/3CeYtTH7GucgXksChhZ95i/T3Gj6tCBombAxuYS9p0VOuQo12O/VUVMf6kS
	UXEWX2KxqIKboA9l1rEvu7ppjtvy51t8U8JRWGXgcaJ/lyHwKEz7HrAPLyh9ufZEYVRFdIgSVrD
	6jsnSf3KuSmdazFhrG+uGkrPWymHEad+bt3PeDkarelodZ/MqhxgKTGGFr3kNnRWjTLLvEAm3b4
	IF3iq9IMpQ=
X-Gm-Gg: AYBFou1Uxyb6hnyar3RygHptufgYT6uwJ+1Trh7Z02EsLUAC80bYppJsedglE+IUJRJ
	9CQViIibmfE0bJx6Tg3jU1ZLTUn2uJtP2Z2PN/ymtGWBm63xEi3UCqlVoubueSRWFN/nid4jqUV
	OW10c0U2VrDSwCEvkzaWV/v3IdAVlHZnyjboxWjc/4yvmGsgARqoVJyIZitRjj5Wk7sKchFjXLI
	pj8qo67EXUqgVP6inkXKtzzqeZQ5q10TZcrGFwsTbdXu99v9A9aZjEArgdSNm/nRuqzFoJya/zs
	t8CLwr74wmC/+JPEzHDz36jYVtXoM+T7KilQcNbisL4JmoqZrvCCEyO5ehktrJWOUbxIQhzPSxe
	7TsYiWbtgpWV/L/did/UeYAdIfgIQLl+0NI5XM8M41aoEC2TRWucR2KE+7JHfFGDDAYGH0a7dR5
	/XfMKjt4BB5IS7ZrcBZtyIBCZOzSeBZDgud4w=
X-Received: by 2002:a05:620a:26a0:b0:93c:7a5c:77d8 with SMTP id af79cd13be357-9479f1d0c7cmr73985885a.4.1794251801761;
        Mon, 09 Nov 2026 11:16:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9479f008208sm4161885a.17.2026.11.09.11.16.41
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 11:16:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c41dae9db9dso121040766b.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794251800; x=1794856600; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECmbxQIu0medjA9fJoU3hHvNwYis+NHeVpRg/oNyqQQ=;
        b=PxAi64JZylv90lsoC0IdHFb+cfRU77eoyNfr+/pIB/UYKHkai7eAsJ1kyTWNmyiAIS
         8GasdtqFYQCQQx0REtmvaNiQftboGFn3KQtAJeuoAV99dQd0MdH7LC0Jni9R58eyoD7W
         60lLOnQu0zxUFnLBHv0Plj56yVxNhYHAe2MmA=
X-Forwarded-Encrypted: i=1; AL+hErEdL0PdN9RMHNXIYrEAsuvikFyRGW1cZICwp+5RIL8LKPq5ZRBlo+AFCaeYAeidZCinuLn3z6c=@vger.kernel.org
X-Received: by 2002:a17:906:fb91:b0:c2e:2baa:a642 with SMTP id a640c23a62f3a-c50495990demr17487066b.30.1794251800221;
        Mon, 09 Nov 2026 11:16:40 -0800 (PST)
X-Received: by 2002:a17:906:fb91:b0:c2e:2baa:a642 with SMTP id
 a640c23a62f3a-c50495990demr17485966b.30.1794251799745; Mon, 09 Nov 2026
 11:16:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108222942.1233295-1-bcochrane@google.com>
In-Reply-To: <20261108222942.1233295-1-bcochrane@google.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 9 Nov 2026 11:16:28 -0800
X-Gm-Features: AclHuK9F4oHp-3lINBrOFrQNC4YdvTSTxqVCJNhImGxebjQGBiNGxus0RCZRHhE
Message-ID: <CACKFLi=ezg_i8fEhncGmT4wqhJSy2S7dkkWDDkohHAL6GnzXvg@mail.gmail.com>
Subject: Re: [PATCH net v4] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
To: Bryan Cochrane <bcochrane@google.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000342bd4065fdccd37"

--000000000000342bd4065fdccd37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 2:29=E2=80=AFPM Bryan Cochrane <bcochrane@google.com=
> wrote:
> v4:
>  - Return to the synchronous close in bnxt_fw_reset() from v2, using
>    netdev_unlock() + bnxt_rtnl_lock_sp() as suggested by Michael Chan,
>    and guard BNXT_STATE_IN_SP_TASK in bnxt_[rtnl_]lock_sp() and
>    bnxt_[rtnl_]unlock_sp() with current_work() =3D=3D &bp->sp_task. Defer=
ring
>    the close to bnxt_fw_reset_task() in v3 still hung when entered via
>    bnxt_fw_recover(), raced with bnxt_hwrm_if_change() clearing
>    fw_reset_state, and marked the reporter SEVERITY_FATAL (reported by
>    the netdev Sashiko review).

v4 looks good to me.  Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000342bd4065fdccd37
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBcEoZ0
n7QhTxiU5yxiCKG5x2JTeuuIGO3iZdD5i9uq3DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMDkxOTE2NDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCcsjgDdIQd0Rv6CxrA8CVPshL/F8VF/QNNe7C2t6bk
lIiFLdBq3nhmB1XCA0Fq0xQgK3gj1Juk5cF5TFbhjvbIJpVmR7uaYcZGKb1pRH9EF7H8agsw5bc7
QLG1+sCc0Xzn/9+8kcu05kwuJujKDkFGV6dpvJ4IHGXDYaf+UxBNR3RKnyviMiPIVEi1Bdhae1aD
ls6VHP5u6iDQZR+ZzL/v3l7AlvPfpZmsxAU6CE7+ycaj+xsoY0y8ubCkyUYXSvSyu8e/zIO37wzh
DGf6N899JvKf4oCL2Ble/ZqAAenAY6ylnXeo8ydakt+acReVAK2o0QpKvjxB+U6yDTSBIg1w
--000000000000342bd4065fdccd37--

Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF231327BFA
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787995696; cv=none; b=gEgNFm0/4nIvOCKf4jspzGpimG/NBGM5ZMiSA8RktPlE2OJ103RshD7ua8TzzxhCmJh5IUy7lIkAmE4cmJRL//R/T94OxgiZqaqzxMlaCXr2loTlv2FSxVe86j7yUMfFBYwv1HnIclRr04qXDQY2Q24ITLYR8pPM1frZhtZfBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787995696; c=relaxed/simple;
	bh=bXLxmkFx2MA0U0lXRWZd8KrbDIoUbyUQ4gvxplrIxU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owJEWyhRANo8vHd9D5qHeIDmBtT+QVadqfACAI3Gvr9WzvDrGZBamYmJKUrZD5DVhpnk4IvizJEN/LF5SJN872gC74r8/wU6HnrujdgaJ7lev/jN127pv9U3LGtL8bvfgnrZFk78wwQwaWiNJ8NDHnwyTWlHQaKTkpvIKPJm8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EDyiV8pz; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EDyiV8pz"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2835601a91.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787995694; x=1788600494;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t26kcwvkPuDpRsCIZWWZntaAlnUev+NYgbbAdGbCCsU=;
        b=YMy9uSJzo7zqnKOw86IwCIiR0PmZLduh/Jx3pKGTAQt9nd45m8OrAPj3u/Hd4l/DO6
         DNHpZEiEGrwhpk09Te2i3qrjqIQyVI7/Pymcb81SxpQXKWXLhABcgiiEium0LJBQD8ky
         ejhEKuYk9jP0PfrdMcAnOiSkzpW6xf+UvmzaEJNfkPYOx5fvUPkzMeARgNH+BLJhCLO2
         YuwA1d2lhsWTOrSIwZXx94XsCjXUeBTsO3j06SWOFw6nVjJqUlro3YCvkoTOqrerYdzv
         pR0oFYYb/UA5PjEt/B98ZKJ8rNKEb86EJQnn83BbhLu5pWEFCFZpjVzSdOJvVpiLWtap
         xGFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxW4GVckiCEPYa7+kOjRW31PkXzhe/jL8VMmFM2Y+kDnRtWQCXk6cy/rLZ/kbJCf2QM/dda/SY=@vger.kernel.org
X-Gm-Message-State: AFuF++nMZ7KvkfFjSKvqLrQ12Ue554nTtDykV1Iz2/qImpRWSD2QRoSq
	L97XmSRNJUqz5TXhnihQfVKpk67PmqpIINos7JvZI1RpHG8oMx3r+sIqohNbvZeTMTgSzKuHH6U
	UE+yJ64cY+xffNhEQ8TDOLvD1DpqJ86Opw7Aic2mklzor76FXoasbygoykxg0o3jmrUJUMUQA7A
	I9uKrES8HZZDFKsXp9grfKWY3zZYedDN5MnOEZSGoZ7LWZKi/lMcXfo/YqSJ/FzlxKkKJZxnHoE
	wbHE19rCsc=
X-Gm-Gg: AYBFou2hPItHtNl/9NRrNu+rYfrWtLF8YTIjSC8w/rjxYDVw4IoctxlYmq0uj8N3it3
	5UiHrZwAEo1WXjJxlvL46hgYsy7qTgZ6MEPCuqKz7pg+tXdm9KaWzOferZ0XbefjXqdQ2uB/+dk
	bpMkc7JrT0RZGXnfXnPX+eJy0ywGdgOvT2H/gUk7Uc/oTTWNw966zeCgG0vw2fIPrnxkoOIRg5D
	uBcpvBctcugo+Z7RovY6VuTEKzPfcazdIfRrH3tBB2kiNN8ZI3ZJrM8rn9JZEBMGyAlx3mPjz8w
	jFUxzPQtSC10VDLrkQKtof74KKtauc1opTaJBuFJ68JovqqPTaat7iBnBPgLCe3hY+G8nuDEmCX
	cy38swBxgOrdLKMIViVif7ZbXBWTAq8/HUj+4G8JbSVCYrTu2++sDCwdr+YRPkYOjzNcDO4SWKM
	hIJKF9Y1oBULqAOJ7n5FeMgMBqjdPlkReTIGw=
X-Received: by 2002:a17:90b:2b47:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-396d0d2c9d3mr24164989a91.3.1787995693886;
        Sat, 29 Aug 2026 02:28:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-396ddcbd559sm1834823a91.11.2026.08.29.02.28.13
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Aug 2026 02:28:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8485d853b08so3022735b3a.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787995692; x=1788600492; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t26kcwvkPuDpRsCIZWWZntaAlnUev+NYgbbAdGbCCsU=;
        b=EDyiV8pzPjGT8omSJ0RkR1UsSqkCJsX1tFeBN1CSPNG9fOMv0MJBRsTrPV/DbWPByA
         eh/l9e57QEmP4eqXL+XJuSDI6lsffYjX3KnJSUlKykBweh4a3xddAI2v/t7D60MYOSSq
         bs07qe0YX9B/06IbBfx74OkeIAkOnqFYxkZuA=
X-Forwarded-Encrypted: i=1; AHgh+RpLktKvvx/9ZTKqX3iqIw9184gsQlwtUUAHKwutmSGo3349tSMPtd36ZZjxTQUE+uUq2Gmsu/E=@vger.kernel.org
X-Received: by 2002:a05:6a00:1813:b0:848:4754:28e5 with SMTP id d2e1a72fcca58-8562aeaa990mr22156842b3a.16.1787995692269;
        Sat, 29 Aug 2026 02:28:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:1813:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-8562aeaa990mr22156780b3a.16.1787995691772; Sat, 29 Aug 2026
 02:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827230233.94878-1-joe@dama.to>
In-Reply-To: <20260827230233.94878-1-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 29 Aug 2026 14:57:59 +0530
X-Gm-Features: AcwNN1W2waLey4-84n7PaXplySQ4DKnIbZlqhbWc0cUMnHxU3uIb6suUVCnFFFU
Message-ID: <CALs4sv1v7E_pxmdcNzxf8GyR7=-B26J5Z1YZ7fc4Y2Oc7Le8yg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Prevent queue stop with deferred completions
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001e6a03065a2c301f"

--0000000000001e6a03065a2c301f
Content-Type: text/plain; charset="UTF-8"

>         if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
>                 netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
>                                    bp->tx_wake_thresh);
> -               return NETDEV_TX_BUSY;
> +               goto tx_busy;
>         }
>
>         /* BD backpressure alone cannot prevent overwriting in-flight
> @@ -77,7 +77,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
>          */
>         if (!netif_txq_maybe_stop(txq, bnxt_inline_avail(txr),
>                                   num_segs, num_segs))
> -               return NETDEV_TX_BUSY;
> +               goto tx_busy;
>
>         if (unlikely(tso_dma_map_init(&map, &pdev->dev, skb, hdr_len)))
>                 goto drop;
> @@ -235,4 +235,17 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
>         dev_kfree_skb_any(skb);
>         dev_core_stats_tx_dropped_inc(bp->dev);
>         return NETDEV_TX_OK;
> +
> +tx_busy:
> +       if (txr->kick_pending) {
> +               u16 kick_prod = txr->kick_prod;
> +               struct tx_bd *txbd0;
> +
> +               txbd0 = &txr->tx_desc_ring[TX_RING(bp, kick_prod)]
> +                                         [TX_IDX(kick_prod)];
> +               txbd0->tx_bd_len_flags_type &=
> +                       cpu_to_le32(~TX_BD_FLAGS_NO_CMPL);

Should we not do a bnxt_txr_db_kick() also? It maybe a good idea to do
it in success case also instead of bnxt_db_write..

> +       }
> +
> +       return NETDEV_TX_BUSY;
>  }
>
> base-commit: e2a6641e3bfde58f2284f9859c2b0fdcc6d1c0da
> --
> 2.53.0-Meta
>

--0000000000001e6a03065a2c301f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCApf3Kc
KMpaVA2SYnBX25ZfcHtMsbir5DjMFuZzCvUg6jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MjkwOTI4MTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCq+Fz95uI1hCHCkST8+ZeSLOBMc8dxYAVF0M6wQS93
MecgVaKvXY6VBkEuCa+WUCMg6bT3eZ+VDTiClCue37oVhaqqWoq7g9N0p0sjosEIdUdlOK0jw/2R
aeKq/o51SpIdnKd1To3OEOFipn1SJiP56JQ1GsCcfFCdBRF/5kV5mDSbpQvFyU0OiXC8Y9hTZIWa
uRvsHnbqk/GQKBfwwQeW2joVKFUkTZvfkN+ziVADW0VmKIebcYIRSuA2kY2arJxPChbhkXhmD13A
IRvlhvDKAd2dyeRVyA9q8ZAHhEtW3BMMRMoOjkh4zP6AFDu/E+tfaAFX5nudtpxynMWeZt/f
--0000000000001e6a03065a2c301f--

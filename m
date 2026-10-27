Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793113411;
	b=xakDYnIb/loCl6c7Lb0yqEwZgTdfpZ7yA150r0qFEcqRWAzA+c+Iqg7TRMeQC8+eK6Xs
	 ic1+ff/lZLzJUxnmPntNUwioO99NoZ5mrwEU+AmRwfi70nXJKMEQOE+JytFrkUgywwoYd
	 9KFocjHmU4kvTXIOuESIfYjELXEEytn1O8erSuzNeBdQfvG28NZ0Yt7Y1f/mXICHacoID
	 W9qFOkwpc0mmFB1VYKuyXNRcEu98N3H+yje1a3as98wmzWn1DA3BIu6eB98/klKibPDMB
	 dUQJxvVGDJH2STOqddmz/7uFD893DSUh0ifM71TeCD+ZUIQf7oW/+MGKyJq/PJ60+eA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q4yjzdXp7FCkLMermgzdi57SXBbbuDvC0SxPh7Oh9/M=;
	b=bfGcZOfLPmMrfI33xTaXrS/Zvp3AzJuX39mdkw1R+CEq7UhOSdp/KFVeWU5+f9KpJiS9
	 AGZwI+JVcalkqWUCH0GsXSJqjJYXlEu7ch1DUgGbFoodRn8ipRoNcAcWfcI95HhT+FtgB
	 oFAJKHYPSC7vCjX6boLqIbfOAcmYnj6XpbJXX0D4IvXc0q6DM9ked3y1Oa+vOAAEwrWuq
	 q0hPA9JqRNeuKkyhFs/4aWlO3gbhF8RILaBbbh1JksT+pPY4rtQS639EulINs5ALfFvg1
	 P/CTWwD9i6do7/TZxoNa48uo0ngHTCoBkLPIf1a/7hQUBrFwaLhFvKqawMKTDDf6qEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=WeYNsnTq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C4606A330
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C1C4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=WeYNsnTq
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so12248241.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793113409; cv=none;
        d=google.com; s=arc-20260327;
        b=hq1+4i1+Zdrrq5xtIdGqlmsHw5d+htrXj3UZ8X/aM74M52WguwQzKeJe+sHGLDJ9Yp
         gJkZMhKDd3BVHMQ8+0CjReXOqOCPJkmYwBwZjoCQc0Hjmz8ddLIsGyLqe4UiTVcVcZy6
         DxB0ozYmCdB/NuqvPwPU/pDLlURDVyWbNS9Bl7Nj31RGMt4NdaHs0hTkqSp9PuIvnCZm
         9ApPnSLhdp3zAEqzq2iN6WOFiNhZ8POg8Sm0xRtFBvazY03bdC+na3Do+KcMMCf4Jcih
         +xDTNdxEFIGLIXn6R/bVSjDibxFRAoXSmV40SWfgiHBiHOxLh2xZgn52SoTZe9/vvIU1
         SQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q4yjzdXp7FCkLMermgzdi57SXBbbuDvC0SxPh7Oh9/M=;
        fh=gRPYWf2aG/KYcuIy/fMvH4ePGfluybUzkNYLAY8w9iM=;
        b=F4Njh553lKLOqpEaWTr4gcP/eOwJpajrWrfwJOfiQ8Ngma8+XR+WiKUkEdAgoqrwWU
         0iBSHvD7aDmolDz/GrnqY3yI2IB+INb3ZJneHPMRgMCO4A4LBDL+HVkd/kZ5JUosxBqk
         SeCB+fs6BPcpLvVmNR17a5FoQMUH9gJ6DEu1u5piHgag+DVgdTDSk5Jq1CX3Fka6zOAF
         oiiQLcA+zZf1a+mTblIYk/tzN/208/+Y8gWVUKh/H9fhzspT4+CA6bU2e8rq6k9diBz8
         UHtTpMwk7rXSdhXauwPsHAHI1GaXqPcli+qFBPOBH61jXa90Iu7Gcl5CTUreZHtnZFRg
         JmAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793113409; x=1793718209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q4yjzdXp7FCkLMermgzdi57SXBbbuDvC0SxPh7Oh9/M=;
        b=WeYNsnTqWZaF3xsNZX5JViJKmK7h4YyKeRJS3ghyg044jPC8aI4WLIowLZD/nrYXAE
         4TLAdMD+bPCnBgDqbi1tXwZA0LCgtiRKL/xKY5zG2j2tNUWVKYgmU/qkRT2w30jWjGbP
         3AojjbEL4Q2FuhYBvGWXnUK83eoevXqZCIs+g2Sq0kJ0i9wIgp1xGxIG01zsmygoFgJj
         buaIxfU5spY57qEtKPG94lYfIsX3NqOykWXO8l/z4kClTfs/fYLga35qF+KXHztHdMEw
         3KdFMbCQA1qqEXvrRvVdSX4a5TUmwHVkgIoBnbXdP7cMjCo+oJuXuRymj8LNc7AslSmo
         AD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113409; x=1793718209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4yjzdXp7FCkLMermgzdi57SXBbbuDvC0SxPh7Oh9/M=;
        b=wiMaAbf9JRcBtDVdlc09o0ukEDs1C55htkeP1MNiucok5VnsKx5J6MP2Rn1LQzk9XW
         QaGjeRgoDOFZXp99R/4CJWLSEN2Q6ThYZds1OqHLfTFx/qqPLiTIaGJnoQ79KMbHGC4w
         HNBa2BvxrmPMuAk8u604RKW5ZLaPYk6ayTBiXOw/wgcBNq2auGoyCsD+88kIaIq+nQ39
         SbP8qpL/FqpRwy8MFfahSCqUWFxPbgMmtIjFx0jrhF0YQSTIhlkUtqWdpqOccBoGQRdm
         xKlKP7sMFOmNgruTQip3IJ/ZDgAp3ZV+lgKjSr62w4B8sad7hd3DmZ+8EoCfdH7PPJLv
         7gyw==
X-Forwarded-Encrypted: i=1; AKwUvBxCIyHheCWktquZMBma7cEZEr9nW7EXvEq5Zd+UG28llSpuwyKpmvmnMs2tYL5t5CnHgz73h+A=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2h/PAo8AidB4PN3wWDJor5acGZSPRuThAXwaf/vl67w2s3lvw
	lM7yN+Aw3XOqf1e0iOMIomQrcjjmixpPI/pcexlJrZKgtN4SA1noGwbeYg2kFxS66VXuKdZ4Zg5
	AuPKZGJAE1BkpapwVX8BIWlih5ekZbFrVdX1a5u38tw==
X-Gm-Gg: AYBFou1ZNr2AEJU9yP21RnwM9nS5dvsL6wp7OnuledL1rW1k+pDNDDsDKBJw+EQE+UW
	pMBTdTq7uzCCG/qbJcb6sMu9CnPk8fZLvcSit3ZPr4pgJl7hCBvnYcsXPyFA4uVNr5lX1FFw0uQ
	uU47QXrYm5hOzN5wNMueZ6gf9HvqiQSQ0gc1h7avNN0OroDgPp92dFOE6dY1okBoHLaHCatuvbJ
	UrcalQjP+l2a6WKhwyy+mp2huNplSPR96UyNq3Ab0l1IRYrtQcYbaUTRq0a0Hc4c4JSUvS5gnQD
	9fT8AH5RELLAN/jlEtfNRAnJnNPW+ViIZu/99monrADtmSjFgD6IDFb56y66CCxIixHz/kYJ2b4
	gX1OKgiFOd0s+lOVVszY1na0v+v4BxaEsG/RfOM9r2P0bH7S4JUCOeJBxHfdlX2SOalQrz6EyJM
	LY/Zc1SfS72/ffPs/XvKnEN1vN8FIn35fpvwImcm+YkgF2R4flKwMz+23espv9yEYBC/P64TcOn
	DvT3IQqmJ8WjVfDT5IL5eRJ
X-Received: by 2002:a05:6122:20ac:b0:5ce:ab22:1749 with SMTP id
 71dfb90a1353d-5ec23091f23mr3869101e0c.1.1793113408876; Tue, 27 Oct 2026
 08:03:28 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020181147.939575-2-rjethwani@purestorage.com> <179287171668.3134.17927231522917764342@kernel.org>
In-Reply-To: <179287171668.3134.17927231522917764342@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 27 Oct 2026 08:03:17 -0700
X-Gm-Features: AclHuK9yL4WWAq3mrPn8b4cfVf3joHDTYv2MvTxMA1PYLKyDQCOolR3KWG6ODwQ
Message-ID: <CAKaoeS2Gj86TpdD6_BY=emw0eaDZ5Yp9LuHoBBYjxP1sg5mxow@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: net: add TLS 1.2 hardware offload tests
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, aviadye@mellanox.com, ilyal@mellanox.com, 
	borisp@mellanox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 12:55=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] test_tls_offload() in
>   tools/testing/selftests/drivers/net/hw/tls_hw_offload.py skips the=E2=
=80=A6
> - [Medium] main() in tls_hw_offload.py raises KsftSkipEx outside
>   ksft_run().
> - [Low] The comment on HW_NIC_COUNTERS says '*_packets increment once per
>   packet the NIC actually encrypted or decrypted ... so they prove the=E2=
=80=A6
>
> --
>
> selftests: net: add TLS 1.2 hardware offload tests
>
> This adds a two-node kTLS hardware offload selftest. A C helper installs
> fixed AES-GCM keys on both endpoints, and a Python harness runs echo
> traffic over IPv4/IPv6 with different payload sizes, checking the TLS MIB
> and NIC ethtool counters to confirm HW offload in each enabled DUT
> direction. It also adds handshake and alert record-type regression cases
> for the push_pending_record fix.
>
> > diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b=
/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > new file mode 100755
> > index 0000000000000..37f26e21a7b78
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > @@ -0,0 +1,402 @@
>
> [ ... ]
>
> > +# TlsTxDevice/TlsRxDevice in /proc/net/tls_stat only prove tls_dev_add=
()
> > +# accepted the offload:
> > +#  - *_packets increment once per packet the NIC actually encrypted or
> > +#    decrypted (mlx5 counts gso_segs, not records), so they prove the =
HW
> > +#    crypto path was exercised.
>
> [Severity: Low]
> Is this description accurate for the TX side? Documentation/networking/
> tls-offload.rst defines the counter as:
>
>   tx_tls_encrypted_packets - number of TX packets passed to the device
>   for encryption of their TLS payload.
>
> mlx5 increments it in the driver xmit path while it builds the
> descriptor. It does not wait for a hardware completion:
>
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c:mlx5e_ktls_han=
dle_tx_skb() {
>     ...
>     stats->tls_encrypted_packets +=3D skb_is_gso(skb) ? skb_shinfo(skb)->=
gso_segs : 1;
>     ...
> }
>
> So the ksft_ge() on tx_tls_encrypted_packets in check_hw_crypto() shows
> that the driver handed TLS packets to the offload path. It does not show
> that the NIC encrypted them. A broken HW encrypt would most likely still
> be caught by the peer's TlsDecryptError check or the echo memcmp(). The
> gap is only in what this comment and the "NIC reported no HW crypto"
> message claim.
>
> Could the comment be reworded to match the documented semantics?
>
> > +#  - *_ctx increment once per tls_dev_add().
> > +# Missing NIC crypto counters remain optional.
>
> [ ... ]
>
> > +# Drivers whose tls_dev_add() accepts only AES-GCM-128: nfp
> > +# (nfp_net_cipher_supported()), cxgb4 (chcr_ktls), funeth.
> > +GCM128_ONLY_DRIVERS =3D {"nfp", "nfp_netvf", "cxgb4", "funeth"}
>
> [ ... ]
>
> > +def test_tls_offload(cfg, cipher, tls_version, ipver):
> > +    """Cipher/version matrix over the HW offload data path."""
> > +    # The tls-hw-{tx,rx}-offload feature bits do not advertise cipher
> > +    # support, and there is no uAPI to query it. Skip AES-GCM-256 on d=
rivers
> > +    # whose tls_dev_add() accepts only AES-GCM-128; keep the HW assert=
ions
> > +    # for every other driver/cipher pair.
> > +    if tls_version =3D=3D "1.2" and cipher =3D=3D "256":
> > +        info =3D cmd(f"ethtool -i {cfg.ifname}", fail=3DFalse).stdout
> > +        for line in info.splitlines():
> > +            name, _, value =3D line.partition(':')
> > +            driver =3D value.strip()
> > +            if name.strip() =3D=3D 'driver' and driver in GCM128_ONLY_=
DRIVERS:
> > +                raise KsftSkipEx(f"{driver} TLS offload supports only =
AES-GCM-128")
> > +
> > +    run_tls_test(cfg, cipher=3Dcipher, tls_version=3Dtls_version, ipve=
r=3Dipver)
>
> [Severity: Medium]
> Can the tls12_aes256 variant report a false failure on mlx5 devices that
> lack the AES-GCM-256 capability?
>
> On mlx5, AES-GCM-256 support is a per-device capability bit, not a
> property of the driver. mlx5e_is_ktls_device() turns on the tls-hw
> offload features when the device reports either tls_1_2_aes_gcm_128 or
> tls_1_2_aes_gcm_256. mlx5e_ktls_add() then rejects any cipher the device
> lacks:
>
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h:mlx5e_ktls_type_c=
heck() {
>     ...
>     case TLS_CIPHER_AES_GCM_256:
>         if (crypto_info->version =3D=3D TLS_1_2_VERSION)
>             return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
>     ...
> }
>
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c:mlx5e_ktls_add() =
{
>     ...
>     if (!mlx5e_ktls_type_check(mdev, crypto_info))
>         return -EOPNOTSUPP;
>     ...
> }
>
> When that happens, do_tls_setsockopt_conf() in net/tls/tls_main.c falls
> back to tls_set_sw_offload() and bumps TlsTxSw/TlsRxSw. setsockopt()
> still succeeds, so the C helper sees no error.
>
> mlx5_core is not in GCM128_ONLY_DRIVERS, so check_path() with
> require_hw=3DTrue then fails with "HW offload not engaged", even though t=
he
> device is behaving as designed.
>
> Would it be more robust to detect this cipher-specific SW fallback
> (Device delta of 0, Sw delta of at least 1, no TlsDecryptError) and raise
> KsftSkipEx, rather than relying on a list of driver names?
>
> [ ... ]
>
> > +def main() -> None:
> > +    """Set up the DUT/peer environment and run the offload test suites=
."""
> > +    with NetDrvEpEnv(__file__, nsim_test=3DFalse) as cfg:
> > +        cfg.bin_local =3D cfg.test_dir / "tls_hw_offload"
> > +        if not cfg.bin_local.exists():
> > +            raise KsftSkipEx(f"tls_hw_offload binary not found at {cfg=
.bin_local}")
> > +        cfg.bin_remote =3D cfg.remote.deploy(cfg.bin_local)
> > +        check_tls_support(cfg)
> > +        cfg.cleanup_failed =3D False
> > +
> > +        ksft_run([test_tls_offload, test_tls_offload_sizes,
> > +                  test_tls_offload_record_type], args=3D(cfg, ))
> > +    ksft_exit()
>
> [Severity: Medium]
> Does raising KsftSkipEx here, outside ksft_run(), turn the expected skip
> cases into failures?
>
> The missing-binary check raises directly. check_tls_support() also
> raises KsftSkipEx when /proc/net/tls_stat is missing on either host, when
> ethtool -k fails, or when the DUT has neither tls-hw-tx-offload nor
> tls-hw-rx-offload enabled.
>
> KsftSkipEx only becomes a SKIP result inside the per-case loop of
> ksft_run():
>
> tools/testing/selftests/net/lib/py/ksft.py:ksft_run() {
>     ...
>         except KsftSkipEx as e:
>             comment =3D "SKIP " + str(e)
>             cnt_key =3D 'skip'
>     ...
> }
>
> NetDrvEnvBase.__exit__() only calls self.__del__() and returns None, so
> the exception reaches the interpreter. The result is a traceback, exit
> status 1 and no KTAP output, and ksft_exit() is never reached.
>
> Most NICs have no kTLS HW offload, and on all of them the kselftest
> runner would record this test as FAIL instead of SKIP.
>
> Could these checks move into the test cases? Alternatively, main() could
> catch KsftSkipEx and exit with KSFT_SKIP (4).
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261020181147.939575-1-rjethwani%40purestorage.com

pw-bot: cr

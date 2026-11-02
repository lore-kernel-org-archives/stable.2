Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793654793;
	b=0BfEbTuw/LKrCCv0Gx9TYJ9iVLhfosEkFQYgaSbge+6/lWi2MplBZzXp1SCL+ryvGZ3n
	 JSE/Mp8dhkUiBapqBeZTKJfA9ihWMAzowgve/+HZ0VONGiUSSf7boyO3iR2WJCUF4xVpd
	 v6lwRHSJUHktncjo3mdDl9egw70RCoUM8lds/uffu7whZbZAj3w3DUK7gO0WtVb+FPBoa
	 oCF1XYHpJDmIr48l6Sztgg2qpmsQKv7ROOqgmKNLRJzu0o6rkEaojfgNFn0d+R/pYSxan
	 q2+2q6NGOzP6ehAf22SJLq2K/34iz4T5oosUQ7UaA6ouYVvxIHWxaX9xJBOwf3WPrWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VQNxh4E09UbuTnsPgF35Q2gxnGUXI30LdDtVm+7397g=;
	b=HHxaMmtn7nuCrBbZZf5bWoGJC9NT5oO+q/Kc8KudNuf4ruHdeUH1HWkUT5XJuy2NmW9H
	 MG8uVoK5UpI7zAifEHXp3YABk5rv2s0xLMbedAsuR4BWBs4S8Pn5ARWjGPmcMmS0YGobV
	 RkPOJjGgNwjP9RYD0evYod9XtJjK1WodeTtes43vZWS4V8nTo7b+wHZ666zfNmADUgtw2
	 Mq+ZXc2xFDj4G6mXWMaHsYEtQbjY7Qm9VqJH15J9ceApUAOVZM4b2HxfXv7mx8l3hclSq
	 fXryw0zXV0V0G+UAGzzh3a03ZXezNf6w4t9U52xqYref7pG+Z5SvKUu1vYKPbfl7HDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=F9v8zzb8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4A606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E4A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=F9v8zzb8
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so2936905e0c.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:26:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793654791; cv=none;
        d=google.com; s=arc-20260327;
        b=rkLMe0jNwtsIXe+x/brMgJ0A+wiAfC43ImHpQjNICEqklVLGhLG6J1V6UIIOYVLAKE
         /+lkueIof8o3GiACrGnxXW6c0XvbNUtu6MG620YzElHpoI9YeNrq5oUxPsPmM5nQybsc
         vlHxbEkbr0qJcoLNqNu1+zRyOlZL44Ezyc0rR7RHHW8AJ8szRSXFnxgj7qqHV/YEWWUp
         s++cRB6ii749lauRTh2+WVsy6sGCXV0y1eUN369n9VMbgWF0Ib0YtP+chLpzqqoRKKvu
         gRWNi9KhDzRUcLr2l485+RO7jpzPOK7Ya91nAw0dRkXZnn0DtmoxJ6Fvy9UtalvuZc8A
         ZN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQNxh4E09UbuTnsPgF35Q2gxnGUXI30LdDtVm+7397g=;
        fh=2I9+ZmZLd0cv8LSN+0GFphWapgxxSHx+vPCaLbweuB4=;
        b=PUFmv5r1eYsHRDxlHspRcM2KfIJR6afFSST4fntoSeBRv9MqHkcSCYTYCevZ1Wssci
         8sEnOJ5uiqlKiXjm4P5nRhgprL4EHzA3z3BG2yBntT/demXRoSvs0StX/H3hsL444MYg
         1IP55Dnu0iN8G7CSdzXioyZ3ENs8YJUMQzyEpoj36hcDpOj65m73A3OMHPDL9XgAHIPf
         fQ/nhzsfkRMby2WEwY2yGEzwjkB5XV2zqqX9zfDWL23bRpo1N5fijUm90V/mgFBgx5ZP
         065hj1qTUbpXMQMAYRRDYB6Qvpz0ykSAl3y/bSkk4ARCv73pqQ2MYiIwaeOtEJCmSmxX
         Q8sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793654791; x=1794259591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQNxh4E09UbuTnsPgF35Q2gxnGUXI30LdDtVm+7397g=;
        b=F9v8zzb8mKIHR1ATsY4VGzyv5czZzBfUwihwBvEStbjd6IGaWOxvgBy7wXEA5iyGWM
         EXnQMDfibX7Lx4z/pBy8K8kQLNHIaJq4IRjMNheDHttYW/qEZlb9V67Y5jwEFjjrEI7K
         xcHDVD1rQXg6wFypM8kP6b9Pa7JS6azZgs55ZDDOsM4AVgXaWCIW9EQMtgqCPWt63qAX
         +ncHbGFd/X4s4vGvt3eGZN10yzYycx/+h9QG7B2n6YdnA5P78UyNNqMWnXVcKxl7HY5q
         5zVK+g+tadIXx4gye0wlKBoK6prcvm1ems2RmO8PQpWZJiJYsyIlKreIkQf7jpaD5RRo
         uq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654791; x=1794259591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQNxh4E09UbuTnsPgF35Q2gxnGUXI30LdDtVm+7397g=;
        b=G+aGxogecSR1oVlq6T9+lSqxrC3QahgBnzq9xeAxNZ3lbI8GUpEnQA3QlK/36Z+RSs
         6poaUsCopwp2ahIm0IT+taxQHOjH5A8qNzsr+KgLyjqtjEHuJKHv8Sg6A5OBVkGcxsJL
         ZzeqgNBvT4Yhra1vDSAKv6sLrau+VHWjJR6QHrUItN4/HphhPfwJK/iT25LPpmAmDKzo
         srty2UVj+QJVV8mmmPSkU0klAmo9IEWheP4VTfxc9wISGdk0dfMeDwBoztSQDkZzfSn3
         lYcY7n6HEJYevivRPypEHjAxhqch5j6Im23zjQxyY5ma87jCbJHtE4/cKv8lbpfHXLm5
         S2bQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQxoMprN5DF+VJTTj1wOpm8KQbpWrN0bp08CqAHwmeaPkeF1Laxe1tMZ7htcm/Qoc7HYbAmE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GV+cFOSNwPtoErGLEv0deGWLakZotRK6b2vqgeqibcG8F6uO1
	Z+32Ch3o9jIQZsRrU1J9WUVf1Sa2GpX9aZVr7jmN9lwNxdKKqNjM3hDcWMShj20R3QqWSOXAOKz
	4NW0odCokOZ451yogwDCU5oe6BkCY2bBYcZc9gN3zGg==
X-Gm-Gg: AYBFou2VnprKefrt6ONs+COU3imCvTVU6i1yRDxc+X5D3NO2nkJOGanWH23F5Ji+wiA
	VQS8t4e0SEJnLNdkbXpZIz/koSFTetdvXVmXQymkWh1/8QqYwFpQWo30lWkb1Grx0mLIKSc8wQC
	ERXjWdCLFngTE6yAPDLaHkFjN1U6NcKETm4/38X8cb/dpa6bqFTnEuZmE9OobjUF5+BivPPerDd
	pIZae/Lsu/gwcclJZbcAojM0W9fAXY53AXbjdE+SVzRfobsu+lxTM7/PuAko7gTtcRW62zZyix7
	YxyizCnhlQ6oxiBtEjLJoGSGAXe2gvZRHHpSSwTBmOWN/mMVBDK8X4BNkNYDBHUMdgq6s+alkZm
	pu9vP4rTgmfJwH4zAOomAU1i0xx4IH0f4PoCda5P8CMMzbXuvLZHiejiI92Lg+4sO4CKUKkPDBp
	IqopZWWsWuCLPvSSsJfoZbzwSbQ7WMOseJ00ShdW9KDK7BW7clWcbb/2cy83ugNEKZHEbYpY7/N
	One7xQDph9My2xt8T5lBvAv
X-Received: by 2002:a05:6122:21a3:b0:5cd:590:c22e with SMTP id
 71dfb90a1353d-5ec689aed88mr5219637e0c.21.1793654791273; Mon, 02 Nov 2026
 13:26:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029172302.2944955-2-rjethwani@purestorage.com> <179364254636.3131.4069372250703759332@kernel.org>
In-Reply-To: <179364254636.3131.4069372250703759332@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 2 Nov 2026 13:26:20 -0800
X-Gm-Features: AclHuK9nHLnDMQvP2qQAOwulgJKfpc9JDvd1vD557sgt5xdTi1XrzG5V8Azu63g
Message-ID: <CAKaoeS1rw1pB953evvE4H6LC2jTANtJzRWW5kUsteOKOrmDCJg@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] selftests: net: add TLS 1.2 hardware offload tests
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ilyal@mellanox.com, borisp@mellanox.com, 
	aviadye@mellanox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:02=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The tls12_aes256 variant of test_tls_offload
>   (tls_hw_offload.py:280) requires HW offload in every DUT direction=E2=
=80=A6
> - [Low] Two comments say both helpers' stdout pipes are only drained
>   after the helper exits: run_tls_test() in tls_hw_offload.py ("Both=E2=
=80=A6
> - [Low] When 'Rx' is in tls_hw_directions, check_hw_crypto() asserts that
>   rx_tls_decrypted_packets grew by at least 1, but nothing makes the=E2=
=80=A6
>
> --
>
> selftests: net: add TLS 1.2 hardware offload tests
>
> This adds a two-node kTLS hardware offload selftest. A C helper installs
> fixed AES-GCM keys on both ends; the DUT runs the client and the peer
> echoes the data back. The test checks the TLS MIB counters and the NIC's
> ethtool -S TLS counters to confirm HW offload was used in each enabled
> DUT direction, and it adds handshake and alert record-type regression
> cases.
>
> > diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b=
/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > new file mode 100755
> > index 0000000000000..78fa764a6ef3f
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > @@ -0,0 +1,321 @@
>
> [ ... ]
>
> > +def check_hw_crypto(cfg, nic_before, nic_after, hw_directions):
> > +    """Check DUT NIC offload-path packet counts and initial key instal=
ls."""
> > +    for direction in hw_directions:
> > +        names =3D HW_NIC_COUNTERS[direction]
> > +
> > +        key =3D names['crypto']
> > +        if key in nic_after:
> > +            got =3D stat_diff(nic_before, nic_after, key)
> > +            ksft_ge(got, 1,
> > +                    comment=3Df"DUT {direction}: NIC reported no TLS "
> > +                            f"offload packets ({key}=3D{got})")
>
> [Severity: Low]
> When Rx is in hw_directions, can rx_tls_decrypted_packets stay at 0 after
> a short run, even with working hardware?
>
> Nothing waits for the device RX context to become active before the
> peer's echoes arrive. On mlx5, mlx5e_ktls_add_rx() bumps rx_tls_ctx
> synchronously and returns after post_rx_param_wqes(). The steering rule
> that sends the flow to the TLS TIR is installed later, from a workqueue:
>
> mlx5e_ktls_handle_ctx_completion()
>   queue_work(rule->priv->tls->rx_wq, &rule->work)
>     accel_rule_handle_work()
>       mlx5e_accel_fs_add_sk()
>
> Until that rule is in place, records are decrypted in SW. TlsRxDevice
> still grows, but mlx5e_ktls_handle_rx_skb() only bumps the counter on
> the HW-decrypted path:
>
>         case CQE_TLS_OFFLOAD_DECRYPTED:
>                 skb->decrypted =3D 1;
>                 stats->tls_decrypted_packets++;
>
> If the rule lands mid-stream, a resync is also needed before HW
> decryption starts.
>
> client_connect_tls() starts sending as soon as TLS_RX is installed, and
> cfg.wait_hw_stats_settle() only runs after the traffic has finished.
> Could the small_buf variant (100 round trips of 512 bytes) finish
> entirely inside that window and report a false failure?
>
> This depends on firmware command and workqueue latency, and the commit
> message reports passing runs on ConnectX-6 Dx, so it may only show up as
> an occasional flake.

Agreed that on mlx5 the rule is installed asynchronously after the
context is created.
I haven't seen this on ConnectX-6 Dx across repeated runs.
If it does flake, the failure is visible and attributable, and I'd
rather not add a sleep or a skip.

> [ ... ]
>
> > +    # Both helpers run with their stdout captured in a pipe that is on=
ly
> > +    # drained once they exit, so the helper keeps its per-connection o=
utput
> > +    # small (see the note on verbose in tls_hw_offload.c); do not pass=
 -V.
>
> [Severity: Low]
> Is this comment accurate for the local client?
>
> Only the remote server is started with bkg(), so its ssh pipe is not
> read until bkg.__exit__() calls process().
>
> The client runs in the foreground via cmd(client_cmd). In the non-backgro=
und
> case cmd.__init__() calls self.process() right away. _process_terminate()
> then uses self.proc.communicate(timeout=3Dtimeout), which drains stdout a=
nd
> stderr while it waits for the child to exit.
>
> The comment on verbose in tls_hw_offload.c makes the same claim:
>
>   /* Per-iteration progress output (-V). Off by default: the
>    * harness captures stdout in a pipe that is not drained until the help=
er
>    * exits, ...
>
> The -V restriction still makes sense for the server. Should both comments
> say that only the background server's pipe goes undrained?

Good catch. The foreground cmd() drains through communicate(),
so only the bkg() server's pipe goes undrained. I'll fix both comments.

> > +    #
> > +    # Both helpers exit on their own within HELPER_TIMEOUT_S (see
> > +    # tls_hw_offload.c), so nothing outlives the variant even on failu=
re.
> > +    with bkg(server_cmd, host=3Dcfg.remote, exit_wait=3DTrue):
> > +        wait_port_listen(port, host=3Dcfg.remote)
> > +        cmd(client_cmd)
>
> [ ... ]
>
> > +@ksft_variants([
> > +    KsftNamedVariant("tls12_aes128", "128", "1.2", "4"),
> > +    KsftNamedVariant("tls12_aes256", "256", "1.2", "4"),
>
> [Severity: Medium]
> Can the tls12_aes256 variant fail on hardware and a kernel that are both
> working correctly?
>
> check_tls_support() only looks for "tls-hw-tx-offload: on" and
> "tls-hw-rx-offload: on" in ethtool -k. Those flags don't say which
> ciphers the device accepts, and several in-tree drivers only handle
> AES-GCM-128:
>
>   nfp: nfp_net_cipher_supported() returns false for anything except
>   TLS_CIPHER_AES_GCM_128, so nfp_net_tls_add() returns -EOPNOTSUPP
>
>   chcr: chcr_ktls_save_keys() only handles TLS_CIPHER_AES_GCM_128
>
>   funeth: fun_ktls_add() returns -EOPNOTSUPP for anything except 128
>
>   mlx5: mlx5e_ktls_type_check() checks a separate firmware capability
>   for 256:
>
>         case TLS_CIPHER_AES_GCM_256:
>                 if (crypto_info->version =3D=3D TLS_1_2_VERSION)
>                         return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
>
> When the driver declines, do_tls_setsockopt_conf() falls back to SW
> without reporting an error:
>
> net/tls/tls_main.c:do_tls_setsockopt_conf() {
>     ...
>                 rc =3D tls_set_device_offload(sk);
>                 conf =3D TLS_HW;
>                 if (!rc) {
>                         TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE=
);
>                         TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDE=
VICE);
>                 } else {
>                         rc =3D tls_set_sw_offload(sk, 1,
>                                                 update ? crypto_info : NU=
LL);
>     ...
>                                 TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLS=
TXSW);
>     ...
> }
>
> check_path() then requires ksft_ge(dev, 1) for that direction and fails
> with "DUT Tx: HW offload not engaged (Device=3D0, Sw=3D1)".
>
> Would it make sense to skip this variant when the DUT falls back to SW
> for this cipher, rather than reporting a failure?

That's intended. A driver that doesn't support AES-GCM-256 offload
falls back to SW, and the test reports that as a failure.
Per Jakub's earlier feedback on this series, HW tests don't try to
skip for every device capability gap.
The automated triage separates regressions from failures caused by
missing support.

>
> > +    KsftNamedVariant("tls12_aes128_ip6", "128", "1.2", "6"),
> > +])
> > +def test_tls_offload(cfg, cipher, tls_version, ipver):
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029172302.2944955-1-rjethwani%40purestorage.com

pw-bot: cr

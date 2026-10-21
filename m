Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605277;
	b=Ln9WiL0hQH2i56QOqllq8yRXbDsBCGGQZRyY1uybEeGoPIAumccjLhr7/xv4L/FzlEvX
	 G96WlJ9k/IlyWNNIOwb1U/RkzBIslmZ76+mwMV8E8JM9QgSdSDQ5RFlkTco/g7QC7hE7A
	 3efAFEpFRF7WxiMs4mbZxzFdPTSgwst0JgetifBhaCNY7bE7G//6l5GtKCJZ9X6ev9FaD
	 huw0uAK8/vYRgbm72nJaY2SenAxrmKAC+Kb+y3vM0PHM+zKyltdH5oQPeQ1DHN8/SrwS0
	 rA9C/Q6H+XfmD8Cx3oNdoYEO8tyTHKcALeug6N0svyXbNe7eLI6vdKlps2pxV0/YKbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bnSgzKVlIwUx1mAdgm8G7itOWlMwTusQYmRJS/QwgdQ=;
	b=ps0ip7FEoGtZpJ6vQzaejt/2tm5yIULP5pmCvJPi/91kEcRLYtxP4yqj6osVLPGHLHpg
	 K3GzXv5IV2H1lplhVZ8oFmQcYzJNHHaJWZeJT8rUnDo07Tu2JNgzAz/PYUMJ6eNKfQPdk
	 Yy0ITowLxgdWpgpAgYz2tnlXbLG0WQsspR7qBM1sLK8ShNQfHElkEjjMIj8OE+UFnikLe
	 1vEl/PQwkmRVWUWI9p/F1dYAPpYDHlLgk1UYcEdfijS4gl701IhhLcbW525DLSuGRQgz9
	 oWcbzhJhV4tF/CgbVd8l6ywZmqY7YflQYA7H+62vC3Xgf3XRerUDm/uIi7dzMUaqN9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="YspD/xZY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B7606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 115B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YspD/xZY
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2db33db4de9so6935ad.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605276; cv=none;
        d=google.com; s=arc-20260327;
        b=EaN6Nhxj6HPF9z98NUpxLvLhOIz8hq5GuDSIU/hPX1K+7YstlI2A2t0iAOWy8n0ylm
         R4GEPh4JM0Yj6DHAJcvpWF5YN8/NJ6dCzfm3zFbZXnPwckw+AFe2VXgZxGfy1ezTzrK9
         GUKMX+m9EfWWruK4tCH7Br+ytfYaNB0be1l+dDoRz7ORIMNVcU8PYOPjyLL5hgzj75Up
         i1jTjQ4EU2F/GhdrMt8XbQzRPBjlnomHO+SK/dxEHnGBsifWXh6sEVGsJ/QpJHHWbwLz
         zhOf/4HZ4sllyIpfRlkQz8DSJJuuxm4wSnX7/RgZ3RvNZbBlsqTI33n96YbgF83UjRY2
         KGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bnSgzKVlIwUx1mAdgm8G7itOWlMwTusQYmRJS/QwgdQ=;
        fh=Tr73vS0JLbWLGw5xoovgHPxo75WBUQfMjjHpKOLoL/4=;
        b=Fva5RmZruqSakzw4925BBKzR0r2A2P8Kavapn22Mv2I4h6Vr3B9Xk8FzC3FbQnmBze
         D3jPPzjB8je+YAee9QnrZululbBYsHUByRXGwPAkVW2t1iEromDWonYkrmxzoCY1GoUU
         dGrYoUeXclDDUKTdWZbGZ2ZMoauEOB4b7N4LH2S+N6he+rnws1BvQ/yX5HgFZQS4wTGA
         lTp8aFJUhbozVVdTxNGafhEqsNMhbC+bRDlpyWIJfqGkTqxePIKHbgl6+MFI87JSa7qC
         Q5hxoXcWcWvgsVMl6R82EUk1rc3EAhmtbvYCzU+2S46fUlM4DeXqPyxqz4RMm88ePTv6
         8BjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792605276; x=1793210076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bnSgzKVlIwUx1mAdgm8G7itOWlMwTusQYmRJS/QwgdQ=;
        b=YspD/xZY44fFV+FFHSZjF/1RlmBvUNuSfWoWWuFHud6JXIClp37+f+OlnoJN1eKOFv
         MQwoRZ1P9DqC2Qp2kHPovo9qAd0TufADjD0onPwpW7vRQHd7e4lfy43i9RbNf9+IekNM
         zlMvCbl+Gs+EP66/kfLB2hUtRPMo0cNKL27WtWxfeIRVgl1aztbKh+i3BhpMc8WkQmRQ
         OU8c6q+GZActMQnlEzInHLDDUC/nt438pE2N47e+HQN3Bbw84i7dNsQh0+pxRanzfcRC
         8HL2Vby3lni04TIOBHrddKZ7sdcx8H6SsjQP1K0p1tG5Sribwas8GMu1gQZTpsDxi+xT
         rVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605276; x=1793210076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnSgzKVlIwUx1mAdgm8G7itOWlMwTusQYmRJS/QwgdQ=;
        b=gD/LR1riyIdit3DBFn++ZHauKPMQk+go03GARSjShKvGPJjijMXjGm9ENXtDmCtdDu
         UWi8dvShCBO2D5cEw/21puqcZ4GdiNqWt+3Yq0msLbRu6Zc+SKLjrQLkIw8MhLffHQhn
         ywHDgTNj7mLZnv4Nx87l3VU/gL5gS+EKJnJoxiLE8kGaw5H1/VmZSN7D3vzTpeZlgQ/+
         I2LwDmdisdwx7suQfmpJKfE7ogHqbOnBOSQJCitGufYhgXTFscGC83hCy6YPSjBYdN8G
         UyF5Ycd5WUXbBtiCtXsoOJNxQt9w8Fos+pXMqehUkoXOfhpSgCgOlrkZtGfNEnk2bSHK
         oQQA==
X-Forwarded-Encrypted: i=1; AKwUvBx/2OKl8S6wjk8nhIRCRcn+/kA44XnnNl9ZDHm1uVdjq4yB2ruPlB8tti3DKp7PhEu3fvx5LmM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUR2ZrbZKx8jL47pIhGGk1ZiEYLMtsqPmEN9ea+xjPnPwPUR0G
	xsZIy7LTcmG8QM2Y9VcjfcSFWxpkXnkVxTQsyj0pujb+KwSRVZLWGHuIC+yGbh6nBDqaJFHTmxd
	MCxHtQNpkNdjkH03r1FWwsbkQSCWvDNI74T7l3KLP
X-Gm-Gg: AYBFou1GQuqnwJjl9bP+uVQOwGRrzYInZQ8YpHjgYTouJl5nzLpg90oeZnNQyuinS/x
	pdOK9L3Ri6mwcrwKKMQ+S93E5pzFsicyztwFEJc92ejEHY7ARmbP6oLyYJVP1GynctfQfhvoSl8
	I0MxwebcBV0pOYMOkjI1VE94cHVBBePVT0/TiB7+EkAYFd17FDeiJzMDqnC7sv6aWv4VzJaIYOL
	/dWEBua8jrn8d6SyzQWSi+/IfTrfbLb17uiRtN+sOicr+b82VLubeL4/GXj3NkBG3G5Jo+MPFqj
	sRg0/YySWyoqQeyr1nB/naBNK/8eQCva80kwczWE15z9nwcB/fxup+ZN4cwfWXGNe1GJ8XsvxwS
	wSH7KfVm6Rjj/UOSwRP6fxQ4RY0wvJGTEtXeuNcMBnSwgji1dThg1YM8bw1QDPvqbL3Nsbu0Hh8
	kKeihLsVpCH+X9ATEj52IevpXqzCskkxTZlesP
X-Received: by 2002:a17:903:1c9:b0:2e6:f400:5655 with SMTP id
 d9443c01a7336-2ea1ad93c36mr12625325ad.3.1792605275821; Wed, 21 Oct 2026
 10:54:35 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 21 Oct 2026 10:54:24 -0700
X-Gm-Features: AclHuK8DF4cNZdOlsLxmOPiqNQYOfIZsIcUlIaWsQRwFpFNtX7VrcLCvRlNCrbM
Message-ID: <CAEAWyHeByLa9ONLzb+NiaavjVSpuNHbEgM_u9uzyVGV3w2zaHw@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix out-of-bounds read in gve_get_flow_rule_entry()
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: netdev@vger.kernel.org, Joshua Washington <joshwash@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:33=E2=80=AFPM Aamir Ahmed <elb12345@hotmail.co.uk=
> wrote:
>
> gve_get_flow_rule_entry() checks the requested location against the
> first and last cached rules, but rules_cache_num can be 0 while
> rules_cache_synced is true: GVE_FLOW_RULE_QUERY_RULES returns the rules
> from the requested location onwards, so a request past the last
> installed rule - or any request when no rules are installed - returns
> zero rules, which the driver accepts and marks as synced.
>
> The next query evaluates rules_cache[*cache_num - 1] with
> *cache_num =3D=3D 0. The zero-initialised cache does not trip the earlier
> comparison, *cache_num - 1 wraps to 0xFFFFFFFF in u32, and the read
> faults about 352 GiB past the cache. ETHTOOL_GRXCLSRULE needs no
> capability, so an unprivileged user can trigger it:
>
>     BUG: unable to handle page fault for address: ff240996c4c64fa8
>     #PF: supervisor read access in kernel mode
>     RIP: gve_get_flow_rule_entry+0xd4/0x110 [gve]
>
> Treat an empty cache as a cache miss and re-query.
>
> Fixes: 6f3bc487565d ("gve: Add flow steering ethtool support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Thanks for the patch!
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

> ---
> Reproducer available on request.
>
>  drivers/net/ethernet/google/gve/gve_flow_rule.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/ne=
t/ethernet/google/gve/gve_flow_rule.c
> index 2c80cda..db8b9a3 100644
> --- a/drivers/net/ethernet/google/gve/gve_flow_rule.c
> +++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> @@ -206,6 +206,7 @@ int gve_get_flow_rule_entry(struct gve_priv *priv, st=
ruct ethtool_rxnfc *cmd)
>                 return -EOPNOTSUPP;
>
>         if (!priv->flow_rules_cache.rules_cache_synced ||
> +           !*cache_num ||
>             fsp->location < be32_to_cpu(rules_cache[0].location) ||
>             fsp->location > be32_to_cpu(rules_cache[*cache_num - 1].locat=
ion)) {
>                 err =3D gve_adminq_query_flow_rules(priv, GVE_FLOW_RULE_Q=
UERY_RULES, fsp->location);
> --
> 2.55.0
>

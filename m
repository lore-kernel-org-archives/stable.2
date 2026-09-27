Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7241A55D
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529052; cv=pass; b=mV/2n2iCb/awYTw4G2ZhmUf8bQ12YgwSChM59skmhrx0NuvWKnkAVNrEY5HVG3LeY99lg7BdBhR2HVP/gaq4VOCz35Ox2tmA4idYya/Au1aedGpHXkqy7UMY3+GUvcsOk9pUmYv6MPaozWCNEurHdQTbThtZGX+EfOYKn0uzGFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529052; c=relaxed/simple;
	bh=ikTxL5JuCzeBWeGH3nGI6q2+sz2cBQtCh19A8s6v9IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkB/lGS5f4BcSEnaxYDyWvuygawZIg+4XShEfqe2CyiH0TImXq4BY8lnoRMCQn3ay9b65f1bOzH9yK5V+lSCMDjZ5XR3Wj+DNXwRzxoOVz2VUWpX+JpwaNu+dgVppk6RfAS+BJg92XVLs1h06Bv30L7lZK01cO9HDofkmoValGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pl5oaSsw; arc=pass smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pl5oaSsw"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-53336049862so5932271cf.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 10:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790529050; cv=none;
        d=google.com; s=arc-20260327;
        b=oG+xlj5sUkC61iaNSj8MHlAP4fI4Gyy0wsM+kzns6lNJttlWYYcQ40fm77Om7InEXO
         jr1oPXNhTNXL3xdyOacR52Yp6WH3h37WyauQ9awUcJUdJyRQvzdku9Xf0dAMATfJCyQ8
         0aZ28ipgvCykyngqYOQqfOTNlPF8Y9RHOS8xpfzoII2HoGqjk4PHQwZ8Xt6HhZuLSsTj
         xV26AGmUnmZF6SyyE+RGp6mlrcI5xbAayMxSPXv/C/z53iwTQt0zPM1L6WN8feQLuC0X
         eX/k8Me7JfkGYMstQpOF+6+DpYf/wQUFiOkDN3psHFXvcQ78trzbArNC7dtjydPVd2pX
         61CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ikTxL5JuCzeBWeGH3nGI6q2+sz2cBQtCh19A8s6v9IU=;
        fh=4lDzYFLrL2JaaEu5lP89l5sEtEzVoN3cNsw8IXip/uc=;
        b=XGJ8KlOM/o8Xy0reGLKDOEN9v6sZhNeeQTXy+bv/3fg1820T354HHu57q6cTCt6Y3V
         2Ed/IGi1CWobTQDBCN7/eMB1NOCsPHBJQfuPvigyKFVj8nHwmH8m248ZD2IzOD1ynC+Q
         vaCuBBJWUE5/77tdkc6AsGwvZhnRP/d600FJkwkBK546NGsxVBVQNKHEDNeBdpi7WhPm
         32kFZwcTu/tPLwyleYTbxZqKlOvlIq7SabOCsqQ1kjP3xUKKn/mE+9A2sxgOSERNjLoJ
         wKbd68jBtlB4XJmKooX01QWfw3VDW1akWO5eOXGBOtPe+VaFHXBUN0XFsvzb3V7MMCn4
         wGAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790529050; x=1791133850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ikTxL5JuCzeBWeGH3nGI6q2+sz2cBQtCh19A8s6v9IU=;
        b=pl5oaSswpnk9t4rjwmLnkIZQbSXpEvhz3yxaBMgpof0O5foCC1TBCBub4Sbm3OKPha
         yXr31BWYy+ynor0uVodWrAgSRXspIwCfB9VrcDjnsw2obA61owzNQblnkoszlWmYZ4Ax
         vJUpjN1t6VrI0b5bJo/kEnbzY/ELpoPQcl5bYYcLQPQrdZoAHefirlmp6VtBA/rvtaz3
         6n751M4URtrfEhoEot+zAnm/1ieDseB824xai/TYnPZuL8Hf8+PidZL6soy6/iCtsZu9
         MNuAbHsYWRKC6m9/6vMeu9BBs5Rf2XoockOrWi+rm1K1dEyGeplg4tztubQfaprpmwXE
         3QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790529050; x=1791133850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikTxL5JuCzeBWeGH3nGI6q2+sz2cBQtCh19A8s6v9IU=;
        b=D+ep2UQEjZZm8uMPEy7rqt5dt1uRDLmoDvoZ5ihKR/kPpS7pJIn4ka1H/kFYEB2rWP
         x7CxuthzjbzuvDGillL4tV5J3xhhfhBMp+ZpCQhIhf9Kr+Da7sySbPIumUMbMg91HfMZ
         bvXoJ6+/MQFfE7LkK6DViKiM+XnHjobrrbiL5PpOUaY6GkcfqUBtqba3el/keMcpnaRf
         jq0SnQ8XJs+GLcv44LOl9PNH+9Gj3oLv7RBCZ5OzWve5SZrzS/16fH7aInjUSHlWGm1u
         t9/UIhStO2pFkdA3Y9wIU8qS/wX7PpuXdw5NWipZ3gwLKTi+ExpOYJQimgOmc+NT4w+1
         nM3w==
X-Forwarded-Encrypted: i=1; AKwUvBy15RV7RzZ36x6i6JkAAUzIck9aU9iDWdMiY0l5BI48AG2P3MuEC+u8gz5N+Dmj98kD75Zp5mc=@vger.kernel.org
X-Gm-Message-State: AFuF++nI0Zv3YmxeruXR2PLKGMxsO7tm1LI702BLuzKVMTnNxaFph2ep
	2o+xCUdcJLrhhNIVV0pXdojbokS8FiOXFxaJ+oz/G1xwY2Dpd/bIZNQwKPkKpKeUtjF2c33BEYr
	3NONTlCIPV/iTnnyF3wIo7QeBu3nJuKcLeaIGSJsb
X-Gm-Gg: AYBFou26D+jLuJYQeLyxJDVti46x235b31ICnx5ggzPqLgEdKxWAtppB7btDRI1yRjO
	pqcOGOeqENB/snsryjwD9LaA9ztXCcDPP+skTmn+HoB4V9aDX2QdXaSj2ZCCqxOv8sUj7g4+HF9
	8/BsWgfJklTJw9PkJcE3GxjaK2xNDWqlsl3S7+TjCDRgQlDdMcBv3loPEQtKZ7P/GjKvDIWZypi
	CZymMpc2A6vIbrot1F+CCvnzaSQRcj5reEu50x3fk5jyC/fjnU49/V1znZgYOv8Y5NDzd6FqHa0
	e+x4TzkqxIFgerlo/xcR++8QKygvom0z391coIPDiGrytTicmoiWZXGRgHNrJyrDwjApJUKOM+f
	Jay+o8J5aHTAudXtzIjauCFx8G/eHTrgAdJpYsxgmJEtdUvfFwGJJ25uhRbpPS4FvjzEL
X-Received: by 2002:a05:622a:6f16:20b0:533:3868:1f6d with SMTP id
 d75a77b69052e-53338682227mr27382171cf.59.1790529048151; Sun, 27 Sep 2026
 10:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927163117.746432-2-bestswngs@gmail.com>
In-Reply-To: <20260927163117.746432-2-bestswngs@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 27 Sep 2026 19:10:36 +0200
X-Gm-Features: AclHuK-wtOUaURDTxb0s4NuF5eW9fAjvgRkV0CtGV9tL1ejWVBuFWcDjyUMkjB4
Message-ID: <CANn89i+monpTo=bjqnHRhuGaCkfHe9BJNhJncjK+vUq0YKAAag@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: gso: validate TCP headers before segment length checks
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, co+1fe9b56e2c61be5e@bugs.sh, 
	stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 6:31=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> skb_gso_transport_seglen() derives the TCP header length with
> tcp_hdrlen() or inner_tcp_hdrlen(). Both helpers dereference transport
> header metadata without validating it first.
>
> A TUN user can supply a TCP GSO packet without NEEDS_CSUM and with an
> invalid IP header. The skb remains GSO while transport_header keeps the
> unset sentinel. TBF and police can then reach the length validator and
> read tcp->doff outside the skb head.

Do you realize this leaves non-TCP GSO broken with unset transport_header ?

Please fix tun instead of adding numerous workarounds in our fast paths.

__virtio_net_hdr_to_skb() needs hardening instead.

virtio_net/tun/af_packet MUST not feed 'gso' packets without transport
header being set,
among other things.

pw-bot: rejected

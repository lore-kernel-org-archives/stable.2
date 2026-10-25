Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792925679;
	b=QKErYERHua47vgmLR6cDCj3AqPg5+fpw/42tqwiosdl2PPgb3JvKyTARKg3Xr+uhO0jy
	 EwtJrRnINfsGGqTw1eGubVLnzRoxt1Tvej6gpy3OSGXZhsBMEBDOFs+kyeoj/oyIpgMLd
	 BAnN9joo91k927cOEsHT4XCOIKh6Gj1GK+bwekYbdX8JmdFZl01UXyVNeOjrFy6cvrwxm
	 J9CqQzbZAXUNafaU5tF2JXfnhWS9YtP2t2sdB4Ahr0k3q0bWIqw95A/zlmgHUS5X19T98
	 GOpp+qV3YvnnLtJasaJBnf+QgzYQscZ+4zuJDB4aX15yI8ssBS2wsoknOdy2yNVj1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925679;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YUpmzKZTRSq0SLS/cbOe7m9gR2A9I/YOZNEIBpgGCsI=;
	b=kJtSGd0oT5vQjv/UxnkY6lufB46UJw7AkCoIAHO2OBeBTilkHLmghjqsCp+TzuPqU2Ht
	 xElzCxeSmN+Fii1Y7hnQwFxTtfHIJS7tI3i8t/0rqsEplz/8+VFxdQXAtpD8W4peN7gi2
	 47nXRn2I1DTu7ZGu9Y/NohhJ6bMMmB/uTnV/3h0lpdeGgDJ2HuSrx0BkDMcq2lEfNJJ7j
	 +PVEfSzoprQxk1DKIBhcNCqd9m0S7O+t8BCyEe+j0NWBy5NE6RVAWIzqPPBpyf5vQysYb
	 vBq5l1mPxaLAmU5KxoYVT+cZlHmkDGqqg2lsAh2ReHVeg+EYe/zGYpyHOzUFDqq+B5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AigJWNR/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD5606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AigJWNR/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189811F031E1
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792925679;
	bh=YUpmzKZTRSq0SLS/cbOe7m9gR2A9I/YOZNEIBpgGCsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AigJWNR/+w9M1f3eGhsJQnhY9rfg/vq+tfMFMWTNAe3uhkosA/h25XBDwx1meMa0w
	 4f9N4GKfTSjexHYvUUPagHiSCmIwW24WPruwPszaG3iH2lbkOXc+uLTaFpFIBpcb7s
	 x6bQf/Ayj/oT5kEBrrnSrji7chnxlPMPsDIG92rJhTty0XchLnKmZX95lj1DcO1m9T
	 vc2WN9zrhwtVzA7xxTJeAIZr13hPm7g/5BaAJl4iHIyrsZzUFsqBF+vpXK8ja5osfS
	 Fl4hjJjsPUiIxsxguJu1VtlWnj4NnvWGQRcH2tS854qOw9Jrchxk+TNOMK0tvDiGgU
	 lECDcT/Ze9jww==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-46556b9e02cso1459867fac.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 03:54:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy4N6AU2PdWZutqFe4dJcsL0L0E76awg+h6feabK1Xc/nXEBw+NKnxo1stPee+U4KwDxc3pCpk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4GzNJPOa0wEwN10EEtBhAY4NJl7fv/lFG+8CeF9ltOSsYGLJt
	QzKVUNUh4Fz6NfZV91icvqhT7/BqLL/t+Fdmm/RIeZ2HNi2pQBnnloau+ubrCAG7ftmv4bkPLMu
	VTG7lXUZcu+GOWZgrIw05JvbJ99FSAsE=
X-Received: by 2002:a05:6870:5b8f:b0:493:c06d:7700 with SMTP id
 586e51a60fabf-4a83f57ff87mr1836034fac.25.1792925678477; Sun, 25 Oct 2026
 03:54:38 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025014251.542973-1-yanxia@cmss.chinamobile.com>
 <179289279836.3327.9494173903555653580@kernel.org> <20261025052117.603790-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <20261025052117.603790-1-yanxia@cmss.chinamobile.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 11:54:27 +0100
X-Gmail-Original-Message-ID: <CAL4WiioxAR1ZBjVJNgYfLM0hUwyHapRu+TAUzedpOpe0yheH3w@mail.gmail.com>
X-Gm-Features: AclHuK8-3dHCgmtdtpDWr-ENFR_K6te6aI0Mm1zxluZuaww3MP1c6hfoi2JnGxk
Message-ID: <CAL4WiioxAR1ZBjVJNgYfLM0hUwyHapRu+TAUzedpOpe0yheH3w@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: fix RX byte accounting for local traffic
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dskr99@gmail.com, 
	maheshb@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	yana06070@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 25 oct. 2026 =C3=A0 06:21, Xia Yan <yanxia@cmss.chinamobile.com> a =
=C3=A9crit :
>
> Hi,
>
> > - How the issue was discovered
>
> Found while comparing ipvlan's local forwarding and external receive
> paths: skb->len still includes the Ethernet header on the local path,
> but no longer does after eth_type_trans() on the external path. Both
> the unicast and multicast RX accounting added ETH_HLEN without
> distinguishing the two.
>
> Confirmed with UDP traffic between ipvlan devices in separate network
> namespaces: five IPv4 packets with 32-byte UDP payloads increased
> rx_bytes by 440 bytes instead of 370.

This is probably not a net candidate. No need for CC: stable

Also macvlan has the same issue, maybe wait for net-next reopening to
send a series fixing both ?

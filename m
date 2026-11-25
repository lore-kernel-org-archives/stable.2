Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795577317;
	b=C0kGCXeP87E7f6F47ySAwsrFwPXm5RxHmeXSw8sg5g/v03AmAPA4r7TRzFgKJKx3vYak
	 Aq6uBbcdxrx/JDDyRg0QtEGXwLqCdgPPJlMUdhC8Od3Rr/RZDvqr3QkZ9Kzz42w2I3fof
	 pXt6KVBhUG2wNyxfPHBL1bU7mrs5SMc0zmIhj9Z6rLLN0Y/uW3rnO21H2GCLwYnNyUY99
	 NgsiM3m0R9OFMegdkZXWxuTj1HUhR0N3Btr1KJu5AVv3tEIAEbPpE71VkXZzp7Dg0dP8R
	 I5zRFiA3xxtFd3HGXe1OSVgRuF95fNm+MssGyqJg5V7D0WrjpKhgN8Gh4Wo1VPkoRyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eVOao2kSoPsHbrBTrVlhM55djOW3pr1LawZArVs2fJk=;
	b=2V4PN66vDnMIuZh1TYY7q48gYzSu7vLD0t4Eh6NYEpDK+88cd711udQGZ71u1bgCTmxz
	 UaEXcSK/xc9Rk0fH13cj6yYv9ajQpDVHgj2MWTF9m0JlM2hS3VuJ8n9/bJRGcoOPOeW3m
	 P37JdyNhNYtbCb09yJyZ1DOy4pVMpZBzgkOGBA9dsJfgqLbbse13Waw1hBcL5HoTfUeg+
	 it0A6ThZfdSnalh9XmYwkvhV3aD0dqAKUzRtVKvzb8CcABXa4QKPCYJIfYExCykS+h8ty
	 rwUK9PgVrUP+SMFzDMtqg2hiYnE+g3rUDiN0d3qDsyw4unCChwyGYfOwEXwO92jgJrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CKrE2NJm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64F606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF64F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CKrE2NJm
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c1479be604so3948282e87.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795577315; cv=none;
        d=google.com; s=arc-20260327;
        b=R08BSG9n9oWZ6x5ViN4Haj/pPWK84wwz4IUDnMYqzBtm2x70U9aW6zyrQ8qaa9cSIA
         4WKdgW6mG9Db8Tta6gpUCKMLOimWRJfnGTt8QO2ENz64cs+i29DWISSykLGWr6SGRl8z
         ofHYqNIhBCsRMa5aB+GwX3bq5LDreTEvRzK0lf7bxs/Yod8aB6knNxmR8XG5NCDYyDaU
         eHkT36U5K+EirJX4lW7t5m2Zfll/zOW+cLhdqRcCrc4mT2zuzUP5u3AXSvcEbDmhbbsN
         3/ovaKjKIxGE8quDuG8g1npjDSyQhCAhghoVnKLA/bXXmQ7VZaKluZ0a9s7HXb6RExaU
         JNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVOao2kSoPsHbrBTrVlhM55djOW3pr1LawZArVs2fJk=;
        fh=bWV0O0GnW89sosy72fwKqgzVch6LdgaiL/QLi+KjiDs=;
        b=BiasPPOWIxEp1a9VrIVzfjQ3euiFwou6yqglHilO14s7LkM/F6D728dqG+WNFHx7dY
         J3fyyvT9MKSr3gDNj8ISEyQQY4BJDi49xN81cJJm1k6N+7TV8xKx5sYplyqX+z+k1hu9
         GB4i2tMDlj8WzQKJZTinf2rGPOkKE8gr0vr5Fg4z3BEz94g2uEzG7SC0URHZlcpla2jy
         c2qr+JiUxacyDbht0uaTg38Iu/B1KNQan3x22jDJSEFKcEJzdGVe8C3F0Xeaje15oiO5
         ooPkhaLYBeAUtguFrKvcwweutIJNC1fuqbf5qOKOtndz2TSgW0cQtX8/XUH4/RhIdjhW
         zIVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577315; x=1796182115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVOao2kSoPsHbrBTrVlhM55djOW3pr1LawZArVs2fJk=;
        b=CKrE2NJmlO2x2coP0veBjV43Ou6wO02utmDWOdQSD0IkTjr3J6lG9f9RqRUMJs53A2
         hJprCmuxtWzih2y0dy4DOnGYV8UFqsLFMPI4kG2gOnaPvNpjIhM1Kl6o6+W8BXvYtw0m
         NXxJGK6jX2k4C7T9oqL6OKmnX+rwIQ++IbMcNRyOpuG5ejw0UqUyBEH2QNeB3H1LHV8S
         zTLR/1GbP2eDY+gj9cyba75/ol5+p0UJIi22lqyT7BJxORrSmtnxzcV5xE+EiFnTCJ6d
         xB/pPs80i9Wl7WMnvqO0buCYNyxR17vRt23KyQR/Sz6+CoSICQSpitl2qJfc17VRxke6
         L68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577315; x=1796182115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVOao2kSoPsHbrBTrVlhM55djOW3pr1LawZArVs2fJk=;
        b=z0O6xKQ4f3NbiQRhszzuh+/SE7hQv+As+zaUbaQt5cw8f62oR38FcJvoDMJUJNhB+d
         m//MVVPMlTdYyzLUXtCuus5XbXZbhrX6wqteGmAPopVKQpIRgPT8xs4bROuidBi7p3kU
         oyxrKU84snN058Tmg/D0MEhUcHV8r/cXGyG/Rh+xoUevGPNRGrgB3ULrhwy+yjcQdOfC
         XtqtZEvzC1+DrOFzRiaBOx5p4D7m8TyqannG284ilh4bODSV3ynOo3dcp22XldLcIsyx
         18ysj7JofB1f+8O1J8tHZI5kw7S7gdijRuFAF4uGkSNuBIN6w9OBVXrAUh4K1Dy/dY+/
         Jkmw==
X-Forwarded-Encrypted: i=1; AL+hErFA9Vu+gsNTLsISJfQFPtqXZtx9TR9bgEeP/TaqyPHaqyZUJPeI2E3yY11RUH6EJ4zjR78djQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z85jEv9LGMubk4d/gI6kbRRSZSO+P5UjQb5yaldXzJ4Z4ZmtwEW
	5jSqrSQo57nMEs00WGZHvfuEpvaGUWmY4HIpdFhptvo1uMCP1ZdRt6NsnDtAD9vqgKRzGmWjDFG
	NdV2Z9MNNU4Q9e44A+My0If2w/eokgfcjPPCniYs=
X-Gm-Gg: AZFdTZdpGVu7F5Y2ceAg4t6BehjxkkY8+oqB968XHjbPzeOg5gZhgr2nDATzRgaow1+
	yZK+i+fbBf77oSwmQl6Hetvnw+pdLpAByDmWHEMjleJxCVuZttC2PMd+Z48Swlg104qwFlRZhiG
	+XMmn4wHigdPz4oqoX98mtpC9o7v5BJfVApNwYFUNU+2Rku6RssvmZrk0KW7czryvOjoYVZl/Ap
	cY3Ynh986oZPAFuVuNafk5GQTbn6bCsCEbk588gxZ+Ouw4U0n+1bYTxmWBYGLQ+rlSzGKZkXEBy
	uduYE8Ei+7fVR7m0Jk3jrx7LRxim7Qn19N6lfQx4rk/dG+Wj485026E5/EeLcM66XVsvP6smEeN
	DxOHGQTytwn+55CgcyTWL95gGBD2IfplgcfJPauQ=
X-Received: by 2002:a05:6512:8346:b0:5bf:f7e7:85eb with SMTP id
 2adb3069b0e04-5c1bc7fea99mr2659579e87.21.1795577314677; Tue, 24 Nov 2026
 19:28:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-u-serial-console-dequeue-v2-0-820f355827e6@gmail.com>
 <20261122-u-serial-console-dequeue-v2-1-820f355827e6@gmail.com> <awP_a5IqlYHPvx-G@qmqm.qmqm.pl>
In-Reply-To: <awP_a5IqlYHPvx-G@qmqm.qmqm.pl>
From: Fabricio Akio <fabricioakio@gmail.com>
Date: Wed, 25 Nov 2026 00:27:56 -0300
X-Gm-Features: Aa3M54q3-u3iR8PfW5c1rCzULwKjC42ht9kSn9FSOQhdbTrBvX5w3OxzVNEj4Ks
Message-ID: <CANxzQdFNudKjwSO0cA3Leizo9PmZgDJkZtEfEnBWL7H+xYwCLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: gadget: u_serial: Publish the console only
 under port_lock
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neill Kapron <nkapron@google.com>, 
	Krystian Kaniewski <krystianmkaniewski@gmail.com>, Brian Ellis <brianellis@gotenna.com>, 
	Ai Chao <aichao@kylinos.cn>, Prashanth K <prashanth.k@oss.qualcomm.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 09:55:07AM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> Note that there is `if (port->console) return` just at the start of this
> function. If there is indeed a race here, that should be taken into
> account.

gserial_set_console() and gserial_free_line() hold ports[port_num].lock
across gs_console_init() and gs_console_exit(). The initial call from
gserial_alloc_line() during configfs function creation runs before the
function's console attribute is exposed. That makes the early check safe.

The race is later in gs_console_init(). After it sets port->console
and before it takes port_lock, gserial_connect() can take port_lock,
set port->port_usb and attach a request to the console. Init then
takes port_lock, sees port->port_usb set and attaches a second
request, overwriting the first. Moving the assignment under port_lock
closes that window.

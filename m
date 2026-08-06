Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A352DECD3
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021731; cv=none; b=OH0PXKkL5+xXlmgXJjH29fv+9hiDshtEH1Vo/hXAnY58KFjXCXghliB9890jyM3/3v9BMhdk8bJfq6G6ddTegbEZSlexdeK/M3OkfduXweXmvTdRKNycY9JDVKNm93QwtPkdA3Z0SJwV63riO7YXfW0h8KT2zzv7VIDsg9pj4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021731; c=relaxed/simple;
	bh=OKBgE1zco51TS+bnUGKw3JCA3xNVFMZtwavXxzMaGl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHVUKTw0ggHCX3SPLx8H3A/KO7PYu1MgyYnGN/tmJhhoGXrqB+G6KS1Zx9Oc2ylwMbQmRGbbnaxRAutg53DNSlHn/y/zg0w2zUZa1jf/sL6NTY90HbYJFv56YN0hDyvyrCI5S2HSEsvyuEemi4uZYBWiAwV3mx48dPtZzm5H3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ked/cAju; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4lpL5Xz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ked/cAju";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4lpL5Xz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786021728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Loby3/i2NagUTDWGI/ZUcbVav8fDPEU/GK5BwQZ1+vs=;
	b=Ked/cAjulm9C1LjcRB1UIWrG4lLhCbZf18l9XUdbxW1WkUIL9Uq5WUmOLyicWndokDpC1/
	aA0u/3a+Rv9r2idqEh06gLtpOapLbS1dXuIyUtSOmijx44370jDBMrzY9SGlpemScP1B7y
	oGMda8qgGb1+PGsEMUvQkrJMTqTRg/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-Ov17lV3OM3KZqm1EJoB3eg-1; Thu, 06 Aug 2026 09:08:25 -0400
X-MC-Unique: Ov17lV3OM3KZqm1EJoB3eg-1
X-Mimecast-MFC-AGG-ID: Ov17lV3OM3KZqm1EJoB3eg_1786021704
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6db77430so1087326f8f.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786021704; x=1786626504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Loby3/i2NagUTDWGI/ZUcbVav8fDPEU/GK5BwQZ1+vs=;
        b=E4lpL5Xzu8YIsdVRAQHN/gGqRTZZbhJZp4rDRzoeEzUgCoRNm+DsxYL8SA50uucKJg
         /7GpxX/UKu0TcOc1pLSRsLHD6OEuk4psPKx14kRE/425G+XfcoZJQTwqDmiSwEnAtpWF
         NPbt86QQrePGD+BjqW2zcF3zwDM/hxyBjP4ctNwRHo2d9bxDN5YHXR//1XitT3RZTf17
         Z9B/jkva6ri8senk7xgljhPPEkB9UV+LAY+h1fksjQ2KFIvsQgMiBzZDnz9KebDeBy08
         N9GFfFtB5q4O0ZfelQ7FrIFWuZOrO8N5Z+67eKC+m6X7ZJuILSvHfxJ/CGyABnM5/Vi5
         9V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021704; x=1786626504;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Loby3/i2NagUTDWGI/ZUcbVav8fDPEU/GK5BwQZ1+vs=;
        b=mBp2cyDpmznrml9RaKcZPOt5aHXkR0I8NkiRiiVDAQzPir5hYYYMJv6nQgl86o5SOl
         l2NIVpvY10VqTsjbn0xff9duiwezoz36Tef0ycB0/Tgy0tzRJYXPkxbnyGA7RCQc89B5
         gmkZaau3BlfxOszOUZC/wWmvTZ9vB9/mrKaED47qFUtXZM2tkj7Wc/GgDP2YaJSnxnz0
         uS1uI/ck7Tz8sBxOHF9Mw3rmBzyzPmsmpovwI+//ZP19RBIoAAINRvQdfA3n9rxR2PwE
         MurMDMli4mpq9R7NE3asGs7yCTIKSb12Vg4BxC5q1A5PLdl1R5OqBorAq9ks6u+JNIf/
         FbJA==
X-Forwarded-Encrypted: i=1; AHgh+RpM6gHmDeZp/D/nq/XYvh3qTAAhvruRE5tW9T5lt02ZtEKAyjJOjUO2YgEoWt89rgnqSHReuWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvf6GYYOt5x+0v70o7DrxBXuVqIdsGlWM3C0bZ2PoiRpWfPS1
	6qwo6NxLExf1QEZx2pcioyy6VT1SH9Lq238R5qvt5GB2H0mR0Eq+p4eroUuOFk+AQTUMYDKbKtb
	VHb3zBbiX7uGaB3YDu9u2/YyCPX/ah10SSd6EDoXse3Wlj5eXJOjDfAPjUQ==
X-Gm-Gg: AR+sD10TDtG3ckoWsUoHUVXmz2pHfwvLwv5Tmw57qiliDGfiFqlSiFdK+G5pBPBdf2l
	ZJb7dLQtPPUh5n7QXnue3ey0USutiHgOFSUMScE3KPUHekmy1Yq/XrNHBarAv3cboVzwf41LL+Z
	Ey91shEeiEx6M/EHXKODyNcschpNCmk9MECeY2kFrXCEK39iY/n7bUDmcGSHVbkXAqOsqdE+LZr
	v4zEqYzOarMlTznRJu2gMjdN6il3IO0BgZ5g2NZc/r9nrzK+Dwz1GLaPQPAhS8zUKc5OrCetkel
	iQR+WllQNilIYqkq0U0bcwjrbP1gPTIs03OGuYjjaZ/o+JEmZ+OSCpoFdW5NYG5WXU7gBRmuKPL
	gxT7B5B0Zy3vSCbkzX672ENO5JJ/vAcQ9oe99dAZoUxdnENWzGVMZCGCXBA+HB+d3ZPsqEpG9Cf
	Q=
X-Received: by 2002:a05:6000:604:b0:47f:7526:598 with SMTP id ffacd0b85a97d-47fec5037eamr22742481f8f.12.1786021703986;
        Thu, 06 Aug 2026 06:08:23 -0700 (PDT)
X-Received: by 2002:a05:6000:604:b0:47f:7526:598 with SMTP id ffacd0b85a97d-47fec5037eamr22742391f8f.12.1786021703523;
        Thu, 06 Aug 2026 06:08:23 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b183b2sm6802661f8f.24.2026.08.06.06.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 06:08:22 -0700 (PDT)
Message-ID: <7dac738b-3ea2-430e-9513-2702c426a057@redhat.com>
Date: Thu, 6 Aug 2026 15:08:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] macvlan: require lower-netns admin for shared port
 settings
To: Doruk Tan Ozturk <doruk@0sec.ai>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: xmei5@asu.edu, thomas.karlsson@paneda.se, herbert@gondor.apana.org.au,
 daniel@iogearbox.net, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260802130137.98105-1-doruk@0sec.ai>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260802130137.98105-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 3:01 PM, Doruk Tan Ozturk wrote:
> struct macvlan_port is per lower device and is shared by every macvlan
> upper on it, including uppers that live in other network namespaces.
> Two of its fields are settable over rtnetlink by any upper on the port:
> port->bc_cutoff, written by IFLA_MACVLAN_BC_CUTOFF, and
> port->bc_queue_len_used, recomputed from IFLA_MACVLAN_BC_QUEUE_LEN.
> (port->flags and port->perm_addr are also rtnetlink-settable, but only
> in passthru mode, which requires port->count == 0 and so cannot be
> reached from a second upper.)
> 
> rtnetlink checks CAP_NET_ADMIN against the network namespace the
> configured device lives in and nothing else, so once a macvlan has been
> moved into a child network namespace, an administrator of that namespace
> alone reaches macvlan_changelink(), which applies both attributes
> without considering who owns the lower device.
> 
> The create path has the same gap. macvlan_common_newlink() resolves a
> lower device that is itself a macvlan to the real lower device:
> 
> 	if (netif_is_macvlan(lowerdev))
> 		lowerdev = macvlan_dev_real_dev(lowerdev);
> 
> That real device may sit in a network namespace that was never
> capability-checked. The new upper then joins its macvlan_port and runs
> update_port_bc_queue_len() on it, and, when IFLA_MACVLAN_BC_CUTOFF is
> present, update_port_bc_cutoff().
> 
> port->bc_cutoff is not a local tuning knob. update_port_bc_cutoff()
> recomputes port->bc_filter, which macvlan_handle_frame() tests to decide
> whether a multicast frame is deferred to the port broadcast work queue
> or flooded inline from the RX softirq, and a negative cutoff clears
> bc_filter outright. A namespace that administers none of the other
> uppers can therefore change how all of them receive multicast.
> 
> Reproduced on 6.8 with a dummy lower device and two macvlan uppers, one
> left in the initial namespace and one moved into a child user and
> network namespace. From the child, both a changelink and a nested
> newlink carrying IFLA_MACVLAN_BC_CUTOFF were accepted, and the value
> read back on the initial-namespace sibling followed them, changing from
> 1 to -7 and then to -42.
> 
> Require CAP_NET_ADMIN in the lower device network namespace before
> applying a shared port setting or creating a macvlan on a flattened
> lower device. rtnl_dev_link_net_capable() short-circuits when the lower
> device shares the macvlan network namespace, so an ordinary
> single-namespace configuration is unaffected, and per-upper settings
> such as mode and flags stay available to an administrator of the
> macvlan's own namespace. This is the model ipvlan has used since
> commit 7cc9f7003a96 ("ipvlan: disallow userns cap_net_admin to change
> global mode/flags").
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> The newlink gate is unconditional rather than keyed on a BC attribute
> being present, because joining another namespace's macvlan_port is
> itself a mutation of shared state; ipvlan gates ipvlan_link_new() the
> same way.
> 
> IFLA_MACVLAN_BC_QUEUE_LEN is gated here as well as by any magnitude
> check, because the two address different things: a magnitude check
> bounds how large a value any caller may request, while this bounds who
> may write the shared port at all. update_port_bc_queue_len() takes the
> maximum across uppers, so a cross-namespace lowering has no security
> effect and this over-rejects it; that is accepted in exchange for one
> rule covering every writer of the shared struct.
> 
> Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
> Fixes: 954d1fa1ac93 ("macvlan: Add netlink attribute for broadcast cutoff")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
I think that following ipvlan example is correct, but the behavior
change may break existing user; we don't want bad regression this late.
I think this is more suitable for net-next, with no fixes tag.

/P


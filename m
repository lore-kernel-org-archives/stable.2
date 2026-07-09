Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCC38D401
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560279; cv=none; b=oVcpxeSpRGwQk2bDH4VzBPCCPFU/NVtvo4fjyD9rLv639FB7zo89Q3SMLHjRYCDo3DVQyijA2FwsPwaQk2RvLLSIUKuRA+9XkcEsxnEAimQ/sMESSbCvGtg8khwAMDnXkcTjoXrAHlbcMm17gi6N1j5T8IQCdtYa06b72++37Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560279; c=relaxed/simple;
	bh=l7eHw/raYhzCKyoQvZO5b5gtYbr1anwl7xluE4HEstQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=d3k5eLCuHTrzv+zx0uW7XBn0Q22CInEkL0FdQqwx/+G1YCQLG8YlRS7Yu7Mbq+rUkIqAgbU3vsQQQh8n/XSphyzqHYc7gcq2nQ8PmnNWkGb0SRwva8C9p5+rirs7ezRbvB62A7XaJjH/tY1tj3X9CbQUBs1pLsZohbrfHzhs2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QggIFKPx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QggIFKPx"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80bb578d58bso13987677b3.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783560277; x=1784165077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l7eHw/raYhzCKyoQvZO5b5gtYbr1anwl7xluE4HEstQ=;
        b=QggIFKPxJXqU+hgCDM8CbHi6qty1kxvO+hDKATtwDl0ALTj0vuyF3wyaS2piKuxSz3
         KpkBHSIPtmpA8MGK7+G/wu+KjXcey9BeSNJ+zixcDTNeoK9CKNFZFCCtkw010krVemtP
         ZzLjyUeqBTbOIQPQlmE7e8/rxp54IPeEi1dFJro9oyoARm2QoMAezUrNeacurygnd0nw
         KDP21kf/GEW+w0WCS+XDi8mwqAGNNAbTIqNzGhMEC8lr53bFwwaLGWYGCAHfaZx6SBng
         O25F6CjKlI+y/V5Deic0wMCn1/l7AvaROyw5aCa9uXZTPLRk/ZH/TE4c/Wauz35vRcHQ
         j7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783560277; x=1784165077;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7eHw/raYhzCKyoQvZO5b5gtYbr1anwl7xluE4HEstQ=;
        b=L+ragXtqfB0SU4NzLylDVdCZylFXoCRWJ+wLyZad0/caEae67PEEgEtvnsoRLAqWFZ
         WtCsZvFw/+YjdhGBxEDO93jd609MCqRqhrW57mIjMPsOnSUcAL/pgZUmn1MQVBzI3dyu
         bukkehlXsUophMpUYCsU6A/ScNF4jNT2hvsrPWNc0WMQ8r3WO90woeIROBbpjBl8DoG/
         O4MO4pjnFgtwAF5fbao+94G3HKGCBc7xN1mnl87hqMREIHIYhO+qC/enAA4wSZnkCde2
         JxvzmGdo7r0OqsZU9cKJkqyOGpqe07rjwPnTpmCZLGO/YaXczDPV2wjZ7ARyuOfQAlzJ
         I3LA==
X-Forwarded-Encrypted: i=1; AHgh+RqlcxP1gIkizdCCSTAF+eOFIMQONQj5OAw6qr3n3mgcjG6gOyxuPbnPhVF1LCzxAM9eJ5ZTCIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bBr86kkAr1Pj97jSf1NjLOVduOKvnrusgVrUiqeN7dpjdm9x
	m4Q+Q8BFUZKiwuj/syHvFLbYaWxIKDcY6BhDNj9wQlHVnsrv6e4wC0Vz
X-Gm-Gg: AfdE7cm1uS8wqijEZbQPrldmLmRp9p/BoZbqjXav17XOiavAT1bVNzML6cgm7vnXTu8
	QAw53tnBPeTYF+kDh0iCNHItnK8OU+wOWmcNm3VA6eANWwrYJkLwMxb6hExU6MP4QnTeWNrqaYk
	3Tkrz3rZPKYm87NUgAbhR9RRrlnbbRBWF/yZwrtgk5nSpiX2bW1hYtW2woJJj9JT+C1Og5K3eIp
	S7lW3DDjHwsEhZVUZQjyrVLPdPshH11Q+aoMRnJvP06pIGey0hZvimpPDFzS8cGUdGu4oc8XA8r
	aozAgAhURDz9qRY5v+n6GUpNC+yhA3V/8FNl7ThfSjIkkfeU+2MbVB4ho1D3f+5PDCzCNxdvJ0p
	R+mGh/hwFqptA4kq6sjFqwRziMbLNGv5gMcUOEg1vT1WK5KtsBWrK4/RtLHc+/ezQXxT2eTFY/I
	M6T+eMLzauCeogNh3n5rWg3tk5ec9aYvgLi0x7DiGgKJsgc7KOe7Prz6JRL8hQe9ErSA==
X-Received: by 2002:a05:690c:12:b0:81d:4f4b:94be with SMTP id 00721157ae682-81dbd41c1a7mr37863157b3.32.1783560276655;
        Wed, 08 Jul 2026 18:24:36 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be99124sm6315537b3.4.2026.07.08.18.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:24:36 -0700 (PDT)
Date: Wed, 08 Jul 2026 21:24:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "dsahern@kernel.org" <dsahern@kernel.org>, 
 "imv4bel@gmail.com" <imv4bel@gmail.com>, 
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "alice@isovalent.com" <alice@isovalent.com>, 
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, 
 "eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, 
 "nbd@nbd.name" <nbd@nbd.name>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 "willemb@google.com" <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "sd@queasysnail.net" <sd@queasysnail.net>
Cc: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>, 
 =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Message-ID: <willemdebruijn.kernel.31a5346f5d77e@gmail.com>
In-Reply-To: <2d71af40897d73dbd9e243ce5e25bbd3f99acc5d.camel@mediatek.com>
References: <20260707021425.483-1-shiming.cheng@mediatek.com>
 <willemdebruijn.kernel.39a3b0237ed2@gmail.com>
 <2d71af40897d73dbd9e243ce5e25bbd3f99acc5d.camel@mediatek.com>
Subject: Re: [PATCH v6] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shiming Cheng (=E6=88=90=E8=AF=97=E6=98=8E) wrote:
> On Tue, 2026-07-07 at 11:16 -0400, Willem de Bruijn wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > =

> > =

> > Shiming Cheng wrote:
> > > The skb_gro_receive_list() function is missing a critical safety
> > > check
> > > that exists in the skb_gro_receive() implementation. Specifically,
> > > it
> > > does not validate NAPI_GRO_CB(skb)->flush before allowing packet
> > > aggregation, as of commit 0ab03f353d36 ("net-gro: Fix GRO flush
> > > when receiving a GSO packet.").
> > =

> > It does not check .. as of commit .. ?
> > =

> > No, skb_gro_receive checkos NAP_GRO_CB(skb)->flush as of that commit.=

> > =

> =

> Is this wording okay?
> =

> Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
> packet.") added a flush check to skb_gro_receive(), but
> skb_gro_receive_list() lacks the same validation.
> =

> As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
> re-aggregated.

That sounds good to me, thanks. =


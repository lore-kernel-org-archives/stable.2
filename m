Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE62E7378
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816499; cv=none; b=J00Ujx33u5S7rCz2ju/i0kDzyX8fKUiSFCNSuG3sL+YkxgZmAO70A2QVIDGmggV+Pjg1YtohdZBemLk+SA5CDKwN3fT3cuTUyyv5oCHgYwfO22iS8AgKZS5V8xm0XZo2kjGosRKnFyJpXhvIrspMAuV+irgeLye1kMF0V0209M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816499; c=relaxed/simple;
	bh=cINaHydl09cxBcvFqTlYGQ6MHKu1jghguZ6j16+ZxYc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kBx72B80CMqRC9G0kffZ7bowPZKUvJciNMpTy+uAOdhIHa5Id4nLTkBS+EaNTSvgjiVXPnYH59c6kzllcZ1E63EjIfAVjYaIs9Y7He0MNoTulSUQoD1nHqrn6g3x/30s1bg0IU6jpRaAw5KqdM/9KWhkj95shJKv9Fs81EnhJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+a+7KSQ; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+a+7KSQ"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8ab4c9f876bso19530607b3.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790816494; x=1791421294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lnMNm9948egObF1IuNHPSJpwOljnWRz/GhZI4bv+aoM=;
        b=i+a+7KSQfM0/AbTmT2zV5M93ONDfW7/4Hfi3ip39Z1qmW2PsgBvusUQxKzDDbXW8kB
         Ip2DYTfbgu8eFHkXaj3xtYFySmZWngF7JgS1X/ft24WmJKq6HyhUhatnfire1YrwKlq0
         uWKQynqc2gixBYwl5jTRFvaBQE1njTfN+fJ6z/zigCBD9gqTYkjmsr8QWKKbnuXmdM3u
         VeIOBhY3lpFXYT9n2fDRF5qNmEIaP829R+jW0Hg+Ztub9datta7z4bFgj2wMh+EPe/XS
         5CxealTmep0uQfAewQkP+mIi1Z/ADEThPWhT18g4RIjWURfiqCWwOnuPffUs9Z/1soSw
         hLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816494; x=1791421294;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lnMNm9948egObF1IuNHPSJpwOljnWRz/GhZI4bv+aoM=;
        b=Kzx+1PXZbzyE69UR/iDrudCNNySNtEn7qvEVWaz3U8Kk+IcvFh0sJrB8DP9MAHl30e
         wZwm0KQcXfMyzk5xk/8a9mfGEnTAQX5i3IjoAfA4NxSUop88afVzfC/8xrA3w+y7J4q2
         OCOyOAk4mDMbtiOJfBgMJTawKamGcwwZ/kxFDETjDTuCwCr2JdBjIVI5/iumwHLwZDbG
         szz0BpIB9ZZD7Tisqgk9znocnT0lWCahThijmYjrHXDBvhUg83mrzUSTMwpsJPBcNm+k
         xAZg8uUbZuGwBmfCv9bISY1BHliOirP25vXNP6Xa29KL590kLSeC0bQ8iNLYLFUi2vf2
         GkUQ==
X-Forwarded-Encrypted: i=1; AKwUvBznP4DjQ/HwxK/DxRs9CFoPgnFdlOP0v95+aKl2FXZpXxzqgOI3Fqhxugo9PpABsWUXowKn9Ew=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg6QQrG8JR7+xr83zByE2d2Hl4SEMXJAei+MiW4unSmve1Kj2F
	GVNxII882wqg3MPZiAvIW5gCA7z9aia4yoI/dHghw574qkjUYEdU7TRq
X-Gm-Gg: AYBFou0SbeJ2aRTsoCa4SQm6aOAWMQRbGLhxFjSIyokJ7Xk2RzOnwiwiA2fnjbD2o/t
	6twUQ2jXkxmsIStBzkU+eVlzDeadvWzETOh7mbUO9cu99XUrJjT7eY2oL8fvmVvyiB+Y9DdXk2C
	EEKcnoImrfdxctQLRCz7m9IkgJ8kLAyuyaqXqcSBDCePSwwo8rOdGkfP5n18/zvOqmCMIkZQn1s
	9UGY1EsfRJMxo5rb+RJ3TjVIUCHaGAt3QL2TZ/tlujq5VoA5gMZ5mwb6F+n2ovu1W8VVj0HIq9N
	mu/AdFXD5PcOkcrxhum8BGDWW4KKWJRKBrr/dS2Yq4vImVOp4KAqfp+Dbn5zi7YJLFpjfF9BSme
	7bXQkrAvX/2xcZmeH1PDvjj8JBcsqypARd1TtSld3JjiNBfyJFU82ql4DxBp/zNx2J7od0SKvmC
	jz3iTwwoFRLZCCNFOb4aw2M5Rldau0LU3tfR2PRBtJ3lNm3gLw+m3A2fhKgYnMWR6SKR7aYtUQI
	MKsa/2v9BivYEDq4u/r8328ZbpPjF+bQ9uSPXILZI0T8n1YXFZXbLvbtZphM5E=
X-Received: by 2002:a05:690c:5703:b0:8ab:422f:a89e with SMTP id 00721157ae682-8ac93fea07amr12918507b3.53.1790816493908;
        Wed, 30 Sep 2026 18:01:33 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdad9eaafsm5062287b3.46.2026.09.30.18.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 18:01:33 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:01:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 quchaosheng000406@163.com
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 mkl@pengutronix.de, 
 socketcan@hartkopp.net, 
 stable@vger.kernel.org, 
 benquike@gmail.com
Message-ID: <willemdebruijn.kernel.34fd899c50ed8@gmail.com>
In-Reply-To: <179081112900.434549.3927636774761151103@kernel.org>
References: <20260928113108.2127215-1-quchaosheng000406@163.com>
 <179081112900.434549.3927636774761151103@kernel.org>
Subject: Re: [PATCH v3 net] net/packet: guard the ll header push in
 packet_rcv_spkt()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 0 (2) =C2=B7 Medium: 1 =C2=B7 Low: 0
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [Medium] The history and Fixes attribution in the commit message are
>   inaccurate.
> =

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the same CAN=

>   RX skb with mac_header =3D=3D 0xFFFF (left that way by init_can_skb()=
=E2=80=A6
> - [High] This problem wasn't introduced by this patch, but the
>   SOCK_PACKET receive path this patch touches leaks stale skb->cb bytes=
=E2=80=A6
> =


> [Severity: High]
> This is a pre-existing issue, but further down, packet_rcv_spkt() build=
s
> the sockaddr_pkt in place in skb->cb:
> =

>     spkt->spkt_family =3D dev->type;
>     strscpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
>     spkt->spkt_protocol =3D skb->protocol;
> =

> strscpy() writes strlen(name) + 1 bytes and doesn't pad, and nothing cl=
ears
> the rest of spkt_device. packet_recvmsg() then copies the full
> sizeof(struct sockaddr_pkt) to userspace:
> =

>     memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
> =

> Can this leak stale skb->cb bytes to userspace?

This is being addressed in a separate fix that is in the review process:

https://lore.kernel.org/netdev/20260919215237.3470987-1-benquike@gmail.co=
m/
 =




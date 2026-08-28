Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C943DAADD
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929062; cv=pass; b=TBsTpk+Qn25w2GJ4K+2K67gplPF6D8N7F5Ta1nHzls1Qp08V5dCxQSqlUnAbIVc+BDDvqkkjggeHDEya4tKRCA2aItQSBcEXbPvm8uaPs8ugM4Mr14pGj30wfmhFs30Dc8CtJOn34h+h6yRroDXuAHKsNao+V58VzduHNAJ35mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929062; c=relaxed/simple;
	bh=kAyeEhSjNccNcnTFgFj7n9DSA0wrFShWyms0f0y15AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIzYbFWXW/jnYA4DSV4NdGTOa6hNEl2hNxPchSO3QHGkm8TMR771T49BFYD/tN5ySKReF7YTKcpViUjh+nEFmDGeboRmb+2Zng6IGwfmuOvj8IuNiBvBHYrdhKdS8jPqhGxdFTi91wOv5KB0FEFojUIdLb9iY0SEgjjQ7AqnD5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSg/N1iS; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSg/N1iS"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52d5bfa4bafso11979621cf.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787929059; cv=none;
        d=google.com; s=arc-20260327;
        b=q/R7Y6YsMbYaf0i5bt3022nB6w2K3IGD9fF0ntescSJcPpVSvLvG/aikaCeHYCwhDc
         aYHLTwySfPewg1k/q/jLZdM7IE62H/CL0qO7Oh6WrMrv82+uFj2IOHZmo77HFTwoQihD
         ViijxcmK48dYuaNhvT8HIhu62nBueqTgC9UjJL3in1tITeEqTVHvRl678iGZ/y8IZqzc
         jqKqekLZn9dpeMxhdHWhY//W0k3YK/0qhlK2EmIOg1YtLJYE83V40kWmwcf7HyLSL7//
         QOT+ZjuZQfcv+NHEqwYwxDapmnjaZDVzWVPg6cAyizTMWC7udiXoQgjssvX8dkh3vKhJ
         kEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kAyeEhSjNccNcnTFgFj7n9DSA0wrFShWyms0f0y15AY=;
        fh=sB0i806TsHvZFl01C6glDP5p3VWda0wOWb0RWNr4qsw=;
        b=UntGWUbbF7D9fKppt49h+sl3PS4ajPuIEsI2G98iUlObWS8hxyBCoWgV0mqe7Vv0u3
         WsIsju28Q3a6cQFt6QrKrteb/TSJwDiQM5GZN+FRSLKjfDpcMpnGJEONDKlty0alRSrX
         aSFVwYDGg0AjnCTTbgwdLKin3GXId6AOZ4BEm7XymASNNQ6zPH0fWLM2ndXenty+dG7e
         Z8U29KPIEipFPdFSSPCS1aTVlPoyc0FRPc8c/1TKJe9hyvqhYg9Q3rZBumiCWmX3XyKl
         zlmSiNo9PF53SFRIKxG5hhzs3fDryZ3J/cSI7Tbt4Glkk82m834QEaZBthDO3i2oKgTg
         lTjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787929059; x=1788533859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kAyeEhSjNccNcnTFgFj7n9DSA0wrFShWyms0f0y15AY=;
        b=uSg/N1iS9wRCLSsaEb5RIKeZW6B1H07+sjbyyMr7O6RyDSp6qcgD9gGPwKE8fkXcW+
         wCy2Sby5T+FoRqJZmVcZVIEl/UWrxrHG5yrCXHR3enIVXI6RIDwDKz7geaIx8LfzJ4tf
         MPU9b1K2TUG5oFg3i/aKQt67q4Mr+hNaGgruUh/dgo95iRtN7th41rv01tEewQgnAICI
         vHVfHjfD6GMeuclYPtxIsn0lBAwh4StJwePMr06+NBmJp7nwMYPR8irKqToaySbYqOOU
         +//iUnCtw87PflVAXOAJ21UI07sKgulVqLgtFe7WHhf4opRFRcL2jkD3y2027K0iwc8K
         10tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787929059; x=1788533859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAyeEhSjNccNcnTFgFj7n9DSA0wrFShWyms0f0y15AY=;
        b=Db/1HhTz69VeNsHRg/LuNDxilg0jgvYttBmcf4rErGx0KjsMejZ6lzlG68PbQT/GB/
         drYHB58L3C3NhM+rES/5cTJFbDaU6uqhs8qy92QnI4xls/4RoaYJAIjLF/BRn17er19k
         2QhHFZRcfhZBwick8KPdAotKsu0TFI/n4rHAuLRRn4xDOTkDf7brPAaNOOX3h+bJCQLR
         uvviDrvUeeEbDZdLtOLTorFel8mRY+68cbT+6QNT60BVLiMEIw7Uu87cw/aqAK/l5hrm
         LlJ88/WOYJ6wf5LqhHHXgF50p4UOJbfyy69I/7Q+8mCJNw86T8RA2eoD7WaRoyv9Fz/u
         5kPg==
X-Forwarded-Encrypted: i=1; AHgh+Rpyc7wsas+K3DuZlP4bHrdSesghTD0/pFHjlcn+A8m4AAJo64o3qDoXKnHbTwRa//HmcLb64bY=@vger.kernel.org
X-Gm-Message-State: AFuF++m7ulczpm3U7+1IM1+s54ctW5Q/CF+jI56axTDfNIEPRVEtaPwM
	qkqOVczRzYh+772pYNZTbZKEPu0g86De4o635HyXf9OSCZnm0fZBdZpzwT2QhuXze0qFcJRTLN6
	Gnp0GXjwludjhXBru2xUGmvuiVal5t3Lge4HMnODJ
X-Gm-Gg: AR+sD10Qq4TZb79BZDrAYTttyGeR48Ut8b6Pjw6DdYyM3dcNzn7nd1AWQowrdBgxQDD
	ph3NkZ1w1Sk2NT6dZMtjm23fX7BC6xknHptnazELNgfW1pkz8y6uEF+oegF2uk0uzqM1jumW5w5
	+FVaQSey9MQyOkBtYmWae6C7MwyjiRBtSVUVva3dS4Cn94IOpkv8OLH9Swk7J5USB54fVEJFiHB
	xX7/i+fUtS0eH4kI76efiKmbEqB527zxwqruENrXUxx0e1eoFnObO6F7fH/47p3Nmcw+gXEThkb
	T8WMZVlpBBKqViDmhr/5WtkvFjbE3c4aITWoE/PktuWhp86PH6FgDvUXu2fNZQ0f65y8mg+c+tj
	ek2zIBzlYl29k/8eszlerKfbtnV3fpXMXvvMnNBiMKBe2iB5CGV2PXtKw/3d0+7R8rtCqKA==
X-Received: by 2002:a05:622a:58c:b0:52f:b36e:4075 with SMTP id
 d75a77b69052e-52fb93b2b20mr87332321cf.10.1787929058786; Fri, 28 Aug 2026
 07:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827230233.94878-1-joe@dama.to>
In-Reply-To: <20260827230233.94878-1-joe@dama.to>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 16:57:27 +0200
X-Gm-Features: AcwNN1VizoTZVZB2sDoB94siA40iAhF_z9QOM3aJZ-MfaTs6002ngL1t8IbRvxk
Message-ID: <CANn89iJTkVw17sM=8Y80yh40vEHDe=tDWicGVsoLNdKBv9GDMQ@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Prevent queue stop with deferred completions
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 1:09=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> When the driver receives a burst of packets, it can mark a BD with the
> NO_CMPL bit to defer completions. The expectation is that the last
> packet in the ring will have this bit unset and the completion generated
> by that packet will cleanup that packet and the ones preceding it. This
> helps to reduce the number of completions fired.
>
> The suppressed completions are controlled by the driver and the number
> of packets with suppressed completions scales with the size of the ring.
> SW USO packets, on the other hand, have an upper bound on the maximum
> number of BDs which can be consumed which does not scale with the ring
> size.
>
> So, for small rings it is possible that: a burst of packets is handed to
> the driver, the driver defers completions for all of the packets because
> the number of free descriptors stays above the threshold in the driver.
> Then, a USO packet arrives, but the number of BDs available is not
> enough and the USO code exits early with NETDEV_TX_BUSY.
>
> In this case, you end up in a state where the ring is full of packets
> with their completions suppressed, which can cause the queue to stop and
> never be restarted.
>
> Assuming default CONFIG_MAX_SKB_FRAGS, this is only possible for small
> rings (<=3D 457 descriptors, below the driver default value) when
> a burst of packets fills the ring, followed by a large USO packet that
> can't fit. For larger rings, the delta between the completion
> suppression threshold and the BDs required for SW USO is large enough
> that completions will fire and this case is unreachable.
>
> This issue was pointed out by Sashiko and while it seems fairly unlikely
> given that the queue size must be small to trigger this, it is indeed
> possible.
>
> Fix this by tracking the last BD which deferred completions. If SW USO
> exits early and there is a doorbell pending, enable completions for the
> last packet in the ring with disabled completions. This ensures that a
> completion will be generated and avoids stopping the queue with no way
> to start it again.
>
> Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")
> Cc: <stable@vger.kernel.org> # v7.1+: 4e15e89faac9: net: bnxt: ring the d=
oorbell when SW USO exits early
> Signed-off-by: Joe Damato <joe@dama.to>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

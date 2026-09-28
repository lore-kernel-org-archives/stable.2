Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A03644C9;
	Mon, 28 Sep 2026 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577509; cv=none; b=pLCpBfr3ijzZNdSp7cN2bcJkKOwpK4RNUOfJxgu90kxYqjJYwDXQejRm6doM4L4LGpUBJxFQtfGLlbpyhh3iDVWevAK18LF46bMJysvlpPVDgN0NUKO4hwReSOjvdj7Ghtwa6qKn1rVJZzRqTXFaabdscCv2YFHfL3Xn7GcxQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577509; c=relaxed/simple;
	bh=oab10M41cORlOaqNO3JIQuODWkcTzu++0eN5IsOiEkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIeci7hk7W1kgWDYFVEN/CF0d8xckoE9bG36LVARm2F1BrrfHD4VNzkqzUg1NPnik8Rrqn+T+N7+xMytsWCBI9UBsVknxf1inNYeL2uRE8mN9998G+907AHn0ivinK4gqugdM98FZEUdnDpt8aU/6rsCVmbvmMB8Eq+hA66tIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rWuYiW0s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCixssuX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWuYiW0s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCixssuX"
Date: Mon, 28 Sep 2026 08:38:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790577506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oab10M41cORlOaqNO3JIQuODWkcTzu++0eN5IsOiEkw=;
	b=rWuYiW0sOfIl39b6o8KIoPDZucRz832wEPEknuqnV3ffsqIh08vTFNJRLt2D4gQaDCeCGz
	0yIoYKlHlcJbyhKsgEdVeC+grUizo2MuTD5cD32Ev/5EGiuz6M5VbgKWS97/KDDqlVzbgz
	hgxD1Vui1Q0xHxkRRHqFTGdXvLkPaeqJ+8ISLxcHfdaggvjjWVB8PR8LyKvAkuMT6r5c2P
	9HkL6UZQS7kPW0wfRhMvs4Td0xbOAtJGKUHCOTwXOQbsCE133DfA29MUcIgiLNQmM1ol0U
	y4bBsr/XO6ICPEvx+0RutCc+MtqFFpLLrLiRWM7hV9suooZ85+q0giO8Kfw7bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790577506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oab10M41cORlOaqNO3JIQuODWkcTzu++0eN5IsOiEkw=;
	b=iCixssuXrvneknmIGOp4I2w9Ciyb3RZgXNROKFtxPQW0BKzdD8MHwzcz2JNJxyEZgfoehD
	vfgEdL2tsRK9WrCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com
Subject: Re: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward
 entry
Message-ID: <20260928063824.0E3LO1vu@linutronix.de>
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-4-xiexinet@gmail.com>
 <20260923104346.ur63K3h2@linutronix.de>
 <2cf54664-c07d-471f-af6d-4b70e09626b4@gmail.com>
 <20260925082954.MYDugnDU@linutronix.de>
 <21bfa8a9-c488-49aa-b2a1-4d282fd51c42@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <21bfa8a9-c488-49aa-b2a1-4d282fd51c42@gmail.com>

On 2026-09-25 11:52:52 [+0200], Xin Xie wrote:
=E2=80=A6
> A veth pair is simply an in-kernel memory pipe. When a large TCP skb=20
> arrives at prp0-peer, veth does not trigger TSO or software segmentation,
> it simply hands over the intact skb pointer directly to prp0-int.
>=20
> Turning GRO off on prp0-int does not force prp0-peer to split it. I=20
> confirmed this with ordinary TCP traffic in a VM, with GRO off on both=20
> veth ends.

So veth. The test suite is using veth I don't remember that it was (is)
a problem there. But then there is no TCP.
Wouldn't it be also a problem if you attach veth interface to a bridge
and that large TCP skb would have to leave the bridge via a physical
port?
This does not sound like it is limited to hsr. I think it deserves a
helper similar to skb_linearize().

> Patch 3 splits that skb before PRP assigns sequence numbers and adds
> RCTs. Each resulting frame needs its own sequence number and RCT.
> Ordinary non-GSO skbs skip the segmentation path.
>=20
> In addition, if GRO disablement fails (e.g., buggy drivers or
> hardware-fixed GRO_HW that cannot be turned off via ethtool), Patch 3
> also acts as a fallback defense for these edge cases.
>=20

Sebastian

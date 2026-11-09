Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189565;
	b=rXjolh61inaHv/161nPhtIprFe718Mhf/ZJgy55juVVixAeCt20Pk6JBMNKysyl6zewo
	 ig/suoQpxmKzday6TXoBtshJLzsK0X0HUqNwT7kHibV2KmkQ/+PXcD4WeE0FNF61OMUAv
	 LgiY2FVVCNFdRDp22ECIj0Q1UeLOD1qeAtWHxepx78LQDbCk1NR4Pfax4XTLv3QEnl1Ds
	 j0qg6BHTDWVsifMMT9Luj+o6c50WjNjwDMsV7wWMTepeg/A0jFyPWHIarcCcf2U+tT/19
	 HNAfDcg6H2ARphUu/HQbU0OguX8hzDWVVQiVf3UER+RDgeaWOrFDPZ/hWia8RuJ8XYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189565;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=YcTsk5UG7w4kGYR4VHGjHB/+rgaQJ/NrIRk3u4uwtks=;
	b=Xdc4JhTsraTJH4bfcynfyaoIC165jr9f0HAxAwv1yza0NxqkMQn5EBPuhOrR7k298N8P
	 5L4KKuj2GYZYigCUXA97fdcbv98WY2JTUrVRKxPlbdAE2tdeHQid9XBWVLSqCBLf1ITGn
	 NzERmJK9dumQ4r5VlZ1g8q9ywOzlmIxc4urMbPKnPF1tseLpLfoIU+7sESGKQKB7fBaut
	 naix9BWTz/hGj4kTlN00DrKpnaxvMcGrDRR8AlROw8DmIcR5tsRZm6ifJozLfYhYxOwBx
	 K1Qt2MJktfapuh09Wo5YFpXLwVwTPk8+Ce+c+d3QccJtOf57+JwamxZvZcx2qJH3+GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=JDMl5nSr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qQfNTYl6;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C32606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C32606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=JDMl5nSr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qQfNTYl6
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3B771400053
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 20:59:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 20:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794189563; x=
	1794275963; bh=YcTsk5UG7w4kGYR4VHGjHB/+rgaQJ/NrIRk3u4uwtks=; b=J
	DMl5nSrnfEFy4lCdwnKCpoy36pp1k+X9sRbcPQm7EZf685gik6WMKff2jC4JhVHN
	Uoaeq+elM9Km8fd1QgwGS/rawESebMHoQxhAQW7LxF2yhJxwwHcAl7TF4vLICiT4
	cV9DcJPQcexew8pwzkDR7YjOnJoFg0b638LQ68Uo5S1+TV8JQzS3L+p1n8mrhEx4
	b8QFmuhBJOlhQl4Wc3mpZQ7JeIIsLgN0oxPpoE58aS0Q9Yd1fyBkyPSVo1Px4s78
	a0+3VzTvjah3CD0AG35PTRwFKlgXkUfjX2VjnMybMET79WFkv5nfoBIxrIFikWMq
	+m+nKNea90X3TS6OfMo7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794189563; x=1794275963; bh=Y
	cTsk5UG7w4kGYR4VHGjHB/+rgaQJ/NrIRk3u4uwtks=; b=qQfNTYl64nlxe1Zo3
	hrgbQawew2bk2mmCznA21ABxy2YkgIglo4Tf2H9unySHukTChdSXXEz7cFw4Xwz9
	0JPYxv+KVOBZK86E0TS/qUgZZX6UgOvhWgD8Ndln53NIjoCVd7j7s2rwm0Pesa5I
	SZyAN7EBZZj8g2pNPLIsnt41nh8vq3QPh8BeOnyGViqQTXvACNzewjYHb5V/uwX+
	nuYTMrtl+227kX9qXpH7G4rSbfWLHGEe/3zItGCEmCAUG3MNZ5gXuvWHUq5qTtZ0
	bHrSEhUlQm+Dz9svV+Ibh9hMVHnWxfd37P3MrneJVkXHNGryBdg6s73qZP11yhP8
	Z1/4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189563; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TThHtKI8lw3aCcbMTwGhsCB5sdH6yGEkORg6a7Va0pMyd6r
	aGzCXMao5zmtvtOEmf9R9S1QRzOXaLs1KyPZALXNGBZqJVU7BLulyB5xXDqjLnLv
	HSKp9kQlYqDPpYSV5K1nOoJYXot+33KXsgQHvSOINnDLWam+6JsbjzV+AP/59iSE
	aC2sRqJFpbUDLr2oYWeGbi1qa8AQu0dWmh7xQBWZdmG+s5cvoXbydaTO7KcFkSr6
	clzFfOyArbGecJpqLzGSdVcTmvVfpeNT59H1QWHYfuliGXo9YAyRUzCvVqA91keF
	ew8sNYoo+IAeQR11GJg0wyYxOyjKZh9OBfSruBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:f1pK0pDBzXffgaVtw/b6ogyRNidMO86ukh2T24cPSAY=:/DultEZ4GnPXu7giuMrEakw0t4dZlD6aiDwyE2Uh484=;
X-ME-Sender: <xms:-yjxamJqwH9IBfiS5Bw2HaU3giLpmEoVGMwUd1E46DJzAreuqOZafw>
    <xme:-yjxakL3bCvmCXePh-2DMwfEy8bJ139E330OfgBypxLa_sNN4Mkg5tmsT4byDgBjI
    EOaIO45UNtvcG9rqtIW5FxkS29sT2pi0rFrFXvzG7e83i4untO1Jyo>
X-ME-Received: <xmr:-yjxakWJq8RMu0rO1FgZpar7SU_PS2LuXZ__ulQzwOEsniHCk5ibqHAJ-0Tb-XLWlV2ybm8>
X-ME-Proxy-Cause: dmFkZTF1b+cjCy0SEnx2s8WnCdHzzK18WsFUDKOdszaPMZRd7IIANhU2Gbug44zb8NuZhm
    yzdHaQ200Gk+aH8iEPbMDS4Cjoxq7M7tTE4s/yxwTqi1rTKX/BWMV/chb8/N2lJTTa73YY
    cvAXvvgYwrgx+fuNcaeg3yFGJPqvF1ZohRfjWzqyOMYEUi3F//kTgLifpTe6NM2nUH2hrv
    uYRV2+ccOxPyaY02rWPU4/RsB6fIPzGkNOyH4+PdnIMpR+9p7pdYVv2fNo840fQl/98Dfv
    u3ZXHMR86xn+4Y76OzQ9iQ8PTK3CJlfhyFCivwhUAGJLp1VEqGoiifsgKXqjruxuVhWYMB
    uaXTxExrMOEKNfAi+E7vcka3vP3+MP2oFFLSrrWU8jXmZ804NGJ9j3wovimyfLbKkaIRav
    ICcDPY+zvcpvBivD2ugc9XzbrsINm1Hm2QkhqcbbZFzwIKpIoif8b2WCG5D20eYp1QrGA9
    m/qFx/1IcsZ8hB/lnNKiWc8lZkotPhqz6e8lzCDEwzoEbYktTgUeFXK0Z4lRS8TuEFlmYZ
    JFOC2DaBsAyFnDl+mqB/MrP+tjhoB+1MeDl1+b/3DlMONeZc5WGohcgMHSSiCPGSqNUbWx
    ZrRQsHl3vhWj/nXkzq5mlCGxKtNmwiL4yn5wDqF5nUVO7PqRvoxdtjYu1uVA
X-ME-Proxy: <xmx:-yjxami502M38O_a6Vuq0mBMSbCmn-AFeoYU9kAFrKegDVouHnZHqg>
    <xmx:-yjxav_eX7_w0wQDY1fCE38K7xOZGqQ_Yb4WTfjFflGRV2iIAnxnJg>
    <xmx:-yjxagD41vBspe1R8x7ELveS4EHjnZFpbVDB4sYtP5AbpU8fbqHuLg>
    <xmx:-yjxasJK7CkgzxslUQMW_U2ffvBneo6Qv3zQtMW-VbDSDVOclnEnIA>
    <xmx:-yjxasqJxkQktScODC9SABIWupHhOgtvEBXe2JYFAwfFU25DaQtLeOdw>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 20:59:23 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v2 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sun,  8 Nov 2026 20:58:42 -0500
Message-ID: <20261109015902.3034747-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
References: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backports of

  6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid states")
  a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to outstanding requests")

which failed to apply to the 5.15-stable tree:

  https://lore.kernel.org/stable/20261107060628-failed-5.15-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107060634-failed-5.15-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
5.15.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")

5.15.y still has AMP and A2MP, which upstream removed in e7b02296fb40
("Bluetooth: Remove BT_HS"). Patches 1 to 3 also close the same holes
in the AMP paths; the changes are described at the top of each commit
message.

Changes in v2:
- Patch 2: a2mp_discover_rsp() now pulls the payload of an unsolicited
  Discover Response before returning, so a2mp_chan_recv_cb() does not
  parse it as the next A2MP command header.
  https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org/

v1: https://lore.kernel.org/stable/20261108000542.1969015-1-oss@fourdim.xyz/

Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 include/net/bluetooth/l2cap.h |   2 +-
 net/bluetooth/a2mp.c          |  12 ++--
 net/bluetooth/a2mp.h          |   1 +
 net/bluetooth/l2cap_core.c    | 126 ++++++++++++++++++++++++++++++----
 4 files changed, 124 insertions(+), 17 deletions(-)

-- 
2.56.0


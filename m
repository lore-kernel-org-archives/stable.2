Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590021;
	b=BcaomJEbwZEUAsSk7MX/IxWZ8uWP7snZzX0z+umyb9V+IgHwUkosruVNHOfHuagNw1CR
	 WiOdu1lLJXcx0LAut+HNM3UZ8aAZWWPe37DhJJpi4tNxL0AdJUboIqhRXJ3h0D3WeSdKg
	 wtSmJWYFJ/uxZP4pmaELvAkNp8L0wclr7gFnBAuonUdqyVvAw5OPUdC/xmlsxkTI423Jl
	 8gRuoJ6o2R+e339ZGeebfIvHkHI/Ywq/se4UgdkrI1aVwCu5QUAI5Tfmm53D3QXjfyTi7
	 S6Jj4FdKA2PY9L5QVlhQEMaIqs1BdzHmwBTFseitc2FJkNSdxV/2ZeOv7BCIWRYsdYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590021;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6WRgVK68mjF6Qd2ZvGefWKuv0NF7BDejjZwjjctKnRo=;
	b=kAe9y1Zdnp8SWMH4tuvm5KFfrnPdxizGnhxtEWXikibUBb+CWzb9+cEd4RmLFhyWkl3H
	 Y9yIL14RDK+vEGwBcFOwyYpKrvL9a26Tr1GdEX6x5RBcaFeeMZSLv0KwvAFrIcLb/G590
	 8LLfFYzhEQ6Q6gsEXthdMuq8Gx4oS77RnFfzFJEcOjQONtdqV/eZ9C3jlVwQz77KrjxA5
	 KChEZMaHZSXjienUxdBVLg9sTvPX9nw1u8rimYCP19tYssTZAIxNiml2zRHMrdl+g3JuR
	 /612doJk2jPYR56OZECmx8cNQUQro297fiPEWqC/PdQSRF91VGY3h2+G1YDZA9KjFsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzIR8tLT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F03606A8AB;
	Fri, 13 Nov 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzIR8tLT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794590021;
	b=sQTp+n3NkEJsUVMaQzMFptLFsc13tLhLavzXBffo3iGjBBG3cTVeVMdmvgOF+yQMVbo4
	 RTmwQzGkAgcoSwezi63gjWB6fNdqoOb5Q2jvMa+A1jvXQvShgviVlvZn6zTvy+8v7m8y2
	 U0FZ2jmZy4Ar+sUPoy39iC6fmgH3ilGN98v3rx/RvgnpWXyc5Tz/04FdzpRp4hhOa4Mls
	 30XIdm6CBAT170e5uliDVXPlL+XZKWzq8sRngHGXaVb/7pdYgbELrszo8ael7zMIWT2CW
	 utfix0Ak0MYpkzdPNkWAaXx8WDG8W7LizfFTC+oqOYoOZ89P4TYTGf/8OAoGK6Cvx/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590021;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6WRgVK68mjF6Qd2ZvGefWKuv0NF7BDejjZwjjctKnRo=;
	b=UlwlP6s9v8v+/ueuzl1NRnm9dZGxAYaMokSP+MvHzONjw8hG1XOyB2jKXsW51efZFIIA
	 W/EgwcuETTDWfiNWunf4McbXItpeRor5ROqsL3kUZBhji/r4rgKFttKvx6BCYtWfbODgD
	 M3lKIYJj5gHY9OMYsGRQ5150GWuCCOjfbbfwnES/e0Tsfovio8hpgsvoqqfO6WJNPMckU
	 z7yVlwWm7DTV1CZs8CAhVOA5HINd3p6xTLAfEohO9TNItaGhnJc8eS4zLWU1Ahwt1DZpc
	 cC22uT6PUeK+rCBCVEFu7bJerBeagPTfs4wRVK+yThJqBPtwcaKgH61UMGME+RB0XrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 893481F000C5;
	Fri, 13 Nov 2026 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590021;
	bh=6WRgVK68mjF6Qd2ZvGefWKuv0NF7BDejjZwjjctKnRo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=UzIR8tLTNRxF/FBYQc2DWQh+s/zc4CvchyeFohRtr2NK1pd3y/VVcVLnqefsv1R47
	 u+Mp3HqNuKaQbLCqxcwam/86oFfg1cOWC2/+pVmU04cctjijcFYTWUyeW01OsDrsSr
	 XMcOYk/z6MygLQEqbipIit7OGILHSAxnQ+fJ92BcNBoj3R++II/P1ZXl7cFwsWpcbF
	 sWc1N9aCkGo0uilwxMcCX/t6hqgzNcwr2tgM5biDWDD/iaKNMNQgbeNiok7JU8/3RE
	 yQO39ALzwK/nQumIMU+9p4ZB1XIuF5Em8/yRNE+T0nkD4iIfSjETtA8lRN0eKs4il0
	 LTG+mmazJtKXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB4B4499E3;
	Fri, 13 Nov 2026 17:13:39 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 17:13:40 +0000
Subject: [PATCH net] net: stmmac: drop the rest of the frame when
 napi_build_skb() fails
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-stmmac-rx-skb-fail-v1-1-fcaae89f2d2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6W8swtJ1Fj8FfGQxK2u2ijZKIXSf
 zfqcQZmZigXYcW+m1H4LSqP3MCuOqRLyGcmOTWGM85ba9ekdRxDojKR3iINQe4Uo/d978zG7LZ
 o4bPwINNvekDmiuNf6iteOdXvDsvyAb0bGMd7AAAA
X-Change-ID: 20261113-stmmac-rx-skb-fail-bb6688204075
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794590019; l=2559;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=wIb/6vSfLxz3UqBxBdPnsbYyCrSq+sayPpXGXdTp9/o=;
 b=CPrFrxa72Bl0nYXh6+1shMuAOTknAtY7Kk/bwk/FpvzkYEqnDO+PX7KyvlVyN8YxhGuYk8haN
 2e5Vh4N8kLlDX6jm3HO7+1ZH6RHs7Qnt9vzjmlksuQhH587SjVPPyvK
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

If napi_build_skb() fails on the first buffer of a frame that spans
several descriptors, stmmac_rx() drops that buffer but goes on with the
next descriptor of the same frame as if a new frame started there. The
rest of the frame is then passed up the stack as a frame of its own. A
frame spans several descriptors when it does not fit in the RX buffers
of one descriptor.

Mark the frame as errored instead, so that its remaining descriptors are
discarded like those of a frame with a receive error. The frame is
counted once in rx_dropped and once against the NAPI budget.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Found while working on the sun8i EMAC jumbo frame series, where frames
over 2032 bytes span several descriptors. Lorenzo's pending net-next
series "net: stmmac: introduce XDP rx multi-buff support" (v10) removes
this path; this is the fix for net and stable and will conflict with it.

Tested on an Orange Pi Zero2 (dwmac-sun8i, MTU 4070), backported to
v7.3.3 with the jumbo series and a test hook that fails
napi_build_skb(): of 12726 multi-descriptor frames, the 1818 failed
ones were dropped and counted in rx_dropped, no fragment reached the
stack, and all other frames arrived intact. Without the patch the 1818
fragments were delivered as frames.

Developed with Claude (Anthropic), which wrote the fix and the commit
message. I reviewed every change.
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 25894771e9e9..d05c5bb8b4b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6029,7 +6029,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 							 buf->page);
 				buf->page = NULL;
 				rx_dropped++;
-				count++;
+				error = 1;
 				goto drain_data;
 			}
 
@@ -6065,7 +6065,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (likely(status & rx_not_ls))
 			goto read_again;
 		if (!skb)
-			continue;
+			goto next;
 
 		/* Got entire packet into SKB. Finish it. */
 

---
base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
change-id: 20261113-stmmac-rx-skb-fail-bb6688204075

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>



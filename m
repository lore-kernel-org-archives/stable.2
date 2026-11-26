Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674977;
	b=s0kAG8XERpR6P4vRsLH4eYg0qYbtYAXkaiNGkRhOz6Rk2enI7yd1cFsmsQ6x5E6w6q9K
	 1QDSKgABp8je1Sep3hLB3FsvTGYvdOzmwfS0otiITjAEJ7dS0/I0Q6Btcm7eW6IHx51cw
	 UtgToDVbs4ddFi7IJfmWMQmCagqPK04fDozeQn7RDpXEfZBRlzphYQMjJ2lS1gwio3okc
	 S9IMomzZ+zTAyZKrvchnkyhHPqG+HD81xJrqZXRcjxwG7Ug+Se3Fnl6r54NlpC6AMs5W5
	 WBeZL6hQTb8BTVIN9AKTGrZgRnxs3ygR4GU7mZp1p2hBi1fxgbMh6JDci1GsvPW15zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674977;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=R/FSE/9VhVyeTS0bvcwaj6O93PURdcX3MPrsTx44saM=;
	b=MFI5fVY2EM1sol/BSbTmiBV5ruCAmEq7JMyh9w8S9kbIZ3T/6sku6xcyi4OVpMu/gPWJ
	 GSEj3NJI0cTjDdbm6TVXGhCdIXIALnKQjnNoD9cUnOHphgpxTZE46RwNEAk/DeQAynBTp
	 JLF2FXUJfHLjUNM74hHQ+xR8WvGUwvF3hgIY+omxECHyrQ53TNXNd6x/J7H8Bdzlydd3F
	 +MnjrKBx8xSKCrOdk93GW/f+sleT84XaCW9VlP07XjIFe0lQo8QQOiGk4BoOsaLaw0Ejg
	 pXzS5JbSr1ZBprCxtNzkvWSrjdOcXPO3WjNwovI3dVhu79mWAp+dshwi4Cpb+PcMU+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISvH7kGH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB476606A331;
	Thu, 26 Nov 2026 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISvH7kGH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674977;
	b=aYzxwcs9kLHajT4tUie2JzuR6jBr63FwcwcmiOI9av4HGlIDjUKgV93B04AEl4OmItUU
	 lcxyWPh8o3xbclcst5BPZdzkN3THgvfDyR93lirgDbweXqr9mW4nsP39C55unktLT4fnY
	 X23u5EdqcxRkTlW3p8e6Wvs8+Wvr3v8rxFHh+oeC8HwcIkQyFe0nFOxmFq6z2JOlBbNy1
	 l7ne1WY/3dI57M5iPwYhucqUgkQQn4cJrZVgBLFVXWSEHP71pR3ecWmBNYAHbFewn2/9m
	 7Re/cjDVAF6FAcbyjao/7Hn2A+gPXohUX8U5ubzpquDUrDjurdLb0U0bCFUfZhMZ9Ug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674977;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=R/FSE/9VhVyeTS0bvcwaj6O93PURdcX3MPrsTx44saM=;
	b=s6mIZ9MFg0h3mggxc9gSrx6PGbMt13UnOzS/w6wa3SsfzCMvWFwvt+nP1RihqwuvXZXb
	 UxdrszObSxtKZLnDh/cGhnJw+Dp570qXaau/YEB/mxkHwUr9FxbI9HyrYt9PaY+wDe4ao
	 D93+LBMkTA9V2u0Fh7Gwyf5/FqcdZnAmuxskEAYKaXWdantIXLlIp1SV9/xmstTkKaHMK
	 iVJjMpXPL6YZEOUU/2YtgQUs7CIQ5n8fhSSIJdK2xCJL8V/ECY3gGy7AKQ6RdqptCzDVt
	 fxkSAirLRFkzwi3XviqM3Qc785QJNyxzNboGSeRsczuj5twLNoXoFuJswfTYD8LsmgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C30F81F000D4;
	Thu, 26 Nov 2026 06:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674977;
	bh=R/FSE/9VhVyeTS0bvcwaj6O93PURdcX3MPrsTx44saM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ISvH7kGH0Ohpy0YS+aqy8CmSC7o+CGCzfgkaHschO2ETZHUYEeLzt7QZsgYJ+N3/5
	 HorCTu8JZpLWk2rsK3lth3Hg2GB/iIWtZg7XPimM1lJ2+RMlQ1PwEuC5CeaWcXvAkA
	 ZqRdHd3cFMuWQWvZa3xKqvgkcGR5EOjIx3FtkkbqkTL3RiZgooW3UgTXz201CSeJOF
	 ntyHmmhrxavGcNoVK2bf8862VS39dXEz1PL0fAFCaFvBHygolOEGMfxLzsGe85SH/Z
	 eV77FYUZtSsz7enwyZ63B3v5gaPnxY08OA/n4aqzKfYBOB2oPiqUBsa9fy8qaJBu8V
	 Bn4mtC2HdFdfw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4771B4D270;
	Thu, 26 Nov 2026 06:35:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 06:02:01 +0000
Subject: [PATCH 5.10.y v2] net: mvpp2: limit XDP frame size to the RX
 buffer
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-mvpp2-f3c6-v2-1-808d54f66dd7@certik.com>
X-B4-Tracking: v=1; b=H4sIAFjLB2sC/0WNwQ7CIBBEf6XZs9RCU5L6K8bDAovFKDRsbTRN/
 13Qg8d5mXmzAVMOxHBqNsi0Bg4plqAODdgJ45VEcCWD6pSWUmnxWOdZCd9bLUZvxsEhWuwdlMG
 cyYfXV3aGoZVd+4bLj/PT3Mgu1VSbBpmEyRjtVBFTdEtKd1H58f8A+/4ByUznpaEAAAA=
X-Change-ID: 20261126-mvpp2-f3c6-9fb95daaca3d
To: stable@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795672920; l=2926;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=nEG54vSD1l9G1xJGLgOmyZlKk1HndBSHrnab9cKFiPU=;
 b=5yBYtOfxgP4dHfX5ShB6vHrc56oa5xb49E7w39wPP+JZMRqSc227JdKMK3GVTeVrIuX2aMoMY
 67EBESzxCRiC0GAkfZhMvxZaOYeS3fZdZqel1w6Z0VS2zCFqfL+1oe5
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Til Kaiser <mail@tk154.de>

commit f3c6aa078927e6fe8121c9c591ddee8716c5305a upstream.

mvpp2 has short and long BM pools, and short pool buffers can be smaller
than PAGE_SIZE. The XDP path nevertheless initializes every xdp_buff with
PAGE_SIZE as frame size.

XDP helpers use frame_sz to validate tail growth and to derive the hard
end of the data area. Advertising PAGE_SIZE for short buffers can let
bpf_xdp_adjust_tail() grow a packet past the real allocation, corrupting
memory or later tripping skb tailroom checks.

Initialize the XDP buffer with bm_pool->frag_size so XDP tailroom matches
the actual buffer backing the packet.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Signed-off-by: Til Kaiser <mail@tk154.de>
Link: https://patch.msgid.link/20260607134943.21996-3-mail@tk154.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ adapted to 5.10: no xdp_init_buff() here, set xdp.frame_sz directly ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes in v2
v2: resent through a whitespace-safe path; v1 <CAFaZ9erzjfA3ogfym5X53zX6fW1kMTHcOnu7rMdkCeq=H64Qbg@mail.gmail.com> was damaged by my mail client and does not apply.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

5.10.y is the one stable branch still missing this. 5.15.y and newer
already took it. 5.10 has no xdp_init_buff() and mvpp2_rx() fills in
the xdp_buff by hand, so the change lands on the xdp.frame_sz
assignment instead. Same value, same spot.

Tested on v5.10.275:
- x86_64 allmodconfig (CONFIG_MVPP2=m) W=1 build of mvpp2_main.o,
  base vs patched, no new warnings
- x86_64 defconfig with CONFIG_MVPP2=y builds and boots under QEMU/KVM
- I don't have mvpp2 hardware, so the XDP short pool path itself is
  untested here. No existing selftest reaches it.

The other two fixes from the same upstream series, 5e8e2a9624df ("net:
mvpp2: refill RX buffers before XDP or skb use") and 77a6b90ce56b
("net: mvpp2: build skb from XDP-adjusted data on XDP_PASS"), aren't in
5.10.y either. This one doesn't depend on them, so it's on its own here.

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index cb0e319bc2f1..3e60d40b3f6f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3617,7 +3617,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			xdp.data_hard_start = data;
 			xdp.data = data + MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
 			xdp.data_end = xdp.data + rx_bytes;
-			xdp.frame_sz = PAGE_SIZE;
+			xdp.frame_sz = bm_pool->frag_size;
 
 			if (bm_pool->pkt_size == MVPP2_BM_SHORT_PKT_SIZE)
 				xdp.rxq = &rxq->xdp_rxq_short;



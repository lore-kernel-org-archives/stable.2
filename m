Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794860182;
	b=znWhHlW/c/oFsXGPZSpCF5XMMu0Tpvfn7G094nUVhK8tMjsl0d4XUG+0hF6/xxxLvVdv
	 4YJsy6Qjde6615vIaMMbyJQPCjuoY9N4JQxoqCVDiVcg7zgNA0OgbrI2v85E0Ev07/PoQ
	 0eZvV0zyVOl4VGjmrCl6ibR3/1DlL/otIxvzg3x2BaSjjO9lM2eTAI6/itVY6ocs5BkP8
	 nD5BfiFgIqsENVK5JK5FBfdWBslzoZMVvzmtdMpRaLvTEwYZuGmeQDmhwh9Kv2QKwnXz9
	 gybC0AdLFI0JoKrAXULhU1FUuJYrYzhlErDJbhj/voE2HEbt1f5v/mTbgUP93kvFB5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860182;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7W2ZASRZygP0wkBXpMKWBtbwdp5JtwNM/6Hn3wFvVW8=;
	b=R+Y4FehFLN24mYsurGvGPZMb6gUq9T/PP+4+577Juaz5W1vRbXi/2gBRdjxFeb5zo5W7
	 qdcPJROUNlOzJpEsRfdFrxP2zEt721fzt66lDTfw7qHxeKOo6SMuNPmw10Vf6QtgVzEZv
	 I+De1WfLvtYkHgEVR4pf1sgCv318VDdRWTii9dsaRziQW2Y1D/DBMnm+mxDp2ijY/tEwD
	 n6FSaq91iKahtr3i09ahBR4W//84LfM5+OhqKORAcCS2SyktEChK56+o70nT6Ymi396of
	 hiVp8OReRAedfrq0knd7z4VFtftsL6PzE2wNKzPMJXtxGfTMU0dI7PgGDX+yfZg7Dtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnuNr7vI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505C606A323;
	Mon, 16 Nov 2026 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnuNr7vI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794860182;
	b=ky9ycx/YvHbDywtB6VLQ7oYBjwhCX8rg6UEBuX02HZL0VfdZs9dH9gtKTYwH0kiNqoDu
	 4SvX9PFJyGQSp+UFhW6DFv4TjCoFogyROgiAQH9D39jB7i+W5emf4JpYXXdgWFDNS2YCm
	 tqLqOYsoEAE3ymafmLbu7K96SRTI+0rG55o8fKktxYggvSgOs7ZCKRA2AXYCmh9UQ+Oxb
	 BVlQ+IKouzo8cvS1j8ILyn9a2DkERIpziddxP/hHTQvULNenUec0rKhjShW7iMihaG31q
	 W/UyB2rW2dFGHQ620pia9jECgm5xWOIOpuWLT7rRXBXolQr9vLB17qXTezkwoHFuAKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860182;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7W2ZASRZygP0wkBXpMKWBtbwdp5JtwNM/6Hn3wFvVW8=;
	b=TWRjPbFU7ItOwonIPbH1rN2KK7p/V8z2gauTOXPD5RkgzQXYCo3rH+Ss4bhQHjRVGqSS
	 FmYIaeREe1NpBopLUGqh4vywKvjP1CFZDvCIZaWS/fTqumTu41gSS+clMzaxCJtKdg6qz
	 B1nWViWap7Lmulu3ohkJHSaMf2VFTfpM5aodsW/C44RdmEQivUpFLW1qwNXIpST9EmZAc
	 EQEJKiUbDBvzKh9Otz1e1nuBTfswz/wtpM/KPZkFQHg1e7kAh+SExswe/O2fMtfmpvoEM
	 wNGixMSv9mcmaShtS7ce7saAvaS3oDvZOjgIaGPpKXvi0UeGwQ4v8l+0FGWEeHIcLzg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8AE781F000C6;
	Mon, 16 Nov 2026 20:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794860182;
	bh=7W2ZASRZygP0wkBXpMKWBtbwdp5JtwNM/6Hn3wFvVW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KnuNr7vIOJZ3In6KoJfal+9hZLlm3xnMJxmj42OhY6REi+hFKzcLRyCBEu2f36/bk
	 9Ep7PWi/+NLMpsMpqZYRcEhOmdHYq+JjdPaaSmPQn2dc2CH3rQkZBNbtMI7y/djs0n
	 zZc5M5R16AqxL0KpxJjR1qoHbe1N2TqoG6Z32w+pTEgCLnG9kZPZzOyoAkfGCUKE9K
	 rmJmEbBUwOIRuF6dFav4pteFwPllp3GyYTjl/wgRcLlaU6Vdu1+CnPB0d4/y614r1S
	 5N52lEdKoH8G2j3JEBzsSnSpvpF9mXGpyCTeMz/H6VHE7bdDM67RiDfmNExmNBegZV
	 VfEHf2XVj0qTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0F2024A5D1;
	Mon, 16 Nov 2026 20:16:21 +0000 (UTC)
From: Marc Herrero via B4 Relay <devnull+marcht.proton.me@kernel.org>
Date: Mon, 16 Nov 2026 20:16:21 +0000
Subject: [PATCH v2 2/2] ASoC: qcom: audioreach: only disconnect the route a
 mixer control owns
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
Message-Id: <20261116-q6apm-fixes-v2-2-ea89fb43316a@proton.me>
References: <20261116-q6apm-fixes-v2-0-ea89fb43316a@proton.me>
In-Reply-To: <20261116-q6apm-fixes-v2-0-ea89fb43316a@proton.me>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Herrero <marcht@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794860180; l=2169;
 i=marcht@proton.me; s=20261111; h=from:subject:message-id;
 bh=5GY+RyEwsSLLjDug3UhC0wQAQJ4Vka8brzoVhhszmhE=;
 b=pbRPm+nLWeDcSAhEBrWdUHO/O2jQrubIJka04sF/J45X1LaxZnGIzQjvF+tVyl0GMTITxUapU
 tuJxWCx5s//D7d5BN4V1g2RpgSMlIGs0/6GoxLQ2Ef+x0QRAgqRBtRj
X-Developer-Key: i=marcht@proton.me; a=ed25519;
 pk=pIPy6L+INgiuJt7L7umVilPgpzy/Ni3QS77ToLj/H9c=
X-Endpoint-Received: by B4 Relay for marcht@proton.me/20261111 with
 auth_id=1490
X-Original-From: Marc Herrero <marcht@proton.me>
Reply-To: marcht@proton.me
Content-Transfer-Encoding: 7bit

From: Marc Herrero <marcht@proton.me>

Each AudioReach virtual mixer route control ("<BE> Audio Mixer <FE>")
connects a front-end stream graph to a back-end device graph by storing
the source module in the device graph's audioreach_graph_info. Writing 0
to any of these controls clears that link unconditionally, even when the
device graph is connected to a different front end.

When two front ends can feed the same back end the result therefore
depends on write order. On QCS6490 (Radxa Dragon Q6A):

 - alsactl restore writes 'DISPLAY_PORT_RX_0 Audio Mixer MultiMedia2' = 1
   and then 'DISPLAY_PORT_RX_0 Audio Mixer MultiMedia1' = 0, which leaves
   DisplayPort disconnected although the saved state has it connected;
 - the UCM HDMI enable sequence writes
   'RX_CODEC_DMA_RX_0 Audio Mixer MultiMedia2' = 0, which disconnects
   MultiMedia1 from the headphones. A PCM started on MultiMedia1 after
   that never advances (hw_ptr stays at 0).

Make audioreach_connect_sub_graphs() only clear the link when it belongs
to the control being cleared, using the same test as
audioreach_is_vmixer_connected() does for get(). The DAPM mixer state is
still updated for every write, so DAPM keeps tracking each route control
as before.

Fixes: e4977b91cff8 ("ASoC: qdsp6: audioreach: Simplify handing FE and BE graph connections")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Herrero <marcht@proton.me>
---
 sound/soc/qcom/qdsp6/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 612d8f03e6e9..aa2ab2b058d0 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -1240,7 +1240,9 @@ static void audioreach_connect_sub_graphs(struct q6apm *apm,
 		info->dst_mod_inst_id = m2->module_instance_id;
 		info->dst_mod_ip_port_id = 2;
 
-	} else {
+	} else if (info->src_mod_inst_id == m1->module_instance_id &&
+		   info->dst_mod_inst_id == m2->module_instance_id) {
+		/* only drop the link this control made, not another FE's */
 		info->src_mod_inst_id = 0;
 		info->src_mod_op_port_id = 0;
 		info->dst_mod_inst_id = 0;

-- 
2.53.0



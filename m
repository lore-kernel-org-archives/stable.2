Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794248557;
	b=BTSX/+zljT1LdjWs2Yj3Z8ZaagF0jbQA2zyaKezg9kM486ZnBM1vcQ+XeAYpT6DNyWdn
	 l1nmhZrslTtIWcvZ07dVQQI5iNxKhbEplF0duJr/wwo5w6vQVGwbS92o9nQ11KanB8QSb
	 +twQkIELoEIWZg+Bu0wN2paPa+JfcfBecysgnV8OFEzacFDrnIi+Wbc9cxoG0Mwze3ZTk
	 ejBdUh+SsTnIm2DzyYCAk4ycAVjXMx/qj1GH97uUBgNT5SxpEDUH4ugWsVPSAuOUyxMoZ
	 P5EH4Rv9/fI+jwJnlpI//3khO85GLjXTKLplfZbl/mmX+btEd/+etiYrSKnuCof8QWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248557;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xNmCOP2xYudoY3c58TVmCr/zLg3Xy1bk3ujOYfJ111s=;
	b=2tpDgdjgZW99fPNJEc4RTDD+HBtApWIt8c90JiaRJleyYv0tVT4c+vq9/UFz573ws2zO
	 oR+D/WsFrlmaFyKqHeYkLf6hKZowenLpSegQw7OTY40dezSvtQCrPHCHl/7kJH52fIlLz
	 Rg6VS99RLIzms3Bye+xkGvyzu6xaRKCl7G62XsF9nlnot3gR7zmF3Mbf7ADWE6wx/d0oL
	 GsO9cGBDJ8+CphL3FOIbShw5eTVSRcXFsn0QWc2cNy40umTsa4d9ydIQ7vTKjXS7oMetH
	 5U6hENkwW8cK9YG0WsWSJJD+jAupQ0/RRPDuZtWZ5XULXs/AApF+pZUrzYWcDOkdBSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iVjR/0EY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF47606A321;
	Mon,  9 Nov 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVjR/0EY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794248557;
	b=S5KNHMEwAF/D99TOG9IQS3xg39LQYrsCyef0AUt2GN21Q/B7fKNfr5rmgbXz1l73u39x
	 NsMZ9177ngzfREJho8Wl8c/3K2t5g/XQPQY109yC2ACBCl/bDmqBT69rfSXJ5x1w8ak61
	 K5izRjO6x7gCrNz1AzSI5tEduXtTwnuucCwntaqfr3kk+T3/VSC6YDrBXFsbRp+r+aYOL
	 O5HuPl+Oah83w5hl7kqnIsaA0mywiAInJLYkMCIqcOzeh+JFRBLO2dikKCMKX/XWVnYLj
	 gOtiIQPm6DjzyopwPVEIpliAPJzETHdc6n8GgakfqayGEb1kv/phUZR6WdndshoPdTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794248557;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xNmCOP2xYudoY3c58TVmCr/zLg3Xy1bk3ujOYfJ111s=;
	b=XRNlWRAw+zKma2LOTog1DFSGF2udZtlCyM3HnavliTiONd6a3O1g4nbSUQkK8prqjrhZ
	 ATjKrLJf29CnxG91mMiUHPKBD+OjvLWpzNzQlaDZMtjI2jA/dbuNPS90yV/K4Ak+fwJIh
	 //CRnHcq9OYGqWvSMlra6H5KiBVnFKH60+knYbrnT1Lq+wbyyzwOvuItlFeeXAvmyzcmM
	 ba+hqhX/h3yVof+5PqvKhbf96WYQa8cMagCdLu3fXCespSmlZFldfAeHtqFDm4GhcLeFB
	 R4p7XDz2+viwtolj/2aNOofJN9vdpn2s+QsT27f6iiL+VijYSYxlQFUPWgenu2M4CyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A0EE91F0089F;
	Mon,  9 Nov 2026 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794248557;
	bh=xNmCOP2xYudoY3c58TVmCr/zLg3Xy1bk3ujOYfJ111s=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=iVjR/0EYwhyNzjz0ynQtryOCjNXqluNx3AXU11L2T0azTI15UKEOtW39F+A5rMdtf
	 e0Vl1YyNF2nyOe33uZLKG1XMByb/0c4bsCb5SW98217JPntY7GqHY2nrV+j0sJDDth
	 N/R5DkW1axnxu9CPMDivbxZLjqKjVNmhsId+TCoINxmXZ+I+w6DJxaRp1XANxH73IN
	 7liPzQxtii7Qj3aasj9k4KkufM5djm6688Go768Tu23F4j2mzs7d7D2ptnYJoHz41t
	 1Gdu2b5dwszvhf/Gimxl6YJqn81kdnpjFKvrGKgiQVmCNUDT9B+7s9+LGalYGzd2rh
	 yAS0i/oF+zjag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3159B485B2;
	Mon,  9 Nov 2026 18:22:36 +0000 (UTC)
From: "Nicholas E. Andrade via B4 Relay" <devnull+sdnick484.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 10:22:35 -0800
Subject: [PATCH] ASoC: amd: acp: fix PDM ring buffer address on ACP7.x
 resume
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
Message-Id: <20261109-for-next-v1-1-54a06f391bda@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avIrBPUQLCrRAutqaaFhloI0d2zW
 n7wv3dBwkiYoGMXRDwpUfAVsmEwrtYvyGmqBiWUllIYPofIPZbMrWqtUM4apx3UfI84U/mu+uF
 3OtyGY373cN8PRGBWDmwAAAA=
X-Change-ID: 20261109-for-next-a23a02ba9b6b
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Nicholas E. Andrade" <sdnick484@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794248555; l=2818;
 i=sdnick484@gmail.com; s=20261109; h=from:subject:message-id;
 bh=8RaG7FvDYO7V+CSMfCZPjcUt6Rsow7pb/3k3rvgPCIM=;
 b=8HgxVqk2Ro9a50QOMq42KnkEi4iD8kX3OS7sYnkkhDRjDw/4lQJ0gbh9rR2onZekoKglapw7j
 cXpvj4VQXJ3BGzfVwsmHegvLCG43Vnh0gu0vSV1Gc3K92qEyWHseJMC
X-Developer-Key: i=sdnick484@gmail.com; a=ed25519;
 pk=dZeJlYx1JwBxT2ReweY1tgwN5soFTVPcCKakRZCpX54=
X-Endpoint-Received: by B4 Relay for sdnick484@gmail.com/20261109 with
 auth_id=1464
X-Original-From: "Nicholas E. Andrade" <sdnick484@gmail.com>
Reply-To: sdnick484@gmail.com
Content-Transfer-Encoding: 7bit

From: "Nicholas E. Andrade" <sdnick484@gmail.com>

On ACP7.x the DMIC ring buffer lives at ACP7x_DMIC_MEM_WINDOW_START,
and acp_dmic_prepare() programs ACP_WOV_RX_RINGBUFADDR accordingly.
The system resume path (acp70_pcm_resume() -> restore_acp_pdm_params()
-> set_acp_pdm_ring_buffer()) however still uses the pre-ACP7.x
calculation, stream->reg_offset + MEM_WINDOW_START (0x6080000).

That window is not backed by the PTEs config_acp_dma() writes for the
DMIC stream (scratch offset 0x6000, i.e. window 0x4C00000), so after
resume the ATU translates DMIC DMA through uninitialised SRAM and the
ACP writes to random IOVAs. With the IOMMU enabled, a capture stream
held open across s2idle produces a continuous stream of faults until
it is closed, and captures nothing useful:

  snd_acp_pci 0000:c4:00.5: AMD-Vi: Event logged [IO_PAGE_FAULT
  domain=0x0018 address=0x1ddeee9942398e20 flags=0x0030]

Commit 3ee257aba1d5 ("ASoC: amd: acp: Audio is not resuming after
s0ix") fixed the same problem for the I2S restore path in
set_acp_i2s_dma_fifo() but left the PDM path unchanged. Select the
ACP7.x window there too, matching acp_dmic_prepare().

Tested on a Lenovo ThinkPad P14s Gen 6 AMD (ACP rev 0x71, kernel
7.3.1) by holding
  arecord -D hw:CARD=acppdmmach,DEV=0 -f S32_LE -r 48000 -c 2
open across s2idle: before the fix, IO_PAGE_FAULTs after every resume
and no audio; after, no faults and audio captured correctly after
resume.

The bug was diagnosed and the fix drafted with the help of an AI
coding assistant (Claude); the analysis, change and testing were
reviewed and verified by the submitter on the hardware above.

Fixes: f6f7d25b1103 ("ASoC: amd: acp: Add pte configuration for ACP7.0 platform")
Cc: stable@vger.kernel.org

Signed-off-by: Nicholas E. Andrade <sdnick484@gmail.com>
---
 sound/soc/amd/acp/acp-legacy-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 4e477c48d4b..9c0528a7dfc 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -154,7 +154,10 @@ static void set_acp_pdm_ring_buffer(struct snd_pcm_substream *substream,
 
 	period_bytes = frames_to_bytes(runtime, runtime->period_size);
 	pdm_size = frames_to_bytes(runtime, runtime->buffer_size);
-	physical_addr = stream->reg_offset + MEM_WINDOW_START;
+	if (chip->acp_rev >= ACP70_PCI_ID)
+		physical_addr = ACP7x_DMIC_MEM_WINDOW_START;
+	else
+		physical_addr = stream->reg_offset + MEM_WINDOW_START;
 
 	/* Init ACP PDM Ring buffer */
 	writel(physical_addr, chip->base + ACP_WOV_RX_RINGBUFADDR);

---
base-commit: cde5523c75f1320a55ac1d55a717ccbb566557f0
change-id: 20261109-for-next-a23a02ba9b6b

Best regards,
--  
Nicholas E. Andrade <sdnick484@gmail.com>



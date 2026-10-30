Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357456;
	b=B15mhAzIHr3lCOgjgUu53bMokX1kT8jTe8kaL8spFRteZGMxPSVYTXIkRQLQuQbi5Es4
	 1mY0kiSW9RkklkUda9xAFtyXKzjRXssvIZ1+6n1tW5f8+ZAmy+3WtKRX6c20nlO92dSlq
	 LztX4TqdxRVMj+2kXISBSBvew6zxDeDMVgL7Y/3WEQT57HhnolPHwJeO/Mk/1ti5MnMXp
	 XOGobwXx2abRumR4L/V3koXhPfV9/29Wg6PVKLpbtWty9c8XJRDJqVJBDsicZtyUKB4xy
	 iwFk0z3KCvgG14Efb9bx4jx6pSpJ1TM8XhwZ4RNh2d2KecYprLVv98t5mZ4fqhmoyhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357456;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=swWTjIAU8FgVPCklJ6P61ykI1U8LYOWq7bqWAoTGdlA=;
	b=EnyeyxRVTFgKMbNOeC2u64j6nRDWLYwE3k2mGSuidi32Fujn7abYNdzF+tzBrv/OTBXb
	 2KENk8qUANKO8Lo1wPLjcT7I+twyz0+JxBSRckLE7e3W+8OFejuHX9cxI4hfAUa3FX7It
	 SqBx5vepq+bnNL1RIrcaaXuKVIyrImRyBh/7hjnozW6IPpIYwAQzDqtKCpERaWV48Sh59
	 6y2ljKkr/f3h1TCEFEOmAMalkpGh9EpI3NgFVklthTk4alocxH3vFtB+4107BT2lFmF3c
	 6Uw224wdvuSB2IPaUFF7CQJy87mtnZrXiTdxC0TNfRNMe6RoQU/vd1DqJlqqBtftB7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrxqjrxA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9D60A262C;
	Fri, 30 Oct 2026 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrxqjrxA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087691F0093A;
	Fri, 30 Oct 2026 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357455;
	bh=swWTjIAU8FgVPCklJ6P61ykI1U8LYOWq7bqWAoTGdlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TrxqjrxAmT61FKiMPNeoVtKyTqtdoA99K3yjgnUoRATljQz3BIzhNfUmO6BZ15bTA
	 lB37YZEfxC8Fefo66oL+JDYntPMz8Bv4VVf+7vsgUaKKsTZ7RT+110DpGhNe3ykfCk
	 QyKRXcLPc98EKSJa2kLMoCuL7xGN2Klo4iXqOAlIyA/0I1l2H9OCmeQ4P591dh3YtI
	 hjn5R7iTgsqdUK+jo0+0vlnj0UtpmDW3Xw0lx8IRSpuPwYxAnPFkMszg6rNgV/mw77
	 BJgAOZ2p1g/vZOwftxftB78ZCDPrmqw5ijCQrGM/0WNHV3Y3G4YIhCDUnI9cFxPqt4
	 zyqqITl+EMrsQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vinod Koul <vkoul@kernel.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/21] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before closing BPT streams
Date: Fri, 30 Oct 2026 10:46:44 +0000
Message-ID: <20261030104840.3361217-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
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

When sdw_enable_stream() fails in intel_ace2x_bpt_send_async() after
hda_sdw_bpt_send_async() has already started the TX and RX DMA streams,
intel_ace2x_bpt_close_stream() invokes hda_sdw_bpt_close() directly
without calling hda_sdw_bpt_wait().  As a result,
hda_sdw_bpt_dma_deprepare() tears down the DMA buffers and BDL while
the DMA hardware is still running.

Disable any running TX or RX BPT DMA stream at the start of
hda_sdw_bpt_close() before unmapping channels and depreparing DMA
resources.

Fixes: 4c1ce9f37d8a ("soundwire: intel_ace2x: add BPT send_async/wait callbacks")
Closes: https://sashiko.dev/#/bug/linux-ff0012de-abdd-4796-875e-b1fbbf47235f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 sound/soc/sof/intel/hda-sdw-bpt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sof/intel/hda-sdw-bpt.c b/sound/soc/sof/intel/hda-sdw-bpt.c
index ba9fbd662b85..9d97d8676251 100644
--- a/sound/soc/sof/intel/hda-sdw-bpt.c
+++ b/sound/soc/sof/intel/hda-sdw-bpt.c
@@ -456,6 +456,12 @@ int hda_sdw_bpt_close(struct device *dev, int link_id, struct hdac_ext_stream *b
 	int ret;
 	int ret1;
 
+	if (bpt_rx_stream && hdac_stream(bpt_rx_stream)->running)
+		hda_sdw_bpt_dma_disable(dev, bpt_rx_stream);
+
+	if (bpt_tx_stream && hdac_stream(bpt_tx_stream)->running)
+		hda_sdw_bpt_dma_disable(dev, bpt_tx_stream);
+
 	/*
 	 * In the case of SoundWire we need to reset the PCMSyCM registers.
 	 * Need to continue depreparing the DMA buffers even if this fails.
-- 
2.56.0.317.g454f8302e1-goog


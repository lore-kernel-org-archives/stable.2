Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316618;
	b=HYbmXqasnxfe3HZYVkwHmJXJPsfPfmiwaXB0XSfwZSuswIYZjI52SA5dXEp26kmufl5b
	 R8yYSuomQFt4vSdM7MJc5UzC1kaGVMo9OUuRfyFV+gUukzql2Y7TEJ2qDQiN6vLRaZjiC
	 fY340TmvUnlUV3sy85BsDmd26Vqgz6/vxBJdsAMXC9u30LiReDDA3T1eClYaRdHz7obc0
	 zTR80I83kxlE0aIaXgA/1hnQi5mRBScf4T1yQk9PciQZRXCU98fHTJ6q/68BbJy2KMOOB
	 FpR4Q1IYmY8bKN6xAdeMu/Dhx+diUEFihJ78fgNEL3DlMNWUfMEpaT9lLp11LXqksAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316618;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lPw/5S58DZQlTesLTVHv+YY88dgiz6gD3h2+DSTc3Zk=;
	b=YEqoEuPd/Xtuv6yBaU6SabdVoo+XEiCvE0dC2cALr9Qo47uzUMXr/jAXbXNpmdYATfRn
	 sTiKk0qr43MA9Sc9UCNOSyuFzIdDd9VtdBanRWBdJDj7PmnsROKLWbM0keyY0Fi4/gUHn
	 S8LrQgZqcHSgd68bW7bZMEXlzRd37QQxeyjVo94EOsXx1s14BG+S6Ln7uYjNt/wjRtjNk
	 YFNzviwS2TIPMOwtOQEMPMRAj+W/l1e2amVl7RvLkbb66yLBLtKLHvuPe2KNBm9W35O+v
	 UKVfVSophKa1+FaM2r414w4Wh8xAkjDqpLeCuz36Pi5xCUsVVrO6rupquTkOBdEwljg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=bvWPjXOO;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B07606A326;
	Tue, 10 Nov 2026 13:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B07606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=bvWPjXOO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794316611; bh=lPw/5S58DZQlTesLTVHv+YY88dgiz6gD3h2+DSTc3Zk=;
	h=From:To:Cc:Subject:Date;
	b=bvWPjXOOxayNzPao+CtRgDv4eOeP7ME8tDnwbCD6rssTpOWWtt4dU+8zV8OiFTSRh
	 x+9GLxLcfy9k0mY2cHpDnsJK8ZO7fSEEiQQrbkGi/f4j0bRi5O6ridM2Cd03zgAS+T
	 xjJcUDYdVnNB90UnKTlnNxUPrCkz9dIOatdPjiIQ=
Received: from localhost.localdomain ([14.155.185.171])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 4313A2FB; Tue, 10 Nov 2026 21:16:49 +0800
X-QQ-mid: xmsmtpt1794316609t1zb1lv87
Message-ID: <tencent_C00D995A9F70206DFD1330DCB1222EEBCB07@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JupLwDnYE/eysQuAMoZk0KnKqN0idjV7dUwPWDmHk9Hyv/9aGE4I
	 uhPvZrMrY1pcYcHgj9SfXc+q8+JZXPmODcw67jaGCObYyvkZKgg4oWWmX75cUK1K59D3/fOzuu+M
	 JGI+07CuaVDnjWOtvh7SwQ8dncemMVML2ch2qHKs6nVZNfP75scvViAm8utkw1DmQytcj+4RRNC9
	 JLs0qkjVdK79DGRESyQmA9XRzBSVU1/i36E2EeIsr3pCpjV3Srl7ZvIsZ+vD4tcvfj5IO1eBIV1N
	 JEfR3aJZjR3zK6q8bvGeonx0OAnq6dY6/V7tn4nXyHRPztd/vVXWS0enkXGvcN7PaKegYfLTkn4p
	 +nk0FoVhNxq5NJjLZTTDylHGBKeHRugiv+IC/Ye6miAp8Br8CeJ64LfxRK27SM2qngSq6uJIQUWV
	 tvhUpo3S9yDrjIYHXVUZP3y1jursJDacqXM87BhfzE0BxF+J5184HIQYYkS6n4/cXKbFmk30OUl9
	 MHHghCTg5zvZ3kF4Dm5yiQBaqH8uncUSJBb4SvmNi9Q5Sd6miKAlFjH46SttFrVfN/82W3tfnq86
	 OXbldRaQ0d7lOrSsE1Ry6UQC+GzT35M2osgIk2EK/CORIE0P7MAIXj3mFN9K7xdzbZHbtqri5SeS
	 Ljpf0kGMRKVKWp189whOkZ7C1I6DcEVqAVE2qs+t4iT1Lcq8FHowG5qpQKWlIo7c0r+1rQ1SGCGw
	 C2kCqWQCieuVygZYXSeADQvdqfzjG9GB813AiQpZvOngsm5EYXZPRkqoC/vrd40/mEZJclE773Xb
	 HkhRRV5xGDmcxl4F4Smw9671AwdLkiHsrWmpS3ZTg/UNbcqx5mR+CuoPSKBouKaX6GopUoIJq+gV
	 4Yg/FKMh0Jyz5mysDWALmUDYXVJ1utFsiGFZjfOR8GrpdvBY2wZF2eWGOrGHGObmPIr6AZ6cDLK9
	 jiloXVMClOB+edshaXcjG2XAYT0GrsHrFdLRhBeHZR2DAPL26IuvoCr05tCbzAs4M5gySBoPx6xh
	 EpvEkSPCBnzgI/HdJ3+Cq+o+7jwT8CKOqFvof6yJQPTvCDF8iTJvGi5G+JUq599/SKC0QXOgEPqP
	 jljps2I3ylLveIplRJg1c07Nlne6UCz/kOyMx6kjp3mJN0pdt3KxOqTFs8ww==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Wang YuWei <1973615295@qq.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang YuWei <1973615295@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: dw-axi-dmac: Fix use-after-free on cyclic terminate
Date: Tue, 10 Nov 2026 21:16:49 +0800
X-OQ-MSGID: <20261110131649.13218-1-1973615295@qq.com>
X-Mailer: git-send-email 2.34.1
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

dma_chan_terminate_all() frees all descriptors but leaves vc->cyclic
pointing at the active cyclic descriptor. If a period interrupt has
already run vchan_cyclic_callback() and the vchan tasklet has not run
yet, the tasklet later reads the callback from the freed descriptor:

  CPU0                                  CPU1
  axi_chan_block_xfer_complete()
    vchan_cyclic_callback(vd)
      vc->cyclic = vd
      tasklet_schedule()
                                        dmaengine_terminate_sync()
                                          dma_chan_terminate_all()
                                            vchan_get_all_descriptors()
                                            vchan_dma_desc_free_list()
                                              -> vd freed
                                          dw_axi_dma_synchronize()
                                            tasklet_kill()
  vchan_complete()
    vd = vc->cyclic          <- freed
    cb = vd->tx.callback     <- garbage

tasklet_kill() waits for the scheduled tasklet rather than cancelling
it, so dmaengine_terminate_sync() does not close the window. Any cyclic
user can hit this, e.g. ALSA via pcm_dmaengine. It was found with an
out-of-tree 8250 driver that runs UART RX as a cyclic transfer, where
closing the port crashed in the tasklet:

  Unable to handle kernel execute from non-executable memory
  lr : vchan_complete+0xbc/0x23c

The window is normally only as long as it takes the tasklet to run, but
it grows when the tasklet is delayed under heavy interrupt load, which
is how it was hit here.

The active descriptor stays on desc_issued in this driver. Take it off
and pass it to vchan_terminate_vdesc(), which clears vc->cyclic under
vc.lock, as other virt-dma drivers do in terminate_all().

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Cc: stable@vger.kernel.org
Signed-off-by: Wang YuWei <1973615295@qq.com>
---
Tested on the v6.1 based vendor kernel on the hardware where the crash
was seen; build-tested only on mainline (arm64, W=1).

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7520c78f5..4d41c7538 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1182,6 +1182,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	u32 chan_active = BIT(chan->id) << DMAC_CHAN_EN_SHIFT;
+	struct virt_dma_desc *vd;
 	unsigned long flags;
 	u32 val;
 	int ret;
@@ -1202,6 +1203,17 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
+	/*
+	 * The active descriptor stays on desc_issued. Hand it to
+	 * vchan_terminate_vdesc() so that a cyclic callback still pending in
+	 * the vchan tasklet is dropped before the descriptor is freed below.
+	 */
+	vd = vchan_next_desc(&chan->vc);
+	if (vd) {
+		list_del(&vd->node);
+		vchan_terminate_vdesc(vd);
+	}
+
 	vchan_get_all_descriptors(&chan->vc, &head);
 
 	chan->cyclic = false;
-- 
2.34.1


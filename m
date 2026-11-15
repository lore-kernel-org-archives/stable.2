Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727181;
	b=1VGSoFJiK8Uax57LwkF3EZxRQTZ3b2Z04RmpKkYdOTsj3xIeC0/JmpPhqJiCcB6cBpdL
	 9BWT/KNhAA8YO+HG6VOdCQaXulwpDyGTn6vnFGWAjABD0TQaET9fr/NK0WQn3RsQvf7RR
	 HAdHcNDOmKZXcHiGVgv1C4e4rAnI6T/kcDu+ATElnBh4DjIbEBrAVPURqTAN37EzeWrRh
	 ekaT7nnHDPYRR3OXSGGaKnwtTJCj36vQg1drvndpyDZuUx96EB4v3v5Op8gjsmk5iU9Cj
	 MSolfqEcrPJ52JN+865OGwoHhRHSBKU8um/RWB4qlolV+jQd4WA7fB70b+02xAldz7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=nXyMrT3sYdOxeSk47EaCAAbBwQAWb4yc1AvLRKcz5XE=;
	b=T2Bpu/WEpw1pGydPKoIyAsf4sc3pr6dxzKL0xtACpTaBeOjZb/I52u/PQ30wAqI2eoBO
	 wXPQW+NndVMTBCCvfKGnWTMWSGzBdyasC05Ykyej7xCkpjm/nwFeWkr0X4UM3HobeY9qZ
	 Lx7ooAlL9B/wRgfqNQl+tn3es+amcZim1arGrkdFffaR6jPdtYSmCKhtrWE3XR6S3zWKL
	 8nYzFUIIbXlnkTRMKLJs/m0QNR70bt9fnUQAlg2CRiY2LcIRd5rn+A6WpF7QZi91XOO8c
	 pcAgbY/Jc1nz4qZAYdk5lArNmg8GiEn4pXG49g+7ojkPbwvLi6muqA3jDEQRgVy6XvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u9ZOqO/W";
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0526606A31F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0526606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9ZOqO/W
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-71ac9e15640so1090900eaf.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 23:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727180; x=1795331980; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nXyMrT3sYdOxeSk47EaCAAbBwQAWb4yc1AvLRKcz5XE=;
        b=u9ZOqO/WGuvUTfJeon5puJvmrGkdOEessM2TfATgkPUOU5Yah8sDNvOdqlPF2/E/yo
         2EeEfz/1DwIT3iJju4rPOa5hqOgcVV4bw8lop9yrYRrp3Wt/IxhIR1sAono8AodUrCxm
         LVGp/9e9MnrgOGfpY2rNh70xVEg0on/zcz4vTERwnCPWbCmvmg76UrfVxGo5umutFLUk
         CSW1Kl8FA3LWPGLty1PdRGb9mewc8cvq6S1+amKciSzC3kOjHkMb2z03cjzEu/crjB8H
         +bw28/C7xaupuhrtaWa6x8c0CpbxMv839gaIJX10vg1aZi2+1djXDHeKQtP4Tc+iypG8
         7A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727180; x=1795331980;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nXyMrT3sYdOxeSk47EaCAAbBwQAWb4yc1AvLRKcz5XE=;
        b=Rnn//6SNLPccFsvqnMOTOZD3Al3ryEpU8tPcZwYWR7eWfmckvyf8UEuO26/bxJEk6t
         BBVbt0hRLB1+JzdFuhyv3YN0kn+59eAbFkRef4UdXmSyY5jGmXn56HCcJgmmrisa6QLp
         J6gvx0y8TsgB9jfGFvZwbT9gk5tpXPslJdT7KyDv92ndsGhDf/cUlHBYROCKglqm2TUo
         fr4AgMEUftl31X1Z0PZGlVq8gvFwnokidJjhmoMMd/W53urA4eSdk09EeERpUhChlOHU
         urCixhvSlWCDGbqjnFllgiBDziFIhJVCcuOEPlWl/43YgqIbtgDTZSRi7a4iuUTA1FtA
         FlIw==
X-Forwarded-Encrypted: i=1; AL+hErE049dTRgCY91DABlw5NpQLuM6nEYDpAqFevupaiPyBQ8bScg/Wn+4065jyWc2re5gW2LFgZrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uo+aHIl71GzjDf9SCEjmmKkZwITgToYex90SzikjE1HPRrpOe
	zdyCFXX7bqPatxk1MUYAIEtiTEIKT9nNOpWCyYsAzF0d4yZAImxcA8Ha
X-Gm-Gg: AYBFou23QK+ASgItuloCBTsyhzRvwkAuuQ07eOFIRGFzRM1eGso62QRQoDL+85vSSsZ
	aNOAwIeiXDosv/1bU7D1EYzjuoRGA6L9HS4mVJF9osmAcpdN+hamm2FP/wlqB8uY6m0dZCk4hiL
	XP0qXK3OylsjI6DkHmiYgmclGAE5OJBRVgZ8paI4eOQiVQVLhXRX1G3yR7yq4IwSoyJGVs5yppb
	kOjqidp2fkOXE96FduTUkodZDLdAgnn9YJcga7MKMrK7pHyukYDzsDqEih2NsyvNG0gbDKyPqpn
	cVgDDycsaEfCFSUPNf6McvTL1R52UDAaAQKYw+6N+i/5dpW9hsOGpazZz48uC5IRKzI1vQy8x7Y
	o2wbYkmU0tl+cyN84UfljJjyV75jOumPf401LQZuaiJd2O8rp8vCkPnA9vRekZnp+z0FJr6wPTn
	bpJ9gEjK0pc7rWvA2Rd0zDBIcj/Pf2Xje77CEVb8i2AadFHmaFwXPBodvWMCwIYw0/FQWIUdcVc
	Z7XCZY/Jsh+wWPFuUtwDC9xXbAQDHY0PmeYm/5acIqXTOZ/dZu7KERDEZkXWhIkUcwCa3gPl9EC
	G+hbO01L0ddfY1hdFAjLkWzn6fMDhaPaOt8ANqaknyUYcr+mEK8dcjvRHotri5DUpulHjeR5nGM
	PPEFCm9LibflYbrhQMuE5OP//eI/4LrYIGiopFFeZnuazmofT6gUZZD2oTBPn4C0Z78f3cRw/sh
	I2Qdkjv0eGnk2flQmP4WTZDTSpax15xz60bGz4pwcbpouoKeNxaPg=
X-Received: by 2002:a05:6820:a29a:10b0:714:e19b:c3c7 with SMTP id 006d021491bc7-71ab509996cmr3191034eaf.39.1794727179658;
        Sat, 14 Nov 2026 23:19:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:39 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v7 00/10] dmaengine: dw: serialize completion and
 termination
Date: Sun, 15 Nov 2026 00:19:33 -0700
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QwU7EIBAG4FfZcBalU6DUk+9hPFAYWoxtDdTqu
 um7O9092NRDTbj8ZObLDxeWMUXM7PF0YQnnmOM4UKjuTsx1dmiRR0+ZgQBdCCh4/mj6OHH/yX1
 veT4PrkvjEL+RzwVHpUSQVfCFt4yI94Qhfl3555dbpv1XdNNqrhONzcibZIlZr8jEoY0DPtz2a
 KKLeRrT+dpwLlbpn2XoFFzbYJQDr4Oun9rexrd7N/ZsLTPDFoMDDLjgCqTEWnpnjdtj5RYrD7C
 SMKehCUKaoBzuMbnF6gNMEhbQSln5OoBRe0z9YqQdYIowX4KoKmVCE/78md5iR8/UhAGicKU0A
 NJvsWVZfgBy9Q6ffQIAAA==
X-Change-ID: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

Keep client callbacks in the controller tasklet while preserving polled
completion. Serialize descriptor ownership across completion, error
recovery and termination, and wait for callbacks before a client reuses
its resources.

The series first serializes completion, error recovery and cookie
accounting with termination. Separate patches extract hardware-LLP
residue calculation, calculate it in the status getter, simplify completion
handling and report queued residue. Channel release and
device_synchronize then gain tasklet draining before the final patch
adds deferred notifications and shared completed-descriptor cleanup.

The series adapts Serge Semin's channel-restart and callback fixes [0-2].
Polling continues to advance cookies and software-LLP blocks, while client
notifications run from the controller tasklet. Synchronization preserves
pending tasklet runs from other channels.

Based on dmaengine/fixes at 6628e7d4c6b2.

[0] https://lore.kernel.org/r/20240911184710.4207-1-fancer.lancer@gmail.com
[1] https://lore.kernel.org/r/20240911184710.4207-2-fancer.lancer@gmail.com
[2] https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes in v7:
- Use a scoped channel-lock guard in dwc_tx_status(), following Frank's
  review, keeping polled completion and residue lookup in the same scope.
- Collect Frank's Reviewed-by tags for the residue and completion patches.
- Link to v6: https://patch.msgid.link/20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com

Changes in v6:
- Keep dwc_get_hard_llp_desc_residue() next to dwc_get_sent() when
  converting it to return residue, following Frank's review.
- Remove inherited RFC notes from the individual patches, retaining
  the revision history in this cover letter.
- Link to v5: https://patch.msgid.link/20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com

Changes in v5:
- Rebase onto dmaengine/fixes at 6628e7d4c6b2, using the shared
  dmaengine_chan_dev() helper for channel logging.
- Split residue handling into a behavior-preserving extraction, status
  calculation, scanner simplification and queued-residue reporting,
  following Frank's review.
- Share completed-descriptor freeing between the tasklet and channel
  release, retaining callbacks for normal completion and suppressing
  them during teardown. Name the helper dwc_free_completed().
- Carry Frank's additional review tags and put the submitter sign-off
  after the review tags.
- Link to v4: https://patch.msgid.link/20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com

Changes in v4:
- Split v3's callback-deferral patch into cookie accounting, residue
  calculation, channel-release draining and callback-deferral patches,
  following Frank's review. The resulting seven-patch series preserves
  v3's final implementation.
- Place device_synchronize before callback deferral so clients can drain
  deferred notifications when the completion list is introduced.
- Carry Frank's Reviewed-by tags on the unchanged channel-completion,
  error-recovery and device_synchronize patches.
- Link to v3: https://patch.msgid.link/20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com

Changes in v3:
- Order channel-completion and error-recovery locking before callback
  deferral, retaining four patches.
- Require a locked RAW.XFER event before retiring a transfer; zero source
  residue alone cannot establish destination completion.
- Preserve polled completion and software-LLP progress in tx_status(),
  queuing client notifications for the controller tasklet.
- Serialize cookie updates with termination and report queued residue.
- Drain deferred notifications on channel release and let a pending
  tasklet return without MMIO after the last channel is released.
- Adapt Serge's two patches and retain his authorship and revision notes.
  Drop the Tested-by tags that covered their earlier implementations.
- Identify the introduction of the synchronization API in the final
  patch's Fixes tag.
- Link to v2: https://patch.msgid.link/20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com

Changes in v2:
- Carry Serge Semin's two posted fixes before the synchronization change,
  preserving his authorship and revision notes. Add the requested stable
  Cc trailers and Andy Shevchenko's Tested-by tags to those unchanged fixes.
- Add a separate error-recovery fix for stale error status, empty channel
  lists and software-LLP state when terminating or restarting a channel.
- Use tasklet_disable()/tasklet_enable() instead of tasklet_kill() so
  synchronization preserves scheduling requests from other channels.
- Explain descriptor ownership during termination and acknowledge the
  shared-tasklet scheduling race reported by Sashiko.
- Link to v1: https://patch.msgid.link/20261021-submit-dw-dma-synchronize-v1-v1-1-6af85c2d6f69@gmail.com

Revision history from Serge's series:

Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
Changelog RFC:
- Add a new patch:
  [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
  fixing the "XFER bit set, but channel not idle" error.
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.

---
James Hilliard (6):
      dmaengine: dw: serialize error recovery with channel termination
      dmaengine: dw: complete cookies before releasing the channel lock
      dmaengine: dw: simplify transfer-complete handling
      dmaengine: dw: report residue for queued transfers
      dmaengine: dw: drain the tasklet before releasing channel resources
      dmaengine: dw: synchronize completion callbacks

Serge Semin (4):
      dmaengine: dw: Fix XFER bit set, but channel not idle error
      dmaengine: dw: extract hardware-LLP residue calculation
      dmaengine: dw: calculate residue in the status getter
      dmaengine: dw: Prevent tx-status calling DMA-desc callback

 drivers/dma/dw/core.c | 284 +++++++++++++++++++++++++-------------------------
 drivers/dma/dw/regs.h |   1 +
 2 files changed, 145 insertions(+), 140 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


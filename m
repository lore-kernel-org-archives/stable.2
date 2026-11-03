Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744777;
	b=NeaFJSLscXa7WPyMZMs4TzexR9cNTuwCfIIJyvAvdpfhS0yGN9d1ZhRLZoSX1Rwvte1X
	 vZeXgk0LSY7F/Xizi/e00kXXdTrI6eVp3cEWsutf2Lv0NpNfNeBBNevo5Bd54VXQtzlba
	 QxvbQZGbDDn7cSH4osWWS+5MjbGt/k1WwUm2/0cGmHfSbOfwSiMDEDXg2FeBBnn6UslFI
	 zQRYVc2YsgxQL7TtiWxgXA0fpNlURC2f4xL6tKMxm0eYuIQK2nFTgbEIsI+lbFqXL8MMz
	 haI8bzwoPYQ9/DWdHYCSpvS/ku9rzUw+UqV2fyta3igsmeZVjDNGU5g9qnbOSM2qUIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Z27hgKYTb2n1VfMFl375pQz709FIUXDNAK7CWpp6XtM=;
	b=MTBVzhOpnyt8wQaxCH7rIIrshgWybW1Mke+AEzuyDamfk3cY0sHutqaJrhIeShVOlTsv
	 1ruoNlN2FAZ/huf7tpTVTo0oZ4/evYWR947vC7TXBnXTdWZ9XcVUyNyZokCA+3HVksnaF
	 VIqrx4xRha63o0lPIMmsjci7gt8blsbk6Dwq9hPS9LFvFg1VoItk4ZISpIApy6Sk8QHqC
	 1tBczL/JK0NyzqH9ka4ryvEbTPej9qweLdjFg22/XGgfQIBcHmwhWZT6CvqeMzwaOVm3k
	 neziIPGn3Q9x9xsluL6S4gdNZTaOtyvWXD9Hk6bKFz6RPSDWax0QWLwd0VyBmInUT1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=um4iDJHl;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CD606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 476CD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=um4iDJHl
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b28d7c729fso87418b6e.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744776; x=1794349576; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z27hgKYTb2n1VfMFl375pQz709FIUXDNAK7CWpp6XtM=;
        b=um4iDJHlTQS1vMCWE+mHQxM9reo7nYH0ZIojAUj6CCPwE/FUhh8O1xOdfFL/p1yPte
         Cvx5kkQVDbdNhhzYV3cIKoBLsSGOysX+NJFFBCLom2uKAVVSO78/de29jIF0sY27QeIK
         oEtopI3AJoZ97LFszpRZm6sAWFlyOjWBIJJRgQQWZjMWru2OpDHgcyzO/5m+Hd4j76Iz
         oF/wqQhIFCrbPNcqieIqwm4YLsF07Jf1GlKPPA+HDXZL3vGtyvmcY7S8oZFEK08GaUqu
         RwDDGoKB9aHF36nH5bnj7S3EWzJAD4QkmNX3lZGtmvT8rX1dBizFiMo8hB0PdhTa8XdA
         g43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744776; x=1794349576;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z27hgKYTb2n1VfMFl375pQz709FIUXDNAK7CWpp6XtM=;
        b=f8gXOsr2/esTyiYwS9nwBU/TelGe0E/Dd4yZCV+810cDy0oSmaEHdNuUnOQytqM1yd
         DhTJKRWF/PrR2yhJLdj/LOoRjq8QzhEEU7A+Hhl5MxtY3/LbSNWaO0CkbPmuHvbyl3L6
         S6P0j9cncZI0duyihXMyNQswdTdstll2NcP0qDoU1MxJ5aUJesH+GEhT62tNzkCbN1tg
         xCXNXNDHIsJQ6I/oHSV9oJ/JBfHegNSiX6P+NclOwTgWouyqBaaVGA6x3IO2E2SGH+C4
         baSjaHMLEiLDf+jHPPaORyGcPgQt4TSIlXnI0FLV0C6UVN0G2bRS2/ZtT18XZ4bbE/4m
         ApeA==
X-Forwarded-Encrypted: i=1; AKwUvBy7QGbLR8RfOPwBTW0IZK9h1cpuLX05FH/cnL1nCn7D7F2jqExQbDdKkd7GiPH1nbBiwxx7/Jw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fRikf52Yn1OWFBsuNKfhBcNliJplTYz515hzI61B3XpQ4ck7/
	F8eC417qs9RlU1Mfq7gxnW+QnNBL8DGfoKLwqUArcpbRqiMozbXRxPOI
X-Gm-Gg: AYBFou3/i7bypl+U/NEwzwkrAIy6VtYColCkZCB1CParHzMs8PfC5cX42Rq3kIXkYsO
	SaHUQjdk0iRigKSfjx28H8iZNcA1TUVEe5cT/suyjVVnOWK7qn2f1Q1PMViKAEzEOPiqX4fxwqe
	5z0GOt9fv3RiJf0dwcCJ32QB98/U2flWgEz8fT8Zeq6676NREbzYgFvSBbr3J/BEr3U6liHjVjQ
	tErZHfqdow22WF955DukLsMOF7xuVxpSezPxX/48c0WRbyGCLO7Aw53qOT+CSxpxdaXcYJ4oSwV
	bbXUfma9UFSjmk4T52VJstWYMPpzerGksnIBeblty7+xO1nx2D/ZI8cwdZq5kLokTGY9MIxQxfa
	0i/OcJFZ5CpcUih0fdVrzcQRvcCvdIW9bXQTORbqcT5DXWEdNQTh+1/lEGvZcft4s/IJVSIJ7GI
	TCcY02VzNg7bdoiHCophcLyer/kXTf0ddagH11S9LNdvTyGxtp+fqFEPP00unNeEahfyXQZgtZz
	nX2l/wao9uW8XJ4HEYYHVTviLPuEKE1I5LXcgtz4kDn3E60is53l744/SV3bpozxgEjumKzWxTv
	VQNWu8K17MmwMVy+lh3vsUpq13KdjLqvdkYx5GSGMi0OcaCZ2QgytuPecp32MXcbiLHrglECBrO
	x22+MuGyd4hzCafRGR4CTt+JqrhuxTjvIDTwrctTyDeZhfNDvqZ5OwDcfIIVD/xhoLNb0C2WSKW
	uVwZhNpqOC/CVcx25D/ndy9ae+BO8EVOJRQMqKAzSxRMhuP04wIfE=
X-Received: by 2002:a05:6808:1925:b0:4c3:4e34:c69e with SMTP id 5614622812f47-5640d919f60mr12985788b6e.8.1793744776144;
        Tue, 03 Nov 2026 14:26:16 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v6 00/10] dmaengine: dw: serialize completion and
 termination
Date: Tue, 03 Nov 2026 15:26:02 -0700
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Qz07EIBAG8FfZcBYFCrT15HsYD/wZWoylBmp13
 fTdne4erL3UhMtHZn75MhdSIEco5PF0IRnmWOKYMOi7E3G9SR3Q6DETwYTmTHBaPuwQJ+o/qR8
 MLefk+jym+A105hSUYkHWwXNvCBLvGUL8uvLPL7eM+6/gptVcJ6wpQG02yKxfaELqYoKH2x5O9
 LFMYz5fG858lf5ZBh+n2oRGOeF10O1TN5j4du/GgaxlZrHFxAEmKKNKSAmt9M40bo9VW6w6wCr
 EnBY2MNkE5WCPyS3WHmASsQBGytq3QTRqj6lfDLUDTCHmK8HqWjXBhj83W5blBwTT5+QwAgAA
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

 drivers/dma/dw/core.c | 287 +++++++++++++++++++++++++-------------------------
 drivers/dma/dw/regs.h |   1 +
 2 files changed, 147 insertions(+), 141 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


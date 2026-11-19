Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104108;
	b=AMZbNxIfKECyuLV2dwEyV+KqFUQBgw+1/CaBe8O/+Aq28VWC3wFDoNgcXKDowTlpffEn
	 ye4qtYRLwqWjMLry7QBa4Ay53xy4FA0QWbZibUtAaaZPeKaeu2frJCZp4bK+aGMebrJ4/
	 N2O4CQ/Yg+kZ7Hq8yOtw8DxBW6jvUrmY1YoGd19i4znMqwsFg92tQ+BFv86l0f2gUlU+Y
	 xOIzupLcVWqcrYgkAhLX3TmlpDosig7TmNrMMxBjTRL6pDq7of4mWzfsvTcx5uS+xQlgL
	 qrue1hnFBuD2+2xzpT5jRSsiuaUW3eOPcl51vE/XHVwRLq5JZ3EzLpKpeD0dNl22ErA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=/ZxPIuLt+/kiepGNuwG64GaZNG5kVNJvtdcH3UsJ5V8=;
	b=XBBbIif/wYr5iTABJZZU96fyc3a+w4PpS2GlD9MEu8/gWHu2iAr7LUKFOb1JmELEL2a8
	 mYgtAGjIkaMajOkQjx+X8qNpyp+kAcSFLjOJw4cMKGE2x2wQeQS/aj1rf2jACl1jaXVNb
	 XbaGQk6cAmlI+LgRig8Ol7xAUP+mqcu0TvZzC+06PzpjYsPz/b446W/ptgrFgUNwwOsIr
	 R8jKeEa/WPi33BD7zXuZpDC4/zhIOwTADha4IUngh4D41wRYHoBmSpuEpp3VwIChd44Br
	 z5zD8ikFtXjCZ4PzXyhK7CnyqCgUssVR8vVyq29M8t0Jips7OX6FUfI/gMPNQRSKMTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tl+HGnHa;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC600606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC600606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tl+HGnHa
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b335eeb340so21734047b3.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104107; x=1795708907; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ZxPIuLt+/kiepGNuwG64GaZNG5kVNJvtdcH3UsJ5V8=;
        b=Tl+HGnHaqVMQ8e83+0+G/PBH9EvpKLU+LRYt+fR2tmuIj5npjpUgDWN0uMm1iEGTur
         jtu3qMfDFHWS/WM0IanTtuo/GppWeWMfJj09pvaQJnm+uBeDpRVk2P+HGsLl6ZfhAd/h
         P0KccTU1rj/57isj+90nFFBY1T61sGV2KEBc1Ok6weaEafrMsNyUrvBBPwU2Bab5STmX
         51ozJWMnx6yHZwAY9PRMAO8jne2OFys70hzmlTCjIANDFg3Jz2i4y3agLUAvi5nfQ7L5
         XT+5Ei+npXDCcCoG7psJ854BWoIijw2SekT/jcGKm94LaVvopkzv67HPbiqkMskeIiEt
         XZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104107; x=1795708907;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ZxPIuLt+/kiepGNuwG64GaZNG5kVNJvtdcH3UsJ5V8=;
        b=eYk9qddRc7+E2FGADxW0KuxS6ZX0hm0OXprv2fLzGhYOYh/MD7dB6IPWSq/ubSv+J9
         F51hQbxarWB1Gu+Zi+UKy0p6lRVGVzRT2Owb7FaIBQp+xcqFiY8wQiwyl3iIpXdKrmlv
         hovtUxk4YYFkHQ593a+/G8UU/xJ5aT7c/6QBLHxN0/c2dLKaIDR5pYOHXqkdWQzyu73F
         GrkL+qoCXPpONx1NyTKo4kLU8ganHcI8TF2W9dUhhmjp/DZs0WZh0ZK9mXgYgs2pJCYY
         +dfSpoBdQHT5CG6bEJeKAxFVTMaeY2zLIdFjF1ze+qq2KvbRvT8JjgEoQeQspPpP5wRk
         Ndiw==
X-Forwarded-Encrypted: i=1; AL+hErEpUEQbndUxU8ZpeWTUgrzWRbuch9fMwK7LILhXslgSxCqhqlPOjBII+k/kcp9RsYUPrL3cE4o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PZcZ0vUUz34/NrD/plZcKia0UzQtrhuUcwoxlFbLhjcosLVx1
	hqrmK33OSb4dgkexzRVD9MSaslZR7OfFWQ/mSqNHqJLQhJm9z2YZ8kjh
X-Gm-Gg: AZFdTZcxp+71jef9rHWwL2Mb1uGRvv8j4P6cLCtXYN+MgfTrdiM5Uu6kYtSndIEN9Ei
	wMCFrshHKD+2BCDXPftDDs0qHbfKgdrgchO6mzVjwdj0McqoB3Qf1T6IsXUwrLck/I/6mtj1DLA
	aAPvALYVzMbdMaxWDwvjpEusdK369RHPMeA/32CAH6Cnl2oozImwYtGOqdKvDFBgkL80bjkeeQQ
	CxLjYmfkoz9tc7x4fZcrJ8nC1Nbwk/6+1lq4wwPhm3KyUdPKi46DnYOsdhkzQNRzHMa0wzGytZT
	SOkFiOY5L68AuUo5gwLTt4oh+nltRuAAFdf2jxF8ivauABObPc22oVCASPx+14SMOC2vljb/3fv
	yIG0gfQ5srkYNOqA8fa6UkblOaweIvx25DJd1vSsM7PmbVEZQd4A63k0Bz3Ppx5N5Rh9cgUG9Ys
	xsDjALtXfkoG2+Fk76i4o5LC8sEzjGFtNkAXSS0OpDtJMLk1PKz/gABQD6ZRHqbohXTqwbDPo9+
	KHpwYQxwCXlDkolll0r+QM+Uyeq8j26Dfog3PB6Qmqy4c2Ik60nB6NsHHlCUqn5yYjVBBh7cR7p
	+3bq/EsciemONG3Pnd4gv7F4qoA4268c7SB6BwgbtiepCmPUHuvK/75cy12NkgSSYWc66/nxhw6
	Il44YF5dD/T0YuXyhyYpwoFt+jQFpuWRSSG+f6e4U6gCPldkZ5//vJO+tgzWIdTsr2uwQYtb3eC
	LETLqTfxZGse6R3UcNj9H9jhH+WvNTJ/zLVfN3xmfdP3aPYpRGAuk=
X-Received: by 2002:a05:690c:370a:b0:8a9:693a:324 with SMTP id 00721157ae682-8b520524d38mr523527b3.109.1795104106234;
        Thu, 19 Nov 2026 08:01:46 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:45 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v8 0/9] dmaengine: dw-axi-dmac: fix termination and pause
 acknowledgment
Date: Thu, 19 Nov 2026 09:00:55 -0700
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43T22rjMBAG4FcJvq5aaXQYKVd9j2UvdBg1Ks2ht
 pPNUvruHScUjKG44JvR4dMI/f7oBuobDd1289H1dGlDOx648A+bLu/i4YVEK1x3IMEpJb0Yzmn
 fRlH+iXhtouyjGMbjSZzieSBxUSIHXRWhQ+VCx8qpp9qutxP+/L3XTLxSHid2WpEi70x9POTdN
 MQLenp/+uEAN+3YNR7q/9+avqhJ/n1//EmRjaesAgUi8/yyj+3tMR/33dTfBeZeWPeAPWdiYbN
 UDHrp6Zmn5Lqn2dO2lpqiT06VpWfmHqx7ZvIoZTAJjC5p6dm5p9c9y563oCNgsuj90nNzz657j
 r2UE+jCsZEQlh7OPVz3kL1iK2gZYi0Ic+/z4TtfZ076eE/lPYA8z+524xx4wmKyS2CzL8pXpY0
 lvq8soDyEGAnJ3LIdx7zjH2S7qVkbbbzUWpZoaw2WLKAKAWtEfnYMiBmS5xY+vwCBwHycdAMAA
 A==
X-Change-ID: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Wang YuWei <1973615295@qq.com>
X-Mailer: b4 0.17-dev

Keep cyclic mode in each descriptor so failed preparation and queued
work cannot change the completion handling of another transfer.

Use the layout-aware channel enable check during termination and retain
transfer resources when the channel does not stop. Preserve suspension
status for the pause and resume paths, including acknowledgments that
arrive after a polling timeout or during another channel's interrupt.

Keep a pending pause across cyclic segment completion and resume the
segment only after the client releases the pause. Track the active
descriptor until completion so queued work cannot reissue it while its
interrupt is pending.

Retain terminated descriptors until their callbacks have drained, including
cyclic descriptors that error handling has moved to the completed list.
Serialize interrupt status collection with channel reuse so an old event
cannot complete a replacement transfer.

Require at least one IRQ before registering the controller. Keep shared
IRQ handlers out of uninitialized or suspended hardware, and drain them
before disabling clocks or removing channel devices.

This series uses the shared virt-dma descriptor-retirement helper [0].

[0] https://lore.kernel.org/r/20261115-submit-sun4i-dma-callback-lifetime-v1-v2-1-fb7d258702f8@gmail.com/

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v8:
- Use read_poll_timeout_atomic() for stop and suspend polling and a
  scoped IRQ-save guard during termination, following Frank's review.
- Propagate deferred IRQ discovery and reject controllers without IRQs
  before registering their DMA channels.
- Keep controller interrupts masked until DMA registration completes.
  Serialize the hardware mask with handler admission and rearming across
  power transitions, following Sashiko's review of v7 patch 8.
- Leave a suspended controller powered down on removal.
- Link to v7: https://patch.msgid.link/20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com

Changes in v7:
- Guard shared interrupts until hardware and channel registration are ready,
  following Sashiko's review, and hold an active runtime PM reference while
  handling them.
- Balance probe/removal power references and drain handlers before clock
  shutdown, including forced system suspend.
- Link to v6: https://patch.msgid.link/20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com

Changes in v6:
- Retain descriptors through callback synchronization using the posted
  virt-dma helper, covering pending, executing and error-completed cyclic
  callbacks raised in Mitch's follow-up.
- Serialize interrupt status collection with channel reuse and clear old
  completion and error status after successful termination.
- Link to v5: https://patch.msgid.link/20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com

Changes in v5:
- Use a positive enabled-channel condition in the suspend-status helper,
  following Andy's review.
- Initialize the resume result immediately before its first use.
- Separate the lock-protected channel bitfields from the preceding fields.
- Link to v4: https://patch.msgid.link/20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com

Changes in v4:
- Add a preparatory fix for cyclic mode leaking between transfers,
  following Sashiko's review. Store the mode in each descriptor so
  failed preparation, error recovery and queued work cannot change
  another transfer's completion handling.
- Link to v3: https://patch.msgid.link/20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com

Changes in v3:
- Wrap the atomic polling calls by argument group and correct their
  continuation indentation, following Andy's review.
- Move the termination return-value check simplification into the
  channel-enable polling patch.
- Separate the pause-loop conversion to atomic polling from the
  pending-request and cyclic-restart changes.
- Annotate the suspend-wait helper with its channel-lock requirement.
- Pack the lock-protected flags into existing padding while keeping
  cyclic separately writable, following Andy's review.
- Link to v2: https://patch.msgid.link/20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com

Changes in v2:
- Use readx_poll_timeout_atomic() for the single-argument status helpers
  and express the termination polling interval and timeout in milliseconds,
  following Andy's review.
- Track pending suspend requests separately from confirmed suspension so
  resume can handle acknowledgments received after a pause timeout.
- Use the atomic polling helper, including its final status check, and
  report -EAGAIN if resume cannot yet cancel a pending suspend request.
- Defer cyclic restart while paused and track the active descriptor until
  completion, preventing resume or issue_pending from reissuing it.
- Reset pause state on successful termination and channel allocation;
  clear stale status when starting a new descriptor.
- Link to v1: https://patch.msgid.link/20261108-submit-dw-axi-dma-stop-pause-v1-v1-0-c48ec19e9ee4@gmail.com

To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Sergey Khimich <serghox@gmail.com>
To: Sia Jee Heng <jee.heng.sia@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (9):
      dmaengine: dw-axi-dmac: keep cyclic mode in the descriptor
      dmaengine: dw-axi-dmac: poll the correct enable bit during termination
      dmaengine: dw-axi-dmac: retain descriptors when termination times out
      dmaengine: dw-axi-dmac: use atomic polling for suspend acknowledgment
      dmaengine: dw-axi-dmac: preserve pending pause requests
      dmaengine: dw-axi-dmac: retain descriptors until callbacks drain
      dmaengine: dw-axi-dmac: serialize interrupt status with channel reuse
      dmaengine: dw-axi-dmac: require an IRQ before registering the controller
      dmaengine: dw-axi-dmac: guard shared IRQs across the controller lifetime

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 311 +++++++++++++++++--------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  13 +-
 2 files changed, 218 insertions(+), 106 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git fixes
change-id: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169
prerequisite-patch-id: fc343480330da5ff95e5271997fa71107977c2b8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


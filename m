Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960475;
	b=NIER6AgZSMOHgs5pMfnuYbOcwL12ATuuzchbC0dmBJjSpmwL/Z2JKEkPZxUEX+H/g3Yj
	 BVuBBBHGfJI2VpJ9HiUIjaFFsvvlHNuWrVy2oZifWbdJsDrU2awQCs/K7I+Uy48AYJ9Hs
	 qdST8b9SsH1YSO/tcgoRsDGr2IMo7mpj033vryJHPsfgzDzL3tpD8E5bUlQ9Kykf+dImc
	 EK638njmNnT5qOH+j4NEtyepJYjKTrgtv0tLBXlszZ92KZS5TnZzH0iQuOEyy6Q0wUil/
	 KzP8XUlGVqS/fZl+sIkIF35q+zcA4gSM8BmErEtRGG0NQj9bAp3sSOMcXup09FX16ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Bl3W5aQMmq5HJBKFRVehRWJZkxZwzzcvP3FrIH0GS3o=;
	b=Z3/Oujhm9PjVifkYf318PjufSrj3MLmcRaDIXGnSQofvs39BpGxfBVfv7ljzJtePZghu
	 RppctyVGxcAz6wS8Bcgzgpq/TgvMvVRG7MUzBJe036jnd9brnWnPSwD5S3p4B2zuY3W2R
	 NsAJzCp4ZZIkcoVgbrsmliy8IrprSYh/tuVPbuatxUEsKGrHakc4QcamqH8fhJCfbT6f+
	 qvsR5mQ4m5JWhbwayNksGaD4teD6SNmIx54rUAtizpZ07CywlcYAZSbBLnk2hDZWVso5x
	 bf8DwitFn5xW+faORAUYvBJRNLWBqWs4In0GZlFvI5hCltCLLPhtWs0QYOPLgAQnHBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7EKJyEN;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AC606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 582AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7EKJyEN
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8629ef8613aso157899a34.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794960474; x=1795565274; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bl3W5aQMmq5HJBKFRVehRWJZkxZwzzcvP3FrIH0GS3o=;
        b=s7EKJyENJzabOd+ChQTSi9RCtCnBOVv2xhr2xygiKRvOXsM3E63Q99mem0WD7wsQu5
         MyYvNZvLkcOAcUpbB6qEwCSa3QzH605tLKPdDafUr9vdhhP9d7HPiO1SwVjl3sf2Vr8i
         ndb4aEPcwl0px777EuqfrGXkoss5/WrbEuAsdkQ5Px14qrnJJIpPylLR/Fwsiuc4of/d
         Wfqq8n0Mda0eOor1SLvcYgwyGUBPYDlhSHvGDfymtX8JYM6qXqdUzX7opzJiG3xPWn5G
         4Nen+EgVHC8K798bb7u145EOg9bPnBdk0ITGz0lb441/AP/jPv5l87PPi4A1u5lVBAm0
         I8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794960474; x=1795565274;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bl3W5aQMmq5HJBKFRVehRWJZkxZwzzcvP3FrIH0GS3o=;
        b=GmabLIVpmMReRZozZOuiGKo3BAhiQTrGl56Oxo9ozoABRHZVdtORkWb8rOwzkr2aCb
         iXvh/oAJ3Jt/vhJSFGPqR93AmfS/gAmO9qCbWGT2oIv5/POvVWKd052rKF0affw3Y4Mb
         SO7JatDHFbO3sOmW03PXfl1cgUmFlUDl9nXoTW22pkTa3M5a8rferrB/kndJBJZ2M6pU
         kUVONSMplVAAbbnIi3YSOfGiVcWxgVIkMg75YIT2vmd3oQvdhwDe9e/U4vKzv7JlS9HX
         PBBNiwhNVvTYbmFmcgH3Lu6j/YHp2yNcGK/Hs/EA798Mp7zkulzzt7IaWTsYQxrCoH8Z
         6esQ==
X-Forwarded-Encrypted: i=1; AL+hErE9zW7Zs48wbvPVgp56gedbvyjXq/i5+hrGm/JObzPo2EQ+nGhrjLfTCO+eNeT4oRsC7OyS1h8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BINN0YUDXNCxwHt30pz3C7gpsoLwNoOaq9VGpNzk1VoxB7N4Z
	nDd3POI8zzAn9bIBWRGyS1sYLR4ij19CSDFG18lIPLqUc2J69jIOEcJA
X-Gm-Gg: AYBFou3O10aplWF0JduGVwclNg5NYtXdnKZUi8achIKcmNfGG3J7OI4OCFtcX4IhUH9
	oDDvJNLN+hc6C2mS2Q9gaZmoQBxVEP7ZCLC4svXwtzVH0/cPVz/ofeplzKWld7um5aNPoHtPY9r
	6lnXMBIrAPD/GYLqkPNhwuMvefcdVJRkHRYBESFAnM7cTjOg1JNvxN52wpKORDEd9+LjyAX5E83
	WugnjQtV2Ow+cJKBIdZahHDmlMh17j8SqGBH7p2R6ZWIyk95oc3yIfU0P9lbG9j29UQ9fqpkunT
	u5Lp3AkKDskVPhaBbXdKt1F/F/I8FFd0DpN9IMbNYue2lIWqoYS96S7R5xH9e8G1SqE0uSrw66h
	NLCZI7Aih9AXtrsYWoP8tWzdDC7pQuYq+dqHV52msiwWEioFimMa8HpYPY77RxatWxx3H2cyX6H
	GJZXwLqYD+nVFuZEuMLRf0tytUZdwaxgfkZqGl2HGS6G5k5XeMb+BLw7V3JxWxRQN8ZUP7A4vBu
	/Ea5Uw84eWYCkYA6OcEvavWQlawgh+vSMKwME1SQQaEj/1/7VHHm6DTlJaGJH7xrzEMYAS7XOoX
	4/hW+Fvb85j6zm8aDIQGl3zJ/YwOt9CHPt4tPqhzy2MF5t+5V4EKDcHS5/2uEIZlgcaLoZnacCW
	jM/BUHbqzOkItFPbHjb1KOKIYraEja/3C53r1HLYV4aQTZe9I30h66YArRItNSvX20Km+oGzGTD
	DWlcsr0GYyselpASLHGBJNR8nw7yx4yLmeSmHmy9tICittBB2DrS8=
X-Received: by 2002:a05:6808:1304:b0:4f5:eaac:5151 with SMTP id 5614622812f47-5774181a19dmr1349662b6e.39.1794960473879;
        Tue, 17 Nov 2026 16:07:53 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777b393d40sm434954b6e.17.2026.11.17.16.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:07:53 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v7 0/8] dmaengine: dw-axi-dmac: fix termination and pause
 acknowledgment
Date: Tue, 17 Nov 2026 17:07:39 -0700
Message-Id: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Sy2rDMBAF0F8JXketNXpn1f8oXegxilXqJLUdN
 yXk3ztOKBhDccGb0ePogu+16rEr2Fe7zbXqcCx9OR5oMNtNFRt/2CMrieYKatCc15b159CWgaU
 v5i+Fpdazfjie2Mmfe2QjZ9GJzNFow7WrSDl1mMvl/sLr22Mm4h3jMLHTieDpZuj8ITbTEh3o8
 PP5jwf0dKMptNR930OPfJL/n4++mkVpMXKHDlG+7FtfPp7isa2mfCPMPbfuAXla+kRmysaJpSd
 mHq/XPUGeUDnl4G3QPC09Ofdg3ZOThyGCDCBFCktPzT2x7inyrALhwQRlrF16eu6pdU+TF2IAk
 ag2Nbi5d9v+9uFMzRweLXoUhvbJ3W20BosmyagDqGgTt5kLqZDy1Qm4Bec9GpT3LvohNlTo3SZ
 HIYW0tRB18ipnp1CB4c6Z7A39JuOMiRAsRbj9AEzkafkkAwAA
X-Change-ID: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org, Wang YuWei <1973615295@qq.com>
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

Keep shared IRQ handlers out of uninitialized or suspended hardware, and
drain them before disabling clocks or removing channel devices.

This series uses the shared virt-dma descriptor-retirement helper [0].

[0] https://lore.kernel.org/r/20261115-submit-sun4i-dma-callback-lifetime-v1-v2-1-fb7d258702f8@gmail.com/

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
James Hilliard (8):
      dmaengine: dw-axi-dmac: keep cyclic mode in the descriptor
      dmaengine: dw-axi-dmac: poll the correct enable bit during termination
      dmaengine: dw-axi-dmac: retain descriptors when termination times out
      dmaengine: dw-axi-dmac: use atomic polling for suspend acknowledgment
      dmaengine: dw-axi-dmac: preserve pending pause requests
      dmaengine: dw-axi-dmac: retain descriptors until callbacks drain
      dmaengine: dw-axi-dmac: serialize interrupt status with channel reuse
      dmaengine: dw-axi-dmac: guard shared IRQs across the controller lifetime

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 260 +++++++++++++++++--------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  11 +-
 2 files changed, 190 insertions(+), 81 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git fixes
change-id: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169
prerequisite-patch-id: fc343480330da5ff95e5271997fa71107977c2b8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


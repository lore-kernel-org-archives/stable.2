Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA62D2394
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039946; cv=none; b=SgrFoy1UdYW95bc3K6WDCkYUmkiBlNR7LJVQasEXCE5opyLaBIrZ3+FypXj7mZ+2D1gEVCudf1mxosC+wpag3D14jmzfobvXyhKmNXEdiOFATl5BR+ooOIjn4WZ+U6Aa2E3v+TyNRqIpdJ6riPghX+ej0Jb61kxG1oZ5ZioEo6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039946; c=relaxed/simple;
	bh=pZcPqmI0wKjjQYdTGXbl3f1Xv9J+0KXIB9pJxbsR8+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kr2OyB4JUXMPaD8N5/6ozdcU/Nh8wc9epoPgNT1zHkBIDXaHmbRFM8uMoyxUqzayVSubehun4lA9KR5RSh1HYKfnCfVOidJM1tTpwEevjwGV2BQM5HJcufqXKQaDTD1pZk4+DwaGrjybpB6tNJkn+0gP0cHJ9ylqO2xIFFDtID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=DVMcbKsI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="DVMcbKsI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e915887d9dso17132475ad.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792039944; x=1792644744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6H2Mg08LBrKNkGx6ANh2AzhZuIGv+IBNWXSBQcbv5VM=;
        b=DVMcbKsIIr9uOMdtE5Xc3rTPJ5+QL0BsS58LHOX6y3IVumwLdM20xqMDXdMpdwo1nR
         Xna38msfGXl9MN+NGOkXckoHFJcPppeiZXqrKpVJ2bWwkxB9ML8Ms7+Tk7D0vo9GAuVz
         wOJ73IK48tcpVq1uc9b+h7vdUjPLRqM/iKcQNsXL9v60gFfo5eHDuP3Uvc+2yqhIkVD7
         G+VyXAMzQRhoRyp0+nBm5sfNTSjHYQNl58WPjk2IAyYJs1VrkNYZdisCLI5XV9zSo12A
         QGQZI3AdSMCFeoYBX8kOJvfPsNXfjlnBaTW7JgYBDO+qNwkyIvrFSKv/H/EyLsNWXNfh
         SLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792039944; x=1792644744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6H2Mg08LBrKNkGx6ANh2AzhZuIGv+IBNWXSBQcbv5VM=;
        b=O69f/6U11k+Aln6oaxCShu/CYAxduJx2sMBC549Of3uS9uvYmWPnk0OotbrNCtM4f6
         c3x+YpBIhfwDYYXo3d3Gj+tAwIo/waYNUUcd8cnODmSg+tKkotsgZKsTM//DN01EP71B
         9KbWaVvS7hfbM1ZjhDPek+EFDB0KSvQDiEc6zryz796IM4a2bZ4jWZ33qcB36/XZioP9
         874iseQk029d/jeiJ+rGj+r/Y3MTPqVW3PqdyWX8oes7kFU9xpBMZG4bRNLDzYqGNz3i
         wW1x8DGPMcXoCNhOV2RBH0NDzM8AedUZU3WJJVHzU3A1Bl6bkyAgQ7b5BJCjB8AqJwYH
         gSKQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9IZ0wFKK8fsdUAkGFpHwln3XUOb5E2IVFtFg5dB4Rq2MCEVZ728EBfoDi/F/FYIM6WpUFSds=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDQWpFPGW6VtY9ZZkYDYgBMTCuxWk7wgOKXSkpfGOgT9/N7eXM
	zAazjiSYRsFdnzs4mGTpKvjIFb6aguxBj16wHy326r4mDFC62SpOUnPs1xXtrQaXETE=
X-Gm-Gg: AYBFou0tGUHHGpltGmdspczZAzOuBJ+SS0lOIlUMzVymzmSEYYkMAm99QGp301VVEqe
	RzAtpz6ejJAwcN2ABWjW13jqFXOKea3uqe/STWwEE6MW7mEzwhzd7ha0mr4c3BEgltUDY42wmVI
	v5Qke6EzLlbQDdZj9o4k0QK+BzADPVXSil4/m48MKdbiFIJARQimTzAKVwTF9OJNnsexq8cp245
	VRGMzQ5Trc+Df0ut0b7n6CESZJr4iKaguj/A6La3LCGjupmtH3kkKd5920xrX/dxT/jC2tjDXDu
	+cXOq3TklpVCWs5004abtPmnLVJ1zCeZ3p50TazP+L/BntdOSQHGqQ4KZlP2Kk8FY/VZOrs+mcS
	wmgtmr1K/0PDlDpcknAA8XPf93w+AkMXKvQDKeNyYUP1jgnyVHfnhteH1sae3QLijPzuCVRiHDE
	IqcrcPOqEGZegAAL/kM+2r+TgVe5+YiS60UJJPPqsqU7OOGdCrBYnApggiKu0UQLY//snFdGgaz
	IC81Q==
X-Received: by 2002:a17:902:e744:b0:2e2:ffcb:87a9 with SMTP id d9443c01a7336-2e842ab6aaamr150097475ad.24.1792039943631;
        Wed, 14 Oct 2026 21:52:23 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e962a4dfbbsm1615915ad.58.2026.10.14.21.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:52:23 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v9 0/9] scsi: mvumi: bound the values the firmware supplies
Date: Thu, 15 Oct 2026 13:52:04 +0900
Message-ID: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This supersedes

  [PATCH v8 0/8] scsi: mvumi: bound the values the firmware supplies
  <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>

which can be dropped.

Patches 1-6 and 8 are unchanged from v8.  Patch 7 replaces v8's 7/8.
Patch 9 is new.

Everything the firmware writes reaches the driver either through the
handshake page, through the event buffer, or through a response frame in
the outbound list.  The patches follow that split:

 1  event buffer: param_count and sense_data_length index fixed arrays in
    mvumi_show_event().
 2  handshake page: frame_length drives the checksum walk, whose counter is
    an unsigned char, so 256 or more never terminates.
 3  event buffer: the hotplug bitmap size drives two walks with nothing
    holding it inside what the firmware was asked for.
 4  event buffer: those walks cast a four-byte-aligned bitmap to
    unsigned long *.
 5  handshake page: the entry sizes and max_io size three allocations, the
    list depth drives the ring index, the device count has to fit the byte
    mvumi_build_frame() gives it, a reset reports all of them again without
    reallocating anything, and every field is read once.
 6  response frame: the tag indexes tag_cmd[], and the value that is
    checked has to be the value that is used.
 7  DMA teardown: mvumi_delete_internal_cmd() rebuilt the buffer address
    out of the command frame with a shift that cannot produce the upper
    half of it.  Rather than widen the shift, keep the address and the
    length in struct mvumi_cmd and stop reading the frame back.
 8  outbound list: the 0xff the driver stamps over the tag of an entry it
    has consumed is a tag in range once the firmware asks for more than 255
    commands, so a stale entry is no longer turned away.  Stamp 0xffff,
    which is outside the u16 tag range whatever the firmware asks for.
 9  handshake: nothing bounds how many times mvumi_check_handshake() will
    answer the firmware, so a controller that keeps the handshake going
    keeps it going forever.  Count the steps and give up after 1024.

Patch 7 is what the review of v8 7/8 pointed at.  I had sent that as a
one-line fix to widen the shift; the review asked why the driver reads
those fields back out of the command frame at all, which is the better
question, so the read-back is gone instead and the shift with it.  The
truncation is not reachable as a bug: dma_set_mask() moves only the
streaming mask and nothing in this driver raises the coherent mask above
the 32 bits pci_device_add() sets, so dma_alloc_coherent() never returns
an address whose upper half could be lost.  No Cc: stable on that patch
for the same reason.

Patch 9 answers the review of v8 5/8, which said a rejected handshake page
would leave the driver retrying forever.  The quoted reason was a
"before = jiffies" reset inside the DRBL_HANDSHAKE_ISR branch, and there
is no such code in the tree -- mvumi_handshake_event() samples that once
on entry and times out after FW_MAX_DELAY -- but the outer loop in
mvumi_check_handshake() really is unbounded, so that is what patch 9
bounds.  It does not touch the doorbell writes or the HS_S_ABORT store, so
the FW_STATE_STARTING restart still works.

Two points from the v8 reviews I am not changing.

Endianness: the driver does no device-to-host endian conversion anywhere,
and these fields are plain u16 and u32 used natively throughout
(host->max_id = mhba->max_target_id, tag_pool.size = mhba->max_io).  The
new checks read the same values the driver already consumes, so they
follow the existing convention rather than change it.  Making the driver
big-endian-correct is a driver-wide change: fifteen multi-byte fields are
read from firmware-written memory without a conversion, across the
handshake header and page 1, the response frame, the event and hotplug
records, and the inbound frame fields the driver reads back.  I will send
that as its own series.  Patch 7 takes the SGL fields off that list, since
nothing reads them any more.  On a big-endian build the base driver
silently accepts a byte-swapped device count and scans phantom targets;
patch 5 turns that into an explicit probe failure, so the behaviour there
does change.

dma_rmb(): both reads of mhba->ob_list, and the memcpy of the payload, are
reached only through mvumi_receive_ob_list_entry(), which begins by
calling mvumi_check_ob_list_9143() or _9580().  Both of those read the
MMIO copy pointer with ioread32() before returning, and that read carries
the architecture's read barrier, which orders every load after it, so a
dma_rmb() further down would be covered by a barrier that has already run.
Making the tag the thing that is ordered against instead would need the
controller to write the payload before the tag, and the tag is at offset 2
of the response frame while the payload starts at offset 8.  Nothing in
the tree states a write order, so I have left it.

One more thing I left alone: the second hotplug bitmap starts at
bitmap[size >> 3], which is only self-consistent when size is a multiple
of eight, and nothing in the tree says whether the firmware packs the two
bitmaps bit by bit or aligns the second to a byte.  Either reading makes
the index wrong for a size that is not a multiple of eight, but correcting
it one way breaks the other, so patch 4 keeps the existing numbering
exactly.

I don't have mvumi hardware; these are reasoned from the code, not
reproduced on a controller.

Yehyeong Lee (9):
  scsi: mvumi: bound the per-event parameter and sense dumps
  scsi: mvumi: reject an out-of-range handshake frame length
  scsi: mvumi: bound the hotplug event bitmap
  scsi: mvumi: walk the hotplug event bitmap a byte at a time
  scsi: mvumi: reject handshake sizes that overflow the list allocations
  scsi: mvumi: validate the response frame tag before using it
  scsi: mvumi: free the internal command buffer by what was allocated
  scsi: mvumi: stamp a consumed outbound list entry out of range
  scsi: mvumi: bound the firmware handshake retry loop

 drivers/scsi/mvumi.c | 264 ++++++++++++++++++++++++++++++++-----------
 drivers/scsi/mvumi.h |  36 ++++--
 2 files changed, 226 insertions(+), 74 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0


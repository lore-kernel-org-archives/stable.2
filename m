Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D9514769
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991172; cv=none; b=QKPgRfenICZToF4Dh1qDdQyTpgSKKGqoojTpgFUCFB5+1uXcCbu6IcDcKDfQcURns3xbqmi2P0wbH9uZ0QMSRzgojtw3ZtoqjrX7mldla54A2DaQGB5kapZ9/d/1mpogg6F5RuD3By/ki02p5toD941BoBhO1olRGOiHfUVCAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991172; c=relaxed/simple;
	bh=IFyaKeG8PqcZmLWzpXkqwho5yu30vxmgLPrGWSAnX+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oF8QnGCLL8nwYu37wWxHsGEvbxiIi+ba4bccFIi4TTV0dlZXnyRzrpyHPGFr09urIN7CL4KYX6Ju6Rw37EvzNFOrcQBFPSKksWNH/62mfNa4AAWRgQ9bR1gMMsl0ahwZFenoSiPgmpm7Lk5tHm/XBHogLItEM68SVYlcmbGBh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=QQEf+RdE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="QQEf+RdE"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so2332838a12.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791991169; x=1792595969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=srFWpE+TVCETelKCcIQxO8OekNsEmjBOESyjztjbwL0=;
        b=QQEf+RdEyeOZ39t8l7ub8jwhe/seu1fPHTnXH7NSaazUSTElQC7ErzsJz9uYchSKeD
         9o2pctw9prhtviu2ZFUL5pyqKS7Ve//Tt/pfg56pW5mGJTxB6YbYD/58X3ZZCgDCWsgQ
         99DXuz1APdPiyXjxX665vpdWJOfX+YkGWIWVFH1XqJ23poL21pDb0hHbRM5eEM5Aq6X8
         635UuRa+exUDQxNG0wtfO0CbIAy2yAy8kr15KyHbomQf6ym5otZlIXHyC15217i72iOq
         R7nDqMICimvb71VvZJD6X/5TIXd7F4jAOSDswaH75dLQvSkqTEpR6usMj6m0BUZ+quTG
         Hfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991169; x=1792595969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=srFWpE+TVCETelKCcIQxO8OekNsEmjBOESyjztjbwL0=;
        b=PcnP4a9rbdGn75HjW+lUvPpX7imeq3T5Et6yAIuGaqqGIWCfPyyh5rU25wnJYdW/4b
         NzXTTgXFXMOe6R0yKUovBKmQnzvLxGQJz6x8YJ0xx5let7NL39Bx2+qrWFYXDsmLBkM2
         ePl78mSSBG0eYuqiaJpkHuIUCWH+EuZg6TSXaq+BpUhaHiJ9cvJWzF+VD8VZmgBLVGop
         H7ZVRqGjdZpDKVJVIJUN4qvFy1MOKcoiG8GCtRsCWufMc3ZVM89+tQQJGsrcu1K6Qv6Q
         Q6ucV3FayJM6zbhuDbLBOjbEJQp2h6A0XQ6B3mD+H+h5ZeKjx0Wm+j9zmOc8mLGUd+2r
         2Srw==
X-Forwarded-Encrypted: i=1; AKwUvBxMyQ9+/cQEFyNWuBnWa0csEsPoFnrNkx1jdESz0/kdWk9vMLM+2pKr7LydUYalp0FvxdVLHmQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdQjwY+6sVmnwJIfSh0D7/XCAM5C0iRqRvu5bYTS0HdMvt74vA
	eZhDUwPJftsR/zEUlUEJ1W4Sjo0WJfeMlfXUvbrF+canKaVF09G1z7wmMpsIKgPPMF4=
X-Gm-Gg: AYBFou33CG9zEQhpRKZ1sBIGIox3KTXHa6+WPWEtAdEfNTFR09SP5yHrufTFqaBDASa
	k4PO+MYh1A8+8ToZOdrOSu1UCr4UfuRm9Uo8GqeX3cyLds0Prle7aXWzkufcZLEUU0sCEXKXEHT
	Nvs20NaTcYGO6mjVjmQnCdwgG+BFBd+/j9abR+uigw7qYan1k8oOHFub5CM9U13FKWh1V5/RHuw
	FU/5q9SNQJgLGvpeDmosxj6xAy3U8hbehdtKEI8+4VgfDhfSJ0d2VGLkWQeXyi5+QTNn+aYHTQ3
	j4+nqI7LhJqY3i1RjOas6LbsaOFBnAYahrM4tl+d2N3EImSbgz/TWsd7MtbSWLWrvQODlcwmhWG
	AhV8aKcMu4JEUEm2xP9aFltPDbBhxRIdT2hZsst/LkUmfHtb0Q76FQ6fcx+0TC9Bm6g1N4j1YJ7
	3l0gYVN++w13SkkxypvRRX1EniDpMSr7AObSGwevSZ6Le5oljBXYLxl05xPVkcLAX4g38/MZogl
	hRFmOy9UfAb12nNgP+AFTtpCBNSFbw=
X-Received: by 2002:a17:90b:4b:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3ab3ac59383mr12662310a91.47.1791991168762;
        Wed, 14 Oct 2026 08:19:28 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac8d40e7f3sm622450a91.5.2026.10.14.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:19:28 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 0/6] scsi: mvumi: bound the values the firmware supplies
Date: Thu, 15 Oct 2026 00:19:08 +0900
Message-ID: <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This folds the two mvumi series I have on the list into one and adds what a
full pass over the driver's firmware-supplied values turned up.  It
supersedes

  [PATCH v2 0/2] scsi: mvumi: bound two firmware-supplied lengths
  20261013173145.3412863-1-yhlee@isslab.korea.ac.kr

  [PATCH v4] scsi: mvumi: reject handshake sizes that overflow the list
  allocations
  20261014134104.3528958-1-yhlee@isslab.korea.ac.kr

and both of those can be dropped.

Everything the firmware writes reaches the driver either through the
handshake page, through the event buffer, or through a response frame in
the outbound list.  The patches follow that split:

 1  event buffer: param_count and sense_data_length index fixed arrays in
    mvumi_show_event().
 2  handshake page: frame_length drives the checksum walk, whose counter is
    an unsigned char, so 256 or more never terminates.
 3  event buffer: the hotplug bitmap size drives two find_next_zero_bit()
    scans with nothing holding it inside the 512-byte buffer.
 4  handshake page: the entry sizes and max_io size three allocations, the
    list depth drives the ring index, and a reset reports all of them
    again without reallocating anything.
 5  response frame: the tag indexes tag_cmd[], and the value that is
    checked and the value that is used are separate fetches of
    firmware-writable memory.
 6  handshake page: max_devices_support is a u16 and the loop counter
    mvumi_flush_cache() compares it against is an unsigned char.

Patch 6 depends on patch 4 and patch 5 reads better after it, so the order
matters; 1 to 3 are independent.

I have no mvumi hardware, so none of this is tested on a controller.  Each
patch's reasoning is from the source, and I modelled the arithmetic and the
loop bounds of every case in userspace, including the values that should
still be accepted.

v5:
- one series instead of two; supersedes the two above.
- new: bound the hotplug event bitmap (patch 3).
- new: validate the response frame tag (patch 5).
- patch 4 also rejects an entry size too small to hold the frames the
  driver puts in it, which is what made the max_sg subtraction in
  mvumi_io_attach() wrap.
- new: widen the flush cache loop counter (patch 6), which answers the
  review of the v4 posting above.

Yehyeong Lee (6):
  scsi: mvumi: bound the per-event parameter and sense dumps
  scsi: mvumi: reject an out-of-range handshake frame length
  scsi: mvumi: bound the hotplug event bitmap
  scsi: mvumi: reject handshake sizes that overflow the list allocations
  scsi: mvumi: validate the response frame tag before using it
  scsi: mvumi: widen the flush cache loop counter

 drivers/scsi/mvumi.c | 156 +++++++++++++++++++++++++++++++++++--------
 drivers/scsi/mvumi.h |   3 +
 2 files changed, 132 insertions(+), 27 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0


Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EDF3E3D95
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224569; cv=none; b=X1Q8q8nijl0VqCyxMFq8tDfwR2prUKdAvgFt8ITO1d7s4Dq8MeF0/UPZ14dRZYyQAFabqwzHWBXaGP7TRDLlCnSOhevz6sZ3HC7kP73pBvw2wQhNCAWNBavO0psRx+Xkft0CcseWACniWZkzn2EXRBPw1HZA5CyhX32vQvXpboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224569; c=relaxed/simple;
	bh=B2/If2I8PT0MSdA8a4FuUWeodlBgQY7ugY/SpyNFLlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQ3O5mQhCrQ5GNHHNTGwPKPk0RZWnaubYztDXHaYj27KsSTf4enSeyNPa3zPvDVUyC7NwN1FZ8vZZccBBH7G5X+WlchcPq5lBieycyjaEedMgJbXq5M942fvueHXArbotblqs88NqoeLLBOD666jOCXyMICkwMSSRle+GcWsjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqW2n1pg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqW2n1pg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so2118629a12.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224567; x=1787829367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yAh4nZneSYIANizSSGNJIh+YCcQ7YFBZyVxQrfrQA4k=;
        b=hqW2n1pg31AI0Amj5etSUQUPtbuE+qKh/x3SQcWiBiBC8t24HnPp7xKqBux7wX/riP
         np2uFwQcAlaY0IhbfOF9z5cnzYNzON1vlsCnmVzg9OHZoAWQmSCGUoKpGn3zJGiO2On/
         8esrPHdCn3N7AUdxoQdorvTy6d9UXN9mMmYPJmZmPGmeuQegfck0Pgnuo5cJOWuhDb3Z
         N+PyKwy/LqYF89lpxoe7uG7NVmgTrMolpkzeTEEnY1fgnq5J6PjCu1qh5lL1h5w2i74I
         VnHKTgBFHWtRm0pLneEK5FZBb5Ok24+PmGJLWatHWx5y3RBNJsNTkeyjfe1pwqMyQxzT
         /S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224567; x=1787829367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yAh4nZneSYIANizSSGNJIh+YCcQ7YFBZyVxQrfrQA4k=;
        b=BB7JMQ7lhXgVvJT8nGIbpbQ3aTaY56rKqOpmOiZu1krZjBO1z7FPOPtdvrsjmsYQwI
         Ih5nVYoNsn5rCdrsdQHKwPeZpSjNoh+1CkhBD7YJIJYLnIWkabd4rPvzNA5yyUvdJgXs
         qx/B7Pg7JFcOu/HjxYUHLBlje5N3tcYzeYt0cUXxsYz66cTapfGaxVaA3fG707PHyf9g
         8fZVmIgWrS3rLzDfl0ODY0OgCCg6DTQ9xZzLR8gXB1xm9e1MhelWN12r/lqG3vSZLqpb
         C3PM9dxBEHL+PGfRafgHVVYRfPeWBYbRd/64FfTf57s2GRpZDph+7EHe0107AP8TlENO
         A5EA==
X-Forwarded-Encrypted: i=1; AHgh+RqEPA1pS8FTqJ957K4AXHFtZDy9LBe9LeZakej5pGdQTaRexy2SmGwPXbKsN03zT7BRKWdqKZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8gNPTyC5qfyt8LHvSd7TgqYCQPi7th9UsRG++bf5C188iM29
	Ou8jtZeSqC12W13RdxpYzxd7SVraeWxBwevQsAYVYtaDXqIqZBRTOUNsxPCk5huW
X-Gm-Gg: AR+sD13XYB2H1tshxBWuCQw+Xpytbn1QRssICrmxYqsFK0a6slmtIsGsf6CLZScA8or
	SunfGOTgEuEiBr3zEHD/oNehkNEIf95PzmelYgGVKJLLSTiiaTJNZ59zofToAVuzaNNgYaimE03
	ah771zI9wz1gVqeaKc2cFAuUbKxStU9tKilGLuvIWf1ML01WLiKQ4Nf/lLWCC9c9lljNRubz3PZ
	E4fPcwC2OqBqvCksr76JWH4gVkS9wC5UwWIF295HujxiXnuhJraKEKRt9nxbhK9fBfs6uSDApGM
	hmhbnVnMnebNz18Co3C8dxY0GYvUtGxobFpQ42Vgm2tnhqtCpyMPl6I4FA0euGVrI6lWcaJCi+6
	+Nrc8dyaVgXK8np0JU1pa8BMU+LdYU8Ev/s2sSoOfzHt3pKxx1G+33ZYecZYwl3nYua3uC6KsID
	eYfCzEB0Gmdt+I4TM4bojmxFEISe2uvS1ltKUqzYg3UjSyKwrDEbkS0rwRqgjM6ecywe0xpqNM1
	aF/5e3wCKhkCDowaXrPos69QX5julWN48ZSbmzEFtzjOFJPM58Soth59OTKqpzW
X-Received: by 2002:a05:6a21:99a3:b0:3cc:faf3:331a with SMTP id adf61e73a8af0-3cd011b5342mr21398409637.10.1787224566967;
        Thu, 20 Aug 2026 04:16:06 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15cada6fesm1236455a12.27.2026.08.20.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:16:05 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 0/2] HID: intel-thc-hid: intel-quickspi: two DMA buffer overflows
Date: Thu, 20 Aug 2026 20:15:56 +0900
Message-ID: <20260820111558.475304-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two heap overflows on the QuickSPI receive path, both from a controller
that declares one length and sends another.

The first is the DMA landing buffer, sized from the device descriptor while
the THC DMA rounds its packet size up to 4K.  The second is the GET REPORT
response, whose length is checked against what the DMA delivered and never
against report_buf.  Each has a sibling in-tree that already gets it right,
named in the patch.

Neither was reproduced on hardware.  Both turned up while working on
commit 035ec4a71cb8 ("HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
response to the caller buffer"), which covers neither.

A fuller fix for the first would give thc_rxdma_read() a capacity argument,
but that changes a shared API and touches intel-quicki2c, so this keeps to
the driver.

HyeongJun An (2):
  HID: intel-thc-hid: intel-quickspi: size the input buffer for the DMA
  HID: intel-thc-hid: intel-quickspi: bound the GET REPORT response to
    report_buf

 .../hid/intel-thc-hid/intel-quickspi/pci-quickspi.c  |  9 +++++++--
 .../intel-thc-hid/intel-quickspi/quickspi-protocol.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.43.0


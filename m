Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F630D3E5
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904349; cv=none; b=P1YtrjtydAU4xdDhmBMMGb9PHDboyCnJNOTrhQGq+d3X/MeSt8b+xFVx3xlm16+IkrQzoH1rl3XNoLuw/faYTg54RrArZuEL8KA49PJekPN4PuM46wU3Zm9QckgFByWGfRdQAytWqo/LOVQi5P4YW2V5AenJ4OVwto51BFabz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904349; c=relaxed/simple;
	bh=kZI89yOlXiYsDvofh/WtTjLUnb7HWp10I4jru0/8Jh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmLnonZl3XWKb/O3BIT6dHui3Q0zjmUBhWdz8ilc03FBL67WNecTy5FTaGQ10h2F05fX3NvHmmfhpCxNrWFNNEkvNz6HFuVPpgfu1ULEU1W/EpRnlwdRWVDcirLhH6aSLnTpd/7Hk+V98f74bqPK509sJVrE6yTpuHeDQm3bZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjGvvrKb; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjGvvrKb"
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-81aac23195fso949004a34.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 18:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790904345; x=1791509145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hA/VQ66U6s58Eb4wx5IlG71m91D/QLj21C8n4BUEC5I=;
        b=VjGvvrKbYuSgCoQLDo2Ac99IUdt0hcCqqpGCUoN0mp4+HAP4YAcHDgvktl/axyDCaI
         IMlvaBLmlO9y/IstlcHfqo6DR2TgxqWYsMYpF1S4krXQ9I4MQoGCLGUnq+p7Z/HqraRv
         L+UIHDPvo8jnSgIqoZAVjLpkOnTB5VzkMCH0hNGHHKaq27/5Kv1fsfto5vPek6oiOBFc
         iLJYZRwxiruFD5WwbEHZ2RUR5HDLDuAcemS5UdwTL1/YFlXJEbu1u/6lNEtaupCTV721
         wVal2F45jFphfAB9LDBRrUvDqGGmOwHhVeOeBhnlYSxS+NszFYwT+eSZDPZE+g0KG+iL
         ISIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790904345; x=1791509145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hA/VQ66U6s58Eb4wx5IlG71m91D/QLj21C8n4BUEC5I=;
        b=bMVgPwuq6ojkl/Sn/DCZ1qMWSraBxEJSBLXB5zovg4CUUf9IYKQ8nKclisakfruYzG
         CsCSm0xo3DJszYjqvUBuPUwMYx+pcn4gJ7klHMGyuuJAgUXfxtPpVOo+3bZFyFr2QR6F
         awvMI2e+DfCVfcGGBVTWRWIsUPUse1eSTxTduKn3TrBFSKLZI59BUjk6hBxnTtYf+rLW
         yxj6IIxb1snjyb6VIMXDYNPhcZSoKT8bVRL2qBwx9LO36n5mBKgekvKWxjccnb2FI81u
         eOEyOvg3kSzCd3lDkJ706LTYmhHfSluyuYpduh+Hsj5lWd1SL9bKWnZD19gpOQBm2uQZ
         Yq5A==
X-Gm-Message-State: AFuF++mQYhP/nUyv3V5Yloy2QoHSgL3hnbveEYB6Zb7un9H6HoUAlKRu
	xG4Dl0HsN/VkoiCUZ9qfa32s0AV/LKPsiC9OkQpug1Cjmsc+ssdhE3brc68d9onKvNU=
X-Gm-Gg: AYBFou1lFbdlr6pADzkE1kE5euzAdzt1cwmq2O6KQRXZKLo2e/UwPyIbB2GcGADYLcE
	P1C9kaTV6xE0Oz9lEU4ETuabY0gWqMgW+bnia4jVXSJFSGGWbefpWro7VNic3JVandFZV0BY7sR
	2ft3lbsWvKZ3nivxEt2unSTm+KIhrCc4ECgsr9RkwFrjI5hoA54rOztAQnbkJoTViclcY4pxgHe
	fna0T953nd4BquoB3BYViwWzrBEsC42TziGoXtpWvrYrHitCvg5DyHYBHizIVikPsjiB7ozVobQ
	R3ZuIbnFcgP5+yHqqoOhKGFGQAbbsqgyRGWZKQyFbTWxF5JubtYsUjXFKm1TNEoEGxsQ9u/gMKv
	IvRucpjV2G+xqsZu4o8aAmrBv3H5cfQ4hF2nnmxKq8Eoxbi7prHU+5ZYZIfhGYZtEwhmc1/32cs
	zuYm/4xl56Lp7eHCI6pIANRmnk/kwIrWyxPadkdIoV1JilT+5n+kw6kEW2jrgOi9L3utxboxJv/
	MBFaexltrgUpRTCqoLyYskSCcpv79pKSayLmD9nclCcxlpVGHDYnQ==
X-Received: by 2002:a05:6830:4107:b0:805:98ae:2160 with SMTP id 46e09a7af769-8228147557bmr2111785a34.2.1790904345564;
        Thu, 01 Oct 2026 18:25:45 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a86abbesm1749053a34.24.2026.10.01.18.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 18:25:45 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: stable@vger.kernel.org
Cc: Tibor Harcsa <silurust@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Please backport dc16388d45ec ("Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table") to stable
Date: Fri,  2 Oct 2026 03:25:42 +0200
Message-ID: <20261002012542.473669-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

please consider for linux-7.2.y, linux-6.18.y, linux-6.12.y, linux-6.6.y
and linux-6.1.y:

  dc16388d45ec ("Bluetooth: btusb: Add IMC Networks QCA9377 to quirks
  table")

It is in mainline since v7.3-rc1 and carries no Cc: stable tag. It adds
one entry to the btusb quirks table, beside the existing 13d3:3501 entry
that carries the same flags:

	{ USB_DEVICE(0x13d3, 0x3503), .driver_info = BTUSB_QCA_ROME |
						     BTUSB_WIDEBAND_SPEECH },

None of the five trees has the ID. The commit cherry-picks onto each of
them and btusb builds with it on each (checked 2026-10-02).

Without the entry, on an IMC Networks QCA9377 (13d3:3503) in a laptop
running Ubuntu's 7.0-based kernel, the device is matched as a generic
controller, btusb_setup_qca() never runs, and it stays on its ROM
firmware. On that firmware I observed:

 - "unexpected event for opcode 0x2005" during LE scans, as the commit
   message describes;
 - after a transparent (mSBC) SCO link had streamed on USB alternate
   setting 1, the next HCI command timed out: 12 recorded instances
   across four 7.0 builds and three headset models; in the investigated
   ones the controller then stopped answering USB control transfers and
   only removing power recovered it.

With the entry (the commit applied to the 7.0.0-34 source and btusb.ko
rebuilt, nothing else changed) the driver loads
qca/rampatch_usb_00000302.bin and qca/nvm_usb_00000302.bin from
linux-firmware, and neither failure was observed in the test on the
same machine:

 - 0 "0x2005" events over the boot;
 - 16 SCO links on two headsets, including one that had wedged the
   controller before, with all 16 hang-ups answered and 0 command
   timeouts. A diagnostic build enabling only the QCA setup part of the
   entry had previously completed 58 links over three boots with all 58
   hang-ups answered and 0 command timeouts.

Runtime testing was performed on the 7.0-based kernel; the five
requested stable trees were cherry-picked and build-tested. Logs, HCI
captures and the exact commands are public, exhibits EX-055 to EX-059
at:

  https://github.com/ivoitovych/qca9377-bt-hang

Thank you,
Iaroslav Voitovych

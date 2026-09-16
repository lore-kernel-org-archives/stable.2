Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30FA4D7D5D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580085; cv=none; b=SN/WI3MR2cnvvzoG/h7Vk6guBqIzAPGN6MJzGYlDFis32aqNStAnsT/U/RTttGEf9VPoQhteWSEB0zVZ2okFWxdn3dNHmSgo+KaT8xAqOs0nWcQqTrD+7Bcrs8pEFFlTeYlq6wJrgPbP0HB+VR0ZRrBCw8xp6o5DHQ2cqSJj2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580085; c=relaxed/simple;
	bh=stiosI3snHNHPAa7ZoIaPSQZFzvJjokfhZ5zzBdnZzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZiFkkeF9vosLScI9SobT3wHPuZhx618vEOIJI4K2IlfEgwSB1/pMJHl8SAduytWGy7Q0PRYZER9OnboifH2hPNTquaDUwkhlQmMH666JdWJuywDMwEbwS53erB11fIVQDdZGaSlCmmvqMs2HZztH5PxCS5fW0u+oo2h8t4R4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqaCr9BM; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqaCr9BM"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843172bff4so6223f8f.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580074; x=1790184874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jab3z2lSjSUyFpWaybvz4ThV7LQrYnGZZ7snDuu1hVg=;
        b=SqaCr9BMWMBsPR/KAfzXLDqD9uM9mKp0EPgGFsmEz8YavL2du4yIUyG3yULtLKuIN9
         GvUzu3ScpHVMma72foX5hcMP7ZYlxac66ccXe24ddh7elcJQ4JIKgW9F4CaBxvFGRRTU
         eJ6d2/Xlup/nChGlK9u1oAwYro/hkVTtTLGLZKNLZEwUqa6ISBrvfhUMvMgxHvocGtPp
         8GSJtxifdbSZ7nKSkUHngB4CH9mFJ/hamu3nlCpMmcA+D4BQa1VG9nDNiAPZ2a3Cid93
         tm0iplWep293BHBLtm3frx6XAbc5nsG4BRiJX5rNh2+//JPmRQt5Bj5UjP/YhLbyVmgE
         dWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580074; x=1790184874;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jab3z2lSjSUyFpWaybvz4ThV7LQrYnGZZ7snDuu1hVg=;
        b=KGue+0rxPNtdYthjvKw9NCXUUzj5xrgdWjDqvdgdlxIedXuRttFScFOf+dVdJFn58m
         q8ptBNfcIITz4TqlCsoMuJE7d+9ShVA905uPDbYhbT8L6POS+ECObSNUHmUpBR9IrerN
         TB0Zjfr2Wv6BOc5cugBHpboYc0kXMLPjGCC0jDIPtJEZSjzxi3okJMKEShzm/1wGf8so
         aHIG3BhLSdRklgMKoR/pfBAWTXHIlyJss4SwyJLPyfB/sG9vel8lUGiJMoNyLF/VgxgT
         HCDu/yiZJo1wzpgadF7rswun7Ah38p+33+cDmNUZbz0FaRAKafkVEqehAtOz0QJ9bbev
         Zg1Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9ktp5aSYjqFnfyaHYOec7vkRSneOP10SOOTNz/lPKj3gzqpQBawplU+3SjmCAmSfsYRD39EA=@vger.kernel.org
X-Gm-Message-State: AFuF++nY3EusF5zH5bLFmcsfAyt2C0SYaWx1jOjdPhRAHmDnje9x9Y4e
	1lRREltmnHNHt5n7Jyh+/vBlRyjamQYr/3jHcsSxa6IPpYWBTWbItQ0=
X-Gm-Gg: AYBFou2ahn8gxLruLBlNSBfkPN2RsP3jdbi9Bb/Kb6L+6bcwtQ1oszxEJhZf7JLIFKJ
	elq8EElQI0Dep076ce0mibbmqnN+LtngkfClWq3k7EpXonZMax8eWzlW9MsOB6xWTtoHXJtfsqU
	Mp8I9V3J1KY/4s0WnQnp2igsPuZO0FkX4Shy56Gp9tnW0UvYdbjofnLMsIAqrEHrbfistPAP6Se
	Ux25ykFIH/ILfqY8bClC1DBaU3ZsGteCCYHx23SSYWcfLglUm0cOvIqVymEd06jq81GtxGPHA2m
	bZjY6/AaRRejTIVE5+VET5LXeUPJBuEJpezdTu1cUs2mMIAKVRUK9ZktahoeOMBQcKCXSrZ6uDr
	Jd2yy2wcZqAco144fpZ4OfALX7m5SFgLC2QVFMX9c8ArhAaUgiAei7rrD/hmtTxkNZSiMh15192
	J33JkZMs7PaLv6sK7MFeLXr/lMnh944VCWb1s5RH3QffL5HiBAVZVFPLJksmsw7fJ0gCnE4+YHx
	sqsiiHEWLGrG2o578r1a2+RZVOhvApyqfWuLtgR1qVqqXsK5hSAXMbEZLiW3WGs+hbp6DGZQX14
	5SG+J+ehenYIJbw=
X-Received: by 2002:a05:6000:18a6:b0:486:faa5:2165 with SMTP id ffacd0b85a97d-4870d271014mr4626272f8f.54.1789580074036;
        Wed, 16 Sep 2026 10:34:34 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:f23c:f0c3:c09d:d6d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm8987544f8f.20.2026.09.16.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:34:33 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"John W . Linville" <linville@tuxdriver.com>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH ath-next v4 0/8] wifi: ath9k: fix register access and spectral scan filter handling on ath9k_htc
Date: Wed, 16 Sep 2026 20:34:21 +0300
Message-ID: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eight fixes for the AR9271 USB driver, resent as one series in
dependency order as requested.

Patch 1 gives the multi-register read a return value and checks it.

Patches 2 and 3 belong together: 2 fixes the byte count of a full
read-modify-write flush, which has truncated the AR9271 PA calibration
since the buffer was added, and caps the buffer at 14 entries because
the corrected 15-entry command fills whole USB packets and is never
delivered; 3 refuses any such command.

Patches 4, 5 and 8 are one bug family: a timed-out register read
returns all ones, and the spectral scan wrote it back into the RX
filter (4); disabling the scan never cleared the PHY error bits (5);
the ath9k_htc filter recalculation read the same registers back (8).
5 needs 4's helper, 8 needs both. 8 has a Fixes tag but no stable tag:
the failure has not been seen on that path.

Patch 6 fixes an out-of-bounds write in the shared spectral code on
ath9k_htc. Patch 7 passes CRC-tagged spectral samples to the FFT
parser, which the firmware reports as CRC errors. Both stand alone.

Testing, all on AR9271; ath9k (PCI) is build-tested only:

  1: build; a timed-out multi-read was not provoked.
  2, 3: 100 interface opens on two devices, also on the stock
     firmware, no hang; the size fix without the cap hangs the device
     on the first open.
  4: with a read fault injected the filter stays closed.
  5: PHY error frames after a scan is disabled fall from about 2000/s
     to tens/s.
  6: a 7 hour scan soak with no memory corruption where the unpatched
     driver faulted within a minute.
  7: about 24 % more spectral samples per second at baseline.
  8: filter recalculation issues no reads; the timeout it guards
     against was not provoked.
  All eight, on the series as sent: 965 interface up/down cycles with
     spectral bursts, then 5 hours of continuous scanning under a
     900 frame/s injected load; 657,426 WMI commands and 5,808
     multi-register reads, none failed; taint unchanged.

Not in this series: the acked -EBUSY guard for spectral scan control
while the hardware is disabled, and the ath9k_htc debugfs counters and
round-trip work, which follow once these fixes are in.

Changes since the separate threads: patch 1 returns the error instead
of filling the buffer with all ones, patch 3 returns -EMSGSIZE,
kernel-doc for the RX filter helpers and no other code comments, one
base, the git-blame authors on Cc, shorter commit messages, and the
Assisted-by trailer in the documented form.

Nerijus Bendžiūnas (8):
  wifi: ath9k: return an error from a failed multi-register read
  wifi: ath9k_htc: fix the byte count of a full RMW buffer flush
  wifi: ath9k_htc: refuse a command that fills whole USB packets
  wifi: ath9k: stop a failed register read from opening the RX filter
  wifi: ath9k: clear the PHY error filter when a spectral scan is
    disabled
  wifi: ath9k: count spectral samples in the driver's own RX stats
  wifi: ath9k_htc: pass CRC-tagged spectral samples to the FFT parser
  wifi: ath9k_htc: derive the PHY error filter bits from software state

 drivers/net/wireless/ath/ath.h                |  2 +-
 drivers/net/wireless/ath/ath9k/ani.c          |  4 +-
 .../net/wireless/ath/ath9k/common-spectral.c  | 41 +++++++++++------
 .../net/wireless/ath/ath9k/common-spectral.h  | 10 +++-
 drivers/net/wireless/ath/ath9k/debug.c        |  3 +-
 drivers/net/wireless/ath/ath9k/eeprom.c       | 10 ++--
 drivers/net/wireless/ath/ath9k/eeprom.h       |  2 +-
 drivers/net/wireless/ath/ath9k/eeprom_4k.c    |  4 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c  |  7 ++-
 drivers/net/wireless/ath/ath9k/eeprom_def.c   |  5 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c      |  7 +++
 .../net/wireless/ath/ath9k/htc_drv_debug.c    |  3 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |  9 ++--
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 41 ++++++++++++++---
 drivers/net/wireless/ath/ath9k/hw.c           | 46 +++++++++++++++++++
 drivers/net/wireless/ath/ath9k/hw.h           |  2 +
 drivers/net/wireless/ath/ath9k/init.c         |  6 ++-
 drivers/net/wireless/ath/ath9k/wmi.h          |  2 +-
 18 files changed, 156 insertions(+), 48 deletions(-)


base-commit: c3bace8584ca707e34ba837f65c2e9d566af4c2c
-- 
2.55.0


Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7003905E3
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229915; cv=none; b=hY82b6pBwWHDYktrMUcoG3Z7oje3Bgnmqqw3KsBrLLSWSFu5wILwGn4C66goIEzvFeFcIGdTKwDRnhXr32Wx6Eu46a/a+Pr4WvNuqfVjyw7oMVnihWHzEEftkS9UXNJQR8qPKu5oHjtR8eGvNyx4sxIeMdYgEEAs1OFKz96ccsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229915; c=relaxed/simple;
	bh=A7hEuCLZWRdGFblp///+ebIF29mgq6p9oSmiBLCXlLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=euve+/99+1hqiKCnX69sLIHtIcKHIKpdCbEyip6vtK9KfTre/GvmN4a1QjxAr8dVqYJMcflzYJrRF2GgkD1KKDYYpjSzJTkm01CBE3aPmV9IbNWWHR70h/oCntW/QVnnYa2yHE9UZf+Exb5M6Caj+g90puiR0D9JLUCJcOoz3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNVaI0c1; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNVaI0c1"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8633a38df87so805321b3a.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790229914; x=1790834714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdu061GCn59M+R7cqh6VYjsrqQSSKRxNFPR4yXO2TzY=;
        b=iNVaI0c1wZvy54ZslA0TjSDz9/QCiCUi14vYktLovQy2XOMJZ7HahsdBwO90aRDyJH
         BXYYhHOye8Lkgve4HRgRCLnF3AL4O7YJZj2EEHAYcSXmeWzmdL8VvRHi5gR+hEgxzdWb
         XE4+lwbT4fmEY0SzkOp/fmtSxDGq5lYwrLmarz7PBEfGdSRhnH6dwztOw8wt2lm3Qbfr
         bGXiKECid38f99sFJ+Iw3bg2koYe11w9WSZ8V5dZqs4bvLEAuj4d2RVWR6CftHgTKpSL
         5IONVlAsAS9TnTivphbpBR9/SWnvv0BPWHxwQkMKBVTUzX/IpGqyg+HmCcZUvfOJb4qI
         VKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229914; x=1790834714;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fdu061GCn59M+R7cqh6VYjsrqQSSKRxNFPR4yXO2TzY=;
        b=12iGkKwd6iWA9UjkW1fsjbmVb8/+g4wp/TRrnpicJzZ1rM4IkS3sGqVV7F3pzyW6VY
         k+HKEeIQgqrBj/8y/0hZTCfTB5euGyczNQ681DiwHnNCsE9gpFcqLsjXl0yxRdIJ9NET
         vgGKDLfNEnGia7U2IHZukUrqDHCK3raUUAtTMOwEC6VO//TKtvhY5TnghQnjMz4CYN1V
         UfNDt5HQBOYENhAloywM+pRS5lctwQ7/9zuOdNfPRjpGhOS1HKqAO4SKSgl5ZhYeKnbl
         39G6J+n9yA1yIS1jC3ffB8RuqQXO3CeyQFtbG3xzD68qLlxikXUrERQbJjw84BHm42Ec
         H/EA==
X-Forwarded-Encrypted: i=1; AKwUvBxb5adq39kES94Jzz40twt8vlkvyvFwAXLbwDCz8FtFbm/+gTOmiJBwr9MUJD/THuD4g3dgwbc=@vger.kernel.org
X-Gm-Message-State: AFuF++mdM/5wwOIaJbzrgMuG7KhTiBfxjL5zWwaDOwY7EvQ32/F3M89s
	7WaraLB0yEzjIrFTMzTspL5be5SrsYaQ6e5B4uokv9ZINeIr/CR3zcQ1
X-Gm-Gg: AYBFou35M1dPtAS4fie//AiThX1mugUQHKasKGU5qHuw+7TF0CibD79r6yvv8L4FBYK
	XI1eh5kqDdKtZ7TDr8r6I55myV9SO55fj6CQD3Feod/M5bbtD6po5tWjbr3N2gV9KEpBoLwnHHy
	Q1k4fXHQUBlZMHu85PXVQPyyNcZcrq9899z21keSbBpKsX/4papIsPcGuifdk8pWMY30joCNmZj
	2jNYZRPbsm9d1gV6eml1CHsfBNeNfUplocj9HJocgWQ/Uzf740IrPkClD7EO8N3SgIX1RRD6Zpx
	ZQn97/QXlSkC6PgSZ61VScO4BxRDLN/TqRyvSD/jxobyMR7klfCUQuuDn9GOI2VT3/VO0qA9dqE
	NcTyYT2obNwZEWxFtb6gMRuQ0XdlNiiQ7Hwj7LiLD0QbGy3O7Xh+3AMmKhrKgNdmxptdBQdsJDM
	gdY5jmuHtGwC6M/QRECTSVc6kHQy41D3RUC8GZYrxIvnNBHAiZVDVxlUor9MkescZhfNrPqQQIt
	eBEtNhRnOytbPuHQF1s28GwhQepiT7P495GC5OHk96D4p1JYDjOMMbkF/83cQ4Xg4KROg1R2e2X
	hxKmqVIqdA==
X-Received: by 2002:a05:6a20:d49b:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3de0e790e6emr1523337637.26.1790229913520;
        Wed, 23 Sep 2026 23:05:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f2228a2sm2056710a12.4.2026.09.23.23.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:05:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 0/3] serial: fix IRQ chain race, baud fallback, and uartclk overflow
Date: Thu, 24 Sep 2026 06:04:43 +0000
Message-ID: <20260924060511.2364717-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes three bugs in the 8250 and serial core drivers:

1. Hold hash_mutex across IRQ chain lookup, linking, and error-path
   unlinking in serial_link_irq_chain() to prevent a use-after-free race
   with concurrent serial_unlink_irq_chain().
2. Allow a third loop iteration (try < 3) in uart_get_baud_rate() so that
   when both the requested and old baud rates are out of range and try == 1
   clips the rate into termios, the clipped baud rate is evaluated and
   returned on try == 2 instead of returning 0 and causing a divide-by-zero
   in uart_get_divisor().
3. Reject baud_base > UINT_MAX / 16 in uart_set_info() alongside the
   uartclk == 0 check so that multiplying baud_base by 16 cannot wrap
   around in 32-bit unsigned arithmetic to a small non-zero uartclk.

Changes in v3:
- Patch 2/3: Collect Reviewed-by from Ilpo Järvinen.
- Patch 3/3: Add missing #include <linux/limits.h> for UINT_MAX and move
  the new_info->baud_base > UINT_MAX / 16 check to the uartclk == 0 check,
  as suggested by Ilpo Järvinen.

Changes in v2:
- Split the 8250_core.c and serial_core.c fixes into a 3-patch series,
  add Cc: stable@vger.kernel.org, and document how each patch was tested in
  QEMU, as requested by Greg Kroah-Hartman and John Ogness.

Hui Peng (3):
  serial: 8250: hold hash_mutex across IRQ chain linking in
    serial_link_irq_chain()
  serial: core: allow third iteration in uart_get_baud_rate() fallback
  serial: core: reject baud_base values that overflow port->uartclk in
    uart_set_info()

 drivers/tty/serial/8250/8250_core.c | 4 ++--
 drivers/tty/serial/serial_core.c    | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.49.0

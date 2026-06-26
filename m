Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210A3164A9
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470773; cv=none; b=rAIZ1/W7Ww9snQsMHvQFo96XPTMRoR5ZoFgKyOTmP+OiyQZtTEV2Km1MzDJnfoaWyMMHgdSTI/5MKu9PIgon50KcOBZ0XKg/NBzXNTw540nB6EyC6cOuDjchBoqnPsAkKsQy9CpZagAdqI1H/g6lA9R8eds08oF/McqjdUYi0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470773; c=relaxed/simple;
	bh=Kr2B56j+YXQcnhiNkNd5xEnnYZxvJNIH58SRYO83s6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2x6bkA8oZblFUGLgx5UtKcQlHn5S9ac4mUaSGW8PX9edFPtOjOEDy8Ze/NMgpAYuAuNfaf+3HqPjwAXZf5bmjGjcOwLoBWzVLdeTQd/dVIgyJ6GuGsaVPbuQ7EN44rxceSjPHVOhv7TTCbdVA89fftLdF5YOV6bzIOYdce9VtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4yWOcRu; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4yWOcRu"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30c9c8c2697so717126eec.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782470772; x=1783075572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ienghRFlOKCrHTVcT7ltXLw6p3FK6RiRmVx7RZAUjMQ=;
        b=R4yWOcRuSnPL1zhhK4UX6nTRT2rEvUahAVquLzDW6a+sAbDnEnq8vQEIICH+4OM1ya
         GU+uFo/nrihgSWJmXjSFZ9n7L1toV8ygDL02/4QH3tWWa4dyEe0VnHO0McCPgmG2tZK1
         JDXLpWp9VK1tXvXxy8qSUWWYTAVE5ZXKcuR0jreSTjFDlLSF+hY1+eKDQ/k+OCudhCCK
         Mc5O2YV59RqBZV6Po3pcByOsDrAEo8G1XOxBmXdJl9+yCalBLwaCUaE1o4q61UrrIL2c
         2l22cgHhTEAknJUfa/0AOa7GPjQ6ITj+yvUfIoZKb0Dwv6uV9gdWdo//m8fxiKrrWkIn
         lDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782470772; x=1783075572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ienghRFlOKCrHTVcT7ltXLw6p3FK6RiRmVx7RZAUjMQ=;
        b=pR0rzmo3Pb0I837/VO6JPLHS99hYlHGnG5eU2vhaAYXoC3gF3OKxQW8OxQbv30wY3e
         iV4F118S2T289HtToFvjJsWa/f7fd7WGNxokCxsK0hLdJQPGtQDutrpUAIg4SnKLrvn3
         n1dReEuj04xMH79MxIYozo/yXG0OQOjhmVZHqKKZjBC2Iw17WfMLiBnwQJJvgAfbMZCp
         Vl9UkoQziLC6E/L8NsdeJf2ea57Zv1YF/0SCbTEYli2QvOddQRPYClU6jexusvJl3kwL
         DoyqQo6EY21VYZqNLcJ6BkKY23EBU524BUTZpxXVh0OPi07LYCnhVsZ317BISHPUyhQT
         CteQ==
X-Gm-Message-State: AOJu0YxynU35QQL2ilmiFilCYmA77afGtNk2m/Tu7P/W7sdeXeCd/1kJ
	8Yvk/CFc44uVwBph40CHGsZG6rcT+SQtq+W+faPrPxCpyw0d0/Ca5MwYFgyitjCb3g9gQA==
X-Gm-Gg: AfdE7cmMDjnUc4JsrpeXKczCyoII5+c+m5DrDsU9Yz8orMaQ13QwDm3mSWluUeQ3/tW
	Vt7WVul/+v9puXRwBfuEGQnbvjalnDZEhBFUcanJ8lh/+pP6UDTHPF3UaM7Ed3LfNI4tpiiFcLB
	zUtgmHQjXRhyellQgkTXxJkrFwoe7wFqv+u9LFLR8HCI2ToQwrCNRmiu41nrz6EaEMcY6RBDiIN
	ZPBWk19MrCmWFpZvz055MUjf21dBi3EDBOR0/rw3G5LxWZUWDqpMGxiNHbAgkhmEgmLu1dn9xxY
	4X86F69fFEJyM+Eu/GFOkXeqCXY8wA43hj97h8koF4HT/WgxxVDMEYZBLDwv+sSKT8nqSC3Z3Lk
	KNhSQQRMtkiDth4uqnUzP1KAT8MsGZuDhciXannCj+XOzGiaccLxrJOCF5Yrq6WOsyM/oslG+TE
	qCichD7HHOOCoMtt8bHQu/szj+Th/kimTh8geEwtueSHTWzJEu07qTlJ+Stw==
X-Received: by 2002:a05:7301:6583:b0:30c:7b76:9047 with SMTP id 5a478bee46e88-30c84d4a202mr6138025eec.17.1782470771484;
        Fri, 26 Jun 2026 03:46:11 -0700 (PDT)
Received: from naduvan.timesys.com ([122.178.167.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab28fasm17823093eec.30.2026.06.26.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:46:10 -0700 (PDT)
From: Siva Balasubramanian <sivakumar.bs@gmail.com>
To: stable@vger.kernel.org
Cc: tristan@talencesecurity.com,
	pav@iki.fi,
	luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	Siva Balasubramanian <sivakumar.bs@gmail.com>
Subject: [PATCH 0/2] Bluetooth: btmtk: WMT event length validation (CVE-2026-46140) - 6.6.y backport
Date: Fri, 26 Jun 2026 16:16:02 +0530
Message-Id: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please consider the following two upstream commits for 6.6.y. They are
present in 6.12.y but missing from 6.6.y (latest checked: v6.6.143),
which contains the offending commit d019930b0049 ("Bluetooth: btmtk:
move btusb_mtk_hci_wmt_sync to btmtk.c") and is therefore affected.

  634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length before
                 struct access")  -- CVE-2026-46140, tagged Cc: stable
  e3ac0d9f1a20 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
                 events")         -- Fixes the above; regression fix for
                 real MT7925/MT7922 hardware. Both are needed together.

The first patch fixes an out-of-bounds read: btmtk_usb_hci_wmt_sync()
casts the WMT event response SKB data into struct btmtk_hci_wmt_evt /
struct btmtk_hci_wmt_evt_funcc without checking the SKB length first.
The second patch is the required follow-up: the strict length check
breaks devices that legitimately send a shorter FUNC_CTRL event, so it
must accompany the first.

Both cherry-pick cleanly onto linux-6.6.y at v6.6.143 with no conflicts;
skb_pull_data() is available in 6.6.y. Compile-tested only
(CC [M] drivers/bluetooth/btmtk.o) - no affected hardware available.

Pauli Virtanen (1):
  Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

Tristan Madani (1):
  Bluetooth: btmtk: validate WMT event SKB length before struct access

 drivers/bluetooth/btmtk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--
2.34.1

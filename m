Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5723939AE;
	Wed, 10 Jun 2026 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122272; cv=pass; b=e6AW1li/WEf85DF752Vy4+/lUnXov7YGR7Rspim2JMjnlr75E4mVCsVNDr57ud2BMK0gxQeRtLr2k5uKvGo66Ciozn80MH2IpSS1rfDxje8zYMy3n/4xldXulJwG3tPnwwotB3ubE1suiAyWj/XBqiDElnZ8l0btdXBhUbcJ7ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122272; c=relaxed/simple;
	bh=riH4yJNKeElQNcJczQKK64j8AXlr3K91b5PhxiwVFXA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c1rw4eOFcSTVyaXTA+NUtxWrIdBx8Gny23VHTgCHIDE/iMDKZBme1MYePg3QdaPmblIo4yLJPqZXvtN+7zioMRQN2xdu+pxzGRYpOew2VuvDceHw8ta6phQDDRlNZszai+TS3i+3XwRA99VThK/7WXFQYyxlwRPAUKsFcaI7W/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=MA//mqft; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="MA//mqft"
ARC-Seal: i=1; a=rsa-sha256; t=1781122257; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KFRFgLD1Sh6expo3VpR1mlHFrvKMAoK+yDVQZKl65AIFpmWmpmwWF3bQRJ6O6IGLZYA1N5L5dD8MoQXfK7FPcaNJL51YRkdOO0ssgKaOLP515fit81659zOZj+rBBZmBM/BAy4CX1I/LAWAQiAEgnC+Q4u7n1jBsbrZILEl57kM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781122257; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qYVTpsCizl4QvsBZjd+LQibGGxmSivONhN51UP7z5vw=; 
	b=d99lSUqBMdlp35CB5RuxVrHWt5TTqhT4Rfd9YDlrfcVtc4/6TOb0lNdHpVdjk/JH5QbVYiYDiRnQYpE4mQL/Omz6BJaf84zN4+t7lhWFljHXyFq3BsFZ7+dO5hEmJhyaWmwwL3eCtDoE9rqPlCwqH2oCjWk/dxbPgC2ozwZt6kw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781122257;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=qYVTpsCizl4QvsBZjd+LQibGGxmSivONhN51UP7z5vw=;
	b=MA//mqft1pb/zFlrGimvmutxXAB/w/6IR1PBALI5xNwGUrlrEJk6O8fmcQfZOUpB
	l+drS/DyBfMH1ak6O2YSvPRXbaaQJx/fBr09G3ZQi2HfUehxVA/AKSnkttv0Fcs/fUs
	ehjo9WJx7dkaYN4LRd5PeXCXdWsiT7wmCaHH8lu6AqkdtptR7pKdkJWMMZ9ANXIMjUO
	IZQFIw3nEyBCr1ej2V+m1aFIegTve282MIx5JedN7FGFUPNUjGVX78gqF6MRkCykzxh
	6rovCI4ALJhB0R23AB/Uoo4bKCxgkQ0gsTAAnXzzvaFIugHzIFfHdIaxflEzFxTm5lE
	ERiZSPcMsA==
Received: by mx.zohomail.com with SMTPS id 1781122254565659.4771807559712;
	Wed, 10 Jun 2026 13:10:54 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v3 0/3] ACPI: battery: Do not generate too much pressure on
 ACPI methods
Date: Thu, 11 Jun 2026 04:10:43 +0800
Message-Id: <20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPEKWoC/4XNTQ6CMBCG4auQrq3plF9deQ/joi0DjImUtJVIC
 He3YIyudPklM887M4+O0LNjMjOHI3myfRzpLmGmU32LnOq4mRSyELkUXGdcmYG4ViGgm3hvAzV
 kVIiP/CDqsgKVNhJKFonBYUOPjT9fXtvf9RVNWM31oiMfrJu2/gjr3TtV/k6NwAWXqUg11hUao
 U/O9u3+ZpGtpVF+rALgjyWjlWGFdZGDghy+rGVZnkYxstslAQAA
X-Change-ID: 20260520-b4-acpi-battery-notification-90d781a3f217
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-d5d98
X-ZohoMailClient: External

The acpi_battery_notify() and acpi_battery_get_property() callbacks
sometimes generate too much pressure on corresponding ACPI methods. On
some devices with fragile ACPI implementation, these methods share the
same mutex protecting EC accesses (hence slow to execute) with a lot of
other EC-related methods. Such pressure on them eventually leads to a
catastrophic situation that a bunch of ACPI method calls fail to acquire
the same mutex due to timeout. The firmware of these devices doesn't
handle mutex acquisition failure gracefully and return garbage data,
causing even more chaos.

For acpi_battery_notify(), a very common pattern in EC queries that
emits two consecutive battery notifications with event IDs 0x80 and 0x81
updates battery state and calls power_supply_changed() twice within a
short period, generating significant pressure on _STA, _BST and
_BIX/_BIF methods. Not only that, power_supply_ext properties may also
rely on some other ACPI methods, so both uevent assembling and userspace
processes call them. It becomes a nightmare when all these methods share
the same ACPI mutex and hence vulnerable to lock starvation. Even worse,
after the first uevent reaches userspace, some userspace processes start
to read all battery properties in order to refresh their internal
states, which competes with the second notification's handling and
uevent assembling, exacerbating the lock starvation.

For acpi_battery_get_property(), it generates too much pressure on the
_BST method because of the lack of synchronization. In detail, it
sometimes nullifies the cache mechanism of acpi_battery_get_state() when
multiple processes read power supply properties simultaneously, which
usually happens after a uevent. Normally, emitting a uevent implies that
the cache must have been refreshed due to power_supply_uevent() reading
all properties, so the mentioned processes should have seen cache hits.
Unfortunately, these fragile devices' power_supply_ext properties are
somehow slow to read after battery events, resulting in cache expiration
before power_supply_uevent() finishes. Hence, once the uevent reaches
userspace, the _BST method will be executed multiple times within a
short period due to userspace processes reading all properties again.

Improve acpi_battery_notify() by merging consecutive battery
notifications within 10ms using a delayed work, so that they only
refresh and/or update battery state once. ACPI netlink event and
notifier call chain are still triggered multiple times in order not to
break other components. Finally, call power_supply_changed() once and
lead to a single uevent instead of a bunch, preventing userspace
programs from causing too much pressure on power supply properties and
the underlying ACPI methods.

Fix acpi_battery_get_property() by introducing a mutex to protect all
accesses to battery properties, so that acpi_battery_get_property() can
take the advantage of the mutex and synchronize itself. This also
prevents potential race conditions, e.g., when multiple tasks read power
supply properties simultaneously, or when other callbacks are called
during its execution.

Since the series touches acpi_battery_alarm_store(), also convert the
use of sscanf("%lu\n") into the more preferred kstrtoul() beforehand.

With the series, the lock starvation issue on mentioned devices is
greatly improved according to the feedback from one of the device
owners.

Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Rong Zhang <i@rong.moe>

---
Changes in v3:
- Address Sashiko's concerns on my last-minute changes:
  - Set the number base to 10 in order not to break the ABI
  - Do not overwrite the initial value of `ret' in
    acpi_battery_get_property()
  - https://sashiko.dev/#/patchset/20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151%40rong.moe
- Link to v2: https://patch.msgid.link/20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe

Changes in v2:
- Address Sashiko's concerns:
  - Return from acpi_battery_notification_worker() early when the fifo
    is empty
  - Use pr_err_ratelimited() for potential event storms
  - Add missing `\n' in a printk message
  - Use a separated mutex to protect all properties instead of reusing
    update_lock
  - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b%40rong.moe
- Minimalize the critical section of acpi_battery_notify()
- Rearrange the series
- Dropped Tested-by from patch 3 due to massive rewrite
- Link to v1: https://patch.msgid.link/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe

---
Rong Zhang (3):
      ACPI: battery: Merge consecutive battery notifications
      ACPI: battery: Use kstrtoul() over sscanf("%lu\n")
      ACPI: battery: Protect all properties with a separated mutex

 drivers/acpi/battery.c | 235 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 177 insertions(+), 58 deletions(-)
---
base-commit: acb7500801e98639f6d8c2d796ed9f64cba83d3a
change-id: 20260520-b4-acpi-battery-notification-90d781a3f217

Thanks,
Rong


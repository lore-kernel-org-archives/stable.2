Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423533;
	b=A/VKWIcxhNAJHRYPg0TfU2AM7FV68qmczKKnyAMOhMI9hOrzKb0UDDJAQDIu/HkgsFjz
	 lC0NeXFF3b+Zz/NDZf0WbgV85f9SsaWwdzeNi5W7u+Uc8FifyI3YSN8+6Enh2L2ex2eZ6
	 FfsRMCH8FkQa1dMvhJPIEn8h+OtkT0YJvbE3sgi0DKT1s9JMy3NB2A19LONmhzSzcj1v+
	 J9S8cXfme+H4zDzUw94qwXhaThu3eP8BtMPKCgVRUSUJ2Af+YK27KWoVSDgm5lJYBYfym
	 ifJDFOrk6/zO6pq3viWOzZvDoDf6N3ag7RuSzu4oqds2k6CpEQrD07fb+fCxmZptDcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6dAWyhBV0tSfzWq++DvFdvgQxpkA9HyPG6hImHuuPjI=;
	b=v8MfJfMQ4DWCnyKQTvXaV655HG24mSi6ABWE2mhAmYFtM+xd751Tz8eSbsixAmmHtIJL
	 J2qabwblT7ohMWutMr7Fxc/4SvJzyuGZg5wASUUt26Rgb7MTHI8q+yJ7kWbqM7CFD0Suq
	 OBBK7PaeyTRcscRXzQzR/6e+kIThgWFmb+t67IWfU0z5fLBl0FB1D4OBJ8dEqmkJDd16A
	 3uoAA460QDQhtSsWYt1lumBGDvfH/jGW1ri9q/VLIypco1PbkhgAx7htgBbiUcJ1wHd8f
	 St3VCALuQeKHem/1Ghizm6wXRc+mWBT9yoD3WiiGdT5+Dflo1QUVmESY2XvnQBoIytQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UmTCDghk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D579606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UmTCDghk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815EB1F00A05;
	Wed, 11 Nov 2026 18:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423533;
	bh=6dAWyhBV0tSfzWq++DvFdvgQxpkA9HyPG6hImHuuPjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UmTCDghkPNo675wBQcAZBVmSXFV+EIIeztn1lS0cUy1Ok1U7VbQM3e64gtvZq4y35
	 y3ozOq7sUcSg1gyYlbBsTF9mylcbLSLjXuqr9vRCXTPejPJf9nKvHcQ+8N5ytZhacI
	 IygzJ8w8p0AEgZiPj55fdzngIUlileRjdCAWklz+11Bq3tYZ7x9ULAjrvZkx1fMTQK
	 qCmuq7UPvUqyEAMBKqMFTWpGdKU/JbCWcoYznXlkH8z4FLfJKNgSsT+oaLIqVnyfMm
	 SWsxdbDU3ZUeWVuZ9f6vZ52hoT37mqJxQNNc4toamXqXDfHbGyxijMPVYPikJTtD0L
	 1Zx7Y1Hn/hvQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Priyank Rathod <rathodpriyank@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
Date: Wed, 11 Nov 2026 13:58:51 -0500
Message-ID: <20261111185836.3872177-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053150-failed-6.6-d4c842c3af5b@kernel.org>
References: <20261107053150-failed-6.6-d4c842c3af5b@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Priyank Rathod <rathodpriyank@google.com>

[ Upstream commit d4c842c3af5bc52b3ca0b8a7f116114e43b6ba44 ]

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues the
entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

This is reachable whenever the device reported by firmware is not (or is no
longer) present in the PCI device tree, e.g. after hot-removal or when
firmware reports an error for a device the kernel never enumerated.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260928-b4-fix-aer-memleaks-v5-2-ba6b94c9c9a6@google.com
[ sashal: changed pci_print_aer() calls to the existing cper_print_aer() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index bdf7e32529f99..2f7d88353b028 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1005,13 +1005,12 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
 			       entry.domain, entry.bus,
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
-			continue;
-		}
-		cper_print_aer(pdev, entry.severity, entry.regs);
+		else
+			cper_print_aer(pdev, entry.severity, entry.regs);
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
 		 * ghes_estatus_pool to protect it from overwriting when multiple sections
@@ -1021,13 +1020,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					      sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
-		pci_dev_put(pdev);
+		if (pdev) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+			pci_dev_put(pdev);
+		}
 	}
 }
 
-- 
2.53.0


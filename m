Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015721A267
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083563; cv=none; b=YbMm4Uo4x/bqqq1v/0Np3madeplI70Jrby9+glsgSv1huy4oOu1b27yXVQznDLCusk4pMP2z8WudDcu2kxJs0gFLudu814ZP1QqrNQ9TX+ZnxGE6imwPsQgiEv2KNj6O2ywSVAbEcCFw/R2bh6SLv7RWdPpjy09SuX5Kk5ExwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083563; c=relaxed/simple;
	bh=OeGHmdfLFPl9jW4FMIQcF0zflV4AFD9jmAVac49WEVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTI6JtEV3yGzGHSOmdwd5EvezPCH8ulE3rWSgRbkq8fpfhCWtsnOhqjKvG+UJQBMXHwi236tHtrERflNQxTHVHMby7gVxRpkZR/0QK8QXpfQOlvsJIg1OgbZYMEy9nREjJolt1p3v5/OxjglIKsfwrPGuReOCLp2KsHg/i5A47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXuiZnn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXuiZnn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB191F000E9;
	Wed, 15 Jul 2026 02:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083561;
	bh=TRoKCEgNh4idlyC9hxzgKaM8yG2Q740pvxVPcph8seE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXuiZnn0f3xhqKkzA2dlPyhuAiVnaVuFqMyk9uXGMocLNS2vl0CltxHQ2rl6osK+6
	 1cyhr+C9HurVPsVS4TQUrnXVWKz8jXE6Qo5xUWQE+S7YmiZCCuU9bzY73cDsKgRTKh
	 ioEvrqZnKc5MLmX9dAbu9Z7jSJVCxLKrwV8+1Xl+9ngZ9X1hovlgXUv2WgzDkI3zaH
	 C2I4xLjLdt7t0QMOaAt9f4Dj51zuU8ybO9gPj+vXlZ4qXSlJns+YhOcASZPM1wbUxe
	 DGxWCsLfGK/neI7D/BNJAk6yMGuy+N0kRH/USCYxapEnUz9cUzDvDSzzMySleXNd+w
	 Ah2jHgYY5lJpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/6] PCI: Prevent resource tree corruption when BAR resize fails
Date: Tue, 14 Jul 2026 22:45:54 -0400
Message-ID: <20260715024559.106836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071309-opal-shaking-a4ea@gregkh>
References: <2026071309-opal-shaking-a4ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 91c4c89db41499eea1b29c56655f79c3bae66e93 ]

pbus_reassign_bridge_resources() saves bridge windows into the saved
list before attempting to adjust resource assignments to perform a BAR
resize operation. If resource adjustments cannot be completed fully,
rollback is attempted by restoring the resource from the saved list.

The rollback, however, does not check whether the resources it restores were
assigned by the partial resize attempt. If restore changes addresses of the
resource, it can result in corrupting the resource tree.

An example of a corrupted resource tree with overlapping addresses:

  6200000000000-6203fbfffffff : pciex@620c3c0000000
    6200000000000-6203fbff0ffff : PCI Bus 0030:01
      6200020000000-62000207fffff : 0030:01:00.0
      6200000000000-6203fbff0ffff : PCI Bus 0030:02

A resource that are assigned into the resource tree must remain
unchanged. Thus, release such a resource before attempting to restore
and claim it back.

For simplicity, always do the release and claim back for the resource
even in the cases where it is restored to the same address range.

Note: this fix may "break" some cases where devices "worked" because
the resource tree corruption allowed address space double counting to
fit more resource than what can now be assigned without double
counting. The upcoming changes to BAR resizing should address those
scenarios (to the extent possible).

Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
Reported-by: Simon Richter <Simon.Richter@hogyros.de>
Link: https://lore.kernel.org/linux-pci/67840a16-99b4-4d8c-9b5c-4721ab0970a2@hogyros.de/
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/linux-pci/874irqop6b.fsf@draig.linaro.org/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-2-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9c078af9e166b6..066d4dd2fc1e89 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2314,6 +2314,11 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		bridge = dev_res->dev;
 		i = res - bridge->resource;
 
+		if (res->parent) {
+			release_child_resources(res);
+			pci_release_resource(bridge, i);
+		}
+
 		res->start = dev_res->start;
 		res->end = dev_res->end;
 		res->flags = dev_res->flags;
-- 
2.53.0


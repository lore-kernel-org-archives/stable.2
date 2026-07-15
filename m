Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17725CC57
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114181; cv=none; b=sa1OUY0NAJ1i1KChfJY58zuksI40SPIaxs0duhkpijP5T/axKvfvX/baQ18Le4c1oVRH/GFBglxAlR69M88JkpthX4KaCjbjkXyn8X9VP4WMBi6FHwF/xhwhZ2/B1fsyCFk6ECLUQFzapLT+0tM5I+4g2Iw7rpwDv4I+eRZkDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114181; c=relaxed/simple;
	bh=w4WT5jjx6r+X0lquEG4NBtO7Z4IRyduBagLGufTiuxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPLzjAqiN/TbERNie/Jm50Mq4e9zito5t26vCQAK9yXUigrL4eP8k8uQb5WfQUZ1vLmtBmuEQ4lGTFkXY8Dgou6QObh5mjl3CPD0rGP7Sp/RHL1l8j3awXAqDlTszTQtqDqiNF8HoZxJSDUTVK+BiYQwbTnYNMOMFHYIrhEKpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCXqSTm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCXqSTm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF421F000E9;
	Wed, 15 Jul 2026 11:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114180;
	bh=gK9RqY3Wa0HzDTaRz73/AmxLKaiwSyW3h83+nZq9R5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCXqSTm/GYsxoW2BTRkohct/XtKYmKTFyF9E9rTMALX1XEHJ81ZQk4vTdg2UO/yBd
	 FjjiUqrSjIDXGmTCspELZJTW0oQ29I77Mkatha7UW1zJ3+a0XR+p/DBmiUMT6cKvV4
	 wU5U/p35gQBVu32vIAU2bPw93rEf6nTGoNLY0SfUFPN/z9yEBZMg6BYwyNbTXCossQ
	 G+Wg94c8Ga6Ip5UPZ/+sWHnq/v+1e7GHyyR5E68Ft6UO/w/XfolHtwko3dZhLbzerK
	 tGquDX6eRi5xYyfrusPwoLfL6RiIgjkPSjR2ruWUS98me8pFgP/dZQCDCaYoYizfe1
	 TIrEuY0NLvY/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] PCI: Prevent resource tree corruption when BAR resize fails
Date: Wed, 15 Jul 2026 07:16:13 -0400
Message-ID: <20260715111618.647249-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071314-tableware-flashback-79cc@gregkh>
References: <2026071314-tableware-flashback-79cc@gregkh>
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
index 04c3ae8efc0f84..92a9a0f38fa76e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2257,6 +2257,11 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
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


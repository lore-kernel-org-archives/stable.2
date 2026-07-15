Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FF3B14CF
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133147; cv=none; b=gnu0UHlBpcfm0Ra5Vf/52XAIYOvkjYCgHvmyRKxps2zXTXOMHz35UrmSm6X3lj5Hw9+iOKEen1T5vM9OgzbrDGkNg1a9D85lr4bKAe+z7G0tiH5/qV53Lg3nS+2awxTp/mv2ibbogksyFuhMi2ulsconIc3rXl16vsP4aaTgTQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133147; c=relaxed/simple;
	bh=w4WT5jjx6r+X0lquEG4NBtO7Z4IRyduBagLGufTiuxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUQNkjoFYrC6dTM89rsMXusFEAP1zYBRMZsPrB050/bkmmnlTJ5OX67sMIVUOQUBp9ZPwmhPne9081oQG2C/zya95SW2mdlJMmvDFC2zwxfE0DN7uMt92W34MDpgWrIGA26cFZCPMy4B5HLr2NVTEtS9FlwufvnOIAIvzjzdGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDZ1GHHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDZ1GHHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC8F1F000E9;
	Wed, 15 Jul 2026 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133146;
	bh=gK9RqY3Wa0HzDTaRz73/AmxLKaiwSyW3h83+nZq9R5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDZ1GHHbpf6WzQ6mB48jbANn+1uX1fFd5WX+KAAx/vtcBCHctVModJKdq0Nu3h2if
	 8/4qZODIwdkK+XYOvMqDqxwPhU97Alzp2hrIGhth95Rpr9UJOvTDtLhaUlR48o5UD6
	 5BP3/17ycPNU0/9y8I6nkmfY6cU1c5SpdY6hGfoWyTpQ8UWtjz3JTE/gpmdNbjBWu6
	 FlFrIgm+9LTc3Vho3GSMECb7oT7D0I+WGJDi48Epxl8sajbLa9cOf8HKFnHhv0+1Es
	 akoHdEggmeUkGBe+o3aP4GnmgFsKr2XF+r0C5YpKopzXn/NQULOdxKIzO4FHo2++5Y
	 uUQby/EZPyQsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/6] PCI: Prevent resource tree corruption when BAR resize fails
Date: Wed, 15 Jul 2026 12:32:18 -0400
Message-ID: <20260715163223.952417-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071318-kettle-cringe-5d1a@gregkh>
References: <2026071318-kettle-cringe-5d1a@gregkh>
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


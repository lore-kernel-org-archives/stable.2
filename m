Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBD42BC44
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074679; cv=none; b=cxOWBxahfHkhdJCq0NUtyBrHs0qaXtBfPonN+LtX9d/7OGTI8n66pJHLFULJlc2u7ZE64uqy/ymYNXGZnI+CK/islBAyB4gQLiiutmS6ySneq4Li/TYJHLsVRi/UOjFX9tqhCm036zO/NZ83pJgMeBNWXCU/rIkp4DEEmq9aBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074679; c=relaxed/simple;
	bh=nMeRujv2M96Z4i+CcrXnCyD52IUW5vDvXAFyIglWrfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgnw9F2+wAqU5iVvS6I5iV68Moex3h3RR6hXBs+O6VKv/G4HKiUSY1CGZtVt1VEQZEcolk+KeilioPHm1ELY2Vwea15dAMp5Lywu08hdhG2OEeae8uUpKMdzxsaOcLxHk9cw5aOZrPL/362LoM/QwLR6XvTpvOjIMkpKe6wOd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLtfW5QW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLtfW5QW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28C41F000E9;
	Wed, 15 Jul 2026 00:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074678;
	bh=mTfXuak47zwMuvrNkoKoqa/ivtT878VcpFa/gqBR/B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HLtfW5QWp4BBkIEBw3A8fhpkcw/RzQ2su670lGvSTPaNyvAdtviZ5G+7r22FdmvLJ
	 K21xkl8tjGyUsk/1wiBTTIJ3ql/+tZ2/ibWUD6syAdqWfWI7CTa1PlzYQUKgHj+RvV
	 ZZqq4CakXHfMN086IkzqeHL8lgKAxBLNXwUf992j/Izy/HaOz+xWaVDjuuLyXbAc1U
	 K/kr91yXOKqggvk4jbcaGPPcppcTcpdJl83bJtqTRtPUFeQ37DfB878woSKlh8c3+n
	 cyEnhFkgxA/Bc2ZpN1/29ozOfsqdvoZHi0GV0UvqytdsYAQxZGq36fWqrT1oBloBnn
	 YANe89GaCNDNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] PCI: Prevent resource tree corruption when BAR resize fails
Date: Tue, 14 Jul 2026 20:17:51 -0400
Message-ID: <20260715001756.3783927-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071305-gulp-reenter-fa22@gregkh>
References: <2026071305-gulp-reenter-fa22@gregkh>
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
index d07c1d9ed0620c..569f1e27a07807 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2312,6 +2312,11 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
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


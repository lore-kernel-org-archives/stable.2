Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691312;
	b=RQiZPVdddQ2sEhf7F5cukCDttzMcifwNg+xPL3xWxvDVcaT8ewCn4L1bQmS1e2d76ji/
	 YJoA/WeWc7Hhn01jSNB4dPporlgzmHwh4lwoIbXnyRqELgfn4ZqaNVXiCt7Elbwihrmv+
	 /UMLWo9Lj21W5vblEljDDp7ZZ3/NRmQOCbG15UFjZ9YaWnDyj5ZJLtA+r7TwndVsC/lVL
	 0lQEUOMa7QEz0t/R3DjBxEUAJlHUVpHePuCGl8uU2fgKmjFMRc9bd7iuL+omtnOOtw/GN
	 fax7sAZCGNW2szmaVzBD/6Gf4Ou/vV8zF7Ipm1wKpS6S9RhCc7njhlbXx2FXpNBO+sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691312;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=SpslVbUahu1lzhSFFj8q6rCig7MM9wSX+fuc0eipTGc=;
	b=pSHBU/mtzpO+HNAV5/2kCFIC/8XqDZAl9Pt5Z3CZ/tWsFztVTCqET+wDKGJs4nI5tg4X
	 gHFU/9o2Xqs5+7oVPUaEgWGm81L8lvTRQpTqYNS7Lto1QBux2q6z/GlE5vkugpWRVDH+H
	 zyIot7u9n4MU5/uK0NV8NQIS4kxfNfEdkIsHfTqvJVV20qsB5s8/BZfKN20Di5zg5mqgR
	 n7XfccH/WMTBt39BUVsPy5qZYiYnZ/KUN22XSYTmxm09engiPrxaqzVzfAXMucj5SYzPX
	 GmNHISkTz4fn0MqeQjxrEnTXKYh1JKe+rRE09Eih6VRL2tHQk3eQfDRjK2JRdGE0VBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="T7UZ/xC6";
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691C606A31B;
	Thu, 22 Oct 2026 17:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B691C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=T7UZ/xC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792691311; x=1824227311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SpslVbUahu1lzhSFFj8q6rCig7MM9wSX+fuc0eipTGc=;
  b=T7UZ/xC6BezNuiL+3Wdnm2IPgpNrcke8tP3zj/jRsjKllA7/0EFuxw1F
   khtCIz85VrOONWTTkCBuhckHsDodgNsudIsHhIH3Wg4Z67FF6Wf6EUwAv
   MQ40zrLKCkvdpxn2qsGKZ81bunMYR4Dg8yxEKlf4OM33hdS2fRqvdeSAo
   Vyh8G/sv3ZrrOInFxn7IKEiBLJ672Cs0ezqq9dlhXt23cToS4OmLzVGEx
   mKllSEfpS5DQEaD+ip+IMt/kt/GbQAw52fmPzQcTxyIGUXLdcZ2dx1YN4
   7N3CZlMONw4DwOW2KzRxm0a77qYAz862aw63rU1DQlr1/68fRA+VNV6bo
   g==;
X-CSE-ConnectionGUID: L+EihjG2S0W5i2YMzsl0Uw==
X-CSE-MsgGUID: xBeVkGZtR9OnaJ0HESE8mw==
X-IronPort-AV: E=Sophos;i="6.27,172,1787011200"; 
   d="scan'208";a="31772390"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 17:48:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:11227]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.97:2525] with esmtp (Farcaster)
 id dd35c2c1-3ca3-49e5-a666-293da7c32e6d; Thu, 22 Oct 2026 17:48:31 +0000 (UTC)
X-Farcaster-Flow-ID: dd35c2c1-3ca3-49e5-a666-293da7c32e6d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 22 Oct 2026 17:48:30 +0000
Received: from dev-dsk-aarnahmd-2a-95203392.us-west-2.amazon.com
 (172.19.38.251) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 22 Oct 2026
 17:48:30 +0000
From: Aaron Ahmed <aarnahmd@amazon.com>
To: <stable@vger.kernel.org>
CC: <maz@kernel.org>, <oupton@kernel.org>, <joey.gouly@arm.com>,
	<seiden@linux.ibm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<fuad.tabba@linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.10.y] KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save
Date: Thu, 22 Oct 2026 17:45:36 +0000
Message-ID: <20261022174537.2767-1-aarnahmd@amazon.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit c6c156d931c33b92362383cf76f6d6e1291dcbfe ]

MAPC with V=0 drops ite->collection but leaves the ITE on the device's
ITT list, and vgic_its_save_ite() dereferences it unconditionally. A
guest that issues MAPD, MAPTI and then MAPC(V=0) therefore oopses the
host when the VMM issues KVM_DEV_ARM_ITS_SAVE_TABLES to migrate it.
That sequence is UNPREDICTABLE per the architecture, but KVM already
handles the resulting state in the translate, MOVI and DISCARD paths.

Save a zeroed entry, which vgic_its_restore_ite() reads back as
invalid. Skipping the ITE instead would leave the ITT slot holding
whatever is in guest memory, and restore rejects an entry naming a
collection the restored collection table does not have.

Fixes: eff484e0298da ("KVM: arm64: vgic-its: ITT save and restore")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20260807104102.2410744-2-fuad.tabba@linux.dev
Signed-off-by: Oliver Upton <oupton@kernel.org>
[aarnahmd: Upstream vgic_its_write_entry_lock() takes in the kind of table
 entry (ite) and looks up its size, while 5.10 takes in the size of an ite
 directly via ite_esz, because commit 3b2c81d5feb2 ("KVM: arm64: vgic-its:
 Add stronger type-checking to the ITS entry sizes") is not in 5.10.]
Signed-off-by: Aaron Ahmed <aarnahmd@amazon.com>
---
 arch/arm64/kvm/vgic/vgic-its.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index e6ec0701f5616..07b8ca72111f3 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2151,6 +2151,14 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 	u32 next_offset;
 	u64 val;
 
+	/*
+	 * MAPC with V=0 keeps the ITEs mapped but drops their collection,
+	 * and with it the ICID. Save a zeroed entry, which the restore path
+	 * reads back as invalid.
+	 */
+	if (!ite->collection)
+		return vgic_its_write_entry_lock(its, gpa, 0ULL, ite_esz);
+
 	next_offset = compute_next_eventid_offset(&dev->itt_head, ite);
 	val = ((u64)next_offset << KVM_ITS_ITE_NEXT_SHIFT) |
 	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
-- 
2.47.3


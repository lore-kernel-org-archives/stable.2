Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18473DDDDE
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557049; cv=none; b=nQ49qrYzudWJ2YSx1TemMArwvcPPIa+R+yox2uRHZtNLH9KMDrmvMA2KPVUqvGZhA9TaJuxB3QzC8XNP+cIiv0TTZYkrygI0DHn3BKVgxrIm9YxhrphEdnMBzyJsNLwMz2eGwZJy1I+1f0rH+2pn7RSY9L/qi+AMSCAE87jVW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557049; c=relaxed/simple;
	bh=7CmgCK+8i1RhMflFWXTqEzDGsuIRmXaOuuz+fr00HmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLJlnzXfrTFmzuOX95G1UyXQCyaA4yVle6hJILU8vHU9UET8jtzwOsD5z4Ev0TTKmwRluyDk8AwdcXtwaniHaRCMDuR/GDkGjQ+4rwH2x7Ovy9aos1j3H0t4hXIrgj/zf9IXDDP00+JFRuOPfHwqniZr/h7sLVhOM4ahps3lFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQXJ8BKG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQXJ8BKG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780557046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TTx7iJcEYQPNF0fLP9iIlrZJ+hGEW1AJgAn2YYrO6Tk=;
	b=IQXJ8BKG0+CPEpbkjS35rHqJo7cJ9AgdxEwbW65ECAqczNnGEN0Mdpf77yxdSs8YoSzN6z
	2SFobd95fJfzF/aoovcpZ/NJruuZqgjIbOHmccxdyEe8F1TYUzTP4kSP1vgpHDHbteJjjN
	4A/0Nt/uSrHq88ULkJunWy+Uxem0doM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-2myNmU-MPgSRWm_ZsUO4mg-1; Thu,
 04 Jun 2026 03:10:41 -0400
X-MC-Unique: 2myNmU-MPgSRWm_ZsUO4mg-1
X-Mimecast-MFC-AGG-ID: 2myNmU-MPgSRWm_ZsUO4mg_1780557040
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D88FB19560AD;
	Thu,  4 Jun 2026 07:10:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 291A830001A1;
	Thu,  4 Jun 2026 07:10:36 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Thu,  4 Jun 2026 09:10:32 +0200
Message-ID: <20260604071032.659009-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When unbinding the ath12k driver, kernel NULL pointer dereferences
occur in irq_work_sync() called from rhashtable_destroy().

Two hash tables are affected:
1. ath12k_link_sta hash table in ath12k_base
2. ath12k_dp_link_peer hash table in ath12k_dp

The issue happens because the destroy functions are called unconditionally
in cleanup paths, but the hash tables are only initialized late in their
respective init functions. If the device was never fully started or if the
init functions failed before initializing the hash tables, the pointers
will be NULL. The issues are always reproducible from a VM because the MSI
addressing initialization is failing.

Call trace for ath12k_link_sta_rhash_tbl_destroy:
 RIP: irq_work_sync+0x1e/0x70
 rhashtable_destroy+0x12/0x60
 ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
 ath12k_core_stop+0xe/0x80 [ath12k]
 ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
 ath12k_pci_remove+0x60/0x110 [ath12k]

Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
 RIP: irq_work_sync+0x1e/0x70
 rhashtable_destroy+0x12/0x60
 ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
 ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
 ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
 ath12k_pci_remove+0x60/0x110 [ath12k]

Fix this by adding NULL checks before calling rhashtable_destroy() in
both destroy functions.

Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
Cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/ath/ath12k/dp_peer.c | 5 +++++
 drivers/net/wireless/ath/ath12k/peer.c    | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index a1100782d45e..38045564e223 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -275,9 +275,14 @@ int ath12k_dp_link_peer_rhash_tbl_init(struct ath12k_dp *dp)
 void ath12k_dp_link_peer_rhash_tbl_destroy(struct ath12k_dp *dp)
 {
 	mutex_lock(&dp->link_peer_rhash_tbl_lock);
+	if (!dp->rhead_peer_addr)
+		goto unlock;
+
 	rhashtable_destroy(dp->rhead_peer_addr);
 	kfree(dp->rhead_peer_addr);
 	dp->rhead_peer_addr = NULL;
+
+unlock:
 	mutex_unlock(&dp->link_peer_rhash_tbl_lock);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 2e875176baaa..80fee2ce68f1 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -444,6 +444,9 @@ int ath12k_link_sta_rhash_tbl_init(struct ath12k_base *ab)
 
 void ath12k_link_sta_rhash_tbl_destroy(struct ath12k_base *ab)
 {
+	if (!ab->rhead_sta_addr)
+		return;
+
 	rhashtable_destroy(ab->rhead_sta_addr);
 	kfree(ab->rhead_sta_addr);
 	ab->rhead_sta_addr = NULL;
-- 
2.54.0


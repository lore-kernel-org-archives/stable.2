Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47973E2745
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522477; cv=none; b=M6AoOTDI+SfT3AHjMLQwkU29DBpkjpOqxKJqVlJFrPSCqNLT6pSx/iT/Tg/YZVOuD3p+j2Adx5aQPR7fPFbg1Jz/oyYkZKrM/5zFk3jYfFc1g/5hIczDupRv+DngqSwzu/KGfRytNxs+91tfJgj6R/w3/wTyJj27rf9VRub9Skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522477; c=relaxed/simple;
	bh=5U6hRboFmaA2jOHsVIjiXeUUhlJIyvz1/OH/G0G51GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTZt62dwnU2zZ7y/EAJ4a/JwbfchDJuWo1pyIm1DPsPGHBJ7swXAcTtt/3Si1oWubTHFTk1nxv40SEvtl8UorBZ/wmewIkmM8tGbF7cwPGay3bUX1ql/tK+K/bE+4td09NfqhNXFA7wnVbg8w20QxKL2ClWK9kUHP+RPJcA2Lvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgLkN05S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgLkN05S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781522474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B6WQlP4LsP1BC2/D9rOcFasJgBtWxq+pQN34qv7/LvI=;
	b=SgLkN05ST3Axypb654UX7ywFh4vy+reizC666gVIIr73dtj2l5ZYt4N8Onk9XIxGwvO61g
	+f6gia+hlOEOae4irmtV+cJnZZo6lLlgBxAW6TYQexPkqGXd90zLrOtIQA/GGjijxuU6QP
	qEBufveMP3C56/pETsf0HQs23d6ra6w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-jMW5aiWeMYq1zjUJVUtulQ-1; Mon,
 15 Jun 2026 07:21:11 -0400
X-MC-Unique: jMW5aiWeMYq1zjUJVUtulQ-1
X-Mimecast-MFC-AGG-ID: jMW5aiWeMYq1zjUJVUtulQ_1781522470
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F239E19540D3;
	Mon, 15 Jun 2026 11:21:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.61])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD5291774;
	Mon, 15 Jun 2026 11:21:06 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Mon, 15 Jun 2026 13:21:03 +0200
Message-ID: <20260615112103.601982-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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

The NULL check approach was chosen because the rhashtable pointer
serves as the initialization state indicator. The init can fail at
various points, leaving some components uninitialized. Checking the
pointer directly is simpler than adding separate state flags that
would need synchronization.

Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
Cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2: - Use guard(mutex) instead of manual mutex_lock/unlock with goto in
    ath12k_dp_link_peer_rhash_tbl_destroy (suggested by Jeff Johnson)
    - Add rationale paragraph in commit message explaining why NULL check
    approach was chosen over state flags
v1: https://lore.kernel.org/all/20260604071032.659009-1-jtornosm@redhat.com/ 

 drivers/net/wireless/ath/ath12k/dp_peer.c | 7 +++++--
 drivers/net/wireless/ath/ath12k/peer.c    | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index a1100782d45e..ab3e3e107782 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -274,11 +274,14 @@ int ath12k_dp_link_peer_rhash_tbl_init(struct ath12k_dp *dp)
 
 void ath12k_dp_link_peer_rhash_tbl_destroy(struct ath12k_dp *dp)
 {
-	mutex_lock(&dp->link_peer_rhash_tbl_lock);
+	guard(mutex)(&dp->link_peer_rhash_tbl_lock);
+
+	if (!dp->rhead_peer_addr)
+		return;
+
 	rhashtable_destroy(dp->rhead_peer_addr);
 	kfree(dp->rhead_peer_addr);
 	dp->rhead_peer_addr = NULL;
-	mutex_unlock(&dp->link_peer_rhash_tbl_lock);
 }
 
 static int ath12k_dp_link_peer_rhash_insert(struct ath12k_dp *dp,
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


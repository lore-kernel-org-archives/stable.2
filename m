Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6923E35F;
	Thu, 27 Aug 2026 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868849; cv=none; b=lCgHHgPdAH2r650eQyonNV8yrPWzoO5jK/3aFQRQ43ZOqJ0D5InCqrN+wq8SzbxsQ2MzE7ulMgfY5sL6A/bLWsciAwoYOLUdEolp6PbsRGjp919VduRTv2crPivTWBh7mvagi004z3YelZeGk3qhrSdwb+SC3bJWMafy/66Chm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868849; c=relaxed/simple;
	bh=CtZKd35OHvBA9T83JQValE7ehekafIMiOzAK1TyWwf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mkj90BK9I0tta9J7So8FEXc5+0mMXfdMGm1/hmruItyWCRtEAgSM0121GznagSlHh+YH0lFiYTZG6qU/DV/N1iv6MZFm6lfFy1EfSAkpNcIh6G1UsAqs5GlgZPnx0n+7TYRyY9ZM0/NJO1NFw+tGycH8Z5jrsuWPJlxNHwSIfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=ND5gxTEZ; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="ND5gxTEZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=/vS53OweWc
	DYGGilrKvuXWilaGvWa2+hDdiYmV/MoCM=; b=ND5gxTEZLMy2qrd3bLBvVeKM8t
	zarr/cPgVZUPqQi/914kBTl9CmB6nOafRHJ7+xRGQgNyDMwRIxTyEZvYYGlK3NYM
	3/Fbgbq10dM4hz4NUoxEPrt4soEgXzihAn64BCQUvok6AoG/Fr16RnHTp525Kq4W
	j54HCS/TBnZSJDiRg=
Received: from skw.ustc.edu.cn (unknown [211.86.152.107])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHgimVtpBqhamqAA--.3828S2;
	Fri, 28 Aug 2026 06:13:56 +0800 (CST)
From: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	linux-wpan@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Subject: [PATCH net v3] mac802154: fix data race and NULL deref on local->assoc_dev
Date: Fri, 28 Aug 2026 06:13:39 +0800
Message-Id: <20260827221339.885245-1-skwkevin@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCHgimVtpBqhamqAA--.3828S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWkXw4xuFy7JFWUZFyrZwb_yoW3tF4UpF
	WUurs8KF1DXFnavws7Jw1rtry3Zr48u347GwnrZFZIv3Z8WF1rZa1aqrnFvF1Utr4kXFWf
	AFWDAFW5AF4qk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_ZwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUajgxUUUUU=
X-CM-SenderInfo: 5vnzyvxylqqzxdloh3xvwfhvlgxou0/

local->assoc_dev is shared between the association path and the
association-response worker without common synchronization.

mac802154_perform_association() stores the coordinator pointer and waits
for a response. Its timeout and error paths clear the pointer and return
to mac802154_associate(), which may then free the coordinator object.
Meanwhile, mac802154_rx_mac_cmd_worker() may observe the associating bit
and enter mac802154_process_association_resp(), which dereferences
assoc_dev.

The worker's bit test and the handler's pointer dereference are not
atomic with respect to cleanup. Cleanup can clear assoc_dev between them,
causing a NULL dereference, or free the coordinator while the response
handler still uses the pointer.

The recorded result is exposed to the same window. assoc_status and
assoc_addr are written by the handler but read by the association path
while the associating bit is still set, so a second response for the same
request - a malicious one, for instance - can replace them between those
reads and leave the caller with an incoherent status and address pair.

The response handler only needs the coordinator extended address.
Replace assoc_dev with a cached address, removing the pointer lifetime
dependency. Protect the cached address and the associating bit with a
dedicated spinlock. A READ_ONCE()/WRITE_ONCE() pair would not guarantee
an atomic __le64 access on all 32-bit architectures.

Reset the completion, publish the cached address, and set the associating
bit while holding the lock. Clear the bit and snapshot the result under
the same lock as soon as wait_for_completion_killable_timeout() returns,
before the result is consumed, so a later response cannot pass the
recheck and replace it. Cleanup clears the bit under the lock too.
The response handler takes the lock, rechecks the bit, validates the
cached address, records the response, and completes the waiter before
unlocking. Thus cleanup cannot pass the handler between its state check
and completion, and the cached 64-bit value cannot tear.

Both users run in process context, so a plain spinlock is sufficient.
The lock is not held while waiting for the completion.

Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Fixes: fefd19807fe9 ("mac802154: Handle associating")
Cc: stable@vger.kernel.org
Signed-off-by: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
---
v3:
 - clear IEEE802154_IS_ASSOCIATING and snapshot assoc_status/assoc_addr
   under assoc_lock right after wait_for_completion returns, so a second
   (e.g. malicious) response can no longer pass the recheck and overwrite
   them while perform_association() consumes the result (Miquel).

v2:
 - replace assoc_dev with the cached coordinator extended address, as
   suggested by Miquel;
 - use a plain spinlock instead of spin_lock_bh(), since both users run
   in process context;
 - protect the cached address and the association-state transitions
   with the same lock;
 - recheck the association state in the response handler and signal the
   completion before releasing the lock;
 - add Cc: stable@vger.kernel.org.

Link v2:
https://lore.kernel.org/r/20260826225959.682483-1-skwkevin@mail.ustc.edu.cn

Link v1:
https://lore.kernel.org/r/20260824175938.11143-1-skwkevin@mail.ustc.edu.cn

 net/mac802154/ieee802154_i.h |  3 ++-
 net/mac802154/main.c         |  1 +
 net/mac802154/scan.c         | 47 ++++++++++++++++++++++++++----------
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 8f2bff268392..8f92ac83f5f9 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -76,7 +76,8 @@ struct ieee802154_local {
 	struct work_struct rx_mac_cmd_work;
 
 	/* Association */
-	struct ieee802154_pan_device *assoc_dev;
+	spinlock_t assoc_lock; /* protects association address and active bit */
+	__le64 assoc_dev_extended_addr;
 	struct completion assoc_done;
 	__le16 assoc_addr;
 	u8 assoc_status;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ea1efef3572a..63e89bd586e3 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -104,6 +104,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	INIT_WORK(&local->rx_mac_cmd_work, mac802154_rx_mac_cmd_worker);
 
 	init_completion(&local->assoc_done);
+	spin_lock_init(&local->assoc_lock);
 
 	/* init supported flags with 802.15.4 default ranges */
 	phy->supported.max_minbe = 8;
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 005338f89b75..87a7867dbb72 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -536,7 +536,9 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 	struct ieee802154_association_req_frame frame = {};
 	struct ieee802154_local *local = sdata->local;
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	__le16 resp_short_addr;
 	struct sk_buff *skb;
+	u8 resp_status;
 	int ret;
 
 	frame.mhr.fc.type = IEEE802154_FC_TYPE_MAC_CMD;
@@ -578,9 +580,11 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 		return ret;
 	}
 
-	local->assoc_dev = coord;
+	spin_lock(&local->assoc_lock);
 	reinit_completion(&local->assoc_done);
+	local->assoc_dev_extended_addr = coord->extended_addr;
 	set_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
+	spin_unlock(&local->assoc_lock);
 
 	ret = ieee802154_mlme_tx_one_locked(local, sdata, skb);
 	if (ret) {
@@ -599,25 +603,38 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 		goto clear_assoc;
 	}
 
-	if (local->assoc_status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
-		if (local->assoc_status == IEEE802154_PAN_AT_CAPACITY)
+	/* The association is complete: clear the associating bit and snapshot
+	 * the result under the same lock, so a second (e.g. malicious) ASSOC
+	 * RESP can no longer pass the recheck below and overwrite
+	 * assoc_status/assoc_addr before they are consumed.
+	 */
+	spin_lock(&local->assoc_lock);
+	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
+	resp_status = local->assoc_status;
+	resp_short_addr = local->assoc_addr;
+	spin_unlock(&local->assoc_lock);
+
+	if (resp_status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
+		if (resp_status == IEEE802154_PAN_AT_CAPACITY)
 			ret = -ERANGE;
 		else
 			ret = -EPERM;
 
 		dev_warn(&sdata->dev->dev,
 			 "Negative ASSOC RESP received from %8phC: %s\n", &ceaddr,
-			 local->assoc_status == IEEE802154_PAN_AT_CAPACITY ?
+			 resp_status == IEEE802154_PAN_AT_CAPACITY ?
 			 "PAN at capacity" : "access denied");
-		goto clear_assoc;
+		return ret;
 	}
 
-	ret = 0;
-	*short_addr = local->assoc_addr;
+	*short_addr = resp_short_addr;
+
+	return 0;
 
 clear_assoc:
+	spin_lock(&local->assoc_lock);
 	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
-	local->assoc_dev = NULL;
+	spin_unlock(&local->assoc_lock);
 
 	return ret;
 }
@@ -639,19 +656,23 @@ int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
 		     dest->mode != IEEE802154_EXTENDED_ADDRESSING))
 		return -EINVAL;
 
-	if (unlikely(dest->extended_addr != wpan_dev->extended_addr ||
-		     src->extended_addr != local->assoc_dev->extended_addr))
+	spin_lock(&local->assoc_lock);
+	if (unlikely(!test_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing) ||
+		     dest->extended_addr != wpan_dev->extended_addr ||
+		     src->extended_addr != local->assoc_dev_extended_addr)) {
+		spin_unlock(&local->assoc_lock);
 		return -ENODEV;
+	}
 
 	memcpy(&resp_pl, skb->data, sizeof(resp_pl));
 	local->assoc_addr = resp_pl.short_addr;
 	local->assoc_status = resp_pl.status;
+	complete(&local->assoc_done);
+	spin_unlock(&local->assoc_lock);
 
 	dev_dbg(&skb->dev->dev,
 		"ASSOC RESP 0x%x received from %8phC, getting short address %04x\n",
-		local->assoc_status, &deaddr, local->assoc_addr);
-
-	complete(&local->assoc_done);
+		resp_pl.status, &deaddr, resp_pl.short_addr);
 
 	return 0;
 }

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.34.1


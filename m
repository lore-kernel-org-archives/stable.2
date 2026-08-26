Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E33438F65B;
	Wed, 26 Aug 2026 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785274; cv=none; b=tqHd5+IgSayYNaJsoBEs+VLFJP1U8RksNzTeTIzcBcvA3kO2YZyU2NkWK6yZ6gEXFJtE4rnsxyjTniEQrxJsoTGIsAWDjh6jJK+Z23f1MyDRmtagTrY/KnwHDJAE1kXoU2gF8rAMnVcF3Hy7cwCdindTu0o/ppaB7PeQuj1MKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785274; c=relaxed/simple;
	bh=Iw4i56TIUhDjddRRiabwFPLHIl+IFID7m5T8lhsAX8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GkgeBA0bHVWDlzTXS3ojLQW432/tetnUWeGgIs0OPQYFy5XFeas1PeJg4+jGBUU1OBNo4OgDMenMD9TMeiBopSBxyHUzPYae/L6KGDUSeocQGTs+zcu5WNOmVyXpqgwKTHSs+WpWHio2BAztfGFHT0iYyZwrFEq6IMr+LIGuBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=PKwgYhmT; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="PKwgYhmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=QrfgfmUHeY
	l5b5B9RzrFiEdDLTdEmBUPmSntgIBZbOk=; b=PKwgYhmTbbwjDbhpTbg2swnS/h
	zyzkzxMgq4FmGJXk7rAx/taGU9RZjMHO9MbqLSVitxp14UjO3skjIaAWFiLEBiEe
	uUu0DRVWG2C1C6R/NmRCNCIxBjPPyRiFdnEH30oCoqXTZPIqND49Q5o1Jvel9W70
	NxK4eIG1uTlu2y/9E=
Received: from skw.ustc.edu.cn (unknown [211.86.152.137])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBXWjH1b49qZj+jAA--.3696S2;
	Thu, 27 Aug 2026 07:00:35 +0800 (CST)
From: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] mac802154: fix data race and NULL deref on local->assoc_dev
Date: Thu, 27 Aug 2026 06:59:59 +0800
Message-Id: <20260826225959.682483-1-skwkevin@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBXWjH1b49qZj+jAA--.3696S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWkXw4xuFy3XF4ktFWxtFb_yoW7try3pF
	y2grn5KF1DXFn2vws7Jw1Fqry3ur48uw1xGw17ZFsIv3Z8WF15Z3W2grnFvF1jyr4vvayf
	ArWDJa15AF4DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6FWl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUyKZXDUUUU
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

The response handler only needs the coordinator extended address.
Replace assoc_dev with a cached address, removing the pointer lifetime
dependency. Protect the cached address and the associating bit with a
dedicated spinlock. A READ_ONCE()/WRITE_ONCE() pair would not guarantee
an atomic __le64 access on all 32-bit architectures.

Reset the completion, publish the cached address, and set the associating
bit while holding the lock. Cleanup clears the bit under the same lock.
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
v2:
  - cache the coordinator extended address instead of retaining the
    assoc_dev pointer, as suggested by Miquel;
  - use a plain spinlock to serialize the cached address and associating
    bit, including 64-bit address accesses on 32-bit architectures;
  - reset the completion under the same lock, recheck the associating bit
    in the response handler, and complete before releasing the lock;
  - use the response payload in the debug message;
  - add Cc: stable@vger.kernel.org.

Link: https://lore.kernel.org/r/20260824175938.11143-1-skwkevin@mail.ustc.edu.cn

 net/mac802154/ieee802154_i.h |  3 ++-
 net/mac802154/main.c         |  1 +
 net/mac802154/scan.c         | 21 ++++++++++++++-------
 3 files changed, 17 insertions(+), 8 deletions(-)

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
index 005338f89b75..0ae11e448ccb 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -578,9 +578,11 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
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
@@ -616,8 +618,9 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 	*short_addr = local->assoc_addr;
 
 clear_assoc:
+	spin_lock(&local->assoc_lock);
 	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
-	local->assoc_dev = NULL;
+	spin_unlock(&local->assoc_lock);
 
 	return ret;
 }
@@ -639,19 +642,23 @@ int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
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


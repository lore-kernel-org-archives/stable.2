Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD7446074;
	Wed, 16 Sep 2026 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565337; cv=none; b=ToJO2p5inaLEUEm2MZC0tlkIkga5tSkcrzHsMun0EoTyRCW+mEtutGi2EFEogtnMtgDlDcM9EFYK91EVvK7XCjYW3yJVsS0fQaFKj6kTM9iSCvA1cCnuWjYfwG30F1VaE8bKEDZ5m4UfZYr0uWi3SNnmz/D+SBVr8mR6mN/GEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565337; c=relaxed/simple;
	bh=9MrfUzBbRxO3K/j5gxi6S7iy4qoB+aIJE60TUfbvLEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ckfAD5Fz/tL4qpVhKximi9HQbw8Ph/75a4GBvCkHKpkZaLmQcGc/l7WXK1IWLyuq9wLFSHtOBxB+CPHEwOOg7Gsz6PdWDc+vyLKMfJcfhpktzDvrCaEDgTA2RIj1mk/yVUUbEs49qOjS6OHITQQfcbiERSnUkSOv0yKK1jnuqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=FckN4SA3; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="FckN4SA3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mU
	eWvQyELQ91Zo7gd0quF0DPhsMTPLIThzQR0sZzvog=; b=FckN4SA30XOP6w1T8p
	4TiZwK09qFPed466ZHcJoH/Ha4DkptRPANfpFDGVbaPNK2iTvxQ2yFu3Yt0jhuOi
	KwJpH+Oqqn0QMpbuvJkWV4NUlDokgKxHx+UYSRiM3QJsSUp3uOqH1+gjvwax8rqF
	mlU5vRsnWVvSTkauwH2Nr/qSk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDnvepPmapqaFzjHw--.21948S2;
	Wed, 16 Sep 2026 21:27:43 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [Intel-wired-lan] [PATCH net] igb: unregister the i2c adapter when register_netdev() fails
Date: Wed, 16 Sep 2026 21:27:40 +0800
Message-Id: <20260916132740.1001797-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgDnvepPmapqaFzjHw--.21948S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr17Wr45XF17Ar4DAw4Utwb_yoW5GF4xpF
	4DAa4fCr4jqrnFga1DJ3W0yFyYkaySk3yYka17Zw4fWFn8tryDXryYyFyYyFyrKrZ5u3Zx
	tr4qvw15Cr1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UA9N3UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQ++lWqqmU+yYgAA3L

From: Linkui Xiao <xiaolinkui@kylinos.cn>

igb_probe() sets up the bit-banging i2c adapter with igb_init_i2c()
before it registers the netdev, but the err_register path only zeroes
adapter->i2c_adap instead of unregistering the adapter. On i350 parts,
where igb_init_i2c() really registers the bus, the adapter is therefore
still registered when free_netdev() releases the memory that embeds it.
The i2c core keeps pointing at the freed adapter, so any later access to
that bus dereferences freed memory, and the adapter number is leaked.

Call igb_remove_i2c() instead, the same way igb_remove() tears the bus
down. Move the helper next to igb_init_i2c() so that it is in scope for
igb_probe(). i2c_del_adapter() returns early for an adapter that was
never registered, so the parts without i2c support are unaffected.

Fixes: 441fc6fdb47a ("igb: Add i2c interface to igb.")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..f965ca144f42 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3190,6 +3190,16 @@ static s32 igb_init_i2c(struct igb_adapter *adapter)
 	return status;
 }
 
+/**
+ *  igb_remove_i2c - Cleanup  I2C interface
+ *  @adapter: pointer to adapter structure
+ **/
+static void igb_remove_i2c(struct igb_adapter *adapter)
+{
+	/* free the adapter bus structure */
+	i2c_del_adapter(&adapter->i2c_adap);
+}
+
 /**
  *  igb_probe - Device Initialization Routine
  *  @pdev: PCI device information struct
@@ -3657,7 +3667,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_register:
 	igb_release_hw_control(adapter);
-	memset(&adapter->i2c_adap, 0, sizeof(adapter->i2c_adap));
+	igb_remove_i2c(adapter);
 err_eeprom:
 	if (!igb_check_reset_block(hw))
 		igb_reset_phy(hw);
@@ -3849,16 +3859,6 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 }
 
 #endif
-/**
- *  igb_remove_i2c - Cleanup  I2C interface
- *  @adapter: pointer to adapter structure
- **/
-static void igb_remove_i2c(struct igb_adapter *adapter)
-{
-	/* free the adapter bus structure */
-	i2c_del_adapter(&adapter->i2c_adap);
-}
-
 /**
  *  igb_remove - Device Removal Routine
  *  @pdev: PCI device information struct
-- 
2.25.1


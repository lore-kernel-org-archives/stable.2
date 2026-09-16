Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714950EBF2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566450; cv=none; b=QJeZqplljjmdSZqn8wFYRgFgbLxCIHGwGYzP8Wdz43qV2cvyhuzSVO10xCreXtwuAsQVB0GcM5bXtPOqzNIVFj1DIzN9tMrHvXUPahf2h0c+fyibAAVvPfXzEJEomccF2cwEInriV/XES/92rOWioWEvkqRyizvLbrV2RS0YcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566450; c=relaxed/simple;
	bh=/9MCjfhdugiDF6wauqRFfzV/HQVMKnX3+zLGfKdbJXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kyhW92frSJRUSIRTqAYjwHFuXFYNk1jdgMl1uyptD9wCIRwimXvJWx5si3qW6nj+33pa/MjuBEhzIRh2pCYwpjd0IsD8vwI0LIA2N0R4cREQhQhnoWVRX6yWlfM3jjEEW9WOi0mKFhUfMi+47m5vFpuuCVxqFxpd9lKIMNCNBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XHyURbk0; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XHyURbk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ux
	HOqLqY0ioEbW+y+gjnHEMXBft+GOWtp81bJHPmr4o=; b=XHyURbk0IvPb7f9HhO
	7dD4y9dUY/WbXOqxaagpZEkQVa1dXt1F93NaYSrRMlQ38M2zWaJL4m9q7vHUw0GI
	oXwHLIAXfAzTGjRHVKA5dJigBdaKf+f/82DLuad3x9ayCoWXMfhKZWz/x7cSVq0v
	Qxmd7btOHBp+1Ghh556W0y1oQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnMojfnapq+TSpBQ--.53495S2;
	Wed, 16 Sep 2026 21:47:12 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: xiaolinkui@kylinos.cn,
	534535881@qq.com
Cc: stable@vger.kernel.org
Subject: [Intel-wired-lan] [PATCH net] igb: stop igb_set_eeprom() from writing an unread first word
Date: Wed, 16 Sep 2026 21:47:10 +0800
Message-Id: <20260916134710.1014461-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnMojfnapq+TSpBQ--.53495S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw47KrW7ArW7CF4UCFy8Xwb_yoW8WF18pF
	WUCasa93y8XrnrWa1kGa18Aa4Dt3W8trWYgF10k3yF9ws8A393Zry2q3yUGryYkrZ5uFsI
	kFs7Cwn8A3WDXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Up7K3UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQDku2qqneDqugAA3b

From: Linkui Xiao <xiaolinkui@kylinos.cn>

igb_set_eeprom() does a read/modify/write of the first EEPROM word when
the requested range does not start on a word boundary. The error from
that read is stored in ret_val but never checked, so the function keeps
going with an eeprom_buff[0] that kmalloc() left uninitialised and
programs it into the NVM. The read failure is not even reported, because
ret_val is overwritten by the result of the write below.

The write is followed by nvm.ops.update(), so the corrupted word is
covered by a fresh checksum and the damage survives a reload.

The read of the last word already bails out on error, do the same for the
first one. Skipping the write also keeps the stale ret_val from being
lost, and igb_set_fw_version() is correctly not called since the NVM was
left untouched.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 65014a54a6d1..19ff9eb2c4d2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -814,6 +814,8 @@ static int igb_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = hw->nvm.ops.read(hw, first_word, 1,
 					    &eeprom_buff[0]);
+		if (ret_val)
+			goto out;
 		ptr++;
 	}
 	if (((eeprom->offset + eeprom->len) & 1) && (ret_val == 0)) {
-- 
2.25.1


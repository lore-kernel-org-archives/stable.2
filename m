Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C28503BD8;
	Wed, 16 Sep 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566851; cv=none; b=JBHSDI030bQGRnSbaoSKTV0hetNXgIZe61pu7tlU6+IC80pNFEx3rn8pyek/drXCoejhB9vy9+EyuOlO7OkJAYsOhyJlXTVeWbXtAjVN8V4wT3k8NqEkIrJoZ3YOWabC/jLbRk7cFu5ftPh02dSWFuX90+tLN7O11HKGNoC7thM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566851; c=relaxed/simple;
	bh=/9MCjfhdugiDF6wauqRFfzV/HQVMKnX3+zLGfKdbJXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lf4H4iOEmqiQK4zYn6w2dZYGW5PbOFIRnElLM6xaSa5Q/CqNIk0b2L5GbkFbZQfxg2cpsZokj4ybhrCwUuS+EH8khHULY/B23q0kqMIEIMz0//hwk8ze7vNmICAdkoObbgpq0rOHgmkfhm2whDEJmNWc7VNgcANhB41a2hA4Lzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iuIxhXR6; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iuIxhXR6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ux
	HOqLqY0ioEbW+y+gjnHEMXBft+GOWtp81bJHPmr4o=; b=iuIxhXR6uz/47dNXIc
	6sqlj+Gunny0Wz7yUfYi9IUA8JJsqES5Ozihy/KBOv2HJkO4BbFe3Qyvs+U6j27C
	jJ1Z6hqIgQS/+XjchYDJpv0LMKw8Za1AXoTGkMGHJuVJDlMAnCDKQGUYwgpz/Grm
	YRZmFU7cqwslpi4zZHgrBAhAo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3V803n6pqYsHmBQ--.44918S2;
	Wed, 16 Sep 2026 21:52:56 +0800 (CST)
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
Subject: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word in igb_set_eeprom()
Date: Wed, 16 Sep 2026 21:52:54 +0800
Message-Id: <20260916135254.1016847-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V803n6pqYsHmBQ--.44918S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw47KrW7ArW7CF4UCFy8Xwb_yoW8WF18pF
	WUCasa93y8XrnrWa1kGa18Aa4Dt3W8trWYgF10k3yF9ws8A393Zry2q3yUGryYkrZ5uFsI
	kFs7Cwn8A3WDXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRg7EmqqnzjGbgAA3r

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


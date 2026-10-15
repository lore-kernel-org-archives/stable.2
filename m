Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12F56260E
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087924; cv=none; b=KI5GLT4GMZO78tIMwH+qtsrOJTE/RuuBI20hF79sXU6aGaezIa4GHAQ5tPDluBTQD9IbYA1Nu2PDb58uznhoa15A7Ukf/fzI5pe4HBW6wrSvzmEddgcYQKAWvTHxVBva0lRu6k/Kb40+JjWa30LDJYvUO6BbZRY84carJi4p8cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087924; c=relaxed/simple;
	bh=v6uBnPzNTqK/DtaKreQRi0wrwzigClvyCacLhQWDzS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcnsgEY+CvJSYYlqjB6tXa+LlqyJcSwAhjjHLikSV5eWCIQ+nU83hDeXo3LFqCWPXOua9x+pNg5SEOMcy5u4LzjZqWb/TMVLfgkh+bxV6Cex7X6mlHEzClJgykUr9+FMaqCyNJdzMq3Y8+WlxcCU54T4XaumC48CqWFKEACGrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=cCeoua95; arc=none smtp.client-ip=91.218.175.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="cCeoua95"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v6uBnPzNTqK/DtaKreQRi0wrwzigClvyCacLhQWDzS8=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792087912; v=1; x=1792692712;
 b=cCeoua95HfCNykWLx03fY4MoPrwnSrg0BtaY3zsg77R+EKcuv6aNIdjim7vo7MjzOsqjo2tQ
 mnlJ6ys7HCqrO64pg0YSdQ53nEBOnofRtgC5fqA6Hbwm/z/Yr5L43JAP3jZS8LbkQDwgy9dINit
 TqeXQnYBLwtzgix6xKQgsyGArbDK3Nz0l3X/H/fsH269GNGexdiLE8jYh1i7OogdXhzIYNAgkTQ
 l0v7zCtJ76ZkVYhB/r95xVrYR216nFowFTivyCP2aAbacuxmJOHTcvU4vRkE8Br3nAZJYRMfaNB
 5ENnnfL1GIULUIj/7h6fbAlc5na3jK7Ru1APOeKoRW6qg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 93294ec33b7d1305;
	Thu, 15 Oct 2026 18:11:52 +0000
X-Mizu-Trace-ID: 93294ec33b7d1305
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH rtw-next] wifi: rtw89: debug: return the error when a read handler fails
Date: Thu, 15 Oct 2026 11:11:50 -0700
Message-ID: <20261015181150.13483-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I hit this while testing an RTL8922AU patch. Reading read_reg in debugfs
before choosing a register set off a kernel BUG that killed the reader.
It does the same every time on an RTL8852BU:

  rtw89_8852bu 2-1:1.0: invalid read reg len 0
  usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-8k' (offset 56, size 262144)!
  kernel BUG at mm/usercopy.c:102!

After that the driver cannot be unloaded, and on my test box network
configuration hung until a power cycle. Without hardened usercopy the
reads return kernel memory instead, and cat kept reading until I
stopped it.

The read path passes the handler's error to the copy as a length, and
saves it for reads at a later offset. Return the error before the copy.

  RTL8852BU over USB                 before    after
  read_reg, nothing chosen
    6.18.52                          BUG       -EINVAL
    7.2.6                            BUG       -EINVAL
    6.18.52, hardened usercopy off   256 KB    -EINVAL
  mac_mem_dump at offset 1,
  after a failed read
    6.18.52                          BUG       -ENOENT
    7.2.6                            BUG       -ENOENT
    6.18.52, hardened usercopy off   256 KB    -ENOENT

  RTL8922AU over USB                 before    after
  read_reg, nothing chosen
    7.2.6                            BUG       -EINVAL
  mac_mem_dump at offset 1,
  after a failed read
    7.2.6                            BUG       -ENOENT

Fixes: 831cceed3baf ("wifi: rtw89: debugfs: implement file_ops::read/write to replace seq_file")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 3a430bd08..3b7f8a809 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -185,6 +185,9 @@ static ssize_t rtw89_debugfs_file_read(struct file *file, char __user *userbuf,
 	debugfs_priv->rused = n;
 
 out:
+	if (n < 0)
+		return n;
+
 	return simple_read_from_buffer(userbuf, count, ppos, buf, n);
 }
 
-- 
2.56.0


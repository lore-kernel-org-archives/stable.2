Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6189E376A1B;
	Thu, 24 Sep 2026 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231363; cv=none; b=USnzjfBj0ceE2DG59ZORfVCH3nM1vMqToYVNjiuFCh7Q7KYlhsU00N9+Fi+7POf6mA72pG5uT+Us++Jfr0XJKw+qtrwzsT5Uc4DbTTWVhr/FZ+2lspQnDHCTMh5BKKcaUxRZemKE9wRRT9bSv+vjPpZyofsTsJVCfPxs2wc3hLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231363; c=relaxed/simple;
	bh=6iqbqhXwGTHKBdwfFPthQxFI7IQ1nhEzc9hhiM8YNeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TVaFmw6JOo9WnLnKBTOkaKx7q/Q5GeM6eyhn4qkiDQzPGXNhrhoqMD+a8YWOaKloSwQ/LZw05IaifuMCFC//DBdVh4gtMG1UZ2sU4tbkw8BFSl3EI4GG2H5xvCqO4VWBUFhBhnpHgHDC+seBwq9zGzt4PaCgabjAtC5NA5qE+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k35t1ZR0; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k35t1ZR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lP
	M7VbB2Ckh2dptNlX39+BnR+DQtmk+AawBaDoPjXVw=; b=k35t1ZR0YtmBPpP74q
	oZ3bXgopi2imYDBkwGyf+AWauZ6TixL3nmZRaxTongzBtKt6YCpm9owVl8xgjwgH
	Seux02kezvMOb/fn4phvnTX5crXq+1Mrj+IAMpmpgsR70UWOTU22FZRJl6ORTCkt
	mqqauKS+NacGj5uO7PHFVIZ+Y=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXTw4qw7Rq7hkpAg--.2979S2;
	Thu, 24 Sep 2026 14:28:59 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] slimbus: messaging: fix leaked PM vote on tid allocation failure
Date: Thu, 24 Sep 2026 14:28:56 +0800
Message-Id: <20260924062856.42977-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e76a151b-4dde-4bdd-91ee-e025e9bcc994@163.com>
References: <e76a151b-4dde-4bdd-91ee-e025e9bcc994@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXTw4qw7Rq7hkpAg--.2979S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWfWw1DXFyUJF4UKFy7Awb_yoW8Gr15pF
	47Wr1akrnYqry7AF1q9rW0qa43Zasa93yUCa1Uta4fAw4rJF40qryrtry5tFWqyF1rAw1j
	vrs8t34Fy3WDCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnzVbUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC8wvCbmq0wytGkwAA33

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

In slim_do_transfer(), when a transaction needs a tid and
slim_alloc_txn_tid() fails, the function returns directly instead of
jumping to slim_xfer_err. The runtime PM vote taken earlier with
pm_runtime_get_sync() is then never released, leaving the controller
permanently powered up.

As txn->tid is still 0 at that point, jumping to slim_xfer_err drops
the vote exactly like it is done for other failed transactions.

Fixes: d3062a2109309 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
Cc: stable@vger.kernel.org
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org as suggested by Srinivas.

 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index e2dbe4a66b70..ee127ef42046 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -139,7 +139,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	if (need_tid) {
 		ret = slim_alloc_txn_tid(ctrl, txn);
 		if (ret)
-			return ret;
+			goto slim_xfer_err;
 
 		if (!txn->msg->comp)
 			txn->comp = &done;
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A13955D0;
	Mon, 20 Jul 2026 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518242; cv=none; b=BuAGdqNHFLUupvRQBwy3CmdtUqgGLFM3ojQjM9HuiNyQ0tVdHSkaG3GnFw0joexn95JM37Zhq6vSYaOamEHfVJDJnzVkSSCpRaoMrhyUpcPbkS94T8gCRkUN3N+pq5r/DKINWVrfzTQvnDOp3I9/nwxvr2BMu9M+tgg0PBf1b8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518242; c=relaxed/simple;
	bh=cD4UIAZvGc5FxtJxaWlmL1baCCE4bH3tRAhMoxgot8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SXeC3kebsw7XBPKeMt6Oe8tF488DsndcqniyJtLxNfsraWbd+zXVSOIh49KbrK+DwkfuNJQ4qltDoHUejhuz1nFv3QTBLhCmBRxYbn6RxlZ5PMHGcTuR+rf7xfOkIe5OUE2gtZ0ebdda+CiI7G1p/uTLb/+x7r6gAB/ytan/SzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5e4a384483eb11f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6d26cbb1-6dbb-4abd-aae8-d5dfe5a2f823,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:dbaf429601f380af8cd06f5fc4ec8631,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5e4a384483eb11f1aa26b74ffac11d73-20260720
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 273153055; Mon, 20 Jul 2026 11:30:34 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
	Richard Pospesel <pospeselr@gmail.com>,
	Chris Diamand <chris@diamand.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Input: byd - synchronize timer deletion before freeing private data
Date: Mon, 20 Jul 2026 11:30:30 +0800
Message-Id: <20260720033030.1580891-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

byd_disconnect() uses timer_delete() before freeing the driver's private
data.  This does not wait for a running byd_clear_touch() callback, which
dereferences the private data and its psmouse pointer.  A callback racing
with disconnect can therefore access the private data after it has been
freed.

Use timer_delete_sync() to wait for any running callback before releasing
the private data.

Fixes: 2d5f5611dd0d ("Input: byd - enable absolute mode")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/input/mouse/byd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index f5770a3af2f1..7a69724c1ac6 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -423,7 +423,7 @@ static void byd_disconnect(struct psmouse *psmouse)
 	struct byd_data *priv = psmouse->private;
 
 	if (priv) {
-		timer_delete(&priv->timer);
+		timer_delete_sync(&priv->timer);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 	}
-- 
2.25.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D093D79E2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159724; cv=none; b=vFFl7rqEQiWAvLyYe/S+QJlA5sRZu3Lw5lnq1eKWWWNbPQhEx6Y510yd5C6RlIdZT3TlLetmNDVtYtDq9cQUpCSVF8YsYE1lCIiuuVXWS4OPbEzXVnL7XPF5QGUTBnVnPZStwHtcgzTSQgzOTBo8ye3M+BLFbZpfKmuv7oKPz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159724; c=relaxed/simple;
	bh=NhWMioxg3jhBRKmFgEuv4moODOgHCGHAd1AjJO6EYXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYihlzAM386CkdOVYPaAxGMBbLD13H6ggqaTQw4HkIlW6Uux3De26/AkbRaJbjf0f2sSv7DPPx1IM45ED0aCCXvJAsoEDJb1qCELbiJ5gEybLx/Ohz2LZrY0odK6neE3vcNdtnNHO6DpcMdnnDv8eIM4HxZFCZo9ZPzXuxgc1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYoi9Gi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYoi9Gi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C901F00AC4;
	Wed, 15 Jul 2026 23:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159723;
	bh=YmK7Qq8P8ja6BfOH6N8sPsM7jzfPpIs9XVKfcnHjI2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYoi9Gi/xFBPUhG2KgT/hqnylC3mahPD19xZS1KJJXY28iVSAVmkI1XX1Z0a6mO2R
	 km2hax4kooz97+1OUVFQCS/Nyxan/3ywc+g0V2ggNU0q3QX8/I6QLjY7fZhrerBYNc
	 CqljkbaKLyWSbj7tC+CShcutDCHiZFP4PlfvhimILi5R/Vgqv+dsU3Fp4sVGnuha6z
	 teXsBxID/MSlr5S+yheok6BJpVEZFRJI0Gn5yw21NgNruvheITCGWRxEN79eyR8qsH
	 +/ZvWPCnIlsObrbFqEhITs8YieICZJIDM7Tbi+ySiOgTuu8qVBKWeG0k09WM9JifiN
	 VScvb714Q5kyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
Date: Wed, 15 Jul 2026 19:55:17 -0400
Message-ID: <20260715235519.525147-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715235519.525147-1-sashal@kernel.org>
References: <2026071307-release-elongated-f82c@gregkh>
 <20260715235519.525147-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sungwoo Kim <iam@sung-woo.kim>

[ Upstream commit 4d7b41c0e43995b0e992b9f8903109275744b658 ]

Extend a critical section to prevent chan from early freeing.
Also make the l2cap_connect() return type void. Nothing is using the
returned value but it is ugly to return a potentially freed pointer.
Making it void will help with backports because earlier kernels did use
the return value. Now the compile will break for kernels where this
patch is not a complete fix.

Call stack summary:

[use]
l2cap_bredr_sig_cmd
  l2cap_connect
  ┌ mutex_lock(&conn->chan_lock);
  │ chan = pchan->ops->new_connection(pchan); <- alloc chan
  │ __l2cap_chan_add(conn, chan);
  │   l2cap_chan_hold(chan);
  │   list_add(&chan->list, &conn->chan_l);   ... (1)
  └ mutex_unlock(&conn->chan_lock);
    chan->conf_state              ... (4) <- use after free

[free]
l2cap_conn_del
┌ mutex_lock(&conn->chan_lock);
│ foreach chan in conn->chan_l:            ... (2)
│   l2cap_chan_put(chan);
│     l2cap_chan_destroy
│       kfree(chan)               ... (3) <- chan freed
└ mutex_unlock(&conn->chan_lock);

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read
include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit
include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in l2cap_connect+0xa67/0x11a0
net/bluetooth/l2cap_core.c:4260
Read of size 8 at addr ffff88810bf040a0 by task kworker/u3:1/311

Fixes: 73ffa904b782 ("Bluetooth: Move conf_{req,rsp} stuff to struct l2cap_chan")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 6fef032af009 ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 362627940eae45..22672a167ef47b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3965,13 +3965,12 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
-static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
-					struct l2cap_cmd_hdr *cmd,
-					u8 *data, u8 rsp_code, u8 amp_id)
+static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
+			  u8 *data, u8 rsp_code, u8 amp_id)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
-	struct l2cap_chan *chan = NULL, *pchan;
+	struct l2cap_chan *chan = NULL, *pchan = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3984,7 +3983,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 					 &conn->hcon->dst, ACL_LINK);
 	if (!pchan) {
 		result = L2CAP_CR_BAD_PSM;
-		goto sendresp;
+		goto response;
 	}
 
 	mutex_lock(&conn->chan_lock);
@@ -4072,17 +4071,15 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	}
 
 response:
-	l2cap_chan_unlock(pchan);
-	mutex_unlock(&conn->chan_lock);
-	l2cap_chan_put(pchan);
-
-sendresp:
 	rsp.scid   = cpu_to_le16(scid);
 	rsp.dcid   = cpu_to_le16(dcid);
 	rsp.result = cpu_to_le16(result);
 	rsp.status = cpu_to_le16(status);
 	l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
 
+	if (!pchan)
+		return;
+
 	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO) {
 		struct l2cap_info_req info;
 		info.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
@@ -4105,7 +4102,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		chan->num_conf_req++;
 	}
 
-	return chan;
+	l2cap_chan_unlock(pchan);
+	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(pchan);
 }
 
 static int l2cap_connect_req(struct l2cap_conn *conn,
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491955;
	b=BdtcQSur9As4CdQxPORbjWlQfCSC9m9oQVTvftxS9rKS0VNte8JSmBGF1FHnDgu1mSIz
	 06KxeS+xdCq/5PnkntMru88islGpK64Mxhq881xO43zEWarSqoF12G4AZeGO9aV4lKoQ3
	 O612kuYWbby0oRw9ekSxP6qdiRni7hBVCl9FFUD49mbBsydTGJwRqJi1bt/nTSeMT7Tft
	 Ry0gvAK4uHRULQkya2zOg587+PlSuUuqERCn3nahyvUXkJ8xCsacJPmQjBkc5HalxqlwL
	 pl8FrF5ZtDwiUIMjrTcsooaYfqNJvow51aX/uNb6w0utoBBZ+9d6eagVr36jPNGfNFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491955;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=/4QK2VEVaNUR4dD+Jet/7ljypHn8xGKD/HMMFXFMLhE=;
	b=YaGOtYj6OvOm1cbgZukRVGOIabyvEak3uUsFWETsruQqxM/r1P+B+77y53xuYASMgxNG
	 NJyyEdkduf2tB+F18q2YDG2ejCyn2tm6caEECbkdmOdQmRNSEzgdTrU8dpsFrrJXac6HK
	 60h+eaOJ5Oae4bruNDCOFRozchvVruEOQLmLUdDfE2UAGExbjuDuYDof5QmZeXrQ057DH
	 HJi+z9t1uIEZCDCSIVsGVbDCYJXXGWDoPWVjQPyPoKYgTdt4a2qkTbBhcGR9GWMObJKPo
	 6MVuZB/bkzZMgoRK7/qk+EbNJReVI3W2G39KbHifMmvalNuiWjKM4ZrCOI9rIUaN9MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=G5U7PRNw;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472B606A31C;
	Thu, 12 Nov 2026 13:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B472B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=G5U7PRNw
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 547738928;
	Thu, 12 Nov 2026 21:59:04 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: atr: Fix potential alias mapping leak on adapter removal
Date: Thu, 12 Nov 2026 21:59:03 +0800
Message-ID: <20261112-88a3a7ff32-i2c-atr@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d00e0cfa03a1kunm425011f329f5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHU0dVkNOQ0tIT04eTUIYTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=G5U7PRNwXp0pmXHBJLe7+5q5FGjsvbQ4GNSbwdqPeF/6u92EXhZuid39c9To/DVW6/bDDoc3ovjgnqlznvP4xhlhQt8cLGr7R8FEjm2N8N5ACG5u1jrBnQt4M7zWcExQuOlzXtlc38yfcKYa/PgwqUYIBYCj98iE5XFBjmGhKrY=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=/4QK2VEVaNUR4dD+Jet/7ljypHn8xGKD/HMMFXFMLhE=;
	h=date:mime-version:subject:message-id:from;

Transfers to addresses without registered clients can create alias
mappings. Removing the adapter generates no client removal notification
for those addresses, so their mappings and alias reservations remain.

Detach any remaining mappings after deleting the adapter and before
freeing its alias pool and channel.

This issue was found by our static analysis tool under development.

Fixes: c3f55241882b ("i2c: Support dynamic address translation")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/i2c/i2c-atr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index b98442ffff94..ebade2a000b2 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -903,6 +903,7 @@ EXPORT_SYMBOL_NS_GPL(i2c_atr_add_adapter, "I2C_ATR");
 
 void i2c_atr_del_adapter(struct i2c_atr *atr, u32 chan_id)
 {
+	struct i2c_atr_alias_pair *c2a, *tmp;
 	char symlink_name[ATR_MAX_SYMLINK_LEN];
 	struct i2c_adapter *adap;
 	struct i2c_atr_chan *chan;
@@ -925,6 +926,9 @@ void i2c_atr_del_adapter(struct i2c_atr *atr, u32 chan_id)
 
 	i2c_del_adapter(adap);
 
+	list_for_each_entry_safe(c2a, tmp, &chan->alias_pairs, node)
+		i2c_atr_detach_addr(adap, c2a->addr);
+
 	if (!chan->alias_pool->shared)
 		i2c_atr_free_alias_pool(chan->alias_pool);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620259;
	b=Cp/cmLmk3lwzk9WYmW4HaDJE/FFHq0J6kAMJgucAxqFCT6i0uuYYxd5Io15WCtNL3jjs
	 HhGmCU94L1NN99+d3L14qYexriyNuNU2sP06nVg4i+WTXH7Z3EE5N9mkdXJoRNC/8AnJw
	 71oK5q9cZj4M2eWClRpXyUDh4NiUclH1YOt8nMst2FjqQJ0y0j7ln420EqcLZKy99krG/
	 speljuOWnP3PEJ+RAxYo6EJnyy0oaGemgqmBEFilFSnFfAunQpivCYiqh5ciq3S/RbLlj
	 S4A21lx6bIsjJuIq+31vAlxj8H/EKd0jatnIOFVd9Vyy1g9BeZfSZzPF3qU0hzXFLjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620259;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:References:Date:Mime-Version:From:To:Subject:Content-Type:
	 X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=LNqxXIZNaAqYfHTltarRLdW5yFtdpVJT00hDqUHTe5Y=;
	b=rTwdWz4Kxy0tuaL/IPf+mDPDZCdKD5uUCiIh1gb+GUWRwZXQ5lBHKAH9HEzRBQWrIpex
	 FiAeNg7ojlQdrwVSbNOMx4PWtLqOCErUi5EQYW1aSBAgqq8LkgxIfzGxe2ewDVOLtX2Ee
	 dHnRfiAKLv6xjF9Vwz4Ag0wuHki5oCfd4Fc1neuU9gJNipz1+pnu1oWcnm3Q04RDJfCQw
	 OmLh4mazj8uFoapkJmuhZ65nCOBZ7jaKBTGHezR+kkSZebtr7tlsqLAvSTl7pJI9w2l4X
	 1+q6EFSAAhcN0hrzH0icBNstqMlQzS4nzwhYhH+cQRRu2d0OM5CqReBdYpPP22BXtJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712D606A326;
	Mon,  2 Nov 2026 11:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E712D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJ95C6C7dz8Xrrc;
	Mon, 02 Nov 2026 19:50:55 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A2Bonwm068879;
	Mon, 2 Nov 2026 19:50:50 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 19:50:52 +0800 (CST)
X-Zmail-TransId: 2afa6ae8791c8b0-7a746
X-Mailer: Zmail v1.0
Message-ID: <20261102195052961juHOv3LqlGtcYgvGv708m@zte.com.cn>
References: 20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn
Date: Mon, 2 Nov 2026 19:50:52 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvM10gdWJpZnM6IGdjOiBmaXggYXV0aGVudGljYXRpb24gbm9kZSBsZWFr?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A2Bonwm068879
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 02 Nov 2026 19:50:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE8791F.000/4jJ95C6C7dz8Xrrc

move_nodes() allocates the authentication node, writes it to the GC
write-buffer and only frees it on the error paths.  Every GC pass that
moves nodes on an authenticated file system therefore leaks
ubifs_auth_node_sz() bytes.

Free the buffer after it has been written to the write-buffer.

Fixes: 6f06d96fdf62 ("ubifs: Add auth nodes to garbage collector journal head")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 933c79b5cd6b..2b0f29423f48 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -427,6 +427,7 @@ static int move_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb)
 				kfree(auth);
 				goto out;
 			}
+			kfree(auth);
 
 			ubifs_add_dirt(c, wbuf->lnum, ubifs_auth_node_sz(c));
 		}

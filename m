Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621564;
	b=0bOLh7qIw1m6DLbO2b+eilPHjm9wGuSArn8jspnc6FvsDsUrJfv0eVObyqTju/phNaID
	 ozI4AY0ofwn2QKxIlSCIO6ypFNZn6+mrMcUQt6jre0dpyNTlDbBGaPkkEuWVHLwCoNABQ
	 WdcyrEb1l67LAZ/zCXIbgFGM9iOvxfVfy30XxvbzQPmUAgyGrzpxW+udi40Xe/eickroD
	 YGcLXSqt/1z4zPfr42sNxc+oXLUWqa1MNLZYEq08rs5ypcqC8127jdTLkfSZ4jnoBuEu7
	 iCofTsN6/llgP8Zs8Dpxbzt3MKpsxLMTt0KsFDGafFzQ58X0oGItPiGcPR4e9xgj+5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621564;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=LNqxXIZNaAqYfHTltarRLdW5yFtdpVJT00hDqUHTe5Y=;
	b=ll1x8u70OjHsgXWjuapJIlmUG3kbklsgTcucENr8ATNWqR/oZov3Deq5e9JyFKg5mTDv
	 gJZdiNFEPHVlQ/gCcLeHVmhK35WH6IfkI1oj9XFk7NXkXOWAAQ3KWH3VwOcatyNb/H0TM
	 TbgnzJEkegnbIs5E7b8iqmM3T1U1hB0XlcQqsE3kaaJXg0qPRjaNX5slVUjcWNNFR/hK6
	 aNLW5CqA8+baNV0MCJiECahCMf1piRWm1/yZuTmBA30UsQ+1AeHLQmwh0ov5rhWeZZA5V
	 qi/XvRrkfmHZNx10AgyBKzhAVX8+NA8Z650uRjZYZo5ParBIwKgrtoGGbfUjKB1hswg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3B606A337;
	Mon,  2 Nov 2026 12:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC3B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJ9ZK0hBbz8Xrrh;
	Mon, 02 Nov 2026 20:12:41 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A2CCXo9023196;
	Mon, 2 Nov 2026 20:12:33 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 20:12:36 +0800 (CST)
X-Zmail-TransId: 2afc6ae87e341ad-97026
X-Mailer: Zmail v1.0
Message-ID: <20261102201236377NBmEu0bSIAHVWZO6liD9L@zte.com.cn>
In-Reply-To: <20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn>
References: 20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn
Date: Mon, 2 Nov 2026 20:12:36 +0800 (CST)
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
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>
Cc: <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvM10gdWJpZnM6IGdjOiBmaXggYXV0aGVudGljYXRpb24gbm9kZSBsZWFr?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A2CCXo9023196
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 20:12:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE87E39.000/4jJ9ZK0hBbz8Xrrh

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

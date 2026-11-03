Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687093;
	b=lPqaJRi5SxuxlmFxUdAOS/oHSAUwPewRTvzbjDJv4JKDz5Kp56XamEKm2iFnKnAnF/Xl
	 eD1tMU4gbdH6IGiVV2FTqx953943QMa6u8uRnyX2qkGLvAu/wDMu5Gua3vqCj7bqo7v2o
	 uMrRPqLck7NGx8SIq9Sx6ow/HNblQ2lfPwm1t/1o5BhI0uoYMPWMZ99t39rtnzAvjbXAx
	 +pnTo115RmOAKTjAbVu1tsWPbIRMMLgcbxCwsUXwLnIXwDjC4qBEuF2Gkp3SJLaNmJ6Y8
	 n+o+639NlJg1rxCqFBwliCUDFdEAf8/TsCXIoJPbvm9gzypt3KmjBfm0wxZVlRSZoHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687093;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=eeZeY70kXLLXQ2gRy/XNnXtmd+92VeSsXHtBr864MHI=;
	b=1pgfNLS5b737hMSuFEwlni4ZTcUPraEkN5OT136IJ5ndjJpbPhm2l5imQqTmY1a4eX2w
	 ZBthgYyZ6zSBAO1rY0mRgltmKpFr+c5SVvRkmSebgwP4uKz1ZgJ8OhWqJoTE0tkUicsA+
	 gJzbMKWlqxcXFltNpSe3hxdT4fcC0dvmX54fD0XwKM0nkntyvwIVUCc2jtWa2jnjjIvyP
	 L+O6jC0OdNqLR38dmbsaGLswlvqDGIKiIO0HPZD68Z+PBWpqHni1rjoH9nmh6nH5YI4Ii
	 4cpkl9Paz+Qd6Pvy9Wozosf2TpKQFqo5qD8KCv+HCyfV/dZMhlG+yG8VlOc6Fax4SSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0E606A324;
	Tue,  3 Nov 2026 06:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1B0E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJdpV6Wb6z8Xrrh;
	Tue, 03 Nov 2026 14:24:50 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A36Oee5009328;
	Tue, 3 Nov 2026 14:24:40 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 14:24:42 +0800 (CST)
X-Zmail-TransId: 2af96ae97e2afa5-cf8eb
X-Mailer: Zmail v1.0
Message-ID: <20261103142442501gxpuxmM4sK7TCoDREZdJo@zte.com.cn>
In-Reply-To: <202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn>
References: 202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn
Date: Tue, 3 Nov 2026 14:24:42 +0800 (CST)
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
To: <richard@nod.at>
Cc: <linux-mtd@lists.infradead.org>, <chengzhihao1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvNV0gdWJpZnM6IHJlamVjdCBtYXN0ZXIgbm9kZXMgY2xhaW1pbmcgYSB0b28gc21hbGwgaW5vZGUgbnVtYmVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A36Oee5009328
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 03 Nov 2026 14:24:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE97E32.001/4jJdpV6Wb6z8Xrrh

v2: merge the lower bound into the existing highest_inum check, as
    suggested by Zhihao Cheng.

diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index a148760fa49e..e180091fab8c 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -186,7 +186,13 @@ static int validate_master(const struct ubifs_info *c)
 		goto out;
 	}
 
-	if (c->highest_inum >= INUM_WATERMARK) {
+	/*
+	 * Inode numbers below UBIFS_FIRST_INO are reserved.  If the master node
+	 * claims a smaller value, newly created inodes would reuse the root
+	 * inode number or another reserved one.
+	 */
+	if (c->highest_inum >= INUM_WATERMARK ||
+	    c->highest_inum < UBIFS_FIRST_INO) {
 		err = 3;
 		goto out;
 	}

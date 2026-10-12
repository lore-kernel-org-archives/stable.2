Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479F4A4F00;
	Mon, 12 Oct 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819822; cv=none; b=OjnSPilNZBCZaSL7H4YFi916YSnOTp90vWYJeRwo4mOOP49ACrcdXcfCQol8I7sYQhb5voLidGhnAoPryP/28nahRvjVNsnZ+Td8Ht0M7tEO49ZzN+tt3zPGYAnOVLVNTmua3hbf8zFdQlxSHk3XSESVnH48Ha0VN1bYeWz0OXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819822; c=relaxed/simple;
	bh=6xQcw7g1bvhnk0ObeYgJSCmrI7NhNqdrEmULoZW/dXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pO6yVbpiUiPtYdY6Nx601BbuI0/+So5AOeyRD/LC+Vt0/w4UWm6OiJdi1RXj6NfTUSP48/dFegtsnkMzwTFxmilvs9RHXb7uCsFxTL37N+erbwqCfl4p6iKaViqVyxAMUxIsWhzwC6x5vWzqORhkFyjw9QDZFggxtL3jQquBn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hMyCB2NV; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hMyCB2NV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791819789;
	bh=hV/umWOvbkcBevdYzEmDjmcKrs9VPD4XBxSvPVlQkFA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hMyCB2NVKli9FTG9RWX//2SMMbQkF1wqayITsDu6Elw4olBvowG44XU4ZMDeYAVPQ
	 oOU9hAe7BTrzLUGoLpWDWvPzZ0YXbif7riwbFVmrJ51g+arzY5o3Hggifkd7VMEywP
	 Uk96gw9wflD6+N09mXGcZewxW60Xouy1EOZiwC4E=
X-QQ-mid: esmtpgz12t1791819770t572b00de
X-QQ-Originating-IP: tGa534g5NuUdp9e9dmQIksdzgJ5wvxcloWeTReGrces=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Oct 2026 23:42:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4210704846734550082
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	kartikey406@gmail.com,
	harshit.m.mogalapalli@oracle.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.1.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Mon, 12 Oct 2026 23:42:46 +0800
Message-Id: <20261012154246.1233496-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MXb7G7hxR8QF0Q/xf3MDk9YGIMfmHkQurrkagw84VijXQ0nyV1yroMSx
	/fNTskm7UrKneX5jFMZctghCJGH/TNaf+vJZhG6zRe/F8ivfDn+RMVo0jNLEocA5gh+E9xU
	0BqVv8fcmPNMA7PHj2F7bXXPoGYlU8JFnlWlY7ojVpElhqMKerprzo016rniGws37lTLjGF
	2WOS3Z1DC58momksmkv0rXV6iCFBn601EVhPX/rdmcHp8wmoPFVwfuM7Ghpr/ocFvwOUz+V
	/P0ooXOo+k/hiQ3PuYtGXAkmvS3XDz7cH4H6CRHWmFfZakgGu3qaq90vsfHaf5EouNA8FiO
	+Fcjx2MUQj/+sqjPzyarANOpMqDGiPiadf4NjnxNHi6jAwWfuNYZAu3eJ3RotbsgqpYHzXp
	JPSHAumuwebbsRtEbFqCt9aD3EtBysIsLD1bBHipCbU2Fvcc6rJ2rlbW9JtKcjlaVKxxU3u
	OZCtpXFtN51PZ7NezfZ8/iLaeFzHiYZnKShScOExyQtkmjJ2gYaw1HxoASd/hn00V8y3xvh
	T4+8Hid+lXD+oJD5MKTnPiJDDnZmMqKjAYwOSKQV2c8ncaphk5ujv8QkdozK+yhMed6dErB
	hevsLXb9HkT3HxkMCWBt+ic06VTrMUaTMLcexmLxjFgmKz+GlIkX9AV2fxEIxvFeY/lKdPt
	gjAJacDmwgDB/TdgpbX0YGkaKp8z0BPQ0dtZ2WRbzC9L0kjOGrXNJ0Y46dfHEazSxYtAVIO
	8WxrrPZtdh0HYkW7EcJzch5MP4gtLJPiOinWZpmGaBHYOVaGLQhaeDvbt77dDgqWDe0L8PF
	wWprs7RE7zmDiIdxUW+Y1XxlGut4eva3HB30kLAOFJ8u2XS+F/TFjvDUgKBUoLhoc0HYR49
	zRMVDV6/9tjMf3eo8Temn2DY7h4a0UtlXn4JLQ6GNW9rwPcwr4D06PxApw0Hu6VXahKvoB/
	REw6P3bZ+hgKCicAp+gvBW6r5rSBUqAGaS/SI+tShj7l/nJ7wPIwUX+Ou0TQ79K6dQJTSbx
	ysn1arPJTmQm9Yo96i0bkciLxITB3NJ/iIVmKhg1vW4+8yQ5v/vU5m4qwnkPiFPD9+MCizM
	b7J665OXE93tx+Nu6VNMEsF36ydPfzUL7qwdGNpfgsL
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

This error path returns while wdev_lock() is still held, so one
malformed IE request can permanently block later operations on this
wiphy. Route the error through out to release the lock.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
Fixes: 8b921a899346 ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/wireless/wext-sme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index be121fa36c514..ba6d8827f64b3 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -352,8 +352,10 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 			/* nothing */
 		}
 
-		if (!for_each_element_completed(elem, extra, ie_len))
-			return -EINVAL;
+		if (!for_each_element_completed(elem, extra, ie_len)) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		ie = kmemdup(extra, ie_len, GFP_KERNEL);
 		if (!ie) {
-- 
2.39.5


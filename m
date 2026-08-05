Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0B344DB5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951707; cv=none; b=Z1mV/qCbGr7iEkEA4NEDZkDtX5AgpYoMQjeoWup65v3hTNUhUc21cXJfBlCyEDK9qVdJPCBvAU8UyH9fZnD2FkqAUpXrd18fbmcLeFko+36LXW88u02SbEfjmwTXRU9PHNLZ0RA95SUkAyOOvLDdHO8t1vbq6R81wH/16iO3hmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951707; c=relaxed/simple;
	bh=J/+L2oUAff2xtion7+DNej4z1akgy0hG4O562hm7E/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFojtvnyCnWZrhqizJiEvjxGEims7VmXHWDLR+OVIIRIv2D9C/qSaMRh7owQ38bba0w12NjUcYvw9wzXF2yPBxKwP2WKC6LcXEB9NJ6U8l33qhflwbAWCfyRMEUWqIrjKyTm91e8qvHLayqgGkNvYi1axiTCGe2pYy/WOe9Df4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YS2bCX1P; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YS2bCX1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951685;
	bh=KTSG6PS4F3THrygwe0WvpOAU0Tar12qhZ32fkqQMoig=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YS2bCX1PvXintD7hwFcZZW2kRUmCg/mIktE+YVGBKsa7w/p/XPsseCfKubtfe1iym
	 R8l6Cwvarp5ldlfpNxdfoEiBZcI4MSgNc6FGSZXgJ56SBVdG0kPx7EXL593hKyOzhe
	 md46OL4ZzARA4Cd6zqctg7mi9OxV96e/2SqvQyms=
X-QQ-mid: esmtpgz16t1785951667t9996d430
X-QQ-Originating-IP: F3JXF9w4lhY9m5QR9RmBa2yl5idpZGSAGzAPdpj+8dM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:40:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7127773513636345103
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Christian Brauner <brauner@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 3/8] net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()
Date: Thu,  6 Aug 2026 01:39:56 +0800
Message-Id: <20260805173958.660310-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805173958.660310-1-guanwentao@uniontech.com>
References: <20260805173958.660310-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NnSC/w0LuVTXRgAqPMPEnpTCfBePc3hWHYGLsx5vcAJyYO7cmwnsJ1cW
	zxuBQBgJOUY1/1v7TDKhEFg5rwDNARant0jYeC1Ck68xfqE/m8OpmrvUMWUOgLNW6IeCrIu
	rZYjVPdgIu+09QPt1K8dAQi70jZOGzU8TdZEdVst6zngfJViwrbhj1WspBB1T/AXf1Jy+rx
	k1iBh4FpyNXQdPk6utC+i7uFpWm17s3M2qYfq+91NLS9WW6Bn3NRHrEkcN+0PFUN3RmJgal
	0yJAyMViZXVBF7zAwTbCuvLzoqNi4hC72kpehQXOkR2G0zp0UfaKQMuaqgVtGE1xHpSUifN
	WG40Z0iXBZ+3p21iDFjIuZSDZrnXaFszxidN8St5lW5ZrTrnlfmBYKnxYdejEMUYgTQsXSM
	vS31jvkzUoEru8EWCsgtJApZoxDXPmoe/IDKbgNI+51QlWHXmtEitK0tXc3pHrf6vaTXUA7
	dn3Xr5W6vGgP1yCrwfrLfe0BZ6ZgSYCqo+0R5bBzn3DJ/jeN91rMo7+XFWLdzFFBXOHHNGK
	felmJ46Gk6pW4tlBhR1A8XDhgTAD+7rflHA72dtMXa/uA9Jx+yxbKdlVbNSIHdpN3euLykP
	xa61vvG4sDnpwcOFzjhe9OujwG/fR+KH+yzw2YwqnSkFlEGttwqbuIIK4UoBZczQQy405JZ
	cktgWQFmqjwZlFES7LfKt9ADabyKpe/Xq/PAbZAg++o59gP/badyxBaP0Akbfh0jPKsFEhZ
	4NF5N8VKqiLyP7ConJR7MAr5yhlWO9ipZn15uC/UV5gr7MVOPnXCv5xHj2a0Pu0hnEJexFB
	E2bbgcyD2//yJxKVTwZgHUWaHE3RES27jASg8VTbmiVjoTLuXMfiZvxVjgEBsmdNfkmG2tQ
	pflCP1gnI7GY1Ccrg9AuWRM0yKope6nzKBMakCiaPM+OHu1GvnWsM5x0/uTQ8c0hK6+lVES
	as69iTS5F+qdlZR1UYT2pRUSn8/9VP1fI8bNKfCvzVQ1e9m5icxGVTJn2J0FbeuYOt3gSCt
	1rNaxDLbZM8WHlQvI8Co1BZvmPyUUU+W2VCHwbzwlV6i1CB0vINvmcf1HNw1kzc0vXvjckJ
	cv/qr62oho6lcMzYnpMQpU88tvTGeTsZcCfj4+cRYgIAhVw5+XM/cE6fEMQet0yBGTGc2HL
	GZ5ZEaz2Kf/EVcc=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

Link: https://patch.msgid.link/20251123-work-fd-prepare-v4-27-b6efa1706cfd@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit fe67b063f687d8f32c466778aad57508bc1c618a)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/handshake/netlink.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index d8211e0ba75c6..7b1d42607ae68 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -93,7 +93,7 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	struct handshake_net *hn = handshake_pernet(net);
 	struct handshake_req *req = NULL;
 	struct socket *sock;
-	int class, fd, err;
+	int class, err;
 
 	err = -EOPNOTSUPP;
 	if (!hn)
@@ -106,27 +106,25 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = -EAGAIN;
 	req = handshake_req_next(hn, class);
-	if (!req)
-		goto out_status;
-
-	sock = req->hr_sk->sk_socket;
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		err = fd;
-		goto out_complete;
-	}
-
-	err = req->hr_proto->hp_accept(req, info, fd);
-	if (err) {
-		put_unused_fd(fd);
-		goto out_complete;
+	if (req) {
+		sock = req->hr_sk->sk_socket;
+
+		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
+		if (fdf.err) {
+			err = fdf.err;
+			goto out_complete;
+		}
+
+		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
+		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
+		if (err)
+			goto out_complete; /* Automatic cleanup handles fput */
+
+		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
+		fd_publish(fdf);
+		return 0;
 	}
 
-	fd_install(fd, get_file(sock->file));
-
-	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
-	return 0;
-
 out_complete:
 	handshake_complete(req, -EIO, NULL);
 out_status:
-- 
2.30.2


Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF983C8C43
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950364; cv=none; b=h6dNatuFE5YVg4Nphy68cs8Heh04ITUSxG9H73Jxdcu00tc0EWzZve1aVKAhsp+duHsx7EF2V4PR/Cy5c/fNZuJaj3fq9VCdf0tJ4EjBdLxalvmlVd/wG/DjaQWzszqIROP80mRrqqtis8I6kwcf6LQcaK1L0m53YI+Q8VKfv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950364; c=relaxed/simple;
	bh=J/+L2oUAff2xtion7+DNej4z1akgy0hG4O562hm7E/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4bNaBbZK68wv1i7ZC8nm/yHxG77uUAKK7yqWq27k64crprhpbSiigy7Fu6I2OWs1m8TOZYnMv46xZmtUaiBQsGL3TgUODjrBejv+SHjHJR49swU1GztUWrM5xfl54tPYK1Qn/jXlmCb7053SOIUDI4RCoTG15jIOFEQxkDF76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Jz29TjBk; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Jz29TjBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785950335;
	bh=KTSG6PS4F3THrygwe0WvpOAU0Tar12qhZ32fkqQMoig=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Jz29TjBkhNU78xXPe6AY03rUFPWC3E938HVVdDTHCZlqE71CNRSgnNNWHAyG5OVkj
	 8XeQXCLu8bmbtx4gpTxfD3PVc15jvnJiGymkzq0CzGw3gdJ6/M8Srwq2jzEP3i1h6v
	 c17ogE3PEb9suNVpN3wz9gaWmzqVW3KliKy5qfT4=
X-QQ-mid: esmtpgz12t1785950317td71e7324
X-QQ-Originating-IP: iBZAYU048uxNnzMe9QtPpx9fBny1IWZQgYTDjfS5HLo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:18:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7198757207188803485
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Christian Brauner <brauner@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v2 3/7] net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()
Date: Thu,  6 Aug 2026 01:17:41 +0800
Message-Id: <20260805171742.654530-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805171742.654530-1-guanwentao@uniontech.com>
References: <20260805171742.654530-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ObFHHlrAm440ZAMxa6rkZjw2yWRuTx986dN+17KCF33lnQCwTk6dv6g8
	fykhKH/esThuO2kLPoRKjAd/YEm7DWqAV1J/AOa0V5ChUOH+OWGMZ+nWuibF53qMVgpIT02
	bGUM1LA1KSn8HsoYLn8Uo9tSBLIUvc3X/R4Tz60ZD1F/L+edzujU5jF6qXTy+yrE3LIi5S2
	unH1XBsYVNmYtpLEF1yYspC23gJhZO6/hngBABR5+L8zqvcc/e/67iID4akW/P5gPkSsEZa
	0OHf3VYU2QnGYJaTOSpAc/8NGWc11BaBwUEw1jdwxQMbmh0wpRRYYMeGUT4ihYcENH+WMDG
	UGdLSfbmPkpleXI8xYWSXAygUB9DOVwNe9Yeltu2rGSDU9AfZhq0sLosNELF8/ksIT3TiGu
	ENZHuWKgOD95ss40A+RO0p6VGGpafSmX/QxKm4s2PRJU6q1V5EsRHcyTN5l3t2gNFxCJqBy
	3nXTl6n8cDFiuWwbHCEvpmypz/HI6uD90nhQ9M/W8rBNneI/7ybqMHvTKWqYaY6ti/mSAAU
	Qo8HPor1ZK9XhWSc+7WuookWTaos+/BJJGGrrJgXmlcCPfudo53npC94sdQKiOxNvlVm9cg
	tHg4aK9EgfKzP13U3T/Hl9YdAKW0Zea8cy90AqeQa1vsrnvsYSJarkbgUWreoeb5njY6ah6
	wa83Y3+tmT98LQjB5cceUeCA1t1sX3hcnmZeDTjcneZWjJ2AOHGLDS54uwTtg8soPi0oR4T
	C1K4MSxUYG72jP4J2RZO506gCaGSAffNOEpomf5mN5k+mH/s7w50InOT4JQ+29BJoydd4CM
	y3HY4fE234Ztr0R3w0Ng8E6Q+frEygbgP4mju2F3O/WcxRs4GrrumvJMo03W7NSXr7wTfKp
	umksVGArAawhMJgKtA4TKSTxEdFTffM5QsGx4hxIXsRzqWXaylDs4QbroKRtPC7Ockyn2Bb
	eprW0MzQU/wheB2x4DB8gN6ux52iOb49qJTXk6ySa1D2VoctZ26JttqraSfepNopem9nzPU
	XrPNZ08dAEkhoSChrz1wPTYebi9Vs/cvHe8wg2D0mWv3kWiDyTQW5BI3Q1tx3WHYsJ1k2S9
	rEKOVVsGUqZW4FxNfKt9LM=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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


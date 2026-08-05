Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CF3E7BC7
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921335; cv=none; b=t8/wnHKpajSHihhPMZo7mQk7QCdDaFsPq+bCyeN7Jl7k64oATRHl1lvN9v2OTuKSzx/egm2z47MgjwBDpf6ius/0BZQDPZyu/pfND9G79wV7wvHgZztYQkeDJHVMIld8Ks8rF+NsOYToBOripREAR7ndgbz5qeobWP1PUD1aOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921335; c=relaxed/simple;
	bh=J/+L2oUAff2xtion7+DNej4z1akgy0hG4O562hm7E/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Miy5ZErlnJt95kH/fb+udQTwCKSlm/CzWwzo9nvEApqZnanKIfqLsnLh549iX/tIg4EiNQbdsFQ4PTk1OpdA8fNXsegS+Rn6g1438MzY8ujo1s++bYiBvX+bguHrBHGUGy0SEeLgZ1zQxABxGlONRdkYf0aB0nnvScOzoAFPpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=pYjpqTpS; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="pYjpqTpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785921303;
	bh=KTSG6PS4F3THrygwe0WvpOAU0Tar12qhZ32fkqQMoig=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=pYjpqTpSRBgX7jBgexVpm9SG6aLrQO6EgctF0Xbza56HEZ7FzdlyeME+ODrwa7Kja
	 mtWDwPGfzlobQiznKh6wP0WWSu4LNpS784gLTj7Sbv1EslMylZYjtmKcXzBv1KBUWM
	 skp4aJVx6Uw++PvHjmDPR5j9pPdpWz3GCn8X/Wa8=
X-QQ-mid: esmtpsz21t1785921285t8c9e9b03
X-QQ-Originating-IP: 7tVY5MLGp04uogP7o7T4VX8C64p+P4SwcL1+aAitRtE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 17:14:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2780590021561648818
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Christian Brauner <brauner@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 2/5] net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()
Date: Wed,  5 Aug 2026 17:13:48 +0800
Message-Id: <20260805091348.609325-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805091348.609325-1-guanwentao@uniontech.com>
References: <20260805091348.609325-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MRglurmJ/mwmZvSjSSHXwavZYXz38z4f43t5voysYtenBDKjPRb6jVkU
	3D3xtU7uwXqJeOV/ukaAP298kYEQ8kduFWE4mASNLVnsPhq6oK6dLZHFpO1CFJ8C7Gjc9iR
	3rtjlVGcP7n2K9bA2EJzdgOs0oIL3A1iEnOK0rBn3l2/8NTvFJt6A0nxssLd2iwzTUJ8Kmu
	0awMBQlt7rxZ/dTgWgj36GtHiAXUeCg79QHA5BpSVYdNx+iJS7wU4hGHO4jTDeMDAJxVem8
	nhbTYlznMzpYguOOb7n3CFlfd+fIDzHHtCuJI3/yP0kHvih2LYVCTdv2yrb2wQdLhExA13E
	hSKz/81kZunedKEhZPwmiRjPjRvDGHlwTFeZKDeLGI5k3qkm+uaL2HDO/eNlWlDS02tMfYl
	nWy0sYF8yGOs+VXMVTrgCC3A9Kt6mLAlFPHsutI8C6STc2R7Vdf7hbMJ+YHjA3wf+WMYu4t
	bDtiNHX3/5GjuCDEouFQBmOUMmOKkuh0Jre22P1/Hc2zPQ5B0NYFfl82LNNmKQxhflNNTM9
	drxS2i68RrcQewXj3xHYuABIjmAdJI4wU9GPMsF1qJVnTutA6a0Ex3btvnuPA8Qa7AZvwFs
	2T/ZChAh1Yt8sKyLhF2GtDVFI0XGlQl97AmVXaJl1QrU7IhACA4YSlq6iUrfIFKriVC7BAi
	lGafrZAI+voa3ogwj/A1U0miTqIcBtRMHDH23+1JcI2QNZNTjo72D2HZjTLdCQnRAMFu0nQ
	2JKoJT+8HiRgx30uETZRbVYt3ZBY7YfcOT3B2NXv6qpSBHFPwDrT6tM67kChq1Eq0WYdG5t
	OeCwac5+zqOt/9juGfwkQo68BJn3BHfOJk0RPtonqljVSUeRJFEJlP997mUidOqqIoENSeR
	CoS90pV/ONoY95irHRnJY1IfNnltwi3qQ6dKNQs88rM+Xb+cAXB5yIysCzlVR9uUtxZTE69
	SRwiPZWnzFwWy28GP1+/Tu9hGN4CvalDSPlpk5TWrjiwFKrHMKUrb3EhABRxZSSr11Fpeo4
	psiLwaUViZorOrsntO6A/Dc7UAgwH/HOc2udxEwGiwQdWHHOMkgpSqNFBPYoMN2g92cGwhp
	Nn8Vj7uNPqk8TTXTu8SwLQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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


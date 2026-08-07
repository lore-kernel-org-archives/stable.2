Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC344237A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103328; cv=none; b=mGK7fzNS/XMkJmFA0PZcgbWedP8FNtVsiUSWiDfQ0XA3cAMGnpC2uq91hBfSssep7UjUObsC4OKBDTEWrb4e1UaHBPeaYisXLQTKYfDus3s9fq387oYt/rfM8/3aOekhUW1LMQaQfq4T88kZS3xREPRgpE2NS5ilz3zDsEoqlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103328; c=relaxed/simple;
	bh=IJO+pudBU5vPl9GSPJEofCC4PUyKmOBdWXsGmEXeacw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDr3wBHqYbWI9Cd8hFSpr5fVpzZK4K3SpZpZss5Dzb+y2+QCiw2geUNPgNq7TBmZJ7CmWb0CGCSUIDErwDOhOin5xCBgslOzZEeU1/uryJIlGcp+PqBOQDa5l6egZsvBLZdJACSNFC/Wfan8kU9fPpp8oJ9BMjZOD3S5X9n1szM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeD7LLbF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeD7LLbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946311F00AC4;
	Fri,  7 Aug 2026 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103308;
	bh=qu0Lb0kUQvY/A6lAgGo1E7663iGZTp+YFmN6rTqWtXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeD7LLbFg63np+qL3WRFh2F78VNVhfIkao7+HuJHkxoZaKB8G/UF/8ibHjv9uV3Xh
	 y+t8IaNRGNmQ2j38iltiwbBft0zuRTp/XQbxxuApFH19XXilBiy0DgirHZX0WskB/u
	 ltsYldERsTOzE2XeVuCKajDIXfA2BoMD2okQ1utNPVMgcqp/vYuuoho6U5C9Yq22vu
	 HvhHJcIYLmattonJf7nNNT7p7JUts//u7KNsdGcrcltG62+JSEd1ozA08D3yug2bMX
	 t13tDDVKrlehObOIj5k7EdpMLpvpEDImHoNDaTzUuKKO2LbZ+JHhUljkvbdY1yGWZ/
	 lXiy9gfCMb5Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <roxy520tt@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] sctp: close UDP tunnel sockets during netns teardown
Date: Fri,  7 Aug 2026 07:48:23 -0400
Message-ID: <20260807114823.2056694-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807114823.2056694-1-sashal@kernel.org>
References: <2026072946-amulet-patriarch-e5e9@gregkh>
 <20260807114823.2056694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <roxy520tt@gmail.com>

[ Upstream commit ffb2bd7ade36ec4da32c46a6eddbf4515316d08c ]

proc_sctp_do_udp_port() starts per-net SCTP UDP tunneling sockets when
net.sctp.udp_port is set, and stops/restarts them when the sysctl value
changes. The netns exit path does not stop these sockets, so a namespace
can be torn down while its SCTP UDP tunnel sockets are still installed.

Close the UDP tunnel sockets from sctp_ctrlsock_exit() after unregistering
the per-net sysctl table. This prevents new sysctl writes from racing in
while the sockets are being released, and closes the sockets before the
control socket is destroyed.

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt%40gmail.com
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/6dab75f22855cb219e2e30a5497cab03b970ab91.1784033357.git.roxy520tt@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index bc1bd3a454ab3..e4b4575708464 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1471,6 +1471,7 @@ static int __net_init sctp_ctrlsock_init(struct net *net)
 static void __net_exit sctp_ctrlsock_exit(struct net *net)
 {
 	sctp_sysctl_net_unregister(net);
+	sctp_udp_sock_stop(net);
 
 	/* Free the control endpoint.  */
 	inet_ctl_sock_destroy(net->sctp.ctl_sock);
-- 
2.53.0


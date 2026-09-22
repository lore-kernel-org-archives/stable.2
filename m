Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808B4A689D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106047; cv=none; b=QpgQEN0p8w76cF+oJq0UD+VWZj0ZVAc25vWg/lkyrR+yBfDuxWJHkZ3pZwFNghSHnwFeY8KWsegY6kNJZhhklPQsbOz+t2FPBm+kXc9LFZqWLnZTbDRV7SrmwGk5AXxGHd+MGgyCJ684dJNbzOiMHim7TG1ZtN68U1t13OIGqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106047; c=relaxed/simple;
	bh=et2jN+++Omxsk+CLG3DsOW56BP70mqB7g39YoC5HQFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG2i0iTqtYaixUHyxn+FjCd8Er+gO5irzlWbthPfkF66bj/HToYXfI3aWdpzecgNhFkWB689Fy4eyBsJrvL94T8ek/oVTX4Lt5nDkMWoR1Wj4sXU/CQYUI2r8CDLthOPkCmzNhv3l8UR8j5ObNCInPL77pwCcUslxUTx7idm8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcvAV7zS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcvAV7zS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421911F0089A;
	Tue, 22 Sep 2026 19:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106046;
	bh=RzFWDLqukI7+amTjWanNlaVX40EdTN79ISq1+Qx7C2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AcvAV7zSI4KHLKsHWPZksSQnUsk4q1FxvrtiNWbtoAc5HCnZQILjyqy7SirOkVK5L
	 i7O/fqsfHdSYLpz0ANuHO7CA1NhCC4KNmmVHfSifyr+NEZ7DsYcLu+ZhDLCl946Ya+
	 QoLZtM76BYo2nlIUMQ8nVxFO6dNLWKrEbyNHN2zpaV5CcPCBYoVn0pipsHFGFdAQno
	 obBxh/yMdJg5tYkW+3s/J4JGrQFpS8Cf0IhleAzQb1DdGo3F+5GgzVTnXqWGYTXJN4
	 RfusTNp1K9m5h4UM842syxh91TMv9wUNijBbVh7E5rSJSG7aNKlUtIlEXQ/e5VUSby
	 cd2hgmqVTYJ+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Stefan Metzmacher <metze@samba.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix smbd_connection leak on cifs_get_tcp_session() error
Date: Tue, 22 Sep 2026 15:40:43 -0400
Message-ID: <20260922194043.23710-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092222-drool-acetone-c3a8@gregkh>
References: <2026092222-drool-acetone-c3a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit e75c96157d45e498970158c8f7373d90102e33b9 ]

When an RDMA connection is successfully established via
smbd_get_connection() but cifs_get_tcp_session() later fails (e.g.
kthread_create() returns an error), the error path frees tcp_ses
without first destroying the smbd_connection.

Fix this by calling smbd_destroy() in the out_err cleanup path before
kfree(tcp_ses).  smbd_destroy() safely handles the case where
smbd_conn is NULL, so it can be called unconditionally.

Closes: https://sashiko.dev/#/patchset/20260912165503.521597-1-pc%40manguebit.org
Fixes: 2f8946464b11 ("CIFS: SMBD: Upper layer connects to SMBDirect session")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: Stefan Metzmacher <metze@samba.org>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a95b9d2318fa2..db54cbbe8cc5e 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2676,6 +2676,7 @@ cifs_get_tcp_session(struct smb_vol *volume_info)
 			kfree(tcp_ses->hostname);
 		if (tcp_ses->ssocket)
 			sock_release(tcp_ses->ssocket);
+		smbd_destroy(tcp_ses);
 		kfree(tcp_ses);
 	}
 	return ERR_PTR(rc);
-- 
2.53.0


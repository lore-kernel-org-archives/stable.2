Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D881624DF
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267022; cv=none; b=KNdZFaoK1LN5RP5M+1J/QG1qqP/8i431gpZ+6/+q9Vfp4VT63QkP5v6CwoMZuRXwEfjW58K8faVTRqnVJ0yauoch0qRKs46KtC826oD3jN/saizC3ILbrYO2nP/2KroeP4MqWNyNH05MfRggfhrDxqzpMrkxoiEFNBcO4ueMIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267022; c=relaxed/simple;
	bh=Ujf6K8321O6sV/uxeWboTxwq2KIn6jXQJr27MvlPQU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWitlZwfqWbaOylKFUHCRneHgQJFrZNSZU9rYZwtWgrtb3Q2cUla2+SR2u4S1zsDRqxcRfjuVJyMjpVCdT/gZsfSSDwX+iRYkEuFTmUlxrVZ7LBsdfBpijPRr1juKEkA1gVUwFEw0gSu0zgYn0HrEuYdSeR0IsBJuF/xCdlCwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCibAemT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCibAemT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE5A1F000E9;
	Tue, 28 Jul 2026 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267021;
	bh=xpdWXB8JNMlyL7T/06ctlNMzDT7yu1GIeLYXJqpQYtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CCibAemTAnZQLw2yf6ajBoTzehLgmiU0XU6jxxZtk+s0OosIOOTGzMS1YFTff2GvB
	 Is5jFKxg7guTQR7Pu528vcvyBj9zHoLNdNgp9JA1BlbpdPPco1lPU9bDQZXeH7MHYe
	 kto5r2jBMDk0QBLkGZeZAMDRU7XzOZL63MdiGScZVBkkCRR8nbBajln0+XnRZimeKO
	 JBVeD8QCEuc04pmvdHUtYncf/NJQDNGfz6tbuXRVbj9LpCR3iHZCdOURALQIht+Pte
	 PFW6vPNYanFAqyjeZC0Umf2cmWYYHFZi9k/fJ8GD/xmdd5xPNlQysmGDPnJhykgXoy
	 fzongdA6uImiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Corey Minyard <corey@minyard.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ipmi: fix refcount leak in i_ipmi_request()
Date: Tue, 28 Jul 2026 15:30:19 -0400
Message-ID: <20260728193019.456162-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072152-tripod-washtub-9b4d@gregkh>
References: <2026072152-tripod-washtub-9b4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit a3f3859cecacb64f18fd446271ece9a3b3f2d4de ]

When a caller provides a `supplied_recv` message to i_ipmi_request(),
the function increments the user's `nr_msgs` reference count. If an
error occurs later, the out_err cleanup path only frees the recv_msg
if the function allocated it itself (i.e., !supplied_recv). In the
supplied_recv case the cleanup is skipped, leaving the reference count
elevated. The caller ipmi_request_supply_msgs() does not release the
supplied_recv on error, so the reference is permanently leaked.

Fix this by explicitly reverting the reference count operations when a
supplied recv_msg with a valid user pointer is present in the error
path: decrement nr_msgs and drop the user's kref.

Cc: stable@vger.kernel.org
Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Message-ID: <20260603120634.3758747-1-vulab@iscas.ac.cn>
Signed-off-by: Corey Minyard <corey@minyard.net>
[ changed `free_ipmi_user` to `free_user` in the two added `kref_put()` calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 62d39ea9f00836..48f2a2ca8278f5 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2331,6 +2331,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		if (smi_msg == NULL) {
 			if (!supplied_recv)
 				ipmi_free_recv_msg(recv_msg);
+			else if (recv_msg->user) {
+				atomic_dec(&recv_msg->user->nr_msgs);
+				kref_put(&recv_msg->user->refcount, free_user);
+			}
 			return -ENOMEM;
 		}
 	}
@@ -2373,6 +2377,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 			ipmi_free_smi_msg(smi_msg);
 		if (!supplied_recv)
 			ipmi_free_recv_msg(recv_msg);
+		else if (recv_msg->user) {
+			atomic_dec(&recv_msg->user->nr_msgs);
+			kref_put(&recv_msg->user->refcount, free_user);
+		}
 	} else {
 		dev_dbg(intf->si_dev, "Send: %*ph\n",
 			smi_msg->data_size, smi_msg->data);
-- 
2.53.0


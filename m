Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C83A873E
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262066; cv=none; b=oAq8geaDQtIHTwKKs2dNcAWspJxUWkF0fi8g4rFSnqFS67XPvfXvEow67rsxYRy3h0qEjV6Al2zg2on9+gOWzi0FequtlNb4JaBV0RYuejCgS/hTtBk6GDRd81VaUiZbXuJkXzjmH/A55ogPE+QzZ6nI5mKgswhxwq8vHwkfmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262066; c=relaxed/simple;
	bh=y0qua/8HgjlUtZLbNPmcAbIwEP39cmmWrKZ3cjUfgSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5HwQ69cYM4Hoky7jo3PQrV1+52awMpgTvoxz2/m5ooIfCbkHd9Q0nl+GEsApUMdbOf20y01/JhXVeFFusPbNIc2kolnPtzQQeBYgcz3kyshmexTA3Maw3vBnzhAKknFg4xoxi1foB6wNOkulxwEdFv9SNopABTOKXx/WfGOr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt2ua7pv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt2ua7pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF0F1F000E9;
	Tue, 28 Jul 2026 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262064;
	bh=YkxeFpytX1opw7hvf8l4bGpSAJtgOHI1A+NfyKH7Aoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lt2ua7pvuAYnAQwCVaM8vTYYEVri6YSuwKD8/xSlUMN/rEFAOtoYQ0EFApBYsdBur
	 OYewcb/E9yrfoMvS3W/fjdynV0DWlkgXaOTMX91CsTWk22vfX24ulpTeAahpTPjilh
	 RybeiINqQJjqLn5yrKUWmmN3r2/J99QI3v4SSv00zimwGnw+9Ceh9HcvF5bPo+dKgr
	 5pRd18QLHzg9JZoQ00QeNl3IaQykIIrCYseF6XV7zAlnbJRqHdxX+eAI9HfwU69TJ1
	 YBwugJKj/4SguH7d8Jct6aa7VsF/iu/QHgj5SqMfaNlT2WERnWvU0InUO2xy13c3Q+
	 rX/kxCh/VsGqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Corey Minyard <corey@minyard.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ipmi: fix refcount leak in i_ipmi_request()
Date: Tue, 28 Jul 2026 14:07:42 -0400
Message-ID: <20260728180742.291994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072152-astute-spore-9b56@gregkh>
References: <2026072152-astute-spore-9b56@gregkh>
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
index 37b84bfa623e99..7dec2138b87445 100644
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


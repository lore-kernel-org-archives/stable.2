Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510692;
	b=5kNce5rLMscaFPkEg+jDWlT9OHGXF/0YC96lPz5b7uySeaTgsbyK6D9N9Jmv03RkEYDD
	 EL58PHhgSIRhmwXAeLzOZOy51cCewfiwSoj5eFcitCv41qxR5StltZt346Qw3YqCA9NKX
	 YL1/hxE/KbvlfYsMaeQXl8SMBBklVqDizHHMSuiohbo5IQC2BNfQva72YqPhxrHui/vM6
	 RIFZTYemc0CJD1hKWCu6DR4+FbNOUWnT3XbQzs0l/LQW3UyIXrLABjKqbZhBsJvw9AbOG
	 quZcCAOLSsXQmrn/g/6Jt/IvHtO8mUDaU/gqzWNLQ810tJg8rdec6ti9iUxlL4pGguQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510692;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pokTu+l1vM7o6Eh7om7s7KcxHn5AkgfsRI7hSQoz1Lc=;
	b=l+Uc83NuPPa8a32DDsaUF76Sg4R+YcGNsHXWRXTKROb6I8B47TeQxgqKHaUfJLgIAZl1
	 J3hGZftEU7GVc71lXQdIrsIHx+CPwS+KnPndB0vjuPxfxd0BQhfq43HaYuANgc7x5l+Uc
	 48qPUWHG+bu2GuPypdaDPUgSfmrX85Rl9jcdfmEcwSqFGiVrdQnp3HzVILvDt3tB4hR6Y
	 pSWhCbiRDoHFcv8SDrc6Tc1U6flzgnZnwUBkAUDbgVvqQ9aB8d+gr75TsyI5FsB3fFKfo
	 LHyOzb/4YBHM6pftetIuz7aFA8UC9VBvh3kKu4wci3SK+zSuua/h+DNM0bVdDcZWHKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Auy5RydO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35B60A2607;
	Tue, 24 Nov 2026 08:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D35B60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Auy5RydO
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4FF7B205A2A;
	Tue, 24 Nov 2026 09:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pokTu+l1vM7o6Eh7om7s7KcxHn5AkgfsRI7hSQoz1Lc=;
	b=Auy5RydOXqAec/lVdMqs4evD3UwyQ8mwNu40RinCaBSY3HftkKzQFWB0k9QVPoG99tYQ76
	MF+x0ldOE4hagZfjhA6AgAxRCNTm8CBM3Gv7bDNBQs8Xgui4tfa6kGBrACQEGJgDdvScjZ
	BP88UVsz47bN93SuaS0TWzfxfNlKpNHAxfevoplqXU7r0fi+SmH26wOvY1Bgu/lJCNOd5J
	sE8m8Ej5q5P9X3x0hC+pZQi+lh1JS07QmCF9zhjvD5tiLnX9s3t+DqSGLvupJgl7Ls3Vt9
	vYpkHC1TPa0/HBKLBOlDKnkNtXPaXumYyrCuuuKn4gS4UrI5HFR1VZhUFWt+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pokTu+l1vM7o6Eh7om7s7KcxHn5AkgfsRI7hSQoz1Lc=;
	b=HDt0kPCrqMJu9otDig488FyPsUppCLJGJPLGi/QtZnWcFpBCX+GD4e3Kr6aDKPkzkCcfwX
	P1P59ALw4kEwa4Ga9KuUCVc/tT1pa7C9qZl/MKmTwHyd0OZvgluJEtUbi5HZmdxu4gZyCF
	P96ZvPnDfKBAYiLcNmHakgCmNAojCNGp5Qa7hfe5K7Q/a2+MCcq8h+5xQGpP8DFFyBNKSk
	d2YeMTSOzVB4JatQYd0Fx31+57blEECuI+DEqWKO5F5lLzuQDpKYEA6duvqIsvVZyTikbl
	ZuHhu0NSkleZW/5VxW453kGwfgtOZj7Xp7/nvvkh7xBeGciWYCcjRFMkx8apNQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510687; a=rsa-sha256;
	cv=none;
	b=K2QduMmcYjpqKoDTJHgDRY2jAmYYn9W9ZQx2po0hIGYO6rAy3QgX8x3c/2wqUSPX0jdms1
	miF72XS9tDxxogHzV4Cn3XDrc149NZQMaBI1nEY/K64AatYaQWfUG3cRndxh/UJllLxvgi
	BDiFAhuUAZDu/5scrz+SDAvk3TLsMtJ9mSAVJfjgXxsOuabSM3Q/Nks+1O6x5AaPCxHKJ6
	DMhDP/xQ2Cpzdf4ZkLiX/F5H12onu2bx9J3bPHlx+4nMORyVDXcoglg8MpxXWD+EdoR+5h
	YiN4zZrW72oepfUxlK136VV7DobnzbJ68l3RMRUKwN4tWODjI6ALAXPG59gUjQ==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 09/12] can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
Date: Tue, 24 Nov 2026 09:51:36 +0100
Message-ID: <20261124085757.1093632-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124085757.1093632-1-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Ling <zhuling0805@qq.com>

can_fill_info() emits IFLA_CAN_BITRATE_MAX with nla_put(), which consumes
space for both the attribute header and its aligned payload. However,
can_get_size() accounts for the payload only. The resulting underestimate
can make filling the netlink response fail with -EMSGSIZE when the skb has
no remaining slack.

Use nla_total_size() to account for the complete attribute.

Fixes: 2290aefa2e90 ("can: dev: Add support for limiting configured bitrate")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://patch.msgid.link/tencent_D1C873B86B0E92011A264B0E196B911D5308@qq.com
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-3924d490-baed-49dc-880a-6fd1163cf08d
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 521e2496e2cc..10e7ccaf40fb 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -833,7 +833,7 @@ static size_t can_get_size(const struct net_device *dev)
 	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
 		size += nla_total_size(sizeof(*priv->bitrate_const) *
 				       priv->bitrate_const_cnt);
-	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
+	size += nla_total_size(sizeof(priv->bitrate_max));	/* IFLA_CAN_BITRATE_MAX */
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
 	size += can_data_bittiming_get_size(dev, &priv->fd,
-- 
2.53.0


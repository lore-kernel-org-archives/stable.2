Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3033A169F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258449; cv=none; b=SgQCnVyZXaKSq5Vrs+CKuMuz/Cr/Bjpn02KHmhoWgEeLJv0nfuHSaunSS38Eut1ZS97GNA4yybBYZriEFrtLO1u+hAWC5OVVxbxiffFS372vWb6Iw2bwJLuwBiOI8glWTPecaxNE9jO7Lukrg8Ds82GmF1yrP/pv5BBZBX9Y0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258449; c=relaxed/simple;
	bh=jwlmxNoAj5rkCIRi1iujtk2xKau8ySPoTeNvy9UrsDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa92gK4jpiqPrr5E2VvZUHBS+TMgHSthJcm1sUQJmnrzRJtk2L3dH/o0XZhk9siRoV3vfqjlG/W2gFA4Bvhxh4s3Lfbwzb3iiYnFoM1/OFb/T3frwuUUbS36bN1fMbXOeDBBKVuDghL8qNmxO1yVl06/JAP8IuNqeoL64RuVg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdlOMnvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdlOMnvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D9A1F00A3A;
	Tue, 28 Jul 2026 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258447;
	bh=Ejxy9adFJZ5GHaUulBzTWPxNyKRcPnIS6nkY87JJB9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdlOMnvlmcF7D+ptOh6W5K66fJBGGUZUkKHs29cuVsFY4K2sghhWw+rndC6JtVpCL
	 MGsoywUMFBmP7/rR/Eihb5lBhsFcjZDInGrRmxcGfVz3xmVar5x/pvcwFvuj4ARQHW
	 0DB7ayJb61MJWNyb5A8azfxDUwYdqZJVP1rUluC/iuJBfvyalMo4U77pRJOe+HWiZj
	 k/ogAyhcv2ILKPnfHmmCzHv7Ki7yDkXwj7CdHym3Lr+OwbnwOcFjom7qFlj0Q/AQfM
	 5yCUU8ImOgBvzhdpLd4kVX55MjYHNEQBYl7zRjuDLGxdPSsbycq8d97DI6v8ZAfJyO
	 B//i5pfJ+5A0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Corey Minyard <corey@minyard.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ipmi: fix refcount leak in i_ipmi_request()
Date: Tue, 28 Jul 2026 13:07:22 -0400
Message-ID: <20260728170722.184404-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072152-turbine-driving-268c@gregkh>
References: <2026072152-turbine-driving-268c@gregkh>
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
index 41ae4dac4eebad..8357cc5884b58a 100644
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


Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A983AA1B6;
	Mon,  8 Jun 2026 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912642; cv=none; b=k4+Ihh1xVqbH4GOGBWZhWusT4SWwyYC8bPcYmm0fHR/i/26F8JdL7zP8O/cfcLsw08r8AXzPEUD9VwqsJy3HG6tlIl54hxzq+XPctzAtdIE/3JCNXn4dlBVpbEzxl3CVQPhYGwI098JNWZZZRtEZhMrJCCyN8rMbTTYLs6FDWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912642; c=relaxed/simple;
	bh=ngMAaFyO11vI37AhZlJcXNHtXsNDnTTugPJQE0HoGfQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Tp6Ssyak8/ef6ilNp4wyPvXr1CYbtzCiPCeq59iG8hXWRDyC1dArYbKZ6Ut76EWPnsNGhxOWqw7xEVwmW4KTTy8hIxvUdwyg5ZvolChaLPpm8jjrSO1dtJ/ZjP7ux3kC1+AB8Ptb0DDFVA2vhyoW4sooqwc0z9lPUJ0NTOL+pBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=H9D8IhW4; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="H9D8IhW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780912636;
	bh=Yj/4+3DzEU4TvSvmleeAUG1+meO3Aqt864cXNzMpXo0=;
	h=From:To:Cc:Subject:Date;
	b=H9D8IhW4FTBytKxkA4hUrnenQwJlr1vmCyjKH6Vz453D4TAOA61hCgp9lJHV+ksbn
	 FLSuOVTW9gIzB/K1LocoRIPSbEZuoYXJpy/K6SvC0UPigN7nAJ5kgA3cgAptFqYJ8n
	 irC9lUys76mLNspbjDXXDNAS7xBIwe0VCeeSCRuk=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E3938A47; Mon, 08 Jun 2026 17:56:57 +0800
X-QQ-mid: xmsmtpt1780912617tnmdy7k4f
Message-ID: <tencent_42D87A0C871AE6AF019BF6AB46F003577205@qq.com>
X-QQ-XMAILINFO: N6nW3/TXfx9UpWZgwurumrxrG9NWkN3r1kOy2nd/BGyreG5PDGXim1atH0XBly
	 tY9kNk8+dOh9FchWx9CFUWbW1ros/Jtdx3N8QaPJ9xkg8yhjPhBaX4sH811dTaSzafz5tAITHSh3
	 rflyQsBqCL3UygzevhJnEcJEQmvFBmk68dz8cPNv/YFGtwIlwa0Z0NaVLKbyuYFQ0clSuduJo+DT
	 v4UZM9uulQgoJDEqvppQmX5zl3Rr/ecqn8BRQk3PN+8256rpfn7k/+FvFejjYrO6IEDZ4zgY4eEz
	 NW6du84Qyl0nKgNFAS7T9VlKJ+gJtdw7C0/f7aA18LEWBSLBllz/JC0XCv7te5B28Q/bRz1SbSui
	 p1BIKla77nsDvHGGUNp5PgncWY5wMx4nWZxywXTn5p/RsAVl5e9xMVO5lxLxcNEb9qqehEpL17w+
	 7TpTR99MtwsUMc8OuFwUqem60n23aWywJAm+lZQhfnDF1mQusxWpDB+BoJRoTYERMVohBRtZ9dql
	 gYiVgNAjQB+CMWr6+DM0nDdS2sX4zcPaVrmlF1dq0camF11s3mRaAz7AaObr1eq0Ker6SX71+wCl
	 K7baeuO+yxl6m4fKcSE/0yhw7k4DIr8ScsGrgVNC+kwfXWdDQ7FO7KUeFX1fUGb+I5jK4I5ATUHV
	 1a1XyynJfJCK5bKL1+F1IiQVfjLquH36vKri5Q07fpM1yNipR012lrRfDg+2GDG6uLskL76ZD3RN
	 d2A96srP8VPMaH5a6XqwZFKWmh1OyZc+uSuyfHXiv7Ap0vzowFwR407qaI8Ggcmw74vhQhiiHVoX
	 H7meczsUucCHH2XlYns+mfxq3hOJd2Wbt+3IB2Sj61UizFyHomLNTxelot7kMBNJudHyp6CLllH6
	 TRAjZ/OvKQahBeFAh0rT2v/lFE7mdxPViQA5HqCL8RdeM6FwGdGQgoaUIu88xhoP7oY0i+2F3f6b
	 q4HEk3RsIVWs5ZaaVJhkPPgjz5KVZFT1jaHBQUBu1PR1x/Yt/u4IU8BPw2CWZCkyFWoSboyKJS3P
	 +uC+OHK9iz3bU622rfRQRBVBDsm8+ah1nCsD/NHYrnv9efWraHTGq3JOxwBMU8iJIkGt7zkQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
Date: Mon,  8 Jun 2026 17:56:55 +0800
X-OQ-MSGID: <20260608095656.97896-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit a2639a7f0f5bf7d73f337f8f077c19415c62ed2c ]

hci_conn lookup and field access must be covered by hdev lock in
set_cig_params_sync, otherwise it's possible it is freed concurrently.

Take hdev lock to prevent hci_conn from being deleted or modified
concurrently.  Just RCU lock is not suitable here, as we also want to
avoid "tearing" in the configuration.

Fixes: a091289218202 ("Bluetooth: hci_conn: Fix hci_le_set_cig_params")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Minor context conflict resolved. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 net/bluetooth/hci_conn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f51c530a3c45..ab86cc4a5e3f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1734,9 +1734,13 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	struct iso_cig_params pdu;
 	u8 cis_id;
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
-	if (!conn)
+	if (!conn) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
 
 	memset(&pdu, 0, sizeof(pdu));
 
@@ -1776,6 +1780,8 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 		cis->p_rtn  = qos->ucast.in.rtn;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (!pdu.cp.num_cis)
 		return 0;
 
-- 
2.43.0


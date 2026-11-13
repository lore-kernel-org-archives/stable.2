Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577392;
	b=4eLyepQf4juKM/NLyYLZu+bIHynEbHhdbQ2qAw8XRVcUwZBMZ96fi/Cc50TbFU/gwkxB
	 9IVsNxRDNznGBSqGMK9ZQWsb8Q3ZlZdcpILM8Kre4n+lQBkXNpZRC+ZSlRu1xB2rpapLr
	 FJWsoHBogZsBxoczeQSSF37T7Jng29EiGCx/86WfW823I1pwcJUu6oZf/mqgnF1HpHIvD
	 8Y8pEdFxRaKZ+xX40+cHzQZfXqQtGbVbJjhJPtt9N+wmW22OsXGiNA8K7rdVCYgaCDMy8
	 qMLqQVEUCvCTnGPPhUL/KVpqZ+wTk32EIi6phrxfQpW8RsULvXPJpDsmZsSJ4M1qW3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577392;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=3kcrlVRBobTRT8jOtREfiBLM6vTtQc7X6ndLPnK4qOc=;
	b=aaecWaCZiiuvsGMjvGcGY8Ejgyxcj7BjzH50sZRgXzyHt3s5zSIYUHACyn/Ew/JJp8yL
	 5JvI3vWbmyKZCWPs1wekiTfDcNKqbW4SLbwDbeYaW1VGuC6oitik9h4W7FcviUZCNMU6l
	 OMgU2aK5pcvvlanuoLXDZPFIjKinaImIaHASL3UqXmvkc+0bxQKrJwKbxnhwD4bKwgIFH
	 UwCtCG2c52r5/QYRjlCu3OfCPJdxEOAaSf0a3aHLFzvQAeBqa2uW9zjWlzwZg4DvqDuBZ
	 pnmvSPM8SmMLLvNOHKnHi/5WG1ohLzkwdT4FwYOeaeryQLGcFhtrvdGuWoLOrYdmwIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=cKkX2C9T;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69324606A327;
	Fri, 13 Nov 2026 13:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69324606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=cKkX2C9T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794577330;
	bh=3kcrlVRBobTRT8jOtREfiBLM6vTtQc7X6ndLPnK4qOc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cKkX2C9TU/v7CMDu8ugevsUTc5a31S7buh2ror1VZhNiorOX6FXSVjxpppf7JpIOI
	 grypYAyhUtU72O4aTG+Qe2pGBRWf8GnC3TKYnMe7+QWAWcHXZp5rE9Kox9jMBi6UBD
	 T7FwdYUsE4487kmxajUaoXmD2tJ4bBMkjvbMoxiw=
X-QQ-mid: zesmtpgz8t1794577305t88a9c797
X-QQ-Originating-IP: UpGU27M314SgLzhWg8rwr6TRitp95Zs5/+Vkkk4Vmrk=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 21:41:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2692691757360946475
EX-QQ-RecipientCnt: 10
From: Yichong Chen <chenyichong@uniontech.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Jun <zhanjun@uniontech.com>,
	syzbot+8a8482d4c33cc58babb4@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH net] ieee802154: hwsim: free PIB after hardware unregister
Date: Fri, 13 Nov 2026 21:41:41 +0800
Message-ID: <0D7C088B45E7283A+20261113134141.2626113-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OE2B1K8X9uN6TKRJknmgrzQ8Ba+/H4Q/PDI3pM1HiENumoaa+39xeTTP
	Tb3HtFJN/ArQZA0ll4i+R4WEyv+c6UCgukuAk8Df64MNbytdWPzGcQUPvBwDpNTJbt60dcU
	III9jEPFMPRX8i4v12nzJVqD45Jm6Orcl/xkko1a7n4LgMWUZ4Lo8I0lLFbnNt/YVk3mE2O
	s/Acj07aTdfSmSvG3PnJo0gCwzZqJYb3kvLqvzVq6lhh1lV3F/VvddXutOyyb329czZg2hF
	DJN+mZ28V/r/5lPnfswBad/GsJj9zxcnIXDla9xjHkBe8UHngaXQqZCzRMzNLFMxo1kxMnw
	5DvXDUV8/wm3LeY/dRlHENfPuafH4BnYpnhsZSl1crSvwbz+P8rxjqSeuH9VZDHQXBHxRXI
	4btkLfsxiVv4a3P3EfLHFb7Kos/LoA2Z+vPqI0RnJNyryyYCTBD4TVtUA4XTsG0zFfe8hXo
	G/H7/4CAdxbVNNuVfj5bAPztQwparvcMq3NVfF7dfOaojHQK+C5V5QjsFtZGL9vxlntESpn
	k8aphZgvGTFzkkq71RzItV5JXWfd6hty1IydJzPxVKHp2hvfE6oS1lD5EdnSkxgFOuQDiZ2
	PjqV4PJz/lcOr9yHen/GZ4I5zD33mbHggQXBceteF13bS5/s36CQ7W6xp5lNa0Kszq9xOOJ
	M7ZQCTDq25Ytx1OLx2XToAe4+QGWq44ijSUKincPQNlaQ3eiur+XUR2gD57WSNNOiY4oPkC
	B49fVqrwqChZcy5iKc5JMFpVHakdMIFinx1pWB1hmpc6uCkKuJ2iZ2wNUFSdyiyGGY5jjFv
	xyoiHZSEjW5ZuQ3IW7C/AdJVixecrZSH6MQ+UqvaAXpu9+Pw6VNqYZdJojN83QUGOoaB4ok
	3BdjWjnsDZsNpgRvGRkvFhspAuHMtqLDgoHSq+U+7jdLjRnADdjBTvWVcuDDDs1DC+Hunm7
	As5Sa7Z7p+Xv+jZ2H/c8hZ39SIgaNwWPzlLChPBne9uzkasqL9XddpgboT9dlTMG8/GI0g+
	8ay/4x0XWcpbNc/i1Kl7oxzTZKYU+VsOkFvDslHd+IixAL02kg0PNKb6PXLASpmUlLcSpET
	hM5gWN1QmPCddPvaq90oic=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Zhan Jun <zhanjun@uniontech.com>

hwsim_del() queued the current PIB for RCU freeing before calling
ieee802154_unregister_hw(). Unregistering the hardware closes its
interfaces and aborts an in-progress scan; scan cleanup calls
set_channel(), which replaces the same phy->pib and queues the old object
for RCU freeing again. KASAN then reports an invalid free in
hwsim_update_pib().

Unregister the hardware first, then atomically detach the final PIB under
pib_lock and queue only that current object for RCU freeing. This lets all
driver callbacks finish before the PIB is reclaimed and avoids freeing a
PIB that was already replaced during teardown.

Reported-by: syzbot+8a8482d4c33cc58babb4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6af5f575.b350cda4.2b6a63.0000.GAE@google.com/T/
Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index a9bd1555d2dc..a65ae2afb789 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -1008,12 +1008,16 @@ static void hwsim_del(struct hwsim_phy *phy)
 		list_del_rcu(&e->list);
 		hwsim_free_edge(e);
 	}
-	pib = rcu_dereference(phy->pib);
 	rcu_read_unlock();
 
+	ieee802154_unregister_hw(phy->hw);
+
+	spin_lock_bh(&phy->pib_lock);
+	pib = rcu_replace_pointer(phy->pib, NULL,
+				  lockdep_is_held(&phy->pib_lock));
+	spin_unlock_bh(&phy->pib_lock);
 	kfree_rcu(pib, rcu);
 
-	ieee802154_unregister_hw(phy->hw);
 	ieee802154_free_hw(phy->hw);
 }
 
-- 
2.51.0


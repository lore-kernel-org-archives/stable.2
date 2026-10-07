Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37216347BD4
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351405; cv=none; b=aDTTrVUhZlyCI7Xp4nfHcqE2k/y6Aiu85mBxxjLv+9oyYVoR7+p2zFSnNb537XFo5ihOuF9AqpvddDSuDNleWCOZB80TAJOqAoAn1yiZyN++qyW2yinMO+RsRQ1VbEU1fTC5t5lJNHIGTpSHtyPQeMDWi9NbDF0v6dCB8iNMaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351405; c=relaxed/simple;
	bh=quP2B3H0YMI+eU4qAWnsMNP9r9vvyE/ztfpJ85S4wFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgA5wyK5my3o5JUUUIBvs0KSLl8dYn/KiajUIi9JLuNmLe62nEq2HY9Dx5Ibc1qd+BbWJoy7nDty4w29TerXUXc5i02VaVa/uM2umTbMIiRmyEsq1TSZ+S0kpT/CbH1GFPJgGygtvkLAYVH+gjyHm55G8SVAl2XgWCqfkQcApIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3tmneIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3tmneIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB47C1F0089B;
	Wed,  7 Oct 2026 05:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351403;
	bh=3KRcnRXxHZFKanoj4vOWSwhKRVnnS3ZRuM+uZF1qEkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J3tmneIT73l/9aaLHKM//9DhzGo/VaKH8VYXW+nrkJM+hJdyfwVl1Hre+bdE9DL/x
	 vGnkamOcvAXHHDMlG2P44sZXXNDqMKhqzgnYwfy1ksSDfskooWkapBIvietCSHLjwC
	 jEbiavN+8Xy89VNsr4AfNPD3bh5Mh0Hzis/SDSZO5yZuCBh6TIxroTd9XGGKaXREIQ
	 fQFwgTRPrRTQcTOhZv8szIaCwMVfOvmPAyGxAw+v2ZTbiDLf1G2oq2lgW5Q6dgxNwX
	 c/YFYnsNSDfusnAIko4eMkmqfydgCN2wPTeHmwQmIS6/mYonheNUDbtyp1GTWEGP+W
	 XyKeUvdCei5Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] thunderbolt: Fix NULL dereference in tb_remove_work()
Date: Wed,  7 Oct 2026 01:36:40 -0400
Message-ID: <20261007053627.1475486-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100543-stitch-ocelot-f71a@gregkh>
References: <2026100543-stitch-ocelot-f71a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 4310c6b8e75d6a47f7548e5948fbe6318aa4440a ]

There is a slight race between tb_remove_work() and tb_domain_remove()
which leads to dereferencing a NULL tb->root_switch pointer inside
tb_free_unplugged_xdomains():

        Thread A                            Thread B

  tb_remove_work()
                                    tb_domain_remove()
                                      mutex_lock(&tb->lock)
                                      tb_stop()
                                        /* doesn't cancel a running callback */
                                        cancel_delayed_work(&tcm->remove_work)
                                        ...
                                        tb_switch_remove(tb->root_switch)
                                        tb->root_switch = NULL
                                      mutex_unlock(&tb->lock)
    mutex_lock(&tb->lock)
    ...
    /* without checking ->root_switch */
    tb_free_unplugged_xdomains(tb->root_switch)
    mutex_unlock(&tb->lock)

Commit a8937f35cf39 ("thunderbolt: Remove XDomain from the bus without
holding tb->lock") doesn't seem right to move tb_free_unplugged_xdomains()
out of the &tb->lock section and the check for tb->root_switch, in
particular.  It states:

  For this reason separate removing the XDomain from the topology data
  structures (where we need the lock) from unregistering the device from
  the bus (where remove callbacks of the drivers are being called).

tb_free_unplugged_xdomains() belongs to the former group of functions
requiring the lock.  And it also calls tb_xdomain_remove() which should
only be called with &tb->lock held.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: a8937f35cf39 ("thunderbolt: Remove XDomain from the bus without holding tb->lock")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/tb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 2584e05d06b42..658b34bb743ff 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1479,11 +1479,11 @@ static void tb_remove_work(struct work_struct *work)
 	struct tb *tb = tcm_to_tb(tcm);
 
 	mutex_lock(&tb->lock);
-	if (tb->root_switch)
+	if (tb->root_switch) {
 		tb_free_unplugged_children(tb->root_switch);
+		tb_free_unplugged_xdomains(tb->root_switch);
+	}
 	mutex_unlock(&tb->lock);
-
-	tb_free_unplugged_xdomains(tb->root_switch);
 }
 
 static int tb_runtime_resume(struct tb *tb)
-- 
2.53.0


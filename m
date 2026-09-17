Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA14AF9C2;
	Thu, 17 Sep 2026 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643787; cv=none; b=q6OPE/unW/rUXC3J0ikP+c7RBN5lft0j4HZcVInNGVMSFhREsNQCAoUAjj8mCCJbPDdTW/sD+vK43cE4oiR2bqQ8yitxdl5dLzp+J9E/2s82/khWyt/rvNIyjjiZ4fpropLlT7cW1Lim7GcZnljWDanes0t173Q0w7ziiM0RKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643787; c=relaxed/simple;
	bh=dHbUJ2IN+22KrfIuKTReR4iKhAbp76jX69JYs5B79+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+MCittOJp3UqOTKXSZhTbYMpe4UK3D6pxrV/XLIgoBkCJQxq4SytDjFv2W1F09BLhWlW63N+AnmD4so9+U085V/HdQSekdTaCMGKconTyOZsOFIAMTiOi+h7Ss7BaBtIyswcsO3HmTqsxXLC3Z+20lI6Rn0VK6uWesXog8XPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHcz3zy6tq6Vx_CA--.42008S2;
	Thu, 17 Sep 2026 19:16:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	enachman@marvell.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	maksym.glubokiy@plvision.eu,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: prestera: flower: fix ruleset leak in prestera_flower_prio_get()
Date: Thu, 17 Sep 2026 11:16:03 +0000
Message-Id: <20260917111603.2148710-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHcz3zy6tq6Vx_CA--.42008S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKw13Zw17Jr1fZryUGF1fXrb_yoW8JF15p3
	y8CrWYkr18Jr4Iya9rCw18ZFn09ayaqr9rKrs5Cwn5Wr45GFZ7CryUWws2gr47Ar4rWFy3
	Xw45C3WUuFn8Ww7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU878n5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggNA2qrq3ZtMgAAsD

prestera_acl_ruleset_lookup() returns the ruleset with its reference
count incremented, and the caller is expected to release it with
prestera_acl_ruleset_put(). prestera_flower_prio_get() only reads the
priority range and returns without dropping the reference, so the
ruleset is never destroyed.

Release the reference after the priorities have been read.

Fixes: 44af95718fed5 ("net: prestera: manage matchall and flower priorities")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/prestera/prestera_flower.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
index 58b116cabd48..10d7e149822b 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
@@ -411,6 +411,8 @@ int prestera_flower_prio_get(struct prestera_flow_block *block, u32 chain_index,
 		return PTR_ERR(ruleset);
 
 	prestera_acl_ruleset_prio_get(ruleset, prio_min, prio_max);
+	prestera_acl_ruleset_put(ruleset);
+
 	return 0;
 }
 
-- 
2.34.1


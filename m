Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3334FD7B5;
	Thu, 17 Sep 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663394; cv=none; b=FHO8BSPXzyKAqakzGuJM9cia4BF6CtUZYbSmZC2L6NcZpoTdW6P4TIawLeINmA8oTjCBtA+EcASr9qDQrGCTkj0w/AiMz7OFyPu//72MWLstUJywTvU+rzvrO4/ufPbN0IT9yGt2QSewY2kY0Bj76BvYS1fjAF1GKoee+25PFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663394; c=relaxed/simple;
	bh=XdmgUuJKQjGib5brpBbCB1KtyXLd5oEWHkyPMHuhRoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tTEbXH9C/24pUh3OfOW/kdozM06VpuN844TO5yEEikK1WEFM/PJVAlSAdj5UAICXR5n63ZpNQBDor0QlVkqz58bgJk6yD4l2XZzIWE/ZuLFhm3ZgbnocHJ0T4aBg63pwN5jtEMHf5eewEu++3dsbz1Qp9UjvPARVPEkIsJJjFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHKkOWGKxq3bSECA--.47490S2;
	Fri, 18 Sep 2026 00:43:02 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: apparmor@lists.ubuntu.com
Cc: jmorris@namei.org,
	john.johansen@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: Fix namespace reference leak in __aa_find_or_create_ns()
Date: Thu, 17 Sep 2026 16:43:02 +0000
Message-Id: <20260917164302.2162938-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHKkOWGKxq3bSECA--.47490S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1DKw47Wr1DuFW7uFyrCrg_yoWkWFb_Ga
	n7Za4kCr4DZF9Fkw1jya4IgF93WrW8GFyv93y8KFsrJ34rGr4xJFZrJrs5JrW7Zw42gr1D
	Gas8CrsxJrnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
	87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbUPEDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAENA2qr9nBRugAAsv

When the namespace already exists, the reference taken by aa_get_ns() is
overwritten with ERR_PTR(-EEXIST) without being released. The caller in
apparmorfs.c clears ns on IS_ERR() and so cannot drop it either, leaking
the reference on every mkdir of an existing namespace.

Release the reference before returning -EEXIST.

Fixes: 73688d1ed0b8 ("apparmor: refactor prepare_ns() and make usable from different views")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 security/apparmor/policy_ns.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 5a907a875d8f..c423f4504d4d 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -267,8 +267,10 @@ struct aa_ns *__aa_find_or_create_ns(struct aa_ns *parent, const char *name,
 	ns = aa_get_ns(__aa_find_ns(&parent->sub_ns, name));
 	if (!ns)
 		ns = __aa_create_ns(parent, name, dir);
-	else
+	else {
+		aa_put_ns(ns);
 		ns = ERR_PTR(-EEXIST);
+	}
 
 	/* return ref */
 	return ns;
-- 
2.34.1


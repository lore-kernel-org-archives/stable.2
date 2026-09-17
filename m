Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0D542EE5;
	Thu, 17 Sep 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663309; cv=none; b=ihbN1apHgCig/6spz07j91SfpThh20ZoODMNZslBKdS3nLFzO3gHcTzpZVBvWFQlG0ks4SoJ5U4zqSMoOFvMBIUEivhy0MZiwpY5Gz32wasdxZhPKaAH/wi5T3pqHUWB3c9w8D8C4DmD5jnoRPlpYLZutLmlkjPedXv+fZo8FWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663309; c=relaxed/simple;
	bh=iiXBV5MgplOvJ91LHs1htrM3/RFloTnXRtR+u/xWX5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3a/IjttzLTZU6kbNtsCU27NrD77mSHNVO5vYSfKChlrrWl7XKdTR1bVRoW1Kwn3RzlucrvBXjbog4O+Ge7l2NfrBqJks/etPlBNPHyS9V1/xd6pzIhqQKO73FUaa/JmhaQjKXITNFxioa3wFuKpJ4nIzAAsF5ZG+oBl6xskSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB34jxAGKxqLa+ECA--.7061S2;
	Fri, 18 Sep 2026 00:41:36 +0800 (CST)
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
Subject: [PATCH] apparmor: Fix label reference leak in aa_unix_file_perm()
Date: Thu, 17 Sep 2026 16:41:36 +0000
Message-Id: <20260917164136.2162858-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB34jxAGKxqLa+ECA--.7061S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZry7tr1rKw17ur4ktr4UCFg_yoWktFcE9a
	s7ArnrWrWxZFs0yanFyFWI9F929a4DGFyFqa4j9FZ7G348Gr4fAF9rAr1rXrZxXw4xK345
	t3WDW3sxtwnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUNA2qr9LZUgwAAsG

The inner block in aa_unix_file_perm() re-declares plabel, shadowing the
outer variable that is released at the out label. The reference taken by
aa_get_label_rcu() is thus lost when the block exits, and aa_put_label()
at out is a no-op on the still NULL outer plabel, leaking one label per
permission check on a non-filesystem unix socket.

Drop the shadowing declaration so the outer plabel is used and released.

Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 security/apparmor/af_unix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index fdb4a9f212c3..ecb40cfe7e14 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -758,7 +758,6 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
 			   unix_fs_perm(op, request, subj_cred, label,
 					is_unix_fs(peer_sk) ? &peer_path : NULL));
 	} else if (!is_sk_fs) {
-		struct aa_label *plabel;
 		struct aa_sk_ctx *pctx = aa_sock(peer_sk);
 
 		rcu_read_lock();
-- 
2.34.1


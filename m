Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D137B417;
	Fri, 26 Jun 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486535; cv=none; b=iExya2fXlJm4GvRSDe98g7FQy6Oq8b1ZVLtV7ygvtwQfy6HTZ2+fEliazLWxgaOjNg7dYf17inM0l97Vj7mVJdS8iFkmpc5iHtr9Gh606UtTgOw+4v9y2JfglJ2pc8aQ8nlXoX0Yhp8XId5bslCIZpmZy/6NMmvP0agwQPu/nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486535; c=relaxed/simple;
	bh=dDvBir5NQdT7dHT8o2KC6ZUoCUML6B7AvxdHFvam8r4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKZy5EPiMvMPBCfx4UvNkzxRlOSue9y3bBK/TWu/4WO6IoV9imUfO5R2trbFehksQKucnyCr9ySMgWq2qz7wTC8F/HUM1ijLf/V9haK70jWOU956qy8K3DT9Pg+Xib2+8Y7lOo/S8ee1I4MrM1x3OGJxuOuz9iXGbpwScj9BuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAA329P+lT5q4ohrAw--.36775S2;
	Fri, 26 Jun 2026 23:08:47 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: md: kset_replay: fix use-after-free after cache_key_put
Date: Fri, 26 Jun 2026 23:08:45 +0800
Message-Id: <20260626150845.50456-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA329P+lT5q4ohrAw--.36775S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1DuF1xtF45ZFWDZrWxCrg_yoW8JFW7pF
	W7WryYg3yfXrWIkwsrJ3W0vFyFqa98Jayqg3y7twn5uwn3Zry2vrWIvrWjgry7Xr1fJF43
	AF1UtFs8uF1qqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUTnQ
	UUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEKA2o+idsgsAACsQ

When key->seg_gen is less than cache_seg->gen, the code calls
  cache_key_put(key) which decrements the refcount to 0 and frees the key
  via cache_key_destroy. However, execution falls through to
  cache_seg_get(key->cache_pos.cache_seg) which accesses the freed key's
  memory, causing a use-after-free.

Add a continue statement after cache_key_put to skip the subsequent
  operations on the freed key.

Cc: stable@vger.kernel.org
Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/md/dm-pcache/cache_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
index e068e878231b..c33d6b37f58d 100644
--- a/drivers/md/dm-pcache/cache_key.c
+++ b/drivers/md/dm-pcache/cache_key.c
@@ -733,6 +733,7 @@ static int kset_replay(struct pcache_cache *cache, struct pcache_cache_kset_onme
 		/* Check if the segment generation is valid for insertion. */
 		if (key->seg_gen < key->cache_pos.cache_seg->gen) {
 			cache_key_put(key);
+			continue;
 		} else {
 			cache_subtree = get_subtree(&cache->req_key_tree, key->off);
 			spin_lock(&cache_subtree->tree_lock);
-- 
2.39.5 (Apple Git-154)


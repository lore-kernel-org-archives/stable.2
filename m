Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FCD331EAB;
	Thu, 11 Jun 2026 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196903; cv=none; b=ntjs9CdRbhSbC3t+tEr72y4F7cXd2BsvR2r5Bf4Jk/B0MOQvi+v/9MNyrtRrRdteXnylPgpWHaHQarU5gch3G+At0bvqQesSV/QRWNSZYf7w9CgMeNGexHU9vIDAI8SlsjdJX84SSsp7DLtCUqgorXwcsEP+WXsceJ323F3WMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196903; c=relaxed/simple;
	bh=MsIBZJeZCuCREY17SiyWt5Hb8QTpBmurYizgRrGPRPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0+Cz2marnOCk678/sqN10tPTv/zQUSWaCv4a9uUzUdFqYnckgU08hvl0wxiuby4P3HZtMcbC8SckT6NobB8hYJfwPrtHEO1TwYtxKKrbGhdIetaoIHBfiXT/0Wah/LgBlMgK6YM5eZk4MbPj124gkMwLyylCtYJtuwbZj3tZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowAD3fABa6CpqjZ4aEw--.2037S2;
	Fri, 12 Jun 2026 00:54:52 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	vulab@iscas.ac.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] l2tp: fix refcount leak in l2tp_nl_cmd_tunnel_create()
Date: Fri, 12 Jun 2026 00:54:49 +0800
Message-ID: <20260611165449.2224-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3fABa6CpqjZ4aEw--.2037S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xKF4rXr4UZF4UCFy5CFg_yoW8Aryfpr
	W5ur4DGFW8tF93tr4Dua1kXFya9FZYvF4rGFZYkw1Iywn3X3y7ua15uFn2vF17Cr4ktr1Y
	vw4jqw48uF98XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4PA2oqzrtH4AAAsZ

When l2tp_tunnel_register() fails, l2tp_nl_cmd_tunnel_create()
directly frees the tunnel object with kfree(). This is incorrect
because the tunnel's refcount was incremented to 2: once by
l2tp_tunnel_create() (initial refcount=1) and again by the
caller's refcount_inc() for a temporary reference. The successful
path releases the temporary reference with l2tp_tunnel_put(),
leaving the IDR to hold the remaining reference, but the error
path bypasses reference counting entirely. As a result, the
refcount stays at 2 while the memory is freed, which leaks
references and violates the object's lifecycle that expects
l2tp_tunnel_free() (via kfree_rcu()) when the refcount drops
to zero.

Fix this by replacing kfree() with two l2tp_tunnel_put() calls:
the first releases the temporary reference, and the second
releases the initial reference, triggering the proper RCU‑safe
cleanup.

Cc: stable@vger.kernel.org
Fixes: 6b9f34239b00 ("l2tp: fix races in tunnel creation")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/l2tp/l2tp_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 59457c0c14aa..655bed496ffe 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -245,7 +245,8 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 	refcount_inc(&tunnel->ref_count);
 	ret = l2tp_tunnel_register(tunnel, net, &cfg);
 	if (ret < 0) {
-		kfree(tunnel);
+		l2tp_tunnel_put(tunnel);
+		l2tp_tunnel_put(tunnel);
 		goto out;
 	}
 	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
-- 
2.50.1 (Apple Git-155)


Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076A2D94BA;
	Thu, 11 Jun 2026 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196357; cv=none; b=HG2IMaKwI8Zaz1lNF+QnUbNqhF8JH2ISjnZbkDAeZf9kks42tRwmworxAPQqQ4hmU9cKnwPdCC2pr9oD+yQmgb90ZDlKO/fzP3bs5j8fx0HbQUQ1x1366x8/oIsNmtIAXwmDdjbrPRRRrlvSQXSxFrBJPRrNpnK6D73rW6EPTmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196357; c=relaxed/simple;
	bh=CEd1ITtNJ1dtQfGGL+BtTaRF/mDIRvk8WQFomVTCwcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=co3TrWygIJypkeDgRmpvrkhxkBB0DTgJOLcETIDZP4ethOz8kmzeE1xQcJrQB/wdJv6urzrHhCnEuvxM4czaT8RMAi6th0RYWPZd6XcUgcs9dnnln8VuzGaHcSzZMeiLOjkIs6pUo0or4XxFVWk1lZzIiXbUqrL6fNKjJyPZgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowABnvhE35ipqz20aEw--.26018S2;
	Fri, 12 Jun 2026 00:45:44 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: jchapman@katalix.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: l2tp: fix refcount leak in pppol2tp_tunnel_get()
Date: Fri, 12 Jun 2026 00:45:42 +0800
Message-ID: <20260611164542.1031-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnvhE35ipqz20aEw--.26018S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1kJr48urWrtw47Cr4UJwb_yoW8Gw18pr
	15Cw4kWFWktF93Aws0va1kXa43urZayayrGFyDGw12vw1rX3yxC3y5WFyxWF1UGFWktw1Y
	vr1jgry8Z3WDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoPA2oqzu5B1wAAs3

pppol2tp_tunnel_get() increments the tunnel's refcount via
refcount_inc() on the tunnel returned from l2tp_tunnel_create(). If
l2tp_tunnel_register() subsequently fails, the error path frees the
tunnel via kfree(), bypassing the refcount entirely. At that point the
refcount is 2 (one from l2tp_tunnel_create() and one from the
refcount_inc()), so the reference counts leak and the memory is freed
while still referenced, creating use-after-free potential.

Fix this by using the standard reference counting API: replace the
kfree() with two l2tp_tunnel_put() calls to properly release both
references. This mirrors the cleanup used in other error paths within
the same function.

Cc: stable@vger.kernel.org
Fixes: 6b9f34239b00 ("l2tp: fix races in tunnel creation")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/l2tp/l2tp_ppp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index e0b1915be1a6..0ddfc1893121 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -661,7 +661,8 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 			refcount_inc(&tunnel->ref_count);
 			error = l2tp_tunnel_register(tunnel, net, &tcfg);
 			if (error < 0) {
-				kfree(tunnel);
+				l2tp_tunnel_put(tunnel);
+				l2tp_tunnel_put(tunnel);
 				return ERR_PTR(error);
 			}
 
-- 
2.50.1 (Apple Git-155)


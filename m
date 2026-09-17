Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169F4E1C7E;
	Thu, 17 Sep 2026 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646225; cv=none; b=s8qEvC3/ue1YrS1GbQq3OO1yROufeKMLz9LDZoS2wAeSVPan0Yq9ZJHwbbcjkwAttBXxaMgZmUUBH8w+wyLVT0XqMAyWDb8qqi5+cfO4F9pZFaEq44GtSev/ReVI9QSS8QyIgHhZkqGTNUCxTCRJ3wA972KfzzPLrOvzOILu7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646225; c=relaxed/simple;
	bh=LQSAMvuMIXoFBsB3EoBPRj/v5VaC1ztq+/z7kXIde2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dA391eDePld2DUR7xQ4tjSyz7tZSoWiUpIJZzpZWnYDr6l0EDWwTDgHJ6F/JxYmKqdfMXbTwQ10A0gir6vJRKjb2VZBSmNyp92NDkZPrnYhioHzAoRxaOJTGmHnkSULJw8ehUCjbhSGfuTNAPWJCzX1ErK/dwtOr28CRDEndcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3qEJ01atq7wOACA--.2128S2;
	Thu, 17 Sep 2026 19:56:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: antonio@openvpn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ovpn: Fix use-after-free when releasing peers in unlock_ovpn()
Date: Thu, 17 Sep 2026 11:56:36 +0000
Message-Id: <20260917115636.2150032-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3qEJ01atq7wOACA--.2128S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw47JFy8WryDZw4fuF1DAwb_yoW8JrWfpF
	4rGr47JrykJr40qa1kGF1DWFyF93W3K34YkFyqk34fZrnxtr1YqryxJwnF93s8trZ3Wa1Y
	va1qyF15AayUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYNA2qrq3aEGQAAsP

unlock_ovpn() walks the release list with llist_for_each_entry() and
drops the last reference of each peer in the loop body. Advancing to the
next entry then reads peer->release_entry.next from an object that has
already been scheduled for freeing, which is a use-after-free. Use
llist_for_each_entry_safe() so the next pointer is read before the peer
is released.

Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ovpn/peer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..12ebc5affdd0 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -26,11 +26,11 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
 {
-	struct ovpn_peer *peer;
+	struct ovpn_peer *peer, *tmp;
 
 	spin_unlock_bh(&ovpn->lock);
 
-	llist_for_each_entry(peer, release_list->first, release_entry) {
+	llist_for_each_entry_safe(peer, tmp, release_list->first, release_entry) {
 		ovpn_socket_release(peer);
 		ovpn_peer_put(peer);
 	}
-- 
2.34.1


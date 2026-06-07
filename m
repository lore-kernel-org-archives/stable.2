Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2985C347FC0;
	Sun,  7 Jun 2026 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780832158; cv=none; b=C6tXa5d//5ovL2sXszqQZDacRWFWzp9gihQf0WQL/4hboEzy6tzf+qX2tIwRrcFLZzrEYNb1gunij6qJSaMF90LkwG/YyqheEutm0hsNHl0sIyiti3uY9PFcze5ju0cgBtd2Q+2RdjMf55H0yjVjDGstmJR/lhwGezw1F726Ge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780832158; c=relaxed/simple;
	bh=ysleqvi/ZyuwE5I21DlluB529sBtmOC38NzLRoU5bDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+wBmEv1hptVTHBj5DXDClZB2hi4mvW8WRdWgLODwXU6jzonKw9nxVIUG/jg1u/N9KQ1ks40L4o0xrKGMUS7lrA6lqlV1cL1fXSVNoaa9Vm5R3hjisdDct+qEfFvtM/38OZpJx2gMOhUk7L6hwQif3Le02XwN/oKrbUzRlTRuu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=O8ImGRje; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="O8ImGRje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=3aWVc
	nroJFqAiNfaxYPZenV1m8jAT+VZ8WaKxDim/qE=; b=O8ImGRjeDXXN8UklWrAUZ
	26m/raIabnMJnparAWAbBW0ofMWxUSFwmgfBVEVNa0k1vSuJrzJwJ5AFZhmDfJns
	iK8/ojePVbKytWTnrOTsgLH7gMgim9Imr9a7O6COFVuNeO1fIrjv1HkIhvPi3osN
	jwYB2//xAHvGLOeZ+JD3F4=
Received: from localhost.localdomain (unknown [101.5.11.216])
	by web4 (Coremail) with SMTP id ywQGZQAnC5uLVyVq_ogTAg--.35520S2;
	Sun, 07 Jun 2026 19:35:39 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH net] vlan: prevent cross-netns promisc/allmulti propagation
Date: Sun,  7 Jun 2026 19:35:28 +0800
Message-ID: <20260607113529.98178-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQAnC5uLVyVq_ogTAg--.35520S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1kCFWxJrWDZw47WryxuFg_yoW5CrWxpF
	WUCFn8ArW8GFyS9aySvry7GFWUtF4kZw4Ikw1rta48uws8XFyfXr4rK3sxCryqvrW7AFy8
	AFZFvr1jkF4UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0Jj4NtsUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgILAWoknpt7nwAAsl

vlan_dev_change_rx_flags() propagates IFF_PROMISC and IFF_ALLMULTI
changes from a VLAN device to its real device. If the VLAN device has
been moved to another network namespace, a user with CAP_NET_ADMIN in
that namespace can toggle these flags on the VLAN device and change the
promiscuity/allmulti counters on the real device in the original
namespace.

This breaks the namespace boundary for receive-mode state. In a QEMU
reproducer using dummy0 and dummy0.100, dummy0 started with flags 0x83.
After moving dummy0.100 to another netns and running:

  ip netns exec testns ip link set dummy0.100 promisc on
  ip netns exec testns ip link set dummy0.100 allmulticast on

dummy0 changed to 0x183 and then 0x383. dmesg also showed both
dummy0.100 and dummy0 entering promiscuous/allmulticast mode.

vlan_dev_set_rx_mode() has the same cross-netns issue for unicast and
multicast address sync. Return early in both paths when the VLAN device
and real device are not in the same network namespace. This matches the
existing vlan_hwtstamp_set() namespace check in the same driver.

Fixes: 6c78dcbd47a6 ("[VLAN]: Fix promiscous/allmulti synchronization races")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
QEMU verification:
- Before patch: dummy0 0x83 -> 0x183 -> 0x383; PROMISC_PROPAGATED and
  ALLMULTI_PROPAGATED.
- After patch: dummy0 stayed 0x83; PROMISC_NOT_PROPAGATED and
  ALLMULTI_NOT_PROPAGATED.

 net/8021q/vlan_dev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 7aa3af8b10ea..3d1ed61e5a10 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -471,6 +471,9 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 
+	if (!net_eq(dev_net(dev), dev_net(real_dev)))
+		return;
+
 	if (change & IFF_ALLMULTI)
 		dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
 	if (change & IFF_PROMISC)
@@ -479,8 +482,13 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 
 static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
 {
-	dev_mc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
-	dev_uc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
+	struct net_device *real_dev = vlan_dev_priv(vlan_dev)->real_dev;
+
+	if (!net_eq(dev_net(vlan_dev), dev_net(real_dev)))
+		return;
+
+	dev_mc_sync(real_dev, vlan_dev);
+	dev_uc_sync(real_dev, vlan_dev);
 }
 
 static __be16 vlan_parse_protocol(const struct sk_buff *skb)
-- 
2.43.0


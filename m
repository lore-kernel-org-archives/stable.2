Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892593;
	b=mUONgbrqzgBPFEiO1RjW3gs0V1OXOKn8fPuA4SRPZZ3I6Gg6uttzxrPclzvE9TP5EI/L
	 lHConkEUM0lxZpMvpkUzYS530qdCzTRvg4TOYmw/y9LqeJGLHqlrlM46A/T94jQgA3qhf
	 MQ5wkpjYlAE9UonCYuHxTAW1Tz21mSCQgavM+8h8BoatShApAlTT9ORkNi7qwWVETgX27
	 SFOwqkAsSW7M3z0pxCQn2SdVHbdf1+gUX+NF/3cWrS2JUcbQnj8xqP2EWO2APN7XS9F+/
	 hGXKjjYH7FjkBxLA4qvWLC3UF3IO5bsjCznIhJFcd0UYvqDFj6E1QjnOyZ1MCvxxKyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892593;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8dPfkBHJRZmNcRJRAy4L22rNijjhvjnr83TmmDvpon4=;
	b=TxFZCEEhmykVgnX/mRwOwl1gETiIofOp3J1xllHYYK3hSVe45LgnXpwcf8ndPSNRZzJB
	 Jkmer63Bt8f+g48z+oS3opI7m1TmumTEvZGTdcSt9YgPmg+64dOiXy7cS+nO705pHVFFY
	 jtN3z5rKs2piSQgIikMOxCjy9lSHXYozeVBq1GkAQFW7lGLnIoDvBNnzlkCLYi0BG3BJu
	 lH9hMYxYobPosxAqRd4zhoxVBO6jJtUiVuuV57/x7PrakDAB+Y+KumDWRIx6hL7x27W3o
	 qR5UUR07mTaGOKwDapBHGO9p5S8iIkRsIOy9gwn2h4VY6LMOqNylTA5XiDik1msUmYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DWkqEJBy;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3D606A31A;
	Sun, 25 Oct 2026 01:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B3D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DWkqEJBy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=DWkqEJBykca1o7ex2wdzBm1AZ8xG/3ISiq8HJTqMOKU3sUN5e8dcrwUeGEYLPduGQrwG0KlQuBhgR
	 IWfBCd9YwzysaEnzLh7Izyb+SKAE2rdzwLbfIkJCiL1LDZdrmBnEnfk9yMtzR8ytoIZClJjmvx69+F
	 E7y8xerM4iSh1o84=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96add5ea05b4-47c22;
	Sun, 25 Oct 2026 09:43:03 +0800 (CST)
X-RM-TRANSID:2ee96add5ea05b4-47c22
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86add5ea59c8-7964e;
	Sun, 25 Oct 2026 09:43:02 +0800 (CST)
X-RM-TRANSID:2ee86add5ea59c8-7964e
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	dskr99@gmail.com,
	maheshb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net] ipvlan: fix RX byte accounting for local traffic
Date: Sun, 25 Oct 2026 09:42:51 +0800
Message-ID: <20261025014251.542973-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

For traffic between ipvlan devices on the same lower device,
skb->len already includes the Ethernet header. Adding ETH_HLEN
again in ipvlan_rcv_frame() overcounts rx_bytes by 14 bytes per
packet. ipvlan_process_multicast() does the same for local broadcast
and multicast traffic.

Packets received from the lower device have had the Ethernet header
pulled by eth_type_trans(), so their counters still need ETH_HLEN.

Use the existing local and tx_pkt flags to distinguish these paths.

Sending five IPv4 UDP packets with 32-byte payloads between ipvlan
devices in separate network namespaces increases rx_bytes by 440
instead of 370. With this change the count is 370, while external
traffic is still counted correctly.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
Tests:
  UML: 34 cases, three runs before and after, covering IPv4/IPv6,
  L2/L3/L3S unicast, L2 broadcast and joined multicast. Payloads,
  sources and RX counters were checked.

  x86_64 W=1: full builds completed before and after the fix with
  no new diagnostics, using adjusted allmodconfig and allyesconfig
  configurations with WERROR, KASAN and KCSAN disabled. The latter
  also disabled KUNIT_ALL_TESTS and dependent tests to work around
  an existing MCTP assertion. Configuration dependency changes
  were retained.

 drivers/net/ipvlan/ipvlan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 7ad12dc7..ba646293 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -276,7 +276,7 @@ void ipvlan_process_multicast(struct work_struct *work)
 			if (!(ipvlan->dev->flags & IFF_UP))
 				continue;
 			ret = NET_RX_DROP;
-			len = skb->len + ETH_HLEN;
+			len = skb->len + (tx_pkt ? 0 : ETH_HLEN);
 			nskb = skb_clone(skb, GFP_ATOMIC);
 			local_bh_disable();
 			if (nskb) {
@@ -331,7 +331,7 @@ static int ipvlan_rcv_frame(struct ipvl_addr *addr, struct sk_buff **pskb,
 	bool success = false;
 	struct sk_buff *skb = *pskb;
 
-	len = skb->len + ETH_HLEN;
+	len = skb->len + (local ? 0 : ETH_HLEN);
 	/* Only packets exchanged between two local slaves need to have
 	 * device-up check as well as skb-share check.
 	 */

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b



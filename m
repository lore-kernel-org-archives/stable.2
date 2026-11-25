Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597973;
	b=DKnAJb6hVfgVmiN9PSjtopTQ70/R3tzj6Gbkr4/OfE2KEra3yf8Tgw4e5G5T6CEHrljq
	 ow8H6LKubz0Bb/Vwd2LvNe4jQdEe+lNleSk2nC0CyJq3kFnKDXGaUVMJFsS+GIdpa/bDG
	 P3WdZbiFdf6v//TaJm+FXpB1Bx6QnllPee2tHkWBqByuvT1ymjDtCIzyAhUh0vhgDpHOn
	 KTzOSnAsGotbw/0VN4RTy6pns+kraszO2Hgnd+gd186EkjPr4G40yci3DfjHfqoCJ0t5k
	 8546uR8V0nySIeb9iqsUDJWMOZeohzpyc3EEMB5GfRuvIKFuhk8rP7fCpr8ajjOeJzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597973;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PvF2jtyqcE/NqkJFPuplXRxkSnM877nXqbT6t1W9RIE=;
	b=wLYMWUjdsy9NRnc9TU5P1O6RDWd+L9xGkVVm8dDjcfTfF2OhkEJMI2wXNAoWljjWFIVz
	 zOw3zkPSvca1jh870oKaa4o3A62CwrG6wEB+bs069fyeGL7ah5xqbS4NDAHTmVQqbOhyF
	 SDf8E9a07mRLAFVzjXUmKrqJ6ga0dzz2gAV2jPzlMwgqy/tIM3c2ahxE8iGVd8u8fdeVF
	 kjqt73qNVI+d2bVSWMea4Kthq4/CfmyTXoc9DPyfftedHzZWQvnyJiz6RBBHPHrVoeIjD
	 AvUC0DdkEF7SyxU2SvACRAnbYtY630XhODUCoakKDTVPorhR9KVz1I0McMCTUO5IYnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iqWkgIQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD5606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iqWkgIQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775B11F000CA;
	Wed, 25 Nov 2026 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597973;
	bh=PvF2jtyqcE/NqkJFPuplXRxkSnM877nXqbT6t1W9RIE=;
	h=Subject:To:Cc:From:Date;
	b=iqWkgIQIoGSfOeqTBEBYbfU3Loeor6D/IpigXiFCRTdQpOknNajTWfw3b6pe6frxA
	 X7N2zVMbITFuBWXJVd68i0eWkLYix2/yyXn8r4W7UmhsSFDPZ16TkLM55PUSDqz4Xw
	 D1F52fOnBEocSuJfl3pP/QmoZoEr0vgrDCatX47U=
Subject: FAILED: patch "[PATCH] net/sched: act_ife: require a full Ethernet header on egress" failed to apply to 5.15-stable tree
To: jhs@mojatatu.com,horms@kernel.org,kuba@kernel.org,sashiko-bot@kernel.org,shawnq1@163.com,victor@mojatatu.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:03:42 +0100
Message-ID: <2026112542-skilled-apache-bbfb@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 11dbce09083473249c3843ff31bf8d8fa01bdeef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112542-skilled-apache-bbfb@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11dbce09083473249c3843ff31bf8d8fa01bdeef Mon Sep 17 00:00:00 2001
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Nov 2026 06:50:30 -0500
Subject: [PATCH] net/sched: act_ife: require a full Ethernet header on egress

This is a followup of commit 5b483f7791b0 ("net/sched: act_ife: Only
operate on Ethernet frames") as reported by Sashiko.

The finding was raised by both Sashiko providers (nipa and gemini)
while reviewing the parent patchset. shaos <shawnq1@163.com>
independently reported the same undersized-egress path with a
reproducer, which was reproduced and verified in our test environment.

The issue:
On egress tcf_ife_is_eth_skb() only checks the device type; it does not
check that the skb carries a full Ethernet header. For an Ethernet or
loopback device it returns true even when the skb has no Ethernet
header. tcf_ife_encode() then calls ife_encode(), which copies ETH_HLEN
bytes from skb->data. A short skb therefore reads past its linear data
and the copied bytes, including stale kernel memory, are emitted in the
outer Ethernet header.

The parent commit fixed the reported ingress mac_len case but left the
egress path without a length check.

A total-length test is not sufficient: a non-GSO TUN skb can have a
large total length while only a single byte sits in the linear area, so
ife_encode() still reads past the linear header. Require instead that
the Ethernet header the encoder copies is present in the linear part of
the skb.

The Fix:
On egress require pskb_may_pull(skb, ETH_HLEN) before encoding, which
ensures the Ethernet header is present in the linear data ife_encode()
copies from; the ingress mac_len check is unchanged. A short egress skb
is now dropped instead of being encoded.

Conditions to recreate the bug:
CONFIG_NET_ACT_IFE=y, CONFIG_NET_CLS_MATCHALL=y, CONFIG_NET_SCH_INGRESS=y,
CONFIG_TUN=y, CONFIG_NET_ACT_MIRRED=y. In two user and network
namespaces (a victim and an attacker), open a TUN device in IFF_TUN mode
and attach clsact to it and to lo. Redirect ingress traffic from the TUN
device to lo egress with mirred, and install an ife encode action on lo
egress:

  tc qdisc add dev <tun> clsact
  tc qdisc add dev lo clsact
  tc filter add dev <tun> ingress matchall action mirred egress \
      redirect dev lo
  tc filter add dev lo egress matchall action ife encode use mark 1 \
      action ok

Send a TUN packet shorter than ETH_HLEN (a one-byte payload is enough)
and receive the emitted frame on the other side. Without the fix the
outer Ethernet header contains bytes copied past the short packet; with
the fix the short skb is dropped. The attacker needs CAP_NET_ADMIN in
its user namespace; no init-net privilege is required.

The same path is reachable when the total length is large but the
Ethernet header is not linear: write a non-GSO virtio header with
hdr_len=1 followed by an 8192-byte packet so that only one byte stays
linear. Without the fix the copied header reads past the linear data;
with the fix the header is pulled into the linear area before the copy.

Fixes: 295a6e06d21e ("net/sched: act_ife: Change to use ife module")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Reported-by: shaos <shawnq1@163.com>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821164031.32824-1-victor%40mojatatu.com
Link: https://sashiko.dev/#/patchset/20260821164031.32824-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20261022144736.61227-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/SER-NSBD.v3.r0.20261103064310-2@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 6b23a3965121..5a527da00566 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -878,13 +878,16 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
  * is an Ethernet header because the skb could've been redirected with mirred
  * from a non-Ethernet device.
  */
-static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
+static bool tcf_ife_is_eth_skb(struct sk_buff *skb)
 {
 	if (skb->dev->type != ARPHRD_ETHER &&
 	    skb->dev->type != ARPHRD_LOOPBACK)
 		return false;
 
-	return !skb_at_tc_ingress(skb) || skb->mac_len == ETH_HLEN;
+	if (skb_at_tc_ingress(skb))
+		return skb->mac_len == ETH_HLEN;
+
+	return pskb_may_pull(skb, ETH_HLEN);
 }
 
 TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,


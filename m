Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793524995;
	b=hMY3PYW9sxYp+LPcTBQIlJ0RyLwwtEl15jCLpL8eoeF/pfqbz0WyeA6daBcjxX2Mn44n
	 OSAJWqG0wI73NJOA98c59fr+KNdrcfZf4JeJLFJPksaV87pM1B3+ea3oxJA7TA072sDCN
	 oNfwTYIjRdrRpq24P57WlzEz2B+ug1drb8uC/Jb4iopQfD33N1+01x8ONcqUtorRBq1ab
	 lwcC1HgF+PEt/GSbxbvJsNEspRxtc+VNiCTBfAzYbqf+3nzrFa7kTVWYfCXRC8w0CkRX3
	 ofG8RK3hRiLQsKfJckO0OHdmHPnK/pMzU/Z3AycW9oBuMdr8kcAmu9b56SW2tlKu2TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793524995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QKQXXPx0TtnAH7kUYwvPG35lGpK3RW8/bNQYeuZv+r0=;
	b=jUGsZP67h3DTCSDmPbM3g80/Bj6VOxVHQHhT9Pdeckx6taQYewa/3sBrGB+HHmWygcmk
	 N378odwEjN+1F12KvPVvlzHaK7aqf9uCqt2RB6zpkIQYu3en2h9w91cmSv+d2hDKx9jkc
	 sGEDSVy2oH7E4UbVXTbL6Or30kwrMK4LcyWJWIq6YayZzphjEIqkWkJtWMpjeglJT3xp9
	 HhbDoopvOi1l6otRc69F+/vF6kLgjrU7gSFesSDKCl60ITkID1eymW/wXvGfC3hYdqo54
	 xusDDlbJd8VnHl41gXGYazkw4o3bDFqUGyPhppsRX4xsfDv+fPtcKZZ3lR4Z7bu2Jww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pHyohmlz;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2347606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 09:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2347606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pHyohmlz
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a2551d7b5so4048522eec.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 01:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793524994; x=1794129794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QKQXXPx0TtnAH7kUYwvPG35lGpK3RW8/bNQYeuZv+r0=;
        b=pHyohmlz234FO5ddhkGK3CGghjQSnOPw0U+b7mp+iQ2Qog0pyEnV05r2o/KWSU8x+s
         XyjePTJfY4Yr90NiqcD310MAxjgzU08691YReLHd9Ggq1HqgtsSRdWXu1Z750l8s5MRs
         kJZG2JtcISaQT7kwDUOLBQgnOSMK5S7CMmRAX3pN4Vx6w/yqbQZ5OK1jyKmCDPzcSItk
         GB1gzj365eeujHiPjay8quZNM7Q0AlRzc+b7Mktp7Jkjc769Xz4IMEwmhpaBWTUPr1Dn
         +Kdrx+IqzROl9knrPszFTYBKlorg0c3x8NxszRwtQ+NiKpjQG2Ejy3xcUFkBKP3RH1Gl
         atlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793524994; x=1794129794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKQXXPx0TtnAH7kUYwvPG35lGpK3RW8/bNQYeuZv+r0=;
        b=Sd7wdZ4hOLvb/6KoLRTZFb9PhD0lCd0Wm0wW880Gn3AoKCAT35PPLhukM07fPiKQVk
         N9PqnDGjcQbLbSr5UXHYjSF1+GBsYJmJduo5jRmE+xHWleFqkXXTnDNFkCRDS9ugf4pX
         my3hZXeKlO2OWmG9v4tK9HBpGAMxeRsl2Z6mfau+9OL4dgJ+yKmq2gpMXs7fvWka8wjz
         zP69Ysa5dYQLj4wScKZf62EJuVsRBeOfUiSAEsPXwOnNG2Cvl15h7VUwQ05n8VbfecdN
         r344V0Duq8mQxXoOBnOlE97vo4RHH0B+qT3LR917ECzLVC8cHVCr8l4QhwywQtZEqy3F
         zTzw==
X-Forwarded-Encrypted: i=1; AKwUvByjliTVvRy/6y6Mb+JB5LIgrXLwlfxa2eKU87LGUYoVXkI9y3hzeyhaB0lONOUi+PpLLqQWzy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5DerWv3ZaXs3NaCyXMu9iOZ/I4GwaFjfy8itj8siy4lHcGtCf
	wlV/or5s+US3R8z7ovr2bFoAYfzYLRMwGKliQ2KhJCqVBs6rH70O09Nm
X-Gm-Gg: AYBFou1Mgt/FknJgOsruIsriRtxfFo//0UoUL/JiyUR/V1+GK/1QZG+Qb/UicSuqa92
	S+lCaLoO3xwkRhvyn6GXr5Fn8GXTf12+ChCFAuEER+sz9B9+z1yltL+EQtAoG08+WZTJTiWt3WM
	eWkKEaQY8kT8QmrRzbZuZc+obYSvGPegPYEJ/MWUpaiQ+cYITBZNPpMFOVT6qehKwk4WIZXBQkW
	ynygMVMrgMk1AhPm5nRfi37nvHzzaw+od4vK52b1adIWmLjF8WrubRJHxpVnBqdIxOepiF3yxRP
	ob0q3WbzdO8vS/Jss0LGrtkGMupIarWPwU8V0zROwskcpdZ2DfGpqCS+7jCiXNk0mDxIgdx2mjt
	VL53symdNN9UB8QbN7iW2lRFrbljzfpBfOgwh2KkkEJ/4NdpLHzMe606yZMjyq22edAOJL7KeRS
	HYGGgW+n+wI549hgB9/l4lu0sWwDid7mg1kRBAhhQVJxxRoNEus2vFkm7chiu35No7Qbwcw5Zvc
	1UkdN+/vkjLeN+biomLmNaNvJXjyK7YKfSHtr3N8AQy9maKH7YIRzh6iYuRXOyn3/jmamD3JTXJ
	3DWpkhXl6ocSe3lc4d2Fs0/4LAFIge6QPadR
X-Received: by 2002:a05:7301:53c8:b0:36a:22de:d85b with SMTP id 5a478bee46e88-36a2fd48fb3mr13979029eec.2.1793524993618;
        Sun, 01 Nov 2026 01:23:13 -0800 (PST)
Received: from xploitoverload ([2406:b400:f11:1bac:4040:640b:8a1:8629])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm29407539eec.26.2026.11.01.01.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:23:12 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	Kalpesh Solanki <skalpesh942@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ieee802154: nl-mac: validate device pointers before dereference
Date: Sun,  1 Nov 2026 14:52:19 +0530
Message-ID: <20261101092219.1278751-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A virtual network device (such as a TUN interface) can have its link
type set to ARPHRD_IEEE802154 via ioctl(tun_fd, TUNSETLINK,
ARPHRD_IEEE802154). However, such devices do not have an IEEE 802.15.4
private context allocated (dev->ieee802154_ptr is NULL) and do not
register MAC operations (dev->ml_priv / ieee802154_mlme_ops(dev) is NULL).

When dumping security keys via IEEE802154_LLSEC_LIST_KEY,
ieee802154_llsec_dump_table() iterates through all net devices and
dereferences data.ops->llsec assuming that any ARPHRD_IEEE802154 device
has valid mlme ops. Because data.ops is NULL, this causes an immediate
null-pointer dereference / General Protection Fault:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
  RIP: 0010:ieee802154_llsec_dump_table+0x204/0x5d0
  Call Trace:
   <TASK>
   genl_dumpit+0x125/0x230 net/netlink/genetlink.c:1026
   netlink_dump+0x53b/0xd00 net/netlink/af_netlink.c:2351
   __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2466

Similarly, ieee802154_dump_iface() and ieee802154_nl_get_dev() assume
that ARPHRD_IEEE802154 devices have valid dev->ieee802154_ptr and
ieee802154_mlme_ops(dev) pointers.

Fix this by ensuring dev->ieee802154_ptr and ieee802154_mlme_ops(dev)
are non-NULL before proceeding in ieee802154_nl_get_dev(),
ieee802154_dump_iface(), and ieee802154_llsec_dump_table().

Fixes: 3e9c156e2c21 ("ieee802154: add netlink interfaces for llsec")
Cc: stable@vger.kernel.org
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
Tested-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 net/ieee802154/nl-mac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 74ef0a310af..1acde5af4b5 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -162,7 +162,8 @@ static struct net_device *ieee802154_nl_get_dev(struct genl_info *info)
 	if (!dev)
 		return NULL;
 
-	if (dev->type != ARPHRD_IEEE802154) {
+	if (dev->type != ARPHRD_IEEE802154 || !dev->ieee802154_ptr ||
+	    !ieee802154_mlme_ops(dev)) {
 		dev_put(dev);
 		return NULL;
 	}
@@ -437,7 +438,8 @@ int ieee802154_dump_iface(struct sk_buff *skb, struct netlink_callback *cb)
 
 	idx = 0;
 	for_each_netdev(net, dev) {
-		if (idx < s_idx || dev->type != ARPHRD_IEEE802154)
+		if (idx < s_idx || dev->type != ARPHRD_IEEE802154 ||
+		    !dev->ieee802154_ptr || !ieee802154_mlme_ops(dev))
 			goto cont;
 
 		if (ieee802154_nl_fill_iface(skb, NETLINK_CB(cb->skb).portid,
@@ -771,7 +773,8 @@ ieee802154_llsec_dump_table(struct sk_buff *skb, struct netlink_callback *cb,
 	int rc;
 
 	for_each_netdev(net, dev) {
-		if (idx < first_dev || dev->type != ARPHRD_IEEE802154)
+		if (idx < first_dev || dev->type != ARPHRD_IEEE802154 ||
+		    !dev->ieee802154_ptr || !ieee802154_mlme_ops(dev))
 			goto skip;
 
 		data.ops = ieee802154_mlme_ops(dev);
-- 

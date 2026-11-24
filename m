Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485964;
	b=ouc3h6xfM683KfEPXHRwGuEt6rfx22XxMXB4dk1T0BOOC7cv70ENPp5YYq8cfi06M3Yc
	 D+b/9gDR0awEai9A3cGNfqhBIH66/ni7H3B/kC+BRr+Ail4zXLzQKvTJBr9glK3ya0Ute
	 Ag4sx/FmmCP+T6kTjYlPfTHdHctmnizEQH21xtP/WKotUSie0NXoOn8Ad6G6XeQEb8pIx
	 cGlvnEc/aK+ZYBDWElwK4xuwvjqPpTT4WuNFiEIFo/Xude3jMA8GWng6EFaiW29D0xrls
	 VMNr4T+y9KROv8c+rP+883um0Kt2pyxYq3sd0Oh7nMgG8yRqfeU5Hy5eL2M1kyBdQuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oNydO2SzkAYs5DK03LxQ5roF10I5Ez36bfBcDGkOKnM=;
	b=ETZZwhduk3pG8hSoYd+f/aW5gqJa6CVf/ZqVZ9ygXG9cNKrUKOXMCdIjzFhPM93R9DzL
	 5YmN5qYkrdlvIBz2HUXEJSTVyVLtoHISSFU87e2oIUT26RhyjfChFanEsyWleGTI7K6yl
	 HXheRCKSwcLmuVDsn8KMTfTAfyVR6NAPen7KzKYoMhVQkEhcUHgrKGDlMDq1kih3n94aa
	 zsWgPusmsZuZloZYlMV7LpWpcXFSZlQUmV5LpWGH9fgL48weWR15D+ahS2/wgaBor3Hfl
	 ypVk/n0xpqQ7YHliPs54ynuUhDZeAlq1yeVjRGXWvU3MspQFOBEdKVXldFdcDD0XFHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=TRpzuK1K;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54E606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B54E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=TRpzuK1K
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so6696927c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1795485963; x=1796090763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oNydO2SzkAYs5DK03LxQ5roF10I5Ez36bfBcDGkOKnM=;
        b=TRpzuK1KGHFTa7IuuH6VGVWcrYyDMV5xnup5+ktyk2OPGk6ey7bAIEVyru10LE5LDE
         NiDRegbvx6TKTOFSr1UFHLfl4MepVpYGqNp+DvEXcyINCG1mo2Li2fi9kBH2UCb3sCq3
         sq13UQopbb/DYqrKROJPNw6MV1j+2z/OP4/tkJMbCUaYibpEZ4IQ1mF88vJOcO7mCHx8
         s+hJHHeLtGEH4j1ut7tP8Ys/HsEXh/JRm93EgDxk/umWutTZ2JdQFnHJlc5Pe+bh+Dht
         UddV4oYDjYzwkJNif78lNNiUJ6erll7V5l2mUOfG3JCw3R0IYjV3F9n1nfxiOo/rI3lg
         LWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485963; x=1796090763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oNydO2SzkAYs5DK03LxQ5roF10I5Ez36bfBcDGkOKnM=;
        b=gVxmoq8NVyW0uOwIOKvUYoNMyLUTcaGF+lwfoq1BXNtM7JMnxyngllWY+jmcqcNDgA
         E2lhiEWCr+k6k/5oC13uPFyMp4y7yigmI4N/NHFJKv1AkJhpJ8xlpwbQRR3EIzxmtUbX
         V3TTv9BoaV0ZjJte+x+4H5IUKVV4mPb3VkAZpUsYbl/aoEYpUvflI9yPQDj3vswzfDZH
         NOVyYOc5ACQIILjRKeNItiXNy5+OqNMR3P46oDAtsEW7MWrJRmxPzG///jD+ED1BndKa
         i1IONccUCvF/CEvVYiuvSOLFeiNYCinwFfKHnsiuExfY2cJLjbUL4V+SH1FsGxZib/jF
         fkBA==
X-Forwarded-Encrypted: i=1; AL+hErElgd3E3q02lvb6yhrEa4kQFhFR+8SKCwPaIJhPM6iGn26mAlxzQkaReA+bpUxcrkiHG30pe0w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tWxA5rw0wgn3Av0eV87gcUB+p1n/NJ4X3WE28JT1//b7wkN6I
	jaNrDdua6Wtly9y9tAzmuchizPnxBJJJLC3nprEQi/V3MHsHce5pn25Ylk6T78FP7nrGNEDrQ/p
	RgkJgCw==
X-Gm-Gg: AZFdTZdwu2pFKnxTC8wsXVPpTHEAFOJmYcGhxydbKiBbPBOVdvLDifEoowr8kCXo3fA
	181cSCQqmfdNBSsPmeeYXXbhiKwyjkg4GiSfJvNbrr8nrJPw99koQQ7UBf6Qh5Q0DUm0+NY8w92
	wsZiZt9T9yHG8e6jP1wYmTOnuafDf/v4OUF850qqEgi8Sp+yi41h4OgrIhOT8qV54g4DjvxApZb
	Jp94xlTJ71HjzlVv/vjw8aZeaw0v8rQ1kXhOUYtto1sWqgmNOGv4OhTuPlduDVgz/QiJl6xU5Jt
	Y6ab+VmC0929Xb1bDbQHEUtI6ebSIwScym3OFwelCIjbPEpuOdGKOA4BRD0OXUD16fDqHF/vM67
	O2u/NvClaOHf91bQWb5+2YS1QgU7QUsvm1sQfhjd/u6Eh3ETauBO6CCobevXbUALuecwDTgH6Ig
	6hTK89g/qu0AI420p3ALwcX9xE3iB7W8IAMurLe89cChgqVZGK7CIbDZQdzDY1CrB4dUGy3wZhg
	rIbysZ1QqO6L4+ITKOBEL/OSqBVcAFrpwgelTK8z2uIxofZP+nau7Melc2lcRyYMp4ChPwpsTrm
	LNfKEpe4wb/fMvdK9QKB8onlMvQ2+mJiD1VL9XSMydXeZ0frcQku3NuzG+oaQk+roqBz
X-Received: by 2002:a05:701a:cc95:20b0:144:fa57:c617 with SMTP id a92af1059eb24-1b5568f1200mr12546693c88.34.1795485962869;
        Mon, 23 Nov 2026 18:06:02 -0800 (PST)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm30515502c88.3.2026.11.23.18.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:06:02 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	co+1bf8a8f813116ec5@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH wireless] wifi: nl80211: reject ADD_LINK for an already valid link ID
Date: Mon, 23 Nov 2026 19:05:59 -0700
Message-ID: <20261124020559.1701707-1-xmei5@asu.edu>
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
Content-Transfer-Encoding: 8bit

nl80211_add_link() does not check whether the link ID is already in
wdev->valid_links.  Re-adding a live link overwrites its address behind
mac80211's back, leaving two links with the same address.  An AP_VLAN
on that AP then fails to set up its links, and
ieee80211_update_apvlan_links() dereferences the missing VLAN link:

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:ieee80211_link_vlan_copy_chanctx (net/mac80211/chan.c:2530)
  Call Trace:
   ieee80211_vif_update_links (net/mac80211/link.c:54 ...)
   ieee80211_vif_set_links (net/mac80211/link.c:473)
   nl80211_add_link (net/wireless/nl80211.c:19681)
   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
   genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
   netlink_rcv_skb (net/netlink/af_netlink.c:2585)
   genl_rcv (net/netlink/genetlink.c:1218)
   netlink_unicast (net/netlink/af_netlink.c:1362)
   netlink_sendmsg (net/netlink/af_netlink.c:1921)
   __sock_sendmsg (net/socket.c:800 net/socket.c:818)
   __sys_sendto (net/socket.c:2283)
   __x64_sys_sendto (net/socket.c:2290 net/socket.c:2286)
   do_syscall_64 (arch/x86/entry/syscall_64.c:89)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception

Reject adding a link that already exists.

Cc: stable@vger.kernel.org
Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")
Reported-by: co+1bf8a8f813116ec5@bugs.sh
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e7dd32880598..1059c4aa539f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19670,6 +19670,9 @@ static int nl80211_add_link(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (wdev->valid_links & BIT(link_id))
+		return -EALREADY;
+
 	if (!info->attrs[NL80211_ATTR_MAC] ||
 	    !is_valid_ether_addr(nla_data(info->attrs[NL80211_ATTR_MAC])))
 		return -EINVAL;
-- 
2.43.0


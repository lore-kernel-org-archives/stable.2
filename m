Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241848;
	b=Ldo/2pDDmz3T7UDr7nLuuwV8MWSHHC6uaousBe6oY8cTUVcAuKCvoa1Z82wQ6p2jtCeh
	 zB3a+2hD0scpqvK2c7MCUsqjkA2entlTCakqq3JS+zZojFrVBItlHqrf6mtbS6NrZ063d
	 LVLALfYRS7ENUPCAKOHlIUcDtb/3uIHnnadmE0synivB9eJRlXHdakVpPcuIr9fOKhjAw
	 Bq9wt/LeXHapV8zhTuiQdRETyq9j/9Ef1yWpTMPxyfluqdat/xufyPl21BGjRhyqRFiR0
	 cQ4HyqfoA2dS0vovZYtwb8iZrPd42waOmVfB9Ly/Stw89u8CrapWlR9NCmeRjQiTW1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241848;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=RlT1HOR5Rl/fMmF0MSGp0MrjDJ97osFQBtXZxv2TM3g=;
	b=o6cJPDny7mOxhSXQkn8I5cCNeSj8WnVEM+pQ6LNg+7KtteOvWxFjm6pAcLtcqL9TNipk
	 tlbrCRMiJhJlBvxAOHxLmprZ8jTizvoKL6Jt9CzvwOVqmNtplTD1qDUR4t52hVsDvZ1cD
	 Ld+Lfaykeu6iO7CaezfYnTN1FnaY/d4oQm88fLbOxBLPUaRcGNITJ1f7JJ/aZOpXvzqYc
	 zUTwwxphVnGj4PN8FDTDWy5y2X/HO61j0fD6j2PinCAa+AaMwWbqV5oJj63xdxAbGAFo7
	 etvdEZmKP185na/+2B+si+Onqz5OT2vgrSu/Gf/FdiSLEFqdH1l+pXprWRz8MTIyfvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZrydZk3E;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E4606A31A;
	Thu, 29 Oct 2026 02:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZrydZk3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rl
	T1HOR5Rl/fMmF0MSGp0MrjDJ97osFQBtXZxv2TM3g=; b=ZrydZk3EaA9f2NF4Sj
	0rS+kU1f9FLzRcwUMhl0i+SPGuG+tAKitG199F7lErbe1ZveHRzzEyHNRgk1efIM
	g+9HwcoWR7u7KABJMHD7YNpp+Y2KaegDUSe1QXoqCbhcfxeNIYznF0Fpf+Y9X+/Z
	A8ahswnVn0RkIEjTMEkDiaHJ4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_9fEsuJq8Xs9DQ--.47973S2;
	Thu, 29 Oct 2026 10:43:17 +0800 (CST)
From: Xia Yan <yana06070@163.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	hangbin.liu@linux.dev,
	yana06070@163.com,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/2] veth: keep carrier off when resizing channels with a down peer
Date: Thu, 29 Oct 2026 10:42:58 +0800
Message-Id: <20261029024259.3700-1-yana06070@163.com>
X-Mailer: git-send-email 2.33.0
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
X-CM-TRANSID:_____wD3_9fEsuJq8Xs9DQ--.47973S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4ktF4DAry3JFy7tF17trb_yoW5Xw4kpa
	yfAayrur18W3WUKw48K347uFyUWa1rXay5WF90q3yrZFn8JFn8Zr1Fkayj9F1DKFn5XFWI
	vrZY9FykCa15uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piPCztUUUUU=
X-CM-SenderInfo: p1dqtiawqxiqqrwthudrp/xtbC+wUxt2rissXCLAAA3p

veth_set_channels() temporarily turns carrier off while reconfiguring a
running interface. It then turns carrier on for both ends without
checking whether the peer is administratively up. If only one end is up,
changing its channel counts therefore reports LOWER_UP even though the
peer remains down.

For example, after creating a pair with two RX and TX queues per end:

  ip link set vca up
  ethtool -L vca rx 1 tx 1

vca incorrectly reports LOWER_UP while vcb is still down.

Only restore carrier when the peer has IFF_UP, matching veth_open().
The local interface is already known to be running at this point.

Found during LLM-assisted source review and reproduced with a veth pair
in network namespaces, without kernel instrumentation or error injection.
The companion veth.sh test reproduces the two mixed up/down failures
before the fix and passes after it.

Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
Cc: stable@vger.kernel.org
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Assisted-by: LLM
Signed-off-by: Xia Yan <yana06070@163.com>
---
Changes in v5:
- Driver code is unchanged.
- The companion test drops unnecessary quotes around literal up
  and carries Hangbin's review and test tags.

v4: https://lore.kernel.org/netdev/20261024093007.12981-1-yana06070@163.com/

Changes in v4:
- Driver code is unchanged. Add Hangbin's Reviewed-by.
- The companion test drops the extra GRO on/off runs, as discussed
  with Hangbin, and keeps up/up and both mixed up/down states.

v3: https://lore.kernel.org/netdev/20261022085842.2527-1-yana06070@163.com/

Runtime testing of v4 on 513444cc62e2, x86_64 QEMU/KVM with three vCPUs:
- Complete default veth.sh:
  before: 56 checks pass, two mixed up/down carrier checks fail;
  after: all 58 checks pass. The 55 existing checks pass on both.
- Script exit status: 1 before, 0 after. No checks were skipped.
- Both guests powered down normally.
- The runtime results above are from v4. The only v5 script change
  removes quotes around a literal argument.

 drivers/net/veth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 643b97dc52456df80de10068ccac9af2ada70256..4e75830061ccd3def0476b19a2f92e818464fce9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1372,9 +1372,10 @@ out:
 		 * to identify the range we have to disable
 		 */
 		veth_disable_range_safe(dev, new_rx_count, old_rx_count);
-		netif_carrier_on(dev);
-		if (peer)
+		if (peer && (peer->flags & IFF_UP)) {
+			netif_carrier_on(dev);
 			netif_carrier_on(peer);
+		}
 	}
 
 	/* update XDP supported features */

base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f

-- 
2.39.0.windows.2


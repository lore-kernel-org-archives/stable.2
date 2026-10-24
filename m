Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834267;
	b=rFOpCwERCC4GkykZrMtZfncL+WKlgzlIHzmnqunoj6XVOWlV1Hqt3By/pVttAps7awRJ
	 Mus4omEVJO5cKk/ES5x6HLapi5ei0/pEuMSikLbznVdDDvtO2r+kdnJFD9KvsmoU4PCNa
	 GGlFW44HS9KZ8sy01vFiWpsdo+dyXMeZ9MwVtEMkL8rMbExqv8ZHSJOGA37Cwkbyq9hd8
	 /C0USrCQzDIj2tlUg7M2bvMGFg/DcU4p20sWeEuh1p3YLRL3QN7tdfzITw46CuKjyCtqm
	 2cUHAZhr+xj/pnsYlbDVYry/ohEB1+TokM8SM31lRp3KWV4WAJAJAiIAE1gsv+sFzow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834267;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=4kB+oCvMNA58pfhmwFvYubC2faFkfDxCdQSIlTSMT20=;
	b=AJA+d3KGXsI+iNZNjqaX0ZZWwh1FdXwq+S7o8xjBfiLf4Z33VXRqPbwdBlgfYyghbugl
	 erXt88nS5phefZ+CIToUI/C0vbd2fBBVSWFU3959ZYn1tNamsHQX3aWaqK9rlaR3lbbH5
	 gsMV4J/JV2uUj3k9zd1I57lCrxUqqpIzUyG60VaCI9bM07dZQt+NgvKYHTb/UgKfUpHES
	 LLyDqVJlHnzO97CnM+D2Y3/QW/bCBZuR3iPD1oWybz1oEX1VNEd9L74piGlXCVwcwwM+h
	 w6S2XXvLbfj87Tr+DiUJBWEw51X9i4shY6FcUiHVd6u7VWsZlhnxufn7RN0B9ckD5RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PfgqQzIA;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DF606A31F;
	Sat, 24 Oct 2026 09:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 188DF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PfgqQzIA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4k
	B+oCvMNA58pfhmwFvYubC2faFkfDxCdQSIlTSMT20=; b=PfgqQzIAU+3Uw+BPyB
	cbf2VsCKfgMBCB7chcGVuv+kf0hKPWJsnwiAEvboR25vfiyDtizzwym48YtM7AwX
	jRe9Ww7plYLtJd1jDaSIE95MuxvT9vI7sICyqIZKV5D81PuCG+OySY4IE2BL8dQr
	3a6fS77Nacnsd78FSl007+iBU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX35eretxqoPpsCg--.62139S2;
	Sat, 24 Oct 2026 17:30:21 +0800 (CST)
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
Subject: [PATCH net v4 1/2] veth: keep carrier off when resizing channels with a down peer
Date: Sat, 24 Oct 2026 17:30:06 +0800
Message-Id: <20261024093007.12981-1-yana06070@163.com>
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
X-CM-TRANSID:_____wDX35eretxqoPpsCg--.62139S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4rZF1rAFWxJr47WFy3urg_yoW5Jry3pa
	1fAa4ruF18WF1Utw40g34jkFyjga1fXa45WF9Yg3yru3Z8JFn8Zr1Fyayj9F1UKFn5XF4I
	qrZ09r1kZa98uF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ3ktUUUUU=
X-CM-SenderInfo: p1dqtiawqxiqqrwthudrp/xtbC3w2bImrceq1-DQAA34

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
Changes in v4:
- Driver code is unchanged. Add Hangbin's Reviewed-by.
- The companion test drops the extra GRO on/off runs, as discussed
  with Hangbin, and keeps up/up and both mixed up/down states.

v3: https://lore.kernel.org/netdev/20261022085842.2527-1-yana06070@163.com/

Testing on 513444cc62e2, x86_64 QEMU/KVM with three vCPUs:
- Complete default veth.sh:
  before: 56 checks pass, two mixed up/down carrier checks fail;
  after: all 58 checks pass. The 55 existing checks pass on both.
- Script exit status: 1 before, 0 after. No checks were skipped.
- Both guests powered down normally.
- bash -n and git diff --check pass.

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


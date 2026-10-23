Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752354;
	b=vQUVn5W4stUslcPheo5LMVix1HAd3k9K+Ku7k25zJgRkf7de9mzEsfugzDZ79eP8QQoG
	 4/8zUSqnevXBH6EW6GphNHZ8ZbsEWyxVq8wZ708LiM9yZuQdru7qrNVzuO1KzxLoBNrLu
	 fi9bevFlC2IWpkbNyv+BOWwakAluz4cp+xTpWYFb0oxEdtsYgUNs/Zd+PWtAj4HdzL2n6
	 RHm/NT410ZnhSpOayO5mfL1eH/H6VqNZGa9wRVS32CZ/ry7g5Lytxqlw6E0mzq4BTQJnc
	 XiMd6w3HYg1NkhkQ4sJEPyKF0fe3uvSKBgbmCG3IMP+0cNujUAzSDSTm80mkmwfEaLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752354;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/QICUucPpXxojYxCmq3sRU8Eaip6NUcM3x+3QrmGv+8=;
	b=zAnUxJsqARMh8ifUXIy2n9WZZZOAapQeIMWC8EGqU/qNMtgMKhi1SVIN54ILTPgX1IKm
	 TlHpF2atBElRf3Xu2cRGhdyTZVb8ZI9ZDSa/LCxrsf1DOw2/FsxqUte4ZdmSBWOqPquN9
	 zD6Iae/8Q/lUnhDZHS30r9CNGEsfJkJMLHniNircuUMyxnjCtuTVMP5kWHQDhElMowO3s
	 Pv000SMtl8pL9z2/v39xXcQeeRiIk2N4lC2eq3LW9b7L4+cEZvG835MQ/OuhO1B+8g9Qa
	 JnEq/DQYQjdYLcY85GereuDO8j9rWo7R6dNRoEzy0StpGTMkDEUKVzpyXYiRBG3/1nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m7oOr6su;
	arc=none smtp.remote-ip=95.215.58.175
Received: from mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D0606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE0D0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m7oOr6su
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e0Cethm8EB8vXNdwt1eCOrxjlbHI4XfqJVujITYWMIw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792752351; v=1; x=1793357151;
 b=m7oOr6su+D3IRWZ+Nw1K5IVj2dKwCtI3MQG2UExgvDS5QXsBLJPkm8rMAgKChheqDtW7699d
 ZC0UF8msPReMirU8vU9UbEJUODZj2SeaqtPGcOMF58+McY+yKmVHHN6VExTNqDiw0uskvWhKvdk
 3QeQPXCaFMtyLl8M+ge1aDgQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 536d72eef6148e6b;
	Fri, 23 Oct 2026 10:45:38 +0000
X-Mizu-Trace-ID: 536d72eef6148e6b
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] bonding: fix out-of-bounds read of arp_ip_target
Date: Fri, 23 Oct 2026 18:45:27 +0800
Message-ID: <20261023104528.232427-1-jiayuan.chen@linux.dev>
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

arp_ip_target is a module parameter array with BOND_MAX_ARP_TARGETS
entries. In the loop parsing it in bond_check_params(), arp_ip_count is
the number of accepted targets, while i is the index into
arp_ip_target. Invalid and duplicate entries are skipped without
bumping arp_ip_count, so bounding the loop with arp_ip_count lets i run
past the end of arp_ip_target, e.g. 16 targets with one duplicate:

  BUG: KASAN: global-out-of-bounds in bond_check_params.constprop.0+0x1148/0x1440
  Read of size 8 at addr ffffffff96e9ee00 by task swapper/0/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x91/0xf0
   print_report+0xd1/0x630
   kasan_report+0xf3/0x130
   __asan_report_load8_noabort+0x14/0x30
   bond_check_params.constprop.0+0x1148/0x1440
   bonding_init+0x13/0xe0
   do_one_initcall+0xe7/0x5b0
   kernel_init_freeable+0xa91/0x1120
   kernel_init+0x24/0x220
   ret_from_fork+0x5b3/0x820
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  The buggy address belongs to the variable:
   arp_ip_target+0x80/0xa0

Bound the loop with i instead. arp_ip_count never exceeds i, so it
stays within BOND_MAX_ARP_TARGETS too.

Fixes: 5a5c5fd48e3b ("bonding: arp_ip_count and arp_targets can be wrong")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 09aa45d71fab..7019e5d8fdc8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6273,7 +6273,7 @@ static int __init bond_check_params(struct bond_params *params)
 	}
 
 	for (arp_ip_count = 0, i = 0;
-	     (arp_ip_count < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
+	     (i < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
 		__be32 ip;
 
 		/* not a complete check, but good enough to catch mistakes */
-- 
2.43.0


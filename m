Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792846173;
	b=Jl0pQmV7GgrprtLTQTwDbKq1wHYBYPf3kt5saZasL5AfbvpmSVQAX9E96PDAOf/KwX+c
	 SLtMx18H+DB+XVd76ucxzefGpZMo5OnNe+fPPjJ4qDeTfdp6IlQcKuoCrrNAIOX9f06I6
	 ivT/lCYTqJD8cVF/v07OaI7nwNzGQHk/bYXGGYplFpPTsz4XIPC3AQ5zFn1bdf3mu9ZPF
	 8aU7A0twVev7s5Cfuxq83lIUH0ctrzuA6M6kDMl40x85pDI1qEAPz0CPLCAx1fFm7sSwR
	 Jyqs5sB7OKih3Yh1btxOO6Rj/KLqld1kxTbR/TtbfUU906GSoPIWFjz46Uw1mwKG5mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792846173;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=K8+g1Op14X/DIIeHZSUobv7PPw2ftCu7rm2cQlrW2Aw=;
	b=4uRake9LZNrmRWI62f4jVQpvIohnIJB+emQYd4rSWsNSPQaYhpyJiOXIrrAYZP0LBlcd
	 qEPHbgBx3fEui5ieh0kO2SrjnvZvTBI7Y7jg+GlgwRCOGIUiOtMGXMYmMsisATP+PG2qC
	 lNFzyD48yERuusuwBXngO7uMtiSw0inh8U+Hzo5IeBOzT7aTkk6vUSv64x6aWmYTZMbF2
	 sdx/lzbSHY22Qt5Bw/nfnUErRpkYjZyBbg9Uug2gmYEloru+I+9ASGVF4YIISkgFbFpgj
	 78JJqvtjICoun4IF12aQHuUYh84bxc1gtdlEoMeoVTnmmZ3EAstjFiGmOhXWQ4PGoHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelscan.io;
	spf=pass smtp.mailfrom=kernelscan.io;
	arc=none smtp.remote-ip=212.227.126.131
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1D606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7D1D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelscan.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelscan.io
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1M2gt5-1xI7Xy3ftn-0068XL; Sat, 24
 Oct 2026 14:49:29 +0200
From: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
To: stable@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Sat, 24 Oct 2026 14:49:29 +0200
Message-ID: <20261024124929.5350-1-steffen.pfendtner@kernelscan.io>
X-Mailer: git-send-email 2.50.1
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
X-Provags-ID: V03:K1:YOYeLuMCYQ37ZuG1Lt/Qbd+igSPY06ajGufwxEIbeEEWPfMr7Po
 +ZkkMfJ2hbS3B3GE6cIxiawnezUPtPXPdMMv/BilZEALwJD9RLau+RJ2EVv1ss1Y3uzcQrM
 01MnYmAeW80Gr68UyTHW5UrCW57u8g2dk07oghKsvo/+mUjZsm+0X5yUTVFNxsorqksZiGo
 4ZQ1FHIWSymAea+Ia/jxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ywQis6GEVsI=;2Ed5rwbiB5q3Sq9jBCnmd2+Hcg9
 BeqsUlKmZSirzoz5YP7awgxIrPQFQf23035sFdgOMLrcWuEg+2nNt5HEPbPEf2B7FuNMSpHXv
 oI1BW7sD11TD/mGcvhx6xKeOoWiO69GMwsUDdJrfkOinnYGfa8B8sksqQfLcPO3Lm4OS/DWi4
 IAPspzjnQYHDxO9WB9H32BmaxCAdz0iHiIdnR6fYXyYOAf/D+NIz+dMjEjIMnuC1JXfYABu5z
 AcWCK3KV+nWmDc6gU37W+u6kaxdOKJa+vzoYIzLCO9jPjwf2TaCBlvJfvyHhdng0tVm42rYLR
 wrWwOVeoUCnowQC69l0sJLbAOBCEd2vd883AfQkYuvuHL82KIm6TTDLroyo+SqbE7YKVsmttQ
 p8BV0SKmRRAFNyyDnhMug3RTXnXKpmI8qpDJXWefC6UfXuOfIS7YGzEueGxOrW+PRH4wHtkql
 QepvOUPNoCn1CpNiMr03gweQDOGdw0bI2yCixnCxseVtcaN++VRb1JK56quSKfVXYaXKLhCC8
 HsC8/Ci16FOkR+j9TIATpxvHVzaG4UR0BQSz5gKASYqUGRlRwwRf7uRYp+TqNwLQWTc51r6R+
 VAYDJgcqP1jgaa4vKSKpM4UK466hLhKA0JNoq+/lejE76Zgs2gdWdNqLiVwkkiCynqgkkWd9b
 6nejmBF/ru9E+OJP652Ifh5CclY8hsrglLhiA+6rhpHmxr3yxzic7Veqqn3AeZFjARy6T2AlB
 5dT9Qcgy8u54gc0aNjgQ8LF6MmTCJfQMv/lsr50JZ+PJ2Yw/qoPK8x2yxFFpSWw9Y6MvIJS12
 Q+YP+1p9wfLGXmR8FLk8tu4EBjqvYhs8nYks0OvBGOZw2unDcvQ3PMLsOdJ2dtdOOiIwBk+KT
 EDORp8YykWc/0urQIxyDuIkjw1T4t8sCFx5twD5tQRZGXefxRWR0c0n5F3ff1QKmoAQ4RRyKM
 FgwGkBjv4LaL6gxDtmE2VZTAC2aMcwfuZaGimnTFGwd94M1x+vLjuaFyz+ZdsKAhiImD4M16B
 MpgELH4qB6ZwGH3iNLXa6SOXEirfvqiSnQvd7wrVSD0O3GRcCukq18jodaUoRZE7Owa/J4Tmz
 JBC0ipNbmeVaRBV7Dbe9U1wfyyrYfRJVyyzxwyT2X+z+OsLqq/gnXTSDYrV3wwf+H/mZgmQaE
 Akhq8OcWDxgwlC2/0d3W+rdTvdhBa2leP+SrwUMW92z47PgHs4p2Was8zasT63gr2o/HCJUJS
 lkVBuXEKOCGc3C1StziVumktOe9Yevpzpo7GOS2rYlAhNrR9qsRK3Ec2rYsqbFwI6ytRaZf10
 b+JGyZjOh6DFsytpTx9A26kHz2nr4GUMBOs42jhRuusyOwLoFr01FwjxMCwOchY57ABhbjey4
 3s9fqW3oYmVESrXiu+zOVOuGX0MyljnEZ8sE7jFNdapI7d1ouXE+6eClTIXxYsQYut5UlNZf8
 1WhkVrYHtBsBXuN061ilofjxt/do2d0FI472t3nbSFOQudts5Cpb7ou+vG0/YhpM9sRmhMMaZ
 kzDIHovZe48siv8QHFFzYc+8PsNu6wajzuTJe30St0iypEoJQYleX50GW6lBvfnSJU0HVH16P
 Pmq3qxvIgfZmRpYysH3rodl7uYOGyoqq6i9hJUEI6CF8xu5qtMhxztWQs0IfuueDWfg9fy6sB
 Hdvm1yIiJVOExD9mlwSoOqs4n9byh25HYnP10/1xQITF6Xnrvazg9oftkAGFswL/pxMD88Q7/
 2X/HKyh5A/UAzc7jCmfkKW30qjXMUXZE6xO6TYVtlITXDuj3lI3ZEDCRp0by9J7i/o5X0cZg2
 pL8XPoIRpQijZNQbpQLakXXRqbfy3282Q2XbXYHkq01UsFpu6pLWPNEa4errwaeoACshN3Ske
 iuP01lL4BBuGPiw54K/bq1Z9KuSjgW8yhJKlCc8SCW739DRoGWmKtcrOydzfdf08/YL36W/lk
 oC/8xbDajHdEyn6/Kt9SlnRkBcYF4ib1Uf4vPOIEOtKYys2Or5JTb8Q4TljC7uzpFhhZidTnj
 rfqUU15/uUKlju6xLkxiMM3Zmg6EjeXKjW8zcAT1fSu0BJrjkw9O4396CUfTLlyko56K0vU4x
 x9tVwq1sKuTgoywO5ico2ubTzXOB9E1rNMzbXmC0I7vjXwc8dSceKUrigc5XyHzwiFADt5BDW
 lxubwLMwM6GnFpdbsWIdDnf6RInFev/sgO1xhzqb0FNM/dD8mtz5BrdG7QHhVbNk4bnHHdz5T
 m+xbFXCjjUC49X4Q7D9Zr8jQQOboAGBRp3G2e0cRqsYXe8EK6CctAIjNLdc/4/04BHa1gTM0Q
 Z/L+JnGPQhwJs+PzvuQCw9eh8mi3WV5IC3e84mTZ7kmPSYJ5rmMuBaM/tnWx6pMOBvFazbHHM
 LqiAoPX6V0GqzXdKr7a1G5I1hVQ+rZVkaDPhFdotENCube790TI6UHO2PMzkxsEOt5dLj30qg
 2ixS3la3F+ny5nPRRP2ofKYPf9u78tkL8mRnFLsbelIXuzClytWmK7lsNYCAQe2FHLSvl4RgS
 79BqE7UDDS1hPnLZVLndXlhGHnagXdMjjZJf9PbCubQYRq0DVRLyz8DcBj7j4+3w3uWdjWSvm
 Afbhzq/h9paGvKuUNXuQ62LVjHqnl7r57et22UYIMkoBMNlc65j1rQPjISDGkgyffdL/m+HdM
 jRmUCGIGwOTGl/jWPYSEDc/GZbOliSQkTd0ZXzc8iBZpj3hel4MXk5ql/qGo0GCw/f+nCoXUs
 thlsx3EJ1G39dKhdfVQ+ZJslzw4zU+id1WJ3sOrDvCSy1jmAhTOANW2k+XPcrcAUMi/vAHGK7
 tS7FfZAwuwS089rlZ+BLmixr2FrLiDSgB8dC+Yxvz+aWjKSjSifahNekp7N6M4GfY7VbgpdpR
 8KaO0oCkaIOOrapLhKuGt3oysUn7l0uiky/4yX1iq8bxF5N3UjzZHLEUc0Q4UgfSQ/OJAL6lE
 bAJeEIFdfMlvSLCRnsPUJ3cYU8XmpOUHJrH3YnCXtsOT3o4Vw1k4021Uet8H7N9Q2BifVjknJ
 lu8ddbziNwBChj709jMQaTo4dssh9Q7DZFaDElNgGSsixxeBdRAabGqDH5jbhzKrLMal7OPLu
 UhCRuB0IauRSKRdK2x2HeuTbGnIMx7eKbEgDw+3scFXkXNqBuASLg4JN57Bg82bCrCA0jGgSi
 MAAVyHDRIUsqVfPHkV7H+zfNPFMwViYJd0aPWeZE8cUkVLQRbj5AGzYark5YiuQan162PrdAx
 nvhWVDpzv/U5BCwtYFAehp2ahoWNj/IVYUXi6YkEb22bk76tj5f0wnqHZXoKswweKPbTR6dMm
 5Q2IWwIW/Y5Es0RDpsP9PzyONrZMXZZQ1EuXzeEPTxPTRU2sZQ=

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 2884bf72fb8f03409e423397319205de48adca16 ]

bond_xmit_broadcast() reuses the original skb for the last slave
(determined by bond_is_last_slave()) and clones it for others.
Concurrent slave enslave/release can mutate the slave list during
RCU-protected iteration, changing which slave is "last" mid-loop.
This causes the original skb to be double-consumed (double-freed).

Replace the racy bond_is_last_slave() check with a simple index
comparison (i + 1 == slaves_count) against the pre-snapshot slave
count taken via READ_ONCE() before the loop.  This preserves the
zero-copy optimization for the last slave while making the "last"
determination stable against concurrent list mutations.

The UAF can trigger the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in skb_clone
Read of size 8 at addr ffff888100ef8d40 by task exploit/147

CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:597)
 skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
 bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
 bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
 dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
 __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
 ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
 ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
 ip6_output (net/ipv6/ip6_output.c:250)
 ip6_send_skb (net/ipv6/ip6_output.c:1985)
 udp_v6_send_skb (net/ipv6/udp.c:1442)
 udpv6_sendmsg (net/ipv6/udp.c:1733)
 __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
 __x64_sys_sendto (net/socket.c:2209)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 </TASK>

Allocated by task 147:

Freed by task 147:

The buggy address belongs to the object at ffff888100ef8c80
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 192 bytes inside of
 freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)

Memory state around the buggy address:
 ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                    ^
 ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Backport to 5.15.y: bond_xmit_broadcast() here walks the slave list,
  not a slave array, so there is no array index or slaves_count to
  compare. Count the list entries instead and compare against a
  READ_ONCE() snapshot of bond->slave_cnt taken before the loop. The two
  can match on at most one iteration, so the original skb is consumed at
  most once even if the list changes during the RCU walk; if a slave
  goes away mid-walk, the original skb is freed at the end as before. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
---
Not a clean cherry-pick (see the bracketed note): 5.15's
bond_xmit_broadcast() walks the slave list rather than an array, so the
"last slave" test counts list position against a READ_ONCE() snapshot of
bond->slave_cnt taken before the loop, instead of the array index the
upstream commit uses. Please review this adaptation closely.

Build-tested on arm64; boot-tested under QEMU with KASAN: a broadcast
bond transmitting while slaves are enslaved/released shows no
double-free or KASAN report.

 drivers/net/bonding/bond_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b74732d2924b..249b80ae20fe 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4919,14 +4919,17 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 	struct list_head *iter;
 	bool xmit_suc = false;
 	bool skb_used = false;
+	int slaves_count, i = 0;
 
+	slaves_count = READ_ONCE(bond->slave_cnt);
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		struct sk_buff *skb2;
 
+		i++;
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (i == slaves_count) {
 			skb2 = skb;
 			skb_used = true;
 		} else {
-- 
2.50.1 (Apple Git-155)


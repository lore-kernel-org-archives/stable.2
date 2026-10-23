Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746964;
	b=MUgGrGmZ+lkVjE42uG/7EntOfAb6vPvXsnR6beG+qoFVZfK6Ie98s1388kRsnXv0Ur70
	 7U3ksCwylcLt+92ZDJ5fdcIKO5b6FvAHAyhQHBB6q2Bb9AmdNZt8ODXTiarQgQYTpl72C
	 2R3p+SXCi25iZbqO9ODbLufjSB9JxgnWnE1dxMv4q4NOR+yLu8cjgeOG15EXpf+4ap9Tb
	 X3EmXw4zalnMQCzaQ0FjEtVpR6xhOhuIg6i8hSdCVgHrimRqCptHED8+nolyEQGTMpHl6
	 K7jA7lsy+V9ysdKZvB4BuKJtVja+Xb+K2KKYWxl6TNNAgTrSoXoS+6Y4WUxpohr6P0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746964;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gQa3VPH3WC7Q6OeX84J4Qisj2fpU7RPLlHn2HbeI82U=;
	b=Y0PKfUv0mEanJUokh0mK3V3JTia63isT7YSF+72Iy/wmPJ88Oc4RrMdEPA2hliF2J/9O
	 HFZ/xnHzar/EaoDLOupSlZevuPizmdBdQVRK69WGeRNzu9VQp5ZZNv1KZCVOtYr2VR0gG
	 aMo+IcD+nLSXHzvWcGXLpCMftJkucSSyo2NtOm67dW/t6VN3QcByDzHJUPi047ufbL3XM
	 nXwRvKVdjA5yZa/QYHwb+IbVsLImXPnwDyVZSkveKsFjFsj5nUKl5hqp+QKBcc6zddrtt
	 ePeqj7hH+XeFb1/doIuW2dnTiGZ5IfWyoQatwyqI+G9QBoLdsiTUfI1ZAuNfUlwlfew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YVMKHM67;
	arc=none smtp.remote-ip=91.218.175.10
Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35F606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D35F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YVMKHM67
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AXpBt4cHsmJnsrGVNmAyGambJ4dbgF80uBFZxZfStYY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792746961; v=1; x=1793351761;
 b=YVMKHM67oBkq21ZxQ9lCVhFNPOfVj13dMAaMtxP/6qDup5nOQcW+SMWBGGKLAddRixqoc2Hr
 Ao5sWvrD5JRLkqZjR3TUs46e4GqbnLMMnot8UvfUPKqGNvtF+MQzggf+u/kChzey6os2ODLpDR1
 9D3bdIAbJGTBzIqjJplRkZ8Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b33d5272d189b10a;
	Fri, 23 Oct 2026 09:16:01 +0000
X-Mizu-Trace-ID: b33d5272d189b10a
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Flavio Leitner <fbl@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/5] ipv6: restrict mld_qrv to 255
Date: Fri, 23 Oct 2026 17:13:29 +0800
Message-ID: <20261023091419.167088-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023091419.167088-1-jiayuan.chen@linux.dev>
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
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

net.ipv6.mld_qrv only has a lower bound, but ipv6_mc_reset() stores it
into the u8 inet6_dev::mc_qrv, and every MLD retransmit counter derived
from it (mca_crcount, sf_crcount, mc_ifc_count, mc_dad_count) is u8 as
well. Anything above 255 silently wraps: 256 becomes 0, so no state
change report is ever retransmitted, and the first MLDv2 Query received
on the interface then trips the WARN_ON() in mld_update_qrv():

	WARN_ON(idev->mc_qrv == 0);

A plain bridge with mcast_querier enabled on the link is enough:

  WARNING: net/ipv6/mcast.c:1327 at mld_query_work+0x1fd2/0x2cb0, CPU#3: kworker/3:1/2688
  Workqueue: mld mld_query_work
  RIP: 0010:mld_query_work+0x1fd2/0x2cb0
  Call Trace:
   <TASK>
   process_one_work+0x93a/0x1b20
   worker_thread+0x6d0/0x11d0
   kthread+0x358/0x470
   ret_from_fork+0x5b3/0x820
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Cap the sysctl at U8_MAX, the largest value mc_qrv can actually hold.

Fixes: 2f711939d2ea ("ipv6: add sysctl_mld_qrv to configure query robustness variable")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/sysctl_net_ipv6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 1a0a36dcdabc..05a384680332 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -29,6 +29,7 @@ static u32 rt6_multipath_hash_fields_all_mask =
 	FIB_MULTIPATH_HASH_FIELD_ALL_MASK;
 static u32 ioam6_id_max = IOAM6_DEFAULT_ID;
 static u64 ioam6_id_wide_max = IOAM6_DEFAULT_ID_WIDE;
+static int mld_qrv_max = U8_MAX;
 
 static int proc_rt6_multipath_hash_policy(const struct ctl_table *table, int write,
 					  void *buffer, size_t *lenp, loff_t *ppos)
@@ -229,7 +230,8 @@ static struct ctl_table ipv6_rotable[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &mld_qrv_max,
 	},
 #ifdef CONFIG_NETLABEL
 	{
-- 
2.43.0


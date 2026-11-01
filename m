Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793513778;
	b=15zYu29bYEisuWZM1jvd8yiHmYyHV/G+nYnwaMTPvA2Q2cEcRUVYOhh2+RE1eujn4hOK
	 xG0V+mkV8zWwZqSwA+ED4lWdiEN3L0EGyTsoyQSW1ej/g3wBhmIIfNnS+/g3pvbD7K2Ns
	 bJ+NT0lobu5gH91jqQb3aaibRP05SbMUKKFIIAqGKxTm71OazdKZz5TL3cknJyyhstHF4
	 3VfKa1XFyPVG0rhvbpxmHKpUmVlIrSOF8Q+iiWC7bR0wqSdrUoVDmQUHf3xmaLRcwLzs/
	 l5M7b490nQa1SRgQ4hXDJIMm7ISnQgJ7cYiH2x3ASNAGpo53Qk/r4VOCxdx4cZBJ/HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793513778;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hP/wufYrzFLIuJAB9Y1+6Fe9O2Um3BU+tPM/w5XHFXA=;
	b=oj7ZNr7vOk9U8Q9ZvAxVYGNAAK2bIXrAA1rmM13RmDleIyk4gio/XMvrhfxoOM5/jghd
	 V0Wp8tyDJ/4Jz3SYBKeqO5yFDgeoCQu5ogC2DhkUu6WcAvVsmM3QO7abT4zszxFNThwqs
	 9Vbt+D1qW7hLLOFswU0LPsbyZmZiia1eJRhKAXxDa9LDiviHmR4M5EfDhMO4SUP0fv8fu
	 UplTBK/R2+YwOQb9SrLaK1gwiLGxUVBaJpopm/Ju8UN+oHqMnNtfdCtRCAtNADa/laErw
	 av/yNU3rXbXP5bpU7CCDAWdVCCc0iRC20VcS246AhDfaTaK7RRV2WrMSPL9CYke3rmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MFnAF+8G;
	arc=none smtp.remote-ip=91.218.175.238
Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59186606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59186606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MFnAF+8G
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+jgyQbXsrKaLn9nkl/YpTRZhwiLrtYdg6s8W7kdR5tM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793513775; v=1; x=1794118575;
 b=MFnAF+8GyLoxxXthUq9nkMxYhCujTC1xqC3wKS4b1fwYCoAoc3DZUE1EClXqOMOCPVbaz9OH
 TR7MVF3X9jpBnKYORazMRzqzQpRN60+TqMJT+qgv1fI4G3QBn3C/wL9qd/AVJUlb7wOoQbFAgnZ
 CHwlE2V8XyWhBjWj8HJ8ag3o=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1f105a6221850481;
	Sun, 01 Nov 2026 06:16:15 +0000
X-Mizu-Trace-ID: 1f105a6221850481
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Jiri Wiesner <jwiesner@suse.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Gerd Rausch <gerd.rausch@oracle.com>,
	Neal Cardwell <ncardwell@google.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Flavio Leitner <fbl@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 4/5] ipv4: restrict igmp_qrv to 255
Date: Sun,  1 Nov 2026 14:12:02 +0800
Message-ID: <20261101061331.286404-5-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101061331.286404-1-jiayuan.chen@linux.dev>
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
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

net.ipv4.igmp_qrv only has a lower bound, but ip_mc_reset() stores it
into the u8 in_device::mr_qrv, and the IGMPv3 retransmit counters filled
from it (crcount, sf_crcount) are u8 as well. Anything above 255
silently wraps. With 256, mr_qrv becomes 0, every
"in_dev->mr_qrv ?: sysctl_igmp_qrv" falls back to 256, which truncates
to 0 again in crcount, and igmpv3_send_cr() never puts the state change
records for the group into a report. The older version querier present
timeout (mr_qrv * mr_qi + mr_qri) also collapses to just mr_qri.

Make the sysctl a u8 like mr_qrv and switch to proc_dou8vec_minmax(),
which rejects anything above 255, and document it.

Fixes: a9fe8e29945d ("ipv4: implement igmp_qrv sysctl to tune igmp robustness variable")
Cc: stable@vger.kernel.org
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
For AI review: drivers/net/amt.c writing sysctl_igmp_qrv into the 3-bit
qrv wire fields is pre-existing and out of scope for this patch.

v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
Iwashima.
---
 Documentation/networking/ip-sysctl.rst                        | 2 ++
 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst | 2 +-
 include/net/netns/ipv4.h                                      | 2 +-
 net/ipv4/sysctl_net_ipv4.c                                    | 4 ++--
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 71f334f27004e..9e282fb046904 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1906,6 +1906,8 @@ igmp_qrv - INTEGER
 
 	Minimum: 1 (as specified by RFC6636 4.5)
 
+	Maximum: 255
+
 force_igmp_version - INTEGER
 	- 0 - (default) No enforcement of a IGMP version, IGMPv1/v2 fallback
 	  allowed. Will back to IGMPv3 mode again if all IGMPv1/v2 Querier
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 3dc03bff739e4..2833ce6cba1d4 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -143,9 +143,9 @@ int                             sysctl_udp_rmem_min
 u8                              sysctl_fib_notify_on_flag_change
 u8                              sysctl_udp_l3mdev_accept
 u8                              sysctl_igmp_llm_reports
+u8                              sysctl_igmp_qrv
 int                             sysctl_igmp_max_memberships
 int                             sysctl_igmp_max_msf
-int                             sysctl_igmp_qrv
 struct_ping_group_range         ping_group_range
 atomic_t                        dev_addr_genid
 unsigned_int                    sysctl_udp_child_hash_entries
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index cb7f8bf15671c..3efbc7f4b4f7d 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -258,9 +258,9 @@ struct netns_ipv4 {
 #endif
 
 	u8 sysctl_igmp_llm_reports;
+	u8 sysctl_igmp_qrv;
 	int sysctl_igmp_max_memberships;
 	int sysctl_igmp_max_msf;
-	int sysctl_igmp_qrv;
 
 	struct ping_group_range ping_group_range;
 	u16			ping_port_rover;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index e3760daa34706..09f7fc6771456 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -975,9 +975,9 @@ static const struct ctl_table ipv4_net_table[] = {
 	{
 		.procname	= "igmp_qrv",
 		.data		= &init_net.ipv4.sysctl_igmp_qrv,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(u8),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ONE
 	},
 #endif
-- 
2.43.0


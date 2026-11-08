Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154782;
	b=2KGPAm0pEm8R7ZGzPm5Rl4UhoLAqRp1kBx/60s6S4ZcvrkH+qdgoWQi151qB5H2YfqjR
	 GwiDODi/EONKCUjTt+Chytiz1OMfo9KfVYTwTAEuLk7I0Mjdj2zzQRCRUsFc/fGKzAvKw
	 x5HeUjoitx9+KvOb9mDAhnjEe/SEdfy9eLrfauhzcAAT7aMw7zvPW7wXVZBc/zkrVhw7A
	 6dEZHl6iR66HLGXTKwAs587SXzLRgVk3EdH3jhzMV8whzsVDoroeB89Wc6xJMcoyWVG4N
	 x2QcpFzZ/PyUl+3mOw9Q8g71ymlP4DurZJllwLrLELqdR+uGoiJtR4bYXQfo7IK/K5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154782;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9DSuCe65qhyaJ8azYCw22UeBMXJmHmFB4MPv/bGiJYc=;
	b=JLoSFkyegxbtNO+uug5pr0sGhghEbjQjt7DKx4qW0+HI7Io5JYAViJJ/4s5DDeEYidZA
	 ptReUxOGQLRyfmViSrSRqkEbtixJ7OfOHGrSGmLccWrboquKp/rTcBECs24MwpA46fdwv
	 p3QrYhMDUAa4ZUShZvJuTgKAdcRoP/DQoqy8d2sM4Q7avqS+mD4lzUEuhDsgJmw2YowW2
	 5at57/5LzG2b0snPxK20F4FF1t9TSva6XOJRgyZpB6XxEM21TnbemLQlxLKgJFYg/qxb8
	 1LjHj1jpbRNsUCL5yYzzjnSH7vRbQa2sIW+czb9/poqys/9Cw/hvEGJRovsXyAemjkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F80606A330
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 16:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42F80606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so762655e9.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 08:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154781; x=1794759581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9DSuCe65qhyaJ8azYCw22UeBMXJmHmFB4MPv/bGiJYc=;
        b=BaGXEC28rK0qsUD4ZiuYAknu0HmP+qFwx6lS+FJhOu1hhvkUG8ad2ZFwbbo6sOSb34
         KhqSl2z6yZOwDxbK8a/z+ye15ONVrUxGImHyKJfDoLexfLqVB3gNOR1CnN9TrLS7yVwV
         BlEIiN5fq+53BuCHlZgnPal3ac/jOZIH4p/AfEYw0CgDNX6IKLCsgjKPGEir7MRkYvnj
         xB6XPcuG+3Qe13OhtY1syw8f7Xi1eYl7RhrcooMtbGSm56gzfWDfSwccruQJqoeyAhOw
         C2jlVLz0l0uvm9zhqu0oLoKtf5gdlGoAmrJ203LeD1k/K+nFyYF9hBkshqDfWE1rBmRg
         FkrA==
X-Gm-Message-State: APuU4Z9qirzB6Pe4EGiCb1hs8/oIRJK273f74Use30maJIBoLUS0ScQZ
	1Eb64V9xQkXy32NuRlPfE2Tqg0BOdcDlAwCXycZcimsuEpYWHF2mkVyHcR4FhXCNSzOth37cjx5
	PiMpbi/8zmQ==
X-Gm-Gg: AYBFou0b8aJCuRb2ZNJbjRIyoOK4khN1h867UBbFzkMTrjp/v0UQ8wnK9nOye8NGiM6
	Vste478BeJ6yjehRVrHnxW0jMX7xeCsuPensxpC7MjuMsOLCnoaGdCMj+g9jKARiGWj0GKzTg0p
	iwHP8AVYo9NOXSFPG/OZvNZ7x9IFzcKsNaDujSeo04R5HpiEXyamP/4S3/pmFzHfAuQfZ+pRRjh
	8rNPIcOZg7Kz7G+Tl7AQldUKY46moGiITXDJsMy1UnWSN2Vq22lvJCyPhDs+NOcLYot2X7rKPqk
	vmuSgcjNm+FFtKwOwYamnfYBcTxL6m+osoDa22VdpC8gQ1gMxCQv8/ZEtu0NOivnycUOntHtuJP
	NXEdoZ4pl93wD1/m4M8f4O1P+WCFO07apTmgUamB15bASmf5kqMrgELK8q2CPm4+hprfmyjDZwi
	vyAY7jTn7lSNhZnoOP74hKFdWUNvPsFNGgQGrFXOx8CILvp56dgq0oVB/21YG7k7k09iRqQDk/O
	crAkSFI9H+sPw13KBvjstWspW1/fyPT3N/lHJPDugxkThOCrl5bCyVgIJB0V2qds+9UE+mn5YvY
	PA8VdYVgIOVpwEw9VjsXWdDb
X-Received: by 2002:a05:600c:46d1:b0:4a1:7d9b:d4ae with SMTP id 5b1f17b1804b1-4b960d9c486mr37141555e9.5.1794154780732;
        Sun, 08 Nov 2026 08:19:40 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:e93f:179f:cb30:5c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb772e1sm189535415e9.0.2026.11.08.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:19:40 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Christian Schmidbauer <opensource@grische.xyz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Breno Leitao <leitao@debian.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH 6.6.y 2/3] net: core: Implement dstats-type stats collections
Date: Sun,  8 Nov 2026 17:19:36 +0100
Message-ID: <8cf42bcbabc4db62e4243f6d57d6e92da8db8a43.1794153876.git.opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794153876.git.opensource@grische.xyz>
References: <20260812091127.1349673-4-sashal@kernel.org> <20260925180809.603571-1-opensource@grische.xyz> <2026-09-26-daily-reply-0002-re-vxlan-dstats-6-6-reader-and-tx-side@kernel.org> <cover.1794153876.git.opensource@grische.xyz>
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

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit 94b601bc4f8528262b2b83194b7fd3fc2a6da75a ]

We currently have dev_get_tstats64() for collecting per-cpu stats of
type pcpu_sw_netstats ("tstats"). However, tstats doesn't allow for
accounting tx/rx drops. We do have a stats variant that does have stats
for dropped packets: struct pcpu_dstats, but there are no core helpers
for using those stats.

The VRF driver uses dstats, by providing its own collation/fetch
functions to do so.

This change adds a common implementation for dstats-type collection,
used when pcpu_stat_type == NETDEV_PCPU_STAT_DSTAT. This is based on the
VRF driver's existing stats collator (plus the unused tx_drops stat from
there). We will switch the VRF driver to use this in the next change.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240607-dstats-v3-2-cc781fe116f7@codeconstruct.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
 net/core/dev.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f55b7e5ea3a6..d989a21a72fd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10713,6 +10713,54 @@ void netdev_run_todo(void)
 	}
 }
 
+/* Collate per-cpu network dstats statistics
+ *
+ * Read per-cpu network statistics from dev->dstats and populate the related
+ * fields in @s.
+ */
+static void dev_fetch_dstats(struct rtnl_link_stats64 *s,
+			     const struct pcpu_dstats __percpu *dstats)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		u64 rx_packets, rx_bytes, rx_drops;
+		u64 tx_packets, tx_bytes, tx_drops;
+		const struct pcpu_dstats *stats;
+		unsigned int start;
+
+		stats = per_cpu_ptr(dstats, cpu);
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			rx_packets = u64_stats_read(&stats->rx_packets);
+			rx_bytes   = u64_stats_read(&stats->rx_bytes);
+			rx_drops   = u64_stats_read(&stats->rx_drops);
+			tx_packets = u64_stats_read(&stats->tx_packets);
+			tx_bytes   = u64_stats_read(&stats->tx_bytes);
+			tx_drops   = u64_stats_read(&stats->tx_drops);
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		s->rx_packets += rx_packets;
+		s->rx_bytes   += rx_bytes;
+		s->rx_dropped += rx_drops;
+		s->tx_packets += tx_packets;
+		s->tx_bytes   += tx_bytes;
+		s->tx_dropped += tx_drops;
+	}
+}
+
+/* ndo_get_stats64 implementation for dtstats-based accounting.
+ *
+ * Populate @s from dev->stats and dev->dstats. This is used internally by the
+ * core for NETDEV_PCPU_STAT_DSTAT-type stats collection.
+ */
+static void dev_get_dstats64(const struct net_device *dev,
+			     struct rtnl_link_stats64 *s)
+{
+	netdev_stats_to_stats64(s, &dev->stats);
+	dev_fetch_dstats(s, dev->dstats);
+}
+
 /* Convert net_device_stats to rtnl_link_stats64. rtnl_link_stats64 has
  * all the same fields in the same order as net_device_stats, with only
  * the type differing, but rtnl_link_stats64 may have additional fields
@@ -10786,6 +10834,8 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 		netdev_stats_to_stats64(storage, ops->ndo_get_stats(dev));
 	} else if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_TSTATS) {
 		dev_get_tstats64(dev, storage);
+	} else if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_DSTATS) {
+		dev_get_dstats64(dev, storage);
 	} else {
 		netdev_stats_to_stats64(storage, &dev->stats);
 	}
-- 
2.54.0


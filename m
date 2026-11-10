Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330767;
	b=ghxO3N8jLEbEH5M834iGdwfzmWiY+gRbFmlAqdG4TnyEeWaOz5WJ4gKVQvd6n48+30FF
	 vajxXacDtvWIuViLmX9wmgETbMjsByq8oVj2g51OEeryXHeEoEcL0JADO7USbXtq1f7N7
	 Fxcr1RScT7liM6AOuVHW513i0Mw6LBsP+WwxY3gX5SGj0jul0dzx6GaagHANK1pnK5hBD
	 eQOBIzCFNiLODPSSoFWCKWoJODHG3fazlKoXYQolMgpzKkIutDQRzUrhE0pXMeODF2zAa
	 FYK/ONAgN1XtxGv2gQRTj//yIfVlvsgVC6Per6RHEW3mkPyh13bP7LbOvzkiIFYhA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d5Hffi2qW8p5LcPxLMQsHZFGJq7bxKmhrJsNm8W9scw=;
	b=R3mwFgniPJgzuTHwatR1tKs2QfxxBGgkDTvH/MowtMs4a5/9qBfLxPx1QSi9uq/ToLCU
	 vjRO3LEiDe9+l9ekQuUVHdtvNB1fC4zuDBKvlJUeHe2s0t529DzoEZcQzp0D08bhXXyG9
	 F23lInf0HhMzFAA3lC+Ba7ZjC6EEQ0793z5Fg5oSX5LC7V9DQNZmqE/WvcsB3QAtPtkc1
	 Q7DcPdLslzjSt4/aVLf/jPQwbNoqO7778nIUIVJLl1lTlYOb0vhigNuyEmCxnghlw+pzM
	 b8q6CaZx/r2g3mC3xplOgKnoJ71LXPwItekCxyp/D8+0p2FJatGcZD88W+9YWSHe6UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9qkW6hl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6C606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9qkW6hl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56581F008A3;
	Tue, 10 Nov 2026 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330766;
	bh=d5Hffi2qW8p5LcPxLMQsHZFGJq7bxKmhrJsNm8W9scw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H9qkW6hlZFn/qP/pF/2Wnl/N+E+DaKtdgWReAf7lIcMxYyMtVYJKda+HQDVOceOTz
	 NC0kexvEtk+diaaMxqfBBT0ap2iGxxsJMW1o8UToFMm/Qh2TLedmqjG7hCBraEivwZ
	 67sxY40v4Of5UPEqUL3kpo6Y/vbtG0hRKTvkPkt2FUKb1csZPYq/dodfWDdBc3/7yy
	 ea2LGQEd7ZYn8moY6t11Apd5AtGGJFLFUYIa6m8TV0BEZVVezopXwWfql8xvThE7OM
	 RZ1MR+pcmls3jXdacje3GvXUsQMiDgBYZntoUY6Lb4UfGv5a2EkQHLNursCVMvwZTX
	 n/D/um2d5A3fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] net: add include/net/net_debug.h
Date: Tue, 10 Nov 2026 12:12:40 -0500
Message-ID: <20261110171139.2520111-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171139.2520111-1-sashal@kernel.org>
References: <20261107060713-failed-5.15-56453199d28f@kernel.org>
 <20261110171139.2520111-1-sashal@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5b87be9e4978fe507c7e14c0bdff147d10d39aec ]

Remove from include/linux/netdevice.h helpers
that send debug/info/warnings to syslog.

We plan adding more helpers in following patches.

v2: added two includes, and 'struct net_device' forward declaration
    to avoid compile errors (kernel bots)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Extract the helpers that send debug/info/warnings to syslog from
the network device header.

We plan adding more helpers in following patches.

v2: added two includes, and 'struct net_device' forward declaration
    to avoid compile errors (kernel bots)

Omit the refcount-tracker include from the upstream context because
the tracker infrastructure is absent. It is unrelated to this logging
helper extraction. Keep the new header unchanged for the networking
debug checks that follow.

Stable-dep-of: 56453199d28f ("net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h | 141 +----------------------------------
 include/net/net_debug.h   | 151 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 140 deletions(-)
 create mode 100644 include/net/net_debug.h

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 08b8ec57cbbd4..518d4e666db57 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -48,6 +48,7 @@
 #include <uapi/linux/pkt_cls.h>
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
+#include <net/net_debug.h>
 
 struct netpoll_info;
 struct device;
@@ -5343,81 +5344,9 @@ static inline const char *netdev_reg_state(const struct net_device *dev)
 	return " (unknown)";
 }
 
-__printf(3, 4) __cold
-void netdev_printk(const char *level, const struct net_device *dev,
-		   const char *format, ...);
-__printf(2, 3) __cold
-void netdev_emerg(const struct net_device *dev, const char *format, ...);
-__printf(2, 3) __cold
-void netdev_alert(const struct net_device *dev, const char *format, ...);
-__printf(2, 3) __cold
-void netdev_crit(const struct net_device *dev, const char *format, ...);
-__printf(2, 3) __cold
-void netdev_err(const struct net_device *dev, const char *format, ...);
-__printf(2, 3) __cold
-void netdev_warn(const struct net_device *dev, const char *format, ...);
-__printf(2, 3) __cold
-void netdev_notice(const struct net_device *dev, const char *format, ...);
-__printf(2, 3) __cold
-void netdev_info(const struct net_device *dev, const char *format, ...);
-
-#define netdev_level_once(level, dev, fmt, ...)			\
-do {								\
-	static bool __section(".data.once") __print_once;	\
-								\
-	if (!__print_once) {					\
-		__print_once = true;				\
-		netdev_printk(level, dev, fmt, ##__VA_ARGS__);	\
-	}							\
-} while (0)
-
-#define netdev_emerg_once(dev, fmt, ...) \
-	netdev_level_once(KERN_EMERG, dev, fmt, ##__VA_ARGS__)
-#define netdev_alert_once(dev, fmt, ...) \
-	netdev_level_once(KERN_ALERT, dev, fmt, ##__VA_ARGS__)
-#define netdev_crit_once(dev, fmt, ...) \
-	netdev_level_once(KERN_CRIT, dev, fmt, ##__VA_ARGS__)
-#define netdev_err_once(dev, fmt, ...) \
-	netdev_level_once(KERN_ERR, dev, fmt, ##__VA_ARGS__)
-#define netdev_warn_once(dev, fmt, ...) \
-	netdev_level_once(KERN_WARNING, dev, fmt, ##__VA_ARGS__)
-#define netdev_notice_once(dev, fmt, ...) \
-	netdev_level_once(KERN_NOTICE, dev, fmt, ##__VA_ARGS__)
-#define netdev_info_once(dev, fmt, ...) \
-	netdev_level_once(KERN_INFO, dev, fmt, ##__VA_ARGS__)
-
 #define MODULE_ALIAS_NETDEV(device) \
 	MODULE_ALIAS("netdev-" device)
 
-#if defined(CONFIG_DYNAMIC_DEBUG) || \
-	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
-#define netdev_dbg(__dev, format, args...)			\
-do {								\
-	dynamic_netdev_dbg(__dev, format, ##args);		\
-} while (0)
-#elif defined(DEBUG)
-#define netdev_dbg(__dev, format, args...)			\
-	netdev_printk(KERN_DEBUG, __dev, format, ##args)
-#else
-#define netdev_dbg(__dev, format, args...)			\
-({								\
-	if (0)							\
-		netdev_printk(KERN_DEBUG, __dev, format, ##args); \
-})
-#endif
-
-#if defined(VERBOSE_DEBUG)
-#define netdev_vdbg	netdev_dbg
-#else
-
-#define netdev_vdbg(dev, format, args...)			\
-({								\
-	if (0)							\
-		netdev_printk(KERN_DEBUG, dev, format, ##args);	\
-	0;							\
-})
-#endif
-
 /*
  * netdev_WARN() acts like dev_printk(), but with the key difference
  * of using a WARN/WARN_ON to get the message out, including the
@@ -5431,74 +5360,6 @@ do {								\
 	WARN_ONCE(1, "netdevice: %s%s: " format, netdev_name(dev),	\
 		  netdev_reg_state(dev), ##args)
 
-/* netif printk helpers, similar to netdev_printk */
-
-#define netif_printk(priv, type, level, dev, fmt, args...)	\
-do {					  			\
-	if (netif_msg_##type(priv))				\
-		netdev_printk(level, (dev), fmt, ##args);	\
-} while (0)
-
-#define netif_level(level, priv, type, dev, fmt, args...)	\
-do {								\
-	if (netif_msg_##type(priv))				\
-		netdev_##level(dev, fmt, ##args);		\
-} while (0)
-
-#define netif_emerg(priv, type, dev, fmt, args...)		\
-	netif_level(emerg, priv, type, dev, fmt, ##args)
-#define netif_alert(priv, type, dev, fmt, args...)		\
-	netif_level(alert, priv, type, dev, fmt, ##args)
-#define netif_crit(priv, type, dev, fmt, args...)		\
-	netif_level(crit, priv, type, dev, fmt, ##args)
-#define netif_err(priv, type, dev, fmt, args...)		\
-	netif_level(err, priv, type, dev, fmt, ##args)
-#define netif_warn(priv, type, dev, fmt, args...)		\
-	netif_level(warn, priv, type, dev, fmt, ##args)
-#define netif_notice(priv, type, dev, fmt, args...)		\
-	netif_level(notice, priv, type, dev, fmt, ##args)
-#define netif_info(priv, type, dev, fmt, args...)		\
-	netif_level(info, priv, type, dev, fmt, ##args)
-
-#if defined(CONFIG_DYNAMIC_DEBUG) || \
-	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
-#define netif_dbg(priv, type, netdev, format, args...)		\
-do {								\
-	if (netif_msg_##type(priv))				\
-		dynamic_netdev_dbg(netdev, format, ##args);	\
-} while (0)
-#elif defined(DEBUG)
-#define netif_dbg(priv, type, dev, format, args...)		\
-	netif_printk(priv, type, KERN_DEBUG, dev, format, ##args)
-#else
-#define netif_dbg(priv, type, dev, format, args...)			\
-({									\
-	if (0)								\
-		netif_printk(priv, type, KERN_DEBUG, dev, format, ##args); \
-	0;								\
-})
-#endif
-
-/* if @cond then downgrade to debug, else print at @level */
-#define netif_cond_dbg(priv, type, netdev, cond, level, fmt, args...)     \
-	do {                                                              \
-		if (cond)                                                 \
-			netif_dbg(priv, type, netdev, fmt, ##args);       \
-		else                                                      \
-			netif_ ## level(priv, type, netdev, fmt, ##args); \
-	} while (0)
-
-#if defined(VERBOSE_DEBUG)
-#define netif_vdbg	netif_dbg
-#else
-#define netif_vdbg(priv, type, dev, format, args...)		\
-({								\
-	if (0)							\
-		netif_printk(priv, type, KERN_DEBUG, dev, format, ##args); \
-	0;							\
-})
-#endif
-
 /*
  *	The list of packet types we will receive (as opposed to discard)
  *	and the routines to invoke.
diff --git a/include/net/net_debug.h b/include/net/net_debug.h
new file mode 100644
index 0000000000000..19cd2700c20ea
--- /dev/null
+++ b/include/net/net_debug.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NET_DEBUG_H
+#define _LINUX_NET_DEBUG_H
+
+#include <linux/bug.h>
+#include <linux/kern_levels.h>
+
+struct net_device;
+
+__printf(3, 4) __cold
+void netdev_printk(const char *level, const struct net_device *dev,
+		   const char *format, ...);
+__printf(2, 3) __cold
+void netdev_emerg(const struct net_device *dev, const char *format, ...);
+__printf(2, 3) __cold
+void netdev_alert(const struct net_device *dev, const char *format, ...);
+__printf(2, 3) __cold
+void netdev_crit(const struct net_device *dev, const char *format, ...);
+__printf(2, 3) __cold
+void netdev_err(const struct net_device *dev, const char *format, ...);
+__printf(2, 3) __cold
+void netdev_warn(const struct net_device *dev, const char *format, ...);
+__printf(2, 3) __cold
+void netdev_notice(const struct net_device *dev, const char *format, ...);
+__printf(2, 3) __cold
+void netdev_info(const struct net_device *dev, const char *format, ...);
+
+#define netdev_level_once(level, dev, fmt, ...)			\
+do {								\
+	static bool __section(".data.once") __print_once;	\
+								\
+	if (!__print_once) {					\
+		__print_once = true;				\
+		netdev_printk(level, dev, fmt, ##__VA_ARGS__);	\
+	}							\
+} while (0)
+
+#define netdev_emerg_once(dev, fmt, ...) \
+	netdev_level_once(KERN_EMERG, dev, fmt, ##__VA_ARGS__)
+#define netdev_alert_once(dev, fmt, ...) \
+	netdev_level_once(KERN_ALERT, dev, fmt, ##__VA_ARGS__)
+#define netdev_crit_once(dev, fmt, ...) \
+	netdev_level_once(KERN_CRIT, dev, fmt, ##__VA_ARGS__)
+#define netdev_err_once(dev, fmt, ...) \
+	netdev_level_once(KERN_ERR, dev, fmt, ##__VA_ARGS__)
+#define netdev_warn_once(dev, fmt, ...) \
+	netdev_level_once(KERN_WARNING, dev, fmt, ##__VA_ARGS__)
+#define netdev_notice_once(dev, fmt, ...) \
+	netdev_level_once(KERN_NOTICE, dev, fmt, ##__VA_ARGS__)
+#define netdev_info_once(dev, fmt, ...) \
+	netdev_level_once(KERN_INFO, dev, fmt, ##__VA_ARGS__)
+
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+#define netdev_dbg(__dev, format, args...)			\
+do {								\
+	dynamic_netdev_dbg(__dev, format, ##args);		\
+} while (0)
+#elif defined(DEBUG)
+#define netdev_dbg(__dev, format, args...)			\
+	netdev_printk(KERN_DEBUG, __dev, format, ##args)
+#else
+#define netdev_dbg(__dev, format, args...)			\
+({								\
+	if (0)							\
+		netdev_printk(KERN_DEBUG, __dev, format, ##args); \
+})
+#endif
+
+#if defined(VERBOSE_DEBUG)
+#define netdev_vdbg	netdev_dbg
+#else
+
+#define netdev_vdbg(dev, format, args...)			\
+({								\
+	if (0)							\
+		netdev_printk(KERN_DEBUG, dev, format, ##args);	\
+	0;							\
+})
+#endif
+
+/* netif printk helpers, similar to netdev_printk */
+
+#define netif_printk(priv, type, level, dev, fmt, args...)	\
+do {					  			\
+	if (netif_msg_##type(priv))				\
+		netdev_printk(level, (dev), fmt, ##args);	\
+} while (0)
+
+#define netif_level(level, priv, type, dev, fmt, args...)	\
+do {								\
+	if (netif_msg_##type(priv))				\
+		netdev_##level(dev, fmt, ##args);		\
+} while (0)
+
+#define netif_emerg(priv, type, dev, fmt, args...)		\
+	netif_level(emerg, priv, type, dev, fmt, ##args)
+#define netif_alert(priv, type, dev, fmt, args...)		\
+	netif_level(alert, priv, type, dev, fmt, ##args)
+#define netif_crit(priv, type, dev, fmt, args...)		\
+	netif_level(crit, priv, type, dev, fmt, ##args)
+#define netif_err(priv, type, dev, fmt, args...)		\
+	netif_level(err, priv, type, dev, fmt, ##args)
+#define netif_warn(priv, type, dev, fmt, args...)		\
+	netif_level(warn, priv, type, dev, fmt, ##args)
+#define netif_notice(priv, type, dev, fmt, args...)		\
+	netif_level(notice, priv, type, dev, fmt, ##args)
+#define netif_info(priv, type, dev, fmt, args...)		\
+	netif_level(info, priv, type, dev, fmt, ##args)
+
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+#define netif_dbg(priv, type, netdev, format, args...)		\
+do {								\
+	if (netif_msg_##type(priv))				\
+		dynamic_netdev_dbg(netdev, format, ##args);	\
+} while (0)
+#elif defined(DEBUG)
+#define netif_dbg(priv, type, dev, format, args...)		\
+	netif_printk(priv, type, KERN_DEBUG, dev, format, ##args)
+#else
+#define netif_dbg(priv, type, dev, format, args...)			\
+({									\
+	if (0)								\
+		netif_printk(priv, type, KERN_DEBUG, dev, format, ##args); \
+	0;								\
+})
+#endif
+
+/* if @cond then downgrade to debug, else print at @level */
+#define netif_cond_dbg(priv, type, netdev, cond, level, fmt, args...)     \
+	do {                                                              \
+		if (cond)                                                 \
+			netif_dbg(priv, type, netdev, fmt, ##args);       \
+		else                                                      \
+			netif_ ## level(priv, type, netdev, fmt, ##args); \
+	} while (0)
+
+#if defined(VERBOSE_DEBUG)
+#define netif_vdbg	netif_dbg
+#else
+#define netif_vdbg(priv, type, dev, format, args...)		\
+({								\
+	if (0)							\
+		netif_printk(priv, type, KERN_DEBUG, dev, format, ##args); \
+	0;							\
+})
+#endif
+
+
+#endif	/* _LINUX_NET_DEBUG_H */
-- 
2.53.0


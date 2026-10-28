Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197100;
	b=mlDMjEcrMOOxJw8M9bWCgCYR6pXZxARDDHNs4MGizBxTbDxZJdlIoS8PPYGvOE9XIMF7
	 a57uFTP+MqLtVmamkwAbM449Rup66WCtUPY4ZMQxRBeJHVHJTe/HQacmYNabXxbLXCoqM
	 oiOfLz6vSUinAVMqqBSg3oOFmILf6kHvJOJWs2SoiCZkIWZgRDu21UbRimgXLAee9cVhW
	 jKJqczWwYxkYZx3mmoYRF9qiCPqifJNJWNxTOvTyJZJ9saObSIjxxQAdP3ez9OQw6I7rj
	 ryy/Sb+EcCM8ADK/IsprSxYb7qIAniD2hVo3kU7CsGyDCxYAWDPoFLRldQMuukth5jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1ZR9JdhuF78bRej8mJoidoAF0AkalLMRPKfyvzekZdY=;
	b=HJxQvTSjehAP1qNeQy4QQ79uek1v+lpmJ+n7bpS/UNphsJhXHxYZvbX7q1k6bN75uzIO
	 MzRxdfvvZ2BTn9mhckc+89aHSK3dRI8nq72qY1snFmiNsjoLCSQmd4gYgkvhAp5ruCHA2
	 tTqVlzTN7XMiWlfnzwTTjeYM+W64Q2I03+qB5UIiG9YtpI3BqEU7cMZEKljEKptKLPoxq
	 5RPf6e6cVT2uDkzQuB2lNy0lziZRj2qzG3ARiKxRIwn3LPgbdMq5rifVZmxccDFR2tyMO
	 cSpozxYgz1UnHSoi9IvbPJzmKv73XsZB4A0qqTIBKR653ia97icwAqHLcaPYn3uaOdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VhnqMuww;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A1606A330
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 630A1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VhnqMuww
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06210b29fso543636b3a.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197100; x=1793801900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZR9JdhuF78bRej8mJoidoAF0AkalLMRPKfyvzekZdY=;
        b=VhnqMuwwpYoXUUq8HBDgtbGF2pn4aHei9eYe4dMZ/XjiwQG9KIlkAEc1P/PEjXdQAl
         vrZtgmBokQIbKuinmrHuw1l/blqSZ21FZvUAIgy57+4phsXU4UdunMk4NiUxSL1HcEIg
         kM4UDLrgMp2fWJnhx18qRwg6bkic7QJbX44vCt8nmUJAARGPR+p8eHMwjvOXYiGfBjrb
         WbJEiUWK5Dku3OYJF1eXQT0WkDBaO/JpWsDgLJUH4UKmj4+kl54/rs+SqSt/RCx/bSeH
         d8iQWQKiuC636Ps3t6Hzrdcu5lMn4NuxQQqCm7nQ6fAQVTpQM4s793VYKCKWJSFMIEOz
         4wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197100; x=1793801900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ZR9JdhuF78bRej8mJoidoAF0AkalLMRPKfyvzekZdY=;
        b=azmrWKFD6Qh6SkIOBAQabRJc1X09dSjU2wqpqJCrWIGjvqxg05HVJMQWcjdLYU3UK4
         mZadP0j0uJbw+cuv2oX8+NlUIGZZLjdJndUa7551KajDCCEmAXAqiFOHw4SfCrtrnYnA
         nq7qVunxxDBH0bSxj+pMBDENxbK0mkUI54UNYyRoU3YyN92Xn0Co4p3xL0Nev7EX28Vs
         T5Pbo/CZ+nAv5ueN79A4edAmmlGtqfI4zRq//B55/Cva7ujD9tRmiEu+I4pc2+QZ60dk
         xiljXruwhfLuRHp0eFo7YB3AgOdU8Ah/yVwcAVvQj9Fp+7PvOaUh0K4URpXlXD5WD2PA
         vkjA==
X-Forwarded-Encrypted: i=1; AKwUvBy+dSuLlnLZlztAPnIYv0GoHV8wcn77XdLoTZ8zE6Erk2TB4ZXeP2dU/ZrLxFrFnfkC6ssTjME=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkJetRB5XpXAB/yLi7Unf1RVpG10+ljxPw7KFlWFo7pXAe4GzU
	81G3JVnsvJ4r+VgoZca/46gPrmJ6rqrOLRzjIP817hiw2i7rDgvvYKmfXBpBqUSI
X-Gm-Gg: AYBFou2/gLFhwFd5A1dDe1EZ5A1JEVP4/SC3hmrjIrGILBKx1qKZSFA7LZWytTekXJ3
	7p3UK9NKqhRbdMVlRXVHLjBjQw6OGdeVo5V1hxJirJqJ9NiO7yxHyhfKkPLH4QtIG/HR5v8KXFf
	TsoPEL6mhPaPQyqnxL2n26SNxDukF6xQfck9UE+02E/qmcmKCBzfocCvs878TB3/2bu32tT2yC/
	qdKZpE1XrN1/IbzvxDJgGO/tyZs/4SfLbRxFR95Tvq0zJM3fhN+jzUD5gCzVgrKRllNB38QxZzT
	j5s1eOJD+2dua33SKdwdCyheoAVUgwK6kNbN+SqJCD8hylcuAtjjCBDlWX9PQaJZq1xOMAJm4cY
	fLghAeQI/zM5pyT7UFid/7+4s03tOQgPeNpc9rkDGQr/e17YCljiqdGEP06gqAWWVgB5RKRNbo+
	AWBp66+MtRW1NSXpE1vx5x3GworiMJWqdMOOhodduYJXgakemMmr8b/OgENOEPFElPJQ4MtDAIN
	01HkesQ74+lT/n/oiRezFrUQOCIpHetxIHCM4ecC2ArvBQ4tQt7RaxmrD6qLNA/GvDuvArv4Fjl
	UfSlqc5ak+IE/v/qX2jSGtDwOYXDEB8ZJvCbwDD6lZPhS1rvbuzdZLjmf2+5YR4izbNBIHOi0ON
	xDVCOygauDrgKq7g=
X-Received: by 2002:a05:6a00:2302:b0:8a0:72e8:732e with SMTP id d2e1a72fcca58-8a6e6ff2f26mr1844183b3a.29.1793197099245;
        Wed, 28 Oct 2026 07:18:19 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a3d5e302sm1284996b3a.7.2026.10.28.07.18.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:18:18 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "John W. Linville" <linville@tuxdriver.com>,
	Javier Lopez <jlopex@gmail.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mac80211_hwsim: serialize radio removal with frame commands
Date: Wed, 28 Oct 2026 22:17:51 +0800
Message-ID: <20261028141751.6728-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028141751.6728-1-enderaoelyther@gmail.com>
References: <20261028141751.6728-1-enderaoelyther@gmail.com>
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

Destroying a radio while a frame, TX status, or PMSR command is in
progress can make the command access the radio after it has been freed.

The command handlers keep using the result of an RCU rhashtable lookup
after the lookup has finished. Socket release and network namespace
teardown can concurrently remove and free that radio.

Serialize non-dump generic netlink command handlers and asynchronous
removal paths with an hwsim-private mutex. Use the same serialization for
virtio dispatch, which invokes the handlers outside generic netlink.

LLM assistance was used to find the bug and review.

Fixes: e9ed49bf4c2c ("mac80211-hwsim: Add support for HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. A forced
QEMU/KASAN race between HWSIM_CMD_FRAME and socket-close removal changed 13
unique use-after-free reports to 0, with no lockdep splat after the change.
Network-namespace, virtio, TX-status and PMSR paths were not run.
A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 .../wireless/virtual/mac80211_hwsim_main.c    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index fcbc7f4355bd..61d0e2c1d00c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -673,6 +673,7 @@ static const struct nl80211_vendor_cmd_info mac80211_hwsim_vendor_events[] = {
 };
 
 DEFINE_SPINLOCK(hwsim_radio_lock);
+static DEFINE_MUTEX(hwsim_radio_mutex);
 LIST_HEAD(hwsim_radios);
 static struct rhashtable hwsim_radios_rht;
 static int hwsim_radio_idx;
@@ -6310,6 +6311,7 @@ static void mac80211_hwsim_free(void)
 {
 	struct mac80211_hwsim_data *data;
 
+	mutex_lock(&hwsim_radio_mutex);
 	spin_lock_bh(&hwsim_radio_lock);
 	while ((data = list_first_entry_or_null(&hwsim_radios,
 						struct mac80211_hwsim_data,
@@ -6323,6 +6325,7 @@ static void mac80211_hwsim_free(void)
 		spin_lock_bh(&hwsim_radio_lock);
 	}
 	spin_unlock_bh(&hwsim_radio_lock);
+	mutex_unlock(&hwsim_radio_mutex);
 	class_unregister(&hwsim_class);
 }
 
@@ -7153,12 +7156,28 @@ static const struct genl_small_ops hwsim_ops[] = {
 	},
 };
 
+static int hwsim_genl_pre_doit(const struct genl_split_ops *ops,
+			       struct sk_buff *skb, struct genl_info *info)
+{
+	mutex_lock(&hwsim_radio_mutex);
+
+	return 0;
+}
+
+static void hwsim_genl_post_doit(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info)
+{
+	mutex_unlock(&hwsim_radio_mutex);
+}
+
 static struct genl_family hwsim_genl_family __ro_after_init = {
 	.name = "MAC80211_HWSIM",
 	.version = 1,
 	.maxattr = HWSIM_ATTR_MAX,
 	.policy = hwsim_genl_policy,
 	.netnsok = true,
+	.pre_doit = hwsim_genl_pre_doit,
+	.post_doit = hwsim_genl_post_doit,
 	.module = THIS_MODULE,
 	.small_ops = hwsim_ops,
 	.n_small_ops = ARRAY_SIZE(hwsim_ops),
@@ -7172,6 +7191,7 @@ static void remove_user_radios(u32 portid, int netgroup)
 	struct mac80211_hwsim_data *entry, *tmp;
 	LIST_HEAD(list);
 
+	mutex_lock(&hwsim_radio_mutex);
 	spin_lock_bh(&hwsim_radio_lock);
 	list_for_each_entry_safe(entry, tmp, &hwsim_radios, list) {
 		if (entry->destroy_on_close && entry->portid == portid &&
@@ -7189,6 +7209,7 @@ static void remove_user_radios(u32 portid, int netgroup)
 		mac80211_hwsim_del_radio(entry, wiphy_name(entry->hw->wiphy),
 					 NULL);
 	}
+	mutex_unlock(&hwsim_radio_mutex);
 }
 
 static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
@@ -7248,6 +7269,7 @@ static void __net_exit hwsim_exit_net(struct net *net)
 	struct mac80211_hwsim_data *data, *tmp;
 	LIST_HEAD(list);
 
+	mutex_lock(&hwsim_radio_mutex);
 	spin_lock_bh(&hwsim_radio_lock);
 	list_for_each_entry_safe(data, tmp, &hwsim_radios, list) {
 		if (!net_eq(wiphy_net(data->hw->wiphy), net))
@@ -7270,6 +7292,7 @@ static void __net_exit hwsim_exit_net(struct net *net)
 					 wiphy_name(data->hw->wiphy),
 					 NULL);
 	}
+	mutex_unlock(&hwsim_radio_mutex);
 
 	ida_free(&hwsim_netgroup_ida, hwsim_net_get_netgroup(net));
 }
@@ -7364,7 +7387,9 @@ static void hwsim_virtio_rx_work(struct work_struct *work)
 	skb_reset_tail_pointer(skb);
 	len = min(len, skb_end_offset(skb));
 	skb_put(skb, len);
+	mutex_lock(&hwsim_radio_mutex);
 	hwsim_virtio_handle_cmd(skb);
+	mutex_unlock(&hwsim_radio_mutex);
 
 	spin_lock_irqsave(&hwsim_virtio_lock, flags);
 	if (!hwsim_virtio_enabled) {
-- 
2.56.0


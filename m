Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5240A952
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373880; cv=none; b=DNsvz2EeH0AeUpWma2eGJidhV8xH5KbfYLVv2E5+1FOP7UUB/Qze2/qhW6AcnUgc9R8+e5rq1W489D+OgdXvvfxxyeOWxA3/+vo8dZfwqRL4JalNtXzkmGPJ2LftbAnH69ECdL4x1qnGwemlP68s73E+KdCay9SQPgGV2i+cL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373880; c=relaxed/simple;
	bh=hnhgbnBFVXGlRf8QMp2yxUOZygghKd++lPr/wVO57Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmcTcoCDlgJygOxXnAvJvGE/nar7Ch+U7ctfYQ9Y6+a49oRM9ycKYiUTUehKmNTC5wAXk406lzT36Y565mJSzlcX310T2RHX5nBTgawKvA0y4fBbymaa9zULOKjrBSpCZupwM5k9girGutxQB714w9oVzEHDXcEjWvHfSYb2tNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=S4wsdsMG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="S4wsdsMG"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e6c4a867cso110233885a.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786373876; x=1786978676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0rB9Jjig8cN4sfHOy8svv9C8RxGQPDOIghXLCybeaw=;
        b=S4wsdsMGG3xUg3nVZ9caWjQzZe0VFSjo7SEAlanZEcO0b2Npfj2eas/L+WIz/soz9b
         DTmVDQlujclnbubu9GhF7399UIYfOgbrbUxdBG41LBAXVHXALGILfqYA3n7SHmhSzcGg
         rfvZjcLq3I17mGQpvOUDxl72qHAMAsDurfOy9fKiivGtnU48TNHXKLNMjvmLzfC5IKT9
         Zct3ImOecGv3cdZJDjkEfsglNP3bTlBQkwDK2IZp3hYiBA/azzVol+ooRcCp9lR8F1C3
         16zPsQLlHqlpjNxhNJJEFxv8a22OEBRaVP0sW4RX7BOc/qkEZpc2ufM2xU8eqeiYkUgu
         xEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373876; x=1786978676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0rB9Jjig8cN4sfHOy8svv9C8RxGQPDOIghXLCybeaw=;
        b=paTt/gIJSGe6TwbfJMSjh054PHdSTWIPGUoRJEqVJu63N9vgbHWeDeYomS5MWzgx7k
         8NmQrGtnTSYSaGFk1mitcNr6EcuWNtgSRArDaHr8LXyZz1R1rsRQvrnh76ej/qUUCOPd
         VfBZs0JY3AOxbsJqFgx4a5dTTFhjKLuoknPSvLGujvEn7C3U0SGU80rGNInLWwfIeN1W
         KqCz88mO1nDP4dRrE6b9oCvAYKuw2qHxBnyAb8O0IOGGcu7NjVcmlTnHTOcdrP2ifUkz
         pZ2+pvHmDXo389jRD922z7EVkMvD9glrbEXcTaXW13osUkGG1aDEdTD0rW/GO4AroNsu
         nbrw==
X-Forwarded-Encrypted: i=1; AHgh+RopwH4UXUmxL0w9rB1JwqbKVtsMAzSziTk2PJsvyD90lrMlTswVHJCuswm3l3/tTa5txo2T8gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAO2VGPKCxw4JLfLn4dmcgejfr4Sn98ADfIMUIopOTgJqdxBtB
	gpwPq/om0yxKJ5zNlU+VqaRPWAwuNMo4de+9YJZNlfC56gHXNwGI4lxDXcg7ce9SsJQ=
X-Gm-Gg: AR+sD13ivHMtjYcdZJgfHTlObdxPwF+9ESMrOHJu8YRvMrrpA+3CrZUK+hdj7VsTX1D
	3ImEzI4M0E8V4WevoEB2vGalz3Dqp4Yd4U4tqEEPj82DTcnsaba+ad3PLbVTTwaGJDhcmvwIOpn
	FAooZPFeCD9SE36DlnHFHyagbipbUOeS3gkNI7bBM3PKPbsodbQFBuy4f1v339P8keUX35llqqH
	jRVqJLhucRpWqWf39BPFsuBY218b9TYAVysuJsAc99GjcySS0/3RYuB0gMc9ACIB/xw/dSXSuNy
	csYffsMCa3myo9vbOFFlBlLVTwJDaE8XcOAlQbugQrh67sfh2yLFhyDeyrfwB8SHnhEPsR78knL
	rVDSXB6kSEp+ppFtOND745prsSXzcJf83A/IsDV4UcZye4fU/QlCsXDJG/hVJUiNvm/iKmUOk29
	Aq3nCq3LKD4OyNMvAR0cpFOY8DkM3kIct3k+uJ3OLGD1nt1XCSHv3olwJ9TW61DameAw==
X-Received: by 2002:a05:620a:40ca:b0:936:4955:e5ef with SMTP id af79cd13be357-93671eae246mr2247821285a.22.1786373876052;
        Mon, 10 Aug 2026 07:57:56 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9366e2294a0sm809249685a.27.2026.08.10.07.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:57:55 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: Kyle Zeng <kylebot@openai.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v2] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Mon, 10 Aug 2026 14:57:51 +0000
Message-ID: <20260810145754.828936-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

The network and transport header fields in struct sk_buff are 16-bit
offsets from skb->head, and U16_MAX is reserved as the unset transport
header value. batadv_tvlv_call_handler() sets both fields from a received
multicast TVLV without checking whether the TVLV end is representable.

If the end offset exceeds the field's range, skb_set_transport_header()
truncates it so that the transport header precedes the network header.
The negative difference is then returned by skb_network_header_len() as
a large u32. batadv_mcast_forw_packet() consequently accepts an oversized
multicast tracker and accesses memory beyond the skb data.

Add skb_set_transport_header_careful(), an offset-aware counterpart to
skb_reset_transport_header_careful(), which validates the final
head-relative offset before assigning it. Use the new helper in
batadv_tvlv_call_handler() and reject unrepresentable TVLVs before
setting the network header.

Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Cc: stable@vger.kernel.org
Suggested-by: Sven Eckelmann <sven@narfation.org>
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add an offset-aware careful transport-header setter and make batman-adv
  handle its failure, as suggested by Sven Eckelmann.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/all/20260731135222.566367-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 include/linux/skbuff.h | 26 ++++++++++++++++++++++++++
 net/batman-adv/tvlv.c  |  5 ++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..dbeceaf5c3b3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3126,6 +3126,32 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
 	skb->transport_header += offset;
 }
 
+/**
+ * skb_set_transport_header_careful - conditionally set transport header
+ * @skb: buffer to alter
+ * @offset: offset to add to skb->data
+ *
+ * Hardened version of skb_set_transport_header().
+ *
+ * Returns: true if the operation was a success.
+ */
+static inline bool __must_check
+skb_set_transport_header_careful(struct sk_buff *skb, const int offset)
+{
+	long transport_offset = skb->data - skb->head + offset;
+
+	if (unlikely(transport_offset !=
+		     (typeof(skb->transport_header))transport_offset))
+		return false;
+
+	if (unlikely(transport_offset ==
+		     (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = transport_offset;
+	return true;
+}
+
 static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->network_header;
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1c9fb21985f6..c384db16bcac 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -433,8 +433,11 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 			return NET_RX_SUCCESS;
 
 		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
+		if (!skb_set_transport_header_careful(skb,
+						      tvlv_offset + tvlv_value_len))
+			return -EINVAL;
+
 		skb_set_network_header(skb, tvlv_offset);
-		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
 
 		return tvlv_handler->mcast_handler(bat_priv, skb);
 	}
-- 
2.53.0

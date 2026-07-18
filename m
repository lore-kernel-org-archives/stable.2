Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AE33F584
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401355; cv=none; b=uQua1ITEBfQZUNrcp9TkRG6ZQi/99+ct0nbqHkeuMQJzsnDjusJC2aNnG3AqYgKI9HOD649Z4nL+6CGbK111h2LcFfy4HD5rIb67cdGU0E5f/Ez5Qbkp5HTc0L8oyFm7uEFMZQblgvxjfo3nnxFB6qOW3sy6I0kAqezmCngqKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401355; c=relaxed/simple;
	bh=XZdD3zKdSTbuGZxGX0Q/ZUS+GERYGHbGZ7CTTNOTzCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzYm0ZgPa1pID4hf+GT2LS/38Bbn3q1p79WKATpa1t8vr7Rw/6NrsdccIgYYE3ZdhmesH6MnWIuktoCtfuEMaCCHsui2Q+B2LJL3hvSKfXMoH0hzSVkI5szJeuOjey521Iwnf9vglb1anq47RGmSOz6O5r6juGnB/nJSE0I4luc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stykqD7q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stykqD7q"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69e7a5b61e4so1757750a12.2
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784401345; x=1785006145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zu/jYX89xJfIleoyKAvoiz/I4BllDAYOzQIUgGaxN8U=;
        b=stykqD7qikaAVsVUWUDQC1LtUP3sIoo1LS4ezA/Ubadw46rBDX6VGpGvAnmnMxks3J
         XD+SHt5mMgUZoyuj9v1justFKH6gMZpjfqFVF6jeY7krc8O/pe2+1PqF2caOJCD92Ida
         sW3k0h0TpW9jaYT82l/kuy3BogtuVo+x56qW/UYEyaNPsONku0m6oOwpuFy3wekdYp2I
         W47Th6v5eZSKPrK78Cfc7u3ZWSqFzn995I8L98vc5Da9ASL7Bcqb3N9s/w2UGseRCHVP
         qwFUhYFjueKUsSsHNqkPlF55qTK46TIe/F8n9p+LS/Chi/5VA+agyNhSQjxyG17vqf1R
         pR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784401345; x=1785006145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zu/jYX89xJfIleoyKAvoiz/I4BllDAYOzQIUgGaxN8U=;
        b=Eo5XwKTgvxJXkyGc72S2K/dUR4J2BXleSKcQuo8A9s5797QXrYy+p1llN3txv5O/DD
         GLlAfg9HLzuNTRChre/0ck4KUwcRPUh8FET0S0mcxdYRGYrti1HSesd3y5zHXamqM1Dv
         e04f4i6QAQ7WPhrDghepD9LULzDE5PqzGN8xfD8rIP4XKhL3R2JAcqcxs8zm0Y31q9r0
         3iHaBRK/WQuFqszAfbUuIZoO2GxwOjSzTpJplx6Y7ON+KRB8+z/SBvtE3V/qp/TW7u4R
         52jZuXOVAYFw0X1WVKvW1ie6V5er3Q6n/63kRpqe1NNtpWDN+mH5wJ0gF7NziM1Q7IJv
         jbYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMm8sxR+POPhmpy0PIO1RWgYGK3Pwjyyy6LiM/vD8I3ZvkX+V6Oh1hlXNy0hhbKNWT8h/eHzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYPUvr8faMIuPmMLA+hmwqcFaZSM2MYVbYAEqkm8VYoxbH8aN
	RiVXOkJ7tQzAKVwzFwd7ehBtw2scjCcs4k3aU4F3r3mmlXtYgD5hZ4yx
X-Gm-Gg: AfdE7cm2EHtf1i08jSNrrUbt9B++lsjHzRoWDcXAigLTzlhTIO3Kpx2L7To1tMdlae8
	EPmT/xbn29b3RCnXBmMGrjszKUrghBcrCh4Cyof9SpX9NEqzsjdztCuxyKj4y+sSct4RU+Pd1jP
	pgT+Te1ntu23vcS6EdM11WDtDmiZLHUEZBZFdh15fTvUCxvrdl7oW9f5sUykVRgFJBh3OHooq7R
	OEm43wi0X0hbhLoVdlH2d0BVyt5da6BDbX2l0xzz0vigd6umuk/ZGfF7VXFiP+J05xxjOqNCqKb
	/FcuNowiD19oTourTdcbAh4433KC2EFEcXgcrzCXwQaDXLyDC8oAeuo5k6lBbg0/o3t19s09GP7
	DZXHzL+BHk+TpymvkkNSE7twQ5r7pP77L0NFyaDzMG6+5X5j7naaEezC5KqlgrJc+47GjpVXvYK
	dncdGowEm/Fw33pnSQD5JY+x27l+5hr1keZcu2zdMuofb4pyuU5H2f5g8=
X-Received: by 2002:a05:6402:51cb:b0:698:c1d9:8134 with SMTP id 4fb4d7f45d1cf-69e6525c1b7mr3043951a12.9.1784401345439;
        Sat, 18 Jul 2026 12:02:25 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbba0fsm2392534a12.17.2026.07.18.12.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 12:02:24 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 5/5] staging: rtl8723bs: fix skb->len underflow in monitor TX path
Date: Sun, 19 Jul 2026 00:02:12 +0500
Message-ID: <20260718190212.64409-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718185445.63070-1-meatuni001@gmail.com>
References: <20260718185445.63070-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw_cfg80211_monitor_if_xmit_entry() strips a radiotap header with
skb_pull(skb, rtap_len), then immediately dereferences the 802.11
header fields (frame_control, addr1, addr2) without checking that
skb->len is still large enough to contain a struct ieee80211_hdr
(24 bytes).

Further down, it calls:

	skb_pull(skb, dot11_hdr_len + qos_len + snap_len -
			sizeof(src_mac_addr) * 2);

again with no check that skb->len covers this amount first. Plain
skb_pull() does not itself validate the requested length against
skb->len; on a too-short injected frame this makes skb->len
underflow to a huge unsigned value, after which skb->data and the
following memcpy()s operate on a corrupted skb.

This function is reachable by writing a raw frame to a monitor-mode
network device, which does not require elevated privileges beyond
being able to create/use a monitor-mode interface (CAP_NET_RAW).

Add explicit skb->len checks before dereferencing the 802.11 header
and before each skb_pull(), bailing out via the existing "fail"
error path on any mismatch.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 6a97afd89dc7..eac1b6ac4c67 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2034,10 +2034,15 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 	/* Skip the ratio tap header */
 	skb_pull(skb, rtap_len);
 
+	if (unlikely(skb->len < sizeof(struct ieee80211_hdr)))
+		goto fail;
+
 	dot11_hdr = (struct ieee80211_hdr *)skb->data;
 	frame_control = le16_to_cpu(dot11_hdr->frame_control);
 	/* Check if the QoS bit is set */
 	if ((frame_control & IEEE80211_FCTL_FTYPE) == IEEE80211_FTYPE_DATA) {
+		int pull_len;
+
 		/* Check if this ia a Wireless Distribution System (WDS) frame
 		 * which has 4 MAC addresses
 		 */
@@ -2046,13 +2051,19 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		if ((frame_control & 0x0300) == 0x0300)
 			dot11_hdr_len += 6;
 
+		if (unlikely(skb->len < dot11_hdr_len + qos_len))
+			goto fail;
+
 		memcpy(dst_mac_addr, dot11_hdr->addr1, sizeof(dst_mac_addr));
 		memcpy(src_mac_addr, dot11_hdr->addr2, sizeof(src_mac_addr));
 
 		/* Skip the 802.11 header, QoS (if any) and SNAP, but leave spaces for
 		 * two MAC addresses
 		 */
-		skb_pull(skb, dot11_hdr_len + qos_len + snap_len - sizeof(src_mac_addr) * 2);
+		pull_len = dot11_hdr_len + qos_len + snap_len - sizeof(src_mac_addr) * 2;
+		if (unlikely(pull_len < 0 || skb->len < pull_len))
+			goto fail;
+		skb_pull(skb, pull_len);
 		pdata = (unsigned char *)skb->data;
 		memcpy(pdata, dst_mac_addr, sizeof(dst_mac_addr));
 		memcpy(pdata + sizeof(dst_mac_addr), src_mac_addr, sizeof(src_mac_addr));
-- 
2.55.0


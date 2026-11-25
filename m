Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644988;
	b=Mnkkt1qJOc3K5jvJWRVQ7/iDVDzVFTS75vMt1lUPtTBvIid4cygw0k27loIGzi12oV3N
	 fSm4iHnQSSi5UWa8CMe5/eVvOEGM9RpFIC2tAUMRkPJWGXdmRhU1PejA6eq0tHoCJ5a5c
	 Nf2TLeXDpDXF2P/MvaNutMoa/yM19szHW6Og/F0fVHxBcNmumQmBrPA+HZGC7Qhnlj2SS
	 5v1jwGjvTB4lDjbI5C54lzbLeDeMBrEqa6hX+Q64vkSmTXUtVdISLEm9OnNjzV4zEP9c0
	 cSFuKRqXmv4XsrARrt4EIFAGeUeqlkrPsVYLA+sMomo4pqciKV/h+hx6KsJFVYRxsvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=JWm3F65cTvbkSUDXl1Y/GIGqkgZqbiVzOvBBoT7EL0A=;
	b=twObvMSN9xXxf4Y73ad8jq45UAW1lDe054lD4OlEwP+rH8nddktp2d3Ni+pJB3fM3SuY
	 UjXDJ57rHSN7jRRPaQ2kOckSj0QShvmmh1hgqL6/nw/Ptepxt/gpW2DMQO0PSqQRuJFxl
	 MffiCdv9mVw2hikpt46ai5/ddEzd/1AB22QGW7DdhukgpObiHvfgSeoLFDqFSH4Xjl9O5
	 0E7eh0ujQmvxSBDdevlrEIkrcOB66LvjneTTysptQdeCeufG1VU8HPwaVM+jGqVnUi885
	 udBY5fe0731V9NWtuYoVbe10cZm+I8UML2TUtg5eKU+6BaHKU2qzq8frxUfCxMpoyZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AK08crEq;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748B606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E748B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AK08crEq
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b25d977b91so6722910c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795644987; x=1796249787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JWm3F65cTvbkSUDXl1Y/GIGqkgZqbiVzOvBBoT7EL0A=;
        b=AK08crEqNBBrtaJJXY0S/ZfGdOYuGH/xEsV/EJyUJPtrXxziBKkMv6qstV+qiKlbtp
         8/c4ffKg6rHGFZnzmbFi6B23K0X1cj3zkCIxC1DYSHyVkbeETSpP8BWNLojaJoAlGhnA
         vws39xwMZ/O21nfvfDItAcWYsbNdWlLLNsEAEDTJCmd85luMiOgina4V4YJcxGYL3JpE
         Oka44TNFUQVC4UrNmM+/+qrK+MUAHJWc7/nJ8R64Znaw/FkcVnGCLNwXoTPnCVBDFEm8
         vYyft6PNS/PvM6PjytotrLR7TeWHlrMwRmspYydNnhKGm5GokZgJlvZ2Q79ROE9wBFUR
         dFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644987; x=1796249787;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWm3F65cTvbkSUDXl1Y/GIGqkgZqbiVzOvBBoT7EL0A=;
        b=WJMqTd82/fkTKvPtBCejJX40wycmHBCEx5PPFtz6qLDBHJ0R3iTBZSI7fVlQxI/qUb
         Vj/Rh4oGhnX0rpAw7fZWuvzWmxO9EJzoZy3i48x64g6KCSgD2mW6wWCkHT6doRI3HL4Q
         S1zQ1fJQ9LW0euPQA49r08e8pIKRWo6GcwFObO/tePnBRK2EDuloQJtdEYBoc3JXPe8r
         9UgNGkHc7nk8A8Z6/oYGChUCPpy2ux9g7AJdEe3d62KCNHjKWG1+ENRhX6dmmvb+nWyP
         I4A4KNBzcYJy1mUj5Ufy1AtCLDgwJmbCkKBZoPyQl7qNROjqFNE0mrvZmKFzE/69jFXi
         Fm2w==
X-Forwarded-Encrypted: i=1; AL+hErF0qFuQaatvP+T84cNmC19zjLiLB2jz7wG1EaQyGEXN3kzZyZ2JFSHBA/4vCzLCBdRUeHJUSg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CfVhd9TFi7T4FIXhg3/dWtBUV/IQkjq7Qm/R2HRNGJVEKZXEs
	hOjQ7P5YhIICmVPmlOSJ6X4YbKFw+YSUdhIGnvjYvUj90YBLd8z9AJiWLaxt4yJeYfsSNMQY9QJ
	fww==
X-Received: from dleb17-n1.prod.google.com ([2002:a05:701b:4251:10b0:1a7:f7dd:f258])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a41:b0:1b5:4b48:b9ee
 with SMTP id a92af1059eb24-1b5568c0ec9mr18863247c88.26.1795644986769; Wed, 25
 Nov 2026 14:16:26 -0800 (PST)
Date: Wed, 25 Nov 2026 22:15:36 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125221536.1417085-1-elkin@google.com>
Subject: [PATCH wireless] wifi: mac80211: fix use-after-free in ieee80211_rx_h_data()
From: Elkin Cruz <elkin@google.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In ieee80211_rx_h_data(), tf caches rx->skb->data before calling
pskb_may_pull(). When pskb_may_pull() reallocates rx->skb->head to pull
nonlinear fragments, tf->payload_type, tf->category, and
tf->action_code dereference freed memory.

Ensure pskb_may_pull() succeeds before reading through tf, and derive
tf from rx->skb->data only after pulling.

Fixes: 8a4d32f30d11 ("mac80211: add TDLS channel-switch Rx flow")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 net/mac80211/rx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a2356cd17691..f97d7f4daa79 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3292,12 +3292,11 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 
 	/* directly handle TDLS channel switch requests/responses */
 	if (unlikely(((struct ethhdr *)rx->skb->data)->h_proto ==
-						cpu_to_be16(ETH_P_TDLS))) {
+						cpu_to_be16(ETH_P_TDLS)) &&
+	    pskb_may_pull(rx->skb, offsetof(struct ieee80211_tdls_data, u))) {
 		struct ieee80211_tdls_data *tf = (void *)rx->skb->data;
 
-		if (pskb_may_pull(rx->skb,
-				  offsetof(struct ieee80211_tdls_data, u)) &&
-		    tf->payload_type == WLAN_TDLS_SNAP_RFTYPE &&
+		if (tf->payload_type == WLAN_TDLS_SNAP_RFTYPE &&
 		    tf->category == WLAN_CATEGORY_TDLS &&
 		    (tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_REQUEST ||
 		     tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_RESPONSE)) {
-- 
2.56.1.839.g22a8290db9-goog


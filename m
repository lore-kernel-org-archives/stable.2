Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793592724;
	b=e5dSbbG+Ju0Q+5I1XKlWqUTWWYi6b1wjjYQ9RhtqoraoptzuEs3dcH/TYap6CQY0RE/9
	 cvrrlybJAht2WOR4EMVt7vpWrh2hVcgTlXsnkWcC3NxxFoK5LkWsD5R7yREDtvotoXit4
	 TPkPwNA3Q5kqgDUdXxjZnofVZJctJQykp5cxIX+5wiXri1+SETsKKkRA9eUonpp7pBa/v
	 cQ0wiYlh3CVMG5Me8HvVY9uHGOZhaiPWoOgfFbjzNsSKBZN7J/fQ7FnfTtjUtsBKwwiiv
	 x0fRJ8JdGF+AvET4eZhI0E44fvYdmvkCHUudZwULkK/8P23dP+f6rr3szLHmCihoybQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793592724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UoVVCs4E0WqMtB/439e3ybc24ctA88xvXydp2Ix8gds=;
	b=cZATvNaAQo3NXMOZQS8Ku/FDDVpqKR3ZDDJHDsvXlWr3vpYBB2CQbVZ7aARZRtqgtb01
	 l00+QCDzbJ6Jn3TE6eOsv+9MORTDoR6a6JhgQlYAR58+EV8h0pAYCb3AhowyHzwkX0nQw
	 fqx99D6huoxiuqjDYF3+JY/7cBCG4BU81k3MgCK/58O5u0qnv5ZAkbCjmjK5unpelsUUn
	 6w0o7lXq8iCp1F5Ca4TD7dZmK2fWBGeiQ9hIBIaBS5kmhcN2C7xGhSmpx083sd+oWj2oR
	 gb+4Ncvlq7BO3MNcFYMeyjBWxwBlZz/yO8JVGS7lPbkEQP1qCBrNV5+fxNXneMzUs4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Tc/9+/Ld";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F119606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 04:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F119606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tc/9+/Ld
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a1947498bso268464eec.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 20:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793592722; x=1794197522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoVVCs4E0WqMtB/439e3ybc24ctA88xvXydp2Ix8gds=;
        b=Tc/9+/LdIC66EeckJPdBLvN9Rg1wU4pEN4l7rnCe3Z/gHKcDFU1y3neN14jG9ql81i
         W5/DMdYmOha3JI3QFuzqYwwl6m7CbFv0EAWX3qkWcen8pt6vZ6jptX3i4rBbZcmiy9xn
         d2HlbnbUSE7tpHxkSiMsGN/e4ulsAbKQe7EaFt+DVKPz60dAFcM+EiHLViGJFINg7S/z
         eW7cDkC2MPdjYjuVj9wngyd4LKVT3xSUN0McuKX/wk85J93UK4ZafZEsLdDTzikiIaOY
         78v/KEOxxmt9wBLgLlKInjZStqKwOXxNdKTDyyapCAwdvvMgLWKG/HJfjkfXk4FLmGLg
         6MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793592722; x=1794197522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoVVCs4E0WqMtB/439e3ybc24ctA88xvXydp2Ix8gds=;
        b=WF7Jw0j7+ExMJdvG5WVQyNfX6Lc9mjnm93BEc7TX2S+BJlsJNbeJC6dEK99PDKlq2n
         oiBI+MXDWXsvzZrp2N0+BUlW61KP2K++F3FbBSMWh4wPOTejYryDlmWH3riTixWi78/i
         A1bx1cK68IXCC5K/38BnYltrtrtK/WTHGO/jr6d4kiWLAfxSjNQ97A1kUrZ4Y3mIYGfG
         gjpowNfWLTHxVWsE+f9PDTjyiHtJgkfY3Q+DBgqJ9UWlD6W59mD10SAf+cU4e8c0JMlP
         3blpHnbe1ZleSE27XEJy1ZXiJ9zgEzBi8fNSkUwKpT+EVj2b9DmAIah6hX5OvPhSnaeL
         hvQg==
X-Forwarded-Encrypted: i=1; AKwUvBzkdxQQEK3g/yI2vMooiWFFvDkgIv472q6dpQ1xEPsAXi3V3P0uOHsW0lx84QaGxklS0Um8Dtg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWqV13N/plmf/FDh4++uXwOOSqZCCxGuDwkBDfUQVhIYlBkmEp
	/kTFVWa27wKLN3eQO6Au1NjrUs0P7ogTNdAfo1R24oGheDyzfWOOWLyJZj4IvmkhmZRmXQ==
X-Gm-Gg: AYBFou01WWBwpfKmylIEWXWUEOS6Lz3CMUR0GAXbsbSTaipgw8x93bhEw2IRKzmWMQ4
	8SBwL8r+e3xKASMxci2WnGQGajdmfj5pn4owmHeOsCK7BPx/k0LefnmtxiAYbDYuax8/JUAL4Gh
	BwiofdXqlAwP+y8Mc4D61IhW3UQzQrfiGaxl9afufz0PszE0rM5eHwgtH6ffACWbEamS0jubBNe
	3HL7cTY1HxWz8QtgiYscLi/JeYr5OwDTk3vOG+553qujZrrsemZDk++iX3wjgn4GmCV1onno88A
	bXZxt5j7sl8ZmEZZVf+W5A23MGkH0YnTWPUcBiFID3+h6tINn/2dgXj0Gzf5os2mh1v+Ms+wqYe
	RuN0zT+1lcEqOLM/tzZYWmzybr2UPXQQgofxElydcdyZXHZKS7GK88pLO0A/VhIkjAofbIZcEEz
	fHSQqqh2XkbdqcqL4vJpYm49hLqU/X1Amjlmu4mY+09EcD4aTnPU/ejUMiv1saCBvBgx2z8BdH2
	9PRHUzulN+RsPyjGlE5Fn6QBnGCTEq3+kj22me7H/eJOSVRYms+V9eOU/6j+jBZLVEDo4ZBoETM
	FuWRbS/xfzUqrpNlyT5rqyMM0yiuRztumlut3J/0/O3VNAKQT1UH5nsJdCVppW0k+g==
X-Received: by 2002:a05:701b:4589:b0:19b:39f4:88c9 with SMTP id a92af1059eb24-1ac5bbb487bmr13511529c88.10.1793592722018;
        Sun, 01 Nov 2026 20:12:02 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:50b9:9b10:1e19:1f0a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a13652csm33171098c88.17.2026.11.01.20.12.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 20:12:01 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: stas.yakovlev@gmail.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: libipw: Do not return NETDEV_TX_BUSY after consuming the skb
Date: Mon,  2 Nov 2026 12:11:55 +0800
Message-ID: <20261102041155.61680-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When the TKIP MSDU encryption is done in software (host_encrypt_msdu,
set by ipw2200), libipw_xmit() copies the frame into a new skb, frees
the original skb and goes on with the new one. If libipw_alloc_txb()
then fails, the function jumps to "failed" and returns NETDEV_TX_BUSY.
The core stack takes NETDEV_TX_BUSY as "skb not consumed" and requeues
the original skb, which has already been freed, so it is used after
free. The new skb is leaked.

Even without the swap, returning NETDEV_TX_BUSY from "failed" is wrong:
every jump there comes after skb_pull() removed the Ethernet header, so
a requeued skb is sent again without it.

Drop the frame on these errors instead: free the skb and return
NETDEV_TX_OK. Do not stop the queue either, since no frame is waiting
for it to be woken.

Fixes: 1264fc0498e1 ("[PATCH] ieee80211: Fix TKIP, repeated fragmentation problem, and payload_size reporting")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch and the changelog were written with the help of an AI coding
    assistant (Claude); I have reviewed them.
    
    Compile-tested only (x86_64 and arm64 allmodconfig, W=1, sparse): I do
    not have ipw2100/ipw2200 hardware, and there is no emulated device.

 drivers/net/wireless/intel/ipw2x00/libipw_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
index 6e16060834b8..d0352c8dc064 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
@@ -509,9 +509,9 @@ netdev_tx_t libipw_xmit(struct sk_buff *skb, struct net_device *dev)
 
       failed:
 	spin_unlock_irqrestore(&ieee->lock, flags);
-	netif_stop_queue(dev);
+	dev_kfree_skb_any(skb);
 	dev->stats.tx_errors++;
-	return NETDEV_TX_BUSY;
+	return NETDEV_TX_OK;
 }
 EXPORT_SYMBOL(libipw_xmit);
 

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
-- 
2.53.0


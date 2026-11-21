Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795278987;
	b=aPLBoww0E3b7rXpZFy68ViN1ZLm0mB3iiMmIuP0avJjJOL/xDdY6I05Bk4Nake7x3HZ7
	 CxMJTh83J6l1wY/yJo6hrWRNBXsKGDeqJbDaHBy/rV8jRz+FoSqncu75bNdMAqv0ksq5h
	 KzQFyjZEp4PNCNtdpimNLTQ0tPYOxCZrEgnEUwp3uOKBaXnfLrY95TQjU/tA2WMnHOpKW
	 /UfypvqF3GUPRe+BzFQzUbUNpp6xwHNgTyW1jRkmua+UFDbMZAR7MfIK7nlF3vX+rDVCR
	 j4/7gSiG8tEFogmv7D96LpLbulvLlM1itLbPUScgXUuGL2ixLHjusGyUScjWquHi2kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795278987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JdxWEIL0M9ex9lHBtx8gNprPKuZ5+30UhfHTwNk0jrM=;
	b=xUtkXIR7kdet4bBIduTLHZYHfnDw1R2FdlN8xdLQkR311GG7F4WbgJRaM/avgm8U/wFS
	 IZs3k9XvdoLaHj79mj2WmFdJtWC6RiSQ6Ot7lT2stakarw8hhyXlsOQRo4npo2dOj465r
	 VITe9qw/TfoPkqvORZANkK4ufGfq3rIKvOC5HTeH6dRwOHVQkoYemnExuvSFyHsh9utoG
	 44AYS8XEPoULnNtWJLAIeCTULVJPz7nMHR3/ektTleBVaD6wA6E6tBlaUSD6SIvdCWe1I
	 +3flt2LziI8cKu36pIJMH2iSg/XjBqGFdTH6vAbIgTn4k7zwwBvkTbrUbEPqxNgUGVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E77nioXE;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6A606A33D
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDB6A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E77nioXE
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso979057a91.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 08:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795278986; x=1795883786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JdxWEIL0M9ex9lHBtx8gNprPKuZ5+30UhfHTwNk0jrM=;
        b=E77nioXEx6DTUNqfNXcdKo0zWowoSzsXLv5vkooVBnbC5TteHUj+9qERJY65168DJQ
         V+Bd4PTUI4E5MJQC53YkSuvqb2BzNwm68zCA1RzD4ISJLxD/JaV/0MrKJOqpDdt6gHQ4
         CPBXPatc0Sg02709BK1LCNdJa9aUi902nGLvs0TXOhNMciVSbPnpBASRG5KX0Yqoldf8
         aYfYvYS0rd+xtDgITDIneWq/Pa4oPH3/lso75yL4UxHWr9WjW/PhW4OAwgitrVPq8CKT
         5cJSjVOK5BJPo6G/kHYFPLd0aZG+PwTLmA2KHN0vYc5lR0Afho31kl8+weh3IytCA+mJ
         xGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795278986; x=1795883786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JdxWEIL0M9ex9lHBtx8gNprPKuZ5+30UhfHTwNk0jrM=;
        b=h6TJHFXQdpLMIQYSa6PCRJGyGmI1izZJhNrvEsolXhIenXkFOPYKm465S7cOu3S+Qp
         1yR8u5YhZ3qwFdCZTuOVDDNcWWhRtxuBGvD6zKZ2izG+gqSH09oZbCJ+ee2lhkM3UQAB
         SeNwW5OjfsjKMP7ytkny37OuEtXOFx/czD9oHz+Sw9JEeGgS6rqhbZ50sDkaeV/e/9P7
         9Z/fGuQBZTvXuboHR+FCOV9KH7OaN0RRP1GMTzoLBXxcg5wsFsAfDvS8SxB4Owaz+r/N
         09m2Q2hRBDN991lcRXxaqp8jchgBmwytzR5lYYqpVbHAoyz9Wl7tO10shaxoongSOXRm
         ugUA==
X-Forwarded-Encrypted: i=1; AL+hErFW3FKf2gknPQo0Nf+MGK6wRcgRF50clB3FkUaJFsWJKthDAwxwgMuz7cAYc8vlwzxUwdvwoTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bmABLXWFZUVY3iAaEU8A56ei1scwlOU/ztMq8bbVITPyjg4kh
	OYYrFfDju1QQHWVMZ4H324BXdna7Ta/xNDr1DnfP87vQn9PVVQIlvsBe
X-Gm-Gg: AZFdTZcHXumFbCfGiZAfYov7A6xGFAlyuIKZdeAXp/gcBt6cC+z1yT53KNwFfA32jXk
	8ywwbe3ibStkT9/KrOtVd1O67agQvYMK2Zbxr2gQufvHiQXuVqkl0Dh1whkN7isDHCjyw0D6pXF
	SZHrlPE4L02HFQERmIQyipvGBXfuD5OQXgr8Yvi2uB9HKZa/ahb9BMO8TrnvWr7+pnThJ89xjNg
	QlRrYK+eEY8Q7zzYIXuYi9WBr35EOH483Nip4lz8EDhiJgXC6bNAwHKb+wj7QR/zQR7Xis6MunC
	dWnH24aJwApBuohHt4cBcWvyU+OwtFdVvMOai31F06iGCQPnKLwN2vMwav4RA0yDV5YscfFi3JY
	GIMnE2Dgr2ZrcW8/f8QS/WgSAIFKE9bk9ffYHFELbdoSvtCN6YbA/2YIGv9mEm7Y+WhYmpNoiWG
	Nx/yhCUgIAK7eYtdb8D+MaFTSKeg1jN3asTZix8tDOLjfANEp0qysVCAcQxGn7aJQfx+CR0BPr2
	1xl91GxtUK9fXalI86deejHskfqtXRqRXhIj+yZRgYSj8nkKPyv/dAFWOTSw1yUQNSQMoaK54E8
	IqzgB3wH5A83iYwtL4Brvh27UZjZNP67TT+ekj2yW7rjRqIm+nGcxYsOd+4OmWZYOh0RqDfia8/
	79+CW
X-Received: by 2002:a17:90b:390c:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3b41c9beafamr5939261a91.66.1795278986142;
        Sat, 21 Nov 2026 08:36:26 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:8549:3fe7:526f:af9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d11753sm12357403a91.5.2026.11.21.08.36.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 08:36:25 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Hemanth Selam <hemanth.selam@gmail.com>,
	Morning Star <alexbestoso@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH rtw-next 1/3] wifi: rtlwifi: rtl8192ce: don't mark unencrypted frames as decrypted
Date: Sun, 22 Nov 2026 00:35:45 +0800
Message-ID: <20261121163547.37019-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121163547.37019-1-enderaoelyther@gmail.com>
References: <20261121163547.37019-1-enderaoelyther@gmail.com>
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

The receive descriptor's SWDEC bit is set when a frame still needs
software decryption. It is also clear for a frame that was never
encrypted. rtl92ce_rx_query_desc() nevertheless sets RX_FLAG_DECRYPTED
for every frame with SWDEC clear except a protected robust management
frame, including unprotected data and management frames.

mac80211 then accepts an unprotected unicast data frame although a
pairwise key is installed, because ieee80211_drop_unencrypted() passes
frames marked as decrypted, and it accepts unprotected deauthentication
and disassociation frames on a connection that uses management frame
protection. A station in radio range can therefore inject plaintext
data into an encrypted connection, or end a protected one, by spoofing
the peer's address.

Set the flag only for a protected frame that is not a robust management
frame, as the rtl8188ee, rtl8192ee, rtl8723ae, rtl8723be and rtl8821ae
drivers do. rtw88 dropped the same assumption in commit 0649ff58a0f6
("rtw88: Don't set RX_FLAG_DECRYPTED if packet has no encryption").

Found by code review. Compile-tested with W=1.

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

834fc28d7880 (7.4-rc1) fixed "managment" in the comment this patch removes;
with the old spelling in the removed lines it applies to 5.10.y through 7.3.y.

AI assistance was used.

 .../wireless/realtek/rtlwifi/rtl8192ce/trx.c    | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
index 99472053ccff..3d11ddf86136 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
@@ -300,20 +300,13 @@ bool rtl92ce_rx_query_desc(struct ieee80211_hw *hw,
 
 	rx_status->flag |= RX_FLAG_MACTIME_START;
 
-	/* hw will set stats->decrypted true, if it finds the
-	 * frame is open data frame or mgmt frame.
-	 * So hw will not decryption robust management frame
-	 * for IEEE80211w but still set status->decrypted
-	 * true, so here we should set it back to undecrypted
-	 * for IEEE80211w frame, and mac80211 sw will help
-	 * to decrypt it
-	 */
+	/* SWDEC is clear for plaintext too; mac80211 decrypts robust mgmt */
 	if (stats->decrypted) {
-		if ((_ieee80211_is_robust_mgmt_frame(hdr)) &&
-		    (ieee80211_has_protected(hdr->frame_control)))
-			rx_status->flag &= ~RX_FLAG_DECRYPTED;
-		else
+		if (ieee80211_has_protected(hdr->frame_control) &&
+		    !_ieee80211_is_robust_mgmt_frame(hdr))
 			rx_status->flag |= RX_FLAG_DECRYPTED;
+		else
+			rx_status->flag &= ~RX_FLAG_DECRYPTED;
 	}
 	/* rate_idx: index of data rate into band's
 	 * supported rates or MCS index if HT rates
-- 
2.56.1


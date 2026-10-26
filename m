Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053936;
	b=uPE9lwvZr3DZ4xvooK+zpodTSfX+wpqdnf9MGGBBriW8noEdl7rblVWecKkrc0f2MazO
	 7goMzE8ibdKttQRmEozaPBNyHOnKMhY0ywUx1rfST+VIRRZnKHMUgHuAIvvdTdrWqE+bF
	 Dbq4fJ7oXJUMHnZzOtIAGcvafw4TFdQ1Vxvf5ijTnbeB51BMTOYXbGMrlWOKas1hEMFfa
	 soVR+6lkryoUOjvIULyUoKIAhdtGpHTri4WqHDMUMFI2Ai/oNsWlQdAajUz/hxBELRBI+
	 vZoiUyjd2NSNbS5/wBNhKbvp60PTrm8/XDUDTY7m8zQqPD3wUrMtPl0SKWZqUVGJpfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pLaJAO5gdQUGb1UHhzJRFMc38wz+LAD8Exy48sOnSII=;
	b=S6h9T35H88ibUdKGqh5h9qhcAcwbgBZAK5lM0DPmNa1JSWZmyJjO4tEIBmDtD9jkib1D
	 bcHGLxMyQb6STCJw8tZGwOiken/xw22tDy+5F93Xv4hJRm1+bG/hE7YMY1lMJRHh2x2Ef
	 xkWCp3xyRmzcqNsVRF+V97H0yI4OP75Z0Qk8UmfJ0Xjmt64auM4Hr2r48HR5eUSK0Hxif
	 tupsCfPXEd8sHigLFaW9wPd91FtCZ9rIJPbcoJkNqU1zUDCTjHaUBxVtjLPZOhtccBLtZ
	 JhhYPwM2Dr6rah0ChMSgSvjR2DwZtlsMLDVeOZg3FKespjOnyuOTM/uZBTmyHcS5KUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pA5y4emS;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550D606A331
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6550D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pA5y4emS
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso18263345e9.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793053935; x=1793658735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLaJAO5gdQUGb1UHhzJRFMc38wz+LAD8Exy48sOnSII=;
        b=pA5y4emSgAGiQ2V3ti8+pUQOQGyGTRv1fwG3tNIJ5m7VfVS6F8nLXRdvMG5ArqA+qk
         42X5+5tHmiqbsAyFzzr0jfs3ZFS8HMf9kkNUgPNqbpQjizqFMYOYlSHmeqxTTqi6NOoT
         Y74My1iK0ewVLZsBPOfMmYmpZn3hiQTkCcrVJ2XkEwnmxpInD9k5oYmV893eMFcyFdch
         f5f+GluMr7/snoEHN0RsIvLKxTMkm0Ses2/GcDVV6r29ebvawOkDZi5FL06uTwQsG8IQ
         vuTWzDJMWyrX3FWU3BZZFtDIlt7vApzPGed2x0ow013a+/y7oKeas8IITmr49vVRGv6r
         0rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793053935; x=1793658735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLaJAO5gdQUGb1UHhzJRFMc38wz+LAD8Exy48sOnSII=;
        b=LHCzLlTbgwp1HJSl5SVza22k52LJQRjsVAo/XRDcPPMq8IG/3A+sdQLzOw15vFKOtf
         5PhmQsLSNwKZeB8iWagedrAH3baPG59/9bzyf04MPiNFRCxpmVhf+W1SJM+2wXjKwbqX
         lMSrcVQO/hv2dsGXjKvdt5/ZYFXcN3jGJvo5x4jKguyNrwpiuO21QnW7O4Bq3LkiRk3g
         4qrX+MjH5i+oBwtIG5il3dVVfkutjiCTvb/5vHiumRHwW07aEWUAyYXrupyR1FZSe/hc
         2VdOseP/ManVF8RFV323UNv/zhXF7WI8Htt4+pn3BhpEGo3p0VFUq3ScVVqJCRSF9rdV
         gUeA==
X-Forwarded-Encrypted: i=1; AKwUvByO9ZNKQdzbkOFbW54SWSHwvunJmu5jjeT0iwX9xNN1SX1RnZ0AWdQN98qrmQLZs4QWqMDlTxU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkGXM+P38+igoS8Zsn7O2LK8wDLlNeNEgztlF8zwNXrbsN8zgo
	V7LjfAJdU+pGpAY8CNtfL5QVbKyKQU08bnEUANNVrZp02toy78AvCtQ=
X-Gm-Gg: AYBFou1EqVnWkwQutUKn0GJnmuhIB9dKcGK9VJOLhl9szqI84Um9rAuUqjyF1J65UHr
	lgZ3PPPZZntgyVypmkByO/8bW84UKfba1mVVgm6Opyd3h+lj8tolFM0NfxxFaOvt3IgR3WK0rb/
	p8b/ulaeQbTpF8PgQqTen1iCHYUXgD+YyiT6i6ndlWZTH/Iwqj9OCQuD219g45C58f8uO1F2VLW
	gh6iydcEO1as0DSGHoKDksdmClRnt+uRhE0eLkfHbyroaFYIfNQmQ5i+VnGfNyfCT+y0zbRvVfa
	6gf9i+kswZynqjT7RUlfaa2BUKcQEkyFIj9ZjzARqzUDC8aiqymHbJpVwrpncEE2sxqLWLzupFA
	gsD+ah/EM7bJetLs/r97JYxQTXIIgwm6Flv8JBwjcJs/L867O4tUuRFR07nF62uFdwwfz1qGA7w
	ewHIPKlXDhv7Cz/lv51cT55VlikRwsbMJlk63lFo395r52sHBT0uJNftQso966VqbchZZYQYZtY
	XhnNZuYXRFDmjHoiHPbEAyk9ki2N4ZmC/8Low==
X-Received: by 2002:a05:600c:4e87:b0:4a1:f7f4:7cf2 with SMTP id 5b1f17b1804b1-4a35acaa046mr152238715e9.17.1793053934795;
        Mon, 26 Oct 2026 15:32:14 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bb112sm241921425e9.8.2026.10.26.15.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:32:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ivo van Doorn <ivdoorn@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v2 wireless 2/3] wifi: rt2x00: replace open-coded IE search with cfg80211_find_ie()
Date: Mon, 26 Oct 2026 22:32:13 +0000
Message-ID: <20261026223213.2091616-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

rt2x00lib_find_ie() open-codes the IE search that cfg80211_find_ie()
already provides.  Replace the hand-rolled function with
cfg80211_find_ie() at the single call site.

Fixes: 1c0bcf89d85cc ("rt2x00: Add autowake support for USB hardware")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    | 30 +++++--------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 4d94b7062f440..921383a630bf2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -557,26 +557,6 @@ void rt2x00lib_txdone_noinfo(struct queue_entry *entry, u32 status)
 }
 EXPORT_SYMBOL_GPL(rt2x00lib_txdone_noinfo);
 
-static u8 *rt2x00lib_find_ie(u8 *data, unsigned int len, u8 ie)
-{
-	struct ieee80211_mgmt *mgmt = (void *)data;
-	u8 *pos, *end;
-
-	pos = (u8 *)mgmt->u.beacon.variable;
-	end = data + len;
-	while (pos < end) {
-		if (pos + 2 + pos[1] > end)
-			return NULL;
-
-		if (pos[0] == ie)
-			return pos;
-
-		pos += 2 + pos[1];
-	}
-
-	return NULL;
-}
-
 static void rt2x00lib_sleep(struct work_struct *work)
 {
 	struct rt2x00_dev *rt2x00dev =
@@ -642,9 +622,10 @@ static void rt2x00lib_rxdone_check_ps(struct rt2x00_dev *rt2x00dev,
 				      struct sk_buff *skb,
 				      struct rxdone_entry_desc *rxdesc)
 {
-	struct ieee80211_hdr *hdr = (void *) skb->data;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_tim_ie *tim_ie;
-	u8 *tim;
+	const u8 *tim;
 	u8 tim_len;
 	bool cam;
 
@@ -666,7 +647,10 @@ static void rt2x00lib_rxdone_check_ps(struct rt2x00_dev *rt2x00dev,
 
 	rt2x00dev->last_beacon = jiffies;
 
-	tim = rt2x00lib_find_ie(skb->data, skb->len - FCS_LEN, WLAN_EID_TIM);
+	tim = cfg80211_find_ie(WLAN_EID_TIM, mgmt->u.beacon.variable,
+			       (skb->len - FCS_LEN) -
+			       offsetof(struct ieee80211_mgmt,
+					u.beacon.variable));
 	if (!tim)
 		return;
 
-- 
2.47.3


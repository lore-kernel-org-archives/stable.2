Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053927;
	b=MINZlMIdWdneq4wia5Ha0zHBmzAWUq8/zbAWyVsU2SIsod1F1CkrgNoqab6bsKyWfaFu
	 gPo9GX10UERMMeCZHdtWFvYSA/TTosLY7SeVEGGSXaMsu0IFIhbuU5zPzXpwyTmsdd5Ex
	 LNOzU2lnktm9q9lx+haZes1lS5Bc2oz7GfrOUZAcpwAZ8eiMPA98wWWPf+XIHsgoJhET5
	 jihWZ+bFcLWge5SKkOwEBIuVkWw94uJTQF2DnRnjvCVrrf6L0qYFfBuKhD68/KNnW0MW3
	 CdIGY4G6HX+bKbQ/rSvHS96CeeutGypKKETm97PkzJ3wPUAm9ff5M4htOR7PMs4IHWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jI//he41YR3FxIYVnv4p5xMdPmJqhOBHXdSZfWcDXws=;
	b=4bYFuvr4DSjuPfEIHZRf5HBmHVDZdkU+i8rIFNA95A9fhj5zzkEgddAzRs5agyrTwz21
	 nC+JAfRFydqbBKXiGqvG7DhjkGOMowgi+1cR3/WKL0weurdAPRnF3c+ULN96MB+pPTr/8
	 q2/uME8b3By5rmXfUpjNLpgFjsG5CGHu+d76R1Ul4nduDrPM64Y8Afh8eVKO3oReBBTp1
	 dqE0i9FmkzrTqUOOW9z0UFGDDv+CerTvO9JklzUHDupgN/nIG4naNI8GhQf9aODtr4moW
	 z0KqQuX/uhEXhPFJ1CSjFmWGFOJS4idTMCOalxr0CT4Wd+2kVPV9pMzAO64dVbDcycg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QwaN2o4s;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085B606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9085B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QwaN2o4s
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso27699935e9.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793053926; x=1793658726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jI//he41YR3FxIYVnv4p5xMdPmJqhOBHXdSZfWcDXws=;
        b=QwaN2o4scPcmHdg9Wj2AFz9YXm1aUVPhXirWyQt7UpzE40980ubcjbufSw8xBvwdeF
         vQGoUDL/YvS03zir97lepYKFGKWMLqiD6ozMWIlWtrDQT08L8I2KxBYB4zjdsr3ySB+v
         a8TAZyu8MQoHnoeNQ6KbBzMI87RrJeInZfT6MWaj2IW8/Xz6E4HOPoBTQ2u3bG1o1f/3
         g5srF7ux3CPbVFW3x0W2XQlcG25DAv3bJbwhX3PI02kXp1C/LhfcT+ji3/gR40z83QjF
         M/zupQ7I4CfwqnYyh4p2d1DYTBWAOECTfVeFykuuPHbPgp/StdT7q7NKYOZkWVcwNyVK
         qg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793053926; x=1793658726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jI//he41YR3FxIYVnv4p5xMdPmJqhOBHXdSZfWcDXws=;
        b=vcs2q2aSH7VwfrB2VxKvkjEQ3I54GmFGQw0w2fyWWCpvhnwOXVdeLshPSitpWi9tvh
         klUxJ7q7+Uv+I3O2dWFjqnxD4RrHSS6F1dsBY3L1CKnWkctqlLl/RiTYfjdJeLxISubV
         ve4i1BQBc2AtW5sDLm2GMtEJzLmL1DDKzKvcVSy5z5MO6+wkGQcT1YQ3YtzfBo7Oreko
         jqmPHUa75k79SWuu8cFXO46vtg1cqBxfdGmZ05aiMx+ozM0Yo7E7WoZXmaQgMbUNr7mK
         ohcAZ3axAYnsPtf84WSo2U4wtqrUl3fOI4ptfGHu3hwoZBRaToeruAy674ev+OPVLbQt
         BcrA==
X-Forwarded-Encrypted: i=1; AKwUvBxMY8FIx6E26rZ2b2KK+0mNN7/Ep8cPggTBED3SzVzgmK7303DYPY8Twt+8nxvSCM7Icg8z+Ks=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHG4eVpoM04sIBQ3c6kjk+QP8rReg4E66ObBiQUBLarBZMPYf7
	mHS4ZVdZfjTOY/vAEJ5yupBP00mcKSoYpug5tnXC2ziKK0tHj686m38=
X-Gm-Gg: AYBFou0UiBh1ZBJqlhn/MpMVhOJlAM7aZGQZoEo/oN5TyUe/DVcT0rb7amtcoj457E1
	9kvH6d9WBBAjjpCU+32EXnb7tiy5bYccoKB9H8dTewgqnT8OSFftMidMb0sqGDEggVMXJ94MYya
	K1rvcFkKf44POWr3wGshq9jNzh2Y2nDHxQTGvguaUIlWKPhqao+ha3pNjwejiZa/5N2j7CMG1Ut
	Qy1t0Ildr24RbB1/alK9GQo8bhNQED76OwyJBL/dpQQAZ7PcnjSYPHLc30brIzC86WEXlOl+mSg
	A7LoGUF8saqs4d8xh8L4dixU1KZYMdw5B7Zb8DRtJmYv+hWQLdagoGkG4AVS7kGjjmi9rFnZcpv
	O0gh1oitTONM82XdRD4l3zs+NKdC8etLNDw7WOEX1TAeg0LzloGO2SxlBybeCRpIJdEuxZJ29Sj
	GX+jkyRAi8b9U2y4oHhE0sY6arVlRtN2mt/Ddbig3ntlqTOpr8OLrhfGz4zPtYrXpNHvb8qu+Xl
	Xmjaiydw+/3i+vCHsXqYVYyXoSuGzidGGoyLg==
X-Received: by 2002:a05:600c:4743:b0:4a1:fe26:24f0 with SMTP id 5b1f17b1804b1-4a35aca078cmr145695625e9.20.1793053925890;
        Mon, 26 Oct 2026 15:32:05 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bac37sm238538735e9.6.2026.10.26.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:32:03 -0700 (PDT)
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
Subject: [PATCH v2 wireless 1/3] wifi: carl9170: replace open-coded IE search with cfg80211_find_ie()
Date: Mon, 26 Oct 2026 22:32:02 +0000
Message-ID: <20261026223202.2089824-1-tristan@talencesecurity.com>
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

carl9170_find_ie() open-codes the IE search that cfg80211_find_ie()
already provides.  Replace the hand-rolled function with
cfg80211_find_ie() at the single call site.

Fixes: a84fab3cbfdc4 ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/ath/carl9170/rx.c | 27 ++++++--------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index fbe46a5e4e415..9db6ac9d6d3c0 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -490,25 +490,6 @@ static struct sk_buff *carl9170_rx_copy_data(u8 *buf, int len)
 	return skb;
 }
 
-static u8 *carl9170_find_ie(u8 *data, unsigned int len, u8 ie)
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
-	return NULL;
-}
-
 /*
  * NOTE:
  *
@@ -521,9 +502,10 @@ static u8 *carl9170_find_ie(u8 *data, unsigned int len, u8 ie)
 static void carl9170_ps_beacon(struct ar9170 *ar, void *data, unsigned int len)
 {
 	struct ieee80211_hdr *hdr = data;
+	struct ieee80211_mgmt *mgmt = data;
 	struct ieee80211_tim_ie *tim_ie;
 	struct ath_common *common = &ar->common;
-	u8 *tim;
+	const u8 *tim;
 	u8 tim_len;
 	bool cam;
 
@@ -541,7 +523,10 @@ static void carl9170_ps_beacon(struct ar9170 *ar, void *data, unsigned int len)
 
 	ar->ps.last_beacon = jiffies;
 
-	tim = carl9170_find_ie(data, len - FCS_LEN, WLAN_EID_TIM);
+	tim = cfg80211_find_ie(WLAN_EID_TIM, mgmt->u.beacon.variable,
+			       (len - FCS_LEN) -
+			       offsetof(struct ieee80211_mgmt,
+					u.beacon.variable));
 	if (!tim)
 		return;
 
-- 
2.47.3


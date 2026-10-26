Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013715;
	b=rdh8tQIFu05VBHx6dmt8qcN984C+m5MPWxh7FHz5U21wg0CoslTCmE5CFEY2zfKBxCO8
	 PrOnssKDQQMnVwodH9WVU7Nai3SR6DIzC7dhFD0AQ8NQDw19rNsZekAnsEcYCrddsWq+t
	 Ims5VPUaOcaxK3y8KDac7FHjxq1KhVZyOF4jqjSPWV1zhcKElE1O/UAB253LxIq/S75J3
	 4p44vhZtdj8kk0ttQe/73/Chwg2XghsdxRhD4U3hx8mz8esv02Kt5iQZusK+o0GkfRmCM
	 Q5mDG9QBF31HCkf6XzC6JgLC/PhkPEFvd7Qp24DhSStWGyqH8L2vqdpjuklVf+wrawg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y17TPOs7l11RYBnKZe+rGQQjDI+pkFbxrNsqaPiSHaw=;
	b=VQzMVAbpQOnX9GH7/Rc/pOi936DD45gwh29KiIr8pDymBTnA891DiQkvhxgO8agMxhot
	 UIBU85JD0uqP/NKf5ayrVXIvJBWoBFURGQO7mQwtJeAzAEMKZOZX3XLCrnGqZIY0iu+ER
	 Qw+Zcy9OEyhpt90faMwdOdrTVOSgJEAJFNq4BzwEhP/ioyPYagZ/BU9e8+idVoLCf5OiM
	 Q/MoCr2j/62y9Jy7E4NdCvv8e8VcDR5Qr//P/k0Zoa+i+0PMVYHwbr5xiONw8Y7Ft1HPP
	 KdAlk6UIUhJJfobldgFQw2Nh9Y6NDc7d/SIvkj90bMXrExH4kx9e6EB4z5dO/DU0sMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="F7l/I6Kh";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBC606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93FBC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F7l/I6Kh
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e10a70540so1573187f8f.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013714; x=1793618514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y17TPOs7l11RYBnKZe+rGQQjDI+pkFbxrNsqaPiSHaw=;
        b=F7l/I6KhnzQvMYptnyBQ8lb8caC+lkU0v7RRGSHSH5jwOyFQUPcR+F74U8mKgLfdXj
         +TubIxKOrMcMreXQ2hrJ01mrwrvjg8VHxJsLd27xQnIUFrSqlNZeJKPvn7OoLRvgE6wa
         +bq928rrZA7RQjFugFTJ1dOyhEmkezoOIb/uP6NH8RvYQw6wt3C6o11zsjQdfo/BwyrN
         eUT/DAV59/QmjXvcaSe5wnH1TMk08i40thR5frnzqLcLT3puEpUDiOmekcngZTK9GP0M
         6CGkbrdU/D+NzXcKvmcp9q24uJFpjMUAwYRNPE7CDz0VVMw0yFS2Pk1t5m0LgZP03d4s
         6neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013714; x=1793618514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y17TPOs7l11RYBnKZe+rGQQjDI+pkFbxrNsqaPiSHaw=;
        b=GgSHLEpmCqPhpMYdD3cmi2ppF5tJQOJFayt/e0RPFTQSBDLY30CxFeuZf/uvAG5d5r
         byDrcoyPG1fAMmfU4Mx5jrGu65HxsL+s2467XaJSOnYjECrGovIRG5bP3Iv1sEIYycz3
         OB9FEWf3nVZdHt44koyUv/mBterHOCFf7s/c+leUH9A3teRwHv2u6qim91fg5F9NRFDr
         O9J15j3Yl8vBT3JvfOjLsJejh4pj3pOXzgUSBGVUYUawKeNic8M56acY2Rq7imiR3OXj
         yLUuWp98tXH5yFN86U1AUmSlaALzYxe3RR/QcSlNFM6SoKlF9R3DO7HzEurGQ96CN2OC
         Mpkw==
X-Forwarded-Encrypted: i=1; AKwUvByEBSY2AaFnSaiu/iXuDVNP9PX3JAfdU4K0De5+bnVerSkYW57uZUwJGE/f3VyucJb8Jfc2qw0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1qnfVAd7h5VaCZGGA/mBDNZICFX7hNnyApsCa7hVS1PgymfzV
	dap48hWJ8bTXJgn1g9G6Yn2lXL6PEdg0FvEUIWVTBJtvd6TftcqL13g=
X-Gm-Gg: AYBFou0cSMFyJS7d9Abx7iZ+EbYwA364mTBOb9uuZcPj1W/LrYSeK7Rr2ZXncIhK/0q
	6oA12mGRerqSnKFhUAyPPIte8ScVyfo6EnubzX2AQAX+JxaTaboJvswShH2ldpwny7NaAA10GsP
	blfCeG1jCsKgdVdQWZOa0CnbPeU6pzO4Tv6QE8+ncY59F+Enna64sR01dUUUPymjT5gdwFC4USM
	iYtVe7MaJZSODMxmER68TYEkqccwF/9BjcB0hSD0jK+0wwjdUoR4HwKH3nD0Yi9DaquzxVykXvO
	g4CAGSyJsP7NMYCB5qdfOhp5M8tJ1lORmHpaR3tAVt2Q5nk8hcF05mho6v/elQceEy+uViBCuED
	m2ufzaltnEepeLPznV9EMTJI2nIm9wxQ0nUaOSfz3gGet4xaHjGPKqJWO8ASofBPukeO/bG6xkE
	ZTkVLROF42vP0y0aIKrV+/7MxGmHBGNw1CifF+hh5GZH8P+s/VUs7u34qA2cpWL8pgUsnpT4lCO
	L/l14mKEvCr4TKvxsmQiWKw
X-Received: by 2002:a5d:4ccc:0:b0:48e:bf0:30f with SMTP id ffacd0b85a97d-48e3eb8b7fcmr9371908f8f.34.1793013713782;
        Mon, 26 Oct 2026 04:21:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm15048703f8f.56.2026.10.26.04.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:21:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ivo van Doorn <ivdoorn@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 1/3] wifi: carl9170: fix IE parsing loop bounds check
Date: Mon, 26 Oct 2026 11:21:49 +0000
Message-ID: <20261026112151.2515228-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

carl9170_find_ie() iterates over information elements using a loop
condition of while (pos < end). When only one byte remains
(pos == end - 1), the loop body accesses pos[1] which reads one byte
beyond the validated buffer boundary. The read happens in the bounds
check expression pos + 2 + pos[1] > end before the result of that
check can prevent the access.

Fix by tightening the loop condition to while (pos + 2 <= end),
which ensures that at least the IE id (pos[0]) and length (pos[1])
bytes are within bounds before any access.

Fixes: a84fab3cbfdc4 ("carl9170: 802.11 rx/tx processing and usb backend")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/ath/carl9170/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index fbe46a5e4e415..de3ee0abd5be2 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -497,7 +497,7 @@ static u8 *carl9170_find_ie(u8 *data, unsigned int len, u8 ie)
 
 	pos = (u8 *)mgmt->u.beacon.variable;
 	end = data + len;
-	while (pos < end) {
+	while (pos + 2 <= end) {
 		if (pos + 2 + pos[1] > end)
 			return NULL;
 
-- 
2.47.3


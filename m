Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148068;
	b=qswKJoli3MfXn9mwNHGMKLly+BxVJRTDKz7MeKDNqcgliCc//RfE/YKmKxl9abrqAY6U
	 R/5GOmtEWYWsw5GkbMQrmT4JzSKScbH/udKzELSCgPmRGbEOVSO9DITZVaomflvzhmmhd
	 6gE1ZEuuJhHDBOf7tBm2gZr9CDxqsLAUagSlTa79xyQMd2uU+WLm0WUWLUI4Cw14v/CGb
	 OxWi0IOfJrrbcUC5c/ct52B27LBfSce8c8ACh1cC2sDSyc5N7oFC2qkjJUuUUkNSCNn3/
	 5LFCq0hIuTQ031PJf0qtOX6Uf5p26cQ9bQKzV7PCA+xAOmNHmK737Ysvi9mhY/pzKIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lHv1Jqi7GXywnb/nW9IKsLC85UK00ELbr2eA4avD0lg=;
	b=Wd6r7NsalQ+2XzJgewURg2JXs/cwxjk9YZqEv/VQ3nXCPHXnynItBiIv2XsnDFB2pqIc
	 sH1/5ADQuvD+kwA5/I9FSwyabWVhP1zx2aCcIKk3uBJ1Wa7UvFJ57/WVluLvwGdfX+iQB
	 zOO/LeMI54TrYc4MK6m/GOEONoJg+cjVzi7BZYhFl0O1TKOkLdcANuM1S8JCda/vdJMGI
	 4U4GIltFfgr652CtJ7aj6RFHm60/o7zJoZ7OSXfV72u/goxP3kAdsSnvrUnnbQ5CyJjVL
	 +JC+PSZ8KLtZYTQUSNv56ToG8orQ01ItGuJNmyvhIDGDN1CQAstfgruYz1Uh7VOt7oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vMSfCDAx;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A8606A33D
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 14:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8A8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vMSfCDAx
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37000e7234bso410333eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794148067; x=1794752867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHv1Jqi7GXywnb/nW9IKsLC85UK00ELbr2eA4avD0lg=;
        b=vMSfCDAx7Gttf61BlOYJfcVYE1BYD/36paanqdJe3rmKlEi4ZLd8/dmhbIEy8fawvX
         WPi+isqj5YWOpxnr3Fslgn6U+E5e2Fw5Ya3BBUVycQFz+YU+S3LyeS2zVC+laV4rl7Ln
         fAY1OEc1HoEOfQo9jYGJAEEjZOCKCy8rFLwRT15fXJd2DNMTBZ77w8s9Fnf6rAPxWiCc
         AqGJZgeB3UspKNZw2CeoaKSYjj1hTfpfX21Mfms8osbGBQsgKYzzylTEEGajjihXFbxm
         q7TgSnaELTqObetYL/2Ld2vtzOMoUeJoImj+S/fS+1nizTLQZfGq7I6WSHDFm14qglUt
         8tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794148067; x=1794752867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHv1Jqi7GXywnb/nW9IKsLC85UK00ELbr2eA4avD0lg=;
        b=IdLpo9ktk7UpWmbkesl8C60xXAThGCl8InD/SOMf2tri/c19eCsn/2VFwCzVKtNjt1
         3uUo01hj2+RDBPRVEf175Y6rIiywKgpzLBzjvtILPa3gtRKn1PUDwiQRBqUZyhGaj1Th
         s9J+Ilsb28YCJOR9FmmmwDbU2UKWryovqKKfozGTsQUMNYt3FynemCR7DmjeAQCWpGrt
         NFCWINkE/MTFYxihUiDu+1AGmXaQM1goQRsoES+pO0qdSh1c7pXfOdgEUSo4zjbHkKag
         phyCLKYYPvPd770FyQTyRi3MiwWtGDAFlS6hGeWxvr/aJtdTmH9I+xxCPQqcQhN26UDw
         z7eQ==
X-Forwarded-Encrypted: i=1; AL+hErHV/vE9TbkeI/zVaHPyobkqBDFB0Xpo2/f4/IKqfmDqPhO0cObjo4qbDcRNzNRn6lvhc9W52UE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xh/t/Ytt0VEEZapB9P/kUOs14m9M6+axV4pHvxlkIzqjKTwcj
	AovSk2MHt2yzb02YbI3PHV4hNS1VsWfKp9hnug9Kdf4j4924c2D/bxE4
X-Gm-Gg: AYBFou1s/NVxj5uWFdMXKcZAP8Ie6lJoVLlmkNB0juwA3LYg3z0CcNcO7ST4fxCmoHE
	rYvABITlv6UjiM5vjWTOWH7FajK40+o005dq2AyB0ccMVM3K20d/MGnAnIY+wyjhzCuEoEPGZoI
	h9ituasHphygf8FHfHPTUf+XVYo48SJ/pAWBh/zH/1TX4QOsysmVNVvkTMTPPYiov1PywZ6XgB8
	L61KU4iPzWOOmvhsO/uq8RAP/lx0sK5G1zgJry3y8HKPoF3AmkgJHFPE8VucAiXzOBJa+viU2x+
	sj9b0XTdPmIGyHdEFoKqL66Y+o2Pskn1IvrnohbQ1gncKxA1xr/sEJg/3yDid4OT768w9+jyz4a
	ATImwCYwxwv5GIBr1qF9vkC/aruwF5V3HZCC4sTvu4TrnC0TuhgpeH1PtXr4H2m10+rxwINCn6S
	Gr763Crf9N0UDCFNzYkErFZ5FQ7DGxEDciiVWBL77l/tKEUJic2qzkusvfwnZ5W3dArY45evolD
	SBCtsLhwAfGrVFZ74e512Aw9MsCPKcc8sCzzI9CW2ZkvGI/G5hsxSXHXUjoJV6f8gDHeaulkpu0
	Wc0cWYR2e8uo5+xQL8t+O5SkfLWI+y8K2Mxn8s8=
X-Received: by 2002:a05:7022:1701:b0:1ac:1343:fa54 with SMTP id a92af1059eb24-1b39fec8a94mr2165816c88.14.1794148066707;
        Sun, 08 Nov 2026 06:27:46 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375604109sm7141347c88.10.2026.11.08.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 06:27:46 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com,
	luka.gejak@linux.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] wifi: rtw88: clear RTW_FLAG_RESTARTING on stop and start failure
Date: Sun,  8 Nov 2026 19:57:05 +0530
Message-ID: <20261108142708.489067-2-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108142708.489067-1-skalpesh942@gmail.com>
References: <20261108142708.489067-1-skalpesh942@gmail.com>
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

When mac80211 stops or suspends the device without WoWLAN,
drv_reconfig_complete() is never invoked with
IEEE80211_RECONFIG_TYPE_RESTART. If firmware recovery was in flight
during this transition, RTW_FLAG_RESTARTING remains set permanently,
blocking all subsequent firmware recoveries until the module is reloaded.

Similarly, if rtw_core_start() fails during drv_start() in a recovery
restart, local->started remains false. When mac80211 cleans up via
cfg80211_shutdown_all_interfaces(), drv_stop() returns early without
calling rtw_ops_stop(), leaving RTW_FLAG_RESTARTING set permanently on
hardware that failed to recover.

Clear RTW_FLAG_RESTARTING in rtw_ops_stop(), as well as in
rtw_ops_start() when rtw_core_start() returns an error, ensuring the
driver always exits the restarting state on error or teardown.

Fixes: 5c831644e1f4 ("rtw88: handle and recover when firmware crash")
Cc: stable@vger.kernel.org
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 5e40cf06a9e..ffd86f08185 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -57,6 +57,8 @@ static int rtw_ops_start(struct ieee80211_hw *hw)
 
 	mutex_lock(&rtwdev->mutex);
 	ret = rtw_core_start(rtwdev);
+	if (ret)
+		clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
 	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
@@ -67,6 +69,7 @@ static void rtw_ops_stop(struct ieee80211_hw *hw, bool suspend)
 	struct rtw_dev *rtwdev = hw->priv;
 
 	mutex_lock(&rtwdev->mutex);
+	clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
 	rtw_core_stop(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
-- 
2.53.0


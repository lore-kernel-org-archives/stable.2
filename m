Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127939;
	b=cRoy3S7/Hyb2GtJWgNixE5R8j70mAddSIMveq0AgmQ96SBTPntUx3sdti3b6TB2c1O/0
	 iusLXExXCQVogTt877JxZCbOXaZ2FxV/VMNEQSA3I5FGXwr6k+IdzZIkU+nYoxh0LMKs9
	 gtmbq7ekATlkJMpBT//8NAqEKgFbYMYeBNm8FpdEJTAA/95pb7TSoYcWyd7A8xvbQ2wCd
	 DGP2nIxDwpsbXKZYQJ/V9CkicgXRMfm6tLy7FagVi7xWUZCgU4beQWcCe57jGZ9tjZMzP
	 mwadnPCoPOgmXtBS7tbJCD2+RagHLtoTMkFS8smiKDxh7oUPwZCK+QdYudZ3SZZVeYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dNhQGc3GPqKfSByEN1B7roZuoogyK4AK7uxo1IzV568=;
	b=vVlL4qCXT84kVWf3GNUW0fzyaJsUULtc1pL8C9utmNNmZUqGQp105mOCeh5M4A8afyvU
	 JYXwPg+TuMZ2TxJyzFjcgpSOb7HY/URdtgmTm0bJ/TpxNGBzHid7Q+oLt0FAMvjxF7ehX
	 FN3mlfjKZiXnxQpmEAzsMbDF54bPJg13OwaTzigAGb4284FXVA/VWYIOe3ng4pe4TL6su
	 NtS28pxi0EgaGi2DbTqwZLzlgKJLe73SMJ2MpCGVCxXH3x1IuTUWGrDP3KSTNRAZVnPoq
	 tXOi5P1zvZMtTe28W9pdyTSnMbYoKxPzEjkXVNSptGAa6CV++bxacyn9dFVN9ZQW7aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6nUdRJC;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B357606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B357606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6nUdRJC
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so751461eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 00:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794127938; x=1794732738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dNhQGc3GPqKfSByEN1B7roZuoogyK4AK7uxo1IzV568=;
        b=t6nUdRJCrrmLJvKtxAzPiaebfS1X9UZEi1vO0XMOtoqyCud0B7PYNRU2rBVcCg7zFZ
         znGnhe7xhGV4o8PnHPYf+qugcDCI4ouyrbXSU8EeV2spPcoW5mmNVXOGKigOphZSpdik
         014J/cwsGLfAedkuea2Rwx0O1mBcXS5PXX28bn580YJCqWfKx2T1lUq/V3GF+knhGrwZ
         AenQ4R+WwWZ6CvzNoinqk3/rsV0kIgFE/MnhrRmuDrQhzOnq1e8lAJg5A4fgoCyDI+Hk
         1EA/JRvXqiK0nekj1OYpqRAoes06dZbWjabhtvJJZJoMQijz9eSDN/WyCDSFOUnJPJ0v
         zcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794127938; x=1794732738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNhQGc3GPqKfSByEN1B7roZuoogyK4AK7uxo1IzV568=;
        b=jQwwF1vOg0EBo03CBQEfh0hHRu/QSD3sugvjtvDphaLHbuzwsFmNcSLrNYALl1X/Ei
         SzqN+jie9ruesImLbry7vqnXZAqkpCT4/TX0w410K2RsmZeQ0jgRyP8Y96kOBKYjxhk6
         bws3lg25WpRT6auWYTrFPEFAFnSlGuDTwrI3Kw5m5L24rI3eXmZVyYnCDBG72AIiIrN8
         GXzT2sQ99wXmorxpefil4KS64l7NsOgI++0Ff5E6qgtuZWGG9yqgXbopvdnuDmukt1qG
         RETFPlKabB3E9E1IYZbXqE6A49ZSxb1QoJjnKTDgikcU+GgKmBFnBu90MKFN7a9/x8c2
         d2NA==
X-Forwarded-Encrypted: i=1; AL+hErF5jAJJmRWx7aXwbFKmsqr9wybpVNgu9egMqGSDQnf1ZXUQW2tBVuQETsFAtl0in5bSIYgcsBI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fZnoeN+ihktTKxE5crGwOHpT9wFSyQU9e2PytwjO6GbjIF7Zt
	2sDG29WP1rpobnvM2zcvfpkegScFRhdBEBWTdyqEUuE26yQ7/JbN3d1hRZFyIFCLaKQ=
X-Gm-Gg: AYBFou2CPVKGR6eQgJxFTqBACbOQo7ThO6n3fuPfdDqnKJHKFaC+IrbvapWgGo/WpCt
	dWssc507kZuI6nNL+h6L4ZTsHPSBkn4NIHe5CZ8dmg8zerZ9yLAKkI+aIc/N0kJobZ2Wbfkx97F
	zCgg/ynN9N5+b8HFj0ni+MP31PfqfwrpkRpsSNpvO8vc8i549UWKMy9tLUCm8ptNXSOTpFtooYf
	InUuNq81LvVZi0w6njFZ+qZcMv3b3bPXjZs0IARM7sUJPNZmgvATsSgRPrWvrdv33I0e9puCu2S
	a+zoOrVX47/vZ1IbbpIQ9/T2ncHsiF+7vVzOHxpcpK21Q80ZMxC6L52UDUhAY8fmWfV6+AmfWTP
	sYfnXsfWYcqhIXmq74HHKAAUax+viKlr3+3q5+TSOKttOnKDnEhyVNICc0N0y/yFqdYY7WsBt35
	SlArnXo5mjmaXAl513ErX40HY3OVNfcRd43OWsB4+QNa6l86HsaNOdYJ3yi1IjGJASjpzbgZmYA
	5wVRF0tr8isggQh25ZQKqil4UNrZRmn5jiiWTGS/3WXOrKEQqH6+qPxVqVN71lNxM7DUKCheSSV
	23WrvIPFFPmA9FEuY0+6wIwJLzhVz3Yk8/7uWO2YCRG5i3UlZz6E9BVgepMZ
X-Received: by 2002:a05:693c:41db:10b0:351:4866:255c with SMTP id 5a478bee46e88-3725e82af56mr2079362eec.32.1794127938349;
        Sun, 08 Nov 2026 00:52:18 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm4050694eec.26.2026.11.08.00.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:52:17 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com
Cc: luka.gejak@linux.dev,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] wifi: rtw88: clear RTW_FLAG_RESTARTING in rtw_ops_stop()
Date: Sun,  8 Nov 2026 14:21:24 +0530
Message-ID: <20261108085126.331784-2-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108085126.331784-1-skalpesh942@gmail.com>
References: <20261108085126.331784-1-skalpesh942@gmail.com>
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
IEEE80211_RECONFIG_TYPE_RESTART. If firmware recovery was queued or
running during this transition, RTW_FLAG_RESTARTING remains set
permanently, preventing all subsequent firmware recoveries until the
driver is reloaded.

Clear RTW_FLAG_RESTARTING in rtw_ops_stop() so that the driver always
starts with a clean recovery state when the interface is brought back
up.

Fixes: 5c831644e1f4 ("rtw88: handle and recover when firmware crash")
Cc: stable@vger.kernel.org
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
v3:
 - New patch in v3 addressing the pre-existing RTW_FLAG_RESTARTING gap.

 drivers/net/wireless/realtek/rtw88/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 5e40cf06a9e..7c86da9e939 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -67,6 +67,7 @@ static void rtw_ops_stop(struct ieee80211_hw *hw, bool suspend)
 	struct rtw_dev *rtwdev = hw->priv;
 
 	mutex_lock(&rtwdev->mutex);
+	clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
 	rtw_core_stop(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
-- 
2.53.0


Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4F428472
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194799; cv=none; b=RT8i++ebUm85wfLcrh8u+5izrnzX6uJZanpgHztyU7RO86rswVgLaM0yQ2O3HyU5Cr3lVTC2twd1YsXwylnacb9YO0NFnHMcblNL4rqYSm10LB58LPyI5xZESiime9WOTbziGxebpv5OpA+ddxAf9+8SiI3kL2eu5vFPiKL71uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194799; c=relaxed/simple;
	bh=kaG5qyz7UM2ji9838UuP3ncG1zNanDsJ30nAadWGaGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLTKOMUnypJwsYNBVj7bAkAggnRff0kd2H7QhnYNix5+F1gLcRg45ZsE4HDuFfa2CNetK20p5oGKVuOpZjDES9KM7Ui4XyES3lTCPDCvf7BMpiCEnknaVgLT3U62IaYFsit8fPu4nEAIZq/7GqyG8x0Ouq3psQqlenrn62KguJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT6bqm+x; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT6bqm+x"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-842307472d4so63175b3a.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194798; x=1781799598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozfYwTRjguWwldkipZcumrs2T+DMse6/l34PtGviF+8=;
        b=DT6bqm+xpm1DQ1SoXwSy4yFQ9QbVt1pKWrNGgUShln/5TWgWFaXgznC7Kys9BYoe57
         Xznbo1EHH15pPbIyVCobDzOm1E036J2+xR07gBJNUomR1nifX2FQLqc+dfUwvJGwimwV
         pAUVghNVPSiWvpZ2j+wvcC6jfaW756FtwNzoD26Rq49qdniKcgDljOCUEyEMTJA+k6zu
         r+77wEKnMcWgdpUPS2q61A4OPMHPy+Q3Cqu/DayycWcYQQlrmlQrMZHlw271+N9nZ1iX
         fRnSaqnulksSIkCJAlGGWjhSTI91SsUsVnX5PUoAzTZoVRSjt5v0ba9+fR1+gamGUmLf
         ALNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194798; x=1781799598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ozfYwTRjguWwldkipZcumrs2T+DMse6/l34PtGviF+8=;
        b=IHq3nCIMDuu7jIwb8w8VoRURCiI3Zn+di8wWlrtcZjFc2NUthb9GkOYAHHyhg7cvIS
         wV4Cx9u3Q7s4FbqyiIf4clJSgr8z1a/4HBiQXTa9OhjYkhWNMi4ub7OtDHpD3iKcFGZw
         cBeWX+TZvbBWmDmR2xJaTlRtTQuuU+urZDcwpM9X96WQFcjt0DvtQbJG+naVeIoC9EEj
         8+wIj5wyQV7HYeXRfw8EtbkgxO5AiLc+h300v1u7z3C08P3BtvrBMKa56/v6AZM2Z9Tr
         RuZsBPQHg8CpES+extSxL7RRhR1y3EbgzWyLl5ASwBrnvdOyZydP2tCzNoHf4N1Ia+pg
         +iHA==
X-Forwarded-Encrypted: i=1; AFNElJ8UIbZpfN7QPS6Z7arImFp/xvNqcms4TyRN3k/bq37Lq1ielRd1s/eqwL7+4fBEHwyVgZUosYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRsBJBCwmJIKeV0vbuInNS2kNVprvHhySsLacOoHLNbo6Ac80
	yPfUVzCjCdNFlwNU86dvyst8IEy+FWswbmnkrU4qGzmMee27IAVquf+T
X-Gm-Gg: Acq92OHNBZTciM3RviIvFw1t6dyL+vC1Bbvltq8Xtu8U3stSamjcgJIjBZW1aRrxSp8
	uOXjUwnNs7jkKvs5XOatf3Ld6g4HgxkMxnLAhYX6PQRX5UuoqpNsUwr4ljxuWhYQSACW3HIEePA
	dTGf6gakEp1orrcQFbivy8WTG8mLigpZ/vDpNt93kiaTRx2LHLhvJX7hWtGdanfPQG28wKjUqEa
	mp4fSdG09WCKOju8+z2utsAmWEFEkaOp5Hr+RpjJSSJbfkaa8v5nljS7zG9Aw2bzSXjE1Ldp2eY
	OPFAW7DwRjtRgmrzi1rs/u95ImINXGWv31/XFps5UMhpCt7+3y+zbK6w06fXXWPLSOMUy2kJkp7
	HYuhYzbiS7rxtVE5PvSm61LzaqzxRsJ1IxKwDnSN3qKAAElJHryxibDe72tR5h46zcA79DveEYq
	VNcTfmhy0U8qLqShU/4zN17bL1GYFiXadzkQ93SPisBXBtduXU90KKBFH52sIfeek=
X-Received: by 2002:a05:6a20:da12:b0:39b:89e0:2e37 with SMTP id adf61e73a8af0-3b5e31d9e1dmr4203682637.14.1781194797751;
        Thu, 11 Jun 2026 09:19:57 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865881640bsm2871231a12.26.2026.06.11.09.19.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 09:19:57 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Pedersen <thomas@adapt-ip.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: cfg80211: derive S1G beacon TSF from S1G fields
Date: Fri, 12 Jun 2026 00:19:46 +0800
Message-ID: <20260611161943.91069-6-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260611161943.91069-4-enderaoelyther@gmail.com>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
 <20260611161943.91069-4-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cfg80211_inform_bss_frame_data() parses S1G beacons with the extension
frame layout, but still reads the TSF from the regular probe response
layout after the S1G branch. For S1G beacons that reads bytes at the
regular management-frame timestamp offset instead of the S1G timestamp.

Use the 32-bit S1G beacon timestamp and the S1G Beacon Compatibility
element's TSF completion field when informing an S1G BSS. Keep the
regular management-frame timestamp read in the non-S1G branch.

Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/scan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 27a56ee2e8f0b..c90619eeb03b1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3309,14 +3309,15 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 		bssid = ext->u.s1g_beacon.sa;
 		capability = le16_to_cpu(compat->compat_info);
 		beacon_interval = le16_to_cpu(compat->beacon_int);
+		tsf = le32_to_cpu(ext->u.s1g_beacon.timestamp);
+		tsf |= (u64)le32_to_cpu(compat->tsf_completion) << 32;
 	} else {
 		bssid = mgmt->bssid;
 		beacon_interval = le16_to_cpu(mgmt->u.probe_resp.beacon_int);
 		capability = le16_to_cpu(mgmt->u.probe_resp.capab_info);
+		tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
 	}
 
-	tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
-
 	if (ieee80211_is_probe_resp(mgmt->frame_control))
 		ftype = CFG80211_BSS_FTYPE_PRESP;
 	else if (ext)
-- 
2.50.1 (Apple Git-155)


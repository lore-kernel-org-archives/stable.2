Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5523E0C47
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540800; cv=none; b=JyYDh0r83fHM/ZEr3IGclqYw7jMxi670sMUACatI29J2/3/BAYHOCqruK+EBSoowEzOI0vGnb61p7WK5/nuMkNKwz7r0LekyBavoDPfeNFV4nii+A4IbBxy05YR8upYgY9TssXhY5UGLiByHjgIy5Zo9JJJIZt902PKM5oE7pPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540800; c=relaxed/simple;
	bh=w/vwlMcntnTxyo/2UhLb95oSOKKha6FuDCeNrxA7k88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfGdAzGJx8ZhShHs0fnZklBbeyKathWV6U8PsBDoGFe+cK2pGEKSi4/2csd/hPTunZQOYtXi0+vWa6nTwyYK0fO+LrfFsLKxTiuciFO7OVX07I53AxGGzXtpTqKMYoZjeNOxQjBEUYI8SxKpbI0BPBF9ECTHXvYqdTN8+i9pTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz01sERd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz01sERd"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca7c1176317so537591a12.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540799; x=1784145599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXKQxSD6UbvExaibIKrfBf8rLHetRRlZMcfn3lvIQPw=;
        b=gz01sERdS54Zn+LDyZ7MToEH2eMMI5CxivKkPhxHNM5CU6XE7tnY2lKZPhChuCnyLl
         l93UZl72CVGg1aR4JyrdGKpSNRWndfxGHJ+jgrRGYsnya6LRjkNvcfEsWEJUkAeAODfc
         /e8UXRSqMnKVSyVD2+R8ugbBqJvCY3yrVE2M5rEa690Ik2tqdH3yhVUv685vnQyKRkrp
         pKiW/RCZfZLTMEavloYlkFIFjX/hum7WreRS+zEZpAHeU+ei6qAl2TaTa1XDIJ/Yji/G
         SeK7jfYUMObgkLQrA9NGIWtuV00usK4KhR2xAVCZYeY8weLweKQOFNjdqjoF8J2e9gzJ
         wYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540799; x=1784145599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXKQxSD6UbvExaibIKrfBf8rLHetRRlZMcfn3lvIQPw=;
        b=I4H9bmaAq2g7ZtmMUynGlDF68e71Tkhd+kTfAm92JLnfcVRfaCK7c1mjf6LCfyxOZf
         gmsM0u7dpu0MKUuW2cE0tgmw1bfqNA65zuqfR0M94tdCuYjb7hfy5HwC31miW3HDC2cL
         RM9LnBWFKixIbqzBUf+LA7ZXndvw7Nxs/MEwuySKLzxZGEQ0G8HNrnlsxLkbur4rRpsi
         kQsV7xJkdI0SBdRXJ7HxWCDuHCT3At3rm5JjCv+0Xwt7P3cn4FuFu6FBfuf03ZZiY18Q
         ga3agmmbWyLqcCj8SQw/l3EEOq3dcrPy/ienTFOgvoqJ7817PapVl28m4vT8/l+81i8x
         WmDQ==
X-Forwarded-Encrypted: i=1; AHgh+RokOfjlv27zdgKBE4jI+3u8jauUbZrI6hI7skD5AZiFXVD55DBI2x4CiY1aZLlo/VwGrTEkWEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzVuXhaylllZ+cNq3zlEG6iclqOQPC+gWHSqYZ1sWEbB+nPcXt
	tuqIgMofWGtsmPhbY+HKges5W+nj34nPWWww5nMImlr6vLBgTy0foFIE
X-Gm-Gg: AfdE7ck63+K0MFWavSAyYbgWzvFKwwD5T0/lunE9XwUx8rJcUHjytGsJzlkSai0FbAz
	oCqigcLB3sd9SEbnMdKvJhkDAvwITqCwukJp6pYASSoRjjaoWmEzws68bf3Y3LEUWTisiq9LL4W
	DH7MFLMDMDECpBzpH5F5JTdfcv0OR6fOfFZ96JVTVMwxzcemcwcC1iHGoc2/+ZgG1ezpH8VuOmx
	jQul9qytMrWNlnB19W7b2d0O3NwBp5GGjUDjpKVd9Wg+RVgwMnWhyRWwcXq+h/v6uLkJ8xP6vDG
	7RjFi5kmrnkr1hFg4BmZ8eub/lhzhl+KKTZaIWorx8nXzkQw2/e46BAS/+j9fwSbWJpJQRBD7Ov
	rFBK/SSITKLn37g7W16A9K9Oaz9ytVQM0500CyJRmr41ln1/v+NP2W7hA9aYleFXJ3O7sEoBbs5
	iHPLvwX/ftwAunh2I14eotmqqav8SnAUg6wCtKFrDjPrmsTGZUrdn/
X-Received: by 2002:a05:6a21:4902:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3c0bcbcadf5mr4956916637.35.1783540798746;
        Wed, 08 Jul 2026 12:59:58 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.12.59.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 12:59:58 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaewan Kim <jaewan@google.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	John Crispin <john@phrozen.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/8] wifi: cfg80211: guard optional PMSR nominal time
Date: Thu,  9 Jul 2026 03:59:07 +0800
Message-ID: <20260708195911.84365-5-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708195911.84365-1-enderaoelyther@gmail.com>
References: <20260708195911.84365-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmsr_parse_ftm() rejects a request that omits NOMINAL_TIME only for
non-trigger-based PD ranging. It then reads the attribute
unconditionally for every non-trigger-based request:

	out->ftm.nominal_time =
		nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);

For the other non-trigger-based request types NOMINAL_TIME is optional,
so tb[...] can be NULL and nla_get_u32() dereferences a NULL pointer.

Keep the requirement for PD ranging and read the nominal-time value only
when the attribute is present.

Fixes: 8823a9b0e7af ("wifi: cfg80211: add NTB continuous ranging and FTM request type support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/pmsr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 34c3625f7fd5e..d1e2fae5bc0e5 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -263,8 +263,9 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 				       "FTM: nominal time is required for PD NTB ranging");
 			return -EINVAL;
 		}
-		out->ftm.nominal_time =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME])
+			out->ftm.nominal_time =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);
 
 		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS])
 			out->ftm.min_time_between_measurements =
-- 
2.50.1 (Apple Git-155)

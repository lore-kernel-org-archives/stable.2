Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75F3F86F9
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149744; cv=none; b=qr/yVUOtNzgbw183x0oEZmAc9Z5zrfm+PfD5NPj5T93YBqde5suyniNyNuc4U/ut8YBtesDSrgky6QEaR/0fgYqphXgQvTIMTbUf0RJPLr13O7w0C0krowslLTaAP1/ahFGviEpkLgUp/hND49q4CFRkFBou1jJ1NWEaqU/+bpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149744; c=relaxed/simple;
	bh=UDRY1N2PPIKwNokluhbRES57rm0lFb8oYBzjdWwo7gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfIWwP+TEhKZlZWJGwqCsYMKVHe8jhT4+f4SrG5wuTcBwV+8iG9adEs3o1ruNijXfDaISJeDyuRgQ3nRPtwOGj91sqsQHTpi71ULfANHUlcxlBlCL4uY7ne4tkN3+gu+p+jRLkaGNl4gdtjs+5wqOo5O+HTWSRuQYK1fs2A+xnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=gxUfYtQR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="gxUfYtQR"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso1841289a12.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785149740; x=1785754540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s0XKAIuEGEIxxI3CPghYnt+GMKDGWSIvJZSgiwQRsPY=;
        b=gxUfYtQRtNh5b9w12P7V5Ii7cIRjSHaVrdyVQTV7dsAWbP6PUAOlgiNP5lXBHlyCB5
         nC390XiK9V+zddnO4J/aT4/SgiH9kfprBLrZFDVG7ejU1WrtweJHwSinvalLb+XLvx4K
         74uaoWZE9cXomijw/QpNb4oLjDb+gjMHsOUd0VB1VWNNz11VSyrOn1oUMpcv+y3qpvFs
         M18vZ/2ObhaP5kR5z/b+rfSD3ogV0A0Yv7fkyUTHDHTncDlBCa6prAjGwadT7XFKwqa7
         ihRGRC4QKwXFrQy/MEoMSgnQnRD55v3x4eicFaAWERV2LPlfLw6MBLpcm8XGuMmSWgs+
         u7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149740; x=1785754540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0XKAIuEGEIxxI3CPghYnt+GMKDGWSIvJZSgiwQRsPY=;
        b=Ls2wy/CfxJC1jVh+QDIG7XNHkwOmyT7F4uQKzLh3JTtkFoTRpdz5x+PwR+1kEKd7fw
         PTuuktf0XTZD9R6raNkhJQ2YecAFEtEYhCWlcE97X9JPRM93NcZKj7IhWJ9UfX2tGsNs
         /qsGjTNO7o6vU8xf31Wnex6z9Bi70MBjAJouhVTsyrHh03dYss4JzgxnmBEYxUDuTXAf
         iEp7aGULm/jkaWTFZ57ImUYy/EinFD/uhSgNAdAi4lg6EH9VwLzc52spm427BH0TH8BV
         V2ZPwXdOqmRDQYde9ExqdTFJ3bPDsQiONbP56yYvYG8eQC8B//HQBZYDk2FqUvciJVlk
         jAnw==
X-Forwarded-Encrypted: i=1; AHgh+RqiwLKxGeGUOYcQyzeAJSQPn+CFLtbhBd1dgaW58YfELIbZLvqxGqWx5wNGGO9yNwGzDD3Hh1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4NyWlN+ILKj6DklD1PSbjHqsgEWLmlxyUsEsnEPcZWLQ7C+IL
	m6r2dSD2T4cvv2AOVT0VzPgt0G/mIdOamWw8Ei/fCT6B0pNRscqPLQhFbZM3mo+Rm6I=
X-Gm-Gg: AR+sD12PSkFeIg21DgwmRSX6HJq92+R/7+PgXH5erH1H+z3gBtMLX/nOiHLDYEEsB0v
	n3j00g5BC304zGyVinHGix6znQ1k6ljXWUiYiRFkmjCDgejojGa5pYAQJCkH3Ej5jNMTAyYoMy2
	IirLHPuaN0tBfGd+gY7aUAwV0jj6pWFb76P/dUgjkFSGsXnEvtLsHnASeTZRWiJv3Au9JKbnOYG
	k44PWGxjHhJ+LLgeG0sKhNtK2PGjjumZaPHozB0Q74zqZVp98DpXaPzLOTtKU+szx+jIqlml0Dx
	CzBEzPa17uyGMaMDXdhmZ5gkl8OObYdxmdV/FAYc4MfBRaXrRE1jw9J3lDknLfHoclQbZlBj1DP
	aSK1X2BAAb/ytS9qJcg9wsVjPBjFFV7qz7Y9QkoUV2fHX6Kii0Xiq3KQ5EZxfyf3ojxKXj5csV4
	yXIGqUiQ1mneFTVCviST+8NKX6YQ5792Oy9qA3f2cRqMnbZXeQquHw62Z2Nu2KHc8/Sso3BkHRS
	p1K8/BgC1hckkkq9B68anQVx1taqK42
X-Received: by 2002:a05:6a21:a45:b0:3b2:a809:1000 with SMTP id adf61e73a8af0-3c67dae40f1mr8265553637.3.1785149740172;
        Mon, 27 Jul 2026 03:55:40 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm85269877c88.15.2026.07.27.03.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:55:39 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: jjohnson@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()
Date: Mon, 27 Jul 2026 16:25:31 +0530
Message-ID: <20260727105532.118164-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ath11k_dp_srng_setup(), the memory allocated for
ring->vaddr_unaligned is not freed when ath11k_hal_srng_setup() fails.
Fix that by calling ath11k_dp_srng_cleanup() in that error path.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/ath/ath11k/dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f389b97acbdd..c3a16da1cba7 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -324,6 +324,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 
 	ret = ath11k_hal_srng_setup(ab, type, ring_num, mac_id, &params);
 	if (ret < 0) {
+		ath11k_dp_srng_cleanup(ab, ring);
 		ath11k_warn(ab, "failed to setup srng: %d ring_id %d\n",
 			    ret, ring_num);
 		return ret;
-- 
2.43.0


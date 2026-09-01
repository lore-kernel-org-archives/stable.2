Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B82F0C62
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225556; cv=none; b=Q1G1xH/rrvbRGWj+RYMwM36VaG/jTBfToDRxVsCDDGH+BLBR1xbw8bQLFGPMmVCxaj6A4C4DAj2FdES2DTZgj+fI3h+HZJKWEZM7MneZFPFKSzTOQlef5ndmkQpIsytaUQZpYIc/7wln/5IImc1Le1WWJF7+Mpo1Wc1nI1/Iw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225556; c=relaxed/simple;
	bh=c8TPBAnpKgejGkee+7aR8v/HjeKxq3ZSI4kzy4iV8UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4jtI00Bzjzds7NL38d62lhQSW4TIM187tUx4Nxv6rURoMw0aZHm91EIYmlacmkzWbtqAO5FVqGnLbaxjm2/7U6SL8yauTNv/qJg+c5CT6zffTahLFVVOWPOEpzesmo8RBzWLVZn+CIMGHpwjC0JY2lffqP38ZFGUbK47mX4CV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kV/cspUe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kV/cspUe"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6d28aa26cso1779325ad.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1788225554; x=1788830354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/YfWiX37BcFMIY5wDz/2vU0NlUYxGlQt3jBtIW0CaU=;
        b=kV/cspUeWzNiQwN4za+sO6hs4RedWJTFH7nDCDQp9UdrHw9x5Yc2c0jub+RgKv5LTA
         dB+lC9VnjX8KQxPTgeMVhwdcu3Sop9EBL3/I7cCuQ8KOH1iIRqjoHr5inUXGVi6Ou3cD
         IWATHB8x7RX726DgOniKeTyOFHbTbA9+MHiuwoW8YaH2CN/NiX3Ked6RPjp+KYM2QCWK
         g6MZEQDDIZx+57/whniOcwMMF065rrDibLxt319utjfZ/vGIggmJloCFeIhPcRXoWrxY
         vrmlpAJT4CpY6GYSZ5i39hIwW/iNl4+ZMBnxATjoLR1GZ2KLjEBsAmtIWuTDcAUgAbS+
         DGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788225554; x=1788830354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/YfWiX37BcFMIY5wDz/2vU0NlUYxGlQt3jBtIW0CaU=;
        b=k90Qd3Y0UqXE0I4vv7lrvpcFEk9WuNMJUVDmsocLMTuA6dMTnCRDCo3gYCqt/lBkaO
         sKAFd6Tzri1GezGGGc4xIkxyXskLGn5mps9QndhSCIzcca3RW+ZqK5jzixt2dV9cmoiu
         564JMhs5oSxLR9K1Z/RXblzGNuXaG2juuozUQE4ghqu9p1MSSxcza/e42fKwnk4WBKUK
         oK2dJFqudbL1xqdthxFXfGftm2yze4b3PI8ZrlaTqhOj+5vurWvgj4Q6v7YxNaMRcNiT
         BVAmpCWqFe9ivggDXhe9lTsuvmxxB/POalRbDVwCIH8coWGIRvU2QxnFkle9D7BXDtB0
         4JsA==
X-Gm-Message-State: AFuF++n6E84pKtJPhjxGcPPKujiJkb4U5J4nEBYyYEsRo1Zi3LhsANag
	qNSF50AY6Zd6ZqYYIyUbyt4XzAfF8M2JmjIt6yNonePf/eAaSg+ua5ffTQlappT/fACw08mnB/m
	yqhzg
X-Gm-Gg: AYBFou2La4JT7wGCCq4uppPwTr5WETN//7x1IE1c280lXDhbGWW0sjj/eEIUm9Q5gFi
	mKIZkcA9F8uQj68QreAIn+Rkgs7/B6p70od+06jUt4uw0zoIS8redEWhUOAIhB533zfWVP0/GwM
	DCE4wzt0dpSGdXx/jtnLdyYIfAz9LFkjUzgdNVkNa9a4OvpeFCVxWaZ4r+tELK7KhUuILzO3qsN
	IbBA8+tig4+QI4cuAoUD9/8l21B6WyrZ//L2BFG7fTG+Em69Xz1kXsYuuw+Wvfh+LZHacREEakN
	mYpe0md7TVRkKXLuXo0AAd81/+ENl+otmJFQyzr2che3XlyziGIiObmGlY+gEsO1mBFwRevV60J
	r7Qjdkhq98HSOMVelrI32YsWwRyxl34T+vyWd1ScYTVXaeWkBaJaeiEQvCYYZb/j6j1JIULQgeM
	DAKDY+cMbqPQinzqYtGde6UaecgeP1wyuqx9D+rlDY3/hLqhWd/VWELF/b5I8y8dPBmi2zmzLj7
	UcCmnY3LuJ0BHI6UUvuVoWl6xLu+pJqzr8DluBV0cn1Kou87HxJ7Oxa8fei
X-Received: by 2002:a17:902:ccd2:b0:2d8:d4d9:ce3b with SMTP id d9443c01a7336-2d8d4d9cf90mr280179845ad.22.1788225553565;
        Mon, 31 Aug 2026 18:19:13 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:88da:a0f:ac8e:bea4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm36255068eec.24.2026.08.31.18.19.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 18:19:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please consider these upstream CVE fixes for 6.12.y
Date: Mon, 31 Aug 2026 21:19:09 -0400
Message-ID: <20260901011909.58400-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

Thanks for taking care of the earlier requests. I refreshed the 6.12 list
against the current stable queue, and these eight CVE fixes are still missing.
Linux CNA records list v6.12.107 as affected by each. The first five are
already in 6.18.y. The final three are missing there too. All eight are in
7.1.y and newer.

I applied the current 6.12.y queue to v6.12.107, then cherry-picked all eight
without changes. With WERROR enabled, the x86_64 allmodconfig kernel and
modules built without warnings. I also compiled the affected block, bnxt_en,
F2FS, MD, mt76, and ath11k paths on RISC-V with the relevant options and
WERROR enabled. I did not runtime-test these fixes.

Could you please queue all eight commits for 6.12.y, and queue the final three
for 6.18.y as well?

  7c0be4ead1f8f5f8be0803f347de0de81e3b8e1c (CVE-2025-21817)
    block: mark GFP_NOIO around sysfs ->store()
  107b25db61122d8f990987895c2912927b8b6e3f (CVE-2025-22108)
    bnxt_en: Mask the bd_cnt field in the TX BD properly
  3147ee567dd9004a49826ddeaf0a4b12865d4409 (CVE-2025-22127)
    f2fs: fix potential deadloop in prepare_compress_overwrite()
  7e40f64896e8e3dca471e287672db5ace12ea0be (CVE-2025-38205)
    drm/amd/display: Avoid divide by zero by initializing dummy pitch to 1
  13017b427118f4311471ee47df74872372ca8482 (CVE-2025-38621)
    md: make rdev_addable usable for rcu mode
  a16d1ec4dd0cdcf689f324adde6067083bce9099 (CVE-2026-43344)
    perf/x86/intel/uncore: Fix die ID init and look up bugs
  c41075ce8cf05ed8c0e7b7efef000dce548ffc42 (CVE-2026-53102)
    wifi: mt76: Fix memory leak after mt76_connac_mcu_alloc_sta_req()
  ff49eba595df500e4ddccc593088c8a4ab5f2c27 (CVE-2026-53113)
    wifi: ath11k: fix memory leaks in beacon template setup

I used Codex to compare the histories and run the builds. I checked the final
list against vulns.git, the branch history, and stable-queue.

Assisted-by: Codex:GPT-5.6

Thanks,
Artem Dinaburg
Trail of Bits

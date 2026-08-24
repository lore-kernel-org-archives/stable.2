Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A218364EA6
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538608; cv=none; b=V1Ca8UMqBy48QSsBykAAw3S9U/uuA3xJuf1slTIijfwTzlNeB8MUERqu1E0UjSP8vvBl4QRmW3+RTW2BMFpgyXzegz389M40GS6cbmhTH5/eY5kAMiuqzJldTD+6MPOexL4m7IYXtZno58NEpIGWfSpj370LwEyLRT4ghPBKax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538608; c=relaxed/simple;
	bh=12vy6s9MlwtswAS4SxJv3UE92x5+mncClXWRS59yTAI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=n419sKuX3sa/aM8N+QdPlSMzvQPp+EbaOoAuLq5RQHWIuJ7oR3MEZ8vqiTBxH3b3airtcqWZCevh3mYGfUAZME/SEc8uxfQX95kZvXAHaL6yCbU6kBrKsSuiwQ6YL9vMVUeIWjlCqb2IrmhmIpszEkzNPWb6+aHtQJGO/UNC0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=G8N/suy1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="G8N/suy1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbee3777e1cso1720079a12.3
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787538605; x=1788143405; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HQFEsqr9va0lAEqH4YFPYweHZ7yAKCU5qfLyvlgpiig=;
        b=G8N/suy19mTFIlVwEzN0t1uFpOYegvaMS4wAaxpNgHWZD8IZ9qdxGahL9HrZ95q4W8
         WDAT3JBQz4Mmx7Mrkmct58Knn1e//u560jX8jblmzv0AwwBnGMZVU1dq/KE8VvRmBRLJ
         vIjIXOE5YtXl1j0v8lLtmT+Q4vwzy/X35jzEpnSm0Pu2QTF8dlKiohQI1sIc24A24Zem
         7MQErHW3oQC96VqfbUlRky38S2eq3pLTeUTcEZ0Gw2D3q8CDgHMEpxEvBSdWf6ylVkjO
         arbFbtqWUJxQjhKMbnkOaMreTtXUai9ReH+lijCTKS1IUlgE1Fr8vhS6/t/NcsKhY21k
         r20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538605; x=1788143405;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HQFEsqr9va0lAEqH4YFPYweHZ7yAKCU5qfLyvlgpiig=;
        b=Xh8yh6yUDDswoeCH3/VkGGSyXrUB2fJBGg8VdmfL8X/ZR4Qqs1yFDwY6o5nojy2JTT
         k/KVWd1SwlEDaAXz65RxugMcvvLUklg9xLeK83P4KrhQeu02Lsu68xWxBJIq9n/nZCPH
         HkXsFTnBvXGYZa0dpSCGQ79zOApfLvzJJpk1BjR7quPxprpqMagvg0xSQ4tW75cUslZm
         iIh8XMptIRgdjbDewV4gpRbhIq/83wZmWeOI8tZDL1adUAOe2OrpWiib8ujI4a4M32V/
         HzxShs4VSxJClMtBumPRur+bQKFywbu4Vc2Lypo82IZnC8wyPD4MC0uMtNN5laE2qHl9
         OdDw==
X-Gm-Message-State: AFuF++kGn2rPxbEJEiP+Bz9lCX7uquzonE2pc6M6Vz0PVqjhDCzT81VQ
	vncO/VrdRJbR61GqQ/lEpU5Fao9D4lonKqQ3/a+r3V3frNEFQCrfABiOy017ksDWokA=
X-Gm-Gg: AR+sD10jv5pCQF3DlQpPm7BB54adlQ0TEieO/OhRnNN5421U5DQA6OvjMKDGMLjbY7t
	eENRUrKtDZ7RndSJ6aK9ObTAHzLkkd/8RZOULrzFBmvFhxhKe9uvW356uTn28YqkRBzQE+ecQbl
	duKXN2crSJUWsxg9o8UEMLJFOQnrj2L6fBGMBNgmt6BJ2J+9s/5NaH+2PdX2XLBW0pvafcwMT6n
	WY74U4F0k9wYc5/Nm9hmSUcA2Mer/msT76hVxm4EohusK1tOHXpoWERUkS/MacRs8Yfi1jW2H3K
	KvzJJVUfVeB1Ko6ywAD8R+7uVf2lFE51LR6I9xTGN0mUNEzlNAq3Rk/5Zp/ww1EdvP6Pa4ckKMz
	M+r5pTAOGNsmjpJvYylWfv1SzocnmeK9rtYG18nrJaZDb7H+7M3vdGiQoIrG9UVFuZwokJ1q5Uo
	etmZ+D8pYsSKsRs+MCqlt3sAgsdiBbsCGbj+pGw8U/h6p/UaCyX7og
X-Received: by 2002:a05:6a21:330e:b0:3c8:d3a4:7b40 with SMTP id adf61e73a8af0-3cd2fdab1f3mr45593158637.2.1787538605581;
        Sun, 23 Aug 2026 19:30:05 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90cb8e3sm28389554eec.12.2026.08.23.19.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:30:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 05208478041ccec1b348d25e1df5c4013608590e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 24 Aug 2026 02:30:03 -0000
Message-ID: <178753860320.2405.11184726775672319853@b455de3d9de8>



Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/05208478041ccec1b348d25e1df5c4013608590e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 05208478041ccec1b348d25e1df5c4013608590e
origin: maestro
test start time: 2026-08-23 12:29:45.234000+00:00

Builds:	   49 ✅    1 ❌    0 ⚠️
Boots: 	   46 ✅    0 ❌    0 ⚠️
Tests: 	 4219 ✅  572 ❌  805 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a8af82762f33761c005a5e8
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

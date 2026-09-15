Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F43CB569
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437468; cv=none; b=FE3txLXeltrVKJ/bdSVTWfNIVsjb+S0i3iHazXKjRVH45EVH1qff7rYxS/GwG2ntqx4neo8j5CLFthdfn5UK2i+aeCn/hZ+gVL1jdAO6McTjPwgGYBme7acK7yHpcO8Z+cedvmabp4tEdS5hkne/nctF9K/cALVpCwjmeNyq87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437468; c=relaxed/simple;
	bh=cDTEaYFdU4bsYd6oOIV2rW4rMgwTR2VRJE7sbO0BfZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3ZBtux1dDfJF1jIiVNS2ij/VbFhz/7Ed/zSOEnWDfDIkwoLclNbmsVyIigext1SoCbE989aS6RYVBJURt2JFcq86fwVI8UOUqK3MOyoT0jw6XCpvgscNz1o7SVrjiiQbB91gijuMBCtY9ccfmUjDFQwaU20ugdR0mxu8vK0MVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmsFinN7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmsFinN7"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-939b5ded99dso395073585a.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437465; x=1790042265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mjFWFVeGJngDPSHgQVYhBNSO+sPnzoNj0Nr7+08rl1w=;
        b=SmsFinN7lgYaHa2rL7Qmu0UMA5POGGHZ1HA3rRZ+3VetM5yKbPhy1LtzJCKzfyS0eL
         xj7bf6u9UO5DBhELbE/RVrmMdmcko0y7kRRp4hRq58E/FNyHIZzTj1pkvVqrXK8xhXXo
         gDBCA7UqftBFZo1sV5vngHAqfabTh7kvj6VsYfRJDgU1oUd6Dkq5dnyyKuiNAqXj9jWK
         3BwNZwt75HWhrT03asfo4AqWwHdnrhU0fCK6OEFg37zCGw+xkgDtLToz3uE21r2zlU9/
         6FhS84Kc8qMpdoBf1GU5KIMfgM0HCC/Fnr09whH71ASgx+nhqWFmILQ+O9gQ3LO9xCPX
         cU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437465; x=1790042265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjFWFVeGJngDPSHgQVYhBNSO+sPnzoNj0Nr7+08rl1w=;
        b=Rjt6fwDeq6vQPn79rIrlPjGaBzQ+rfPipd190mE2G2IMI5oaWBz5eajqfjGVxiJOOU
         0SlrIM4aDz0epGA+YlguccwAgopvhANYXBiuJc3bXe4U7VhtYpjU9gcxSvVWCfI61YB8
         0D7Q8627gMQl0+fCOS0MJFozVgL7yi2WDJ9BiycVKcI5XzF1oW+PGJqxfloDICmaVqSI
         kl7GJBhHSO0lV/SDP8xCF6B49h/xAerB+tRdkBzVVoSU3qowU90e3f3F6njnajjDk3Vu
         N155rpHELsAQPRmc/qWb1TiFDsWqVAJlPNZVl02qayAh3lmrEflJzETZOebyPI1FaH+w
         PkjA==
X-Forwarded-Encrypted: i=1; AKwUvByBX+n10We7p3imW4BB7wF9SxX/P1ecp5iOADXON/KX3cetc93/FYbwa4pcB5MjzAVE8RzoGpE=@vger.kernel.org
X-Gm-Message-State: AFuF++n7eZFfmC5JJ5pDRaEIhf3m4axUlfYjxCD/c559sekEmCQp6FYt
	MiS5dBoCgJBGYRe2yqVrZakcfeQXoQEhFKHmtDdmY1+jk+HolaKePRI=
X-Gm-Gg: AYBFou0EgA7PhqR6lXf0VREWQnN1M+lEIAZnVI42LjHVjf5ocwyQ7BgxUSUEHMHWh3y
	jaFkjUHz/q4PaoOvUqwSIxvdgSek6/oSaiFBDToefFJrPa+8wNhG6///0HhzFnkscGOLvnNafQd
	dVkztQHnRvV9f/7lmCM7H4eMUbfCJa/CzkTV/KZkPfTA86HMW3c+T2nzn3YvmNwOJb+OLZCbICS
	5GNS0L5/nMxq/go6yOQ04v3KnrDaLoyCSfApJZFNmsHpaA2tpAVnySvbTbUC3QwaPiLj+NPhKrj
	JTA41pT6Pc5uCf1jW8W7Y3Y0BStQLiZ6LwYjRcMxORswGd7DaqPJtH6SxCBM28p8HAF6QFGnKR7
	F/P2ExnOICWcrD3qLu0mnBUZN+fj+K1RtVkKCODWM+kutgtWVd+8OGMkjxK5GwBlsgrf8QcY3Bc
	yyn97SaMUSFQ86xynUa1pkJYEKKNTDx2O2Fqb+hTRGcKS14+L+VPqTq2Wah0sZ8/WivBu85ted9
	o5drNNV3CtQFvLBGeKvp5E+8ddVOusKpnes7kYTi/i7r0Urjg3hyM141G40MKTXCkGxvjUXeDCy
	OXNYir0dwvSivDULHvS69Xv9bj0qM5OscWj4jtqgEyMBnS8MpLTdVrN5ImeoBI0yZyB5nA==
X-Received: by 2002:a05:620a:260d:b0:939:1483:55c with SMTP id af79cd13be357-93a2977f5admr780633485a.19.1789437465389;
        Mon, 14 Sep 2026 18:57:45 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a00da28absm863266285a.27.2026.09.14.18.57.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:57:44 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: radio-sf16fmr2: unregister v4l2 device on tuner init failure
Date: Mon, 14 Sep 2026 21:57:36 -0400
Message-ID: <20260915015736.85420-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When snd_tea575x_init() fails, fmr2_probe() releases the I/O region
but leaves its v4l2_device registered. Unregister it before returning
to the caller, which frees the containing fmr2 allocation.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: d4ecc83b79cc ("[media] tea575x-tuner: update to latest V4L2 framework requirements")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
diff --git a/drivers/media/radio/radio-sf16fmr2.c b/drivers/media/radio/radio-sf16fmr2.c
--- a/drivers/media/radio/radio-sf16fmr2.c
+++ b/drivers/media/radio/radio-sf16fmr2.c
@@ -241,6 +241,7 @@
 
 	if (snd_tea575x_init(&fmr2->tea, THIS_MODULE)) {
 		printk(KERN_ERR "radio-sf16fmr2: Unable to detect TEA575x tuner\n");
+		v4l2_device_unregister(&fmr2->v4l2_dev);
 		release_region(fmr2->io, 2);
 		return -ENODEV;
 	}

Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E3559C82
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653555; cv=none; b=opwY07QSJzGT7ktMcea/r6XqQyW+DnWnZ6tn0qTMtIK0IsyoPFiUs/OaRMAYiVzt4Q+oXXr5c7JAbGMCdoilr4XlRFpOM9dD3T6BQB5wPgmTHxT7iI3RxSN4lkEs1cfhd/nruihmewMOikQVAI5bpUEtH3gXZ7K5cAWKXyPOW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653555; c=relaxed/simple;
	bh=AHp2gGfy3tNvp1ZGngeI1a+UWm/HcXY4mVZUYtfxr2g=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=rlnomvvBKi5fO6fjoRWd5i6lWW5SGlLZC9K15kyO1DbWZw7xMO4054WqQWkEQBk17yNBzj8SG4F7ZlBiqyUXwal+aFeW1I+xyotzX2ZT/9peEv10jAAz+l8Un09EyiDhjuKl/ot/iN55MHAdS+UfvIK6gv0y4fDx4CE/3OsVOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=NM4W7UDM; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="NM4W7UDM"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso7485005ad.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789653552; x=1790258352; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TJnx5v35ce2gazY/GK+FjpMB9mNJSTUiqG9Z2nwl0bo=;
        b=NM4W7UDMdyw60I8VPY7xT7049WHFLXkjBbJ26w898oUsZ+uNjSDz4TuB5BxdTn3E1N
         ics23NgM+JxkoXWga5nI4CAW/hbdyg+18ZHVU10BXwBCy0bOMp5+bIyNJYTJopzVvvgR
         S2HIHgC+zPrTiJBLKKTA/ejgehhNgTkkHsjNk1kbuGc4WwaDxkzcPFeaMXQDi0tNBbjG
         fYC3UFtSMpHXvQHc1zC6xn8YTyebi1m+cndnO7Y3L8IDRESRsb7WeMAjU0Rj8UTSas3V
         6D6GIQB+tJwIxxU9Z9Zvvblr910rDseC7tYMSv6eVSjbeEHqU5eK/Rzxs3mvUq+F8XlT
         wYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653552; x=1790258352;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJnx5v35ce2gazY/GK+FjpMB9mNJSTUiqG9Z2nwl0bo=;
        b=1wUgtgRtmqkmxyWHOivuAupe8F4UcRWKoxFF1xNVOghpvj3m8XHxyFJ6WPBKdO2ifi
         +mq1PZ1Ae/j9574tgkozsbtOUkFicOmgsJto2mMbR4MvXnW719auJLgpRcIX+600bcoT
         TKJ5YqPfdLjxgXUu0ASQCNeJZstPoQ0HrzN+p82FPSQUmcTCNy38nO83VdKzZTAj4ufM
         KWcwSR4yWVXIZMJHfXZhlDGGdURFdZa88eljWdRTCo5KRmZuuzCQ6fHtAdavlZJuIRBV
         O9GLqnEzx+M/fgx0gMf1fuIfmxAQp6t8BPGsHRkE3fbXJ6o2650Skchb4OYTzBMqcMrl
         cQ8A==
X-Gm-Message-State: AFuF++nP8bnk9bigz5C9jQqXexuNMla21a5v3UayQ6gTnqGdFSDtJQDs
	hJ89d2gROETF0fy4tTgWWgHLBUhiGmhJDCbPqNlf6jdWeEtAV5FcEuHtGVguJuV6WtVUrn2rQtx
	Yysoe
X-Gm-Gg: AYBFou2aqEH3u5Uko7uaFhWyhQYGYnY1s4xRYulXD1E728ccr0sicSoA2SwMff6H8rE
	6TWj7gKDzKBh/8JZnjLO17V1o+GSbDhdvqOJ5mLwxwAFE+QO9gsIAt24I3Sr54ia2PIDLUYfgnC
	WMO1Ly2bz9hOJtbuJCfZnQdKSr31z92j+CbOMlQE8a6yU4IV7EZFi0wwpkPAW3fpAlQRSlZg5JS
	B+ZH6uChTPfVsneK4drxdGRPAhpw8AtAXyIEDg6/2g5CfKhAWEP105fU89PMtTtLosbIbiegD5j
	LZKoNw4CvLcdPL1ajSRUTWIHcHg1QtpSlROiCnXItp7kPzWOuk6uP3NnTYqy4CEa3IMeKamqtWe
	EE0XDMLPIFjvodrQN4590gvpyNYu+V+zem2WmgZRynBJAdSWU9r9Ys2bsUCvwJw6DszqrpdFlmA
	HBtPK1sWnqEZZMui72TfnajhVucQicRMCbtoqaUEizEX6oLcSExDjhAVA6sJKzKqSyrqTGV+K6L
	A==
X-Received: by 2002:a17:903:2444:b0:2d9:56dd:f804 with SMTP id d9443c01a7336-2dd8e402ca1mr144140315ad.13.1789653552042;
        Thu, 17 Sep 2026 06:59:12 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b22b74sm15572845eec.30.2026.09.17.06.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:59:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)call to undeclared
 function
 'is_core_idle'; ISO C99 and later do no...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 13:59:11 -0000
Message-ID: <178965355099.144182.8103073694649553578@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
call to undeclared function 'is_core_idle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in kernel/sched/fair.o (kernel/sched/fair.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/kernel/sched/fair.c:9912:46: error: call to undeclared function 'is_core_idle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 9912 |         env->dst_core_idle = !sched_smt_active() || is_core_idle(env->dst_cpu);
      |                                                     ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d007df42847297ab5302f06cfbd0dc156b93989f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  25d942d40190013b993a85e00b5a84db4cb99b31

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabdbb4fc1857a999dea717

#kernelci issue maestro:d007df42847297ab5302f06cfbd0dc156b93989f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

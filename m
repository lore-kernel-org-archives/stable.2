Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2C145A1F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834618; cv=none; b=kg7GtzvBia46brBZ5Urj2rkPXs3yFnrrVUFwbu9hkNJg2nIhzG/ANeOYudLvp/huD+bF3uhc8diPSaNVP412MdGngzjyExigsCqr75W8MjsqBPVRPO/SOHAyhWxKyDN3qmrhgQf51+N8KEO4g/GrmtS73EEm5AwbaVLbI4gJGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834618; c=relaxed/simple;
	bh=b1gIX7KXg+DsXTZM6ikXYuL53dZ4dhPPjXyxfZSoHwQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Us6RFOFta+JdsepJGd1usNXB6lMYuKKyvP7h+ENTB4DtWDfgYtiuiRT89i8lHDdXfiznb/ZUGCHok1tmKi5eEeqzctC2eatVUaJ9APhhUnFY4Eq43nxecJCWenPI8xcRsXPfa8MVU/ELpW65sZJib9wLryR3vXh3gnr3a7CBSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=bin5hxgv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="bin5hxgv"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso4455466a91.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 19:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788834615; x=1789439415; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oK0cvidTN3EWT84RtkUpwCSrLd9n/dIqM3OXGoYEDEU=;
        b=bin5hxgvXdD7S8/OAuYkNQags1QoysSIwkdhKqBYiTYe54XOV7QP30GbhY0ckJkGgX
         Ma3lRvJ8Akhlhk41CVafPRzfZJTZcUY3Kcx1HOfCu10mHw4V/FXmQMgSvdgEvajOe6mf
         fBIVMZLwTRdA8qp+rm8aDC9BMWJDkSS1cnINClFPNli5ZSwl1IgBT3q2bohxSfdVJ1Au
         R3LuxQEPW9WFnttDiEsv2ldVukGvMWF4rru2/66n3K/qC7hCP5tgJ10+5Lylw0QFjq3g
         ZkMSZB8SHT3w2a60SsmUQ+JctDOQctmSqh7/sqVhREO4HrC5NwUd09Fa5UjZxBx22jlr
         +daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788834615; x=1789439415;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oK0cvidTN3EWT84RtkUpwCSrLd9n/dIqM3OXGoYEDEU=;
        b=Hvp1t+JcdT/c13TOFGMmHYEuJDf9ArKU6WpUfwJKYO2M74wIdQH11AO7y0gXE7wkxa
         P+doSuTGg2tmrGOBN3EtkQmY5R44nFAWCnDQfOVVZjOyJxUyzK/49UlZm+AJ230t+1tp
         dSWB7KcY7wxA2L3UoodAzWSC8ybjPQLlfnz2orNPd06O2gNWsyPWpH1IcJXy21iPJfqp
         ccR/saFGuUAPMAkwl5KFfU1CGCoEmmgnExqADDOBf1LQ1oF3LM29xdwXjdbXFemI4qo7
         0WT6Fbw5adHjmOKGjxDMH27fASlH6kUV/DjTJukmNeSy5lbcgcQ7aM7+iQO0UtaU0+tw
         +15Q==
X-Gm-Message-State: AFuF++nf+QZVHSYrSOYjybrhh2mQOj5M1LOOYE9b+uFuSTdTS+ihqwaL
	EP2gjAKD44E0R2F1EYAZXf6larqv6QFYvSRriJGH9vPEH0gQpcQftNrt5d9TbZF34sW3vuYLYon
	UF+tS
X-Gm-Gg: AYBFou3YuU83oaM0aJzkeggX5Z0newk0d+ys+jZPFgSFwPFiqeaJnrB4qE1UZ3FriSl
	u0afJ+TEE/fqe6y4IcVN/SGst7s62ZPZwWdZx6EQNkEp7ha9uHggB1xWNg3Nd86OQCaVzrZZotL
	7B5eAIkmW6t06yCWmHt+ffqppLcTsEGri2yp8Y8QpoaBpprPR1dNPLubzm0cJk0MrjA7GTZU/RV
	cLNgn37u+0jV6sIs3rrP/46QmKV4w+ygW7tpvE40hYR5yik+PTzQnT2QqYi0OzjaQOyDQ9OGTW4
	aI3eAVRG5T/QcajKp5nWATLKkNFZ3AySnsBr6f2RFe9W+iQ1qSrdHejTWxZOhPT1WMJMmUrjlGd
	1kmf+xK/OFSyB9Ytw+ZTMY8PHw5Z5zF8JOzmbDBnlCiEaK2FcRZDoCHBjmOmN7S4QsCSwci6/s6
	pS7+3OwgSppAAMgl8dttpr/LzT/QKgcVbDernfy+tdkffqu1ZqQlj3
X-Received: by 2002:a17:90b:51c7:b0:398:e73e:5a0c with SMTP id 98e67ed59e1d1-39b2609f34bmr42847373a91.1.1788834614750;
        Mon, 07 Sep 2026 19:30:14 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm50561372eec.15.2026.09.07.19.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 19:30:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 39a867754a8a743765a458e87d3a46ce26990f83
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 08 Sep 2026 02:30:13 -0000
Message-ID: <178883461318.2670.11223229638146043597@41049dfc76e5>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/39a867754a8a743765a458e87d3a46ce26990f83/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 39a867754a8a743765a458e87d3a46ce26990f83
origin: maestro
test start time: 2026-09-07 16:02:00.701000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   89 ✅    0 ❌    0 ⚠️
Tests: 	 8953 ✅  501 ❌  328 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a9ef792e41d7f97d60dda3a
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

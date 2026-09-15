Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F53CD8B5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439406; cv=none; b=m89kEVlzTj2qHAk6dV3JrjD8rWEB+6/t2c0mB3e/3ULvG/oYxjGcathZcXLiLQDa/uOm6mTqSN/3RUMqjv5uKrgUr3fG8du6LOO/HXdPjFGd93C3xwFzHW62Td2G+0/XSCMQF6gDajcZFeym+2lqK/zy3lGsApFR+hPJcPxuMro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439406; c=relaxed/simple;
	bh=6X+bACiyATSLbUWCEgQbTLmQ6ZsVXTDHUiJCc78oZ4s=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=nvPQFVoQR+/CY4yKS+rIw9k31GLV9uw9qLvd/sj33L2olOtswpeTsc3sk5JXPII0HzFWP3GlnEHTgyh4QiozptG9WD+qGmAZJU8KsNQpJLQdkx8OcSGazrnvykWkb43CXp6CYnsda72flrWIbAr+0IhjBbV4TIS7D2WULktq23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=QCLr0CCV; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="QCLr0CCV"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4b29fa803so1969801a12.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 19:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789439405; x=1790044205; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bEdRxjG0Q8t2eGuycgD5I+EfpTNNK5zRPd4T1JrWJ5c=;
        b=QCLr0CCVVn6jYwM+1et5vs0y46zFhj40Ov19TdwzuJRZSl9FeGsKNb4C0e2LSeSQLN
         gn/Zps+y1lQmVbEFu7uUX/CcPnewAdxN6FwKX2TaRidzQdBAKqFIqqbtch11Tk6uzmqH
         VE6VwdHJFYdYkOGodOqqJMY3pAFhX1pcKxnloDh1vxhl48WLfCy+ojYA3/sITAaMiApP
         SmsULvRpgE/EUs3twzgmxoZrDGARWKWrkNuQZzFTKmY4fiZhCu5X6zB4S1066SR6cS4R
         UHUIa/7Y3o9vJHu8xvhpuNPWonn95s5VRF+5dmfEKQvqx0MUtZC0vUr85+oV1rD+/7Hk
         MCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789439405; x=1790044205;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEdRxjG0Q8t2eGuycgD5I+EfpTNNK5zRPd4T1JrWJ5c=;
        b=fQEpyZBA2z5b4Fnl9MNhiCpO9aV+E69TZnNcCRJalIWJvvV8J2ky1/NuOZIwsp3PBE
         EyWs2CUn1WTLRSy/4lPhEfTDpUjurkFJOW8f02Ig5QXMeWFItNpF5gJTdqUslaNYClRW
         yO8Ql8H5pxq7oaiV5oNclJKLI6Mh/XVOaHXaLbdn9wiVnW5JWUTSNnAzzDreNtDhEzhJ
         NOzsJkD6ac3tqTzweo14r19yVD7X7ZWmtO9jTK5pfzuwUOl3A3695yfRab7I4NxeZLgR
         FWNXiy0hBA1MSuxgx04ZdKjYc5t13T7/fDlTlKgDCFph5b6nMRAWC38lztzL8zEhV+YA
         8XUQ==
X-Gm-Message-State: AFuF++kpB4KN1v+ZzZGsbq8tnB6bpa8rV2XNqeInvIwgktQ0PwaJwMOr
	EePXR2mG7/5PUTwoT+rkns07mrWWhFEWgXlSncYBHD/N701h+m0b2skRYMwvh44HOzA=
X-Gm-Gg: AYBFou2UbFCemhRT+DoMWHnAIzPY6BrbvPRz3jkN0xYetR/AIcQaantKKDTxjvPZ5ku
	bwFutePtk1+Go+ys5JGo9TZuWts7CWoLRVZsjBsW0incnIwj7GMTwHohCbN5OzoCqPq/Z+dzei1
	oJasFuT0OD+GOqNqcWb2FP0oeNfeGoZMcPcV2SbghqACw84/oBRqL4hyCSAOcQOwtrzNp9+M6oQ
	sZ00QKnh7uQEj5NX/gxD3vKdciJ9lmTDTflBPOTegXdmxpvtgCgoBdDpNGHxvTP3Nml1Xdw3kRP
	mfxGnPtBh+9STo0DQPzTh79dC+AowSGbLeAnXCloBV9sSgXvIlK5w5RL4u+tBh3wEgqlLhFbxIK
	xe/e5jx/o3580BtPmcMjrwDCfIQRH/3f7bo90tirP1Zg5QQs585V+uyc3KCuxJ4R14EyVw7HN7a
	zwyu7mgIrkF1YAbK1EFILRvZ7RTmzkuBiwmEzh3JALF8/gYtQh7x1XhXtYD8VuIL8=
X-Received: by 2002:a05:6a20:c88f:b0:3d3:aec2:4dc7 with SMTP id adf61e73a8af0-3db4056794cmr11888203637.19.1789439404686;
        Mon, 14 Sep 2026 19:30:04 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf31c1sm30087096eec.1.2026.09.14.19.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:30:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 0248c33e835ecbec3a591f93fdaae53f7b90a4d6
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 15 Sep 2026 02:30:04 -0000
Message-ID: <178943940371.13018.4306988193734866403@ec7b70f3a45c>



Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/0248c33e835ecbec3a591f93fdaae53f7b90a4d6/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 0248c33e835ecbec3a591f93fdaae53f7b90a4d6
origin: maestro
test start time: 2026-09-14 11:40:22.736000+00:00

Builds:	   45 ✅    1 ❌    0 ⚠️
Boots: 	   27 ✅    0 ❌    0 ⚠️
Tests: 	 2325 ✅  217 ❌    1 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6aa7ea3a20239ade90335b15
      history:  > ✅  > ❌  > ✅  > ❌  > ❌  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B062C21ED
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117829; cv=none; b=frnXFxZNY2a2L0vH8EXNSq7MFJfpTLQgjCKwtkCps9csAf2GZRLaM1rcjLPTj03yiOdkeV5LWy3mgRPKhWJNoOosssTqJ0EabXQBgg0qXZ4vf63nnZvLlGNwpcIb7EJitmQRwJkMQb4Mb56w11eAhlKYhvs8JLOLFNnEso3zaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117829; c=relaxed/simple;
	bh=gfULSDAwr4OuKx9GbbZ/IGqEVWpmxAT3h+ho/4ubafQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=iw+RWBUe8ObCcatiFo8O5aJd44jxcoIhr/lyU3wjHdSNBcw8/IFuh1KDxx2KX+HDWnPWKONtJBgK/7ltGEA7kw8V8LPeTkJHf7JcobF1YnivLmkyZCKHzvPx/7kk9UQAdOxJIb0aGU9p3bdv5bLQKTwPpJVszc8kWhgvaVJ7C4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=dGjsq1FV; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="dGjsq1FV"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1338871eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792117827; x=1792722627; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aIV2PNwpi9UgkZHslE5AToFcTJFKSJPiXwaNu2KSbsc=;
        b=dGjsq1FVzVSR0GoHjcxasV8y4mWViv5lJ30LKf0D6miHPnUl5ZcoVbMDzwLhWcU3OF
         K7pIULNcxgkwdM+cigp8sPATz1qpsK2FJpjx95jZrLjCiwxqqp2v+pc0D4UgJYDso3vu
         HQ6v3x0EiVvBGZKb4pw4eoyTezedDJ+uSh1he7NCCfTLaVJAMuX2VvCzJ+YfPZSWRb3b
         JWOm54qUn/JDKWdYN35HROkvMeHJxcb/iOk+2vtwYwJFz26p8c8WwMgEkF4sc3sbZbNz
         5WDPkhYVjljlOGkTaFC79sIBcpbWd7XXze63EdqFVOIR0PTm9QfFRsv/lalUOBisKHs6
         PY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117827; x=1792722627;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIV2PNwpi9UgkZHslE5AToFcTJFKSJPiXwaNu2KSbsc=;
        b=sULT5s/HQpaBveq7A0FTVw6DFBcbeGF7GPC5575dQBCKqpGxbyxTtcPjk5+mdrJ/ae
         jUop+13ywr5MrHKhe3BJo2opUE4Rz+W6KGmEtMyAjPHt5HjCOUbyfHBaz/gxoKkRBWP/
         V15YCrpgh0QOJElcZHP2LFc0XMK4iv1PMgrp5IllW0vsOWlFHhVLw3sDJd8oOG2et3Ui
         SpWAkYLLi7jYaxpv+nagUEIhZcOEnAJVXp9JmrWjEck2MYjUHYSuhMcW2o2A53n+AO3d
         bDJu8vf1EQls3lsremY4Bc0tsrjvO5rw8sP+3qBwlB7nXsLS6Esbb1Y0GJSn5l2hw91g
         ZjQg==
X-Gm-Message-State: AFq9FYKNMeANy9mc500oGgBot9ONz8tSASZ/JE89l4pKTZ185DKpO2G7
	us4hjG+AlygIZsRw5yX7FxMaGgO5mltoHmbo59410x2XTTNnkRwRq3zg0/AqLnum5H6CiN5cNW1
	9coG8
X-Gm-Gg: AYBFou0+1j3z1tRm4nkYRgOu7jw6TVJAvbqRnRmT4xurZepdvgpptsgTql2x2cUnKxt
	PqRlJTDBDzlL/oxQmsj0EfeJVO77W8RW1Pmht/7tBFpGG18mRjNm3ksErdmVTmYQFxM24aMNPcK
	a5oVDC4tINAPXopjr72Hsk5c3jhsTerSUlzSR5Qr2mYQA7bZu3560iLgfZX59oz5it1NNpj4bDC
	zNS990ER4LcPQMtz7L6I2aoOxIp597bOWVBCm0EOt/dvxZTolNvQQlJK5NsGDALYEk6OE2uvMP5
	czz0y00HMiOJJGiwZgzTZuNqZuc2WsV3K2tu2kNJMtSQ4VTa3NK6hlKtKQpdP2m9HktqiQ5fteP
	edEfFfbimU/mZ/mfsKRe2sFzHDg9q/kwAw4Xi6suxBSN2ZTPyozTnmQw+CHmhENBoYOASPErIrh
	n/h6a8JWI8eBOtjDxOhUB4BI26KKmvDhh1G5Louf8Bdr5VNs3F6VtjFZ6o9aj/0w4=
X-Received: by 2002:a05:7301:103:b0:35b:9f06:e383 with SMTP id 5a478bee46e88-35b9f06f66dmr15448939eec.8.1792117826466;
        Thu, 15 Oct 2026 19:30:26 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360819be413sm1973328eec.13.2026.10.15.19.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:30:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 16 Oct 2026 02:30:25 -0000
Message-ID: <179211782546.391248.3376530712435967686@244668f92ec4>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e
origin: maestro
test start time: 2026-10-15 10:06:54.960000+00:00

Builds:	   57 ✅    0 ❌    0 ⚠️
Boots: 	  105 ✅    0 ❌    0 ⚠️
Tests: 	13015 ✅  958 ❌ 1890 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad0ae74a3f195e1aa8821b9
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad0b100a3f195e1aa88344a
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

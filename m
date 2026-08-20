Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D23783B0
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193008; cv=none; b=hmhrevoLUeAXWV1Di97635q1TVqvAUZM9dwj/rf+55dA454iLswBhsLVdb3hyo8UatUldWP92CiUZ69o9ufALuM47ni6XLimn2zqmGfNgTzhZEd8rmxPp8L9Y7JtaOVHxMBDQJ4BbOYsnAMl5BaOppOvmZNd2k1yPCZmbOQOuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193008; c=relaxed/simple;
	bh=CouPIay7PTAN+W7CMnmC4h5Ha+5x4/JX+44+lea3/JE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=evEOISDAatEDA2Jp4ZngYRqeQreFTlcA37NPhM9Q0nQfICPa6NRbUrEbSBxqWgf4q+dd5WHNMdZOHs5MyxhTq3C0jaJMQls3SMz25j9PjpCa6X7R010+1W6MBWf0+8ybV/xv8YoSAIeV3pn9CH4T756UVoooV5PsCgV5zGvIgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=B5R4DlEL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="B5R4DlEL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2409329a91.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787193006; x=1787797806; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=adTUC8eO2u3VsHwxqAnFN96t5P0h/EQPfo7k4QyZiuA=;
        b=B5R4DlELMAy3YEgQgx2BJpJUW+Md9/voBXb1Ro8CRxNCkSUt6vI4M6oCIQ+jrs/qv6
         SWxYG4G2nFi6mdv9zGafylqhbMnmfOSm/fWHSUA8jsezhkkEG90aSYZBrJOaUHUzaw/i
         ZtcsSx5yPRmhZPDzAVe0atc6Sfl3rE2p8FXvC/FOjdWYcwqOusJQ9P1gXT4SKtbGuk1o
         mYBt2n/HcpK6lNNit7vVQ5L5z6qumQ9hzBPcp6uHf1CnZInFvDWv+xAQXF9ICs7RUMq1
         /FhoS3S4/mgUQJ2HaHOaM7EPHzgjMxto4/MxWR6NyGS55Y080f72wve7dJLqnaoIv09h
         tsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787193006; x=1787797806;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adTUC8eO2u3VsHwxqAnFN96t5P0h/EQPfo7k4QyZiuA=;
        b=V7YRd+fyohKATjiIPppoSvI+/O+W6eDAFdKzQ2T0Cxzoc2KqKImJOjpXi9hV+vAWah
         OuNLQre2ZqSwPIJrEG8Iw5q8UVFfsVfeEQuOz6Q7AgjtR0w68fTfVJEFsi2hGAG5emJ0
         0X7q+WDCDxbF5IFqwZrk8Iej7upL0HcfUAz+R1fWuoKY9EISIOCYQx5MBOAO9grnN67/
         vgI+l0+CkwOa7jn7Xh8Edz9poCp2e8RBm4qzPe7KWvwvS6F7aPXuAIe+9yEIyzaX5V5X
         8koeR5sHU7lzB83UR2s62NX3wsC9gbqyR8j4+3oyvSd+2VWPkKZdi6x1uhgNYNalD6Mj
         lZqw==
X-Gm-Message-State: AFuF++kW48GO7vUDmWmwEJTLlJ50iGqLDX2iWTrfQBx6hbH+34cctxLW
	AOjbqTT7rfEQbmMRzVXHV46UD11210mfymLNrzXd00K3qtKi/KO7M2iTRF9o2ezdcvIsG5CXBh3
	8QggX
X-Gm-Gg: AR+sD113deV9PpXnHHI1xnv5KUh5iEBes5mZlXpxyYTOAeniAixOTP3hNBEgB+zoJ0K
	CYjrxQ4rfThvJqMUJDlDjl1yYOfNSb3rnBtOSiN6SQY0/g3t7P3VVLT+hCs1+mCWrpgeplOlZAR
	ctH93xN6TsoYR6YywO90s+LRIVtClOYt2fVJditry0E+csllR5cZo1uu/roY1nOPuZsSul3m4nk
	rg05y9R4diatCSlIeFgU2F3S/tyeEybfRLtGtVCq+jUzimnuulreoECfI0o2OWGapEb7eEa9mNi
	74FX8yXd9qqfc4KSTyzzGGuczMBHKwQZgxiEROnglOKqCq21weuBqhLdnaQIDpyVqQ9rkqlRnUN
	zVhMLtyvlGC5c7Go4Nn7qFj6PmZ4f+2Dt1gcRTIqmqVSqWQdMKcGIv5r1W7bc9y1SmN0x6hn7I0
	G4uG9tl5+GL8ndNus2DQR70OHbKBAuQa32CTtOI0UXvbII6Pm+WAne
X-Received: by 2002:a17:90b:2e42:b0:380:fead:448d with SMTP id 98e67ed59e1d1-3958109a525mr18077235a91.13.1787193005186;
        Wed, 19 Aug 2026 19:30:05 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3cde4sm12848154eec.4.2026.08.19.19.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:30:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 2a3da1f4966798b0b48ce302944ad356b2c98b5d
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 02:30:04 -0000
Message-ID: <178719300350.432.16693706424140189464@b455de3d9de8>



Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/2a3da1f4966798b0b48ce302944ad356b2c98b5d/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 2a3da1f4966798b0b48ce302944ad356b2c98b5d
origin: maestro
test start time: 2026-08-19 15:29:30.172000+00:00

Builds:	   50 ✅    0 ❌    0 ⚠️
Boots: 	   38 ✅    0 ❌    0 ⚠️
Tests: 	 2250 ✅  576 ❌   43 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a85dada62f33761c0e6401b
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

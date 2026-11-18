Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010353;
	b=xShg03mXmageF7NojNAk0cG24i/zyWIHa+gIbbNaQ0GaGei3I26tWaUAl52wu/ipypg7
	 JymbH32wox3zTeaxoUONxMTlbNWWDjYZT2gMcc308oWmFqmRv54heCNWqrLugYybLmban
	 bu2xYFf9lS3stNktHlk5Cqbgh5PACughuGPdPGaXAYHiTl7EuVBx9zcWYu8pTiRdveqnG
	 sbzDG3Jf5cP5FXB09WSpRxkUgMZHgCmLrMNOeQkRPRPtJUqOhjR7Kc54pKwHPXDfuMO0N
	 5+WeukB1KoU3pDbbN3b5j1L8M9H738UkBq3syKpJPZ1di1J7PlRgGiQGErIV0O2ofKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=RZvC0Zn/EQM7FLJk9oyKmnmn1HFmLnKjuQT0YGDPVR8=;
	b=tKCkWTlrRZUaMlaOPfFdrb3Crwvx+atz2IqiueWTcVazHlbC4mWNpmrgZ7kVpSK+pv3p
	 nCxMFhuU4ijmACHVc7Jp5k6yZR57bvdL3HwW0MJThbDZIyscKqUgP0M3FYFknRq1LPNOl
	 W7sr0bWE+T/FbwImuDLPyLs3dRlTlHlatSJUtEpRtAbTPouRbiufJyZIVchHZxKKVvzKp
	 HmhugdvORVf7tB7Iiuu9IPbohSMG5kQVwPOetw6+A12TfzBUENJxRRpmhtkPxZ/+xgKjL
	 YtSnNkkAB6XDkXtjNo8/qIMITjZA9N4CwT9v8MoSp9mmbgN9Scl/i3N0/ka4ue02kmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=BLzo8VRF;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E41606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E41606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=BLzo8VRF
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-380b40312e2so2845129eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795010352; x=1795615152; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RZvC0Zn/EQM7FLJk9oyKmnmn1HFmLnKjuQT0YGDPVR8=;
        b=BLzo8VRFyRnkuOYOIH/QOS5a0SYqlFIKz2pbHU1YZ4W88sJhumpBuSwZwrN7wCkAd5
         V2uD+vYsnXqyqa1sSDoRFyK9O9QQN7jbSEGuTlpz1t38cSJjp9GJjBSrkFvnsPirOhy4
         JzOZMonv+kAYwcqZSWSYxcZul5wGtT79kr5Uxdl7ir3rVYZsfr0DqiczDScVLPZKwgkf
         9+wb6trvTli+ygnwDIjDkp0qsmqiVDEjuaLKz3Ma8ZzAFaru1K1TNuIxwecA42O1/GL6
         0cuT6jkrFzcD9dtkaf3qbp4uhS2vkCb9Zaj+YpitXMf+xeuS1o26Mbr4pWpDlKDqGg0n
         B2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010352; x=1795615152;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZvC0Zn/EQM7FLJk9oyKmnmn1HFmLnKjuQT0YGDPVR8=;
        b=NXWigm2a6vLQm8QQnPpYPij+WKjKDkWQpf/jJV1aK6lRJimIHv90u9kmp/7LxBq4Ry
         1xBbsuieCJ3d8EozGEe3s7l5CuwaMUX85JIUdfkNC/A4xOxRmqa1PAsULXO6+rz6ZbIG
         1y1OA0xXg1Gpn4lbfsCWBUWKQ5Z/17ENgcYB+3WtBn/1uhEVAehzir/GCmHLyatF9q10
         LcejcDVEh2X0g0c3AedE6CFG0E8L3OGV/L3Ci7/TkNIY0NVehYJfEPh4nTpAgkE//0n8
         Rflz4vRIygXCuEA05h0+fzBxzFCvWsqhrIXIvjzfXRpS2YhlzJT2zZfD2+vYDdKSelXw
         PD5Q==
X-Gm-Message-State: APuU4Z8w3P9irM1UBlX9SYMPeBH6Lp/S9AVKmNfC61io+CtNCO2WsPzt
	TSPQKjvLiOxKi3ptXXjoOd8ivPg0VLMNchH0kdMQsjdXDXY6TfcFjm2SQwoDrTEpXydITbbe4vu
	xxZxJ
X-Gm-Gg: AZFdTZez0NmLhPUSkgM77iZ0JE2uXuYieYZjFLQrUCR95YLGeIgBHI8YgaIwiGVuBhk
	uUGTwccNlCx51ujlADyzEhB78bBRNAE+gIfksHwpXAPVs9HqtCXfswpUKI23Ilr+kIb9tPxNRYB
	QvLoqA14UP+hs8zdsNU3bikhTgpHKVXZnG0mBEwbeTwmU0azZjQTEE96sgiNR7DIUZiu+fy9WaC
	8FHK3mENRNwDw+lmOgN0yDEObnajt65p/x7eUxRSUlk/vQFinE08TfZm3YyLeRGudkGs5Ss1cuu
	D75vIMZ5xMNJfc0Ae+Lf7bT2q+TcgGvMrTLkBxPI8ZxRjxVDNq7EgGYg7KajmQbtLFip4U2EQl7
	hIGRBLiA151+z2+eNDyFlypg/xH9BWCC2ETm8FqqbdVXPNGQ2o10SR06DeQoMvRQhIF4cbFKY+4
	DbuxpJFnPb3apBmxO0BDWUCQYnvh+kSHVwG34e2DpQbVC6B+NTi2K36Z07u+U6ImA+JDBQKdvCb
	x57o7shKMz8ClJ7zkd/w/GDUG4BYKSyP+QyAdLBZOca6qTMulaMdH6Ap6AvF3gEjR9HxNCSVT/P
	FII0Cv2i8kg/ypAQ7CBh/Q==
X-Received: by 2002:a05:7301:fc13:b0:37f:73f9:aee7 with SMTP id 5a478bee46e88-3827da11e94mr2843096eec.5.1795010351514;
        Wed, 18 Nov 2026 05:59:11 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm8710563eec.28.2026.11.18.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:59:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)no member named 'path' in
 'struct
 coresight_device' in drivers/hwtr...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 13:59:11 -0000
Message-ID: <179501035051.303994.13551035224157019598@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.18.y:

---
no member named 'path' in 'struct coresight_device' in drivers/hwtracing/coresight/coresight-etm3x-core.o (drivers/hwtracing/coresight/coresight-etm3x-core.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/hwtracing/coresight/coresight-etm3x-core.c:462:9: error: no member named 'path' in 'struct coresight_device'
  462 |         csdev->path = arg->path;
      |         ~~~~~  ^
/tmp/kci/linux/drivers/hwtracing/coresight/coresight-etm3x-core.c:503:9: error: no member named 'path' in 'struct coresight_device'
  503 |         csdev->path = path;
      |         ~~~~~  ^
/tmp/kci/linux/drivers/hwtracing/coresight/coresight-etm3x-core.c:598:18: error: no member named 'path' in 'struct coresight_device'
  598 |         drvdata->csdev->path = NULL;
      |         ~~~~~~~~~~~~~~  ^
/tmp/kci/linux/drivers/hwtracing/coresight/coresight-etm3x-core.c:622:18: error: no member named 'path' in 'struct coresight_device'
  622 |         drvdata->csdev->path = NULL;
      |         ~~~~~~~~~~~~~~  ^
4 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:70d1473b40f259323ee3a8d42a565e203a170e5f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cdba173620176f2471d7dc1897b8a59fa7a85fcf

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd93a499c74e1a997d432e

#kernelci issue maestro:70d1473b40f259323ee3a8d42a565e203a170e5f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

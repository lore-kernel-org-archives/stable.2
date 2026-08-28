Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202D2673AA
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787884231; cv=none; b=Uvr5I/+vP7FwUz2hkHchlNy1bT+C9KjtWPIwAkVlLqAB9/gODm2Qsq5Py/Nu18mljIRDInrN626wvIwBCPz/A/KN/D6fb3qthr8yeuGv8Re1phICDyhsHdGzGBobtw1nrhJiXdF/9yajw3/YzOyIFN/51D6va4jrhVENUMPm040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787884231; c=relaxed/simple;
	bh=tKLJ9E2pTd0Bn4fh2p6YdHSZn2qZId14xZ+rQ6ss2/k=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=KDFiVVtsgZuB2rkmAYsUxEQZFt91PYRspAHjHsIiyEcrFJOkLpKhTgUnqAezDBq/FzMrk600YXZ7rvbga2wnk6OOmvjWMHWItdsvoLG4/QBqbDBVrrZNgalgxKghYatRXoBSttop4gTCL5/q2rtDL3ZwPsGlarvIKEt++w3A/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=MWoBhfb0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="MWoBhfb0"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so414107a12.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787884230; x=1788489030; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uXR6D4qEjPWcNgjAKv4Sbbp8hRU6DXrwNMSdoXUy3Ww=;
        b=MWoBhfb03NSwZb8P6AZbFryalyRqReidS7E8a+jFghsRQwnoRUZSuF7e0py4ld9Z2T
         7mmLok5ECpLVeyosV2qZm42YC+eBki7L2Q0+m729xgrnWaTVUuPoJdDXnAjfweXOiY2c
         VgsnYR8kr61E9MfuzVnpo9QKdmI26lutl+ar3sfD4bQelQatLqA47Dv/4l+O5v2TAMW7
         fcaLAmPC5KLbxt3S1eWwgDgG2jAgIOt3VnFgwNusADhpkdKJk44fdWgf4fbYyExaepUd
         QZZ1JuC1u7xVmg5WYRk1yTtZYZZT582RDRpK9fQAy86NCXhsQc+jt6F1qimMs2kvqYcB
         EbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787884230; x=1788489030;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXR6D4qEjPWcNgjAKv4Sbbp8hRU6DXrwNMSdoXUy3Ww=;
        b=TyFmWPr7nlPHxDL3A0KlzvJ0YQClB7N72Y6bisvIjIHxlDgcwXNYpp8oP2epg82H32
         S4pBRzEKpOW7JUQl8dmC+XGPnQoS92HnoWu2zvJiA20LUHHiETXJ782ujjL4nktEtn3V
         xfBf5toOkk8NpNQOQd8GpiNEIUN+/NeJnUngrYyMjpO6eKN2do8InfdB/L+YDqskIElO
         43YOGNl2qrR5vQyaXDwDKa2vWym9UTGsctNbC4HmDxhvG7JTyJ9YxnglwU8KKnPXfJ3f
         qoT8TbglvlkZUCcE38tr3cSVkp1eKoVmlScG8MWyLewVmS4hSYaaUHd19/zOz471cmIh
         +SKA==
X-Gm-Message-State: AFuF++nEMxHCyVMdM4vlbp5XYQyqQ3lCgfkAmz0NWzKqkBwsdhbclBmM
	e0TWGyxmQoS78k0PIhOKI/Fn5j7UjfjUwlVbXlr8omFv/qSY9YkgQDPMbKtVVByuUr8=
X-Gm-Gg: AR+sD10q2139bByHSNi3+jcBfSACM2q2mVLAhiFhJwERXJzCjVHw/EqljlLZ1cyqbsg
	LtPJpDajoAeDj2BvLaPbrm6KgmRPjSdnH1qvTnRi0vobv110QP0QR8IgOUqwDR8JSxS/8o/vehs
	ysZqwK1lT3DNhFZmsbRx6fjjwZ98/FRon+DPaUgCyhVcNJvNWOCxzwf+j4wUG5cqfOos2x6LOPi
	Esm+x0ynq4tPsYbD1pdfXsW2op5lf6EZsKCPCgJ5AtWYVwQGxLw2afqIC7g8/4DDFI3LzSiibgd
	KZ8hIwdHI5ANpjthKJClPw9tnZ9+ph7MdE3bfkFOCbM58p0zrHG8f9UY+EZraVKRowOHeo0iGAs
	XPdVAEXV1KAdJMqfoN/z0kwK4fVG0PYj7GbDf99e8m77GBxUrCq91YkRKcSBR1QZ7tL0JNnO2h6
	Z0GY3BpYEcbZgNlfr7w/q+6CAsy6q9uovRuzKYP2FGpX7apaBMI6qN
X-Received: by 2002:a05:6a20:748d:b0:3bf:7bf7:7913 with SMTP id adf61e73a8af0-3d26951c53dmr4775440637.14.1787884229772;
        Thu, 27 Aug 2026 19:30:29 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm638693eec.15.2026.08.27.19.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:30:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 86012429e213eafc10371e3de39868c4b8240e8e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 28 Aug 2026 02:30:29 -0000
Message-ID: <178788422862.5582.15327723677586527681@b455de3d9de8>



Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/86012429e213eafc10371e3de39868c4b8240e8e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 86012429e213eafc10371e3de39868c4b8240e8e
origin: maestro
test start time: 2026-08-27 13:10:45.941000+00:00

Builds:	   50 ✅    0 ❌    0 ⚠️
Boots: 	   23 ✅    0 ❌    0 ⚠️
Tests: 	 2197 ✅  252 ❌    2 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a9042bbc5867fba94641b19
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

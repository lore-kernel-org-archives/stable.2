Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523A559C82
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653552; cv=none; b=sc+7j9QS+xwOXXG/LmdGQz19sN/Sw4+1KPMT3hMgrTGFghhaOFy5oqqbkjdxAOzJhaaOvPcNTy3qrl73R/8JGxko4543sYwp3Xkk2DZ0i4bbiVEmN8NZTE509gdtJYsXy/KvmVsK6/wdEoD9a70r7nyXYRDaA34zYvaWnNPYtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653552; c=relaxed/simple;
	bh=czForb7gF+G4rFKCHAc2h6J5iSiGaGr3SRUPcoBDYYY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=dfQMadbp5GARkhr06Uz2+9vTaOxyV21Gbo/HGSPz4UD0vuRt3AFHmDYandT/G0mAs08i4X7rxHvF5wysSX/1S39jhE9Zz2WTfBzwzvPMxVt/zP5Gek1LZWmcigSM0kkDWgzN5lvL6oa2RBllqyKjsRSqcJMn8udeujib0jHiDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=bfwFsumj; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="bfwFsumj"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c6so734261b3a.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789653550; x=1790258350; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HhDQhVitLYfgKQs1MjzygW5F5N5fvGwOTxwpsZgST8k=;
        b=bfwFsumjtrGQlB6ZpaD3QNMv+mv+5//DcGIwsSEXcZ+9M5Z69Ex2NvN2IVz3XTwHho
         p7to+aNokDL+CxxEcgGyc/liRSv/Ru/e7JynlzuvMflJiBwsoswx7tgEd0TyQV+I2mqi
         uxQ1waa3GVP4mM9W+RZO0YiCJOcDISgJKbHOFSDNYtA9MCSrsSbvQeyKd+EY3iz8Q5d4
         9BFEKD+eubirLEVuRIaETKYXku24i17Cibgxwc6e/BfEsfxW9G6Sz2o+8U6OZqrV8Ta5
         uHKjJymQ0oy0Fm3A4TYs1GwL/sPaFvyPMeOADHeGQvWpyj+fUH0ukSfi3CAYY2vZwFfe
         JQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653550; x=1790258350;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhDQhVitLYfgKQs1MjzygW5F5N5fvGwOTxwpsZgST8k=;
        b=ie8pJt6AckDOqM2tINYZDgGi85/SlzWcYc+EslgJxnC5f/K9j+rDRVHHPhwOaPpvCj
         JU7Z/yM5ZizGTX+u7qDre/PjB5QCsDhgK1rgcvyGx0QR3XV/2+qpKuccJohlVBmy7TFT
         D69AL0IResb35+LwYX5/PvOPPoy/5l+zjcmpOpFN4dgAwS1HOUvpm7VZ2PdQTSMJHmp5
         A2w1A6CwjptcJLy60iKDLzH5wXGNU/p1ItsMOuIHTp6xTPYILCB7JmUpAIVKVTcPHgRe
         Bk26Fp7Jx051Zwm2eedzbUNBAZlif6GkZJDQoIZG2yJV0is3tpR/73Ia2owpcTpFa58J
         dgaw==
X-Gm-Message-State: AFuF++kzHYKX1tWjrR87/SREfrJ5Cvl4IvZF/TgFEvROCXF6vhEz4kbZ
	vhgrwmlu8oAhW9Y4QT5gH9mEioAXL8yurr3FY3me7vgbSvE5dvIMyjRkGKMj+3/kNv2pBZmoNe5
	GiB+F
X-Gm-Gg: AYBFou24DOWa8nlGvyilRFjDiy/rqzfz5IJ+Vdw5s4UbXUeFUijNzbclcRVXFDPDnJl
	HvxOpWQf8Z7hhhO3bPAPC6hyDRsYpjGzrLjkvZhN5rjLk2/3Yjr9VFSBsL1IqcKDZKQGQevsnrw
	vLZbWcZMhdNMeZ8ljve9NjX7UmwpQeRJAwc+R/X+MK+Uis3011veQVn2g9dkro3vsnFmeobPDSS
	RDwP5kj7kIVKzEJzOmEcsH0wErSNspSoVYZ+FTxjYZ8t3ZMmBJmrTzIwnhSBgL7aX3RpDFD6l9f
	RQHjJkH7Pg/fayroMOJeyHJS5EgHTsDYAai2lgTc+XX9NjCUVyYHwXcgF7qfvzVKquAulh1xd33
	2GEsXWDtzqy9TnH6uAE2GuZR5gs84Dbu2a/ANk7Jmegk/SDKrRJwoS/t+K5IvtgObF2PHVYVLmc
	D56nnYJzyH3eDUdbOBqEgSs+Ly/0OW/VBGvaRg7Co3pOhQmGMhY8TyrADB9/yUgjo=
X-Received: by 2002:a05:6a20:3d92:b0:3dd:85a8:cb80 with SMTP id adf61e73a8af0-3dd85a8cfffmr761941637.35.1789653549567;
        Thu, 17 Sep 2026 06:59:09 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cfb0b1sm12711952c88.5.2026.09.17.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:59:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjE1Lnk6IChidWlsZClpbXBs?=
 =?utf-8?b?aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhrdmZyZWXigJk7IGRpZCB5?=
 =?utf-8?b?b3UgbWVhbiDigJhrZnJlZeKAmT8gWy0uLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 13:59:09 -0000
Message-ID: <178965354843.144182.17521463192450938408@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
implicit declaration of function ‘kvfree’; did you mean ‘kfree’? [-Werror=implicit-function-declaration] in net/9p/client.o (net/9p/client.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
net/9p/client.c:934:9: error: implicit declaration of function ‘kvfree’; did you mean ‘kfree’? [-Werror=implicit-function-declaration]
  934 |         kvfree(fid->rdir);
      |         ^~~~~~
      |         kfree
  CC      drivers/clk/meson/axg-aoclk.o
  CC      drivers/acpi/acpi_amba.o
  CC      drivers/clk/mediatek/clk-mt8183-audio.o
  CC      drivers/acpi/power.o
  CC      drivers/clk/meson/gxbb.o
cc1: some warnings being treated as errors
  CC      drivers/dma/mv_xor.o

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7d277bf43f61921f82e659c446ed26d0efe67406
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0cda336e90e56636d2f94cdb84fec866ee662db8

# Builds where the incident occurred:

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6aabe847fc1857a999df04e0/.config
- dashboard: https://d.kernelci.org/build/maestro:6aabe847fc1857a999df04e0

#kernelci issue maestro:7d277bf43f61921f82e659c446ed26d0efe67406

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

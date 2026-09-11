Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB5386576
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153148; cv=none; b=twI0SUVecaSQuHIqef4s7TdWCvmzMSx7mcEiT1R9+5LsDR7W/ZwV85QnhrXSdnUyyA7sAVSlWd7C4Zn5eo/q3xWSX0BMjzmIXR79s3k9i5t93+nIFOLp3wvvg1kMYln9/1s0X23ukn9PqGAGHasyhq5h43Yg1CcwxNNof8qvxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153148; c=relaxed/simple;
	bh=9ToPPO+OxjehGQyhPjvBRl+bx4k8aQ5rSYDHdSMefMA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=WTyz5H3PU+CaRwXggX0AWa3lw/32+1Bo9U8qytRmgWNXG8tIR6eQc+x6VPTQBtVrbigAqrEsIZJPO1itnOF0YsB7Xa6Ma2yU1WaIFMIsldCLwOo9FV7H7xfvDdWqd8W54zS2bW0gKDDMQltF+0zWKLSYGPHE46u2Vk/KT7mQONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=F5VlZDw1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="F5VlZDw1"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f9bso2366725ad.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789153145; x=1789757945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KPOiQjLG2epQ1Pp7Rd0DEIEskew+gMinaAYPCcdSZQg=;
        b=F5VlZDw1tpl45Pcd5Nl+PYiwXhu/fvzMnSAwfJcaSw1p1uTWAmUY9Hvjp9QYUbmWZR
         miVOwi/jxnkKjT57n2AkMs1JKEUbHEWG4QuNvCOO078FrN9VPq6vdNDKsnCru2iNOwQ6
         +ixJspDGS3uT2VmyfVJJxvtO98bB5YG4JBY8FWPpjfQOjlmPWvBa5C+KnmAmc0O3fQ4C
         kq7OsPHF1lrPA8yPhQGZWqga9/8JTrOk1dJJpAGsmUd5O30+7VeoqTbXhxxMEgUnf5CV
         SEaMA6rtmvDk6wq/KLFoLcvAozU3diF26bd9CmVjHkyVuN2gXn6ty7SVSrCQDxjaJHeZ
         1ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153145; x=1789757945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPOiQjLG2epQ1Pp7Rd0DEIEskew+gMinaAYPCcdSZQg=;
        b=pUYcajfs09ka17ToTbqRXmjzfDVtTO2ZpDuMIPMODre2TbyGajsgoBBfTZwaT4Yn07
         SDVtANHgDOiNVR5bada4AknAEYU6L7o7EGZwti5VAYulvmJmWpknrTmRix3HiiZvW97e
         lH9xgtMb38uO+OZpek7MfS/lc7FyeZfojpAu5uJdYQZlquHy/VRfgEKm/rBz5jAqQUw5
         +WAlzXspjt9yr3UVgAqgCVYEit11sGThtZ1Yd/sou66/xwG3+bkRWhWZB197RfR4gYfv
         fKW8QGL+o3wgJefO2N+XGc2PpAgcbwW0MZlU8Tn65xz/yx/RieYBfXpaOrifCEm8XLXj
         Lyhw==
X-Gm-Message-State: AFuF++nb1hrgUlRvRMXikSRkAK7NkeWYWhUg+5F0PuvAs2V2Nq+wVU/4
	CLKhSDQrBwNiZtJFp5yRdSgOdMgOQk9gJoJzXBvB8iQi2Q+mxuMit5Vzp0h+DPIhfPvQTMmMbGV
	ZLzb2
X-Gm-Gg: AYBFou0AFNunmGXLhu6Y6Bq87/b94dJhXEYkNxuCZVtmze9GMylgBsplPc5z2fzm4lZ
	PhijdJfQWkj4GfUKgslOuaClunpl3Y+iBv6AlzHV6jcE7woryOW0wsYA7xa0/VDb8EY5MeBZsg5
	AVAbngr9Kiv1supA+/IT3+FrffWSZ0uJdiAo80tNWWDiwSItatfORvKkyJx9za6Lk/C7c7EeAFz
	kYMkmZPvSL3fVE6XCcSiBymbD1Fm58KQ5+SSikJ7u9hHyLcBtHmCY5xuDX0w9QW8qu69snG9RMh
	HyvWCVZZTTEHmmmo0O1bUaoD88ihXlZnfgPjp7UtN2jSXAfnpHgDIDaP40pyyzU+t1k1oOJseP8
	8zAMwdMgo3WYWvCWkpjQ18d/FKeTtqMGHfV5NwvTA5k6+GzjX0FW5/ERp5Vx6Ew4l00omFvj+zK
	YFpp7uEl2rusl0BqHttVjgZXTwhB7ecitRvPmu5en0qbiL/1OW5pUN0d4ifBZkEOo=
X-Received: by 2002:a17:90b:48c7:b0:398:9be8:ea66 with SMTP id 98e67ed59e1d1-39d9c226c4dmr10304312a91.19.1789153145457;
        Fri, 11 Sep 2026 11:59:05 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4efc398sm9298745eec.19.2026.09.11.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)undefined reference to
 `crc32c' in
 fs/ext4/bitmap (fs/ext4/bitmap.c...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 18:59:04 -0000
Message-ID: <178915314439.4479.4471826194459735209@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
undefined reference to `crc32c' in fs/ext4/bitmap (fs/ext4/bitmap.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
arm-linux-gnueabihf-ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x148): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x258): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o:extents.c:(.text+0xe6c): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:aecdcd539a792f239bb4b4c3a064a6db1f375a3d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40ce620239ade9022ace8

#kernelci issue maestro:aecdcd539a792f239bb4b4c3a064a6db1f375a3d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

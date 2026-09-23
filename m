Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13C3ADBB4
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161155; cv=none; b=NKLBptEZI0SQTEPLH/6rlS0nhPSv5VkBbDa8a0pUKfgPoCL2dwaEedlEOI7fErHnKZdJ0fAyXh0W13YbAErxF7oDz4U5szneSnEr9iaPr9V+CbZEFMQkZhd12q6uzNeNo1lSXzYCDxo23tHc9cp5K5uDOpFfcbovsOKPZe7HYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161155; c=relaxed/simple;
	bh=4v4grpaOoqH/9GbrY+s5KJyCd7CXRnpGOjDPAPFd10k=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=uUpEfkM4oS/cNhX/8PAbQqxuMtyBSjGqRA21ZZv60Y1CmshsqxaY2m6Z/ncfYjeNILvY05t8vMfwtTDdpPXxwmHzQDfTtFrFAbamRyhN35BDTCeKhEUkl0GjMoIbDKpQYT/iiojfjQblMbz+9gVyBXTpJAcwdm0OgY2VWm17MwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=X0RciIpc; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="X0RciIpc"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3346e75082eso355827eec.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1790161145; x=1790765945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mf3iR0otEePqcvtzKc5Xz5MPm7U3A7wI1ep6QEe1co0=;
        b=X0RciIpcs2Dn/s9Ovp9ox3bAEGZtK+eM3Sj/TsT5ciN1WuexBn8fQTZUo3CLv+cqRo
         dtCDW6ZobbtR+uZJw3h3TnzaiHe6FjvPEACA1iPDrtVwwqBCk06q60h5bUVxk/5NJ2Vc
         r/H/Dnoj02fwJRBdNpGjmRx2YIncgt/XbP0gx7S2/9OxI6aKNF9SJkETVCRCnImBsFad
         Si/k0y6d3LftIMdB19ahHIKyCtKZg+1AO1TTJeFbSIaBAkPtHHlvgP85ptt8cbjNNoe4
         zubjNFgSlHKTORMW0iLXrcmJAqTi6kbv48h9p7JoRpO/Em+vcCFyeVutdw/xAnpGRqKH
         dxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161145; x=1790765945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mf3iR0otEePqcvtzKc5Xz5MPm7U3A7wI1ep6QEe1co0=;
        b=21urLRJwsq73CXYstizJOqmEYCq64D14SbBTMmEz+z49odoko9fHxsTuckzPq96Kib
         403RYZuyfPW0OJD/uMhqO3YIxhoQ6ITsszeDHH3Ef8MKVrJRBqOVlGGjNal7RLm6BRKJ
         4NhnPwdONfUnhtZLVFKQ0fVsqWvv1LlWpG3d088rW5Ew29b0kFIcdkYpNYXfssoQXYgT
         cQ4rh1qh5MUXeUWx6bImhJSdkmlRgczFa4jb82mWTo4Wed9K81mditDjegRTU52Y+Aqk
         3OqyG35+8b2H+u+6wVndrx6qDv4ahhO+cHumhroqpJQCkPkC3yA5PEl6QPMpIyM2sEJj
         cQRA==
X-Gm-Message-State: AFuF++lg0f8kGKF5FxrnnnCn5uYA9wS7DR7bVTCqbhVl5ytPTHUxOWo0
	7tJxLsVqMnmQF1q0aE4q72LHAnGP8U21dz5hJdsZG1CQvUUT/2iplvIXAWHeJYizJI4=
X-Gm-Gg: AYBFou00TeKdj5HhcbdW27uzoIiLA8wQbPRHExK9FIyAj3Apimg44+Q20+RdVO9+GdI
	+fucTXGsWGg58fSwf021xbxA+DXSksLQH+luPT57DE1cPamNigiA4f2WICCb0yd7VWE9Iez1jPa
	pC2XavMbH8eCFB8oQCzz2I9q4BHHEub+MC9/QGa+Oz0Bezow8WsMm0IJz2+GSbA7d80mvtBtasF
	DBZy4VEhN1gSleBR4FpJCtyOoxK8C4PnSc9+/VrNsxE3TLJBOUkmFbOrkkCrEcKIzDw6+96cs3k
	thj4SdNh31VOTL52WF7HsrfSAuONy4a3JAAKqU9QMB9bohBZeQmOhh+KvMgYj7m3b0AMFxM0KQ/
	iblZX9NeCWHfdsmv1uPLYO2ndUMo2n9iFDA33TRkBEUUbNuLe7VOrqVV8vuMHLDKegMmv0t7WJ7
	U7NHPUIDQjY8AyskmD2/10E4a13szdu9K9OvR2yRqiUTuVRyqn25s5HEvrIdb7Ewbrm8ohOhaoi
	A==
X-Received: by 2002:a05:693c:87d3:20b0:339:7572:7b2b with SMTP id 5a478bee46e88-33ee381562bmr1303430eec.24.1790161144940;
        Wed, 23 Sep 2026 03:59:04 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625921asm5865178eec.15.2026.09.23.03.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)"init_time_ns"
 [drivers/misc/ntsync.ko] undefined! "do_timens_ktime...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 23 Sep 2026 10:59:04 -0000
Message-ID: <179016114335.454291.10574383324360102084@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
"init_time_ns" [drivers/misc/ntsync.ko] undefined! "do_timens_ktime_to_host" [drivers/misc/ntsync.ko] undefined! in Module.symvers (/tmp/kci/linux/scripts/Makefile.modpost:147) [logspec:kbuild,kbuild.modpost]
---

Log excerpt:
=====================================================
ERROR: modpost: "init_time_ns" [drivers/misc/ntsync.ko] undefined!
ERROR: modpost: "do_timens_ktime_to_host" [drivers/misc/ntsync.ko] undefined!

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:26d7615b23381fbb14518dd8a846d76acd94a52f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  eccdbf0d3a832ccf6c732cdb37c3b39ea88fb4f3

# Builds where the incident occurred:

## x86_64_defconfig+allmodconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ab38fa7d96a8203de845fe0

#kernelci issue maestro:26d7615b23381fbb14518dd8a846d76acd94a52f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

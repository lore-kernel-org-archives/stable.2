Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E44F7CD0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667948; cv=none; b=p7QSk8kwCRjYdxbvlTbLrQUPxteB6YsQ6Wf01W8HX2QKgIAEQl0Xxm+4WbE99QAyNFNmC22L1G8eq6e+eBwM/0yNFhzFk8l9WmiW5169os505u0INgN7gtOTUtzATPPrFmDfN+jYW041JMYFd9rSCdfNH/JvDKfjbt97KY2RZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667948; c=relaxed/simple;
	bh=vpXU0Ysfn8eisahZH+SwTDP1M+XZPXYM4oAzgHtKYvQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Ib9htiTgjzhy15AlzjEBMkzBFY6ABGiWNVbfnoLkXrD375gf4gEXHElQFfGNqXmjnJIbpFEnxdm/HCUVcp3XKm1aP37ERUIdNVfgTKFlQQ6M3ZIt7ydTtxvYJ4mMYej8pmM1175aXx9O8xPA50nBncs1ie3CtXenfBOXdpIZSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=hgA4OL7a; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="hgA4OL7a"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so11916915ad.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789667945; x=1790272745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NJHlZnOrKpid56lqWlPYd4Xoj2CQpHIAy6iVLJTc9Ys=;
        b=hgA4OL7alTAFz2cWiEOy6bonVwTQgJ+8aHrq9MFJ30JzufLPrJKwxvBThjMvjosTXF
         GzivJTHAzESZEuz6UmnfAI/Mey/ymWv9wkOt7guKGyD53VCu2KpKpf0oaSYNs4KBy9Md
         rG6L3GABINI0WAtgcLFpq5W/wM+1KpiTlWyCbpgnSXE2pSLLxMZ5OlTZRdKEXN9NH7cG
         Y5IEc00nFSrFkgyymVNLdPbq0FE5/GzxhY7sD99bRwVr/YQ9flDGVPal1ZbvimZTk6JZ
         LiHttZsoqQPGKKO4fwRX5NbEI9Sqk3Ygm4P2Kn1SHTduDG+fCHwHUCJNLoEJ7mjXCSyo
         75yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667945; x=1790272745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJHlZnOrKpid56lqWlPYd4Xoj2CQpHIAy6iVLJTc9Ys=;
        b=oggy8WoVi2A7vfDP8j8uZkdz+HVDYI9rcEM9+yl7DpWrJe/Bu8L5QJLcLEFUsr8+DJ
         /WoF3SrGW92jwZbTRIRbK40hVTEI796tgn9LzKP/TgjUacHiGV+Rqobxcw63eYBhVOZ7
         UxULEwFD7oSPL4WGSX8IHA2Ucdt+WxFaIJpnJPlKdsRHP+u3/2UkjTO7SKhhpif5I7Hg
         rhzmsO1UUCKO4iL2j6Z67q4cnqCxagYcbQGi3Utlddc1I3Ava1hkX1/QQwu1ECxAxPf1
         GlVvN8UjZlGl2rZ0DmiEUcEL81BF3td5KRFDf/zZJMbFPMNdc3Ejrr2AJntBH9ylpYnc
         zacA==
X-Gm-Message-State: AFuF++kKUotkhd4ILP5WEm6OhMPXlZbI/gO22YR5TJi6XqhWpTtyrBs/
	4rkvgI6bqEHvqRhh1Kbv3zSB4a3SX0xNSPkjskDS8p7KddOBOppXsvvAlwGTSfrv+yGJMHueI+E
	g1lHv
X-Gm-Gg: AYBFou3ru/pmWXS/ahbhaZUp1/9nKz+9er3sspWW7umxJF9hMs8zmvFzKkPvS+u+Ubr
	corOAnGtK/9qG+s8BwxO4AyofhoI5StozzlD4fPLXCz4eq/QNeXZ3LhAaSTqHeZhM1Fy/TQDcJj
	TS/2SngefXtk+s3eDoQWpbufCp3pMdh1FjHWJ6soLTBsKeCI7ATMhtoJSJgHHovD2wx8GKxVUZR
	58wz4Z9q60sSOk4kMdazyXoq62n4/nQ5FtHDWv8pCrJLvCvqYf3YFcY8N2UkMuLbPCBED52HSVv
	t4X0SHltMelherRTBGsQ3ggdtqPg3nBGJVGbSH+QkgmlGap3YcQ0AjRvixR2H41WsT/+nJo1eGP
	7xsXKqfeIx5D0ZTyrfROvTq9AdWkkx1giSfUfDbHtB49Tkj39jYjenT8rmXJUjKnvRRnKpRKw6K
	ZJPtAkfcmIZ3F8U+ncejtcQB1FhapMaLP+TcoL8hUmNjksz+FY5VV8r6Fvv7Il46Y=
X-Received: by 2002:a17:903:1251:b0:2d8:d4d0:792c with SMTP id d9443c01a7336-2dd8e752f13mr156731185ad.16.1789667945255;
        Thu, 17 Sep 2026 10:59:05 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a9fd38sm17529334eec.13.2026.09.17.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)Error in
 arch/s390/boot/vmlinux.syms (/tmp/kci/linux/arch/s390/boot...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 17:59:04 -0000
Message-ID: <178966794363.152940.6540163997608818842@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
Error in arch/s390/boot/vmlinux.syms (/tmp/kci/linux/arch/s390/boot/Makefile:74) [logspec:kbuild,kbuild.other]
---

Log excerpt:
=====================================================
make[3]: *** [/tmp/kci/linux/arch/s390/boot/Makefile:74: arch/s390/boot/vmlinux.syms] Error 1

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:bf8f78b9755fe9e59bbc75d046bdeef487614bd4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  18db24293f4d9b64614e0adf6dbe298073aa8860

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aac140dfc1857a999e115c4

#kernelci issue maestro:bf8f78b9755fe9e59bbc75d046bdeef487614bd4

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

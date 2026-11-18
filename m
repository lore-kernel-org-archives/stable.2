Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006746;
	b=l4iTrDdQYXuFqzatLJMTqjhzKJXeKNehLdoi+RdmsVNhqxphpXFqm1zjUVshOrhAzWMI
	 Czr2+xGuR6FKo0CGygvyhLg93zzugkhkxfAHd/hwfNIs6xeTiI24YcXhvAXMkClirMNbD
	 xf5RIu+Qgv78W1CbpI9RYeNkOAlgwWszADt2Y7OuXr1YnQvxUHlR1SRILRgXAkT3cApo3
	 mlK8uXX+UY5ukKX3KTyWG44mAIlkSH5ylTTO6RspHkYs0i3UB/VV7G7KSw4f9ibsOfRWB
	 juzGw+IXOTBeR2oM9URoKWBYiAUBhVH7ZsAnB+BN9cVMvbyJEwSb4bIYcP3X9c9JhAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=QtpoCTcFD1j91qmHAV2lHjTulmCc0CiZjCMBdcppeko=;
	b=IM6ePzlGenHUNRVQCAmNmSgr0eQhdg1Ec4uouU764SsGzlTZotVcCpfKlD7/Nnkvt4bN
	 X6ofKj6hoMyIIuOyMhE02So4hdbonBtWwK6Q1bsnfz7bfLqVDCp8JLvpQuvVXToNmyt2q
	 +Wdcx8Iwy4YdM5Q/+MF5R4qubwplXxlfmWoHmc65wh9sLwcMCey1tCBksBakbaMzAH7M7
	 fdNPd/ljFc7M+UrNjIE8BiJgB+oJU/N8w7/oxYvC3aSfM3A//CVE/+gUNoyDjwFJrTmbo
	 tBZgh3unSdDZI9VVkeJjfN/TGcBt67Q/FrdSAlYL8KSUpH47rSdDRQMN3ZuQJdpmd/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=OSeQjark;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9D606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=OSeQjark
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1316422c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006745; x=1795611545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QtpoCTcFD1j91qmHAV2lHjTulmCc0CiZjCMBdcppeko=;
        b=OSeQjarkVXM4ddKu6SgHBJ8XuaKUCiKkh7iHqwfTOTT54AzPt103UY5B+TRs+yoUHP
         j160t3oU+ql+/lkxN+/6jwJVd3pjFzL+rBGDnAiBdJnRw+uHocT7urLTgiu67GNlpP6Y
         CBMisBXY2LYQFQZ4UpmBZfMtbk+nZb9osCrlry1YdSGSK6sKqNF+0Y8DNxGKzi3wzkAm
         WH7yPf1yceW0mvzQs1T/Ya7nBaBaz7BQwnCvd1UhRtDTWNIQneXvIjYldlSRgSSx+j0p
         8VY/IemKw59Y6nRrZJ9ERsk091c2uTn8C/MQTq1WvVQWH3XueqxqcolsuiHZMOtUAwUB
         UAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006745; x=1795611545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtpoCTcFD1j91qmHAV2lHjTulmCc0CiZjCMBdcppeko=;
        b=kxuMNqj2/Nat/8sbh4rr03936XZbu6EualAfpRiaBBf5xcHSaC3bj/nW0PcHE83a3V
         C1S6wIBtKTcyLjs57HiNf0MbK0ki/fEh4QyzcCakjqGSGuzhstQlnkevtAW+UQqO3prC
         9bnIsgQBFfw8xuFJdhuilC83SajKz7oGg9Vgj6v3OovL5RYRGNz9C2ZS+r9jFivTQ50M
         0Of0FZT3R/ziokAqDNSK2sR7KPZhKdulBJAmgkfJiagvnQlEjgLa9TfGImKfIImX+l2g
         ljLa82Vxw1PiT5AKQQaq7nHlbCj3GAPn9CyG8NGDEfcVRuFTEy49j9pkPHX+3qmzBnmB
         rvBw==
X-Gm-Message-State: APuU4Z8phUrhIGd3kJjm/+TpAFTL5x07CKfpQqQwxjSa2PUn3lp3ZbAa
	rYprK3CsumNGOzPis1HYyRynPHRloe6f1dljQZiGlTXj+rJidKnShz9EvMaqGhhcvMeL+RgDog7
	xpD20
X-Gm-Gg: AYBFou0SslY14wT/3dyu8zSIc4lXemyUiQpagDih1slYI2MfY9V2Cgc0kFZbuvEQ1HQ
	wYlv5foO6MZqjYcFOhc+wf3j9iQ8a7nBAL8M1PncoBLcJEVb172/oM7EpB0GJ+Uw+dVXkECMaMR
	Zik1ImmM7QTbPftldp/co6jAm0UV3J4QZzRSgZ4yq1XJXZraX/JCFYTjP5uJ5mbv49DgzU4oc16
	Pkte2B7tpv2EROcX3laYe4zkHslfltcJDXquu4/oFLNxIJFibr5oVxH0pjBmW58kZ7l0gI/Zosr
	+fykOWkOCfxongs0ic8sUqxlX6A9ys7Lmgz/ww9c5b/S9YbYcDc+1TOtFoCmSIGJLzz3iFTPvPU
	wv/Piu8C4/3chAtNFhLesDYZ+oS78kovOXKg2It+Pgq49ynae4ODSmP2cZn1JrgPfkaxwNvbov7
	cbypu3L6gqWCeCjPsgvNSWPWoeT7a//slenBGVQOSWm0FF6hnZUd82q4mYKxkv+Cao0AvJUohv/
	vU90ywpcSB/myPSX1RdB/BrWiPnnSPHpIs1a0LCI7t/Yt7AXgSj6UXMotaBqlt9JVcbWWseVFuR
	ICbYr5Rpx2xej8XexRNCKg==
X-Received: by 2002:a05:7023:a8b:b0:1b3:ad63:b9c2 with SMTP id a92af1059eb24-1b543ce9e56mr2664723c88.22.1795006744607;
        Wed, 18 Nov 2026 04:59:04 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f4e19sm9668922c88.13.2026.11.18.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:04 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-7.3.y: (build)use of undeclared
 identifier
 'devm_pci_alloc_host_bridge_release'; ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:04 -0000
Message-ID: <179500674378.301701.2652326104855898669@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
use of undeclared identifier 'devm_pci_alloc_host_bridge_release'; did you mean 'devm_pci_alloc_host_bridge'? in drivers/pci/controller/pcie-iproc-bcma.o (drivers/pci/controller/pcie-iproc-bcma.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pci/controller/pcie-iproc-bcma.c:72:38: error: use of undeclared identifier 'devm_pci_alloc_host_bridge_release'; did you mean 'devm_pci_alloc_host_bridge'?
   72 |         ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
      |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                             devm_pci_alloc_host_bridge
/tmp/kci/linux/include/linux/device/devres.h:181:34: note: expanded from macro 'devm_add_action_or_reset'
  181 |         __devm_add_action_or_reset(dev, action, data, #action)
      |                                         ^~~~~~
/tmp/kci/linux/include/linux/pci.h:696:25: note: 'devm_pci_alloc_host_bridge' declared here
  696 | struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
      |                         ^
/tmp/kci/linux/drivers/pci/controller/pcie-iproc-bcma.c:72:38: error: incompatible function pointer types passing 'struct pci_host_bridge *(struct device *, size_t)' (aka 'struct pci_host_bridge *(struct device *, unsigned int)') to parameter of type 'void (*)(void *)' [-Wincompatible-function-pointer-types]
   72 |         ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
      |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/device/devres.h:169:73: note: passing argument to parameter 'action' here
  169 | static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
      |                                                                         ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:b073a462cef436ac0fab5b241d4d2fc8b9617df7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  be4dd9d66786975bc12243b4d744f97150649f63

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd948899c74e1a997d487f

#kernelci issue maestro:b073a462cef436ac0fab5b241d4d2fc8b9617df7

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

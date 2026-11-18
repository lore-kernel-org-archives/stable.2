Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006749;
	b=js/N5ijdzNPtw5pwvnG0/Co9Ja3Lv6F/uqbEY8LzdSeyJUYaE6hXCkXUUKvucO0KXfqL
	 QoFK00LTkCxfy5yX/ucgOEe5w/U1/Z2IByno9I57syI98EfQidQuHheazH8F4Jmj6kvEP
	 SKh0E4I9cxg+F5gFceSPfpmH6nrB4XKIMvL/+tBYK/f8wUGQl6Oa2yn4gUNRWw0gfb7YC
	 Bo/OL8vhOQHt0AItzKMjArEDlmD08Nvfz8o7vYfH2hrTvz7AKfMESFtAHSaULesQpv5Z1
	 mipGpVh1IurOuPA2nY7fZi3QcyprWFiqySxOhlija1C4KobXxDiAvOEPST4Be8xLvww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=US95disnKq9Y06aMhBRy2v7SRkguxKQeRBGVi7GzNXE=;
	b=IhdLDIJD123ztzhDncpleklg0VguBAmEIKffiyG29TIZWwvWCOqTsDamkbtG2aFreRE6
	 9qDqL+M+EUxE0Y3BVLH3UeZEnplJR1/n+d6X5D/tNpupVCIj5F9gdoKD2mLmoWCoif4Q+
	 YE/yC0q5bjU8RtlD4B2kf9L2Q2jIq293q8EpXXXBHmzWkstZoEF0tXLW9gVIYc8o9TefJ
	 hS9wSRbI61CSr8jQcOz4HvHnJaFo0pFq2rZJqsyj4/j8EP3tSRjWFCki0HsGgEZrShz3v
	 BlXBkX1lNnG8rlYdyafQOMpLdyfsgV8c6IOpXQG5tB2HiIvBfTfnGJI8PHE6ly9nMBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=KVaH0HYT;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF0606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBF0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=KVaH0HYT
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3712b6d9843so1033942eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006748; x=1795611548; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=US95disnKq9Y06aMhBRy2v7SRkguxKQeRBGVi7GzNXE=;
        b=KVaH0HYTc6QN7PblIu5ivFMUCNX2ix8frBbD+dTKndPpYSDRvltuThltfUBN3jIBFW
         dv2hhw29K9bEI9gp31Fs8ENff2Xz0CqYsCjNv0mEXiGxWnvs7KZEaaS2H5L52M05ZhHe
         bUmStonDzbJIzTu9MtBZXGKd3gMor/uZx31y2Sbt10P+FEVTNFjiDoSyzJrdNZq3emkM
         N+N8BuPZlYTTDBTcNcnMx1WNeI94ohlLpSYUeQ48HtwcuY2c9+Br0NwVnNSxqjbI/iyV
         osssMXunpcjOiSmXKlD/uKva5o6FLyZxE8aUV8chEysyd8pGQBoCFLK5Xyww7Um4TSAA
         SeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006748; x=1795611548;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=US95disnKq9Y06aMhBRy2v7SRkguxKQeRBGVi7GzNXE=;
        b=kH9P3yf1oy03ExqB5HkPZ8Bt9mBcN8WlKX5BCDY5poEfDCVUbw0NAoXPN+T+a1zfZ/
         RB6+Eld1v1pVrVfeuLusg8Wx7dQmtGjg4eRpyMBQxnodubrdRmWH3Zb+lPB19BHMzPlW
         yyKQAZTqVN4QTwJqqW2VSJb3JbuVlGVEqp8VTbz9YOxOtC8p5Qj2Xf/AyfV6HbQm+wAU
         qUBcIc8ZzsX2ndYpP1v0QALMFmbL4y+8OkteCDjyzeIB4duPr6KB6crUlC3VNcBkvbdW
         r1VPi5/TtOe8k25eXKygmrn9WWH4cfVtonqW396FVeSDUT13J2RYV9TzXNhQzG5Ddg2M
         4HDw==
X-Gm-Message-State: APuU4Z/J+h1av5D1HQ7t/Dh9su4X31YaSuD9QyF+6oB0L1PrYaahEXmI
	/XiwbGEwfQlp765YDCg9hICArzSwsrW+ATUn7ndX1KaiyWSa1JdjLmhqLQrq5DMRv7iCLMH4xbL
	66uSv
X-Gm-Gg: AYBFou3DURzoGHc8cdMWXsJ/G+OjvfhW9GhZhgdUaF53gUYd0T6dmXZckLWfFM/wfwB
	KJ0cwAYaAc5CrSiUOINCMIHSOSH6NkJ7xA0/U/e2L9k2t/q831gqJANVInCZDSXr5z5mUy9fmZj
	EgRIdecCk4oqsJn1pU1pGB964zPw25zqW0WW2IWJ8DuMgISQ4i75YtshbvareZCcmAI+JIJUqHa
	FZarfl3pWgYDSel1VjEicLS372tXP6tjg7+c9UyM49iqLYwSBBVIeCEOJUOQFp1z/8dUl/Cueg/
	jkjyVAJKz1Tzg35lsLf5BOlO99pGXIpHcS7jLqQDFUF1a0gUf+ohfR2fOmxqCXSJjvcQUSQHtZC
	DMfiSBokZQe9VOWQBdMgtr/seBjQDhaNO1WLurLQ9Y4nqgXZJz8h8hIlmV3mAdBc4lsYRJ7csOu
	DRnMLbZOoEzksdEJvNnPaqpIk0XQe7Zih7Y/JJIq5+8FJddqTfx5HB94uMIoSZsksKv67C5dshU
	47i5aM11jJzIF6yvPiCFevsIuNnIgQMKIWzUVUL6hSHsZixBUCNL6O6EqKvm/Bh+V1V67bH6c1M
	cqtH27ZDB+Do0HxA4PsMhg==
X-Received: by 2002:a05:7301:710e:b0:36c:3b8a:8090 with SMTP id 5a478bee46e88-3827db0e75bmr2680432eec.2.1795006748043;
        Wed, 18 Nov 2026 04:59:08 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bbf0d6sm7980437eec.25.2026.11.18.04.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:07 -0800 (PST)
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
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC03LjMueTogKGJ1aWxkKeKAmGRl?=
 =?utf-8?b?dm1fcGNpX2FsbG9jX2hvc3RfYnJpZGdlX3JlbGVhc2XigJkgdW5kZWNsYXJlZCAo?=
 =?utf-8?b?Zmlyc3QgdXNlIGluIHRoaXMgLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:07 -0000
Message-ID: <179500674723.301701.5763504586143658977@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
‘devm_pci_alloc_host_bridge_release’ undeclared (first use in this function); did you mean ‘devm_pci_alloc_host_bridge’? in drivers/pci/controller/pcie-iproc-bcma.o (drivers/pci/controller/pcie-iproc-bcma.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pci/controller/pcie-iproc-bcma.c:72:45: error: ‘devm_pci_alloc_host_bridge_release’ undeclared (first use in this function); did you mean ‘devm_pci_alloc_host_bridge’?
   72 |         ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
      |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/device/devres.h:181:41: note: in definition of macro ‘devm_add_action_or_reset’
  181 |         __devm_add_action_or_reset(dev, action, data, #action)
      |                                         ^~~~~~
/tmp/kci/linux/drivers/pci/controller/pcie-iproc-bcma.c:72:45: note: each undeclared identifier is reported only once for each function it appears in
   72 |         ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
      |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/device/devres.h:181:41: note: in definition of macro ‘devm_add_action_or_reset’
  181 |         __devm_add_action_or_reset(dev, action, data, #action)
      |                                         ^~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:3ca158ae3a57af4a3c6414a5ac37293670abe402
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  be4dd9d66786975bc12243b4d744f97150649f63

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd94b099c74e1a997d498c

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd94b599c74e1a997d49af

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd94c399c74e1a997d4a88

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd94b999c74e1a997d49cd

#kernelci issue maestro:3ca158ae3a57af4a3c6414a5ac37293670abe402

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

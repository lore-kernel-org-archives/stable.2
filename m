Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006756;
	b=j8RifT+n6Ez42zQrkn2yQB8ce+9R7maVMbqZpOo7rkDIX9vb5QTPnuCwyzX8DCdjw6oB
	 5vMqzVdNeLOLldXlVGMUOrbZNxamSEo+hYyg6w0YpkT4iD/SLT8C7uFo8EnrLvZz+aShs
	 iw3kJJ0km594CSsASOW4ntnwJjAIzUPf/mcUeRechF5fXsDv2Mf4ggjporwwt/xwBpSl6
	 fmaAydxzTWUazsnqP7OWcazAfPUi8HJVmtLRTqoYMotqARF1yRE8IHZbcKunGEPD9Y2bM
	 CzHIYlv4xbzK6d2ppvUiZJYg+TkMJN5vSVPoF9nawjk47DJOZGVqjRc6sx8JIljuaXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=jTcJVFjjtZciZVLdJ1p2wrUvu580IPCCbus7Nzk1PIw=;
	b=FUUut4zNLzM0ttR/+czwJrdy96GJ7aQS/YYQ2h0XfMr98eDimNBf7zdEOnBPIFoLo5+F
	 91BdakZf2aE+0SaClqcNmh8EDuhC3v6CKyIIxm99JamBT6fhzzgfuawQbaQ8bbs8FEnpP
	 KCEqYPCNQa1guElSb7hiNlwkwm92OzqsBe6iX3wExYJU8L5B1JV6ZTQz9Ll8Eo3xFrPw+
	 w9B0wrZcmfI+e8uSk6yp/IJkiIezN5mNdiual9epD8Ue9GEZZ4tAcEE5JabcFyYxCk7Me
	 iM014uqsIw2lQyFYw6W23AZzX03itRohDE56srdzH2053aqHvZVcQEuVXgH8JHkmx1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="TqWGk/8X";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D938606A331
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D938606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=TqWGk/8X
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-37198ed3727so2419048eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006756; x=1795611556; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jTcJVFjjtZciZVLdJ1p2wrUvu580IPCCbus7Nzk1PIw=;
        b=TqWGk/8XOTq7tAOHFeHeytSjWvS2oeD6qfcxgQfj7/+BjBVX+g9XJnEkyWWgIPvnb3
         iUz2j1WLqrAR2AUCks+KJNilmZdctMd40hBnRmm5+vzkdjpjAuRhquhgwFgYAHMIV1lD
         q/YVmT1AItQq6TUEzjnNocQPX5rAjEWb8OYmPjxk1mgYHzpQeNMchmMu1zGNG2tb6Dxc
         LOB8yAf5vPBb+6TexeOgD9XcMKCFJ7dNXYhnJ5ttkTclCxcZz3C6VNef/HKYUusl8hxB
         RTSptiCRaCx4qt9RFIE6kMzvvlSoM+CeiXXE/MZmUd7oiZ0BwvxH8QBfPB6C1jROUEyX
         6VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006756; x=1795611556;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTcJVFjjtZciZVLdJ1p2wrUvu580IPCCbus7Nzk1PIw=;
        b=yvZd0UBkqQzAu+GwP71/mHejtjEuyHZJJLuBKzR4j0wPYPNfZBFEGuf7dQhKtDhstc
         Ykw12nEh/+vYF/8nQrOFcbrZFyTeOmmEu1EAPmRzWE8k+rzFy/LtyinnUdsTHnDfQBj9
         fSrDXcGq+56ju1TGBDGyYjP4OCh3ZioW6dTgfyfoY541TKT5W1kigLyuzX7xGKb/pp6B
         wB3mA99Nw75d4NQTUe/Oo6EoAG+20GgABhg1WtK14gDw0+GaDp/5Zp38dO6ZH7bcdofT
         2dgOXw3/dxGsjJMGOZBfAuvVhNliVZbkI6M559K1BNDpOnWqrO4Bwg61V2QrbVqN6WuA
         TKVQ==
X-Gm-Message-State: APuU4Z8LvSKLqOqoecrYNiwD91SDegR5QSiB3kOh2xoTqBiXaYtLQ+ti
	1g5UyDTTjDw8TDcXm5Jpvum0sXpMFYt8JGV/NjAH3TrqWEDJVd9RNXe3IlzsCfHNe54LiwPSjC7
	MyFVZ
X-Gm-Gg: AZFdTZekOdFX6BZHAxLsuYPGUn25ps3RXhlvZaOkHdv4nItLjSOA53RnsaiS19ooNgP
	1Q7rfA3l31JdQezbochswXoWtCsKLauUmFptypLUuwlzUI5OglFmT6FGKgExgm/lS0S85x3bPm7
	k4QpAbKqedUR4iX6sC2xuXn+M8FwxsJgE/IXeMNn9mV9tU4T8XaEpGN25v2XCxZAbmUbPuhdEhz
	Io5J20mwWL4GgVS5/kZIRxT1krKi+20CZv4CB5yytao0qLFsJZu1EV9Fjltc8jDCeIUsuH4BjJk
	Ql7Eftm3tWHpwIyw8H9cArDTbcSwFPVrnO375y4PIrHJFsB0lwT9MZKgHuOFZvV3fyflsjHxMIG
	rZqjwqABdYXv3WobENreUXEmz+ndyJvz2RTJP3BVQsAgiHlTYvEpvyYFIdRcwaBX8NY74Gf31YB
	/wGg4/JoCJ6FTVyoYZUD3NZZm4DyG+id6p2M8pAJJYs6Z2j1RaqGnHnkYBHJwzOO53VMmtdc5uy
	R088Hl5Gjn88IjQUaukZ214PvkJ9c5fKfZfeMmnXHthztlHGVts70vUAZMAkc6b5JxHmlNN4aM2
	3+TCpzWhGHg0Dk76o7eFEA==
X-Received: by 2002:a05:7300:fd03:b0:36c:dd3b:a3e4 with SMTP id 5a478bee46e88-3828026db4cmr3212107eec.3.1795006755646;
        Wed, 18 Nov 2026 04:59:15 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a630517asm8084396eec.8.2026.11.18.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:15 -0800 (PST)
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
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKXRvbyBm?=
 =?utf-8?b?ZXcgYXJndW1lbnRzIHRvIGZ1bmN0aW9uIOKAmHBtX3J1bnRpbWVfZ2V0X2lmX2Fj?=
 =?utf-8?b?dGl2ZeKAmSBpbiBkcml2ZXJzLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:15 -0000
Message-ID: <179500675485.301701.7270809904350761026@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.1.y:

---
too few arguments to function ‘pm_runtime_get_if_active’ in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1694:15: error: too few arguments to function ‘pm_runtime_get_if_active’
 1694 |         ret = pm_runtime_get_if_active(base->dev);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /tmp/kci/linux/drivers/dma/ste_dma40.c:19:
/tmp/kci/linux/include/linux/pm_runtime.h:76:12: note: declared here
   76 | extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/dma/ste_dma40.c: In function ‘d40_hw_detect_init’:
/tmp/kci/linux/drivers/dma/ste_dma40.c:3305:32: error: returning ‘int’ from a function with return type ‘struct d40_base *’ makes pointer from integer without a cast [-Wint-conversion]
 3305 |                         return -EINVAL;
      |                                ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:bb62aeb462d5315708fd623452f6f98dc33ed1f9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  80555b0524e00b3e34b4619457160cbb971ec8e8

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd916799c74e1a997d386f

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd915e99c74e1a997d385b

#kernelci issue maestro:bb62aeb462d5315708fd623452f6f98dc33ed1f9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

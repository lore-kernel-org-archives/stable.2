Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006754;
	b=foe5CRJuJYqK8426RwaaTELdOJLMR0gk++/hMWio6KkGHu4EhCdNu9JmIyat9rfCCh0y
	 6dxxR/3JiXyRdy+bNAeDMNhnguupaAbNc1ZZ9FFO0Iw94D14HUA8dcNNmDQn33/jsnxrk
	 tqWZ+CBaAPhgzmhm0iU6ITjyFIPyUQ/799OTprLIenipc/x+AbNSqxOjfQ79Q5AfIoM9h
	 Bw7YhgRGpv7F7p37ynADtWDm/txX31BulppK5Zptm6sWezTBO/jRWaQVdlwJd7MHNy3EO
	 o0pnrzms8RT/miXh85zprFWZt+Lyuw/5ybDw94Xw21gHTM0mElIKtoM27gYe0fAQHvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=8/uAkne8k0EntXUzXWcitUyI25VK6DxjgSCozFyEnSU=;
	b=w7m6G5fzAzvXF96qfYx5NEVMHiZO+MbUX8Q7EmZnVL0GptMXrfS+MxujlCOJKin9amDY
	 hYZcE1h6dNHnORfdUZIuvAIewQWWNMfA1TqsRolesiJwaGz78iGCTRnstIpcCvqYVpu0N
	 VnRIM3eqFzzhnqLlvD3SBMKQts8KHqMzJ1Am7x0i4WfmIGisYY0+7NHquYuHrXEEZpXua
	 hJWgYwIUKrjud7QFcfUeHqmgKuZVoWN9BjdWrY+doPxbGr5Ym+Vl5vEsVd+QqmsXjZZa4
	 QJWw6dH+Jy7rj/Z9/Rc9tqHJedB216H/HS8YhPsr7vloEt4Ux6lgKI5BiLEhdHETM0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=PU65afpD;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92713606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92713606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=PU65afpD
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-380b40319bdso1464388eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006754; x=1795611554; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8/uAkne8k0EntXUzXWcitUyI25VK6DxjgSCozFyEnSU=;
        b=PU65afpDiH2tUwJT8GYPxj3uS3xugZXNmhGwYcSai4jMykQ2KwYQX08GWN342MmTuC
         pDMHXQePS37SX7iXBrLVS77mvi+Jrpg5hrOKf414ZkumAddhYW+X8jplQ3qyeUhFxtVK
         qg3T6jeWgEwjf/6cpjRCHH/aWwWS/WRHpsxYZnVHtHe8v7Z91TfbeZtzQmshK4lfFcoH
         2xLX3bVhRDYZmPA7AaHGniGCPZvTlB+Zh3ad0VGNghrUmQyxDzD8GQ/2/TfMOnMt6FXO
         E/tMzks+P8iRHDlyUd0pjPsQOgFqyuJNdgzDJLwDz35tm/gHR4NP2F1ZpnX9J06caLRA
         PSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006754; x=1795611554;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/uAkne8k0EntXUzXWcitUyI25VK6DxjgSCozFyEnSU=;
        b=HNxwg0qjCpCkBsmgASS/3XGpytLy7uSjaFEPUZ2b7dkgsEqbl2ELns09+b4hXaQdXo
         RaQ+n0dfOEmRMwiP+2Jo2cVNwwt4Tud6rpclug3IzWiobsIt3m6ud1STykIkDuHDsotC
         N6OeJJ1i7hhFM67GACtsIeVwzFEpqgICjiGt6gftjUkiBaY0vER6maNVgXDllqcLPqc+
         6rmGp6guRzI+U29GBMOL/oBMD+cUG0zMfIuHjVrD4sFeoYspdbwtvGo9PRYlFvDSELCb
         p0sIGzcHgBMMuoJMRuUvvUpuIEq69OK9f40g7W5H04XUyKFWrQ2U6sU6SgbgnpppHY6X
         i5QA==
X-Gm-Message-State: APuU4Z9lvF7Us5glIEZIQ9ZarVz15IJbG3DhT7+A1+0cL6tGne1RCWPD
	sDFXr0kSacLKhuIU5Ak+jrJrLNRwNaWDeSV3cTvu/k1Tsu4LQkpMGR6TCbgCtUsSfHc=
X-Gm-Gg: AZFdTZc4APbhYv5FxZYE8CyeA8dJvWefEdHCPV3O5pR1aHcM4JWxRNtt3RVQSsz94E8
	gkAJVKiKY/L9ioc6VXKV1ImmthPKgLVWF+qAQVz0zeGI5kJ/6qnFq/iKORZmu03EttriMNvK1uG
	js/ZRJ5INtpXQWsGBbzgp1PPzkti/05lnnvbWRzYuhmqlZqRyztsEMTvJX3B9/4QnmnpdyCTNi0
	XYcJc1SREqBHRZEzj3XLg1wonU0US/jXrvLdQh0JStd4U8qLZSAfAKPOXL9tXhXf3S/dVLXcvJu
	BXMlqQGjFZokDgQrLK2q5VP5A6p6+oXbSCaobk9AQoDYrHewcmqW4u0h4o8vEeUqtpLni0/s+iv
	geBX2imHs3JNh3AbsKhRZQ9LREwU72gHlRsbpaqyaJqBtlCzYIIOT8n6Kd/RZp8F8XcfFmCv08v
	5q7hxOM9mKLvZ4yENN7CoXxhxzqSaoOtwg0C/7oli9MzJ6ydWXU4Qutb/ELr7Ql5tQiUwCw8vQG
	apNYfHT7q2EidpMCiRjZZQgS1Z2R43BOSRUNkj6c+4dVTbZ5DOmu4ggcyQts1Ti4ayCJ2u/DSiV
	DPTSWcsjlLDZCQ8L2DXgabQ=
X-Received: by 2002:a05:7300:c00e:20b0:382:f0d4:1e77 with SMTP id 5a478bee46e88-382f0d4210cmr1559204eec.36.1795006753276;
        Wed, 18 Nov 2026 04:59:13 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a73e0aa6sm7894727eec.19.2026.11.18.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:12 -0800 (PST)
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
 =?utf-8?b?dGl2ZeKAmTsgZXhwZWN0ZWQgLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:12 -0000
Message-ID: <179500675212.301701.8262514497119491246@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.1.y:

---
too few arguments to function ‘pm_runtime_get_if_active’; expected 2, have 1 in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1694:15: error: too few arguments to function ‘pm_runtime_get_if_active’; expected 2, have 1
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

- dashboard: https://d.kernelci.org/i/maestro:02b2acf6c5cfe769de2f75185c8d473200fb618d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  80555b0524e00b3e34b4619457160cbb971ec8e8

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd915199c74e1a997d3841

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd915599c74e1a997d3846

#kernelci issue maestro:02b2acf6c5cfe769de2f75185c8d473200fb618d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

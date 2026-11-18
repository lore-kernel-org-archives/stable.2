Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006750;
	b=fPsSAfbf6z8+xTp9gGqOk+wVrdgkh2r8EVvBs+UIJNisIhkw/d3Y9eZSFz/gZY3WOiEf
	 YS9eC9eSo6kdQ6OuuHWEca79fZ/4YtmDCJPWLkK5dLULh+EGxru1w+T9Gtdg24bBr1dsQ
	 pafGmpJbKXkVbYYPwO23sCBc7sqh+N8WMEdYA4ex5eq0NeZY86oNOrSQD4pGSCbrJXPA4
	 HsvBgkpXPKlKWMMmcgHI9n2Eej0ByuaquBdBrTYmjY3aHYJ1X9RraX/LBBTkj7eFD0kZj
	 R6e0M76YJaHKq404MAg0tbLxaCOqG7SlsXPFWY6dMp2PGYQkM1fafkY8wrGDPZcNhSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=2+5pUpzZHCLjpsUCjUA9iWdYVx3Ttz1+mH9A2uOw8mc=;
	b=YgFTFRwCnPmkM02hHEksPXgIzvg3JN5udMY4KB5oaO+sVQ5l6rigrOT7VMqqXjFKuKI3
	 dl91BOxx4tvPg5EFfhowApkpNOybZ1tAN+56iy+6uyccAZtBeWC1McEPgRxkYm2Z4oqp8
	 TKlGHbMLjB7wNDGELP+rWVGyvylBZeLsKgllzUyh6AXXfXGo28wPUaq+OkTGAaAVk/kKv
	 z8oil8lgYtN1TxzQ4m/hwc0RVvc333ougKxJ3VFbHt4k7GfqM2N/Ztvy1nL9uAG+nIk22
	 vQUqyEJWzC10xtHBc4RdQlbv3Q++WzYT4YZVW1o+BY8QGCh2I4U9ORSUQ5dxO5b1bZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=QrxZ0esC;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7F606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C7F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=QrxZ0esC
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so1774618eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006749; x=1795611549; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2+5pUpzZHCLjpsUCjUA9iWdYVx3Ttz1+mH9A2uOw8mc=;
        b=QrxZ0esCaaY91PXzgM8bvtnnCqjPDP/XpeekOwNojo0dWsg33BlXhK+WPaWJ9861OU
         0RQT0dK4bUyXN/o76jXUlTnSzgzaemnv0fwdqbdNk8swCpQwL4l0JgmiFGacNzfabFMv
         P4DXWfrWl6PZ0Ckn62nKuujAG76oQpBxYU8XuSkFvB8kX5Vq9VvInmvLQPa7vj0au6Rw
         uXfhE87bzlVssEOEQGstTXLx5aYwz3Ye9fthxfGYJT37a9I0xLia4ZscZ70be3mBDwRk
         t9psGG6hnVZ0xZUG5U1xrd87ay+Q+60cfykL0GaUi28EdPFM++m/2sylfzadaqvF2rKt
         NQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006749; x=1795611549;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+5pUpzZHCLjpsUCjUA9iWdYVx3Ttz1+mH9A2uOw8mc=;
        b=K4cHOWbwT/33cB5ES1Lv/clDdr0lCc4HGNF7b09GZ7EMNplIjVQ9uQAPBOZVEp91k8
         l8w9ZOenJeTPPGH6V5Yrq2LD8T+NlZIMRkZCBenIIjiTWf3JNR4pbM6CxHWsZ+B07kJp
         OWlHx0tkkVgDDbRU5/QWxEQQmaRi/YkX8CleNJA1FCfumEqordnABmhHBlfcynK+I5oh
         NzY1IsHnh5uXpX51AiBdjtfMxsuuVjEr5bTfNXuWWNcqAO0j45TZ35utSEruASrjzT+M
         qF1ctHH2Sqz7V7R0iZKCtEDW1JiaWV1rXpdJGlnNQZM0+qmXYUI/VhG+XCH0gyJkz2JP
         Y16A==
X-Gm-Message-State: APuU4Z9C+ZxtfSATEFrsh5zID9C5khHBJldk+bxM6YXQCAzbAzz50zdg
	gKiM3b+O2kIb+DRtu844Oi082wEhOe3TPyitf5yDtjjnNhigBkeB648F8WHXlMzMm2kIJAqIYTn
	Xfbvq
X-Gm-Gg: AZFdTZdyNbcT0dYiE+22xyOMJk2Yhy2t1igKyiMNFoMrOKGaQWXIHG7Gj6p5Tte7MzD
	Dy/YaXlCjIXoibyngNdSFj5eljX+lhsjCTuaUQ0i747Ka9qCvguRHtAcbcX+gbUyT58xm2X+BZP
	7nmdJws9GqtZjDun3k19+mzztrdFhQt9W9nSRqj8pFe+jwTZGd0xW91EAz14Ro9JQrRJUxUEIKM
	+gw5E1iHD9hjSq3JyjdnlCpRz+SxLiPn/aXrCPpaYKDiz3opWcq9XB5vRSPo2FYRaZuJFC1o/uk
	Cjmo8ass2FsZYF3Kwg9gOFEVNBhZ1EOeYXBe8NClDY0K04m152csntdpHYkzR/x7rpenSWCKuy2
	uqP9YaiWR/JolBz7JjAR0JHRuwzT1kvVrZnzKK1SwXBXnerG8SRd+xE8k9s/n+GN2NHEG4ogAyQ
	+nS6lleLq8EZvKlHoYAt4zDDOSFOuH6IhFsvTFiotSsTYMvKfoNXqOQGPXbpROamYWgxPFGrEyV
	M0m+JYEfPXd+FrM3k7Q6QplzVLx5O8qJrBZWmppB3YPOxP3h2cw6qeqje00lNsKc00OFvFNkwfN
	ZtYuq0csK5YFyZe0tKRkFA==
X-Received: by 2002:a05:7300:2387:b0:381:2114:99d0 with SMTP id 5a478bee46e88-3828181007amr3200504eec.39.1795006749372;
        Wed, 18 Nov 2026 04:59:09 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a75d401fsm7775688eec.20.2026.11.18.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:08 -0800 (PST)
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
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZClpbXBs?=
 =?utf-8?b?aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhzeXNjYWxsX3NldF9ucg==?=
 =?utf-8?b?4oCZOyBkaWQgeW91IG1lYW4g4oCYc3kuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:08 -0000
Message-ID: <179500674821.301701.12417316167556561527@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.12.y:

---
implicit declaration of function ‘syscall_set_nr’; did you mean ‘syscall_get_nr’? [-Wimplicit-function-declaration] in arch/s390/kernel/ptrace.o (arch/s390/kernel/ptrace.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/kernel/ptrace.c:353:33: error: implicit declaration of function ‘syscall_set_nr’; did you mean ‘syscall_get_nr’? [-Wimplicit-function-declaration]
  353 |                                 syscall_set_nr(child, regs, data);
      |                                 ^~~~~~~~~~~~~~
      |                                 syscall_get_nr

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:c96e931bacd9f8baac45e0782edeb0c4efb6b44b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  691938ae89f0ace741b11bd0b1e6b369a8334d46

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd936b99c74e1a997d403e

#kernelci issue maestro:c96e931bacd9f8baac45e0782edeb0c4efb6b44b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

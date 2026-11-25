Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618764;
	b=F+Wz+TbrsQo87WXVdWvGOmpoY5OpwZPgAwHWl1JdYj2hnB4MHl/i3DwIFnAMuquEGOBE
	 k7O9bk40+HaC3YjArr/FvnFM/XZzks0ln6ywlxEwkxA06u7uoMZjFNIXydfHqbv7rP8vB
	 7fER0blhnuIAACzqLz6dlxUBipJXk18pYaM2gBUhxrZi4wzmHmmPnSs7K2M82PUCk6+7M
	 2KkwbfJsRaT7eK38/ljMyTpzeawiZhewZHlG8w0aZQY4jjV71hgBfjEXERFOr0xWlBH03
	 dJIFZUZaD9dcrKVM29b5y0doTsrkxwEMboR9+zkYj082l+dObGKe/9jRKesaxy9Nz/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=S11egCmIZNf2DdU+UaZ2Mgs8vc7cLCK9qyK0d8R4VkU=;
	b=VWRCHBZogWuSkj2mMp81dkgMnEJwMu0NmISqcRMsOnKSXyxg/o2P8M39FKdwHDzxXL2e
	 dQA5cyhhEDPHhYSy7pT1uK/wxRgqPmumrK960GddtoGvq63LvhDanqxK1EoDwHhqgNq9a
	 Us0tQ2Ik+IR3wLZTmsGbARTE5bIVWr9f6dpvLkYfBKn5I3BtR2/aZdsm0gfdG+qRMdhx+
	 astjhQuS9rh7jspLIslIE0jQ52vsh87xqflnHdCtk2LAZENo8YtaDsRBiJjskyod9zRjo
	 3VFs+JueQPWKyCj5MbTuMuE+gOipr35GQrBeO91wJEDIATB10us8goiZPa4BQl0jBvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Rhnbsw+n;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15073606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15073606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Rhnbsw+n
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so8980490c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618763; x=1796223563; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S11egCmIZNf2DdU+UaZ2Mgs8vc7cLCK9qyK0d8R4VkU=;
        b=Rhnbsw+nF7f5gsQbdBZGDbgI8skd3jTbdwkq1XQIjq90IwdyJkKGBRXk/8m4n12Qw7
         BqMKXFUdX/eodODtk57rdYbsbSy9CWabU+bUgWiMOBS59fidikuvjaUjoHyqX+zha6/K
         MpeD4zy+yyMJUUPxZJ1h/wnL3DODvrkxzLAIw7tETwR0zrdxRUeIllbnXbcqqrOWbHbJ
         C8YJT+PAH3IHGbtENhQlZdEcb1kdfqIURmZ4FVwQWdMmIEo2LRju9JmaEEqp/xktp7Xz
         sZG5G3lJ4LUAj4D1OnKUHon4tAS4J5qoby++/cqWWX0Y26IuDZ2T5UWV6M1kIOrFReFh
         I4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618763; x=1796223563;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S11egCmIZNf2DdU+UaZ2Mgs8vc7cLCK9qyK0d8R4VkU=;
        b=naViG3xWL97LuIiJHumysMkjK6nh2KIc9U8rHVeUpCZF4Z7DPmYltBHJJLsNH42c7Z
         p06G5zEaOsA8ISNlSfoJkKeS8kdr2UirKOAOwAWfquSbj8UJln8uoI+WjCzcx+RnvGK/
         SUwxgNM6dJ0Ye+ZzIcu9NkEORaCEnLT1kmcSvQSTgEvvEaFNnvoPMe4RFikXEyodT2K0
         OLf0bwJnicVY7vxcwYnCO0d9S7c8Yp3WcK9vSPwEmXVkXaGM/ivqtNh6FpfceA1seyQM
         L5+oRYEtScdFSESxWswJl9EtVc67EDzDntRnA6egSSUjL4KPAGcBlDltNx4JmbcouJvv
         /reQ==
X-Gm-Message-State: APuU4Z/ssXxFG9K23rpx+jlMemb9GpD6tUDfzfcfzFTFtAksPqlkPSwo
	vL8Fe6sry8QhcQXoma85YaEYJTxsZ4VkuRohA57UnHibhCswm5Kv4HZF2NNuMvjW3UNNYoZlzrD
	K/f8x
X-Gm-Gg: AZFdTZcz7F9Myyij8Nw5c9zg1vBT51sT06iSxOKa2vGgg6JgJaBuIeDD0lUNAIo+esK
	CnU34goiaZaRRF1wPBInqewlyRk4n9+flb86ElZGGNEBv73KXlMQgN2GQqUxhUItttdESC6kuCr
	005as2nPf6zFjNoHolWw0kR3qLTBJ384xPCd6XtUykYKzscEgFPF6YhA8N2zgUJbpdlMkFJcji8
	tU9OHJ5Jc6WiXvnFb48fIS9XLRDCxoHRaLbqyH9yp6oAJ4V+seAVRep9rNrSDLgxxz5KGNOHriH
	pgS6UrTv04ZofUUBAI9XiD3PHHl23iZt4p+ydH8ALo4qWG+i6AGFN4ABzcJnHOXXLv5hMNeNYr7
	UANm0JbpGTQjTjKw7rKva6NUMTTzyWM9B0LPWj9wf1Qdzw45B/i2cF8RgHEgdehl+Q+KfB43S4v
	qD0O1CTAiNnWs7rK1PDbTfzqtv03DKJ+hYZjUP4usT2yrN7mBgrJYt7FyOAJ13gK0UF7QyQ1LIb
	yegDpVfNkzUsXHlBat1texf71HEZ+PYoUT+Q645knva94kcEdXVYpaTG1pR8X7lwq+uokOBtery
	o/bVLCN+NlniyRJt7s40qGiajqeI3S0QmPCuMgnV8UI=
X-Received: by 2002:a05:7300:cc83:b0:381:2f5d:a696 with SMTP id 5a478bee46e88-386a0ab6732mr14863088eec.34.1795618763030;
        Wed, 25 Nov 2026 06:59:23 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm67900503eec.5.2026.11.25.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:22 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)implicit declaration of
 function
 'init_flush_fput' [-Werror,-Wimpli...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:22 -0000
Message-ID: <179561876184.101431.16938579162660442035@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
implicit declaration of function 'init_flush_fput' [-Werror,-Wimplicit-function-declaration] in init/do_mounts_rd.o (init/do_mounts_rd.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/init/do_mounts_rd.c:277:2: error: implicit declaration of function 'init_flush_fput' [-Werror,-Wimplicit-function-declaration]
  277 |         init_flush_fput();
      |         ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:44ffdc96348b2c6a9eb31fa1dcb9ef9a1c73c96a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  8e2fb60ab96e45de1da9779df42907b2dd01b85f

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ee56286e1965ecb33009

#kernelci issue maestro:44ffdc96348b2c6a9eb31fa1dcb9ef9a1c73c96a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8E47DD42
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245149; cv=none; b=I2xvJtvtxQOyg2QrbQRtJlloar9YMrM7HlmCyfpbaVhFKqMzTjc62ME4dVu8DJWfn24VK+gckUVguUS+w3J5Bjjzn483f6JDxwzrdjwML2W9pdbwhio8uRChaDiatjkGYJMHI5q4KZlf4DsI8C/HEQUQqDC8F+5NauKoJH8Aexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245149; c=relaxed/simple;
	bh=pl9cPDBkc945LcOwNA4lhkiqOrN4cvkgaIG78A9S6tU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ne2oRV1r3Iv88rRznMVSkVhONC2Dxf3S/kJANgerCnHjiFnMNDKAqXnzok0uGHfxLMKyZ2IBCsMjmiqe09rDpZxAj22hLJX2mYIR0Fxa6ezOzIzsTjEX+fI76u2UWZQ7VfwTJJRxnez+KqFDVJeomM+xCbf3f9VDUw7HIs/C8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=V83U6FL/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="V83U6FL/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d049069377so1377045ad.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787245147; x=1787849947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jk8bVdqhjSO3gpYoSvjFvOD7cOC8eQdlfxTl8+km7pU=;
        b=V83U6FL/S4uT6GObMgfvx3zw3HsmEf8SP83q3Y3wZ3mwmAOppCwhn4hHnegGi5X9cg
         yMobZ92DR+CtYeEuK1qITBWgd9jQRJm6NQvn/mutY984w3spPe0jIfV3pCdl9LBPVlvE
         lM1JA8h1819N02IkS5zuuz3jd2STJPwrS7KJCoAEOoQRtx8GvFYdhFjg4r1KEc5w74Nc
         oypFl/dCmy8+v1MHz80NG8QtV1qDCq+lo8BCJQmjW5ALQ9/Ih/COXExQpAtDyVPNzBPG
         dbJu17m9NGV1mA/QoGe/3+29q91dwn//9+RHIEVpSUViK3VqtdNxOyOPB0tdT9CnpZdP
         z5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245147; x=1787849947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jk8bVdqhjSO3gpYoSvjFvOD7cOC8eQdlfxTl8+km7pU=;
        b=KgKIx09gHSJjE2FHAO7GYIyYWlCX6+99IWBdWMVxshgmMkuER3aCie+1gxiIj6PM16
         6yfbe6MPjyq/rGBEIoyiUb7oBPMZqkRxmaIGINs9TPwWT1ippZOgwn86uw1yOMFL2BMH
         UOlPsPfqStd6ApggxC2qBvT1LsvrTyop5RVKEihXmYhHxpua+7jCstRxOynBP+RL1Jj4
         WrKI20LHTIQyXcVmT8m4PCiPjfmDbhNwyiK1ByBvpMnmnFD2febTk++NLvst9xY26R35
         KsqAZMmed6MUxEJVwOIlKYFJEeqivSnS8hh+bYrwrNAmjj3sf3x5sttpqOlGEgF2PB70
         ceDw==
X-Gm-Message-State: AFuF++m7OIsr5zTJf5jLHUkQtUCBtJLr8yMZIEVGZBh9fJWZKbeXYeSV
	2HKK9fldZDTA8n7BkQeE035sPo+Fbe/JMUFB67zWMJQJ1Yt0N8rZw9VJGrrHTNevtbx92/nfX96
	eN+Ro
X-Gm-Gg: AR+sD13U+rsFR4IDI9Z8yv/EytJWvNh370wvPbWPPPvMtcO63GchF0QuHj7Zzg4XJIN
	/yWkPh6PfLyI50Iu5rK8QSkpHxRtH0up0BQu1hr147X2UwhqzKm5dyDLN4gvxRs46qgdQnDDt7d
	J/zkylIlO2Er0Sz9oTl8jCRjQlcgsaMNTVYCdcxZAyMK+xk0N9/gh9TIwtfm+jwQA+JxKPPKI1F
	L6iWvrPBXznnMCi73lMocuHY0s1/5tPZtfuOkYVC4AlSl5AvM4oOtuY3sWaTgsArAGLqU8LY0TA
	0TMXddmvoWYkqPonFRNA6z9T0LADSSY89s6HOQKPM8uYY17rk0TQoj8PPLScrku0hR512d3iUNS
	5V3yQni2zOrte7L//JKPcz2p1QHkXdjHgEkb6aXqCpadgfVyK9PTg/ug3FxchoTyO4OEijcLPLA
	/LpPx7eQXm3CQz52kxV1jO6N5X7sAwyRiDdDBA6JySvjK3Vv5pe/Iv
X-Received: by 2002:a17:90b:3b83:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-39580a4d117mr24258402a91.1.1787245147284;
        Thu, 20 Aug 2026 09:59:07 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb5csm20420167eec.2.2026.08.20.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) no member named 'bh_work'
 in
 'struct atmel_mci' in drivers/mmc/hos...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 16:59:06 -0000
Message-ID: <178724514547.764.4063567812744277543@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
 no member named 'bh_work' in 'struct atmel_mci' in drivers/mmc/host/atmel-mci.o (drivers/mmc/host/atmel-mci.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/mmc/host/atmel-mci.c:2631:26: error: no member named 'bh_work' in 'struct atmel_mci'
 2631 |         cancel_work_sync(&host->bh_work);
      |                           ~~~~  ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:a12dbce60b33151d5d4570b5c088fec74199a78e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c7885103099f7a40cdf84b4810e6283f866d7dd6

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a8712e762f33761c0f0b728

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a871eb862f33761c0f10447

#kernelci issue maestro:a12dbce60b33151d5d4570b5c088fec74199a78e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

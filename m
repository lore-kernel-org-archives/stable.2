Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1536729C
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241553; cv=none; b=GeQgOyTKZPpUtKaK3V63ilEAmqD9meBsmBrF8UCX+QqmCVlmyL4w9CicmlPYMoHRZJ6cmpF8IxWMvhedN0rL1ZRcurzKfazgFSLBpRuNSPhAir3MQpkm9pemlMJ08YzhguFDbVVcU+7ji5OY6MqBmuSpQnzdZvVaOHtjC1ocpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241553; c=relaxed/simple;
	bh=Lu6MQ3qckGibzooVCPt3MOG9NdJFH8WK5Fc+IqBmksA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=NusCZP9Df0r0Cued741AZYSTsRzIIH13p93TtXNsESu6bNQyTylZgfZeIvCw0PzAwjK6AY0y4+JfJCnrOHMjoZV8UuEzyY6MgyDoRqqjcUytAn1um4UuE3BWTJ/5FfhgqcEB6cDlqW7xxJs3sferQtGXE++Gy5Lt9b3Owf66O1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=jZPrHqy1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="jZPrHqy1"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc11a30a259so53242a12.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787241551; x=1787846351; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bpJ4hiOythIIeGfDYaV5KUj+oTLbFTt90Mxx/LKA7/g=;
        b=jZPrHqy1Wq0mRrzKdX57IKUJCSySg8u5XlJ1kKLX/HioYaq6pemmtb/RZEu8MgWD4T
         4EHrXg/eRioSULvlhIKB3LpQQBMZwZyDNd3AkcHsPCIe7MQrzQGifoSEbp1LieAk7kac
         3SeaZqYxcV1z8NzHsOEz3+aLe286oa3cEFyAEZhXZydc334Viz9oRZj4uK3Qetxi5Fph
         F8JYc+lSB0ZZdbab3bDq58pfJ4E+X8U6SnCc49mtNusT6l28BCZN1AVY/8hnHSN8HNky
         0AWGAgqSUQCZCD7XMLurWumXHoB5h9xnfES2tK2/3gthzFb5+QVI2fOYKBkLkFQLKplR
         3oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241551; x=1787846351;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bpJ4hiOythIIeGfDYaV5KUj+oTLbFTt90Mxx/LKA7/g=;
        b=CdJiFN6fCYyuEuXFSqUKHpfA6mwXY8WGpmUDvuk9m0V1AdqSDPU57fvK7Lylcok1S4
         iXTkICwVAN0VSkoXGU15gC8TMrt9Kt0/WoH73JwXAdDjmXk6mXWe2hg7BiamR/+xGX05
         p3xGJEMRBn/Fm105ZwK7jTQ8Z/wc9ZB/cF0dhlXXscl2Za0wKX8l45ziRpP2+KD+NVik
         FNJlqaOAU3nZziqEGFoY/dWAzB5+sN/A5reFkh08JY/LcDuRL5khoyHZPfsmoVbwOlcg
         Z/RnI3BWuWd/lbBkAF6rk9lCeZFP6nnGRydr9uDK2Bb/HNBdxZPWhlwj64U1U6o61SjM
         rhKA==
X-Gm-Message-State: AOJu0YyBt38p+FKB43wUpe8KpJXk+2326VX8YWCtjZZ4h9uEhMkqJeRX
	hzAvcQ38w1kfKKfZHSirWPDp7c8WXHxkDsafBRr33W2Oy/CYFWvo8RwN576hnop8NmBM1occdtK
	D97t1
X-Gm-Gg: AR+sD12qvyR4CYQfVyOIimPkHirOQK25Thb0Vu1ljD9X5Xbxh6NA+UMd7pjl/0W6488
	UiAIGb1UlW2VTf9B8mogir0GcsYucNBt69jBKJWndc/9Iv7EY20k/iC1U99oixMa0xDSfaDv5ip
	nwXyK/RqakLXKed2vQIVrRm5r4PDSkbecbcrzQOEpqvk5aglnuAL6wxpH7dkiBZ/+4JN/i0bX9H
	zGn6MGIo2VU8pMar4l225+I17d33dj5BcerWEbxPgKk1uy0Ac0gnqWN5nJCPB2v6LsEEMnkbi1T
	S+Q5EqeaAzBjjej18sq1kLQdK6Si+79aPFX51/OQPHuCp7ztal2fW2VViCcm2TC7Y4dOJYFHBVS
	GQRhP7YtkFbKnGDl7aO/PfxmMqFZ2DGOCmzqaRjSYsuR/zZvjsSpGqF6R6MsYoQ5PIuyGcmxtnn
	MyNL0wZepN5kaVBubMEbNukff0dEHd5hFhRGl6omhZ75zfx/dxXP8H
X-Received: by 2002:a05:6a20:7f92:b0:3c3:a3f4:5485 with SMTP id adf61e73a8af0-3cd00e53f45mr25492268637.6.1787241551373;
        Thu, 20 Aug 2026 08:59:11 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77be3sm17825489eec.10.2026.08.20.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:59:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) no member named 'bh_work'
 in
 'struct atmel_mci' in drivers/mmc/hos...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 15:59:10 -0000
Message-ID: <178724154956.746.2797303551549413454@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
 no member named 'bh_work' in 'struct atmel_mci' in drivers/mmc/host/atmel-mci.o (drivers/mmc/host/atmel-mci.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/mmc/host/atmel-mci.c:2661:26: error: no member named 'bh_work' in 'struct atmel_mci'
 2661 |         cancel_work_sync(&host->bh_work);
      |                           ~~~~  ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:1e3306e098086e2add933463d88e677dbf2f582b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ca37407fccb96f6ba527cc8274afa5038874b131

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a87139462f33761c0f0b981

#kernelci issue maestro:1e3306e098086e2add933463d88e677dbf2f582b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

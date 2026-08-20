Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86947884A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241555; cv=none; b=ncASP90KcwAl9DB7FSJJ6OHi2uPOV31E6OcpSbX1FonUU3S0xDdHmxdP1YJGxuVVTZpni3rN+8sCoQsVkLsnrRc4tl1qqcTjpoqD7kxv8u21iLPt3qO4j+EAWLD/JEgm1breEwWtlGrw2EERSDscVlKVC7EYh2waKlTbylZBssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241555; c=relaxed/simple;
	bh=2Vka3AzZEL7dN5Y6WjlBWxB/2THi5KWP2azdPip6U/Y=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=GT7+CSxf434EiJJmSjmzoKSdmUrF84vboCvnfY1reUerN0bP3AeWL5cLoh6S0vJ32+RkVDF+VfbO/CNBVkCSdl1wH1VBRi7ga1DDxja0SdkusEUuIL3xmqt8nhI0fhtN3XK/jSE8OsTS2LKE+AFVfVc6EDaUE4PM1elFizf+8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ibVtL5hg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ibVtL5hg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so555075ad.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787241553; x=1787846353; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SR1NtdQL3ZVORAUku5hlCbq3esKBq6KXI1AuCRg7CMM=;
        b=ibVtL5hgkKUDjE4HeDeUO0lB3HRKARpEzqg5NnT9n1tW9vwllB5gSHz8wg3TJgwPmI
         QJkMkDdjP2ry+4ohpRl8vOxoFuU9K44lnS/h66bhc1WvBjz/eChqGBYU12ikW4+YTm4T
         6UDI44p21BZMToFM70uoIpszqTkhfFLRrAYlmXkI2CEpt7IEGtc544SF9Yt00hvBv1dH
         WopAR1Jzqbof4nAZboKPzTUOziQ7VyGdIoDCBNoMLqZVz6dnZYPJbnTMNcAsJgN4ywL5
         BV3O0HpZEM6z5BjkaBg6vXXfN3Csa0cr0g/X6UfZWDzpj3M0AZH6sqS+RjmubqFbncjh
         hzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241553; x=1787846353;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SR1NtdQL3ZVORAUku5hlCbq3esKBq6KXI1AuCRg7CMM=;
        b=LSwVstqBoVVFNsUcmZOntDjJxy/VudzC+hPEd6i/1gZZcC/YM0i1gbx79RfGtHRL3q
         w9d9VUc/760ZANq8P4zTAlzCCegrVX6P5ABNdB99DBzZS9ViSK1WX1tpZTFtWXV8VTIz
         6uaeSaaARnZ44Lu+ejgeyjuWQsUK+Em3oUVM7zOyy9w7jr8NgVTzTzYsZEiDLrnTctbM
         MSFGGQWIqzJQ1IelNOz87Vpuhw6u2hZXjQ8ov+9+Jfz5gV2CJlBjL4I8TYwhWM2Dzz9s
         4Y9pdkmc5uO5Z2t84Tl8Cloz/m51Dzvhrb8TZnvP3K+ZT2ucOb6V7zHrAA7plaGwovSc
         Lj9A==
X-Gm-Message-State: AFuF++nfyy2++ZQPwbPAZoa3yQ4QeDZ6Jtdrp2mDCo4WCRGV+kS/4kVv
	1LDxeCb/6ZTzNs+gNZkDN8jn8kiL6QkyAV+5LjQ0lVu6U7jeUBnTiLmLBZbSymqeqpjHIgcaFBF
	jRwp1
X-Gm-Gg: AR+sD11YVwzoCCNIay8s3A6dgtzVZo9GAHgG7gHdXIvrs+v4VET1fYn6vhUj/rF6Gxm
	Emfj//vX0JeZuHwbU0hmCsgd8ChLqOVtQ73Oqjc7RZXdQjwzK5svM/QVZ0T6ymwA9aT+zWxu1oe
	G1l7wIMw90aQ4usZUQUC7sc39/LQBudVsbYY39qKIUZJ93z9cZftasYwJyiuD41EFi1ibO3z+mb
	OU4J156DgTYAnvOah5YP1QSpohu8pyiW66ZR+JD2NhbEj79O4HtFoOf4SvK/GVhQpQOmkc0OIAz
	i4Ps4KK6KAPCM9XB+gtKZwGHJnrRFg9G2dLwK0/vfNfUF39/Ta33anqCZQ908qPFijAxpwkVOlK
	ksdgrYPX8ia/kKifCpzjkvSLsPfl8iwwWC7FC8vjqVO72+NwiffcF3L2f/pTxWcHhz4LMFmegx8
	9/OKjwg7tiVfAjDuOvSXYBzhCigu5G/EdYJqGNYG4pvEbOzdNvOjM4
X-Received: by 2002:a17:90b:3c8f:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395810e9626mr27668355a91.15.1787241552994;
        Thu, 20 Aug 2026 08:59:12 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad699c9sm17955926c88.8.2026.08.20.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:59:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSBpbXBs?=
 =?utf-8?b?aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhfX3N0cnVjdF9zaXpl4oCZ?=
 =?utf-8?b?OyBkaWQgeW91IG1lYW4g4oCYc3QuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 15:59:12 -0000
Message-ID: <178724155155.746.8949278698222553185@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
 implicit declaration of function ‘__struct_size’; did you mean ‘struct_size’? [-Wimplicit-function-declaration] in lib/overflow_kunit.o (lib/overflow_kunit.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/lib/overflow_kunit.c:1128:31: error: implicit declaration of function ‘__struct_size’; did you mean ‘struct_size’? [-Wimplicit-function-declaration]
 1128 |         KUNIT_EXPECT_EQ(test, __struct_size(two),
      |                               ^~~~~~~~~~~~~
/tmp/kci/linux/include/kunit/test.h:686:22: note: in definition of macro ‘KUNIT_BASE_BINARY_ASSERTION’
  686 |         const typeof(left) __left = (left);                                    \
      |                      ^~~~
/tmp/kci/linux/include/kunit/test.h:878:9: note: in expansion of macro ‘KUNIT_BINARY_INT_ASSERTION’
  878 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/kunit/test.h:875:9: note: in expansion of macro ‘KUNIT_EXPECT_EQ_MSG’
  875 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
      |         ^~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/lib/overflow_kunit.c:1128:9: note: in expansion of macro ‘KUNIT_EXPECT_EQ’
 1128 |         KUNIT_EXPECT_EQ(test, __struct_size(two),
      |         ^~~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:a4e5d486ff86f71a49720fb8468c9e8489c837f8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ca37407fccb96f6ba527cc8274afa5038874b131

# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a87141f62f33761c0f0bc4a

#kernelci issue maestro:a4e5d486ff86f71a49720fb8468c9e8489c837f8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

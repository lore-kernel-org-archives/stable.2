Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851948;
	b=kuWTyM3lnWm24ZkFHtHnLNln9L7t1vMz2nIWVg+j9F+yb18NXwI+uaZrvxMgbyfCERJr
	 vwnktHC2pKJt6jPuK8QUucsycP4AGCGwMuf9rJ8g1tFD6rF2TNv7xadGPr78AlPK3u7G+
	 hClNJH8kZwZoxYic6HM8l3zS2yot/dcqFK/nHpKnTptDV9WUFOmqoCFIlEWMJPtOcwuXv
	 Rjst3GO/zuGP2ugEZSlGejSRa3C6MlYgxncRq0FmQKH0d7VJfVErXQQWK9QN2g2bOxIe+
	 r4LHvcVl/9BzCneaKT5lN+/9ekcIziiQ/mC6/Yiorrv6cTIxURzIpOdkm40moQXZTHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=wdIgM5+uNBMXad64CvLd+ZQwSVkPL3AqT7Lj1wSLIB0=;
	b=xpNkVHSaneH0D6XQBk1LWgwSAlfpBz9xYsyAztcaRNVH+eQe4cC2xBY/EkAnR7RP73ux
	 BInGXGwUhIuSFuGfGH5p8qF4/YKqGg/bkWs1EvtWgHwfIT7KFmH1w4Nd/aEYi+x6PIF/G
	 G3E8ZRdyOWrYZk5s9xdQMLnS77RJhh9xsM9xmmppHeuWEc+tKPrtvkKo7cTn9XWkRI7L4
	 WZK9tn1WP5B9BSpJrnW7AC+K57bH3AQ45dL6lw+iauiioKc3NYADOq0/DQTAPQzlRtYab
	 Xs+DfzllB/C5TeMD+7bdBQMqiZ+YPLLdx5XkjK3g/biYrlht7AGhhB+wIdxDLn1w8Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=ZRV71EfN;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3151606A884
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3151606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=ZRV71EfN
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so5733084c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794851947; x=1795456747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wdIgM5+uNBMXad64CvLd+ZQwSVkPL3AqT7Lj1wSLIB0=;
        b=ZRV71EfNoq0m0ERxyiBp3LFJbGBOrWNN+imQCI/wzInZBLB+aJKNQaL8unTAHuaap8
         2JlAubHE6c70Cr584TcJc/qSEbnnQohL6ixsprE43PkxaRpIgMfjBCemQbzdytNxZBeY
         KkJxjDBjrJqk5ihSrZ9insi+HZ0PAeot9Fp/BET5Du+x5Kd/NRR8eX6feVy2j3lKPqzY
         huRwPu8A2mH/GjXA0FNBQEwD25AeqF9NVe+BSCnIS4YN7zmF02W14VHW0TYFD240S+uQ
         NrsqohPViC2gzWQ7vh0tCfRi0PR7K82HkbRBtnaXptMQS6hXE2Dr9Wrl/aJHz5q6Clgu
         jtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851947; x=1795456747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdIgM5+uNBMXad64CvLd+ZQwSVkPL3AqT7Lj1wSLIB0=;
        b=bgYhlrtbSYqKDPyTg9gyfWKnCOOGT/momHS6dZqKa/yQkjKwzLUMRqxWxIE6XqSNx0
         /1I67CQMFS2MS4iSRuNwz6vPkFz/hF3Rrf0/CZhFU8WTuoUjV6GCNDTJBi5kNrbSgK4z
         e9oeRagDnEH8mEorPhrlaz/y1nKg/hFpyGHWqmCGqDxMFw61nO7ZSzEjqXC++KRG6h+L
         aKKcYLZxFhcJMsnRDDR1Il+MGqQuCt70rgcoMGo9UGNeS82pQVdDQXaG5dEZ6EjAnKrp
         bnQ4NNUf11dcUrIJDIF+LGSHvMIGHLl6Y3RmNeOkk/HPTZtxae3Azzeu00QAH4E4qtO6
         jkOQ==
X-Gm-Message-State: APuU4Z/lmFlpFlDOBvC2eWXqZZAvJrEJXQwg943OxfUiDnjupeYfykEC
	ulGpJgNXjrbGonytM+bT5pOnSGKz5yTgXO61V1QUHJAxTQ6Ea6T8uSOwlNc/7ghcQUS4p23PM5c
	bX7GJ
X-Gm-Gg: AYBFou0TTM8ZUhrKX2tOcoQyxzvGCceOcykId77mZMP3uTS/fap5vdVs/JF6Bhl8Pef
	Pkr43DGf4ePox7kt2W7l5Y6szLDv6vMOH/WR+lT7iOFhL9OT1hy+gBoxNvBI/YAt4I/WdKwbYvK
	IG3f9v2sg6oV0cV9vF82OsZsyGiVAsn1TfwLbNJWlzGQPkakeuW05org3LSv1+2o9wixolymxCe
	0uH1uDMb6EE7nP8qgtSCi1iVajw3MQb8uYsqwkkM0ljqZpRH09shF9DfCY8UcWTfOioMxskpHmv
	Ukv7ZwJgkqoZeg6jlQxu5pa4dD2PahLuSoA/4yG9zuRbpJyq0MKf4v1b2N5Dda8KjrcykvlFhSc
	AsWmzKkwDsZ8sQSU8+HyAMgt3JC4bUmhQuBgxjczKxh0F63MduHlAkMLDPPXhlJ1Sav0k+fj6qs
	8QJlwYA3Yd/rWQ0Zl9W2IhTFdqgcPGY1WzOFn7E8y14tKV03AC9Uxa6y6OXWlt/0l7JoVlKqDch
	Y+R++kT0LrjuMsVfB74MLopowfIgR0WBuJ0SC8pXtjD+k0VVZCgOgAjuuu/ZXsxoHmmwgrpjlbW
	Wx1oG7r3p7sSJ9+ccw3RNQ==
X-Received: by 2002:a05:7022:e889:b0:151:6e80:baa9 with SMTP id a92af1059eb24-1b503098119mr11535104c88.12.1794851946921;
        Mon, 16 Nov 2026 09:59:06 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm33685197c88.12.2026.11.16.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:59:06 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-7.3.y:
 (build)./include/linux/mmap_lock.h:604:25:
 error: 'struct mm_struct' has n...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 16 Nov 2026 17:59:06 -0000
Message-ID: <179485194561.205922.5436103613689093377@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
./include/linux/mmap_lock.h:604:25: error: 'struct mm_struct' has no member named 'mm_lock_seq' in arch/arc/kernel/asm-offsets.s (arch/arc/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from arch/arc/kernel/asm-offsets.c:7:
./include/linux/mmap_lock.h: In function 'vma_end_write_all':
./include/linux/mmap_lock.h:604:25: error: 'struct mm_struct' has no member named 'mm_lock_seq'
  604 |         if (unlikely(!mm->mm_lock_seq.sequence))
      |                         ^~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:487f404d8fbce0260a2f48b266a1074a5ef28a31
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2a640ccd9d0b0927413e9778fa8970767b7d97d5

# Builds where the incident occurred:

## haps_hs_smp_defconfig on (arc):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arc-haps_hs_smp_defconfig-6afb3c3e99c74e1a9961914a/.config
- dashboard: https://d.kernelci.org/build/maestro:6afb3c3e99c74e1a9961914a

#kernelci issue maestro:487f404d8fbce0260a2f48b266a1074a5ef28a31

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

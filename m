Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3393546E1
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203547; cv=none; b=oNIREYJdBh5st5z51boEcSjJ+hRZoITMRlwh7vVNkqVfqoRmGMiWsFSAQNXCjEDlO13leVVInbkM2E5Yce+PWGERv81HFUwL/5lSsHGv5gXeSTBzGlTLOx0q+WLjzPDx5QRhmM1gZAE2+xO+jn5SpfpTHFEKC32Ge3Xln2lQqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203547; c=relaxed/simple;
	bh=h2JFJvCYm5DdAo4bECtbnM+nEyMV2L5ujBvfxrm3+kY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=CZ98tUI32vQameBaxRgxHODdMXbYmH1Pbqp40d9hDR9NyS7AMIv2neMos/CN9gI3EcK7VEy6wRyhO5nAH29HGKlNkpykN+p7Auo0wjp+ZmlxTAKy3tHHR/DW+4SddXoYqgJ49HDsHuIzpNLuNC0Ou+SOtLpIgPO9jwe5KfxDNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=gvlGtLYN; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="gvlGtLYN"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so231193a12.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789203545; x=1789808345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iDeGp6RuIQ0n4MXZr4ulxpcJhgWEAYWfy0HNERyBbWg=;
        b=gvlGtLYNbNU5XUYQMvx3lOsz9lnKy9ckXgK0iM1EbF2lrM9UZYp0u/f63r+ruKFI9D
         Bej+kYmOWZNl6dyNdV9cWdiVW+qAr3XOWVhy4xA2yR+4MVn7PORvbUmo7YZfxGSvrGXg
         6eWnLY3cN+USyDB9a6kIp3/PsswPtL1YmENYQgWNQSBXo3V/JBZ/ZN+njbSQNdXSh6pM
         VNgNrGckM3XG5Bqv0TuJum5iN7E5fEzWuiaTP/5Xs16EdKG2rWRtB/b1i9fOW/wKEoYV
         L9274XXzGzsmKPrgen2n3cQdLjLaFO7GFiD8KKovxRwRQ5IMYs0jUVHfIdFe8+Cd7YkJ
         yjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203545; x=1789808345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDeGp6RuIQ0n4MXZr4ulxpcJhgWEAYWfy0HNERyBbWg=;
        b=fnEIGTCqKp/rvqf+GnT8yEsuZ7ab6Gl+Jp/m2MOEKfj7qJ2+UJlc1qFzCv/7PAdIAF
         QifrRNowcdYD0ZufqtTz4dzIVmsNd6w4rZsHciTS47b7EPcgYV6FV6lIts8U6n74wT7P
         dZL3AZ1SeuDIOdk8huy+EeJUHf0o4JQjjWzafPG3g4BTylU4IGoPlRS42ltXB2I6hzQX
         nDQ52uQxNyaa9E+hGogKkVAGK9pj6K/MfZMWhC5mNAfqz5fHrvyBWgBJzuHYP4AeJ3/K
         B3zXOp1NzxxyViOqGlHhaD/G7j3VUEeK6fhendqpPBbEuAsOCWcaURXsV59iIbNWVZKE
         eNPg==
X-Gm-Message-State: AFuF++mLztBi3/Ts9s/EreVo+taRA//TrwOnlC3qabVSs2SdmEmJJCj3
	zM5PQ7Ym7jQv5/KhOsgynH8pJCPySa9Z9+BZkxJ9yu4sVntZLkIETyGYBG7jo4z46/KwlcCyOAa
	XJttg
X-Gm-Gg: AYBFou1PhRyJkT9+eK7xIO7OfdsprN9Zts7/ZaKUyC5I95lwUY0SrX3d0pGqKICuKTm
	D39KxWPedVIJm50ajsGEUp2l2Z27bm9LPEzYEEh/+UDrdEtH2dtR/jeVBoWqn6aWIFxaMsrJGTs
	klOVeP+KU+cWbSr0A4cWqKmrcxh2H9xg41rDHU3UJrGHjpqrAiJMf8ztFi4LtTyV9QryTk1YJ2w
	kpJiuZCw33BWwmtqCmoNroynLQQHoFYxTNWB4OpMf+ibHDKRxvnJzR+ib8ZeZ8O9P50dAjNa+RF
	THnZ/bxvtpLjjKOkj04cdT8/h3uvfTZFEUMv6+7YHOIC9GRSLykTeKVfmgtx+Rvev5sIrmC3iIa
	qYPZEtTKq/D9RkIfcK8fHIe0LQRawV+pKWUy0e1YEi0W/LX+Nrep/uquUIJFXMCrOicdSyD43sc
	CjoAuBQnHf5Iwlv2so0qxWVQQqlk3IImJTdu7Wpb4mX93krcJUy+3ApE+RYZ7lQCA=
X-Received: by 2002:a05:6a21:a07:b0:3d3:ad3c:49a8 with SMTP id adf61e73a8af0-3db0e425b50mr4219901637.22.1789203544800;
        Sat, 12 Sep 2026 01:59:04 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4efc398sm13876680eec.19.2026.09.12.01.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build)'field_get' macro
 redefined
 [-Werror,-Wmacro-redefined] in drivers/...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 12 Sep 2026 08:59:04 -0000
Message-ID: <178920354396.4755.13965862132671332154@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
'field_get' macro redefined [-Werror,-Wmacro-redefined] in drivers/clk/at91/pmc.o (drivers/clk/at91/pmc.h) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/clk/at91/pmc.h:101:9: error: 'field_get' macro redefined [-Werror,-Wmacro-redefined]
  101 | #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
      |         ^
/tmp/kci/linux/include/linux/bitfield.h:251:9: note: previous definition is here
  251 | #define field_get(mask, reg)                                            \
      |         ^
In file included from /tmp/kci/linux/drivers/clk/at91/pmc.c:19:
/tmp/kci/linux/drivers/clk/at91/pmc.h:102:9: error: 'field_prep' macro redefined [-Werror,-Wmacro-redefined]
  102 | #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
      |         ^
/tmp/kci/linux/include/linux/bitfield.h:231:9: note: previous definition is here
  231 | #define field_prep(mask, val)                                           \
      |         ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e5ae9fcacf3ab662df91f46f2d73b0b88b633d6f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  e7fc367e0480287d71df5b1cfb47537b592e3dcd

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa5056f20239ade9028f897

#kernelci issue maestro:e5ae9fcacf3ab662df91f46f2d73b0b88b633d6f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467233FFFA1
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149548; cv=none; b=mmxOhUKGq8fSrk5Q4Ods7X+KZjgUO8mlpK8hlLNjih8LyKgHS15VWBu1cHsI1Qkj4Mj5nRpsge+eaFzBAIKh5YOscihH6vQYHpPfEFf0T2TIIFcxNi7X2xxWfLILTSo0UqIUBih+ffJjYvKp07yg+wV5znfAymE0WhxBkVHl0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149548; c=relaxed/simple;
	bh=x6m73ZcLhWoOlEyU1CN5Lu1TFGmeQYiXDjGqory8Mfg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=kSS/xAMHyHWVXrdkOofehxQWMtnbC1XL4ohoEpRAr7LE7AFicdEWkZtVKpcB4lDgL4I8lS8+XY1QRiCUjy44szk5V5+HT2XxUwjIphP4hWU7usexn4b9Y6Y7TExS6I3WJnHi26KZArRaY2cetfaPY7d144L8jIynty0W9D63AqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=jhcz1qA+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="jhcz1qA+"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so945531a12.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789149546; x=1789754346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EARKhcdb5qqNnALLHQ3ulccRqhPUp7fuFHAjRLg03Oo=;
        b=jhcz1qA+ypwDmpWlcIP+1OfoHVsRAgSRKCSHKDaIkBGtwAg9ejAPlPyipsx+pa/np+
         ellz7jsTj5HPaOq+e5XRig3wL4rhw8w7prQoZD7V/Y5iwinfyFCAFlbdubjUTvC2IoDz
         Zps3PscDL2pIS7ZsqwA4HuD4Re+AorpVz0P1VSKRHpv9fFc7/TIJoXPu6Se4zk6F78dL
         0BgUYglkPzEKXbUDVL1cnHMKXIHGxMXnWQDVHl4bIeIqiTdcs6HU3PoFwuUo1UeBkHFs
         nD8JS47RQm6k2Psy5dEZ6XFd2Q6oRj0x6PrKrBh0dIz/tSlHLfQDm3kAhOsBabCD9agZ
         cFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149546; x=1789754346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EARKhcdb5qqNnALLHQ3ulccRqhPUp7fuFHAjRLg03Oo=;
        b=PHtrtYXhRmd0RHuJiVrMJw5tq/i7sJF77hTQY6HRWHArfPKp3rbESb2mOzJtJLBdvV
         06NMj+iH2QH+moSkzTL6ri0cbUv84GZ1yBfL2IB2VehLr3UfKrZxoQkVJD8HGVtGxD/q
         osbR7tJxu9c2141iIpVWxoD4j9tF+4IfmGYJ3kfCpAeSN9OmW22dRbc5lApjfmWXTvrc
         any2/yQloXtamtIJ0aLHza0RavW3ORuzB/lTwjtPHJkd7+GqAhg1qtEjjAQ1zRlqrkpi
         ciXLFNu14JBYkVPs5JwUcwfw3+CjRp+PzH3jAlwXAIcFAhUBLpdD6sm2BumBly6RzGKu
         Xz/A==
X-Gm-Message-State: AFuF++ny0oEspwVxhLjZm1Cj8NeNw/WwRRPVwFSJUV+EYdPmgVgogkp5
	fFmCJXH8D/3nnKatxHtf5GQR92k56soCO8t3+sT1b3pS81nkm5Rz9AxlqIT1EEZRzqR2UnGGSId
	6Iehy
X-Gm-Gg: AYBFou2ZwABDowOvtvlE4FlF1BNy7QyHPqVw+V7ufkZiAR4eYh6PlyUt/n8Fk8bx04f
	0xMHXuQBCMX9hc6KwMJPbWrnPFx3cLnEe9hqM6TypV1+k5vbA2TeJVgIHGuPLvLXYJenlFSz2U0
	YFjS09ELgEyXD/wJ2ok7CgqnGjJvxJdeGWGXXBbQNvHo8Jbn1+cTzeeK1vaW1In/MDyYOMG9n+w
	XIL+c9ado0i47BHJYZMvprVBuvWZyh+crKpyERdv44aG296WKkhNJ32GW3jxPUW3IKVlBlTceXh
	gbq0w+H/hhevpy33UIThs7Dx2ZwrH/8SfG/ipDdpU9/keWz+pk0xTPmC+/v9ecAoP7Wb67H6z43
	OZCNt2xw+WLI+J09el4xQ9lTm5cfPYcPz5c9gPQpCzBhmu5QKzd8VXdMBtRpFIHywO5kpZsoEYM
	hULtlM85bNaO0X8UdAeVLsBR0AkqFjg7/Ad5FExQQpnDGIMZBtX525T9UiNJuaZg4=
X-Received: by 2002:a05:6a20:be8f:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3daed424d01mr11630266637.26.1789149546348;
        Fri, 11 Sep 2026 10:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b345a4sm7771049c88.5.2026.09.11.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)'field_get' macro
 redefined
 [-Werror,-Wmacro-redefined] in drivers/...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 17:59:05 -0000
Message-ID: <178914954497.4461.14819014430394217357@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
'field_get' macro redefined [-Werror,-Wmacro-redefined] in drivers/clk/at91/pmc.o (drivers/clk/at91/pmc.h) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/clk/at91/pmc.h:117:9: error: 'field_get' macro redefined [-Werror,-Wmacro-redefined]
  117 | #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
      |         ^
/tmp/kci/linux/include/linux/bitfield.h:254:9: note: previous definition is here
  254 | #define field_get(mask, reg)                                            \
      |         ^
In file included from /tmp/kci/linux/drivers/clk/at91/pmc.c:19:
/tmp/kci/linux/drivers/clk/at91/pmc.h:118:9: error: 'field_prep' macro redefined [-Werror,-Wmacro-redefined]
  118 | #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
      |         ^
/tmp/kci/linux/include/linux/bitfield.h:234:9: note: previous definition is here
  234 | #define field_prep(mask, val)                                           \
      |         ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:36f06fa1a4ff538d0dee7315f7a720c23d34326b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9f5e4631f281f1f3c92f33dcb2dc004f416196a0

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40b5420239ade9022974d

#kernelci issue maestro:36f06fa1a4ff538d0dee7315f7a720c23d34326b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59C4AC163
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149547; cv=none; b=EIilV97c7rczVlnV4Vnxut37v2aq21Y85jPNhyprEucqrCmwoWJAVu7PXy1tv/cSWbXFGvVU6CKdWCBM48X7SerZM1r+qJG61tqRw9tqQlr6IWo8ypDbgNCejS0HQNdv7+CZuq2LG/bLFBNhNNaqF7tCTXYqgqcBxV3tqXqpwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149547; c=relaxed/simple;
	bh=sNa9zflNRL0W3vNQk8AM7JQxBwY+PO6fQQefI8ketww=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=aq96HB/FWnJzQqcwwFq3ibHt0XJb8HsA+SxKtDJMSQfXQoQobgQfDLldFrceFJ3+qAQE/2i1RnJeYAW6PUPLCH+HVhEZveKoXTbrRc9t+Tk0IkAwKy9/d+VoUxwiak4mnucpIM2jIZ1U38fjipfgt8vEHQnaSuHnc1+bcA70e2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=EWu7ihBp; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="EWu7ihBp"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so52597a91.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789149545; x=1789754345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=txuVCwegmfGLS9iLXgkmasscS2tUIXx0zc29dBaGE3k=;
        b=EWu7ihBpJyh+IPO+AsbHiWJR5I/W0yVmUasop3M0l1SlD4izwd6cvvBilsRROdVGJ9
         mqZqdawGtC7HHj9MUdOxgT727NTjhr3Bu+Qh6gvxRc0lpb80oIzwxJYGAkeF43eFjAWM
         LtgRObWiV9SMmDUq3mxosID37QUdhEMX/ciFzZItAMwIJOr2pt/9Q8N4jK9K5Z/ikT+J
         f9jrCdF0VaL7zU7MsXBrYxOBaRuoqz94RT3axIrTiVIiGs2B1HVZXagjx0W+7bHHz+oY
         WyWqVIqfEeKplrjzFe8EoAXrHlfW/pd1EJJewHqfpR4+eaOHJu/0T5Q+xTFvx70Zmj0t
         2eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149545; x=1789754345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txuVCwegmfGLS9iLXgkmasscS2tUIXx0zc29dBaGE3k=;
        b=kndRie6bMdzUbhONUHKyf1DQ35zdnR/ctZM9KkESPhAKbCWUTeZPV5JR8Qk5+G0yjA
         xUL3fGmbBOfnh1305E/FKxgAzn9WyiDGQUkC2Jtw0V21UFFbuUluIMdsHWzBeo+DlaeQ
         LileWXFltaXXKiQaek4AgBJD17QjwDrEjqBNlIz6IQ/WcUo7bu3MpG7QBjLa4QLW53wY
         yqRWbr8VdYNI1OBxKvHuNqwTNBTH4OadOS8PQVkYk4FPhD0kdJIWi6OO8p9vOhpqFvVw
         A2xNM4ajGoaJA+XvXlSMm4PmU9lS4EzuL8cqn4A+znKNHBufjumuJRXJz9Q1tGnVfTFI
         NecA==
X-Gm-Message-State: AFuF++kjbGYzynfH6ue5vzjQ9igbiD7milq4kdllZ42/guGPali7GhkF
	AF9nkjyzPGhfsnh1d7hhlcEjshg0X4V7UHxx96Nbv43koyrXOwwg0tgAf9XgZomRHvw=
X-Gm-Gg: AYBFou3mYzIOT8IGAdPStpKh2rhtg1CMno052DIzDPUddBzAr0NWBUYXiF37zL324lC
	/7PQUdhjJAdoPz5sYhSLFHtsuJBLCndUF3+tQQjmt0amCKD21KzRobnYX7hDcTUKdu9aMp6RdaH
	eIsTzLBw1B/Neph69eg9PkQzYYMIGP3/W5HxRuzjwSYRaknUnrpY9CYlbvXwimJv6vKmlLtsVKi
	RcirWg6R64zJmdSpc65XaMiQuIr9tV2cRxRFny8bTWELCGCsn+b8WYUoLns5D7w/CwGQa0lWDD3
	ZA/Ec/if2XmJpLlVkT7K6aaeywvXtNJdvT7rgmP9fG63d+a34cY+45wCsgeIpu7EDtf+6EEuT7B
	R6vbHlhn9I1tlYmmSB3N8xy1M5BuxUljGYwb5B3ANH5jZwYqSegJF4S4DZDtSNIHgGzAdvkh78n
	av3dzYm1jaJJLraghS+AsaffiZFmcg24v0RzybWsKHme8zVuPzmEbsQ+tSj615GRg=
X-Received: by 2002:a17:90b:2741:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39d9bdbb0e4mr8768293a91.6.1789149544837;
        Fri, 11 Sep 2026 10:59:04 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm7923981c88.2.2026.09.11.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)undefined reference to
 `crc32c' in
 fs/ext4/bitmap (fs/ext4/bitmap.c...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 17:59:04 -0000
Message-ID: <178914954375.4461.7035650453281765990@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
undefined reference to `crc32c' in fs/ext4/bitmap (fs/ext4/bitmap.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
riscv64-linux-gnu-ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x1ca): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x532): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/extents.o:extents.c:(.text+0xb00): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:b6ca4325c7782942eaad9588858f36c9cfe53c7b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9f5e4631f281f1f3c92f33dcb2dc004f416196a0

# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40bcc20239ade90229c89

#kernelci issue maestro:b6ca4325c7782942eaad9588858f36c9cfe53c7b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

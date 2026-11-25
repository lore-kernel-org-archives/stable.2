Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618759;
	b=ROHU9eooH8+/L1JqlveurfJ+yBUO1F8Vx8RgYVw7nBXIRAC7FWF2o3Wyqhww/i7siGoc
	 uEXixO0W76h/0Q19fhHS5all07IPKnw3K4oZm79bDF6gJC/NhwiB3MnSwQlcvl3fIw4II
	 ypwx7cGtXs7FvYL+coQGiPEW4YBH8pKpAdhfoUylBYm0N/ERSvMsUjZo+2yG+pnq3MTWV
	 wqPPxmn0BboniKGiRl9nfCU2gH/DSAacIPQg3KaKaLH5bFaQ4t8/ighOldy8zqULxww2c
	 KfqOA/YGmlYCzh91Wl4Z9E9Vx80YehS0fsz/T+Zae7PdsaDFJ2NV7seWfLUCufh1vbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=az+Mo3lHkVU5/tVLQE5QWZ1g6RuA+VbE9kvgvsBRd0c=;
	b=Dtg6opMk7o/bLygAZzmzXbKbBcdNcMPFMAAGMRZy41GfFgqi56bWysLLsisu1XWp+z7F
	 Yc00YB2N6hxKpfUZDl5tP1sntVsqCPchzeaomoBgoA6XMH+QCNgRHAx6Q1Tjs43K3EsW6
	 WbWulYM0NwQh5Jr9p3fJyCEtapI3eXciFlqcInOoALBnnjthLJ4vkdBtbs+4FwrIXrsf5
	 kNZNVfGoxum55XApL3laReGXIZgHS610a4zgjCSCIMWBrKgq1id0RxfnvM07hhYGJ8iFy
	 9sJUHDoqG843Z6U4nygs46WMdFdiOZmdXupnC5Qo78yJuFlNP/sKPx95mq1koQWA0Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RgL2PZC+;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1065606A337
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1065606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RgL2PZC+
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386ab9ab619so7160214eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618758; x=1796223558; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=az+Mo3lHkVU5/tVLQE5QWZ1g6RuA+VbE9kvgvsBRd0c=;
        b=RgL2PZC+3txfjeKd8B3dNUqKAFh/x+8CnsCpKZaOpFaf+osajZXmesxxC73jYc9QwJ
         /NtEB7i+w2h/oe6G0qIB21DzttkFFEnh+f0HUGugLNQbGIbtGZxCVb8dQ6ws9lY0Q6D2
         t19Er+NZNxMIStGgBnEW1JumaS1DsP7uQp1IuPBuoh1y6K4BSOYNTDTbB13eZ3kzDRHs
         I4PrVUThbdCzbPSKHFB1naFNkL+XN2bIUlbLXlZnMOVr952ZR//DOp7dwMMLwUSF+Xo1
         rdbMziS/GYvyUCpzCtpk/ZXGJzXjF1MmDvSsRHNNBWvZm0zPKXPYPao7cRVMueHS+uB4
         NJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618758; x=1796223558;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=az+Mo3lHkVU5/tVLQE5QWZ1g6RuA+VbE9kvgvsBRd0c=;
        b=PB4rp8tr5TrvZrAZqSRnNIcoJKI4TBOWXoiC5BEm/PrMjw36IcvwX4CKZ6qokiokMA
         jljRzGlsMMO3foJq2EJvh1EkMW/5bw/Mg5Poyb9jdsVddCfm8d0s6nxmyR3j3HZUS26R
         GOcB/K5gZSEuEBauShdcqbUirfkdncjEn64VmzZFG78V5Xix9FHb3Ki/R5HNnlB16DQb
         ATHqa9gGieUe/13hHg6CsznQFa/zT5dUotY6r9FwmMkptiDfHjxLPQJLSErQ3HSlElVL
         GNjBAn9Y0U7B9HU1sXMPvnIgIN3fKZHLnNimkp01oBHEATQu7kOU8wN+kH/mjz17LtA6
         fx5w==
X-Gm-Message-State: APuU4Z/dca3fm+xk3Nd2wiCXLNW+6SX/9PJY/X58J8CDv9MoEnsW3+ZN
	Vo6mdrLCpc/LDPgQB7pKy7HHN1/3TgLNSMfKXhBmaebjEytgMJio0KDDYzA5QEMA6QXAe6Md5O6
	DJKEH
X-Gm-Gg: AZFdTZclA8OOMN3Y5zcYFgapUNncYdxv6jSZhXIcArhma0QncHrQHAdRtKeqTszrgcX
	u0ZzJ0hCZOJ68GIFB6KXgl5ek9Icp4EJ8PtEG+v5JTqEnux9LrLWPZ4P/Tf8hMA3weE+oy9fK9X
	Rt4Sq3WsK6qDxdhepEL12PCkjU3mDLLb6cRYRBA9Ih1AcNha+SCGTdW6wIX05Ab+7GUAs4OnaAw
	H0XWGLPduNvnPf56wf3UFKFHnr5cuha+vSRuZWWY1N3q4NhPkAR35r0GFPXUglqo0h54mVpy7He
	IeNA3+V8TkoeC6umKO7WJcxiVNAnirsu0liM2AFZaD2ba6smONEC8xc1am8yuRrKKzj9ey4HqfY
	k2zbZhKKyXYhvHOeVH5ky2nvygdvaJENFRnNKNhrykDsZQ5f0qaEJfrnl39/Us38DhfTr9WPNU0
	73GEDhpw1T2/pOgLinfM8l8ep1Zxtw8jIwKNwzOGPngoKB2bnYErmVH6I5kSKybUOAkkBhafSyu
	1LR1DtYnGqxhCXK1R4f8yLq2/uqIYcW8o7NuXRWFiP7Y2upseq/ai+APMqeS/NlJXyVW3uR1B7+
	U69lp3bf5S3FJfO0qEeHN44=
X-Received: by 2002:a05:7022:f516:b0:143:26cf:8615 with SMTP id a92af1059eb24-1b5568ded03mr15936190c88.25.1795618757663;
        Wed, 25 Nov 2026 06:59:17 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm41899244c88.2.2026.11.25.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:17 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)variable has incomplete
 type
 'struct cb_notify_lock_args' in fs/nfs...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:17 -0000
Message-ID: <179561875643.101431.14499775756192753814@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.6.y:

---
variable has incomplete type 'struct cb_notify_lock_args' in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:7108:30: error: variable has incomplete type 'struct cb_notify_lock_args'
 7108 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7108:10: note: forward declaration of 'struct cb_notify_lock_args'
 7108 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7112:19: error: no member named 'cl_lock_waitq' in 'struct nfs_client'
 7112 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                            ~~~  ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:5d5b114a681a02fbe59f4770a11607e7110119ec
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  85b40f175cb821478d26f4304e9ae2f574441f49

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f093286e1965ecb390cf

#kernelci issue maestro:5d5b114a681a02fbe59f4770a11607e7110119ec

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

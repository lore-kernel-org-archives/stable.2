Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEA4AD7D8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149550; cv=none; b=a3c7ueG3vmcvKMELW7yp4E2GJcdGf0VmAfjvJLXd0BW+0Izp5mbdUrXOQhkR6bxSQMhRNjLiev5/4wVPfJXk3sQmYZglc7zmG/bRkOTcRx2l6vpWQhiOT+ZkiYPlkHGLeVv+8jwrzgexhp7aSydPT6oZ4Ku7nqGtdxHeDY2L85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149550; c=relaxed/simple;
	bh=Wh63cZW1uiU7NhouGyz2g0aV9qEX1P0TGstJqWhp72I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=kNTIKn9wTeoTmmSBNVJeTUxoi4DpVgAiWTHwmah7UZqv1TH4rx6EbrCc5OxvAGYloKBmbaMAJtV24DClHus2NajtVcCxVK6w4deUKLkA1JJFDUeDNzCJhHfyQutx59aOJFr/2x/k13XYnfhxxsKhu5RWBFCeVj4w6uF2oCxCkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=QmBvMlht; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="QmBvMlht"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb750so55763a91.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789149549; x=1789754349; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vhT7zkOmUVi7y+t9RLYQsNNIHWnDKJMplMe5she7AFY=;
        b=QmBvMlhtm9scf1JaaOzQtjvJxgsMAnq6TOMkvxoIJatCVExuUVtAt4hhRycmmDuHSQ
         TyX02gdkxEbXDXFqwRPHGvYoh5owGh25Q3I4DsTf12yASMtOtS6VAHW1efF7Heq+MELI
         VL0V3DTguGiYwihvBwviWmz61QGSRgbXSijHnw6ddAEmEW+ZzVkKwpjOX3WqjcxUZgaR
         cHlMka5gMoKtvUJfAYUTVxOM8HgAbSS8cdMvlVnvKpAK2ZYDwvGeCNpicppd4lvkhnRL
         +MrSqxQ1+Ife4P13BH7dNK85vlaz5CIykVNW2MH26o5jjIhdKb406xyaEzLohCJtqXjU
         GZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149549; x=1789754349;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhT7zkOmUVi7y+t9RLYQsNNIHWnDKJMplMe5she7AFY=;
        b=tC2P08Tan7WkIna8XAkRZoNKys+5pfaMafFtV3Kvyd2uGv47ls9JxbLH65Xj1wa4AA
         Ejce/173pmKLMdBzmmXTRErnsiVhh28/Et/0POlzN+xS9UxbwvZjQmBP7tp75K7KQVIA
         g4Zk3G1tX7anYbjlcazAHOKWH/bDt9aM9u/3gWeIuQGpKc6m7Sm4Ct0dMdx4AZjtxN3k
         FatDlBKA0LeKxjO7XEJEQdR5D25/HUkrRqSk56kZs8Q+k2/mI6PTl8hL7GvPjNTPhkKh
         U42QMdQAT2WV/gPO+hKJDO5B5PEa51CuMqA5xifdkYBBHhFPZiSji3pjNdGjv8i0ymmK
         pvAA==
X-Gm-Message-State: AFuF++mAARDBmgkPTQ7+s+n9jU0bE747O8Nx8CJ6hRxqmzSV9vNr3O1k
	/iATfcSyWSHOXzvpafd0U5neJvWmd6m8dDaGHXufPxj7/VJg2l8FX/1c98iQg87CjuZZ+NUyji/
	hDxqM
X-Gm-Gg: AYBFou33T1Xo4IxSbWPQyE0cPjZfyNhW91lpZ8nR57hycjSNbG7nzup35xc+FAbJ+ap
	LEwZDQz6qeqWc9hBsnQ41r8b8UxxRSYdnxbdaAjFb1KB1I2XSDtGUEFr64i5qLUNRy1Ex4vJUuO
	i7SIdZMi/MUlOU+t3YD9C8rN0WIPS8N77qjeG5V21+WFDlw7rmid8/GurbzynuLiznhnntNUtXF
	LjSH36oDdFUqr53j8kaQKyOgTDz8Tb2ENV03e38nRzrGy7FuzwSTZmc43d95OkK8Mk+OqUiM2rY
	Xq292945GiUClXAUeizmtR/xgEjBqPWMWgJgG0p+yo8/c9bTEW+NpIuHvopd06OKFLkNJs+jixj
	2PRoMjY9CZ/w5bnJIBnNnVCEpyv6Uof3mQ7GxnelLcuCIRwD7c7oA8WrcOB+MJFPMxZOb87uAbG
	cEex1/26f9hrzx+Jr+vPzlrG51HNd69d4c45ZmxYayp6vvo3aG97YJrTRlRmbdwso=
X-Received: by 2002:a17:90b:28cd:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-39d9b983602mr9808209a91.0.1789149548945;
        Fri, 11 Sep 2026 10:59:08 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm8003042c88.3.2026.09.11.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:59:08 -0700 (PDT)
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
Date: Fri, 11 Sep 2026 17:59:08 -0000
Message-ID: <178914954783.4461.10598588788553237732@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
undefined reference to `crc32c' in fs/ext4/bitmap (fs/ext4/bitmap.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
x86_64-linux-gnu-ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x15b): undefined reference to `crc32c'
x86_64-linux-gnu-ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x35e): undefined reference to `crc32c'
x86_64-linux-gnu-ld: fs/ext4/extents.o:extents.c:(.text+0x13bd): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:6fdfb5aec1ca87162a3e21137157c4c257584de5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9f5e4631f281f1f3c92f33dcb2dc004f416196a0

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40b6120239ade90229822

#kernelci issue maestro:6fdfb5aec1ca87162a3e21137157c4c257584de5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

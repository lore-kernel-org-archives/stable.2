Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0A364038
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138754; cv=none; b=NE2AeNLdBGDT77LEcKBZ2BomEq1p5yvm8Yb34rRQq+/qYEIwhy7sqtOL/09x+o25YWAejp1kLUJ+fPPMWzLxIXQZ0VKKMqPUX6drWW97O5Pv6GeEWtvoiURpExfLlqgod41IoUVJGDppbTKDOceP17DlnQdaKUxwYM6MU1SLbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138754; c=relaxed/simple;
	bh=g1EGRYVWmQ5Pn/76REklkNMGb+RlAk059cCIymDzRFo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=FEid1p7oU8foY6QcxRcTo3ToieOkASdHavEfqtYVW4N4xr4SEZzC5VHq0eb0mFl/TeEhdbTXLVtP+5QG5atSUNEQO6+VP/PRlAlrbl5qwBFP8WmOglVf8F89f5e0ESi8wOu7vrivu8ZKAiXFkTOt7FNzkaNkn1gNOCHOHAoH2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=C1XY7nrx; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="C1XY7nrx"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8692be1cda4so861746b3a.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138749; x=1789743549; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4CStJEdALst9NW3J7iVdNnwwmd088SUiIpUqSVSQPzo=;
        b=C1XY7nrxWs26dAv8WCPYvCxfQ51Tx+F+ygxOb4HZYgUpHljji0PygFhOA8V/f3AgBL
         tWs0HdRAhjiYlcXDR1w0WZig1yhopvxsD6t42Sr7VX193yRMFbabr3kZR5oVl9/DH6KY
         o6u4EJbrrF2RZDYsYJttPtLVq/r6I9q3zjJlQTyuI4prLcucKgyFp21ps+pfP0/R3OvJ
         TNeNGTQK1pPbQRa81k+m9SYYXtsrZtJKA6rflhQvy7Y6FLr36Uva9u44k0VxejLPtOWw
         pKhEI0HZOB153qRZc+hDMbbnRZ5pl6f4B7ilA/LCtjdoizEWVa9NjfGg//1XB9I+M/56
         6+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138749; x=1789743549;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CStJEdALst9NW3J7iVdNnwwmd088SUiIpUqSVSQPzo=;
        b=henuPxO7zQ7WUZN3RHPUMbODhBmuft3sWyv4FjLnh4/Qwr+oBD4kn/LWrFPQ8zYxB2
         Kcj1XFx78xPe1VdWNed10qxfxkN/6hBdr3LhewrmhbZOUQXIdcRPlLrhoclD5DoVGWEf
         Egkv5XxOrORdS65nFWLJ51TWpbaiUewUeEPUjSUDeXAZcoqFGGmJlnyELjXZv6W9P81r
         wMtCIl4UQnKb9RsJm6oOetk5lcuVMT86qfHwX9a26WM3mnyTzd21qBBDXNrmjEgp4RkO
         RWUTrox0licTkP+6hFE7nk/hkFua2Py1YVysi+Yz7RS1tMsJ3MJmAhLSaEGJshLT0T0v
         +G5g==
X-Gm-Message-State: AFuF++lcSDTIDO9cQ+UbmwzipzURbWb1vuk56AwGGJFueT9Pe+3zNc3B
	N4pBPOtsaGx+Vhbes9sg2M9bFYv8TgSuW0EVK2MP1uJzdCFltdiuaOQyFVQg1PTI09k=
X-Gm-Gg: AYBFou0qWI16O9TJq7o1KJ0tXcoBsQO4YBog07p7mcaAPrL/yFAZ79+YcEgEy/A054a
	T2aX9vcWGi5koFSKh8HdnE53xOUPp/gHZ45f54fYO5APlZcjaKLsfr7fI8pqHzkIb9ENyCxG1kb
	zf5b81hn5khVtGu4vLz5kU5NDusfx6Yq22eI/cyn9wXwAaIeeNViryn/wkBD/mWW5STAmKnRn/Z
	xt24xUh4IzRbVOpFRkE6ukjl0n8cMg1u6eiDk4YxqfKyApwk746UU3aGoj6BUXQeRlubwV2s1yz
	XaWGrPluaP2FGQ3YSq5/u12ShK+O/uXGrtqwK26u7xVl/UT1D0l5OiOlyzYjlEQakhdzjAsDtwN
	6NI9ldYgoojNdgLtqxm3eXi8voior1n4iPav0n7EsINNUor6RrGJDB1rHM9BsKX6/khWm7xoa/9
	2c+xSj0svBfNP223ewRX9MPrmbBdvbFWMLtYd7w0a1tPH+oW9CnX6GdmqNY5Jbj3vB
X-Received: by 2002:a05:6a21:d8a:b0:3c2:dcdd:a85a with SMTP id adf61e73a8af0-3daed5d1834mr9841918637.13.1789138749407;
        Fri, 11 Sep 2026 07:59:09 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b345a4sm6946641c88.5.2026.09.11.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)undefined reference to
 `crc32c' in
 fs/ext4/bitmap (fs/ext4/bitmap.c...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:08 -0000
Message-ID: <178913874801.4387.14258174941042521143@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
undefined reference to `crc32c' in fs/ext4/bitmap (fs/ext4/bitmap.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
arm-linux-gnueabihf-ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x138): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x368): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o:extents.c:(.text+0x1494): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:58b47e9d2982dffe75f564cc15b622b77b9857ec
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40bf820239ade90229dc3

#kernelci issue maestro:58b47e9d2982dffe75f564cc15b622b77b9857ec

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

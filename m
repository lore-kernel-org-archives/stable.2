Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913082C234E
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787970652; cv=none; b=Jy2Dm19wQeYMDQmsYSxBRZBmozays0BXl+vYyIsUUsPVDhgxxg6fb1muYICD30pkjWlMT5oS0OGtCq0aWMjphSFWHkzwLfCOZ6ti0EjIC8kU9I8isoqPPuRoxVRpOIVA6+L792gB7cUz1RvmNItss2aolfNp/RMsMqDxvOSaKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787970652; c=relaxed/simple;
	bh=7nr34Mrfp7ybZbfFQqal7LLtDc7SROSL8IO5W3sG3Gg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gb3E2+jGSb/sZiSwzJzBgX3twwf3/W3xEUYnv2v3RXmXNlN8OmFBbS5uGz2DeWJc23MJ7rslnLqOp2AcIO9jIsLlPTk3VlL5WilUPp/yyRH/18SNMbYLpKoz21IhZRcHPRLbqzpYXvmYn4bhyf/pny5rSAb5gnm4ppDAPzV/CSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Zpx53AV7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Zpx53AV7"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso1414703a12.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 19:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787970650; x=1788575450; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CXveKmE4fgwkrWlzZLvEzGk4NVM/oOPCCpzuMTQRJlk=;
        b=Zpx53AV7//8vTUpayi+pM70pKNTgq+JjeK1zChpL0jy/+2UukCpEOHPeVxP8wECirj
         uP7DaLkfr05awL3hGZlin5C6Y93iBlIje11WuOX1oIa5c+XXeE9p1G6kZWR03HohAhml
         InvGwyudo+XWsSO+Dy13/91w6Aanke5dmSGk2qCS+48rj1qSXg5SqT4AgwFCgdRWmg29
         V3k9uLzlI6lY9YNYnbowL5eiMfW2SzVi6UC/kSmN0HQ/EmZNpz/oc5qZSTeDKdSWbmui
         50euWNvs53bY5A408W6EbWMJ2wSx1j80cG5GXfK34yMa41rUw5/cAQ7Dxhkulx8VfZ1I
         +uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787970650; x=1788575450;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXveKmE4fgwkrWlzZLvEzGk4NVM/oOPCCpzuMTQRJlk=;
        b=LklRV8urQbdlX9u/fbBqBJQO7kUAVGOlX+di3hk1HT5LnT/MPJx3WwhBP2FIIJbQos
         quLtBJ8k78EI3zXqDZgh7pT39qrfY8c3qJBaVvDR6H82g3sbl+bvigBS33siBsNwSZJh
         BM/upLNolaH0YlK7L145GR5Eh6Fg8KqjrFrMMsRJ/ZHnxWsuRjlCsnlpDCH2GGoHpenM
         Y6/fluv4gumH8GPkF1WnVVcxySrFQrSU0HxHXowM5hMWy/ML2FfWc8ohED87n7zqNFdN
         +2eoghzGSsHb2F6bm1Vb/c8AeGIlOLr8SNOKs/j8frT7j535D2SmWDtu2Ft9+6qKk5jh
         QGrQ==
X-Gm-Message-State: AFuF++n6sLveQRl6/AzNtoYrxyL4fBaAlJEDrmqqc/mrZoMTpVzTVT94
	lWdr+M7s6H3H2gtvIDn4cRB/PHSo3yYlKWoj27CnK8uvsUjZbI0p5wuDjyJBdGPbLrs=
X-Gm-Gg: AR+sD11wE367spxGjJ62PlMhKVmzdTu2TX8gO+NIjlNS4k4BHlYkIGYHs5Wy0qaPw0K
	NYyHZNpDmRhAa7BOYWJRWWoJBqVvH8Ybh/ROtx/pLbgTWOnaaTeWtdm71X0iP88CBQKEB6JYujJ
	vJ9PVWN2VTlOVcOUTfFz1rojlkcut0pXlKWTyb+9qhr6YH7oqsBAOmvO5EGJK8SKBXo1G88jQrB
	ILzu7SMDOoOWepGPFv1/Qnyr5vTs+IqLFhc/uMj6jit6+13QCdrU9nBDivT5uPKFWFElLA4m2hY
	SkHaRqVxx7xMOkLFYpiBA4ZRbweqHOUkZpo0e4IHRzktYe5tCEkzLZo1XelIQwi6cAXQsiwOgsc
	cFEZOYKchtUzjyTrqM/IUVmnUT3EKV4s+MM+WPK+ZE7tINI9fZL1JxmfnNnc6hiiuMxwcbPLXPF
	kv8r0hpNvCjxXe00iXav90/w6Lj0O6h8AJf210s3W3SBhBkDWzzHSm
X-Received: by 2002:a05:6a20:7289:b0:3d3:aec2:4dc9 with SMTP id adf61e73a8af0-3d3aec25051mr4721552637.21.1787970649140;
        Fri, 28 Aug 2026 19:30:49 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c37sm11396070eec.6.2026.08.28.19.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 19:30:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 a4a971135a2ff64382ae4235b3ae60503bb1036a
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 29 Aug 2026 02:30:48 -0000
Message-ID: <178797064794.6229.5524275685689618453@b455de3d9de8>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/a4a971135a2ff64382ae4235b3ae60503bb1036a/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: a4a971135a2ff64382ae4235b3ae60503bb1036a
origin: maestro
test start time: 2026-08-28 07:16:01.374000+00:00

Builds:	   55 ✅    0 ❌    0 ⚠️
Boots: 	   66 ✅    0 ❌    0 ⚠️
Tests: 	 5498 ✅ 1692 ❌  210 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset
      last run: https://d.kernelci.org/test/maestro:6a9156bfc5867fba946b32d5
      history:  > ✅  > ❌  
            
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a9157e3c5867fba946b3b6f
      history:  > ✅  > ❌  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a91589cc5867fba946b4224
      history:  > ✅  > ❌  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a9157e3c5867fba946b3b70
      history:  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a914e98c5867fba946b120e
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E0412C08
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505148; cv=none; b=c6J5m8pRJu+dVNQ8zrcrx5XybRrzxahO3ZBPhHeLcrSD6wyTtI+cbnLxdlAwVjsHcgRJn27s/VVI9LCIuS/JVbE7mMb0vs+6VO8JzQrdi+dTrP3fwrk8HIgvidcnJh5mZ4CiHHZHpx4s+bfXTGbuX5oqSWgD9aXMcEaNpXj30Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505148; c=relaxed/simple;
	bh=3464x5NZCoMp1ZDniXwIhOZ6U4CHyalxsFN05Yb4ORs=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=YdjR0mrQ/5759X2P4mVG9uoB3kYb4Kq04YXLx16OKHQ/peA5k5HviCZL5ZY8r6occuK29ixwI2hskF+SXLAcYWQXysF/WDpvCrmIZUQBku73q/2pVr/rH2xqM+rZOGAnVGmIpPKxMBiCHydFrm8GpxM2Vr7IJy8AEm40Ff/7NKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Y30O07/j; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Y30O07/j"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca80d708489so518581a12.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505146; x=1789109946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ETRkNi8xcWdi2GkGx/8bzHVn3l+X1bqSXbSL4WaInnE=;
        b=Y30O07/jK1heq0ayfBPzM9j8eh0aRPtq1g3SBaa6wfk0Gwxcd4NAtlZU+tdOgHkur5
         Cp5DTyA7vxzOfvqIzJT2wW4lMt0S7HGjhGyOG7ZBb83GOdPvSOF/j8/qtrgDrcEvMzYk
         XZ6XLBrfd0hpTUiocBywRMtwmUhGL58eMJYW0AjT2Pbr4/5FTVgfEGwER2JrAqyGMUac
         JGNuQcX1d9jBcGnc46sG2vj9+fIvhKNJBklq1zD03DPk1RomBjsaE6ivEw6pjO/R9hjr
         Oi00MTTL4JXsCVlohgQjbVbtKX6pFETTIYEEuEvhJgzZIrGgletv5x6qG1JYRdCLm74Z
         Umew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505146; x=1789109946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ETRkNi8xcWdi2GkGx/8bzHVn3l+X1bqSXbSL4WaInnE=;
        b=TNhoMSvziqqBE0IQmGeiyRoxo2Rtkscrt4bbHG4/TTYI6mwn8HK1uSZKO5XPea8GPT
         xAMFJh2gKobmrrz+FFDHmU3oT+52HMnp1p/QpoGow64FAO1hZ0FHrLiAb+sU6RlWrIiH
         YYZzytWNcVqbbuRmLs3H3t3Q7Ae1WB+AIx3ye5kk8/QLLFzR27gjg4hHONvNBrkZGv5v
         KC44vKp7M2lqAYtOyCX9AsByp2pdgPwElKoglKGIBxvH95gT0UjywhIt3UlAIKHGUZZN
         I91IpMsUVxABJbSA81EYvc1sYoTTn4GyzAsUun4hhWIw+hTdugVqdgD6LVuRVG/F01Xx
         7/Rg==
X-Gm-Message-State: AFuF++m67YS5Lk56ewJDvYQ0ozgTmvTT9OGKYtB7Wv8KOhSIFZQrxtR2
	OTt4FFW7oURPxkFCRRX+VAvmEMWyGQlYY003KWtGttlqhf8zZY5e90xewl3hnFF7MRCDOxi+0KH
	6EQWKvsY=
X-Gm-Gg: AYBFou3+y4Pw5aMUdxDgiCyhhsjyPQ19obvmWfGQ4haQE6y6Y9KABDx0gMqo7gzcXEl
	D24ftTLCFron6BfX1Gqstt98LmhAPC7/sBeIGsV77uy6qESji1SmJIbQYhmKb+pe6kOCU3rBRx9
	rDHpzTEH7A3i63qIjh7zfpUoM5LH8K7/Zg8gN6/h5GSvcyCYyyBBAQGQUjyXDHHwp+1Rr723nc+
	DKBQG1lVQmy8viGc9PB9sYOqxlecgATvXKJRA4uED0jRzk9eKv4DrRiPh7QgIqBIDagNq3Jdl9R
	Dg73gC/rtDEag3LQ6x3SO+SB1gLgjFv8XHHXL40vLR2j5y8vx2GnbU3ty9Gzatk5VL4dfygBLdb
	NfAcFVPpQDLJ/KC6zUd7eLshcPr/WVxYRNjJkqzNcGCxGm5lWH3xzAQq3tYdlFFWBg7Xg+0zC54
	Kw6kba/hqj6hRkHYaVhYjNPbO/fDDH7v7XmntUAVg69bg8v0bC8rEj
X-Received: by 2002:a17:90b:2244:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-39b0865353bmr11831879a91.18.1788505145547;
        Thu, 03 Sep 2026 23:59:05 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm6172138eec.15.2026.09.03.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98put=5Funaligned=5Fle16=E2=80=99?=
 =?utf-8?q?_=5B-Wimplicit-f=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:04 -0000
Message-ID: <178850514402.887.5901813790625514191@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
implicit declaration of function ‘put_unaligned_le16’ [-Wimplicit-function-declaration] in drivers/pci/pci-sysfs.o (drivers/pci/pci-sysfs.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pci/pci-sysfs.c:901:17: error: implicit declaration of function ‘put_unaligned_le16’ [-Wimplicit-function-declaration]
  901 |                 put_unaligned_le16(*(u16 *)&val, buf);
      |                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/pci/pci-sysfs.c:904:17: error: implicit declaration of function ‘put_unaligned_le32’ [-Wimplicit-function-declaration]
  904 |                 put_unaligned_le32(val, buf);
      |                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/pci/pci-sysfs.c: In function ‘pci_write_legacy_io’:
/tmp/kci/linux/drivers/pci/pci-sysfs.c:936:23: error: implicit declaration of function ‘get_unaligned_le16’; did you mean ‘get_unalign_ctl’? [-Wimplicit-function-declaration]
  936 |                 val = get_unaligned_le16(buf);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       get_unalign_ctl
/tmp/kci/linux/drivers/pci/pci-sysfs.c:939:23: error: implicit declaration of function ‘get_unaligned_le32’; did you mean ‘get_unalign_ctl’? [-Wimplicit-function-declaration]
  939 |                 val = get_unaligned_le32(buf);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       get_unalign_ctl

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:018f0b1618931bad1d8c250ffd6089fdcc4fc828
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ee6921fed8a481c1d78d55e7958748fc4b31d30f

# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a9a5fa9e41d7f97d6fd768f

#kernelci issue maestro:018f0b1618931bad1d8c250ffd6089fdcc4fc828

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

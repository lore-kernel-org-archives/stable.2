Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51571470448
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720440; cv=none; b=A6lo7f4IXDIDN3uMZ1T0MeNQ1u7ssOwA9Sk02wP2Juo6E8slL58yINay5xqMbHp8XjdChToCCgNbuI3aJu6UEoKUJ3SlBBbBOLdfesV/sp9zq172IrtFtJIzNQ6F01U1O0H46r1AOgIhvbziB9ffjDOEtGjWhjLS1lagPKaxFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720440; c=relaxed/simple;
	bh=oQmhcafvryzQTr8aJS6N1tB2XEUUgWL4lgJR/IbHbFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cvtmKuof5OrzNQupkNnO5C9t+vWT0jZjn0kGxQq8My41K8ujhF9aQ/L8JzaFpBNujJXv0gaLJ6+m49dsxlLiBBg3tQXvLgSuqO30W1iVER7XLivgrRMYKc2bpxV2qxzUdM+2fI3QbGdWBAUSe8ctZFIkPycdDM8eXy5SOh2c+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcUH/RZD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcUH/RZD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so14814265ad.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720438; x=1787325238; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fPqMpU+LLRNYiSjrqLFHm/GfoNDBW1/b99+GMQWZD/8=;
        b=rcUH/RZDKoIVRuBaHQyNb60NubVYBTCP0g43QfKSsgkl/tV3yhm1E4iiU7ux9qzijv
         Rcdpb1XXXgXuhjUedk5l6HIPTJaxrK6sUiotqImKF6hZyLje3MZz7IowbaNdbUItsZUp
         mQ7VwzTIvw6N6GHODWVuS8+Vrpw3GLGHoMN6dsI0NrTW5nLpZQcO+KFt+nWelI8rSsK0
         YvRdPls2tuH+5ApbPYRuGkE3KlR9lso869mw5a7LZGeBUQ16SeVRlhNUfoG4IMt5y/Ko
         f51lmmU5980cS2jdYMl0sqQzLnI3KQzOK5tHEouhoz3+JbDnT5iyCOCkySD5jU65lATQ
         8DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720438; x=1787325238;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fPqMpU+LLRNYiSjrqLFHm/GfoNDBW1/b99+GMQWZD/8=;
        b=mlA3YwgnnjxBnBjTW9HLsRR/PIMIq7G7Qsp0u2CnEoeYwUf5iKcu2PP9GU4GDltbZe
         6DbxOYjQMyfGNRa4G8Q7nyg6PZuHnYV7wbYnNEA2kkMnSyWktpumaUhZYN/z9vCjQ9Uw
         RVMLaydU9/SwoucWBgkvWPx4p/awrnhpgk2dgy6WQrX2WGu1LDWqg3+wLGc/hrt/PaaX
         3qw6OlsEBcFB1BUJr0mzMc55F1Xpq7BwGFYkR4+4BYn3PY2Lu/bKmr97oNrgXOtJzKoc
         JQTsWF+M4YGvho/eEJWJxX5vQhXGkZ9dNOmu2Pdwm7U7rjwp6l+8qH4ZCvrfC7xuXK5k
         KINw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/RRR/ah9a3w7t2T/M/f4vHNxUtxIEfECFZA1AtO8FaoWheIEqFvrHVdlX2IGCUG5HSU5on08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHfiLfpzD/8abmuA5bz27p/b8aCgph4pZXfzunLI/sbDfYf6O
	nWsVqcNk5eaE8xhiSLXE2yZETNhlAUQl4xJKvGN/wnWbtLdBUThDi+Ni
X-Gm-Gg: AR+sD10yk1Pe3+T7a7uJ/OqKREmcnpOQyA4VBqnO1gH2A8Wxb/2ghsj9huHZPdKmraY
	QU0xh9Ko2zTcWimpatk1urX8UWcuDuLiWlHe7wTrMi98DKKXBIp3bmf4C5/svoj7zKyuweEwF2m
	MZXAVP7kJgt4K92L5c//sekxLD5r2juePfbxL67sICBcPc66+oWBygCAPLqWYyTXbljJKAC92mI
	H+fPPv1/DWLS/qr9y+ffxHnrWLtZk3If2zdhFKyTNl78i3q1OVNXKbQ9asmzES/yZlghkog+mRN
	8Jydr3o4V3ETgQYaP5akmJjYzXq0y7UngZc14+kYfPWumcLoIc/ldwDZ23Ft/1vGk0aZdDhY1KZ
	+7qyoy8HPFHac6DtIbbjFPig32Lf9xrPOxunvQdKqWjCfQx8MMuVvJAkM9bhjaWB+33iZBG7gyE
	FkkgIjiAlYeUpT//OFAOmRsDfRPVuF6ttY5O4J4lnMrJipYAULIxfnzoKqb84fE8ObM4BETnXQK
	kOJgIYeyA==
X-Received: by 2002:a17:902:ec82:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2d3b082b573mr83408195ad.5.1786720438215;
        Fri, 14 Aug 2026 08:13:58 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec22f98sm11006395ad.84.2026.08.14.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:13:57 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH 0/3] powerpc/spufs: fix a refcount, a type confusion and a
 coredump underflow
Date: Fri, 14 Aug 2026 23:13:38 +0800
Message-Id: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKMwf2oC/yXMQQqAIBBA0avErBNMQqOrRAur0aZFiZMRRHfPa
 vkW/1/AGAkZ2uKCiAcxbWtGVRYwznb1KGjKBiWVlk1VCw7JsfBxS8EKrWrt0JgJjYWchIiOzm/
 X9b85DQuO+/uA+34Au9ZGo3AAAAA=
X-Change-ID: 20260814-spufs-groupa-6246fe77de7a
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786720431; l=1879;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=oQmhcafvryzQTr8aJS6N1tB2XEUUgWL4lgJR/IbHbFo=;
 b=zfG8nyBi7T3ub7M+Svd8MbP/SpBX15kVeB/MKzmI2tsFv1Jn0a9Tkd6kQRapj0IRc+71kQWlG
 6ygYYi4+LN7C+D4Ol8M6zTy8bCMWhvKFP+a6kxzyBqvBfNBHYdc+/pE
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Three independent bugs in the Cell/PS3 spufs driver's file and coredump
paths, found by code inspection. The patches are self-contained and have no
ordering dependency.

1/3  spufs_create_context() drops the gang->alive reference on the success
     path -- the epilogue tests a value that is a file descriptor on success
     -- so the gang directory can be torn down while contexts still
     reference it.

2/3  On 4K-page configs the cntl mmap fault handler dereferences
     file->private_data as a struct spu_context, but simple_attr_open() has
     replaced it with its own object -- a type confusion. Fetch the context
     from the inode instead.

3/3  The signal1/signal2/ibox_info coredump notes declare a 4-byte
     descriptor while their dump callbacks emit an 8-byte u64, driving
     dump_skip_to() backwards (size_t underflow) and truncating the core
     dump. Declare the sizes to match what is emitted.

SPU FILE SYSTEM and CELL BROADBAND ENGINE are marked Orphan in MAINTAINERS,
so this is addressed to the powerpc maintainers and linuxppc-dev. A
concurrent spufs fix series from Junrui Luo is in flight; these patches
touch different sites and do not overlap it. Found by inspection; not build-
or runtime-tested here.

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Zhenhao Wan (3):
      powerpc/spufs: fix gang->alive double-decrement on context creation
      powerpc/spufs: fix type confusion in cntl mmap fault handler
      powerpc/spufs: fix backwards coredump skip from undersized notes

 arch/powerpc/platforms/cell/spufs/file.c  | 8 ++++----
 arch/powerpc/platforms/cell/spufs/inode.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260814-spufs-groupa-6246fe77de7a

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>


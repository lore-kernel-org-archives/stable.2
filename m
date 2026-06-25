Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231637DE83
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375910; cv=none; b=ro9ATlXgMTgoO88cQ2NAuVOCT+YwU6BVuks8X81Z8QEljsioOTZnEB7AGM8wKnp6PTO1XEZ4eDahyF3Ns57SQlGoWfH4Oi8scgwxfDpf+Gqq/iN3BIdb60Jt3anoRtwtl56QS1CXtX367aif8R/AYDugn/SstPGPaUjLPyUsjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375910; c=relaxed/simple;
	bh=DltasMbmf3+mR3I/WxfHKm8FcOsjkwfd5OvuJnjZwcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eX2kSfVEe+noc1OMQtNTdbKL4MeR1Khs8ZxikhHZollJ5lrUyhtWxhpTaHUnEp/r0Pi7dIXVfg61w4aq1g9nO17mnheEC3xQdV27GDUbb5Joykr3TC4PtHODC7sHw7ITNv3cunJQSJu8fw0WVNi/8qF2maMIdurTMaO9uSU7Uys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6LBjGBf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6LBjGBf"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39ad400e762so353201fa.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 01:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375907; x=1782980707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9BmwpxX9oIBT0KeyC8tYnILZSC886G3PgVv44lueVJs=;
        b=m6LBjGBfwjkdcOyet4UjOBoW9edJkyDv9INSGxan5fFes1b9vrALUhB+5C9GlYywP5
         eOMIi65gC0yzmP0GMUqZPHvqc20poMQnAqZmyatR8+T6QH/6etzyEo1TfX5cI+gwRV4p
         IxtYZB9znthf7smDSvq5SsO4QinALRoGwPma4JxETAukqGBjTW7ykVurbAbESj2uO+s1
         Jox8dG2fYMRVDIJDr5fo4Nw3axcNmrw7PYW3A+LbHjIyRhT9jrLgBvrWD6ItxSNLegc9
         osZqiT/aGnqx6JFBZlzulMIkOKFFtZ48XAPBHWoLLtcHDSI+G5Fk8HllbzRaeDGF4hsb
         /O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375907; x=1782980707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BmwpxX9oIBT0KeyC8tYnILZSC886G3PgVv44lueVJs=;
        b=rpV0VATHKzcfkotP8H9LrMBN+Oy1SlB/7R1UWYofRh/A9oN6N2pZHhZ2hAwup6urKp
         3MxoSCPEmlqya87YEXWdylzzP7FHS6PkpqLGUHTE5GN0W5SH9Qnppjyv7BxZHBCDGO5u
         Iua6Ryig+SaeZkeW4ykVPvFsC9aIZeUDQn13aRkVoa9gWHOpvJXPcuYVkUW2VlwvXg6t
         mVAGIJD/Dfz9DdA4qjFvl9G4RFADFqE+1Flp/eEXqIc1DXQn3DJIM8sWpRWPWXP/i3XP
         2PUx7Uj+y/XO7KzVpFehDwfHo4r3YfHboWKnA5TaPmP59p+MNgUD5zV7rS4LJtp0SNWD
         7sxA==
X-Gm-Message-State: AOJu0YyAacElh9l9VAZ2LPFE36yWngnOyewiEqWh4welz/DJbpsKnWBy
	Dz//leX+t1J0fqI+ydNS3+TsGORT24QjTwKoZICJbfTPyUq19J6rd8MyM3WjyjB4pzw=
X-Gm-Gg: AfdE7cmpNN8Dd8ECVEV3emhsJaSu+JQnmibYA2YQ3ouJ/ycG/bcjkPBoaeIB/cTXrtb
	nvsGnol+5cVyeFix/0AnubzubHPR0z8ZpKfzwixgS0osZcPEL9Rhwh97m9xFIcXzEEdpUvalOE3
	8UoAR0VxeVg0dCLsYNnRzCd9lFlYtY3XtxvwSVYy8qb+aMBFBp0KKGXNHAA74ilGyNgnRFcR1WQ
	nhMG8CpOCUTClgNldINPVlMCd0J/LMecihyAdTN5VaOmArI5Gih6jBPnRMbKI9tIp9xwGQIiE9A
	NevlzKuMNKtIINOAf10mHYejZHG4GY0N4AglY423aIAel1d8lcAoCMHuqADOUK7Z7Khce/qQH7H
	s5OggQBgeDq9cRItwvxVknEk2iz+MuRE2LOS392NpgSnN2ik270Vz4aQnzr0GXqDIAqs4wejpPZ
	/YmznV1TIQQq8gp+RLyqSKQefPmfF+
X-Received: by 2002:a2e:a554:0:b0:396:74ed:a7b1 with SMTP id 38308e7fff4ca-39acb6e7858mr3756601fa.15.1782375907169;
        Thu, 25 Jun 2026 01:25:07 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ad31a81adsm566391fa.28.2026.06.25.01.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:25:06 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Alexander Martyniuk <alexevgmart@gmail.com>
Subject: [PATCH 6.12 0/2] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Thu, 25 Jun 2026 11:24:40 +0300
Message-ID: <20260625082442.96390-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()

Link: https://lore.kernel.org/linux-cve-announce/2026062404-CVE-2026-53070-0031@gregkh/

Petr Machata (1):
  net: ipv6: Make udp_tunnel6_xmit_skb() void

Xin Long (1):
  sctp: disable BH before calling udp_tunnel_xmit_skb()

 include/net/udp_tunnel.h  | 14 +++++++-------
 net/ipv6/ip6_udp_tunnel.c | 15 +++++++--------
 net/sctp/ipv6.c           |  9 ++++++---
 net/sctp/protocol.c       |  2 ++
 net/tipc/udp_media.c      | 10 +++++-----
 5 files changed, 27 insertions(+), 23 deletions(-)

-- 
2.43.0


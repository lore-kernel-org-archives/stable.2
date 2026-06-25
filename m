Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58F30D414
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406432; cv=none; b=VAz1n6VlWodTjKdgMNY6jVgVj0JBkl1Fa+95G1Rl4Rwp8kG0rjN679rhROVmUkuxNTLd16D4ZZbyiir7sWV5f38b1EozFgUBK59BLqIGdY5jRmpHBFBRmzgb7dI+0EXqW95StRY3oZrrlO3YGMu8siJt0DlGFBHwKtNBJuK3DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406432; c=relaxed/simple;
	bh=qEn9gVSp5Kgwj8A4/u9VXGBX0jAA+TWVYQEr9RU8X/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xq381ilxl4VG1HXAW7LQc6lYiky6HAWL/Z6Sk0aUB2ZfjKkAHL0O0ERSjwGvexiYaS2eoh6brFsAcLo++Esr+N06jwAlgZQC5MSmkgJqBVSPnC1TW6qqN1n7fqRX3R564vb4P5ksyA6/MyYUBE3lEcvp8zcsjt9+Yulpjq6MwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI3qwmWD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI3qwmWD"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ad4f1cf3cdso1075484e87.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406429; x=1783011229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YFP9t0BEfAxf8MyUpEA7sGVEY2aYzoYOSU9Q/SX1T4=;
        b=XI3qwmWDORFpqpw6Tvi4GStaysY+2aETDgyxkY1lPJD6EZ9jFMQUl87lk1i0c3coiG
         YKAfl5XZlViO6Onpf93nYVd+l9WmXiNB9dNuEbepmTbhxu7a+847A3noBLfid6UmKxpA
         QalJp1/CTta6f4+8vIUb4h39FIXUZs2QxZ6ovHcBzwwZ1KzrkCT1yT5AGRD+AVigPPQN
         6aiYe9HaS16+fBj8MCk80rjvJvU24luqYkPx0J4J5rhvclNqSU1iJR98hlC8zBy7rf6l
         z9d6PChmt/LNcr2YPRI44CsI2REKXiXuJQvLJe+7ggkL4/Ye35/U9ACSVeyieUAOM2tc
         +4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406429; x=1783011229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YFP9t0BEfAxf8MyUpEA7sGVEY2aYzoYOSU9Q/SX1T4=;
        b=NV/YpE/WacTYTZYhYWPQZtsV8bxFcOPezQwjAqyFYL9ZyVvqWwhOrBP4rCQmixFShG
         X4LitqgdBGyuzWOi3C/3KS4zeK9HdTtctesfpPfwVqOJVZej1AgaLdMLAf5VYJUciWug
         d1xzyPkjFNKqywUYeV0hzzssKHn1FkAvJGkkTzCT5l6KmjHw5FdPLH3Voi+WjdJnUeMJ
         NFzQRepKBdwdw7X/d7VDCWN4sxmNv+dAnYLezWiNdbsJSBdEB79hkC6aebCfhcyaEPF1
         gJU9SMNH2mMLlFS9mbnoog0e6Rk/CMz/Hs4fk8GnaRxkFydZipyoc9mFHuvFGAVIxlLH
         zOAA==
X-Gm-Message-State: AOJu0YzvtSSojNVn7IZcivypd2TYiquRcX/GgIzOUGWLpQkiLrEj3Nsj
	py9VSNpc10IkZh74L34DV/n7WYbFOI662oFqC4+8I0qo2UK1X/sLkfq1+bu0acAlFSFfrw==
X-Gm-Gg: AfdE7ckK1+YCMwgGqS4nW0lSkKxwURb/G6Oxuqs5GGtazYx4v25wemxrWSVaMgOLkfM
	5vsAy1l6wSTYTLISIWWo7M3kX6Md9TL6qkbW+f/DRVMxJ6VoOniNx8W1LaYaF+52IAwGxo85C54
	TLf2gA1B/nhT8ojNepwSsy6B79bUMLNGrtcHp74rY1Po2PcliObooVbBeYZc3GVNuy5Pw7SuUxx
	2C1hmhYzpcMO1BLgBLHpmvmCHccVMTVctsNBYM7p65SVAOsn7CBl1txInEu5pSiYGkcyy3Rannp
	uZPZgFzeOSXaC9g48+mPTWdYNV+JDW+fKfJ4MczntRr0yrxYOA36A/r8n3MeDP3X5ekPqSwSgmr
	304SlSlCTUXf7w6SipAguKQD2i40oHfo/CwTnaBYUJAng6KijBU+o98Gr/v+OBNAp8KAObeEdfC
	7nA1iaxAUBk0xq/cv4jnWTLow4sbkISSu21+qiroI=
X-Received: by 2002:a05:6512:6090:b0:5aa:4a98:bdb0 with SMTP id 2adb3069b0e04-5aea1e1f0b7mr1018255e87.4.1782406428458;
        Thu, 25 Jun 2026 09:53:48 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a543sm2828849e87.13.2026.06.25.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:53:47 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <amartyniuk@astralinux.ru>
Subject: [PATCH 5.15/6.1/6.6 0/2] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Thu, 25 Jun 2026 19:53:31 +0300
Message-ID: <20260625165335.162311-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Martyniuk <amartyniuk@astralinux.ru>

Fixes CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()

Link: https://lore.kernel.org/linux-cve-announce/2026062404-CVE-2026-53070-0031@gregkh/

Petr Machata (1):
  net: ipv6: Make udp_tunnel6_xmit_skb() void

Xin Long (1):
  sctp: disable BH before calling udp_tunnel_xmit_skb()

 include/net/udp_tunnel.h  |  2 +-
 net/ipv6/ip6_udp_tunnel.c |  3 +--
 net/sctp/ipv6.c           |  9 ++++++---
 net/sctp/protocol.c       |  2 ++
 net/tipc/udp_media.c      | 10 +++++-----
 5 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.43.0


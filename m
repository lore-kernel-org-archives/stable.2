Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136664119E7
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572960; cv=none; b=BLqBYGcib3ZwYcDKqdZOMMzuJG/A29JPl0v4iBrP82ac8uy1vkAQeYH/C21ka8xayNPOAckyvRQjVlyJEMfU6n59o4+1UysppyuAXxamdfBWI3/P/JHp91ypgbZ7vBZJF0kika+FdZ/Sxjq4OQE2p5xv1/6lSS1j0cMFK27W6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572960; c=relaxed/simple;
	bh=iIazRueLgCwdpQVvBzVvZ3MoLhiaggQsU7v7PgtD+mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoelbG7j1lrby2beoWvsOkzVvSLMBy3cDX/Zg0BnFkYgr/2/ZKQLGYKG/V12335vYVvsKN+kHm1tIjVjyLNAIpHjBdRw1+8BZyi4PUKgeCzt16sRO0ayjSWXGbM1mRVVbwgN6FcxpMYjWhFIrgydUGbPa2BhIGBhoZodgXAT1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IAh0RxaC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IAh0RxaC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954d29264cso7349575e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786572955; x=1787177755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uo5EFl7Rsrbk3IVJayjNPBdLiBo/0qtTpRx9EcPPCkA=;
        b=IAh0RxaCxipOh5bIRlDuq+yxpmi9JeToDrbupWf3q76SgC+yU20ya+d6HvJQXh41N8
         bvlzhFwGA2eqO5JYVS9pBu++nrVplLjQe0DI7hTAjDY55Jw+X0PK7f6MHR6hXbeVFoLO
         w28fk4BhLuALDAbr1AdWcg/7pHyZDwCBQ+7qUepQNvwC0vUmKHL//7j8CdornRgXKQFr
         R4IEls1qwMjeev68UYOivcxiGFNnDOvepvxBRM1idyAeuO6nWfBgVC/lmzHBe801n8PN
         JPAWiR/CpYnSRdagXZEFzjzoGAvB/QhXqSdjV2irwtLV4VTxurBlUijYMmSOi4S9f+gU
         Xl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786572955; x=1787177755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uo5EFl7Rsrbk3IVJayjNPBdLiBo/0qtTpRx9EcPPCkA=;
        b=PnEaB15kDh54MVkuNs9yrOPXTssL/+UPO8MwpeV5I97uIYyUYmB7y25Dr5ZAv+Prri
         XZC+CS8tpVzVZJ153oMs4Mzv2GqhECOTmsLdLKCJy0H2ScCpqrFXT5mfSHenuEGxEMcW
         0SAvUhE1TlruGysJcR2IBV6Ztc5Vb9JNM820bhPEQiE8jtcrWjbwBqP0JAo44vy7d/GQ
         /V1Hkg1jLnTlYFvRuZbcjxSIQANcOIO0Jb4kmsyWe5Xa2dbAuxTzS+NafkGbesQ00yO/
         tKwcVqFcXWil79S6nEwbUvpwrEXxMBZKBaHI694/fPsoHWBlm7jybjefUcXHzsLuy9nC
         qLog==
X-Forwarded-Encrypted: i=1; AHgh+RpfErt769zghc1KUy3mbRfsx4foZhBwOgHBQUWs7K51hQ3xVP1aWDFzZaP4a/yyZHci1AJ81C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamOm9rtmP6NenvRsTjoJEtFCzTjH5zonejTpRs0QD/5ldEIbT
	o1LjhNIhOG6pw0y62RFE0Pp5P47atfjLwvQddwHctL5/PvgrW57IXYaWpyo3IikUCYIACBWsBSM
	eA/eznms=
X-Gm-Gg: AR+sD133azQKNhd0TbQsrmKOdeYTmPtyRKA94owrDGn56YpqDYuT1p3Usmv4mKG0Z7X
	KkYcUsMhRqklx8pxlZ9hCPC/DDBTthr5P2/chlRwVDBifNrYfoTkNV5U0WxXssnYGMgPOxXhkQk
	YrkdVAXEav52EOCIPALyA5c+vGGWtY7sx1MEYBLFVd4ZZO5F6FIyp78XLFpEqRtBgjSnpJe1cyS
	3rq+NsVFEGW1F7fRixCxL21iC17SPGF2WoOMwEleo/qaPravigGEmDg76EkclXKC8+2OZ5aSpgs
	bz8aQn19oDA7CasbZiVTjixlJdnDr8diFdLQq59egOsuw5k85A1JKLqKQtCEsaFjvfcB7bjGWlF
	FYVG28uF6nDE92Iyc72vdTA3aHLpcGGOdgnvIp0gkiegYnZQnriwr4UKfj6YMvyOkB4Ardzu3Rr
	V3Uiz0xd07PvuOXDVzxz12cxShczFQOcUpw0sm4Zuip2jzfXUoYiZUNEDk7+NDDOriOf7+n23hp
	S/FHk6dHMt0glA=
X-Received: by 2002:a05:600c:19d0:b0:499:7024:9d4a with SMTP id 5b1f17b1804b1-4998218db78mr9601255e9.8.1786572955377;
        Wed, 12 Aug 2026 15:15:55 -0700 (PDT)
Received: from dev-jrangi.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm933792f8f.11.2026.08.12.15.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:15:54 -0700 (PDT)
From: Jasjeet Rangi <jrangi@purestorage.com>
To: x86@kernel.org
Cc: jrangi@purestorage.com,
	tony.luck@intel.com,
	bp@alien8.de,
	tglx@kernel.org,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-edac@vger.kernel.org,
	stable@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	yazen.ghannam@amd.com,
	msaggi@purestorage.com,
	rjethwani@purestorage.com,
	rhan@purestorage.com,
	dgiani@purestorage.com
Subject: [PATCH v2 0/2] x86/mce/amd: Fix inverted interrupt enablement during storm handling
Date: Wed, 12 Aug 2026 16:15:12 -0600
Message-ID: <20260812221514.598842-1-jrangi@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This set fixes a bug in AMD MCE storm handling and renames a variable
that could have led to this bug. The variable rename patch is split from
the fix to keep the fix minimal and to allow easier backporting.

Patch 1: Fix inverted interrupt enablement during storm handling on AMD

Patch 2: Rename MCE storm handler parameters for storm mode

Thanks,
Jasjeet

Jasjeet Rangi (2):
  x86/mce/amd: Fix inverted interrupt enablement during storm handling
  x86/mce: Rename MCE storm handler parameters for storm mode

 arch/x86/kernel/cpu/mce/amd.c       | 9 ++++++---
 arch/x86/kernel/cpu/mce/intel.c     | 4 ++--
 arch/x86/kernel/cpu/mce/internal.h  | 8 ++++----
 arch/x86/kernel/cpu/mce/threshold.c | 6 +++---
 4 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.50.1


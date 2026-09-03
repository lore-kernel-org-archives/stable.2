Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8830E83F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405246; cv=none; b=mZHD8NF1S/1yq5J1j6qniWGaSOhgbXrYTP7vuTpiF4fR/qqAc42WnxhnajACbuUb6E8tokIPgRLia5MxXmLOxXT6sYICXy38xN5Qjf0BL8y7fpC833XH34o7ODC+0L0jOm7sB8WlNkZtpNNpkosuR0BEL7oyuSTb9sZF3jmHFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405246; c=relaxed/simple;
	bh=Gdn6FlTTrtnoQY7PyAJfU2F9mE8bnDKAHVlEH3i2pI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBjWwzvmTBzqwxKC94YT0nqwfRz9M6VQmiOEjF+JMXB1ombdsgeDJPFFW03NfO2Scy5VEJy131eou+jXUMczVnhFjWGS8KkJ9bU6giPPIn9Yrbjy0vt/Al4uCNmNa5PMwL587UA/6N81ZLrFB0TbuEQAWOCUOXD8aD6xubRbjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsI7vf+d; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsI7vf+d"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d53197d8b5so16997365ad.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788405245; x=1789010045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vESU/1COBgvnCI0rsLCZoKytSIIaf3V11jedMnJg7JU=;
        b=bsI7vf+dc/Hom2bUfNW2LIsPdRYqWhGggoiRxXQBLrsFf651ewjgPOY+T/QMe92pi2
         qaZ10i5GudVWlMJ3l+FrvWMFvKrmlAQ+l/aDI2V7r6JwzkDuDS5C0kbQ0ZjVXrqcPVrT
         dNBtlukCor+ejxIvA9udM8mp4nbR/qRobRXqut0Ym5hmEuUS/q55RnNC1MB5+q1+VB0k
         3Kc6zesKY4j4uMJx5VQgjSyjzQbGbf/ROxfdwn2X4JFGBm7Hxf5ptwhcdjQSpwstUjeE
         gFyOP1Gj3SYoDgzpH0XDavI3478dQIuIYbLk8dlY5Psc4A7kQbcHfxhwNy9JVtX0qLVM
         fHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788405245; x=1789010045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vESU/1COBgvnCI0rsLCZoKytSIIaf3V11jedMnJg7JU=;
        b=Fg20U8veCLnOa6Wh6huqqeKP60IIUE+M3WzVddKCsVaWSW2qG+SqpRcqZwrG3PDp8K
         AnHdIvFSXGdjkKCPBlF0q99JqdEpqhX6C+lVmAyjfLOXEzk8jBdApMNh9gkyheOcET2U
         7LRTZIHcI0eDE9zot/tKqOtGl70gpS0eBZ4ZPpmIKN/r0Qi96AqSPiEpx6UX3gOTaszu
         /maSg2IWTzjk0dqd6UPxunIBbbhXLZjLmtq76QISpOzFTi/Y7PLGjqvV6ZW408Xta1it
         xGQor0R+qUd8LF0mjDdfNFQo9+Gzz/eMCOHQRpbbzztglY/DAashutCMAnpEHe7QYF1a
         s4dA==
X-Forwarded-Encrypted: i=1; AKwUvBwjsL0VuzPoX3wCxJoBXwsN8aRsi2IM1lzZvKIw5C654B8mQtb4tObeKt7Bq26FBujwTExH5TU=@vger.kernel.org
X-Gm-Message-State: AFuF++l6b7vIcq7JdNotBRMP1mk6J68P5fcINBmLXCNz0LbF4FA+h/BS
	4L0aeTPHJMT1PBFKbcX1XF5CPRkPaCcCZGF/BeDl90dPCilYZoGZGiP1
X-Gm-Gg: AYBFou2tzyYekwdFdD7La7xY93TiLfloJ6giV/HHWlsEOmvv6LdXNXe+lmmaEasbnEg
	k10PYVBo4VvP/PNAYxNLpu4df5gGGX6qmRRMXZ7eYD4XO7wHHlGIANP22rmB1pJw33p2RTKNumw
	AliJc+P1/t09hxoqR7NvncrEeZfCdWsBRqzlob4kYDH099M2oX7qLq7tu9OVoxOQpBmMGHNV/R8
	sU9q0TrLtbOYlgFsoWq6T680TFcLtb7019hbk1QLT0lDK2XxZgkNckvDLqYzFRcUfI4mryYewC2
	YzxXe/N/zyjbR2oDFVc6E1qEsZU5fSHSavMSpdsHPByXwn/+4haQCQ4nP7130DKWGCACKewKfpJ
	rXbX0wi5ogc+tUckavGm6u9f7ebU1f43OA3MgQ37YpnteTJPD8V4dPaE+eGxI+W9o4x9Yc4S55w
	3F4TQHYVU6eJvOeGoCXsUyhnD2wclR5uEfM2+GxseutZRiwM1sv13kfEYfBqDm/+fGU7WQebMql
	M1G35EoZXSTciKgp/1UPIIVmnqr
X-Received: by 2002:a17:903:1aab:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2daf1b16445mr104380145ad.3.1788405244535;
        Wed, 02 Sep 2026 20:14:04 -0700 (PDT)
Received: from localhost.localdomain (vmi2317720.contaboserver.net. [84.247.152.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe0e0d5bsm2824825ad.12.2026.09.02.20.13.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 20:14:04 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon: fix misc bugs in kunit, quota goals and sysfs refresh_ms
Date: Thu,  3 Sep 2026 11:13:28 +0800
Message-ID: <20260903031345.82679-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902002725.108635-1-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

> Patch 1 fixes the DAMOS quota goals commit unit test to cover a
> mistakenly uncovered case.  Patches 2 and 3 fix the bugs in DAMOS PSI
> goal initialization and eligible_mem_bp online commit, respectively.
> Patch 4 fixes the bug in DAMON sysfs refresh_ms file handling.

I reviewed and tested the integrated four-patch series in mm-new:

  a20e38846efb..72dc8fdaae62

The integrated commits had stable patch-ids matching the posted patches.
DAMON KUnit passed 42/42 tests.  I also ran test-only eligible_mem_bp nid and
two-kdamond refresh-isolation regression cases; they passed 42/42 and 43/43
tests, respectively.  Both test-only changes were then removed and the
worktree returned clean at the unchanged series tip.

These were functional UML KUnit tests.  The fixes look good to me.

For the series:

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Tested-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian

Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322F432BF2
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816662; cv=none; b=gsZV1/SaaNVa7ZXDtlgiVt5VmF+8BvFIWBQ/o7q666Wbq81GJTCKiTTDs7WWH8gqzqxi9rjMFPzzJRkFm2VFTVr1Q14Fn/YjMOm7gchLpOF8AvcglovAvLUCA6ZrFiiYiFZCM3PjSgFxLTSxfhDh7MSt2lMwDfYpW95mO9kHxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816662; c=relaxed/simple;
	bh=ikrScTc7pM6pU1jjxXgCeGnxZSGAjLDFh1sm80h3sNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h79NbL24aGcSXQFlsK+KFCljXJAI1Q+qCr26gBOjNwfIG2pVKIqQoJ8Xyo061uoNWxzp+JtK6pb8gJOoHWZnZeFlXyCTM1kK2p2i7iyUWoKP5Vc0KVY5chl0foUIxfuiD8PiLiQ7G15bOoVe3TERfL9okvwP91X+pbboGVw8/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HdNkN3zf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HdNkN3zf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785766400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mqR5JAZWbOvYHiaMBBemW1T1cBzfdsuj4QUZOW2/5Ew=;
	b=HdNkN3zfLY2/9piCOyhCP1sA+0oU+/i+Iuq4O0lrnfNlojBq2f1KUgZttW+5Unj+tNRpta
	v0AOuxHTgzLdvNwtaPjiY7Mn2e/PtgSiXmoIuUGgOWqzIn9ByZzzdWlWWvyqU1XANT3Q64
	h33V6cQR0m022Wfhkkyec/e/Ls/bEcE=
From: Junjie Cao <junjie.cao@linux.dev>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 0/3] backlight: aw99706: DT parsing and blank state fixes
Date: Mon,  3 Aug 2026 07:13:07 -0700
Message-ID: <20260803141310.1379194-1-junjie.cao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The driver reads its tuning properties under names the binding does not
define (patch 1), the NULL-table lookup path accepts any value without
range checking (patch 2), and update_status() ignores the blank state,
leaving bl_power inoperative (patch 3).

v2:
- add patch 3
- add stable tag to patch 1
v1: https://lore.kernel.org/all/20260701133918.33487-1-junjie.cao@linux.dev/

Junjie Cao (3):
  backlight: aw99706: Fix DT property names to match binding
  backlight: aw99706: Validate all DT property values consistently
  backlight: aw99706: Honor the core blank state in update_status()

 drivers/video/backlight/aw99706.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.43.0


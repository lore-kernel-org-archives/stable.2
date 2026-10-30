Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338964;
	b=Uc3B4i5vh0VUGVzjCJV/i5IRh3Wdpu/jv9QIsdor1bZP1vW++Lfk1bfc1bielaYUxoJ0
	 n6Oj+y08BCYwtfz4XKxYLedSDSPu3hNCWUAWXUDu4qjdsQrFUk4n8jHlPJlTtqsrmceoC
	 Kqtwu1E7pBSVIDtIvbrLOFh0jYPyTCJM/iKyoH69EJY3fjtBk/yuIVpOB+lZpfKoohaFf
	 tXy9QdvDKMlZ/j3hmS1xOdbJoBramTTdzwQsWz47gG+sK2zhrcLAkIPTxY6zoL69oKf3K
	 6DC6G6iaRGz24TXqVghJ6eTeQiE49QW6lVpn7rhnsrS99VfEdB86Xch+C14gdlCQxBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=12tXOxCPsbo39hlb1mF4iGYiaxkf5vgxLfHL6faGPYw=;
	b=lM7fSYV8vPXXwpW63yvyfjmh7/mcrjJq58G9uH6ZmPiXeUEncuHjmZ/0E/fDCQE9U1H0
	 uC2ycVp6PGv7jTH7xL0W9cfflMflHHd2oK8phfgCbUWEdoZYE0/YDhYhw40akxI1ExheI
	 uA/7p0wnw4c++gn2e8A4/He1qy8ULF3t3ViPS0GJytnloUl7nJCullvHEJ0an5fekIAOg
	 kjNfL5Mni4e4GMll63pHlYUnbJy+zV8DOnymu7tzl7pCVuRBKiK/jzL3m3/POKUXYu77R
	 bl8AcfYGQWXupXpGDuSfUsbpr0D2L7929j+MSozoj3HfgJSY9eWfZqV+4U6s3LcWtgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vMkfXhwf;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873E606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A873E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vMkfXhwf
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so58499c88.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338963; x=1793943763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=12tXOxCPsbo39hlb1mF4iGYiaxkf5vgxLfHL6faGPYw=;
        b=vMkfXhwfjyi4TT9vUKlVmpL5S1he8tN0Eb3OBr3LB+59kf0jd0sHTvjS0daU3xZirX
         38JOrj1dHn2bYAzvy8ok2PFdB5+NB6Gy9s1WZgqEHfOMmmsvx1qYK1DacHnPe4mFeudl
         +y7nq4O3NBjrzP0YL8fu0bEBEc8bLiM49cB4UGLS8jsYY+o01DjgY0zLBDRpT0ox6mmC
         16Q7N+X3FZzbKYJZbaYtdiewA9le8ZqXWwIQEB7o4FroqnRw/9Uz5hX9IWoPPOmkUqmK
         zEVD9+qKrHpzxdYsgyoXSXmXzCoXaXzCZDh5h9gvlHEYQ57w5UESvPOqCLx6xMIQ3kPG
         FZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338963; x=1793943763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12tXOxCPsbo39hlb1mF4iGYiaxkf5vgxLfHL6faGPYw=;
        b=UOrN2FvH7nRd6SpAciz0F0kbMTz2P0/XwUK428xGdhV4xVDcouf2SaO8lTeFRtXNyO
         gjrZw3xHh0T+d2oq5VkGZn1388X9Xx8XR19G9b3WWuXwVbQBhXkuRadaWOrdu6Uad06d
         14WNHCeJyTzHRcCKTm7WnGBXtHrAHydWcP5RvMVR0WU4/PsAjkQ61wZVLqYuhAZklHEG
         xlgMhjTQLmWpkui1D2vffS5bJZUr31m5pOwBXut6ZB8MNJdAyPNP8TDTC5c+7LjZX7iA
         I6XDP/Udm+B/GdGIH9D7ci0gWTtprGbO8LqezAHXWxfbb7aOlttCl4R7fEafrhATqcCH
         hLIA==
X-Forwarded-Encrypted: i=1; AKwUvByZYUPS6SkuicCNoYVKJfZhUdhFan4Ud07XwWAasJF6lB2ENipdNoAqICoWaT9ujO/LoIJy4aY=@vger.kernel.org
X-Gm-Message-State: AFq9FYITf6/IYmcEdMtagzpgGSTpZmeSqD/YsWVuL8zPQm42CNWA3z9d
	CC5JHvtgp5ExTLqE0hIkUUH6CkdPSAG8cyRfMsCP3pcXVh1BclB2YAgj
X-Gm-Gg: AYBFou3nK4FZIOeDBBD/G1z/HcezjDXzlT1Q6UJJgtQj0RLO8kYoPtHW0IKMIw+YIte
	y3WNhH5MzaJqSjW2gpBiKOT6XH385bUfH44bhv/zGrIHY6ICGVB3XyoZXN+3WxaoNidjvClRBcm
	mmtoWFFi2Bs2TPTLuu1EGX5ZRSrRLTPWcESBltRRnF5/1bxkO6gsWSulP8/4F+KNnfROTBrKbYu
	RK3KZ76Mi7Cp2/cCQeMqGHMrivcpgdZU4OAmWfetBbxmR+vOdov+r1RAfORhYnTS0oeBJ2wbI4F
	6zR3mVyqBWrfXKRHB1DM+ae9W5bi+vGcbb2jTBS6MwrJgRyMwcmMnvTGs1sWk7K69eVCrA4zdvz
	L/vkVQdThkMvQnWr11N6gkca5SixPn7DmfiH0Xu+1o7qAvX09/6AQMBTw1+FaUdlaVMFfPMLOz9
	4NdhaL0fgVFx5pWkHAU8jHjxklQTFCK3oWcnRwhuyuoB181bUEOUGtUd1KanQjsVciPFEg4tMEt
	R377UE2D9YC+wGlqaZsVnI/Tu9H/8GR+1spcI9JW8qE1EziLfPdvyNRrGlBP9TOQHZhxRi9a6E/
	ROxMWQHa3Bo4VLKjSb6sRdRuaW7wXda86MJYvQGLAIQwzsz0O9DlJwjg
X-Received: by 2002:a05:7301:82a:b0:351:dbc:b663 with SMTP id 5a478bee46e88-36a4244f9f6mr2418639eec.31.1793338962362;
        Thu, 29 Oct 2026 22:42:42 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm4380426eec.26.2026.10.29.22.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:42:41 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: tglx@kernel.org,
	jstultz@google.com
Cc: sboyd@kernel.org,
	mlichvar@redhat.com,
	akpm@linux-foundation.org,
	oleg@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2 0/2] tsacct: keep task begin times stable across suspend
Date: Fri, 30 Oct 2026 05:42:25 +0000
Message-ID: <20261030054227.35453-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep taskstats begin times stable across suspend without changing the
MONOTONIC elapsed-time fields.

Patch 1 makes getboottime64() sample its offsets under tk_core.seq.
Patch 2 uses that helper and the task's BOOTTIME start timestamp, and
clamps negative begin times to zero. Keep the helper prerequisite when
backporting the taskstats change.

Changes in v2, addressing Andrew Morton's review:
- Add the getboottime64() sampling prerequisite as patch 1/2.
- Lower-clamp ac_btime64 without imposing a 32-bit upper limit.
- Add Cc: stable to both patches.
- Rebase onto mainline d89e1d186ec9.

Validation used GCC 13.3.0 with W=1. ARM64 and native 32-bit SMP x86 QEMU
guests pass all 36 checks, including the original 24. The 32-bit helper
stress reproduced inconsistent timestamps before the fix and none after.
Suspend time was injected through the real timekeeping hook.

v1: https://lore.kernel.org/r/20261026005506.2253-1-dennylin0707@gmail.com

Hungyu Lin (2):
  timekeeping: Read getboottime64() offsets under the sequence counter
  tsacct: keep task begin times stable across suspend

 kernel/time/timekeeping.c |  8 +++++++-
 kernel/tsacct.c           | 10 ++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)


base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.43.0


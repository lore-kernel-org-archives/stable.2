Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233542C032C
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524471; cv=none; b=a59VTE5OSorsdojgstUWAfQw0y9MujQEQ44fwi1/eLJkQJjXQuzEYAl6tLyKCS+YZ3w+rR6rG7L9bhlR5CFPklrKKtvwVykPWgl0Bwkb63uoJmU5eSTCesJq89sYwWjZB0b/FAwUBKbVhomvGdMsyPxO67Ugx8x5IgIxp2O5NeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524471; c=relaxed/simple;
	bh=jJQBi+FJvmoui7DId5x53h0UMdloG/hSLE5o6TbVpg8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q6lU8tgR4vEghOyPc7z9DP1/XDHpZxUP/VYL8kMNc6Rmnf+GE2iYkx0/9sjH7qf39V0zkg43g6c4Ph5v29HUmfWjSLG15DhfSmhOoiwkL90o3o1W+QtgOf1JHBgOBMNvTgqPHaEHWNhocNYicCXK5C0uATyr+FLgQvZJZtBPgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZoNs2PW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZoNs2PW"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aea0fff535so787760e87.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786524468; x=1787129268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jJQBi+FJvmoui7DId5x53h0UMdloG/hSLE5o6TbVpg8=;
        b=DZoNs2PWo8UvG2Q3EdnnJPznz4pFZzbSNYMn02ktoJ9rV327JBJFGDCJE3r6BLXSuH
         03aGBIsMvU4sHFFNAvpYsGAGJUG7tSTaDff6W5H/hFiw7P1H7Q2EJKt18Nfj1ytcurGt
         PyMGeKMkCzUduC6sIz3Uv76++IZUPcBOUprtM7TNzVJfZJWWplJkZFRIPuePshCrPNG8
         ZY8H5LdMhC2qXqE73+dOyJLqCcS+2+feeWmoGTQ9cvm2Q5F6oFFNvtqpwCg3bW3H9XtU
         x79ebygg8eUEoTMMWUhm70pQ0TD05T8zNuTtbcdk2aQWM6L08vuaGQgll8MIskxMWCVz
         VYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524468; x=1787129268;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJQBi+FJvmoui7DId5x53h0UMdloG/hSLE5o6TbVpg8=;
        b=aPmUtBzmwgmmgNcZE3pFpEfWiSi+Wh0e6gbV9ePt6VEduM1WKCDdjymJxnVS4edR9r
         8UPg997FeTyo0LvQN2Z5Zp9gjKEhzg9Zcawyg+J8RnEY+EAXpvxjuOhs/KQV0I4pHvv8
         G4E0ERWuJ9dLOTUGz1JZFU9Gac44ujD6HdTrm5hYkhg7WBy0iC6o1K7lQCuK5Z1BL2Qb
         sfGDAPbeu5p8g7+YNeAel3O9RUDBlqm2N6XIm8hTqw6nKVTYfyr/fjOKbQmsNbgV3Loz
         UA18irFY5DXMjzidttTf6YcYvBMpYEI4nPVmDmKJ0e2GNyspLTtDtj2UhO0L9FTh6cdS
         DQZQ==
X-Gm-Message-State: AOJu0Yyk85s38Hc+0dYeOQRxF0b2smNyF+HJp16zn9T0F1d5xSrWggfI
	yy5/OlsMefBv2rCoFWj+E40OOGKnayY6N4kZQ8BzbIeNKrYIg1Pvoi1x
X-Gm-Gg: AR+sD13jb3xERFDONvDkpzjxR5vY1QeuVAfwG+7BRDsubYqmE3Ue3YvrC+gtZZSIJ9Z
	HWa93o7OF7WTPMpkM1kVdKeebsqSm+symH3s4z3pjqBiF6Fqmeu1DnrsK9uGXTa6zfOwroMZEgG
	yPOrKsg+WVGFbfeLNdnlF8evLImGnM8yuGe3LicjP9JIz+L8mKqaaOWJfJa7YF/dM2TQIaD6ZFt
	15WeE0NwoFtLd2YoVRwg2Cg4QPYmBgXow6nWOFmeFNz2JwE3YRqHMjv3xsJk0tEblCMsnEyTDYC
	y5YaEFLf5obc5p/epG67rW2iyEZRo83lfR9XbKzTQ35n+k5WKbNK/f0hYsEcKOzLiZhH6Iw3o/S
	YHv0PvwYkPQpG4OOHxB6eEDwOexamSa0dBmYQMJLUymZIq0kl2PZl3JPijETaDli9lUfDUccKPW
	ANt9lEejyeWSSU1IRr7FouOiapTgS2+Xdb+28=
X-Received: by 2002:ac2:4add:0:b0:5b0:1685:e369 with SMTP id 2adb3069b0e04-5b44e32a023mr342278e87.42.1786524467770;
        Wed, 12 Aug 2026 01:47:47 -0700 (PDT)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44d053d4bsm353783e87.80.2026.08.12.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:47:46 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date: Wed, 12 Aug 2026 10:47:45 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Brian Maly <jmaly@digitalocean.com>, 1143545@bugs.debian.org,
	Zeng Jingxiang <linuszeng@tencent.com>, Wei Xu <weixugc@google.com>,
	Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>,
	"T.J. Mercier" <tjmercier@google.com>, Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Please apply commit 1bc542c6a0d1 ("mm/vmscan: wake up flushers
 conditionally to avoid cgroup OOM") to v6.12.y
Message-ID: <178652421812.722408.8065577541585442120@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Control: forwarded -1 https://lore.kernel.org/stable/178652421812.722408.8065577541585442120@eldamar.lan

Hi stable maintainers,

Brian Maly reported in Debian (bugreport
https://bugs.debian.org/1143545) when updating from the 6.1.y series
to the 6.12.y series and noticed it is caused by 6.12.y missing the
commit 1bc542c6a0d1 ("mm/vmscan: wake up flushers conditionally to
avoid cgroup OOM"):

On Mon, Aug 03, 2026 at 09:52:09PM -0400, Brian Maly wrote:
> Package: kernel
> Version: 6.12.94-1
>
>
> After upgrading from 6.1 series kernel to 6.12.x series kernel, a
> performance regression was encountered.
>
> The customer is experiencing:
>
> ~2x slower execution times for write-heavy workloads under tight memory
> cgroup limits (~256Mi)
>
> Significant latency spikes (median 14s vs 7.1s on kernel 6.1; max 23.5s vs
> 7.6s)
>
> Occasional premature OOM conditions
>
>
> Root Cause (Identified by Customer)
>
> The issue is an upstream Linux kernel MGLRU regression:
>
> Regression commit: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging
> cycle") – removed waking flusher threads during MGLRU reclaim, causing dirty
> page accumulation and reclaim stalls under cgroup memory pressure.
>
> Fix commit: 1bc542c6a0d1 ("mm/vmscan: wake up flushers conditionally to
> avoid cgroup OOM") – available in mainline ~6.13/6.14 but not backported to
> the 6.12.x stable series (no Cc: stable tag). Ubuntu had to manually SRU it.
>
> Validation: Disabling MGLRU (/sys/kernel/mm/lru_gen/enabled=0) on kernel
> 6.12 nodes restores near-6.1 performance and eliminates the latency tail,
> confirming the MGLRU reclaim path as the cause.
>
>
> Please include the fix commit in the 6.12 series kernel.

Can you thus please backport/pick 1bc542c6a0d1 ("mm/vmscan: wake up
flushers conditionally to avoid cgroup OOM") for 6.12.y?

Regards,
Salvatore

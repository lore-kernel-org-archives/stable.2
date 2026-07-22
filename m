Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E313EA955
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739266; cv=none; b=XX5Txv+loZ8MZQZx9KMdgsdKl5+aRt4mG5DjHo2PB76HyV0ja+AQTYzKxuChq1yA529WxITf8nrUFGdwg515yTDGOxRlcMZwx1DyJ+iIjOcyziirMs7LlHD8dhIvfpCb2KHCvbep6kmucnDn8lkVTN6ypwSRtwRHCG51fC5cAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739266; c=relaxed/simple;
	bh=oyMK+goq0txSrAys/ktX7587DQsrOSPp9z91wZNt9bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESwaB3Oq5WpjGNrmJYUDl9opzMul/CSv2NspxFz2oTmMoSXAmq23Z0lKsUfOl30+vMUXg5uKfKANqGAA3/ukHQTXhXUn2CLA1XJEn7jrcShxoK/uUCcBUioNexqQg7lUTR3KsdAWLH4+rXf8AWeMZDxxizrcrKqEtlA2ZVNrLyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=WeY06wvQ; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="WeY06wvQ"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h50hm1zjpzr32
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1784739256;
	bh=HYBKJi8bPiw5oZicKeChj/Z6qJNHsFz1b6muPygUJlI=;
	h=From:To:Cc:Subject:Date:From;
	b=WeY06wvQdmSuL65OYd1KBuMS+z5Aq0ZSoOoTdQsenFF9vAolJTPvFusdYcdoPIGJt
	 EN3vbcoJM/1+LauExdPenbCVPLDTh7Ue5hQbGJQEU/KxfvP5OkVKAqsvmh4e87z4SI
	 9tiljDOJXln9Rx/4U5hhAvpqfON8Vw6xDmT6JL69KgCvOUIqhKChpBaqjd7ZZXaMYi
	 gbnXBPAUVfs6VQoQ/e7WhbCbplpP8mEAFOQ1WsEqhLU9jYqB5lWFt0o9Rm3Yi6RUyA
	 VJvMtNWqq4anXwRD+RCQ6AmCJ3T8mGaCERfg7nktNE54SNKewpDpkPXk9Ck9a9mh7L
	 b7evLeVkmYlCw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h50hl5Xh9zhnZ
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:54:15 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Wed, 22 Jul 2026 18:54:15 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: stable@vger.kernel.org
Cc: Daniel Gibson <daniel@gibson.sh>
Subject: [PATCH 0/2] amd_pmc: Backport additional delay_suspend patches for linux-6.6.y
Date: Wed, 22 Jul 2026 18:54:00 +0200
Message-ID: <20260722165402.3199573-1-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

These commits belong to:
bc08f495c7b8 platform/x86/amd/pmc: Check for intermediate wakeup in function
caa25575c3c2 platform/x86/amd/pmc: Delay suspend for some Lenovo Laptops
0c9901b84b59 platform/x86/amd/pmc: Add delay_suspend module parameter

The "Don't log during intermediate wakeups" commit prevents the
aforementioned commits from spamming dmesg during intermediate wakeups.
The affected IdeaPad devices have *lots* of intermediate wakeups when
charging while in s2idle.

The other commit is more cosmetical, but is also trivial and ensures that
the log messages log the same on all kernel versions with these patches.

These commits are already merged in mainline and in the stable-rc
branches for 6.12, 6.18 and 7.1.
In 6.6 they were missing because of merge conflicts. I resolved those.
See also https://lore.kernel.org/stable/2026072230-volatile-citric-73fa@gregkh/


Daniel Gibson (2):
  platform/x86/amd/pmc: Don't log during intermediate wakeups
  platform/x86/amd/pmc: Avoid logging "(null)" for DMI values

 drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++------
 drivers/platform/x86/amd/pmc/pmc.h |  1 +
 2 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.48.1


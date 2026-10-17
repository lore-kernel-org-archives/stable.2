Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726F22F767
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247659; cv=none; b=Q+dS/dV2jJyzbjnFOm81FUmTtAs+05OLCfrkvm08mBM/TgtXdDyolh8VuhzjgNqW+gdkA4HztMrEG6BDOq1M8n2rdlImLOoQBEpXBJJSVSAIjvfFQDu7EiReQr5O3SRrW5MdsTkr8dpGRHvPM4uUwWLLBWKJB8aUItuE1n4dG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247659; c=relaxed/simple;
	bh=yN0C0qhw4onW/qvKGRn+3WMMWq8Q4ipIFte46KVG2OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvucRnWs8k4g3gz38wFw3KpKoFrFks9vsC3qUjuj8m/FF4EvPVnEmw7G5u4MtprqU2VkwyBzng14UPR2XH3IFS9hQlphM7BZ5p+hLBXii6cCkyIeG8Rhn7yVVJ4dJrrUNqGHjNzZsaaCzT54zGD5pTi1V6weBm8wCDpq7YgziMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=MC2ni410; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="MC2ni410"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d502])
	by forward206d.mail.yandex.net (postfix) with ESMTPS id EDF2482EC0
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 17:26:59 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net)
	by forward502d.mail.yandex.net (postfix) with ESMTPS id 73F7CC0145;
	Sat, 17 Oct 2026 17:26:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id VQYgGp9dRGk0-6mIrrFy9;
	Sat, 17 Oct 2026 17:26:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792247211; bh=zHdS8fzX1vnITF5pIdH/IG5QQ6eX0WxwNF77nTGlmNI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=MC2ni410jK1cNDj3aw5JjFvLQGuhszJMRZ8RX3EKJT98sAn48++XeHrgqG5p8Bvmo
	 Mk2UOwCigfkZEOwPoKAzoT8x2FLBAA7/Mn3GI2cm40OXdAOxToSJC3gpa9r7BayOU4
	 XfbIzWQb+KYDOIt0LuUyzn4zVaPztKwik8TYN4bk=
Authentication-Results: mail-nwsmtp-smtp-production-main-63; dkim=pass header.i=@yandex.ru
From: Sergey Armodin <dolph-in@yandex.ru>
To: Maciej Kucharek <qchcio@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0
Date: Sat, 17 Oct 2026 21:26:28 +0700
Message-ID: <20261017142628.9186-1-dolph-in@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015095713.20560-4-qchcio@gmail.com>
References: <20261015095713.20560-4-qchcio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maciej,

I tested this patch on a MacBookPro14,3 with the Radeon Pro 560
(1002:67ef, subsystem 106b:0179, rev c0), which is not in
vi_reset_quirks[].  The kernel is 7.2.5 with commits a5be7ad8f5f0 and
a22e5e4f2ebb backported, plus distribution patches; amdgpu was built
from that tree with this patch on top.

Without the patch this board boots with VRAM at 0 every time
(MC_VM_FB_LOCATION 0x00ff0000), and a re-post moves it to 0xf4fff400
under the driver.

With it, after both a warm reboot and a cold boot (powered off for
three minutes), amdgpu logs "PCI CONFIG reset" and "GPU posting now..."
on load, VRAM is at 0x000000F400000000, MC_VM_FB_LOCATION reads
0xf4fff400 through debugfs, and there are no amdgpu errors.

I then ran five S3 cycles with rtcwake.  After each resume
MC_VM_FB_LOCATION was still 0xf4fff400, the GART table was at
0x000000F401B00000, the internal panel came back, and the kernel log
showed no amdgpu errors, ring timeouts or IOMMU faults.

The 560 is not in vi_reset_quirks[], so v3 3/3 behaves the same way on
this machine.  This also covers the one-line quirk entry I sent for
this GPU [1], so that one can be dropped.

Tested-by: Sergey Armodin <dolph-in@yandex.ru> # MacBookPro14,3, Radeon Pro 560

[1] https://lore.kernel.org/amd-gfx/20261016-amdgpu-pro560-quirk-v1-1-3e5d3fe5ff29@yandex.ru/

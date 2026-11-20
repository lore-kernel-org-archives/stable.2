Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170889;
	b=umaMcAnJpdN28MkcYVf3wMOelY/KyFK6Mn65/gB8ex68gS+2eRQ8miTU2YDvO49MWcVE
	 zu70SQu9qpFaWysYEoODP0S+8zMTS9BzJ/BlMzS8qYTCFGk6Og6eE/cVP8i0I9e6GqksH
	 CTYD2kjzj0e0WwpdqiRM8215p4Gkc6JClbf72vqVcxWGZHfaRh7yTDCKvbM2rCX+0EHWh
	 XZoqFiBvAkAIhLn8hhlt25zQSFK4hfj1XuNHvu0zf2FOBiQ+0C8svLtXdzibR58dA/5Km
	 YsYnP1dq+dUxKrcsWIMfDfma5HXyDZ4b5e4FmcknorVUcCJ6Ox1+7aR/0BuWGNX9leg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170889;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wQqfgunTLnRwvEQh/g3zIyzHHyLtB+m2tV6o9f2aJHQ=;
	b=DmuhIj6r60MAmPPW2gJ71CfI8/K6j/FV29AGV7a2cbpR9eOleAoh6S1Le06O0BijB6kT
	 lwSfwjLf86RNM/er2bnwtLMiyg8zMFDYPXmG2PCXEU+bDfAyV2XdJJm17fIb2LcLtk01L
	 v625yqo5BLpAL6vVF1Nh6P1yLoTZmrukeFFOCdIfJhEEijwgtDVgbfoQOureVzniFjv+/
	 QE8pzOJwpt5hfm1vKSkT5N8y5Lme0idNDOT6zHuf6aD5LR+K40yz5WKgzDIGXeHbTrigl
	 EJx4GYtwZGY+80sQye8ZRfNmOdbQ9Q099T1c6q0NnnFqXt1wSfjaqEaJH3IzmFrxyww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVzFkiUi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D4606A325;
	Fri, 20 Nov 2026 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVzFkiUi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DAF1F000C0;
	Fri, 20 Nov 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795170889;
	bh=wQqfgunTLnRwvEQh/g3zIyzHHyLtB+m2tV6o9f2aJHQ=;
	h=From:Subject:Date:To:Cc;
	b=UVzFkiUiMwNUbS/HWiQlCYAU6Kqri6wlrHFzHqicCWVoNn4OeFiMXdh2lSdq3M9Dr
	 37Qoq+GgPti6suume4wRMhjy0rZ3b4tnuw8XXxovm+Q+vPB0kdW3XNC2jpkSN9V/UX
	 3J85NLshKtgQLLH+eFsHJV4F9yQvNgHKLti05K3RmzTbUsEwasTSukpmTlJFxd3HhU
	 fpeAyRcUolnaVn3/OtaovAZeWaf1hm3Pf0vRfUaubH8QmO7OcEmu+8IpQ3MW9K+uLA
	 T/Yf6qIBXYDhcfOwx/pmRDbBy/00JAehm8V6GDNEolexVF8jvSK+7eMw1E3NqiTU5A
	 CUCz/llR9Lx4Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/2] mm: two NR_BALLOON_PAGES accounting fixes
Date: Fri, 20 Nov 2026 11:34:41 +0100
Message-Id: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCMBAF0KsMs26gSSViriJSkvqtIyUpmSqF0
 rsXdfk2b2NFFSgH2rjiIyolcyDbEA/PmEcYuXMgdq3z1rrWpJNJcZpKyX2u/RxHqDkDF5+6hM6
 DG+K54iHrb73e/tZ3emFYvhXv+wHMEPScdwAAAA==
X-Change-ID: 20261120-b4-balloon_nr_pages-7ee96b3be36e
To: Andrew Morton <akpm@linux-foundation.org>, 
 Nico Pache <nico.pache@linux.dev>, 
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Shao Mingyin <shao.mingyin@zte.com.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=david@kernel.org;
 h=from:subject:message-id; bh=u8RpUaqYDleLKlHxY5TTxwcSUWPuzOrFCFR8UGPSP4I=;
 b=kA0DAAgWx+nLGEVVu3kByyZiAGsAIkOi1KpWa7nTJYIQCaa+Cb0UW7jbV02GcVHHHGiKZwQwe
 oh1BAAWCAAdFiEEUlPfMOnprn17Rg4Dx+nLGEVVu3kFAmsAIkMACgkQx+nLGEVVu3nEEAEAt5h8
 G5dAvgmD7YbKaOmb6YJNykDvpfMLWWyg0r8D6ZAA/i9ruCfdvmaJuFw7O7MLlkLsBMm9G49oxuc
 QvUnxsywA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

two simple fixes for NR_BALLOON_PAGES accounting. I can take both
through the mm-core tree.

I tested patch #1 briefly in a QEMU VM with two numa nodes.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (2):
      mm/balloon: fix NR_BALLOON_PAGES accounting during page migration
      vmw_balloon: account 2 MiB pages in NR_BALLOON_PAGES

 drivers/misc/vmw_balloon.c | 4 ++++
 mm/balloon.c               | 5 +++++
 2 files changed, 9 insertions(+)
---
base-commit: f7d95bf74091373fad7273db4557df9b5a902335
change-id: 20261120-b4-balloon_nr_pages-7ee96b3be36e

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>


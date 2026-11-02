Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618087;
	b=vsAZTfxn2NZ3jTMA9ZolcRazLENqqRm7FnOu2f2Bunn6zTWso4VIETl+za7wAZkQXqUk
	 p3VcfIz/VohkTAjqsZHrV1W1kgtZpS0GSHJMmWXFIs+3SyzO9fQwGSOIW4TYVKvoVYHW3
	 uzTuN9u2OwZx8oNl8ZP8q2OlCydnQ0WcLYis0aP7sBrt9Nj1g2ZAgsM2JZNqGEmbHopv7
	 xgVgp4JLZRgDz+/bAJVuLmY8fuww28CnUl9yUcyWq8rIt3Qdh3XyngDs0Slqc0uTnTE9D
	 fsrDQrdSBXX+r+ZDMKS7kx4RcMhmdMTav32xeweuoh+O5Nuc6NV3kRFSLlTOnpRInzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618087;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=8i8T1jCrmL+UmAeCzN+XnswZfxkWUsWg9bYG+2LlVhY=;
	b=o7ykMUcxmnfVeZKUjYaUOy/o37v6LZByAIovfMiH4KLNQjPuIIPlauWiC4Khmc0HNzAS
	 6rsqgCdCKeLCKqky1yK8xQJcWl3GggxLyIL63IK73g0TnYGUMEVlNu7tzXAxAth5TylcA
	 UkrYb2XKEdv1L1PxRaY2+cgUOHIaZZsmM8ejsjJG0FKm1jlausINhq2IDO+eFIGFaKGjQ
	 lav36XTDxSXk44HU9xs3I4+jnmphW6AvaE28GZmEjc77Is/ztf9CYjQ4T1Jg/P6tFk7PS
	 t1UbM6yaD0lWleUhJuabyd1PsNXamgDcO6oBBN124S+sD0UVd96xibT+JXUD8zl3EUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=bnyFzCuL;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE28606A324;
	Mon,  2 Nov 2026 11:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE28606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=bnyFzCuL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793618082;
	bh=lSCJm5Z5pC3JPNCVX9bjDQtkIOU9+mrcRC10G01liyk=;
	h=From:To:Cc:Subject:Date:From;
	b=bnyFzCuLitUxV1tIb6v7I6/Ue4gOBnBcm4yodXDSnmko95GnqC5sOXRHYzEdI160O
	 8eSxQrsY5Mbxdt7FFwlZUDJBY0aZmnKo+EIUoftzioyDICAAUGRepee00exPrPI/3Z
	 K1tj6OtMsO9lF7ZuUA8Yo1/z5sUWCmSEFBa3j8s0EfwC6uEjAKRjv1Hoa6kZU9i851
	 5Mt3Ih//FsBeZzXVes3KSKCCl/tbwhNHtQ8EwnVh9s5ntHF3U32YPHVyZD3OrZ1XdK
	 +vojaPt4rjIs/XtFAU0wHj3ZS92S5f6AIMnRwd18S4J/AAifPzfspQwYgkc6O0lUm3
	 TvLgu5AH3Ri5Q==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 9EF0425853;
	Mon,  2 Nov 2026 14:14:42 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 14:14:40 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.164])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJ8Fq0hSfz3lJP;
	Mon, 02 Nov 2026 14:13:19 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Schspa Shi <schspa@gmail.com>,
	Lucas Tsai <lucas_tsai@richtek.com>,
	Sebastian Reichel <sre@kernel.org>,
	Rhyland Klein <rklein@nvidia.com>,
	Anton Vorontsov <anton@enomsg.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15 0/2] power: supply: Fix supplied_from allocation
Date: Mon,  2 Nov 2026 14:12:30 +0300
Message-ID: <20261102111233.383-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207173 [Nov 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/02 08:04:00 #28779785
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Please apply this series to 5.10.y and 5.15.y to fix CVE-2026-74271.

When a Device Tree power-supplies property lists more than one supplier,
power_supply_check_supplies() allocates space for only one pointer in
psy->supplied_from. The subsequent allocation through *psy->supplied_from
does not extend that array, and populating the second supplier writes
past its end. Patch 2 allocates a single array large enough for all the
supplier pointers.

Patch 1, upstream commit 966f6551173a ("power: supply: Fix typo in
power_supply_check_supplies"), adjusts the sizeof expressions used by
these allocations. With this small prerequisite in place, the fix in
ba61aed9a346 ("power: supply: core: fix supplied_from allocations")
applies unchanged to both branches. The fix is already in 6.1.y and
newer stable branches.

The series applies cleanly to v5.10.273 and v5.15.224.
Build-tested only.

Schspa Shi (1):
  power: supply: Fix typo in power_supply_check_supplies

Lucas Tsai (1):
  power: supply: core: fix supplied_from allocations

 drivers/power/supply/power_supply_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.43.0

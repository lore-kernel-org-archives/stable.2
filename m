Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004B357D0E
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787997291; cv=none; b=RySqqGKkjGxHm4KMOcTRddteOcobZNsxobV8SpAD+FvpLOkQOSZnZsdgNaXx5UlRnG4kHRiP4F19UPyTqhqTphZAQHhqKudSOXrQrMJY8veyu1lpPcNQ26GYQfXMnmK21F0b8szvVfCHBERgWRQx/4+g4FyGJSqykXOk2PPe2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787997291; c=relaxed/simple;
	bh=l9tqnFzFrSjN8cXxumhwXJEJ078VRqZiI4KHy0mccoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gx3ECZ8JhxOIjiA6nVxwItbfBViIHjjW4UjcS4FhEAW1PmG9yWqjPqT6DL+ip+9QwmGDtZMOLIadLuS0YwJs60mIT57trTjXhsT0klmFObtUoo2NFv93hnRBvzoPMFQb86sIwwUS2GfP3UmS0E2bRekJhKCuRVt2dr9wKIFuVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2HHUwXU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2HHUwXU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-396affa9420so216531a91.3
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787997289; x=1788602089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oC0I9ujd++ODGJE/sqEk3NvSSAuaZ1MshchVq7tKt20=;
        b=E2HHUwXUzOOEuH4jge23rKbOvEj3NkiBJSrjK2KkiRC8m2Oph52BG6qNUi3S/3Rjpq
         PdnNVuozclVabXc6Pm2xva8UH41XAovWTbYPbbWvPXFMYbdlfhA3lH/0eLoRwLWzH3dP
         PrcFO3w7LqFtOxn+zSES1LBX8OCGnxQULVnyr6GkI7I6Kzts6BixNWuLHMgzNm06L9Rc
         SasOEwzf6CMb7474fg8a/r+5eZRYV7MZOaNW34UlSqwsc6pebq1EJhEHI301v0UOK7Yq
         N9dvERzwzPpqbWt3a94zrE3SnGvF6kQlYI2vDefiollttAaALtPVYXRdAv6Pclc5QXLw
         iOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787997289; x=1788602089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oC0I9ujd++ODGJE/sqEk3NvSSAuaZ1MshchVq7tKt20=;
        b=HaLiK7eu5ZYQj5TECNyT9vnaB8MJG/uK+FpwgQ1ef3MxDPwcq+Ee6xsOUUHLBj59WL
         7aTNvHhS3ghQiMjBBCjAa3r1TW2w2NAx/c59rgAMtLXlJkzrj6AqD7xJj/DukXQBZhzf
         v5q316ukN/xvDGdEj5JjR7L61dkdY1Xb9YximBzA/MsgH4orBBEjAppj/d4PWnS3TzP8
         8qE+in9fZVzyZ06CRx8xAYoiGjp0tzYiTUsar201Jpbjy8xczqhwcAMt+ybjZcsj40J0
         r+V+Wmd4S3gwxhJOsOdzqwERSGKoAsgrRAP5PqzsDn+M+IS/hgF/09yjx73C8SSa+okh
         R6Mw==
X-Forwarded-Encrypted: i=1; AKwUvBy1aWrz2RXjqTR4JmOFclU2DboeYsCczvKNJuZpzrxbDOEA4gsE/baNffS2N6TOEIykzK31AR4=@vger.kernel.org
X-Gm-Message-State: AFuF++l+2w1IgBvBFg87IRURhcKeCc23pXWA9Y7pm8Q0aFNNukAoz3x0
	qzMaNR9Gr+rjznpsbHUNAf8ex0rB0KFO0s9QrYJKt9UnFQNCA918IvAr
X-Gm-Gg: AYBFou2uJ+e/0abqmLivF1BA/fN8kFxfkSWrxgo6x5mqa6M/hD6o0ET7y5T2IJB1fYq
	M3glGpbhxRZqt5rZkcDbCGHsGxG0OmFMifyIdt0j8eQmq7boDGuTOkPcTWnKqLvTMIcCdk2OVzE
	0OZ9Tuj7zNto44Q0M3/fR7w/BTPtTe7l23+c8xSAeWNz18//gi/xZ4uf6CzpTr0mKNHviHKtji1
	u85YEk+1fp9vsIG03mK175sC8UB3257s0Ddu8bcPsavw1NOR/iiyZqBBtkabFPszM5saeb8geK4
	43xcjCXLr3fB3dggbGvG8/WB3MqYa/JeI6QWZr847Eb0qbHvhG1OvXD4nVHwspv437bQHlmqz9R
	ul6Rygc1lHTJqtKRnyZLwjrCHcgizPqEJoHSLbnFF6a2kS41tmfPxu/pc0nlpo4RsXz0yZBniTu
	0HePw1QlfRBsKtqjGqT7TquIUPogzXoT8nuotMM+hlq5Oso2gO4MlFnvgBycDlOtgpeWijDKftJ
	qelxH+ZB/L4neJYVRe2Syxzyc3zMMSoTA==
X-Received: by 2002:a17:90b:5543:b0:38e:c140:2a0b with SMTP id 98e67ed59e1d1-398bab83160mr1221956a91.3.1787997288891;
        Sat, 29 Aug 2026 02:54:48 -0700 (PDT)
Received: from cachyos-aura ([2409:40f2:3104:d691:c7eb:3b03:2c8d:127f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c37sm15775697eec.6.2026.08.29.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:54:48 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: nika@nikableh.moe,
	emmanuel.grumbach@intel.com,
	helgaas@kernel.org,
	markpearson@lenovo.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>
Subject: [PATCH wireless 0/2] wifi: iwlwifi: recover the device after it loses power in D3cold
Date: Sat, 29 Aug 2026 15:24:35 +0530
Message-ID: <20260829095437.44716-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On several Meteor Lake laptops the Intel BE200 does not survive a D3cold
transition: the platform's _PR3 power resource genuinely removes the M.2
module's rail, and the card does not restart when the rail and PERST# are
restored. Config space reads 0xffffffff, the link never trains, and the
device stays gone until a reboot.

iwlwifi already has everything needed to recover it. The platform-level
device reset walks _PRR and evaluates _RST, and the vendor _DSM that arms
it is already spoken. The problem is ordering: arming happens from the
removal path, by which point the device no longer answers, and the _DSM is
gated on the firmware reading the device's PCI ID back out of config
space. So arming can never succeed at the one moment it matters.

Patch 1 arms it at probe, while the device still answers. Patch 2 asks for
a product reset when the device is not on the bus after resume, instead of
re-initialising hardware that is not there.

Analysis, register dumps and the discussion this came out of:
Link: https://lore.kernel.org/all/20260829093922.37103-1-navonjohnlukose@gmail.com/

Tested on a Lenovo Yoga Pro 7 14IAH10 (BIOS QGCN35WW), BE200
SUBSYS_00F48086: the card dies in D3cold on every s2idle exactly as
before, and recovers on its own in about 5s, repeatedly, with wifi both
connected and idle at suspend time. With the reset skipped but everything
else identical it stays absent, so the reset is what recovers it rather
than the remove/rescan.

Caveats: one machine and one BIOS, discrete (!integrated) path only - I
have no CNVi hardware, so the integrated arming mask is untested.
Recovery costs ~4.3s of Sleep() inside the platform's _RST, which is
firmware and not something we can shorten.

Tagged for stable: the PLDR path has never worked on platforms with this
_DSM gate, and both changes are small and self-limiting - every _RST
evaluation is already preceded by set_product_reset() setting the mode
that reset wants, so arming at probe cannot alter the behaviour of any
later reset.

Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Navon John Lukose (2):
  wifi: iwlwifi: pcie: arm the product reset at probe
  wifi: iwlwifi: pcie: request a product reset when the device is gone
    after resume

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          | 12 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  5 +++++
 2 files changed, 17 insertions(+)

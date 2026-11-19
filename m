Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795078647;
	b=Vw/SARUbBNDVmsUYJMP+TEf9GUqM9trBmvGgwYIxA+R8CNV/lxV1c/bMypdODJvoIy/e
	 tfhrUV6PpCN14GGcEDCJp4B7I3pDUKlhdXLGSxR7TO4whLSV7UZHR7RREo6MCr0kMnwlQ
	 N+Ouffd273YmjRdtJiG4aaK9tuAKcf52EQK3hdxAn+15bi6pLNYR7Ytv6R/DNRDrVO90c
	 k9K8RrUQ95S2JCG0T23r+dyEdnnTBR60pNqCjlrkIugOx0KdN5Jv7v7A+0qTImj/hBSES
	 dqmowmxz55w9YrBPa0WAeQybWPnR3AbuYD8leGRusxiZ1eLljKi28oVpM6x8nXqeFTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078647;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=uYouIFJD63VT0E+WsHVRLk+MwYuyDX8PTSOIO+DH06c=;
	b=So1hKLMjuLnvoJ45edUkVQKhbtwCuAnKGnOiuBgs1KeTWwPlMvAg+NwRv9Y5HPtzHAOj
	 o5bdg98M8TGxG7vil3R2KdY/apq6DTl4U3bAUH9OXFBQ+YLHFB28Wnp85eZnV2LiStTC2
	 2SDCUDycfwJKe2zUsxEmAs1Isavj5aVyQEwwLkLmvp6sQW9Ei48mJkbKyThP5tnzSXb75
	 67C5e5TIeLAoZujp6VzCP6/i2EZBQk/+IlIuCfUs1d0hhWO+QQ9ZRZAcAGRWWXzqpUOTS
	 LYo2OinXI7Bmrz31Q3CmBkj0JaPvzbXnFmrQe0r6GhoRbXbnmNwZ9z4TFRMo/PXMdtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnZcDhOo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F03606A320;
	Thu, 19 Nov 2026 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnZcDhOo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795078646;
	b=Tce6Ep/F32Jr9OUU4GP6thS7rbZ1Qjsc8Y58IsI7gPgspVdHuD6t+i+isy9pPfk3Xqew
	 BRxSgpTob0fBPhsY2Rty3CGBLtchCQVujt9jO5//M5kTzpzDlo4Frnuak5Rv4XsCl+W4o
	 IIwIw75wIJvpoUUpsUQSkJrMkMg9tu0CDZ6umpw6VwAiHpPPpbcBnFHSwQrnkEjKQVz+j
	 vEgFYEsWShr6a9ljY1eeuWwxTwhG1giUeW1TtMMszn/NhGH3H+5QdtG32p568E6uL4QY+
	 Ur3EkU0CKfa5BLgMBetjuowItRG3KZfTVFUwfKfMjDOxvif5rVSpZk/nper1T5bGDJg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795078646;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uYouIFJD63VT0E+WsHVRLk+MwYuyDX8PTSOIO+DH06c=;
	b=T+BP8ijwUY9P/VozQbwf6JENIs/iu8lqFj9075qYHvW08fRb1y5IeYOtF/N4RWc8SKMk
	 DVpG4QkDKSLc1ZRl6gq8U/xw8JO/LSwHWnOkhHqy0ASy4a8jHP4jTDKcR1qBtfDzA4rFR
	 oZ+xkR417EamexR5cbpPqeo1dSedSFW4YVCdHKHrzOTk9w5N6//HcbdURilYU5TgW0b/r
	 sJetAmnDIE4+kTYlDLgnjffcFOJnG/FUdUAs2YnbdD/vZvausCY7He1hvsrHQ3y2aZ1qE
	 6Fux3cX9Vhycc/mYNuUfc5v/eZ1Gx9N8yQwbf7BH+VO8fnm1j8Hq51dyDFHIqX4FSGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D1F41F000C5;
	Thu, 19 Nov 2026 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078646;
	bh=uYouIFJD63VT0E+WsHVRLk+MwYuyDX8PTSOIO+DH06c=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=PnZcDhOoueVsIrxZOLV9hX58BdI9uXNkxYmm4Tq83kLKKEf/9bXmIfIWDMmL/wC2u
	 LfvGhRMGbEjZTesSJFrbkSnLuZVoO7/h0aP+7UYTfAC4+JuCXnRssow8jiZwyBJyzg
	 TUDthO1EYrPZbXIzBF7ubSd68INOXUx+8LkwTrqWpWasFj51jHse6kh3oI06lqh3Di
	 fTGkufYpLXOaBnqX3Te2+YrWama5erQTHn16oGS9MwzFdPnu3S4aHe2IuiFP3yTs6i
	 EAJ77ju8AzaT7+Q0kqrT5+dp7X7PiUBg+AYNCPHwLYRSeFp5kOVwiqmbptcyh+8Dod
	 O8SM5bw8Ma2HQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B07A04B1C6;
	Thu, 19 Nov 2026 08:57:25 +0000 (UTC)
From: =?utf-8?q?Jordan_DESNO=C3=8BS_via_B4_Relay?= <devnull+jordan.desnoes.francetv.fr@kernel.org>
Subject: [PATCH 6.18.y 0/4] libceph: add CEPH_CRYPTO_AES256KRB5 support
Date: Thu, 19 Nov 2026 09:57:22 +0100
Message-Id: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPK5/moC/yWMQQ6CQAwAv0J6tsRupC5+hXCApWg1QbMFIiH83
 RWOM8nMCiZRxeCWrRBlVtP3kIBOGYRHM9wFtUsM7uyYiEpsxFzBL2Qkjwte2r4r+OpLlgAp+kT
 p9bsPK+CcfL5AfXib2qeE8X+DbfsBs/cemXoAAAA=
X-Change-ID: 20261119-aes256k-6-18-y-4bfd567896ec
To: stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 ceph-devel@vger.kernel.org, 
 =?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795078645; l=1618;
 i=jordan.desnoes@francetv.fr; s=20261119; h=from:subject:message-id;
 bh=UpqiUKM7C7AR2lLJt+zJ2w1iHwSEDbb6nW94JSyxo8Q=;
 b=yfBLQPgOHbbFdt429ktoFdr+HMl0jyRmXE9h3Ngn+2eLDwuEe9lGv2j17vQJXxamT6ZM606jm
 F+xqrQAtd11ACdZ1SlPqvP7wmxnyLB3nyQUFAqxX69W8wI8cJE15wND
X-Developer-Key: i=jordan.desnoes@francetv.fr; a=ed25519;
 pk=NsqAnHujTt5QBjYGvDgx/bh9SKZzYfCniV8bhRv6vTA=
X-Endpoint-Received: by B4 Relay for jordan.desnoes@francetv.fr/20261119
 with auth_id=1567
X-Original-From: =?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
Reply-To: jordan.desnoes@francetv.fr

Backport of the libceph aes256k series from v7.0, as discussed in [1].
Ilya is fine with it going to 6.18.y.

Patches 2 and 4 cherry-pick cleanly. Patches 1 and 3 conflict in
__ceph_x_decrypt() with 821365487aa5 ("libceph: Fix potential
out-of-bounds access in __ceph_x_decrypt()"), which 6.18.y already has;
the resolution gives the same code as mainline.

Tested on 6.18.58 against a Ceph 20.2.4 cluster restricted to aes256k:
rbd and CephFS via ceph-csi, map/unmap, reboot, and 24h of I/O across
ticket renewals. Build-tested on top of 6.18.64.

[1] https://lore.kernel.org/stable/PR1P264MB1805408F7C4A11E6F4D2F6BE887B2@PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM/

Signed-off-by: Jordan DESNOËS <jordan.desnoes@francetv.fr>
---
Ilya Dryomov (4):
      libceph: generalize ceph_x_encrypt_offset() and ceph_x_encrypt_buflen()
      libceph: introduce ceph_crypto_key_prepare()
      libceph: add support for CEPH_CRYPTO_AES256KRB5
      libceph: adapt ceph_x_challenge_blob hashing and msgr1 message signing

 include/linux/ceph/ceph_fs.h |   5 +-
 net/ceph/Kconfig             |   1 +
 net/ceph/auth_x.c            | 195 ++++++++++++++++++++++---------
 net/ceph/auth_x_protocol.h   |  38 ++++++
 net/ceph/crypto.c            | 269 +++++++++++++++++++++++++++++++++++--------
 net/ceph/crypto.h            |  21 +++-
 net/ceph/messenger_v2.c      |  14 +--
 7 files changed, 428 insertions(+), 115 deletions(-)
---
base-commit: fd7cfd39c88596fec816639ad83cbf3e9d316372
change-id: 20261119-aes256k-6-18-y-4bfd567896ec

Best regards,
--  
Jordan DESNOËS <jordan.desnoes@francetv.fr>



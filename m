Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC33793A9;
	Fri, 19 Jun 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871103; cv=none; b=L+3yVn37wBd4rqbcBSoVYj/oMKa7NDCURnO7dIphGMmZqAHrVKELcvv+AOEX6Of/zsFe791/TVSCPdYTIFXXbRi7XBXFtGDE5lA1rsuDFOMtPRQWZ+KtLhMTvYzVOcUr2VKkMB6Mbns+Kzo5af9FB3r/YcSDyE0I1dBpkiGaB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871103; c=relaxed/simple;
	bh=T0ZqElfHmBNHZfdhgrL90VXXZA6lgaZwcMvoWtQQw2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZYKhh3WaU5l4a8D3Uqj1cHAw1jM+kypErTgyswM+ekU+zdhaJNOplpHApQ0r5gCcvbemUqOMv3ftFfCTKncPVyg9a3JbtHOzPB5zOjh4Iphl/WXjjrtfeDH/eFs68uuPTIik6BaAocnjvCx/0E0iFYMhYdHLZPRekSEAyWzzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zxBajycp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zxBajycp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9771F00A3D;
	Fri, 19 Jun 2026 12:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781871099;
	bh=soz2+W0uoD18X8HRTTstY2FJ5AY7lsoDmAKphNkWOs8=;
	h=From:To:Cc:Subject:Date;
	b=zxBajycpiNOSfBslISVbjw+Nz1gGdY3eytnCnoCKkkD9hBlPKx8J2Rp9aH9f4X2qG
	 krLTMd6Igruu3PpddcqeolYwKSg2oel8YsieCtvmejU3PXqIMq42Efk/i15f8O0KVo
	 V4SiB605vDQq/vt8rUvXDfoUbLR9rYys8HuY4NrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.1
Date: Fri, 19 Jun 2026 14:10:30 +0200
Message-ID: <2026061931-reversal-stopped-29e3@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.1 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst |   46 ++++++++++++++++++++++++++++
 Makefile                                    |    2 -
 arch/arm64/Kconfig                          |   38 +++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h            |    4 ++
 arch/arm64/kernel/cpu_errata.c              |   34 +++++++++++++++++++-
 drivers/base/bus.c                          |   11 +++++-
 drivers/base/faux.c                         |   22 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c     |    9 -----
 drivers/hid/hid-input.c                     |   13 +++++++
 fs/fcntl.c                                  |    8 ++--
 10 files changed, 158 insertions(+), 29 deletions(-)

Greg Kroah-Hartman (1):
      Linux 7.1.1

Honglei Huang (1):
      drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages

Johan Hovold (2):
      driver core: faux: fix root device registration
      driver core: reject devices with unregistered buses

Mark Rutland (3):
      arm64: cputype: Add C1-Ultra definitions
      arm64: cputype: Add C1-Premium definitions
      arm64: errata: Mitigate TLBI errata on various Arm CPUs

Mingyu Wang (1):
      fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Rafael Passos (1):
      HID: Input: Add battery list cleanup with devm action

Shanker Donthineni (1):
      arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Will Deacon (1):
      arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU


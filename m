Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB530C152;
	Sat, 25 Jul 2026 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784959505; cv=none; b=bR3mzuJCdmBlV17+Acs3zDpC9ZBoA0o8OqsTkIoUc8DiwCmplAyMtxI6W0RDKFliDlVisjmHlwCpeesbICw4jwXe2dY76Fw1a6Mlr0RUB5084d8DeaOl2hfD7DWEgAdmMA6apzyuMdAil2oIC/P8mBqE7DOmIuxNTtQ7ywvrdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784959505; c=relaxed/simple;
	bh=b1Xz5ELALGN211Rj0biMcEo1WGOydnrq5riJ/R57apc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQ2rPhSt1Mrd29L2A8sb6itKCBqwCqAXbY3gSqpig81k9s0CYysy/sYt4ls1b45gvU5UpaA+urLx9VcySr43FX1826fX8b6DjV5GHXgj860kfs0Zq0yAyR84YYLO61t1u9H4OKDX4LQTgqDywSg6kImcf1vasxsKuF8SyR1T+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbVk5mLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbVk5mLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6031F000E9;
	Sat, 25 Jul 2026 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784959504;
	bh=GKNwJpB/LAzUQBBY32hxVmA624w463kaBnnqN5wFOsg=;
	h=From:To:Cc:Subject:Date;
	b=NbVk5mLeiuzKIZLbnLupwMGpbFFlubr3S+flvvVW27J96PnGPyn4ZeMbmE4GzKvtl
	 omR3Drq+DJ29NBtzjT9oLBoZtwYcmEQwSNIR4kiQcODr0IHSFsCbxx1FIv5SiBIXi1
	 83gWUvo8A7Ya0Lr7+Q5m6ZNc2A3GxtpSPJc+hx5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.98
Date: Sat, 25 Jul 2026 08:04:50 +0200
Message-ID: <2026072506-sepia-baguette-1b41@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.98 kernel.

All users of the 6.12 kernel series that use the ext4 filesystem must
upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile        |    2 +-
 fs/ext4/ioctl.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.98

Yun Zhou (1):
      ext4: fix fd leak in EXT4_IOC_MOVE_EXT cross-sb validation


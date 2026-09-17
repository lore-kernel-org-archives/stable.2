Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65439393DF0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612070; cv=none; b=Jbugft8Hjs5D9yXtrqCdj8a0W+9JANBn2yudoxHbAT2+n7wh3nTE03P5hkQ0aEasSjmydRCRkHQVUqVoD9NYuQqeBh69NDnN2olE4WltPq8UmX/q4NbFjJLFbY3cE2rVsu+vqR3bjSE4SPXh9IKx4UCCS/FTb1QbzZJC0OPWKKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612070; c=relaxed/simple;
	bh=+/69MYRHy5Hpk9zt2/L4eIBPg9nICbdL+uMspIQaJ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnpL8Lhf6OAFnO9LKVMHPzQNOFoEObJoKp5vZrEgP/QfxxxkDhwu3ywBzO2L4TUppQ3wr59kEeVDkQzIqQxz3MEBYDL04pyDQtGa1uypBv9KvVrfarkUZOr6BuOkskna05RuyQbTIqGOf96oIYeSTJ/bcGiYWldzMI4gqc9hk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc4H2KkX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc4H2KkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C921F000FF;
	Thu, 17 Sep 2026 02:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612055;
	bh=V+gllXcVvaBMwcNGY7qYTOnQthlD2iGeCk1cM8z87tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xc4H2KkXDraq3E3d97VQ3OEuDSVAJtRaZeW9dh3PZJn1bPCbmNUGEg2jhTMWwRPe0
	 B0Gj/Y92gvN0k//z7yeV68pwgaRfdRa1q+7xTjNWt2AzCLTYKqrdLeLI4EPOfeO2CT
	 PT3FkftxpAqltlph52rV+MH6Q5gOEVXfTifZcWVeuOihoXTgHO7iOXa4scjR14+3S+
	 bj2KfwaUmzga90WoOVYmu20Y08HoHnZJLv4O1XpwKgIvICJHa44JV93NSZ/UtvYJm4
	 H/xW5c/EP0Sh9drqj1vDl2V/nR8QcglVmrNPZVy7OnpDf+l5+1Tzf4YKgTv8rRXHW+
	 OL+TC/x8PbQSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] landlock: Clarify documentation for the IOCTL access right
Date: Wed, 16 Sep 2026 22:27:32 -0400
Message-ID: <20260917022733.3831420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091642-android-strode-2706@gregkh>
References: <2026091642-android-strode-2706@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Günther Noack <gnoack3000@gmail.com>

[ Upstream commit 6abbb8703aeeb645a681ab6ad155e0b450413787 ]

Move the description of the LANDLOCK_ACCESS_FS_IOCTL_DEV access right
together with the file access rights.

This group of access rights applies to files (in this case device
files), and they can be added to file or directory inodes using
landlock_add_rule(2).  The check for that works the same for all file
access rights, including LANDLOCK_ACCESS_FS_IOCTL_DEV.

Invoking ioctl(2) on directory FDs can not currently be restricted
with Landlock.  Having it grouped separately in the documentation is a
remnant from earlier revisions of the LANDLOCK_ACCESS_FS_IOCTL_DEV
patch set.

Link: https://lore.kernel.org/all/20260108.Thaex5ruach2@digikod.net/
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20260111175203.6545-2-gnoack3000@gmail.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Stable-dep-of: 2c6dc7925382 ("landlock: Fix use-after-free of the source's parent directory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/landlock.h | 37 ++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 94cfad88082f3..7d9158a3e7928 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -156,6 +156,23 @@ struct landlock_net_port_attr {
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
  *   ``O_TRUNC``.  This access right is available since the third version of the
  *   Landlock ABI.
+ * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on an opened
+ *   character or block device.
+ *
+ *   This access right applies to all `ioctl(2)` commands implemented by device
+ *   drivers.  However, the following common IOCTL commands continue to be
+ *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
+ *
+ *   * IOCTL commands targeting file descriptors (``FIOCLEX``, ``FIONCLEX``),
+ *   * IOCTL commands targeting file descriptions (``FIONBIO``, ``FIOASYNC``),
+ *   * IOCTL commands targeting file systems (``FIFREEZE``, ``FITHAW``,
+ *     ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
+ *   * Some IOCTL commands which do not make sense when used with devices, but
+ *     whose implementations are safe and return the right error codes
+ *     (``FS_IOC_FIEMAP``, ``FICLONE``, ``FICLONERANGE``, ``FIDEDUPERANGE``)
+ *
+ *   This access right is available since the fifth version of the Landlock
+ *   ABI.
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -216,26 +233,6 @@ struct landlock_net_port_attr {
  *   If multiple requirements are not met, the ``EACCES`` error code takes
  *   precedence over ``EXDEV``.
  *
- * The following access right applies both to files and directories:
- *
- * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on an opened
- *   character or block device.
- *
- *   This access right applies to all `ioctl(2)` commands implemented by device
- *   drivers.  However, the following common IOCTL commands continue to be
- *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
- *
- *   * IOCTL commands targeting file descriptors (``FIOCLEX``, ``FIONCLEX``),
- *   * IOCTL commands targeting file descriptions (``FIONBIO``, ``FIOASYNC``),
- *   * IOCTL commands targeting file systems (``FIFREEZE``, ``FITHAW``,
- *     ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
- *   * Some IOCTL commands which do not make sense when used with devices, but
- *     whose implementations are safe and return the right error codes
- *     (``FS_IOC_FIEMAP``, ``FICLONE``, ``FICLONERANGE``, ``FIDEDUPERANGE``)
- *
- *   This access right is available since the fifth version of the Landlock
- *   ABI.
- *
  * .. warning::
  *
  *   It is currently not possible to restrict some file-related actions
-- 
2.53.0


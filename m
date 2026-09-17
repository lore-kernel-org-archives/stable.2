Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEA368D4C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609184; cv=none; b=BbzZA45Oqxewe1Fx/4FiuuyIvkdDUFsOruViEsKod2LXFceVBUwJzLvy7fK/WPEl07Kg3XSuT0wOXLah5vnUg27dZoZbWwHD37zZdLjnBX1bf3TQ/EoB31qH6fLHWqjYeq4Hfoz0QWL/ff5kLEJ2ZdfKBP0ngkr2T2AIMmPCzO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609184; c=relaxed/simple;
	bh=hyhYJhc1Zs0GPzonCpy96v8QkcrNO18kSXgFV7E5EAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEGkS/IBu7+pKuV0jHKiZjgJ7WM04akB2D2A8FKV+HxpZri5RYG/q6qFwUM5yLmGdDKBCQ3lRZ/M/zF/YgBrR8UKPxKHvF7QxCuYN8BrnTD/om26wL2yVCJCW9fF6lE4JZ4rZrUzh2HwxAB8M0bw8EpZqOp5FyK8/C7jtnmH6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICCJlhSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICCJlhSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D5E1F000FF;
	Thu, 17 Sep 2026 01:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789609182;
	bh=OcRxiOnaD36ZjQ3ChJjjHXntseqOh5IXvmPp4PlfrHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ICCJlhSApUYD2mWWbcrwdbHWCO64yTb5FcQE7bCHtlGIsuKKYk96MBJbzP0z1mMAo
	 2jBMt+exbvnXWQUenBbStx2YAWMA1sSa7npIlueNbnwo7AEFCQ+kUFcCoQrAYQupxt
	 PaGfveCQoJOvrt4J1LxHry80n86HG03e7Ckr8ZDym6zLObdjXRHpG6AW8WPyk/UnGO
	 xwLY7TcRZ2irzJUQbeM8GeaOSsW1E1G9TOaAXM7ehKDOydQ01wZuKLVcSKwyvVMMb/
	 zUrQnTfQf1Qy2w1rV9pfVglppmqxDRQ42FaQeBvF4RwB1VcSECmDvxNCmdV/KvgmII
	 luuIBp9hsrgfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] landlock: Clarify documentation for the IOCTL access right
Date: Wed, 16 Sep 2026 21:39:36 -0400
Message-ID: <20260917013940.3651217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091639-trophy-refract-3155@gregkh>
References: <2026091639-trophy-refract-3155@gregkh>
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
index bb81293c60106..3a7debc21b52e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -216,6 +216,23 @@ struct landlock_net_port_attr {
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
@@ -276,26 +293,6 @@ struct landlock_net_port_attr {
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


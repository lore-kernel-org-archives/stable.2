Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671230FF36;
	Mon, 28 Sep 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580378; cv=none; b=OzHEo2oR1KwqxSVY98Jw+pZLh9m2vspmNKdpzqcqJOFry3ZSrCo8MGQtDhkj3BRV7qmELcLTf7Nm5BKwFbDxH1Y92UWm7XY7jAsLHt3/SX2N5BwQXrU1r6hvzToOOGdQXCqlPnkpC9teG6HeHj6a7MefICqE6KWY0lftgI2+7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580378; c=relaxed/simple;
	bh=z5Yd3ofejUyoc6HtISU3dTbcxyj8g9BrWUa/kQzVemE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=M4UOECtm+EqswzJQ1rWRYW219tUAMk4eqN6+Hz0Cvedo5x8ukxJnVkMe4zOr4HuWguU7PRnezY3fgPzbiy463aF4L8f6zYsUilyDv9K9jL3vuRwwbvRhXwDkDijw4sgCCu7J1lzzvZRXrPxqheFvKsQTMWX7O3oy0yrgKo6E7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=Q1MQgjhY; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="Q1MQgjhY"
Received: from smtpclient.apple (unknown [124.126.139.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f50f8e19;
	Mon, 28 Sep 2026 15:25:58 +0800 (GMT+08:00)
From: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: [PATCH] 9p: don't decrement a server-owned zero nlink
Message-Id: <8B490036-EBB0-4A36-AE39-F294F7C79649@stu.pku.edu.cn>
Date: Mon, 28 Sep 2026 15:25:48 +0800
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-HM-Tid: 0aa0e6e7fd9903a1kunm6258c4181eb549
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSRoeVhpPGU0fH0xDHR4fSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VSklNVUpIQlVDTVlXWRYaDxIVHRRZQVlPS0hVSktISk
	5MTlVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Q1MQgjhYsCBsZcXRPuM3SYmmfK5+wMqaRTXPwRmYj+tib//7ahC9tVLJEjXLQTppRgQiYhcaTzM2Dn2ESdu0/FbzQCuqW7yfDaJsRZ7sKAel8j0ZANQbLdXb+z4009RUbNq9Bj/Zb9RW7rChZK5csRDpOTzXnjAGf2cjWVRMoO0=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=t5LvP+tltYINo1sKhAAn4aqSaeTM4DOIvH0S4xyaEiM=;
	h=date:mime-version:subject:message-id:from;

A 9P2000.L server can report nlink=3D0 for a regular file that still
exists.  On a cache=3Dloose or cache=3Dfscache mount, lookup stores that
value with set_nlink().  A later successful unlink calls
v9fs_dec_count(), which still calls drop_nlink() for a non-directory.
drop_nlink() warns, and the unsigned link count wraps to 4294967295.
fstat() on a descriptor opened before the unlink shows 0 before and
4294967295 after.

The warning on the unpatched kernel, trimmed:

WARNING: fs/inode.c:408 at drop_nlink+0xac/0xd0, CPU#1: trigger/188
CPU: 1 UID: 0 PID: 188 Comm: trigger Tainted: G                 N  =
7.3.0-rc4-00537-ga3ff15db6820 #1 PREEMPT(lazy)
RIP: 0010:drop_nlink+0xac/0xd0
Call Trace:
 <TASK>
 v9fs_remove+0x529/0x750
 vfs_unlink+0x2f0/0xbd0
 filename_unlinkat+0x340/0x6c0
 __x64_sys_unlink+0x46/0x70
 do_syscall_64+0xe8/0x4f0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>
---[ end trace 0000000000000000 ]---

Directories whose cached nlink is at most 2 already skip this
decrement, because the exported filesystem may not maintain nlink
(commit ac89b2ef9b559).  cache=3Dnone skips it as well (commit
574aa0b479947).  cache=3Dmmap does not take this path: it sets neither
CACHE_META nor CACHE_LOOSE.  A regular file on cache=3Dloose or
cache=3Dfscache still does.  Its count came from GETATTR and may
already be zero, so skip the decrement when i_nlink is already 0.

Verified on 7.3-rc4-00537-ga3ff15db6820 with only this change.  A
server that advertises nlink=3D0 and accepts the unlink no longer
warns, and the open descriptor stays at nlink 0.  An honest server
on the same mount still goes from 1 to 0.  A rejected unlink leaves
the count unchanged.  cache=3Dnone is unchanged.  With panic_on_warn
the unpatched kernel panics on the warning; the patched kernel does
not.

Fixes: ac89b2ef9b559 ("9p: don't maintain dir i_nlink if the exported fs =
doesn't either")
Cc: stable@vger.kernel.org
Signed-off-by: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
---
 fs/9p/vfs_inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d7e678de0a036..347739b81513f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -495,6 +495,12 @@ static int v9fs_at_to_dotl_flags(int flags)
  * nothing and races with concurrent metadata fetches that may already
  * have observed the post-unlink value (nlink =3D=3D 0).
  *
+ * The same applies to a regular file whose cached nlink has already =
been
+ * driven to zero by the server: in the cached modes the attributes =
come
+ * from GETATTR and are applied verbatim, so decrementing a link count =
the
+ * server does not maintain only trips the drop_nlink() WARN_ON and
+ * underflows i_nlink.
+ *
  * @inode: inode whose nlink is being dropped
  */
 static void v9fs_dec_count(struct inode *inode)
@@ -503,6 +509,8 @@ static void v9fs_dec_count(struct inode *inode)
=20
 	if (!(v9ses->cache & (CACHE_META | CACHE_LOOSE)))
 		return;
+	if (inode->i_nlink =3D=3D 0)
+		return;
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
 }


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D93EC2DB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544898; cv=none; b=AMUREolliAcAyLRRcKf1ANAiSUBewTPySYrzFg4U5UJeY3ilMLx/5scx7D7EMOYhRvZ7700JmO66SXBIe61mmdBH/I4T4Og2cbYCGZG4oCAakpczcN+fzyaV7A+SRDPQQEw5X2t3jOEEUv74baXyOG4cMzOeCNOSVcQg73gert8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544898; c=relaxed/simple;
	bh=0/f1Jsc5ztqO7NIkoLjCr6OLhMwNA+JQimm9F83GEIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hF45vfXATnK9r9WwhX0kuvjRCOKl3KCezbDlixWc96f92vzhiHBK0Z/ee0eURsKr8UrU0OAKZ5Dk8qPvIjG15/rG6TG5wKr31dq+v90FcE44EcZ2pIm4MaU6YPyaUbaBxvWDRP8F741vFZuhZNp93WV3mxvzyYqahTYysUHPvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WESc7Z7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WESc7Z7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7635B1F00AC4;
	Mon, 20 Jul 2026 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544897;
	bh=13gX4yNgHUbkaNtGwispG7sINxolJtedO103bs5IS1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WESc7Z7CAeOQCfSbxYUFcSfRPqbb55z9EPH9SIQ497IjH00GUjSkI7Q42BiNDynay
	 gBrQ2OFSXUHHWaBaeo6bNP1Oy9beZTomHg/NYHpedwD8ZBHM7ljmIBQuIy/TP9Wx+e
	 0saKVesOHTjYKGmhmjm9rhzWX4+/Psz65vhsuRJ2TBi6oDg+XuBynW81cT9WsSICH9
	 /D82gWM6TZNHDxr1wsQ7FD9Z9Wnl2t5F2/PAD6lxKJkIxUdIIOGvZa4zKnFv4ihTaz
	 Rd6IlYBJ9gkE859H82z6YbPtwWEkkEbboYwK7i0CVshtcNHQZ8ybhyaaf2egeuuXQa
	 s0r85Dn4bAgUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile
Date: Mon, 20 Jul 2026 06:54:48 -0400
Message-ID: <20260720105452.216179-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720105452.216179-1-sashal@kernel.org>
References: <2026071425-shield-overhung-4ba9@gregkh>
 <20260720105452.216179-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Neill Kapron <nkapron@google.com>

[ Upstream commit 8bdcf96eb135aebacac319667f87db034fb38406 ]

Currently, ffs_epfile_release unconditionally frees the endpoint's
read_buffer when a file descriptor is closed. If userspace explicitly
opens the endpoint multiple times and closes one, the read_buffer is
destroyed. This can lead to silent data loss if other file descriptors
are still actively reading from the endpoint.

By tying the lifetime of the read_buffer to the ffs_epfile structure itself
(which is destroyed when the functionfs instance is torn down in
ffs_epfiles_destroy), we eliminate the brittle dependency on open/release
calls while correctly matching the conceptual lifetime of unread data on
the hardware endpoint.

Fixes: 9353afbbfa7b ("usb: gadget: f_fs: buffer data from ‘oversized’ OUT requests")
Cc: stable <stable@kernel.org>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260619040609.4010746-3-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index bd82db001c7250..7705877fdaa8f1 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1352,7 +1352,6 @@ ffs_epfile_release(struct inode *inode, struct file *file)
 
 	mutex_unlock(&epfile->dmabufs_mutex);
 
-	__ffs_epfile_read_buffer_free(epfile);
 	ffs_data_closed(epfile->ffs);
 
 	return 0;
@@ -2370,6 +2369,7 @@ static void ffs_epfiles_destroy(struct super_block *sb,
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
+		__ffs_epfile_read_buffer_free(epfile);
 		simple_remove_by_name(root, epfile->name, NULL);
 	}
 
-- 
2.53.0


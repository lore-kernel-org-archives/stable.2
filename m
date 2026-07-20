Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6B431E7A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559657; cv=none; b=X0y/zkaxq7fVzz0SVHbpDwGxT3i4hPINTRZelGymn+NFQwTqLpCiXmD05tOd+ICUQ0PRkxjBjsE6K1ZxEMQPdIwUtio96L4UXIWVFp4oYAYOVv+lpj0d5WT8uHQfp5JxCwjT2f3qlbgqmVeRwodaXbJdmBniWUof5CdGTHtn+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559657; c=relaxed/simple;
	bh=oz5/abjfl3P1samBWSu2Fu7P8br2iMa6igEsTBjs3Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USK3F9SO/bR3BESOoIOfm5mEZMkpcD+/BOTExpjZ/CQqimtFM0MuLu4WthZKR+EIY2dH9JFWwqdwxU2lpuKM0N3C8M2uvPabGIkKl8iPB1cHEEOfuxStrf/mhckotU9pkIp2H7TteNAK9FRMjrwh/Q/Sg84Yb6fv6O2CnB+v4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck1wvacY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck1wvacY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBB41F000E9;
	Mon, 20 Jul 2026 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559656;
	bh=ZaB4dNzWdWs44NwIz53mftypBsBGpLxsrgXImnMPw98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ck1wvacYcqi9lABISCWzhIBNdF2l4uugABPib5Ay9kcqCxBcbuPC+nFPrR1flFvte
	 UUE4FU+ftlORQ5Lgw+pC74X6+LQqDFclI5udAkDNOsImMMOfqRsXGVqFVXE+Cf+NKK
	 tdfRHvgRgN20Z0oS/ugtpMGOx4AR7jm+aoEQDXsGChHLCtlpTxCDoBzAolcZNoKhcw
	 uJAM6X69uZ744Khpv6fmpliLA/h2+7riPaJdVCI1Xmri1M9B6RXlz+sZzOTZTG7OPG
	 iPahnbIeTRS7RONYbE24UuY44FvueDa16zKkctfRf9nQEt6OHXwnF30RtzCRQbzF43
	 pgKYLhOINazBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile
Date: Mon, 20 Jul 2026 11:00:54 -0400
Message-ID: <20260720150054.1919483-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071426-configure-huskiness-ce16@gregkh>
References: <2026071426-configure-huskiness-ce16@gregkh>
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
[ adjusted context in ffs_epfiles_destroy() since 6.12 lacks the simple_remove_by_name() rework and still uses dentry-based cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index e88da01620b072..52df6fb67bad5f 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1291,7 +1291,6 @@ ffs_epfile_release(struct inode *inode, struct file *file)
 
 	ENTER();
 
-	__ffs_epfile_read_buffer_free(epfile);
 	ffs_data_closed(epfile->ffs);
 
 	return 0;
@@ -1955,6 +1954,7 @@ static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
+		__ffs_epfile_read_buffer_free(epfile);
 		if (epfile->dentry) {
 			d_delete(epfile->dentry);
 			dput(epfile->dentry);
-- 
2.53.0


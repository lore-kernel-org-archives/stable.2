Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C658365A14
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546920; cv=none; b=BvFXIT/5CP0+QDRqlpliAO2uosCmW+FflCQIc+FxSxVRhHnSpKOmFWXi6y38E9VmXCFrYdLXtHU+txc7qyvFwaZ9BjYj2LTFriVV7Vlq14DxaBJHt9kxOHVd3f4KniW+Pbi9ZPUu0GQQvYCMn4EVR6+LvczKCsnLoVHdcd+hmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546920; c=relaxed/simple;
	bh=lZLzbANLYfqC0A1IMP30s05glzdDlThVF9wUR1ukDR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+uF0+NSXL2FRsWUGRdfkyGmc/k3CBPSI7LBkG3OhqR8nl56pZ8rUoj5GJ3VjdW0OTx2q+7WMt4VsQApiQZQeby/lbsk6t2Qw3MewWHyELSpo7hQcTc30bdRa+QlxhpKXbZyAOhVLaJq0BSPlpH3eNMU2mQs3QT0uFU9aDy3K9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEY3f+Ps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEY3f+Ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8E11F00ACA;
	Fri,  4 Sep 2026 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546912;
	bh=oBC/JWwIGIwIUaOTLPLQVscvwp6UuNBzcZvYOGunxnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EEY3f+Psjf7ZbRZenUcLRnC9Qy3sPRqxlKNAXlNz75efJCMESO631smjFCeT/WSS4
	 OujYxasTck5Mxnb4EU9034l6fBpVu1JJZ7KumO7y08dz2bV8+N6GDeY/GE0Ra608z3
	 zUqIML4+IP1MDx7EbUh9HS7I0hohW/NExDllQzCig+hYZBJoZ8/0Q/uaeetDuxkU/H
	 aZ3imWduvbGJ6k112HHzjI0bisP8Hf2/m/l7p92omErrLJoo7fng6lkZ2SlIrkp6/8
	 Gvlt8H5g7iLvy/cOVhXuOCi8qEvSBDIvu+87XP7G+enGOPsba42V2fW6mKaJshhlPT
	 FdAqZ/fwdbtTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] usb: remove res2 argument from gadget code completions
Date: Fri,  4 Sep 2026 14:35:07 -0400
Message-ID: <20260904183509.1323404-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183509.1323404-1-sashal@kernel.org>
References: <2026090334-tiring-good-fffe@gregkh>
 <20260904183509.1323404-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 4c3d8accdce26afa8089609593aa92965b500f72 ]

The USB gadget code is the only code that every tried to utilize the
2nd argument of the aio completions, but there are strong suspicions
that it was never actually used by anything on the userspace side.

Out of the 3 cases that touch it, two of them just pass in the same
as res, and the last one passes in error/transfer in res like any
other normal use case.

Remove the 2nd argument, pass 0 like the rest of the in-kernel users
of kiocb based IO.

Link: https://lore.kernel.org/linux-block/20211021174021.273c82b1.john@metanate.com/
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

[ sashal: Reduced backport -- upstream 4c3d8accdce26 touches 2 file(s), this
  backport carries 1. Not backported here:
  drivers/usb/gadget/legacy/inode.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 75a27d3e261aa..db562d417e9d6 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -842,7 +842,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		mmdrop(io_data->mm);
 	}
 
-	io_data->kiocb->ki_complete(io_data->kiocb, ret, ret);
+	io_data->kiocb->ki_complete(io_data->kiocb, ret, 0);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050528;
	b=0A43NCIAuWbGmUOPAFdBExVLG197JRyqWXtctcp6LxkqkeGONRQZHISW394cEBMWEJu+
	 Aq7GSkr08ONH1yrh9dSCUHIJJV3bj1QlnY2WQS8b4frbHLDChNKOhiPO8Dudo06718pmZ
	 9JBulfPoOzqJXH+VG+0HD46jif2jxQg3kG5FnI8fa54OZHEK4W8K+NOv/aNcvIK/W5JYG
	 Ow+jJrv5ELzQa398cbJb8qnjYxskLyWKckbW0Kwvh59MWoiiUKIzNSg4DSuvUd8LNXHuH
	 ItlinF71UyFfhPFMzV5ixAXtrBrF0vEK2FVdXsW/a+IPtRjQyqDY5czHm1Ed7pv2JVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KKyT4tCm73wi4YpN+Xdr1SP7yZUkeOWXfxeZ+LNRUxA=;
	b=OlPJsvloaKgsgR9uLfKW9oBQn1SD8pSLdC2b4wC5YNyGwPZz6Ru4TspQyWZ14pQ3YYR0
	 EfOPvzSZJL9qGb11yx3LyExpeyGgAHE40mmB3jBmeA5FarDwnt+UvlVHlrxN4WhfRQWCX
	 S4nibKbL4a0ceLpwG3tz79VQ7DdyILiNoQlw3OdYDSFm+cyWnAq5FSJFW9QQmDuBiAF6x
	 KFkb3CsmP3dmaFeXHeB3x5HbKMSA96BcfwJhrqaBPUBBi72hvg3HHUHrpYPYicN8z3URj
	 V9d8Ynv0oiDadm7tcq648zyTnG2cqMYmjTbpD8sJSxqm2qGnZsPd7bl5nml259mq/rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzDbElkS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF08606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzDbElkS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A91F0089F;
	Sat,  7 Nov 2026 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050527;
	bh=KKyT4tCm73wi4YpN+Xdr1SP7yZUkeOWXfxeZ+LNRUxA=;
	h=From:To:Cc:Subject:Date;
	b=dzDbElkSEV9iGdkRJJiwUbEKQmiTafYunqafdGZh/yFQj1xqfokU0A+/0kN0ToPqm
	 k2O5gGxW+UwtyoREwsGXusttayL7xcnxrDsdQ9Ohexu4fLBTx8WOV/lfEZvK9kOdAg
	 JOZjUDtNCrMHxKlkI4R9JGVmb/zjtupvoDSbsyqL4hns+BVSpdviU4EVqYXE/WWQyp
	 tWz6dk5fCzTWObDGEP8H9tIJLe+f65qFxj1+jmHFAKYijp/Hi2/91BOg5z8jgTp/Yp
	 338hpBEcsnlItrybfJRmtBHlerb97eBXN/gHoWYmLF5ChgGOWPLPeof9Mcv+TOwbxC
	 fhGLqIJQHhxjw==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: smscufx: check for fb_deferred_io_init() error" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:05 -0500
Message-ID: <20261107062205-failed-5.10-8ea6c6e77ccf@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8ea6c6e77ccf887f3e68c64f4c261071a345da1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062205-failed-5.10-8ea6c6e77ccf@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8ea6c6e77ccf887f3e68c64f4c261071a345da1e Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 14:17:03 +0100
Subject: [PATCH] fbdev: smscufx: check for fb_deferred_io_init() error

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently ufx_ops_open() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due to
an allocation failure) info->fbdefio_state is left NULL.

fb_open() will then dereference a NULL pointer (calling
fb_deferred_io_open()) as soon as ufx_ops_open() returns.

Additionally, if the allocation of info->fbdefio itself fails,
ufx_ops_open() sets info->fbdefio to NULL and invokes
fb_deferred_io_init() regardless, hitting BUG_ON(!fbdefio).

Fix this by only invoking fb_deferred_io_init() if the allocation
succeeded, and checking for the error.

The driver already supports operating without deferred I/O, so in either
case fall back to that by setting info->fbdefio to NULL.

The ignored return value was introduced in commit 56c134f7f1b5 ("fbdev:
Track deferred-I/O pages in pageref struct").

However, the BUG_ON() issue originates from the earlier
commit 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display
adapters"), so target that for the fix.

Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adapters")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/smscufx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5704f60e1741b..34d8abd5b3544 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1041,10 +1041,13 @@ static int ufx_ops_open(struct fb_info *info, int user)
 		if (fbdefio) {
 			fbdefio->delay = UFX_DEFIO_WRITE_DELAY;
 			fbdefio->deferred_io = ufx_dpy_deferred_io;
-		}
 
-		info->fbdefio = fbdefio;
-		fb_deferred_io_init(info);
+			info->fbdefio = fbdefio;
+			if (fb_deferred_io_init(info)) {
+				kfree(fbdefio);
+				info->fbdefio = NULL;
+			}
+		}
 	}
 
 	pr_debug("open /dev/fb%d user=%d fb_info=%p count=%d",
-- 
2.53.0





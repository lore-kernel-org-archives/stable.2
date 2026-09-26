Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241FC45D180;
	Sat, 26 Sep 2026 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790428657; cv=none; b=jIOp16giQyqy79+/Uog1VNac+OaURGulU7MskgO1KP4TVSzpdgJ8qAYnEwLWEdKfHmWJshoPC/Vh/2Mn/RVsYgNzZqyap58GkyC4SdmNFwLbUXB0fh6Gmoyx8tE2l+qNKgFDjwOIrrPM86I+Og0V19PDyZ/CfGPWfQsJbtW/3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790428657; c=relaxed/simple;
	bh=YbIqSdJIIkEeq8guVIqFx0aQfnce8CHDh7z/PZ7D9Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9TWwwNWoM2ogynChwZpnDVmo98FbSeGwdWQaCj/g1hTRRa6ihi0QfZ2+Ky/1CZk9WI0xfM7xgS2Qz6xFgBIG7Y9eJrvaC+QdaS6ni9JrLAiEtuZmwpvJdVvyDjCwHS2evRGRbhExLG11NgxfRXO0hxNGPxLOtSgEpWr+rggD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjH69o4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjH69o4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF5C1F0089A;
	Sat, 26 Sep 2026 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790428654;
	bh=S1rhtmqncGPt4Sh2XZYxbcTg+GLkRc1wRusFT4Stx8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WjH69o4f4QAVTrTOZBogLuw44j5D2yEgaa8UP2dvvQqp/YtGaiTinXpleveTobKos
	 xHyHMfExIC3v9uu0JIh1IVtWh97ojYk+N2GgS25uDi2kgJXQdc8dpbwZIPPBFuF/ES
	 mYuH2QX7UPdi8fParz2o/E5uYkIz7KcK5/DjodBJh2zycCUO2ha0pSKs17HCiVdE+e
	 pgu8HYOkM097UXTonqw/J+2VALX89KE2dqjgyTpCjG79GO4vzA5ky/qFIquZQjiaBa
	 D7EJL3zcerXp+jftIwlO7w+XOWE6kXlaK7X4z3jgEbLl0t4DRmpC4rSiSemSlf3p7v
	 zeuB149UhdzuA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 14:17:03 +0100
Subject: [PATCH 5/6] fbdev: smscufx: check for fb_deferred_io_init() error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-fix-fbdefio-error-handling-v1-5-a94810b6e263@kernel.org>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
In-Reply-To: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bernie Thompson <bernie@plugable.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 Steve Glendinning <steve.glendinning@shawell.net>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Steve Glendinning <steve.glendinning@smsc.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=ljs@kernel.org;
 h=from:subject:message-id; bh=YbIqSdJIIkEeq8guVIqFx0aQfnce8CHDh7z/PZ7D9Lk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2H73ivsNZxt+D4ddZ+bcGV0yLO+dcbrV2KU7fILXZ0
 dDjOQdjRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACbCd5yRYUWOgDKXkOir+fPm
 Xzt34Yz/drNt/8uql9QLftnTx99T9ouRYY3e5JK3xjOK9+axcIpOu7Cmoe1M+pxPx96wp7VYHNp
 nxgUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/video/fbdev/smscufx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5704f60e1741..34d8abd5b354 100644
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
2.55.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCE145D180;
	Sat, 26 Sep 2026 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790428647; cv=none; b=dtmulvtGtImSx/TSpqxTX8NLvAIDg7Hg13kuwq6808MjxtMoyCcswhuLwzpD5tSqHJ/QPHqemidlg6siJ3Yx3kYySXcyKV0FPQZPyAa+ZBCgQTn0kMzU8jVEAzx795nerW2fyyLwUOe9wOtxUda7WCmSRZDz6OOcB//JD+yA4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790428647; c=relaxed/simple;
	bh=qlKpIS0kYvsCmMZPm9g3cnnWgN6jr43hgjF/R4k10xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKB1psRzHJ0IFzQbSnNoPH1b0d5zXblH4j/IDZWsMy0YDBqzbXt1pmjK3SVf9/u5LKpvz6r0e3OCwMG/rkGM5d1Liz7UvCoTDwAKdDcVoIE68UhfM87qdCRClT+WaAKYvLggCjqEvweufA0BU6SMIyRCQciZzCnE1Fywk69Fwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6hsqenm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6hsqenm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7238C1F00893;
	Sat, 26 Sep 2026 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790428646;
	bh=iQnzgzJlbml6qFFICw9e5A4EzueJyltcPpFfUYnosW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c6hsqenm0bpKhgnA6m71tv9/GuHSXGFCPIYdm1NxTsO0virkycHxbC7eDP1D34hVf
	 do0edCXBoYtAhUmIvfUybAyIzZbexIU50Olza3am/sUzRhFNqRCtbDVjRYbBqqMoQ1
	 E46aopb+kQT36s3I8kK86LR6klCrpl1GB/+SiKQI9U/uPbxF1zykj2l8r6ZxT2chEs
	 nagz2ryolNAq94oBGA6mSUC5opx3y3FPE1ObztndNFrW8CS44gwUPNxdYSqIDZ57UA
	 9ygXeUGobSNnw+wmWlGF/2ZFRRD+OPp4EF9XfnYaFQ60Jr1ndY21OnyInxg0PEqQEX
	 wDEUwoD/N4MhA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 14:17:01 +0100
Subject: [PATCH 3/6] HID: picoLCD: check for fb_deferred_io_init() error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-fix-fbdefio-error-handling-v1-3-a94810b6e263@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=ljs@kernel.org;
 h=from:subject:message-id; bh=qlKpIS0kYvsCmMZPm9g3cnnWgN6jr43hgjF/R4k10xk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2H70y1Us18tk+S00BxiLnqa6cz9TsTv9rfqMT4bzP2
 Lc3OelIRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACaSc5GR4d/Ozur/J0NSN8aX
 Pzxks1305T2da3v7HPZUfLRR3PCm6Akjw19vRbl/5+3v3hJifWl04uT8H9nF82dZL9q7snB6MOM
 3DXYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently picolcd_init_framebuffer() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due
to an allocation failure) info->fbdefio_state is left NULL.

When the file is subsequently opened, fb_open() will dereference a NULL
pointer (calling fb_deferred_io_open()).

Fix this by checking for the error.

Also correct cleanup ordering - defio is initialised after the sysfs file,
so cleanup defio first.

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/hid/hid-picolcd_fb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 8c28e982e09d..a016dd9ca847 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -531,17 +531,23 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
 		goto err_cleanup;
 	}
 
-	fb_deferred_io_init(info);
+	error = fb_deferred_io_init(info);
+	if (error) {
+		dev_err(dev, "failed to initialize deferred I/O\n");
+		goto err_sysfs;
+	}
+
 	error = register_framebuffer(info);
 	if (error) {
 		dev_err(dev, "failed to register framebuffer\n");
-		goto err_sysfs;
+		goto err_defio;
 	}
 	return 0;
 
+err_defio:
+	fb_deferred_io_cleanup(info);
 err_sysfs:
 	device_remove_file(dev, &dev_attr_fb_update_rate);
-	fb_deferred_io_cleanup(info);
 err_cleanup:
 	data->fb_info    = NULL;
 

-- 
2.55.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E1448BB3;
	Sat, 26 Sep 2026 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790428634; cv=none; b=C4dom8yA3cPqYnrgQHXyjVYQWH/vdPyEaYUS2jCvouEYsA5EmK4T3797WOD9wCrld/3IgRUfDhCUvO6Ve5MkxPo3c5ZsNWvDyS94lNODjxucHB9F+2L6BjaM5KsQZe0UNg8rsA78KlOUBfWPZnop2EL/SkTT9QXxIzPimpurLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790428634; c=relaxed/simple;
	bh=nk6tWgfWfCzVJ80HB+E43ly8yTYHGUV6LKNb27D3Q4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D7o4mtm5shdS26vypbZwSsWcHUpzsMKGnrXi2951SxhVq6pjdogVePRyyHVNcSjFyozAwFl6QYUTiuosjkYrmMCmo3GfA9nCWclta7lyvbCnswRBy68c8UMMdzueebzpIRlO89MbHXQBRdNmsjee4eqYwwO1l36f3KOhqCAsj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+w3z9c4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+w3z9c4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC151F000FF;
	Sat, 26 Sep 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790428633;
	bh=6K6aRJbm7O7grujLpKfmwFADDk/4ClgBVhZ4DN1sLn4=;
	h=From:Subject:Date:To:Cc;
	b=m+w3z9c4uR3Tk1a+jEp1F89n3VGMnDg0YXzs4afked4AIoPSeW26r/FEPyUP5w3MT
	 LZ2iWYiB/6baEW0O3nPZdNcpkLC11oTcAWoUadbraQWCQZJnerna1kKGZJoMQxyjYG
	 rs6iDi/wsSr2kd8OHMPjgQ0Y0gkqN1KMZKRSsCvnAh/SkThlHWgE6bHMfOtg5QtBLF
	 Pb733RnWIiObeUfPHruNaHFUnfKxguYogzsbsIJB4smncQwe9BKB7akbl5v5OeG3nE
	 P4AZIbTJiwRjzrJ8rLKxT6ZvfXhoJTAc54l3H668uOwNTM1Nn/a9BgNGIfEQ/WQ7eC
	 GHFp5ppRc3CYg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/6] fbdev: fixup callers which ignore errors from
 fb_deferred_io_init()
Date: Sat, 26 Sep 2026 14:16:58 +0100
Message-Id: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtQo6CuEi0yxxoIjREiCO/e0
 PLD479QSJgKTM0LQjcXzknDtg1sx5p2Qg7a4IwbzOgGjPxg9IEiZySRLKgsnJx2XL3tem/s2G0
 edHCJquefz0utH+HA3R5sAAAA
X-Change-ID: 20260926-fix-fbdefio-error-handling-ab135b0193cb
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=ljs@kernel.org;
 h=from:subject:message-id; bh=nk6tWgfWfCzVJ80HB+E43ly8yTYHGUV6LKNb27D3Q4g=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2H71yU8auJ7GmyeWWIqPwfdbAMG+nBPuSZTY5e++wm
 78PFDbqKGVhEONikBVTZHn+RXx/kEjYvM4L/m4wc1iZQIYwcHEKwETOljAybFJ1X2V3r/74+UyO
 Z8pClw9dTdZ8MXkq+6Y5Gn9vrucKWs/wP+IY53zuhRM/zVQJZviWOPFZ8S+j8/OF5ly1WKaYZpl
 uxgUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
converted fb_deferred_io_init() from a void function to one returning an
error value.

However a number of callers don't seem to have been apprised of the fact
and continue to treat it like a void function.

This is problematic, as upon allocation failure, struct
fb_info->fbdefio_state is NULL.

That means when a subsequent operation is performed upon the driver, for
instance opening the file, a NULL pointer dereference occurs.

Update all of the remaining drivers which fail to check this to do so.

This issue was discovered as part of a separate series which updated logic
belonging to ssd1307fb.

Also fix up a separate issue with a BUG_ON() occurring on allocation
failure for udlfb and smcufx.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (6):
      fbdev: ssd1307fb: check for fb_deferred_io_init() error
      fbdev: xen-fbfront: check for fb_deferred_io_init() error
      HID: picoLCD: check for fb_deferred_io_init() error
      fbdev: udlfb: check for fb_deferred_io_init() error
      fbdev: smscufx: check for fb_deferred_io_init() error
      fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error

 drivers/hid/hid-picolcd_fb.c           | 12 +++++++++---
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  6 +++++-
 drivers/video/fbdev/smscufx.c          |  9 ++++++---
 drivers/video/fbdev/ssd1307fb.c        |  6 +++++-
 drivers/video/fbdev/udlfb.c            |  9 ++++++---
 drivers/video/fbdev/xen-fbfront.c      |  7 ++++++-
 6 files changed, 37 insertions(+), 12 deletions(-)
---
base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
change-id: 20260926-fix-fbdefio-error-handling-ab135b0193cb

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>


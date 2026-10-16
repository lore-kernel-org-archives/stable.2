Received: from mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D035BDB2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128452; cv=none; b=cVOb8S0g9Lq5kpwOLQ4Eyfxes2efuTtASZ0K5H8/DdBv4zOUsCoqYbSeGeB6U1d0NsBdbtl2Eix5hIV/+ia5I8leBYSu18iNHMbHWcPT7TRNhncg7RX+CM03i83BhKI7LIIT/pP8NLLjCIbzYujmzD+nZgmAJ0lLYhkYp2Vidxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128452; c=relaxed/simple;
	bh=uw7fxBE4sS4SzyBiLGjQGBSyw365kfF4L/SJZG9QNu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmaP1FpcrDHlRm4cfOo8k65CCcDrZL4YNWg1XRvEcnVVzuqBfsDj/ArLkKCCbA6qSQRBaVv4bC3K8i1wyTfRi39gtQKtcVdol0C0U9HrMtfgocs+7TSJm7qKYEFfZ3Usb7GiJpchI4UtwWpQIKUeHsHNJS1zeoMcHew2RIlY1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=ooHteBtg; arc=none smtp.client-ip=95.215.58.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="ooHteBtg"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uw7fxBE4sS4SzyBiLGjQGBSyw365kfF4L/SJZG9QNu8=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792128448; v=1; x=1792733248;
 b=ooHteBtgbozpVDCVIqAkSc4J2FNIMSlRCAf05JamPBiyzDw9+mz8EIxvgwk6FNzTdwsuhDhA
 LHqHdOFHdRrH0qspKigEuldvuRa/PBRIkuDc7+rQFRJ8xrzBLQ/GlP+1mtuLDfmhrEjfQnHVO6o
 X2nEO6/2hY6zXuvOg4ci647T/iH9+s04ZtRnYrfJk6DgIjG0u+jj3kVJceFJgnGaMrJnHv8rCbR
 bP4hvCzirehLY0L6YenAVNaJukcFcejfhC1bfCW/9dnSmXzcM7dxFGy3lSC4nKuQ6LDpO6Tf5cR
 pKRu2c32QBxiBg/nhPJoQQ6bi1AOFijQFcsB/+ddwoNMg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f028aeaa80b00641;
	Fri, 16 Oct 2026 05:27:28 +0000
X-Mizu-Trace-ID: f028aeaa80b00641
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	luyuantao <luyuantao01@163.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/panic: Fix kmsg screen hang on a long log line
Date: Thu, 15 Oct 2026 22:27:21 -0700
Message-ID: <20261016052722.60051-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kmsg panic screen reads the log back one chunk at a time. A record
that does not fit in a chunk comes back empty without moving on, so the
screen asks for it again forever and the panic never finishes. Every
oops logs the list of loaded modules, and on my machine that list does
not fit.

Read into a buffer the size printk formats one record into, and stop if
a read still comes back empty.

Fixes: 54034bebb22f ("drm/panic: Add a kmsg panic screen")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
I usually work on Wi-Fi drivers, so this is new ground for me. While I
was testing a fix for a Wi-Fi driver crash, my test machine froze after
the crash where it should have rebooted, and stayed that way until I
power cycled it. Working out why led me here.

To reproduce, with the kmsg screen and panic=10 on a display driver with
panic support, as root:

  printf "%600s\n" "" | tr ' ' x > /dev/kmsg
  echo c > /proc/sysrq-trigger

Before this patch the panic never gets to its reboot.

QEMU, 10 runs each, on drm-misc-fixes and drm-misc-next (bochs) and
6.12.113 (simpledrm):

                                     before    after
  one 600 char line                  hangs     reboots
  same, then 400 short lines         hangs     reboots
  one record of 300 short lines      hangs     reboots
  oops with 24 modules loaded        hangs     reboots
  plain panic                        reboots   reboots

amdgpu, 2 runs each, Arch's source and config, before and after:

  6.18.52, the two commands above    hangs     reboots
  6.18.52, one record of 300 lines   hangs     reboots
  6.18.52, oops                      hangs     reboots
  7.2.6, kmsg screen set, oops       hangs     reboots

luyuantao's patch [1] stops reading once the screen is full, so it only
helps the second row. With both on drm-misc-fixes, every row reboots.

The buffer is shared, like the QR code buffers; a panic only draws from
one CPU. In drm-misc-next this code is in drm_panic_helper.c, where the
same change was tested.

[1] https://lore.kernel.org/all/20260126100732.365-1-luyuantao01@163.com/

 drivers/gpu/drm/drm_panic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index e576c4791861d..29b1487de7ae0 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -556,7 +556,8 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	struct kmsg_dump_iter iter;
-	char kmsg_buf[512];
+	/* the size printk formats one record into, too big for the stack */
+	static char kmsg_buf[2048];
 	size_t kmsg_len;
 	struct drm_panic_line line;
 	int yoffset;
@@ -574,6 +575,10 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 		char *start;
 		char *end;
 
+		/* a record that does not fit comes back empty, every time */
+		if (!kmsg_len)
+			break;
+
 		/* ignore terminating NUL and newline */
 		start = kmsg_buf + kmsg_len - 2;
 		end = kmsg_buf + kmsg_len - 1;

base-commit: 324fac81f365fc123247f9c8a52cb66ebd93b5e5
-- 
2.56.0


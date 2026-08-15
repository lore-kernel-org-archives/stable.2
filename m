Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82191A9F83
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786812121; cv=none; b=KzmQEwrHvDWCft5EuEpulUUycel5mTIT9plgOMFMD+EUcCsHE3nu+2JRqOUNBrA+zUqUsqxoYzLzVtzr0VGOxUl/V0e1GO0yk1FHlDdBmNA2+OvYwzqMQnfxgL+DkOUEqmnmXZ4gkTZEf2Bj5Q/i3gi3OYPZznoI4juOLdFSxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786812121; c=relaxed/simple;
	bh=ApPK93Vn7+LxrGyA2qPKaVyKxA1dS0RdxMSlm7KVDV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bzb8abc1xHBI6ZMtCXb2QMxuMtpt0mu3r5ubO6DKIQPiv6wVbWXAUMnZ9YK2gQx/jtJaNQOXxD98NkMBqgTsxuDiv8rNfP+bg3UqoX7bIpVSODRepzCKN7+Ox7tS1JCYO/RT5lUoEkobcblFd3mQ/VLdZh7bkTqK7/9lxFIA7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj7i6CHn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj7i6CHn"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84faf87d19dso2073491b3a.3
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786812119; x=1787416919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7syqqlv6107gB1yL3JYNqE/FxDJIWovYEa1sbJDV+M=;
        b=Tj7i6CHnru7omoVZKJL3YE9W0bRRv64bdE9rAymlO8QOgwpJqF9CEiKSm2ghL7ZAhN
         N5I+yTTaWnrNuUTqXIRy+PXoZrtY0DEpTDwPqsqIK8f+xu5Kub44MEK52boA7DZ8lykX
         yB6Bzdh4gq0gtkRjVlWovHIF0WVb/DWxIT7GViN1NGZT1ietKY4HXL0uZ5BQjswvkTOB
         inThj0ie8KNWpQ8rtW1A6XPEXK7Zi92v0btAwqmRisRn6K1NZ0e98g6vMhbJPPuoG75B
         nzqnPG3vI2eS4KZHpjhQS2zUEqCSdyF/4nRUvK0RVvoNCst2REmXkSu+LwRmirPFZTMQ
         VLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786812119; x=1787416919;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B7syqqlv6107gB1yL3JYNqE/FxDJIWovYEa1sbJDV+M=;
        b=OxMEe2YC5IQgr0ea6MyXMLz192qOh4lnGK9HjbRlap+L0vKQGdFphRTS2W28A3dFSv
         3MBo6TdZFR6ZqwVw+R3Pd3s6Jb6J0ZYXbl6btworu2+sVkb5FV4ddTtEKyfTktPpVQ+v
         cBvbFKg4oEEVtPUsxvWWfh9oTA51WfSQbR2djdrrKwDheLKPGsihxsjlxdmjbBAop8Mp
         10B359TvPOUHZb6BPv2C/AVelCJkcI9WNho4YF5mQvQr2FD3g6UIaqEjGaUVw5szdmIf
         CkdIAX/K0spV7Wt2IQaCf9WUWl++3I4b40cv1Ztmk7b7Y3so5V1SkIu9a3+4W3+eVSSc
         EDpw==
X-Forwarded-Encrypted: i=1; AHgh+RoUflCRskDgBa0j37fT703rQFfKSZitBqDVxU3az+/TZ5AE2Dgfg/7lSTTwAUKiajDM0eJJ6VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9HPlmtaOSq/qNXBZbhkQdgyUYIBOI1vsdTn3ekg/nx5fWwJt
	E3OPgUH84OIGxKUjY5UFM5EpWsKq+2h6Ql/jtQXSLWy8o5emgpQBwTPPF9vlvjl8u16HIZA/
X-Gm-Gg: AR+sD12TP/URSczfRQjqZEdxdQvyZ4CD8iBxDl1eGsop4ocvEeNa3AyBmZkf7IjXi7F
	/syqFK1F15t/GiuOfaAX+M7q7d6F82N2cd82GQdJjaQHemu8dwhBkedPOXWSO/3Onxe/rserAnc
	r6kwMH3MvhiH21GGBO9i77qG6TOWiCXPySBmlIf35ADmrrFtLoMjSaNR+shQCsZ8N7Z+r4gB4PH
	6+/kURJ1eRsNpbgzTqeDGgglIgiKOqQfYmhkdAmTp1R85mAD8fTa1Q+Up4c9G2jOcTPPY0rmQJk
	bLKxWqcQGka2t71+Ve1K4dyTIYdGhud+G5pMYMaOiKkhirvnPVmJXr7cthqEg4NHoTTqKxM41+L
	yfNwE708AsQF0x79vs+8ZD1lFcaN5YjqbSNhdX7IzvMoWDVJDif9RvUtSH/gRaLZAWGIU6j8rgR
	kdtt5FyGUV6zzn3L939UIER7SjXEkzk5EtfSnY7G2SRkvgotjhCcbeWPFFSufPcVURnajPik9fU
	WWKllTsPwS4/z/IN74vVQ==
X-Received: by 2002:a05:6a00:1810:b0:837:f79d:909 with SMTP id d2e1a72fcca58-84fde2defa1mr13881212b3a.39.1786812118931;
        Sat, 15 Aug 2026 09:41:58 -0700 (PDT)
Received: from allen-xiaomibookpro14.lan ([2600:1900:4030:ad65:0:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d249c54sm1405086b3a.48.2026.08.15.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 09:41:58 -0700 (PDT)
From: =?UTF-8?q?Chang=20Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	ville.syrjala@linux.intel.com,
	stable@vger.kernel.org,
	Chang Jiong <xspeed1989@gmail.com>
Subject: [PATCH] drm/i915/cdclk: Don't force cd2x pipe select on Xe3 in bxt_sanitize_cdclk()
Date: Sun, 16 Aug 2026 00:41:47 +0800
Message-ID: <20260815164149.607690-1-xspeed1989@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
without a full PLL re-enable") bxt_sanitize_cdclk() normalizes the
CD2X pipe select field of the CDCLK_CTL readback to PIPE_NONE before
comparing against the expected value.

However bxt_cdclk_ctl() does not include the CD2X pipe select field
at all on DISPLAY_VER() >= 30, so on Xe3 (PTL) the normalized
readback (pipe field forced to the PIPE_NONE encoding, 0b111) can
never match the expected value (pipe field 0). The comparison now
fails on every boot and we always take the full CDCLK PLL
disable+re-enable path with the BIOS framebuffer actively scanning
out - exactly what this code was trying to avoid. On a Panther Lake
laptop (Arc B390, 8086:b080, eDP 3120x2080@120) this causes
"CPU pipe A FIFO underrun" during probe and persistent full-screen
scanout corruption for the first KMS client (the SDDM greeter);
the corruption lasts until the next full modeset.

Only normalize the CD2X pipe select field on platforms where
bxt_cdclk_ctl() actually programs it, mirroring its DISPLAY_VER()
check.

Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
Cc: stable@vger.kernel.org
Signed-off-by: Chang Jiong(常炯) <xspeed1989@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2364,8 +2364,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
 	 * dividers both syncing to an active pipe, or asynchronously
 	 * (PIPE_NONE).
 	 */
-	cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
-	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	if (DISPLAY_VER(display) < 30) {
+		cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	}

 	if (cdctl != expected) {
 		if (DISPLAY_VER(display) < 20) {

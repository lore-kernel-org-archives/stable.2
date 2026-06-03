Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2BF366DB9;
	Wed,  3 Jun 2026 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504231; cv=none; b=UI/6CWWUKF8cfwZuqxpxKEKzz/ZLHEFZL1ds3Qh8UGbLzmJ6sFVxTDTPQasZYWsjDubIaOAiiQob5/a3i2jVc48TLvaJc/mrpV9cmdamcOudST74xQf0j3CkZGsXNhHkplPhkimKX1iMSXNiLr/mpRcligb84Z6aIc8z9vgVimg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504231; c=relaxed/simple;
	bh=Gv48m7z8RutNdniPQegD6dEcKYNLX930R1P43d8kz6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IpChVo1DJovwv5POz6AbetlTaFgaB2+0M228+131iwPELuoEOorMfbjp527nSGc8qv3C7d27yN5LUeCXJVbN8KyvHRws9SlNRx+POxXO9EnqoNkP7+y39EopG9dMCw0nRCDUdW7SvTGxNmqKyJR2OSj1x13Z95a77egvnQIE6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEPJrbCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEPJrbCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846921F00893;
	Wed,  3 Jun 2026 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504230;
	bh=aLlWQ1LrvCYEx3vPjcTSjD5GLe/XKh4mcG9PpMlDvMQ=;
	h=From:To:Cc:Subject:Date;
	b=TEPJrbCkVXp0LeSx6krR9uZTH8ac+ttMOqXWyJ+MQgSu+uRJC0Iruq8mD+uoyDsyx
	 /Wr9RkSBLCnOQvjAa+zRiPZRlhKannI7lJWyCForvjlO59+X1JKGb+lgMtcTMp5PiM
	 J3uAiibQ8TiaBK4GehVFU3Em0FZ26vBVVto2EQrSmJsJIWZ/fmrs0Owk3F8bIzKmPW
	 +2H+GLWRiKXs7URE+KdsxSwed+6mAt05tfhejF1vRqyBMAHblrMKxgo7JzPySJemsi
	 2Lld6pIipzsRn90sVBbrXcwcFpLJ9f2YioVH4OMNk29ZSBmdJ46Rr4Vl0wRc4wRAvp
	 c0GAD/PsbXgfg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Cc: stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [linux-6.1.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Wed,  3 Jun 2026 17:30:12 +0100
Message-ID: <20260603163022.3301081-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vicki Pfau <vi@endrift.com>

hid_warn_ratelimited() is needed. Add the others as part of the block.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit 1d64624243af8329b4b219d8c39e28ea448f9929)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/linux/hid.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 5d37e2349fae..f4bdaf1b8f41 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1252,4 +1252,15 @@ int hid_pidff_init_with_quirks(struct hid_device *hid, __u32 initial_quirks);
 #define hid_dbg_once(hid, fmt, ...)			\
 	dev_dbg_once(&(hid)->dev, fmt, ##__VA_ARGS__)
 
+#define hid_err_ratelimited(hid, fmt, ...)			\
+	dev_err_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_notice_ratelimited(hid, fmt, ...)			\
+	dev_notice_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn_ratelimited(hid, fmt, ...)			\
+	dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_info_ratelimited(hid, fmt, ...)			\
+	dev_info_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_dbg_ratelimited(hid, fmt, ...)			\
+	dev_dbg_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+
 #endif
-- 
2.54.0.1032.g2f8565e1d1-goog


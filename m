Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603F2E8DEB;
	Thu,  4 Jun 2026 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565228; cv=none; b=lB1G1IaRXNTA8ZFD2O4mZIxPKG1XNnh82M2+4E+iHOr5Nx4D6bW1vQvUHdrzPRzJMsTgB6tIAw5lG3ejizZXl9fW26yXcSmfBn5ck5iO6qQ1yJ6HJYsD4THhhllXf2xTxe7sPUAQzbsxJg7c9sejS8ZP4+MXaj0BmOQ88F+rChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565228; c=relaxed/simple;
	bh=zITDGdXUz7kbambQLOe9ODIU6O+MnBLEszFLa4FTBwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDYaPPRQpQU0jEI1aX+VxfUyGlVkTVmDnnDd6rIqZC05OnC1QAVpgF/enj24W18wg5ME9ROllSKkriTrc1BMvasxJ1f7fvYRImHPcJpvnUrm4FQFqRv//SxE3NTsoG2KKXIEwFPiFQAPj5Obi2OTxVz5QlWRA23BxTdsSyPDVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZEH9dCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZEH9dCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5191F00893;
	Thu,  4 Jun 2026 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780565226;
	bh=l+iB7Rvpg5+TBBuDmvrkJ26w4N+ilOgjEk1PmgxdSKg=;
	h=From:To:Cc:Subject:Date;
	b=mZEH9dChkuR+7M54ROBmuKu/O5j3bKMwz6SUnOO1mN+XYSFHKOidmbBtvI4JG8QaN
	 6+Q7lhBHgWaBhdGEL4vic080Dz2bMbwZZA4vUtzmUumfxRLElFnr6hWfy7wEWdqc3y
	 P7oRjSLu4LxM4KA3i0nS9D+G366gJbmq+rxnoeh6NjnzztYXLqpomW5Itba1cTqzr5
	 dpKmeU+Ghn17VuiSo1iq9r41YfO0XEKWe6aDwmhkQv0cw9jYTrN2H4WBgutR5IlB7K
	 y0PKLHcEA5Ari9mI/EjvU4S95GCZYHCynFR58hw+QZpnNV3VxpOXOIS1hQr1DgJWJv
	 61h2YFYn0m+rw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
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
Subject: [linux-5.15.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Thu,  4 Jun 2026 10:26:50 +0100
Message-ID: <20260604092659.3953067-1-lee@kernel.org>
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
(cherry picked from commit 3dc96d0b81eae69bf71e129e3f331c982c5c70fd)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/linux/hid.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 671403f208c9..3968fa039c26 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1248,4 +1248,15 @@ do {									\
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


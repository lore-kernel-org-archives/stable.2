Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A63B5319;
	Mon,  8 Jun 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912967; cv=none; b=Cp0MQNn52mflGiIBhgqFqdE24zMewVmkyZ0WvGQBF/0s/qqfPHIk3jSfGtclyAhQGwz2ZubWSbg+sc7T8Q0XIKV0Jj5/D5FoSTsjsPpmQAv4rM3T9yF8PLYm3gbtrHMl0DAhLPFO2+STuxnMf6kk3gRX0y2aZFLvk3OGyVim3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912967; c=relaxed/simple;
	bh=UWTKtBUlaXLwci7Sz6k7hDD72PBDrHTcVnmgcofUg10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VAn+8xTsYm4K3/d2C6j5PGcNOLQR3/2pZ//yLlJLWYhnbc3UEua/S1nrwsT+hIDbyVDIHp6mSNhM3kMoCHj93OIAo+afpNO5tWgITSyioAZYDoh2tV3Qbf+1IWkFPXFELvkXOwLPGDVKhJ0LW+QkOCueVYmC/EHunB8kpauxmNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWFSDCSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWFSDCSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CB31F00893;
	Mon,  8 Jun 2026 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780912966;
	bh=J37sDvgpmbosqkolf839VAuePRwjLxBje0wr+XSg1PQ=;
	h=From:To:Cc:Subject:Date;
	b=YWFSDCSufTqkrUf7Es0mXu45fJdSoQk8Xxk9GeS+u/sd8sih4NfJp7JLfpS2oCekA
	 z21fmzp4etH//7rgSUW5QM89Wg6vSEjxLyRyGfCAUWQkbODbzG0AU4HKwAu6fEknkh
	 fu/g/30HZcu+Ee3pJ8sbLwAwcRroZiaWUCKUGYR5y54y0hTqkTEzAfoY5xMY/SmJtE
	 Dpv3eMnZBgHNH6OZRIKrPWG2zHKZu1VPxBIP51Xt6KplBnFbcWnUtZpgWvUnjDoUGc
	 krz+Svr1fWGzNTr7zTfVBQikdi7YH9rJzN3U2OQnpbsGiHBk+YIfYij7vj5LR/H4bj
	 GTdA1ck1UsOPg==
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
Subject: [linux-5.10.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Mon,  8 Jun 2026 11:02:23 +0100
Message-ID: <20260608100236.2781796-1-lee@kernel.org>
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
(cherry picked from commit 023f03a90d4fcc809ffbfc70e6927ce9889b2578)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/linux/hid.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 03627c96d814..ab56fffb74a2 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1217,4 +1217,15 @@ do {									\
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


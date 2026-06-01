Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CC343884;
	Mon,  1 Jun 2026 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303021; cv=none; b=LtiHOXV5n4XwsIqDDxEmukhi1Fb8z52tsZDpB9aK2nJur1jMRv1F1H25Sjc0KU78W2M9xJeng9anrUOp4/sUWL7qDzp9UoIfzvZyyhQU2inMrPeRnDgtsyFbKRXhxYpPdMGiPdqdI7gy/LidNpfq6otnh+cJF7qCbZvTMg9Q5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303021; c=relaxed/simple;
	bh=sV/5LOAG0khi5+7E3XPfMqP+JsWMASl8fV7WtDssefg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VN8Cona3SzyanZV7buWrT5sFqrMjvgV/wrAl2Jus/yeDlsdMsioXhr/RkGS179THYIboysKd9/q2TquagW7s6xg4AijGw/1a/tuj71mEDrRiXRggoOzMjo9sZfLn96G8ir9VN2D3zxIYY2/V8FwRCx787xkMAJ/XVBGJ3r/KQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcJX5h+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcJX5h+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113841F00898;
	Mon,  1 Jun 2026 08:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780303020;
	bh=3wms+A+84QH76OVr66jdH7Kv7pI3+dDZ+rfdXKI0J4g=;
	h=From:To:Cc:Subject:Date;
	b=NcJX5h+PVk00TwfNJpDuDihLeI3nNtoEn5TQ3IL+bWK3SujbcmKO58Bbny6nAeOEW
	 b0PrXiBhoXimvDdRBxm9B/e7s6rJ/rgIsv1e2LcWZmGCsG6pFAuGhhvAFOrG1AGeOX
	 5bQ9Mf2eCmSkIGQ0kPImCW6eQjXgZVzb4j4B7KmIvV1NUFA/FpCZ9LsuQztjq8p8Kz
	 9i4yk3nS5RiR2S33uQgMEB5ylBExbIlomg/Rjhki9QAAIuBpoByeYV4pn5r/zSlNad
	 Vf63qokCVb/u6MsTzOOPjAviLs3qWu3TyYyDjY4dFc6f0BPYiLowOQnM5MJX7o9y8k
	 RGUOoJzVXQI6w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	bpf@vger.kernel.org
Cc: stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [linux-6.12.y 1/4] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Mon,  1 Jun 2026 09:36:09 +0100
Message-ID: <20260601083642.908433-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
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
index 7d8d09318fa9..bef017d6b440 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1245,4 +1245,15 @@ void hid_quirks_exit(__u16 bus);
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
2.54.0.823.g6e5bcc1fc9-goog


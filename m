Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB522FD665;
	Wed,  3 Jun 2026 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493511; cv=none; b=bif0oItkATiXsnuLkTsONi+0Xt0J9ARZwFVEwY8SFbj4sXxg6QGgtcZ5yET8BpOpwdZ9kQoop3C09GzAmOi/h75fLhHANkkWxkrq0jVoi5zpiD25IwY5s19bt/bl0a6Hq4y449YG1R/1WrPcyVBmAmsdDlK2ep38014+tScxBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493511; c=relaxed/simple;
	bh=Gv48m7z8RutNdniPQegD6dEcKYNLX930R1P43d8kz6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWt7javhlTMGV6UPELMEr7telXXPFgPFhRnCn/qnrb328RxDzKTFwF1vZSnuG0g2u1xlC5PasAtNEw3WmwHUnu4yL7Oz7AyhfE3bMypHCqjz+f2OF7slWoskKvENHLe/gSO0b/q9AhlzCyFrJzKbM6saeoh/CHv7o4u5ZleFdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcHkVi27; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcHkVi27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA841F00893;
	Wed,  3 Jun 2026 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780493509;
	bh=aLlWQ1LrvCYEx3vPjcTSjD5GLe/XKh4mcG9PpMlDvMQ=;
	h=From:To:Cc:Subject:Date;
	b=YcHkVi27MzA9w2HAsoJ/NNPTuAXIjMxJKzjdkgBz6dn7FjMU3ZFyTrLrOVBuwtNVe
	 He4jtDnPja9vRTA2Ra33l93xXaBmrneCLm3VNSVy2Cwt5k1N76eKyZ3JvpBBWCaGW0
	 C/foQ6UbLLsHCWtuTCv3OIqOS0jOs6+Nl//6jK8RFDWpE5eCT7pRlkqY8NyYM3cKs9
	 kfL75e+Mz8Ia1ZmjU9JoC+xcyM49Rdz2xDqkyyPzEYDO7jp7JqpEQJpawdT/ZwJ5iP
	 cmofWPnjVGV4kVMY5HXbeaFebmtLCU8xthBmQ10kiS7gMu770v6/kMhgAxYd7w0lqu
	 54iHxIa9E3HPA==
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
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	bpf@vger.kernel.org
Cc: stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [linux-6.6.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Wed,  3 Jun 2026 14:31:25 +0100
Message-ID: <20260603133140.3069226-1-lee@kernel.org>
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


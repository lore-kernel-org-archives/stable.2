Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF63438A8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560525; cv=none; b=jsVG0q2LGr6IjPY5lO/5/UhBxk3w01y5Vh4/Tsh9AE06zhIcxukpU2MIA1Z4SfQ5D6gM12jZgCoL/lGkqL9myuttvWUJw7AgWAlESaVONyxeeeYcxmmuv/WPOYvXzG0IAA3aJaUKagj4WQEaXnm5dHc1jQovg/o4c+lHp5WapSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560525; c=relaxed/simple;
	bh=AOLVLlHRmRYoKaY1KCj0P7y94HPNEQYaSFhxBYPEeuQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HGlN6LOdMojytV1RHrOiouHrHKZIq9UV3C1bLL7S49NW3n9Q9kVbqieEKtAz2NOzdT722jC0mIbckIXc3BDUYUIOe2BUZq5h0CMaSSf36KqDzSPqSlQd5ByJOwompW5sqHkw34PgC3p6q9go6HpUkhDUa7w+RY1KdFq+SjrucOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uXl4reCW; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uXl4reCW"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so1975063a91.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789560516; x=1790165316; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=afWGkToYaKpedWwJ38tll0kcFmplyXBW6eqdl1WBVz4=;
        b=uXl4reCWI5+PGj631JkmbLxAHkO3/nSzf1lT7k/7AaH/6HfeBN3yOuQbln2WZwZnzo
         pM6D5SprGH1d8p0kWIkGZ+vWBytcMsFvh5//Dy/gLAWYILeZIWtIJVj7DfGk+FFTMaBH
         TNmEQmKTHzkTrKIpWwv3Twjugs/xvryYdtM9RgI/lh3neXeenV2FrnN5+Yq8XLpztM3C
         AeSlRw6GS6H4fZamsuizqkAYNXt88vWRMMH7uciHs5ba4ZOrneGxE7P/aAF/n0Zyxq0W
         I5q1Dn4VyBRIUoAxFcKL6/iGSKHiM56Go38GbpxC/0fBm0OXuevBMkBSdV+Nw7T04Hzq
         JD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789560516; x=1790165316;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=afWGkToYaKpedWwJ38tll0kcFmplyXBW6eqdl1WBVz4=;
        b=Y9+sSA83zrwgZLntxouNin0aMZrPXI9dkW5O2C7642JKKnTVhlCBwHyUcSDAHfPszV
         tSOZ4m2q/7LWhoj3LGUuZhj+z4yUw800XqmSdsKJjKQTgrnPni9MDz4W2Hy4OIEs1b4d
         sG7LepxSS9LIhNXICygQoW6S94SQtmvljQXQavJ9u4NUrmz07oLhmjCJ35d8S3WaJIua
         K4NqsbVgV1DedjQ3jM8kC3uYvN1QYMvEv08VUWzCDcL1VQ5vMFquLMJyHvOSqHj6uTv3
         NT3Pl3LlsoOtEVfNj+sBDMWKJ5exq2J3Jo1fe2efVbWYbzlzsVj1oQBXE+TLG7K1OFo0
         f0OQ==
X-Forwarded-Encrypted: i=1; AKwUvByjf61KclP0HZKTi3Y84oLzButOFOppY6E+jWJaXykQfjCcCxG57XLOT4bMCu19QqE1klIJsjw=@vger.kernel.org
X-Gm-Message-State: AFuF++mT3qQr4R2ofxPTQBYocHvn7CyXOdizJHEWB2Ag/QTVf12aW5SS
	OPM3awaLmMqUSA7qIaoX0ePjsp+T9TM6BdxZO3PWPZdVekYLzH4j+2P5hp99VZXHdetVi5kPz86
	ODWE9mfpPilFZww==
X-Received: from dybtx23.prod.google.com ([2002:a05:7300:f297:b0:33b:c409:f021])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f50:b0:39e:2c5c:a689 with SMTP id 98e67ed59e1d1-39e2c5cababmr992796a91.30.1789560515947;
 Wed, 16 Sep 2026 05:08:35 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:08:32 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916120833.593407-1-cmllamas@google.com>
Subject: [PATCH] rust_binderfs: add transaction_report feature entry
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

rust_binderfs is missing the equivalent of commit f37b55ded8ed ("binder:
add transaction_report feature entry"), which adds "transaction_report"
to the binderfs feature list. This helps userspace determine if the
BINDER_CMD_REPORT from the generic netlink API is supported.

Cc: stable@vger.kernel.org
Fixes: f14e0c8183bc ("rust_binder: report netlink transactions")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder/rust_binderfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
index 300cc65562d1..46a37f1858dd 100644
--- a/drivers/android/binder/rust_binderfs.c
+++ b/drivers/android/binder/rust_binderfs.c
@@ -72,6 +72,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool transaction_report;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -89,6 +90,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.transaction_report = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -566,6 +568,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = rust_binderfs_create_file(dir, "transaction_report",
+				      &binder_features_fops,
+				      &binder_features.transaction_report);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
-- 
2.55.0.1032.g73a4cd73de-goog


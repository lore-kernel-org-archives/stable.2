Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797C453A3C
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764459; cv=none; b=l+631ow7L8/ezlGnAHIn1F9E9v8N++2zVAxvnScFn09bB/6FAJEEB3HCFaQErk8wT8DHuifdkKeehvkRXoX7+O2XmgwjxXxeB2IoAZX2Jt5xp3DRl/N2t1hzDaVAET+v8f/66qQEsbascivXRKF063xi7Ewg77RPrVNg+WmldTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764459; c=relaxed/simple;
	bh=dsIeDaJ4bx2grE63H3JOIxOYzDbbqaJAShesGHEqLjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT9twSijTugTZILayEPUkTdE6+hIUGhkxA0Leig9FCSNY619Z0X7TCy5vxQFT8vmg7CDdjHOCpJqiST+I1I4kRjDcr8TNVbWjWd21uDm0r7pd0WXo+KKb6X7V7s/VrPsE8NNgWSJ38b90MnWbJVVS4dVdLR9SYpwJzQUY37/AW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG/4qGJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG/4qGJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DAD1F00ADF;
	Wed, 26 Aug 2026 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787764451;
	bh=6NPQpb3MQIwv3MDMvpKP0CUd33s6SljaCyPX5+FangI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CG/4qGJTG6z8T2N4yktS7jGXznbQXQpuYBRkQNOeJOt1pGLVP2LbuKUu4ma5Lv6OJ
	 QMWtXnRmbiGwCafdaoYREbOJXI9LbtLjeppQBlGdj5dkLMHnZsBwsX2bKcUMz6q/bP
	 STZXUv8uFXQY3GgS24Unx6uJgXUCzE8BWdSA7vORJII8oVKKR9LrAX4kyYJzcAfpPb
	 unwFPt7dHbScf2Hn4ChXY/cCtP2fnz01GGhNt+WP0jZAbe0rGmBgqGuFfu99y7JFnf
	 +8QF54jj3zBW8dlcOpJtQjL/FpJnJav3EWVSRvVbQRntdtyW5RuDDzDvWuK6y1M2Ag
	 CPOiw+eTBbl4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] HID: pidff: clang-format pass
Date: Wed, 26 Aug 2026 13:14:07 -0400
Message-ID: <20260826171408.2245886-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826171408.2245886-1-sashal@kernel.org>
References: <2026082518-countless-imply-6af9@gregkh>
 <20260826171408.2245886-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit ae42428fb4e3d2eed344f0d6fcfa778bc8b8f80a ]

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 67bb1074e3d2 ("HID: pidff: fix OOB write when hid->inputs is empty")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 46a10bb8b7431..ad0636ca71776 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1298,8 +1298,8 @@ static int pidff_check_autocenter(struct pidff_device *pidff,
 int hid_pidff_init_with_quirks(struct hid_device *hid, __u32 initial_quirks)
 {
 	struct pidff_device *pidff;
-	struct hid_input *hidinput = list_entry(hid->inputs.next,
-						struct hid_input, list);
+	struct hid_input *hidinput =
+		list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *dev = hidinput->input;
 	struct ff_device *ff;
 	int max_effects;
-- 
2.53.0


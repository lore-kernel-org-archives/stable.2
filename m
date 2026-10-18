Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A3343893
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320400; cv=none; b=VRrM1XuK7t+gRlcjJ7t9ewyeB1rU+PHcRYf2MCatrMsHNDlogSbVu1pUfYobDjZxriN8m+OilUyC7aAqN4p4VJ6E/GBzQFIzi8V0tx66rJPDnuZIpkK/N/mcxp0Y27eaxqn7zX5IQuDsHCDNfHC6/OuLCeoJFjifp57TlVoszVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320400; c=relaxed/simple;
	bh=kbhP4xgKoVhLpHyGw3FQY82AhitXCtUAH9uXFDXIWCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUkCA/8YQhSuaoW/Hg4NDE8lRJRRyDbfSfQtYBQd5tFKNVXKYqQNsC+OMY3D/2+MXA27AVzz2Rn+uJOnWN4bZT2KSneX6IOXDaKKzOWCI2Kts6OMXve7j2uboj3WfamrTej9oEcEyFPmDTv1LVH+lNHnUSSSDwLkYm3TTgbk+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKJIA1ha; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKJIA1ha"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so1097385a91.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320395; x=1792925195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOaSt3OidYEeIBYJx+qFc4OoZOMLXmzzOzrHvaHMKHY=;
        b=lKJIA1hat7wADIr5+wQf2dK+rhJ/C56DunyjSGVpTa6nTpVmtB4vYKc7XtKHfMcHTV
         qIRfH6CeQT5w9+xpJwhpdOvyFrzX32DmluKYhV2HOPYYzXn4vq1n9OsFjmqhIF9xsT58
         G6OhqVzgSgDQUcOKMKU00ujTxtqk46Wg8VLRrqG6FHowVZqFf+bx/JyaeFR/HjtDEnWY
         1oN2K+Cf6nQoPrPd7MNxMYnsWCJubQQ/T2Hf1D//pHGOLrfnoH8gkThkM5H/RB8p2+fq
         ef1Lh2UUEKoVVfEm2K6lF1sH/KBLnSoirTeT/B1HK6MuMQwAcE7MAPvO8M49JomKGH6C
         PbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320395; x=1792925195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOaSt3OidYEeIBYJx+qFc4OoZOMLXmzzOzrHvaHMKHY=;
        b=kmpoD/l7t89thzeWan4481iDzb6SeeTYpHG0FhA7kXQFpkmirp6fn4OmoT/U9IRIsh
         Usbi4zk4iPqP5WGiU/lSaBiSDpT/WE3h52WL498y8DaHYHsJO4eYE3TQPsW2QkOl5gg5
         G0nz12XIpW5jBHOoTDxSaeCY8aitXR3yA6bHmXzhv6sZFMmNWnVryzEZwMNFf0jv8LiA
         ia99WTM8Brah3EKd2VO8Uthd3wWudGF6SpcCMqCqCsn9HoXxlECcCbfmlT1+Jzlemcwt
         rKcuounJPa0QEG7+dO3epu+JCZVf7LC6sqvfaS/AbO/sCxy1Tim7cSz/t9A502xv6icq
         AYdw==
X-Forwarded-Encrypted: i=1; AKwUvBzIYOCBhMBzuSuZDcKmqMbuLoHj49+tl5dyFugcERN6LkI+iedCpkzHOztPUBYZ4TpTR9lKkYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeEW352sQTC+WjfjN3w+qD7HSzJi48BAtPmLLl2x718OUqKzxK
	lSE564ASg01h9+mPZRvApJTRkGix1lJ7CADzqJ5OIxj/XS75CXtWEebq
X-Gm-Gg: AYBFou1AoozalsV9wKXUbt9mOiGD1RsQCkLSn12atxAvEuTLPST7lJXcib7GW/s4/Qk
	d7c+XjtJGlZ27INv4ErbGfqEB1yPs4+tVXzY3t6izJJ2s1y9l6YnCSb9fFGonDHn1UDxzMgycpf
	Qib12qNlkXIlaotSVps19to5JlTEy9v0jnnPGz+ptdM8Lsny5OtyolfbKlBWZ7BfbUnE5ftoe+4
	PwR1Upg9AaAhxYWLbr2MsHoj4s1FPZxXxwQQ4bceqdAotY1KbzcT1EjCmA39tLpg9npaUSbybRi
	XnFxBGLB2FlEsMkVhb5PvJsCCA/k4UwvtgO5MShCLnt8xof6fLWZGlj4ZkFbGZdUUu7wmbdieFu
	twkUEzZMtIZs2bsZ6hoVJdhR390q9f9b1c+Uil/u7vmjnCEyPbxR61erIKWeKVKm+YXQfdHesHC
	opQCqaKsl2kaOF92X17m8V5P1E2W3iJrFZE5Hy3pdx3zlVUU6Bso2NyQdZ834juWA75Kitbryvm
	gha6XnW0xBbNvvjs+ltPJE=
X-Received: by 2002:a17:90a:c110:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3acef0e4640mr3774371a91.37.1792320395329;
        Sun, 18 Oct 2026 03:46:35 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:34 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v2 4/5] HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
Date: Sun, 18 Oct 2026 19:46:16 +0900
Message-ID: <20261018104617.743771-5-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018104617.743771-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_bt_irq() dereferences wacom->pen_input in every switch
branch, both directly for dev_warn/dev_dbg and indirectly through
wacom_intuos_bt_process_data() which calls input_sync(pen_input).
pad_input is also used in wacom_intuos_bt_process_data().

Both can be NULL when the corresponding setup_*_input_capabilities()
returns -ENODEV during a successful probe. For INTUOS4WL, pen and pad
are always expected together, so guard both at function entry.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index acf24360d547..12a632ee1cbf 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1260,6 +1260,13 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
+	if (!wacom->pen_input || !wacom->pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: expected pen and pad input devices\n",
+			      __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 0x04:
 		if (len < 32) {
-- 
2.53.0


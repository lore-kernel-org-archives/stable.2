Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859353AC0C9
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762519; cv=none; b=fnoy7bqVcahWTe/B/XdNh1b4PlFrN7GRrpvN2vvvdKnmrLDUyk6Q0H5ZMxQOh8F87BUOnGJbmIRBt4jVEkeHxDSULjU0NfyI2n0hUbxkFYnvuXM32Ik4dKbm9c2XQ4daWQFyB99Vev4wwVBeYCcmvv2Zzat6TM0NYxDZFbosRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762519; c=relaxed/simple;
	bh=wxSQkLXWCWxEaJjBH3HhApPLUhg00iXXhz/BrXspzl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q29s804Qe9mAKMOfTc7BvFlndRdm2E5bZ142CM21pQjEO515JH/Fj5DYsqU+ZPoAgIjOP0k1o5xxc5Ao3sKASmV6LSFuFeV1UYLkYT7OTmeXW6c+U9FGE/4ybDvn+EdrRoDzl1RhwZ6ZuURv4ZaM4wtrV6l6btT7rQKS6n47Tu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFAa3T0R; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFAa3T0R"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso2568966a12.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762515; x=1789367315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sHzKvLnlyGdxYzhKnuxr5occ0k1Zs9EilK19Jh2gzJc=;
        b=lFAa3T0RNosWdYgoWiUqanm3eqKHXhSAXi3+/UmXFqPsANDhYaeMb8L5rK3zkGSV4z
         msvvuO+BGeHHFRp4BmMKNk/bWq+aGvk8Zwd2xPqDwcz2aXzD7aUBAAUU2Il/ochtMNlm
         GsK8MMA0KHHAngIwA4zESCT3ISQbVc+muWp/E5Qe7ksTGW4x6guCtisWEnNTl8vlkfcY
         Q9kTMrhmLp5cQzJE51IAvoe20As1DyOK4H+Uy9Go297/Aa1C+1xgrkBhWM9cz2KG4J+E
         +8Pg8WXNze5pIziHl05s1u1x0BSittGzUtpOGiwQqs/bH+BXU4bqkXWiJNWACpHXHBpn
         7lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762515; x=1789367315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHzKvLnlyGdxYzhKnuxr5occ0k1Zs9EilK19Jh2gzJc=;
        b=Ys5sBiH+kwCCGKiheMH7DjklOAaO5+uZmkUhGVI8BmxMtSy2lwtztJ09tyK6WQnnHm
         OpCquSJZnX3gqckDaITgU2by9ZeqoQunxMs6CWsrkJNnjK8Tw2/5F4Om3PGiQZ9pVd08
         6zVjhuB0GxTjEv0Seu/QupTwsQkqeaMJczQAHOYQ/TbCHQrf+vODAYaKHn+YLbEpuVAA
         fzwwuaFFUSCcjO8VcnkveGoNM+O9OuiBnmK0iTU9DymwPwZHxxqyBoxR0rTOTwA1BlMJ
         shRVNAw4nXaAdD+mRRri71QGZnGLE0rkqEy+Rx7MTvVWQc+eWpECHHOXPeiPpHz/TN90
         KDTA==
X-Forwarded-Encrypted: i=1; AKwUvBwlnwQE4RWdIYeCRqspCXDNgHzRBHK8GfckqGcfk+xjntykDGmh6R1ZBG4KBgicGYkJt04Hlac=@vger.kernel.org
X-Gm-Message-State: AFuF++mIxDBvk79bBiHe2XE5XT5y/TtzqE+AWdcHXpmCZm3MBAtMp+eT
	a76hsJOXE95JUXV6lw/Cb4V/Fdp5Vwzw3WvksJaBp56zPVK1Agvme5g/
X-Gm-Gg: AYBFou18wbwBqrbvmCCw9Ix+oHKQa2M33BYRolau5C+PeA27OiqGqaTk/0VUCeRyMLY
	4ccFughHSIN/xOCs+pB9V7jWST9KUMSr8b4WVcuASJF6pazd5algZiuN3yU+9gZDrmWv4A0JIRM
	t0qB5bMzvE/AUxh/FB6bL8Stz/30ZVKrk3c4/lI18fw8IKxUHyVJcsuchgBOakMjNDV2bdqvieX
	0+IcapPxzs05lNntzZP58YX7OZWYKx9316zmu+sJqDqn/KjWEu2gLw0b7F59B26aVA51WFe4W6/
	5RplgAZEU/FvPnhSLXewO7yhaMLKLH1cmalzMSCEJJ6BB3In2iCVdd82YxHSOaxUNP+8q5vKTUo
	hPeC4yjrcPbG3iEW12oOXvU9cVKriE9xxJkirYoV1l2bst+ed5VfOZrESGZqzF6mTBrBVDsn/Af
	RGhsD6LZGbt7nMEK4UpkZoON4nYNEYZqlyx8wD8+p4wV52F+WN6zXJ1fvrxUMSMgP8x6xvdkbkg
	JFx2mqFNPg0GnldXEwxJDTqX5ZwQYJH9mEJkAISTJ9fe+JgGzopyQO34Bds80ua3IyQJPXOldUT
	doD6BSk=
X-Received: by 2002:a17:90b:17cf:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39b26216cf7mr31265813a91.23.1788762514754;
        Sun, 06 Sep 2026 23:28:34 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25c974cfsm18978042a91.0.2026.09.06.23.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:28:34 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] media: uvcvideo: Fix two bugs on the control change event path
Date: Mon,  7 Sep 2026 14:28:16 +0800
Message-ID: <20260907062819.2519878-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs on the UVC control change event path, both from e5225c820c05,
both in mainline and 6.12.y.

1/2 oopses on an event for an uninitialized XU control.  2/2 leaks heap
past the status buffer to userspace.  They are independent.

2/2 reports zero for a mapping that does not fit, as the compound case
already does.  Staging bValue into a zeroed buffer would give a truthful
value instead, if you prefer that.  6.12.y needs the same guard around
mapping->get().

Wei Jie Law (2):
  media: uvcvideo: Fix NULL deref on events for uninitialized controls
  media: uvcvideo: Fix out-of-bounds read in uvc_ctrl_status_event()

 drivers/media/usb/uvc/uvc_ctrl.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)


base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
-- 
2.43.0


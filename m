Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA537F01D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007377; cv=none; b=BDJkVViw6gaD5/Jsy2XLob7VxzjFoAqgCzqkYQUIKJvqtLx9efWSG2Dq5wrO9pPFjBhpR8Z9OLruaWKRJk+uNmcuuEiZo16eliaQZClwZLcF3q+yt619Z72dnRAHrtfL7MqvivxsjkbJe2bW7TQ1p7zRGGxIijEfZKaSjmwR02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007377; c=relaxed/simple;
	bh=ECVcwLFEHoXgiY83rraXRsyKiBraLM3OX7uUGIYxYjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOVNpGKGJ2r205C4mFzACbEP6P5Ea2bALPsQGUD2vRVQE2zpMtqneMA9R+G8l4t5oj1T6kQTKQ6+JiCkB7u6lhoW/8KwLdONA6zw4E3NFiqdH4j8z6z2Tgg6fsghMcPz7HULTA1iiFuh+hc8KyObe92IY0ymejKwkkkphEGZLc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMw3en6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMw3en6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B693A1F00899;
	Thu, 10 Sep 2026 02:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789007376;
	bh=U6KqgfyNLyVm5j5xfNrHAHtesLhHrLH6ZRIIDb6/WME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMw3en6UcNp6V0EIM8VFrT930IzXDGdMA+XhpIxVHqOoZBPdhOVQjswuWDya4XFY0
	 zOc4HbIJXynMiVrmIrfm2Gu68i7Mwn6qUQ2ugQnpX+S8EtbZIvs3OcE0x54BBfiUE/
	 RyGzHPv48bw41iXRQakvonPa6yydZUgvdPOz1IYytxjYD35VdqTTbPUoAEGlV3xdOP
	 q4QMGR5PkkD2L/ONna5A/13UrHSrS0SPJdn9groNhRpFEyy6Wds9ElYKMUzTH1RA5W
	 hRLJ3R1z6dHY1lOc2hxeNt/z+LnYsGn2xk/rnKEHOD5+eB0TG2/jJb0EVq9d6nIfws
	 sIA/2mFYpcHsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Wed,  9 Sep 2026 22:29:34 -0400
Message-ID: <20260910022934.4041863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090852-entryway-sweat-1e24@gregkh>
References: <2026090852-entryway-sweat-1e24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeffin Philip <jeffinphilip14@gmail.com>

[ Upstream commit 2c0f5ca48674a5b5f9fa4a9c3325aa48053af0bc ]

Previously fsg_num_buffers_validate() was removed as it was not
necessary due to Kconfig setting the limits for n from 2 to 256 with
default as 2. However, setting the page content in such a way that
kstrtou8() reflects n value as either 0 or 1 bypasses these
restrictions leading to a null pointer dereference if n is 0. Fix
this by adding a check for n < 2 and returning -EINVAL if n is
either 0 or 1 consistent with Kconfig logic.

Reported-by: syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=791be35f1fbcc85d06d7
Fixes: fe5a6c48fd95 ("usb: gadget: storage: get rid of fsg_num_buffers_validate()")
Cc: stable <stable@kernel.org>
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260818035904.10324-1-jeffinphilip14@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adjusted context to retain the branch’s existing kcalloc() call instead of kzalloc_objs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_mass_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index d20ca59749074..f2880e06fe80c 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2624,6 +2624,9 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
 	struct fsg_buffhd *bh, *buffhds;
 	int i;
 
+	if (n < 2)
+		return -EINVAL;
+
 	buffhds = kcalloc(n, sizeof(*buffhds), GFP_KERNEL);
 	if (!buffhds)
 		return -ENOMEM;
-- 
2.53.0


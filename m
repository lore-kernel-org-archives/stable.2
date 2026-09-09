Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45342E41E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987056; cv=none; b=upP4En6YTyT4HCgaR0tTi6o9ZmPl0WplWwWVCMow2eC5P1cAUSUYgoUM/7DAy6fnMyZldyCQ6wlPmASkAjm8PKtMYI6N0vsU7daDZBURV/JCAyBdD5ALGwT3LLxP40Xx3lBAKaBLs/DkEvSXIoZ9riZOM4QHrF+O/VRRaj9SgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987056; c=relaxed/simple;
	bh=tn3zT1vO1o2TOMPVHIQFXh/xnvxLx6zTwwS9oyNv6Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkRy9p+bylMhpe0iufP3CG9n7G3YxZLe0heAvgMPvZFd7e85gS1W/SaLv+gGU7SmZbZEn61klwhy8cgEsjQWzoUn4a0tgJlnD1kkCSxU1UE59PT8duqVTN7cwQoDB+wgftxg8ZQz8mK3f72B8F2sfV/DvMTicnWuDgK61QPLumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIU/3YG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIU/3YG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25AF1F000FF;
	Wed,  9 Sep 2026 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987049;
	bh=QADtdTmcNs0XwL2Agum/XebNL8iplZFBhb6Td4Aw2u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kIU/3YG8u/tucit/9/YeNraf/XneDf12yUvj8/4F0NMHsS80tHwja+9cA2Uql8r3t
	 PZLGo47s7b2UViH3sfPNYeUhP/0ajNbS9AvF0eKJI5gPej6Fe1HCYrqhaCQanHAolr
	 Fvsfj+HDEkcLon87hMBLoxJRF32PwQAGlrSH+Ui/8+oZISRQQxgMCcA8w7F86izu6+
	 zZdZRKZb3SqqIZyA4F7OVX8Q70Z2RsOvlW7+r1j6KqCnb1PovMLoqxiRmB11re82yQ
	 eHMJLLvFmaqykQMkOb8+OoR+ilZc5mANtGutB9oUJUs+Fduur71hGP0ZgZdzi59NWC
	 1nCQJISIhLzuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	sashiko-bot@kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] i3c: master: Fix device_register() error path
Date: Wed,  9 Sep 2026 16:50:46 -0400
Message-ID: <20260909205047.3699690-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090418-debug-slicing-96e1@gregkh>
References: <2026090418-debug-slicing-96e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 74be657d98a8d684c0475f3cbd450ef2a30ffc73 ]

When device_register() fails in i3c_master_register_new_i3c_devs(),
put_device() is called to drop the reference taken by
device_register().  That drops the last reference, so the device's
release callback i3c_device_release() runs and frees the i3c_device.

Two problems follow from that:

i3c_device_release() does WARN_ON(i3cdev->desc), so it warns because
desc->dev->desc still points back at the descriptor.  Clear it before
calling put_device().

After put_device() frees the i3c_device, desc->dev is left pointing at
freed memory, so clear desc->dev as well.  That prevents, for example,
i3c_master_unregister_i3c_devs() seeing desc->dev as non-NULL and
dereferencing it.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-i3c/20260701203053.8F3971F000E9@smtp.kernel.org/
Fixes: cab63f6488761 ("i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260702183644.60827-1-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Stable-dep-of: 456f832e5fc2 ("i3c: master: Fix recursive locking during device registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 41452a27262d6..0166490c3da58 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1817,7 +1817,9 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (ret) {
 			dev_err(&master->dev,
 				"Failed to add I3C device (err = %d)\n", ret);
+			desc->dev->desc = NULL;
 			put_device(&desc->dev->dev);
+			desc->dev = NULL;
 		}
 	}
 }
-- 
2.53.0


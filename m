Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17923395D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005553; cv=none; b=hm7ImO6xWehJne0cjy+dUmSvK1W8t5AsnJ78Um+wl+xNjxHSYOz1rxR6x2V6Qvp15LDqv14hGYLpOqAGfEU0JV/OtMUaKEovyBtLs1inDFAO3+r8IMmmTWgWTxx/mznrGP0/oTx7cwS+3lCb7Pz96mpBUuld4vttCEx7js+BhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005553; c=relaxed/simple;
	bh=WvLELWZFkDVU1PMTbPq4r3z1b7lftEJVMlUX0aDWtVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctSXgvTztPPirkNeqjKsU1T9prdhWynY+h1DICcYmA4G/xyuGCSdD1g+sfECO0r5/zwvv34UDbREVQHV6EdqGZAsA7atCVWRD7A+/C9Jgyml6L5gP0JMaKL9FykooNdhK9bWZ+S2w4ospj0Rj2cLMQvb/pkuemtJojx28VedagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VExXimsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VExXimsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0F11F00893;
	Thu, 10 Sep 2026 01:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005551;
	bh=20pXcDQVz3yD1LDxHFpKo70VyEHT2lTiErIe+ZEq9Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VExXimsvcrfY2LREr3m3rPvn4O7aDnTC2oZWBbLNEL4NwMzAa14GNGK3n4JPCPgA6
	 NZijnZTtOLKf/w4brx3N/rw/7nswLEjyZwjrtZxBU5JYZwiaOdwuKvpNgU4HwIRqMW
	 +OqVS7PLS4jXxMwQldpiFmMQpzsKRUd8gYieNU2efgbWYpBS9D60h426egWcb1SEU3
	 usRn3Ii6z1q5RfZ0vJAu/11PW0oZxmqWhjt+mrhYDmBB60fbQEn6t3AyYyYhIFgCmJ
	 1KYF7LlTaibskYG3imwB37+4bPKqB+lqp2q71KxbRVa4U4Xxpj96IBCoMbyLqJb3Lh
	 KIqWj4q3suEEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Wed,  9 Sep 2026 21:59:09 -0400
Message-ID: <20260910015909.3948156-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090850-ethics-surfer-b50f@gregkh>
References: <2026090850-ethics-surfer-b50f@gregkh>
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
index 6f275c3d11ac5..2a22a204c0e73 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2748,6 +2748,9 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
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


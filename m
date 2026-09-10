Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E13806AF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006768; cv=none; b=kZot1jSML1WuuCwCIkjSsKIM+tkxuibkF2Nt7hh8SnEE/OyP0yecHRR6kXQesf3ThAuJYHACwEWRGle+hnFZ8tHWFQY6+K5w75EOwq5lYlYXxbYnuEc1nd0tLKv5THytshnWMi72JXrxprYy2C41noSIZLjRnoNnAF7bppY1cnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006768; c=relaxed/simple;
	bh=eD5NGYLtllI9GPfNeIiYzfeA6hOfGRKz0G8MiwNcFfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqUrFEO5RjBvOYkDmoQq81BGxZHr1P3E8XehGK8X45AAM8b2skOuk8zWO/Ucj+OJssYFaE7oYbDiLPKw3/d1x2PoUChT7F1PHi3UDe4JgtAvF8/Tg1Rb1y9vPwmGNaHI1TSYj7fBrOieCJocP2ZSbUiW5MAWGDV7PleVrEgZwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9jCP9LN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9jCP9LN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614371F00898;
	Thu, 10 Sep 2026 02:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006767;
	bh=cQl6Gajf24PBuFT7R2NXcQdgeJqhzXlQ7p464ZFDV7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9jCP9LNBPrpK7xRVHJY8SeGWSle2h5pI5dFbkuhy8OwkE4kIi5/VfIRjytjLCUwF
	 a0h3xXX8u1dRV/Y6cuvIQjTbLPPX88Nnh0skEkYGLU8nmY4pd4mHJt8o7i4bnnKRQP
	 6g3mP2wfkZrsdHs61SHX+IYRsw6RBdNNeRn38/yGDQu8ihciAidTGU2Mrskh+lsoMP
	 l57CE5JldSKVqGhduYyBQ6k7+d8Ma1wZyc0yIkWod/jkRmatPGFO61Yp5XBi5nBHTC
	 uOUt0svPyzzUYgfyXIYVfXixkqcFsH5bkGLI7bZbR1SjP36V2HFfalcRRENFDTjpLa
	 ohZ55qo8exHfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Wed,  9 Sep 2026 22:19:24 -0400
Message-ID: <20260910021924.4013236-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090851-depress-crushed-5c8c@gregkh>
References: <2026090851-depress-crushed-5c8c@gregkh>
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
index e364b7b4d82b9..ea40f68a6e323 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2747,6 +2747,9 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
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


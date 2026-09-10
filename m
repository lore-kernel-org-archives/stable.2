Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D733769FF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006269; cv=none; b=GicGpy0P9hFKxMJzKUMKpPNBBpJrq4cYfWIiJo4hLiI7Oq0xo3Y5N8q5qjlHc0HVBNyqCB5Mkw20L3svDYvxLXBzBp69leJaUVjWE/TKikIMCi2ubAt+Otb2XnarkXG/ATO7ugaGo8w68y0TNBneQ79Yb3Fl3K9NWLr0DUuIugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006269; c=relaxed/simple;
	bh=OniNcNS6EFqx4poXltPQeM0y9Ag321pgHnddYtcwuVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwYdEIo/IsgOLPlaAYCqKxt58cpmeWFn3Zzr4exqowPzh7MnsefRFyW576sgD5be1EjeyR10ATcuGoNivZE0ht5EJx9NY60btDeQY721kZsMN1ysuV/Fd3KHLAi25N40GZaNxPhX9QYwK2RBlWVSlINQ3aFqnqAXruDbcS6AD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USxCRb32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USxCRb32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4406A1F000FF;
	Thu, 10 Sep 2026 02:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006268;
	bh=KDbIlmzcBKYb/qo6/oi5i5bElV9FWeYhQm1sjuXd7MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USxCRb32CTM3FKx0IgvOXxEa+pODIMalGEdt2+H8LuFhKUwWFbCbED5QNugf9sMo7
	 rAZRjTRbnWW7ps6ntH5i2QarZfQzz11CQtnztZ94D+Ro+xt4Mn9aiEZ9rC5D30YZmE
	 qcwX4v3BKBwSEqJ6GbVxXyw5uQsG1xMI5LUO0Sx8RPhQ+1kMeCBglioE1uyOVYKZLM
	 b9X7Ktup9qCucTi3m8AGvY+SE/i7mfDapiInN6EEjtc49G8QCWPikFsokgm2Dp7ot1
	 jQ55/ZKY6xOQEr1/VCfmteQq1y6gxxrHBrHfMC8SPX7EhpcnU8xIVLp4Sn1Ma4i2iK
	 CLkeW8lETq6GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Wed,  9 Sep 2026 22:11:05 -0400
Message-ID: <20260910021105.3989086-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090850-exonerate-dumpster-494a@gregkh>
References: <2026090850-exonerate-dumpster-494a@gregkh>
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
index 74cb7e57a197c..341cb3861a13f 100644
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


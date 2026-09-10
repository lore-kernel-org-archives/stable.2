Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4F36194D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006452; cv=none; b=HbhTj688qOhZ6C3X+SXAbqg+mDYkz5mSiJOiY1ipFQNotPevYJJ4p+H8ZfWdo6TVO5Rk5snrje8aelXBwUW7hO8Bk5BttDqQHNL91Y3zT5+JTUK2BXveVEk9k+fvYURXh4m6MyuwNEVklqKRV8ewfVRYBIVP+ghU1RWDlju915g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006452; c=relaxed/simple;
	bh=tKcx+5Vsjjnr9AK3kzWngurtrLTwcaOuoWgt3CggJVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdzFKyCf0Nrp/1mFdHeKqtZnRkTpVHWZiBhiQe5FM9MSS+gR8u8qWRBzxhUK9I+5JNwbUpKKDPKVS15V6LY3aLjpULYBZJJ6PYu2MsN/4iV8KqYzh4hChTLE8WziT7znu+dMArY1lQ/nbc9zAgTZfHWBW9Zrc+UthhC1F8F7Tl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deECWw0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deECWw0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51311F000FF;
	Thu, 10 Sep 2026 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006451;
	bh=OxLclSyoHj+B4aaUI9/kR+YJN5OlLsArhd55/S98xW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deECWw0fQ8jCkjNbbFqpRpbSv2obLZwb1lf/FeFx3/WfIKqnanSB/rn/Kc0pItFr9
	 VqO1sP5lo6lRFkYCfkF/3NRKZuAy9ToY+0xIf1baBV7E09Eh4wFYQhHWmgEtNIZFKU
	 AwFk+afhqDMP7tDG434aOW9Jh3CuzKdKQawDHr5o9OJ6aIzMdGU93MFL6nSGcBazEP
	 LTrCmMoh+ZHnEdBltJ1Nihyloulpz4eNEAVg/Mh5DS66uD8Ed2KEl2Iw4CnLTw19Ms
	 6SKsj2s4iEQsewJpD6cYSDUlzJv1qAb0s+A46PXc7mBgt2A5PTdnipkT17BXKvF407
	 CflGg3Md/fTtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Wed,  9 Sep 2026 22:14:09 -0400
Message-ID: <20260910021409.3997045-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090851-diameter-thermal-3fb2@gregkh>
References: <2026090851-diameter-thermal-3fb2@gregkh>
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
index e01d57a5327c6..f149560f8a9b7 100644
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


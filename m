Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7436606A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006957; cv=none; b=iGiGNIdfZpOvpCyBh0jldwHje0JJeQFIzvNfb8vLMwLD2hXvNd//r9o32EjbD6ma7Jx5s5/Z2QedE8xYKoV6O1iyjCkz0NSzFbUdoF04onkV/hPbKP+eXSKMvOxJQRrrKRucR/OGFO+CE/ak3Gn9sUDqEj+fTMpUoDgVfK9v4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006957; c=relaxed/simple;
	bh=d+A7SaPPza8HZmJlTmXut0Nn4itaUG4ds3SsnM5TVEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cItJdAV9AzuRJtb3uT67iFdw2y8JT/+CNze13zZXpMekm8dmz6q3lMi32cdHyJayzz8TSL90gdo06e9dtUyktU89CRrA46TY59MRqadH8Vsa5my0K+Mvx2HJCt6n6dNw64kHOmGXM6fuulS8glBo889eV+h0pS3qJZPvyh8OHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0tc2QNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0tc2QNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2931F000FF;
	Thu, 10 Sep 2026 02:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006956;
	bh=wT/Hwi4YzH4wSodyjl5FYcIO5LfNAq2Gigiur7IPblo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G0tc2QNw/2ecJUxdONwQEgGWpvBjZNMzROuE/1eT0dxp691do5G3ZKIfKN+OfMol+
	 csgTX3gbIJ+DMWZ10SqvqI1UIJldLj9IgQspm9ewrY1xJmzuv9zKwlTbp9aCIkzYJ9
	 Pc0ItuY6LwcvkU1JcIbe8cuV+6dkkR13FHJB4MSDRooozHJRSGQCLx9rk1a7640EO7
	 QHPcsk+MH+mZ5s8kRqBDD1FAQQ4wB7YYOGMj+lyNEHNONm/qJRdD1qzYFSfbzuZq1O
	 K0cjs14TdtbqsD5ZNyNh0MdZMci3j9PIujz9BMj+NLFp0YkPj+dSLaAWTj/G9Gm4gK
	 wClQogWQ2w3oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Wed,  9 Sep 2026 22:22:33 -0400
Message-ID: <20260910022233.4023433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090851-disprove-ointment-dbd3@gregkh>
References: <2026090851-disprove-ointment-dbd3@gregkh>
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
index f602eee451a35..76c0246714c9f 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2592,6 +2592,9 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
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


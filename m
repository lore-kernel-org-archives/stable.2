Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355665;
	b=ygFlXHzN/WjEVMo/ssAZo5f15yfehdSkNf/7FoMA1Bpmus9aJQZQO5blSTmm9Cn8yub3
	 lA9WCRu4Yya/SiDnQYJVjO1VaUBAVu2EnjKprBGxdQk0kMVcZ5n1G+aLWpSAO/j4xBBlP
	 HuKYYH4n2I82y1Q9K/J14w7dkSt3YdD0yskp/BnMJa5JOuZ2JykmWifzYx3Yywqe8jPIi
	 i52iSSbEpt/V6V0XJIEUF59S1+KWxDBfQ5hSgZez8flIXmdi+rKHUdN8XGPzWPwofFWie
	 gnASG7JmjLmOvkQyxBSxK79+he5V76XiN9LShmLIBLbtEXwv+npRI7C++pOZz825Huw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AbPvfBgZL/3EayqDfS4JwAZwB127TIL4WI0+tUtNsGQ=;
	b=fNii/LOPEklaL/x2KgE3rT/QkCPzk5UATq0cni1YFmLuQiZNYLqKq4kSePD2OLBX0YQQ
	 9ruS+cP2c+yCedFIB1uxEXcwbTIuCOZBIIuKGozROiIONFi0u4fgdkCeipaMkgI7uWNMR
	 kEQytFG5vGVOqvKlBLIatTx4d+Q9TL9ncA5PyY0vazk3ZtQnuSZx2WvNtSZ1Cbu/uZtjE
	 m0iSYNNHWWK+eG0jyKEsH6d6ZHbD/8PPB7KTGlXUh4KoeJ93xXleWGf0gzJDlMmyD4dOJ
	 EzFTnBABGgo/AyAsKgwSpaiG2POWx9CTzgycg5HnFW5BLmF6l8zLZXLKniKPrhBI+kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oknlep8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341D606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oknlep8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5991F0089F;
	Wed, 11 Nov 2026 00:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355665;
	bh=AbPvfBgZL/3EayqDfS4JwAZwB127TIL4WI0+tUtNsGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oknlep8sUSZw3FnxhY6fGc8pjWLzWdBC77WrEF6Ij7PYMFpY4iVsUcTKIWt/K138Q
	 iVBOuW+HHy0KUwNu4YL6tj1g1Ps8gjpJmkqFR3+jV3nkGjQNhc9AOTcBarZSyhnPeN
	 KGRgfPs8Ao4BzZG7+CcjKWhbqdNINxghIUjb6KgD5amAzEXRXp1zZb4qMBcUHepkem
	 /wTm/Pm9Bb0qiUchOWhS3Ymlv7rxyeZYcV7Rtn9BLTzYR/pXsRpNqb8PBN0lfqZhZm
	 7ebFnjidMmgP+SpBLhaZTnMx2717jIU/j3JPIA0hX3dzTzDq8UKk7MCdp8dcC+f0uh
	 WhuzU2V989M7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fbcon: Retry rotated font allocation after failure
Date: Tue, 10 Nov 2026 19:07:43 -0500
Message-ID: <20261111000725.224961-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052505-failed-6.12-7935db1a4a0f@kernel.org>
References: <20261107052505-failed-6.12-7935db1a4a0f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

[ Upstream commit 7935db1a4a0f83a63590a222500e5016e2f6c85e ]

fbcon_rotate_font() records the font, its geometry and the rotation in
par->rotated before calling font_data_rotate(). If the allocation
fails, the error path clears par->rotated.buf, but the recorded key
already looks up to date, so the next call takes the early-out and
never retries. The rotated putcs/cursor ops keep returning early on
the NULL buffer, and the console stays blank even after memory is
available again.

Also test par->rotated.buf in the early-out, so a failed allocation
is retried on the next call: at the next fbcon_switch(),
fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: used par->fontbuffer instead of par->rotated.buf in the existing font cache check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index a3f507825eed8..3105682075c87 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -27,7 +27,8 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	u8 *dst;
 
 	if (vc->vc_font.data == par->fontdata &&
-	    par->p->con_rotate == par->cur_rotate)
+	    par->p->con_rotate == par->cur_rotate &&
+	    par->fontbuffer)
 		goto finished;
 
 	src = par->fontdata = vc->vc_font.data;
-- 
2.53.0


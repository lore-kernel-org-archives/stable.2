Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048779;
	b=m7TH1NwlBs5m+Xz2kGQTa8ouUbQ0ufI8NjDsxM+4PkePcGjZGlkJLa9m3jHLJeEcBSnS
	 l86QOMY3095Tg4/Xsg11TATnXSWtvSizXA0/Zi+f45Ge7Uxpt0lUneNYl064bsceiBQA0
	 eiXI+BPSkbsXNZ4BOiZ7X708ZDsNuFXRocV30zDbCbRHLnTLNLP4OfyHHaqC7VJbEUGzu
	 KpZxsY64OWyW2+PrxwyCu3becar1K/O+yJxVq2tvFoE20DA8yCDdZQVBujYDDDbjG1hrW
	 XrNvV41bnaEn4IHUNSNYlkrAWTK4bRBjsMraZ7wUjqsprYdwbCp5lhfjnfdfbn7zCHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048779;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BZP2WAwK5punOyOfDBpgrMWQjbDNegAvlfuP4r5VwKY=;
	b=W+razU1FYu66wYcyeZC8hvjrhsssba2McQnmv9ZcJWhCh8nU4O+IY+OtAoImzXTvTfR5
	 npu9o4/LVVgDqYWPOWzihfY8mlnA6TwdoNzTFa5xOfb22SHfmJW4X3W00+tgOgiNOvZJ+
	 QfyEa1Z+LQlIURTAOT/XikBICK1z2LhZSKVSGO25aRHVf89SV83WiyzvTzBaHP9mTaBBO
	 JQCLdofXDQ1URyJoo3qpgu3K3pmnfQSsDHrb6g1WJPFz0Id8OHGfT5H9RpODVI53oz80Z
	 ZHEyOrDEarzZHReF+ngA+U0plzH4oOL/AJ/3kyO/98+czRUrbcD5nAW687EdqbnpXFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gopIkDna;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gopIkDna
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF4D1F008A1;
	Sat,  7 Nov 2026 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048779;
	bh=BZP2WAwK5punOyOfDBpgrMWQjbDNegAvlfuP4r5VwKY=;
	h=From:To:Cc:Subject:Date;
	b=gopIkDnaLfzBNJ1Vl1IEKCFiPfYc30ExHOnkPl55jCsDGK9kNVu+Pp0o5ZHUoaTmZ
	 HhxdLPh+YHKslheng7cDbTcm6saU6vn6a1TQf79kUyhCYtRjqzd8tXodbCzZ6p44O3
	 07fD7aTHIFyiPZ+5G+/f9dtrKVWnCWyrZvPIKZUaiM7LHBqSDghBwVXxlNAu1OxbqT
	 rosM0Ws0CNE46FDWXWagJY7P6h5Kmjdn6b7+SaOp8LoAbn5ROeS0SqctLWf+gfWy94
	 d7luE2TBcv2YgtCE6OZT/+F52QkF4uNWwJVOfYADVmdGaZcNzorh+cF9gsidCx4oN/
	 z7wD7+IZnlI5g==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Retry rotated font allocation after failure" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:57 -0500
Message-ID: <20261107055256-failed-6.1-7935db1a4a0f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7935db1a4a0f83a63590a222500e5016e2f6c85e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055256-failed-6.1-7935db1a4a0f@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7935db1a4a0f83a63590a222500e5016e2f6c85e Mon Sep 17 00:00:00 2001
From: Yao Yiqi <yaoyiqi3@huawei.com>
Date: Mon, 19 Oct 2026 17:43:31 +0800
Subject: [PATCH] fbcon: Retry rotated font allocation after failure

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
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81baed..7afd63dcee7be 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.53.0





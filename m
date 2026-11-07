Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049194;
	b=EtUA7H5n7+h6445Qq43THAdjpy8ZsTpz2BFUzcyCpJtokKB4sCdvtAUzsGqX8f4awMwg
	 VN5/I1SdZXI5rCGLk3uUJ0qoQxf7iH8Pw29it3VTYbzSmJeKIlbh77BR2KQy4K02icddh
	 y1TyeqQ06MH/4kEeZMGeHLjwxkR+DOs9OQ9MAKvSvtCNBazMj/QuYY2qmj747fT6f7le1
	 V2brIFp7TE+hL+Sk4bDHF6kcPF9NJHtCdMFXtXXM/qnEtbl50D6uUurohVUWTOLgDYhTR
	 hHV4OFLEDI/fRwEaJCj26AJA7BvC8ySQn9Ch+FEJvQFds3M/AJ5Ionx4381peFyw+Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cFasLYR78VytkYU7BdbNeVWDdtvlMJSQfl2pVbSCNJw=;
	b=JIok6iviNRvKWT7v/dvavB8Dskk2lE6pl7KcJ5yPz8NuJwULFoBlzKbSpg23Rc0z63m3
	 v36tCi9TUzVqpA3EcDHaZiX5HuVnYG8OSI3dH78Rdfi6u27+Xp6maHUycfyf6c30rMYSJ
	 uifTO+GqLrb/D+vKBkX+X+9HTbHxrF4n4ek1+Bg4yPUZQr8HW9d9CUhv2j6kNAj/tz81u
	 wPhM35VEzbWDCRN9wwR5KQ8qZ32/Ti3H8B5HlXGOuem0zqmiyuQFc0oE4RcZ7WIL/UdbS
	 4K66RPxbgeWZKJ/4fTttxbVvzmTMryXYuj4NnkTCMMGGnMN8e4dhLVYTnm4gJRDfG0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSAEfGoB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E2606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSAEfGoB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA1D1F0089F;
	Sat,  7 Nov 2026 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049193;
	bh=cFasLYR78VytkYU7BdbNeVWDdtvlMJSQfl2pVbSCNJw=;
	h=From:To:Cc:Subject:Date;
	b=bSAEfGoBqH5i7QBM/UXIMN1oSOhCtZx+umkCtOcf4H6CCrapPaLNjo7w3OpcmpwRo
	 uJyaunJ2ctD3Z4/VKrmMcBvWHtqxDWu9AeDuRwYzvlO87drJM+jBbWUrLYhXdj67nD
	 w85NLf3GfAnk3ROiRR/eg68H/q4ZqrbTjU9JPhBTzuGCt1N/B5i8rK+NqGtRz7NsOr
	 WtXSM7Qbg6S77Dp3l90ll9K1mwuJ9++Q46yM85KqqdrzMohHKiU9ipNzPVB/8Amwxy
	 VNH0yUVdvz40J1Ii/4NPLnXpLIM2cW1F4v7g6wnA69xPw8SklB0Ca5ZAA+aB2ArVBM
	 OX/6EYeilE8qA==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:52 -0500
Message-ID: <20261107055952-failed-5.15-b00fbdad64d4@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b00fbdad64d4ea7d594bc67988c1722fe5b3be50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055952-failed-5.15-b00fbdad64d4@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b00fbdad64d4ea7d594bc67988c1722fe5b3be50 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 10:12:22 +0000
Subject: [PATCH] media: vpif_capture: Fix i2c adapter reference leak in
 vpif_probe()

vpif_probe() takes a reference to the i2c adapter with
i2c_get_adapter() and passes it to v4l2_i2c_new_subdev_board(),
which does not consume it, but the reference is never released, so
it is leaked both when the probe succeeds and when it fails after
the adapter has been acquired.

Release the reference with i2c_put_adapter() on the success path
and in the probe_subdev_out cleanup, and initialise i2c_adap so
that the cleanup is a no-op when the adapter was never acquired.

Fixes: 6ffefff5a9e7 ("V4L/DVB (12906c): V4L : vpif capture driver for DM6467")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/ti/davinci/vpif_capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index 91cb6223561a8..397f3115af5b7 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1602,7 +1602,7 @@ vpif_capture_get_pdata(struct platform_device *pdev,
 static int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
-	struct i2c_adapter *i2c_adap;
+	struct i2c_adapter *i2c_adap = NULL;
 	int subdev_count;
 	int res_idx = 0;
 	int i, err;
@@ -1692,9 +1692,12 @@ static int vpif_probe(struct platform_device *pdev)
 		}
 	}
 
+	i2c_put_adapter(i2c_adap);
+
 	return 0;
 
 probe_subdev_out:
+	i2c_put_adapter(i2c_adap);
 	v4l2_async_nf_cleanup(&vpif_obj.notifier);
 	/* free sub devices memory */
 	kfree(vpif_obj.sd);
-- 
2.53.0





Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045970;
	b=glXCzWp2qv7bl+JhpWfniEjPEbti63txmd9j6GEkZWGqvKv/uy/mvZ5e+u5Jz0TWhAsl
	 PpRQvyAJS4bMv8DhS8rRB87bqsFq8Zog39VUlGsEibjq6knYqwyrxxea+D2q0mAvImADE
	 mMIS2kvIi7xSuJuvG2q0C7vpLC+3X7862kEECJARIhXdUtzu0rXqnzJ5JwwGe4RQYeKtV
	 fnG05C5MuGXXnRte5dRbTSGsslQK859WMbatTfzx809Fltsd+lcwRJubVjaPVuuQENrbd
	 EQGzIp+Q7lUDLHGnZ6d5TbkYWXOXx6E/cKbVAuybNStv9hFxggZ6/JKWG+f+77mnKWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=33XsWVSb6M2erJFGTicHBJvgJU6QYg1O0CncWOouq9Q=;
	b=IFlxfGCG6hvHU4v26miuyfHxZ1g5PVZAhHCOpxOMERk4eoguArWg4qfvA4Y/szorHgCU
	 RiEZITz4N64qLYbp+Pr4UZp1g5WOQDHOWSbtK7/FPC2Vh10YAf9pzWx2fWzbllvCn6WC8
	 +O4QSFzAS+oyj56eoB+0D2Fd3qc0La0+kBRPC/QqHAMdnNTjIWdO4EiodgTKebx30z7e5
	 fo5rUwbEPj3BaxgMW6CPtfaziOZxpFNl3/AAksWmJyBveQaV8drBdnTVbWYLwatLCH06C
	 wsdLN39X/+4b46F83ItgFzLu/DRy/a8ZsjCdtNVyQF0xsi8NqqKROsqERe0zIpLR1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0mjTJwW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0mjTJwW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22181F0089F;
	Sat,  7 Nov 2026 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045970;
	bh=33XsWVSb6M2erJFGTicHBJvgJU6QYg1O0CncWOouq9Q=;
	h=From:To:Cc:Subject:Date;
	b=X0mjTJwWDeu52LvNRNcf52NrsDiOJLQ6U1qmd/Dz4hmaOLcCTAwJxtb38HIK5p+oI
	 nOivQ0O4FHN+j21FXdp8eLyd33zbo1BaCdMoxoHN4BkHiklY9DXoMnh94Md6FJPzMb
	 ePsCx2F+DysRbTP9VUQfkrErFk0dWunPpz+QJg5t5Vw+GfptNHd103ac0kR75j8/C4
	 x5gTIgXy/xfctjOvdF4YSDKH7KND2m7ov642pJNTaCi+NAcMTWLjACPGvNLre39r37
	 us/llCbVe8BZpI10+qes7UUuexvX2cKyA8NqtMnMK9i0vycfHWrHegQmbaQueKgfd1
	 2+dyOjM5JnG4g==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: redrat3: Error path leaves device in transmitting state" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:08 -0500
Message-ID: <20261107050608-failed-6.18-8024d5e84531@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8024d5e84531d828535365718278f1cf0ce67db0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050608-failed-6.18-8024d5e84531@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8024d5e84531d828535365718278f1cf0ce67db0 Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Mon, 13 Jul 2026 13:08:40 +0100
Subject: [PATCH] media: redrat3: Error path leaves device in transmitting
 state

In the allocation failure error path, the transmitting boolean is not
cleared. If this error path is followed the transmitter cannot be
used again until the device is replugged or the module reloaded.

Fix the error path by moving the assignment statement.

Remove the check for the transmitting state in transmit, since rc-core
ensures there is never a reentrant call to the driver transmit function;
the transmit function is always called with dev->lock held.

The transmitting boolean is only used for interpretting firmware errors.

Fixes: fac59136bc22 ("[media] RedRat3: Return directly after a failed kcalloc() in redrat3_transmit_ir()")"
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/rc/redrat3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 30111deb6013c..b07ff832a938c 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -773,17 +773,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 	u8 curlencheck = 0;
 	unsigned i, sendbuf_len;
 
-	if (rr3->transmitting) {
-		dev_warn(dev, "%s: transmitter already in use\n", __func__);
-		return -EAGAIN;
-	}
-
 	if (count > RR3_MAX_SIG_SIZE - RR3_TX_TRAILER_LEN)
 		return -EINVAL;
 
-	/* rr3 will disable rc detector on transmit */
-	rr3->transmitting = true;
-
 	sample_lens = kzalloc_objs(*sample_lens, RR3_DRIVER_MAXLENS);
 	if (!sample_lens)
 		return -ENOMEM;
@@ -794,6 +786,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 		goto out;
 	}
 
+	/* rr3 will disable rc detector on transmit */
+	rr3->transmitting = true;
+
 	for (i = 0; i < count; i++) {
 		cur_sample_len = redrat3_us_to_len(txbuf[i]);
 		if (cur_sample_len > 0xffff) {
-- 
2.53.0





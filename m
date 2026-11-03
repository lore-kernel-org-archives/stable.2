Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700840;
	b=ni5yRko7OYenrsWm5sPukhSzWq56NiuQywPWmWpiwgl1M0v+lqJXSLDs1d8S7EG5jUdx
	 tZhiPpLUTMYjOjW1jOby6fcXXGO23pl/c3heersuXF8NhApa14kBFmfeiJGVnF3gdXnhF
	 Ev7PTppWQvz5/kgJbtqwIerHDnim24s8RPlX/0UVK1Hu+bkocqRa93AU3ftjrALQ5EBJQ
	 YaU0zpb75Z6ydCeqjQHSSjbsSqaZ0piucaxn8ECl8ga/9eBu8ZpaFz1xJfh2rcD1FhH1i
	 YehFTlRvmkqWmCKq8hjuB7oH+32Fr7NCPwVmYZR5pMCgJVJhfDijTzoZkERznN5khJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700840;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QTZQD7jKt+XJmEOS92hivGTP44vPnNuOEC5SfX/Zotg=;
	b=qOOuvZjPiiwBGFFbY8/uV9VpHf869MxSn7NTRwgIFnFltfJlE1nlPg0Gb9imwr5t44Ho
	 F/stwZUUr2cuxmbKbnxT0H3pVRboRS8fZMAtuKpfK1Kq63SDdCb+J0YdO1qQc4drDckG/
	 w2ujy8/pARExV/1HKb7w6mMpmFxO6O1Vg1MV24qCpk4YYp/uPt2K2hfmm9X8cdoNjmQsU
	 L1sxgQyC9LErsrpNAw19FLkCqAymrFIEzNtYcxyhOangIbC09BzyNYgX55zuUysxcZjZl
	 /IHnApbhpj+HnV3jUz+WTVJqb+XRUoZSQeKRUZxrYqSTLvXQ18c4xJcf4GTFqR+0V+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ik5goe3q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4AB606B117
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ik5goe3q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B805C1F000C1;
	Tue,  3 Nov 2026 10:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700840;
	bh=QTZQD7jKt+XJmEOS92hivGTP44vPnNuOEC5SfX/Zotg=;
	h=Subject:To:Cc:From:Date;
	b=Ik5goe3quSUFLXYsMWq+gEKKcAmo0Wgoq5JfjyNP8Uq4ekqCQo5NvGgDSWRpVVS93
	 6EHh52TLVLQ7nf14e3trFDfsus5hpM+bOZbXzKqnS+msPVhqnkwYXPQRFpDWOfaPUt
	 TLyfSovHZZuqilXb4djxFsnTiNupU9rRSewJ52ZI=
Subject: FAILED: patch "[PATCH] backlight: lm3630a: Cancel delayed work before destroying" failed to apply to 5.15-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,danielt@kernel.org,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:13:58 +0100
Message-ID: <2026110358-afar-payable-c2d6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2cf184caab8b406fdd9db126ee40d62418237456
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110358-afar-payable-c2d6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2cf184caab8b406fdd9db126ee40d62418237456 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 2 Oct 2026 23:04:39 -0400
Subject: [PATCH] backlight: lm3630a: Cancel delayed work before destroying
 workqueue

The interrupt handler queues delayed work to read the interrupt status.
After free_irq() stops the producer, this work can still be waiting on its
timer. destroy_workqueue() cannot drain delayed work that has not yet been
queued by its timer, so the timer can outlive both the workqueue and the
devm-allocated chip containing the work.

Cancel the delayed work synchronously after freeing the IRQ and before
destroying the workqueue. This also waits for any running status read to
finish before the chip's resources are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Link: https://patch.msgid.link/20261003030439.599330-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8f49e59ce374..8ef8163c7fef 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -591,6 +591,7 @@ static void lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
+		cancel_delayed_work_sync(&pchip->work);
 		destroy_workqueue(pchip->irqthread);
 	}
 }


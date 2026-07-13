Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD340FDAF
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946815; cv=none; b=vEjm28zX/NzwLnWUYqoQthe7h+tEZANv1LLYMR4f4V6tVGYqLpKLjtAmViPC7akcridZUMdjHcTB0kKa8g1IL3BXD7zYUKvnJxqxEB7NKr3eNdpdsCIGjTwt4ms5f5/KwXR+NraW6DnWsDG3EbT/6ka3J8Dg6SNsbaDkMbwhWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946815; c=relaxed/simple;
	bh=UnsZcAc6QneCiswXB/04ds2Pg6uvmpqPE4vtOikW0rs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nnUqH2x2uYbshlx7UdjwOqp9mtgcqkbTZkF5OnPsuGvV1MGrJDejkQ5mMrQG/C2qtan8JoxGStq6uyJAbEuuuZ7RLn9hQ3DDLgUPHlB0mOvuqrjcpoVhyPPF5uSpHCKPtWNiSvHQaj4Mi2KTUShMT22+KpzElf7lvjj3XzF/DJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KX0LWkzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KX0LWkzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348D41F00A3D;
	Mon, 13 Jul 2026 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783946812;
	bh=+kKStmpabwFdJ7OkNdkv0dZiqIyfYY8X8nU6OAI8UTM=;
	h=Subject:To:Cc:From:Date;
	b=KX0LWkzD7IEb2VblY7Tsym9lV5it8KNblB66GF586x2hZnKQyEj8ITlmPTOfKkf4z
	 Cbkb7wuRCTWVeWiUvb/1Ja00TaRylBqZPcANfHZIUq21V9b7x0Eh6cU/UqMMrMA8TV
	 d6+hvaiu9z10uDCU+tj0xwXai0xGx2SXGzOA3P2E=
Subject: FAILED: patch "[PATCH] iio: adc: spear: Initialize completion before requesting IRQ" failed to apply to 5.10-stable tree
To: m32285159@gmail.com,Stable@vger.kernel.org,bookyungwook@gmail.com,jic23@kernel.org,jjy600901@snu.ac.kr,sangyun.kim@snu.ac.kr,vz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:46:47 +0200
Message-ID: <2026071347-duplex-theatrics-64bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3ee2128b6f0eb0be7b6cb8f6e0f1f113a65201a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071347-duplex-theatrics-64bf@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ee2128b6f0eb0be7b6cb8f6e0f1f113a65201a0 Mon Sep 17 00:00:00 2001
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 12 Jun 2026 19:58:11 -0500
Subject: [PATCH] iio: adc: spear: Initialize completion before requesting IRQ

In the report from Jaeyoung Chung:

"spear_adc_probe() in drivers/iio/adc/spear_adc.c registers its
interrupt handler with devm_request_irq() before it initializes
st->completion with init_completion(). If an interrupt arrives after
devm_request_irq() and before init_completion(), the handler calls
complete() on an uninitialized completion, causing a kernel panic.

The probe path, in spear_adc_probe():

    iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
    ...
    retval = devm_request_irq(&pdev->dev, irq, spear_adc_isr, 0,
                              LPC32XXAD_NAME, st);           /* register handler */
    ...
    init_completion(&st->completion);                       /* initialize completion */

spear_adc_isr() calls complete():

    complete(&st->completion);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access."

Fix the chance of a spurious IRQ causing an uninitialized pointer
dereference by moving init_completion() above devm_request_irq().

Fixes: b586e5d9eee0 ("staging:iio:adc:spear rename device specific state structure to _state")
Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Closes: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 4be722406bb5..ab02a14682ed 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -283,6 +283,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	st = iio_priv(indio_dev);
 	st->dev = dev;
 
+	init_completion(&st->completion);
 	mutex_init(&st->lock);
 
 	/*
@@ -329,8 +330,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	spear_adc_configure(st);
 
-	init_completion(&st->completion);
-
 	indio_dev->name = SPEAR_ADC_MOD_NAME;
 	indio_dev->info = &spear_adc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;


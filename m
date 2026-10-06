Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C42282F1C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272571; cv=none; b=kJ9E4IBWsfeY74jz0+nvzmXYh17V84X9rdiGnpypfk+yXhswGe2UAqdDYbVL1Gzy+FLiJPNHKGtUkgLjJ832UymkN7AoXqwI6f/ieK7tXjD4jwqNXE+lIlPXJEWthfyKVFNrpUVGcetqfXBEKOAX1j6mmnqjGL1qXAvbxap5bRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272571; c=relaxed/simple;
	bh=3T1BHylXpDUcP0ReHvhEiQm59Eh3hJv1IcDjWEU43mo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VGphADbwh0jMfe+Mrishm52jSzgVAeU01Xr0SpOkx64LVhrr3ftJ2f4LSmqLjeSdalxK6MtgR3p8yx/hPcnUNkWrjQ4DdHe8zkA+CEngrMVVOPEFb0ViF8F5hHBY8pJ7pHvCfEOSaWU6rUdM4R0aWLTN9jljJlyxqxjvCV9H3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/u+X//b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S/u+X//b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FACF1F000FF;
	Tue,  6 Oct 2026 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272569;
	bh=PGhodk25StXm0lYaQH+vbArDY36nA1Ce19TGrJvNfds=;
	h=Subject:To:Cc:From:Date;
	b=S/u+X//bMV8iM6x3DyKyJxq8lWzz/YZ66JuvCCbcohv7ysTN0VioGuMdKJeg9U+f6
	 L396Eo0bUeThhZ5tZ1T+UElqIF2eAfKaPfg+2bS91csUI9p2JC40bpc+HKte4EYy0W
	 io8t+9CnlAG3bGdp8FiMrvmQTO146jFCI5ZN0ZeU=
Subject: FAILED: patch "[PATCH] iio: accel: kionix-kx022a: Prevent memory leak and fix state" failed to apply to 6.12-stable tree
To: mazziesaccount@gmail.com,jonathan.cameron@oss.qualcomm.com,mehdi.djait@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:42:42 +0200
Message-ID: <2026100642-onslaught-extruding-e802@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e65e128b51a37dd1a9056ac3d1705d805a5c8bb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100642-onslaught-extruding-e802@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e65e128b51a37dd1a9056ac3d1705d805a5c8bb0 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Wed, 2 Sep 2026 11:49:05 +0300
Subject: [PATCH] iio: accel: kionix-kx022a: Prevent memory leak and fix state

The driver allocates memory for samples at buffer enable path. If regmap
operation fails in the kx022a_fifo_enable() at the buffer enable path, the
allocated memory is never freed. Furthermore, the state information and
previous hardware configuration(s) aren't undone, potentially leaving
WMI interrupts and buffers enabled, or driver state flags wrong.

Free the memory and revert the hardware configuration and state flags on
error path.

Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f671fab3dc31..9ff70a373141 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -980,26 +980,44 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 	guard(mutex)(&data->mutex);
 	ret = __kx022a_turn_on_off(data, false);
 	if (ret)
-		return ret;
+		goto err_free_out;
 
 	/* Update watermark to HW */
 	ret = kx022a_fifo_set_wmi(data);
 	if (ret)
-		return ret;
+		goto err_turn_on_out;
 
 	/* Enable buffer */
 	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
-		return ret;
+		goto err_turn_on_out;
 
 	data->state |= KX022A_STATE_FIFO;
 	ret = regmap_set_bits(data->regmap, data->ien_reg,
 			      KX022A_MASK_WMI);
 	if (ret)
-		return ret;
+		goto err_buf_disable_out;
 
-	return __kx022a_turn_on_off(data, true);
+	ret = __kx022a_turn_on_off(data, true);
+	if (ret)
+		goto err_wmi_clear_out;
+
+	return ret;
+
+err_wmi_clear_out:
+	regmap_clear_bits(data->regmap, data->ien_reg,
+			  KX022A_MASK_WMI);
+err_buf_disable_out:
+	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
+			  KX022A_MASK_BUF_EN);
+	data->state &= ~KX022A_STATE_FIFO;
+err_turn_on_out:
+	__kx022a_turn_on_off(data, true);
+err_free_out:
+	kfree(data->fifo_buffer);
+
+	return ret;
 }
 
 static int kx022a_buffer_postenable(struct iio_dev *idev)


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322146F497
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948855; cv=none; b=ki0Y+yaedsYUytv73TrMXKYnxjXSFOR0E2Dp29ICLwqzMyoig/8+bro/kyBAUo2FlcVH9ClKrQTRfFU4BU27Hscp9ywHhkJc0JLT+2TT/eza64fVqtXH9JPfj6OCjhCKHd6dCo92vKNSNAChyoz0mB8MtD/AVI+v8wyjGM0qiTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948855; c=relaxed/simple;
	bh=T75JMQEQcDC9z2bOCwBWyrK/0RGljov7Q/kK9PSyI44=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HJ2kabguni54buhzuAW3Nv0Fe3wYM1+heF7HZ9Mu/1IQ+6EdARJbzSmCZcsHSiyLq4tFHvykels6zXFzPrZbugpyt0hC4iCltOLqCUEUefP8bLJ0vPmiKAhz13BS68NZk2Qg6uW3D4YD72oAaPCdJJILRvPGUDrVq4QUfc7+VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DlNI/Nlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DlNI/Nlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DCB1F00A3D;
	Wed,  9 Sep 2026 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788948848;
	bh=pQq1YHBU46UEfLrfIjVrv9/0g/KLaQ7Nk9XGtJjSXWU=;
	h=Subject:To:Cc:From:Date;
	b=DlNI/NlgutQGO+avHQ+W+YfEMBk6dTm3nqavpkteT4CqruwVa9CHi+lShJEXeHWzu
	 PlTqS72uPyvDwchNJCN5nzgEEDAmFkViyqO7w3IOaZdDaFNNbOgR0ast4zyh+bDDLv
	 NePOUPz9pfEy3WsIczYGHUd0D10kuKcagRzEzspw=
Subject: FAILED: patch "[PATCH] ASoC: fsl_easrc: Use div64_u64 for 64-by-64 division" failed to apply to 6.1-stable tree
To: wangdicheng@kylinos.cn,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:02:40 +0200
Message-ID: <2026090940-savanna-icky-839a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a46ccc71877e962783e0fffa105e41615904c511
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090940-savanna-icky-839a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a46ccc71877e962783e0fffa105e41615904c511 Mon Sep 17 00:00:00 2001
From: wangdicheng <wangdicheng@kylinos.cn>
Date: Fri, 17 Jul 2026 17:15:42 +0800
Subject: [PATCH] ASoC: fsl_easrc: Use div64_u64 for 64-by-64 division

Fix a coccinelle warning about do_div() truncating a 64-bit divisor:

sound/soc/fsl/fsl_easrc.c:2061:2-8: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

In fsl_easrc_m2m_calc_out_len(), val1 is computed as:

  val1 = (u64)in_rate << frac_bits;   // frac_bits up to 39
  do_div(val1, out_rate);
  val1 += (s64)ctx_priv->ratio_mod << (frac_bits - 31);
  val1 = val1 >> 12;

In the worst case (in_rate=384000, out_rate=8000, frac_bits=39):
  val1 = 384000 << 39 / 8000 = 26,388,279,068,672
  val1 >> 12 = 6,440,497,829  (33 bits, exceeds 32-bit range)

val1 is then used as the divisor in do_div(val2, val1), where
do_div() silently truncates it to 32 bits, producing incorrect
results. Use div64_u64() to perform a proper 64-by-64 division.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Cc: stable@vger.kernel.org
Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
Link: https://patch.msgid.link/20260717091542.721877-4-wangdich9700@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index edfd943197a0..15a342496760 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -2050,7 +2050,7 @@ static int fsl_easrc_m2m_calc_out_len(struct fsl_asrc_pair *pair, int input_buff
 		/* right shift 12 bit to make ratio in 32bit space */
 		val2 = (u64)in_samples << (frac_bits - 12);
 		val1 = val1 >> 12;
-		do_div(val2, val1);
+		val2 = div64_u64(val2, val1);
 		out_samples = val2;
 
 		out_length = out_samples * out_width * channels;


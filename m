Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70E3D3D02;
	Fri, 17 Jul 2026 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271817; cv=none; b=kk15jPv5N2EisWPWuX1qKEJi69CyH5p9blZV16AI+pMZ/V5kZEhgw4V0OYEF0xVJ0Iu9sZ/sqiAVF22KdYy3ySSweob3VVZO6wvOmS2l2A4TWEZ5nrPTw95hJyOmbcxjhL2o3c+JySohUXw2OzS2dtWaFieugekq2l3nBhR5ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271817; c=relaxed/simple;
	bh=ooLhbJab2IT/jUsdMQ220H8Nl/Yjwb6jciWzNw5sptg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzMcdPf33FunspZIB7ujEFsaEynZmEdEzcO4f7hGybuRDsHHs7jTnSbnIhYJ4luxVD/iDGjigDi4WI3S/6l3lgW7ZEMYv/5q5LU8AsYM8YHZBqId8FMK0lz/DJQkowggGTMlMk676Rq3xNAxMdQeVhvLyq+ZHBtJtfmM2NkFBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=flbdJ9ZY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="flbdJ9ZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Tm
	VQJyyUL5l/QZ+zdgCJ4FmSIFyEWgOI5mJJblrlpWs=; b=flbdJ9ZYZqU3Z1B/JR
	e5Yh/6RjEJqIrCCV+/iQ2Gg+yyyBDQMb2SXbwURBCUvlpWTZ83Oa3VMLSSmFJXqM
	9PUUsQWV8mvuw22mXJtsug4n98crfHR/k4Y35vIC4lurfUAK9fUOTZQYGrbJLIKz
	sIzew0tnQIXyWQepMbBh0gJOE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3tYmk01lq70RfKQ--.38418S5;
	Fri, 17 Jul 2026 15:03:07 +0800 (CST)
From: wangdich9700@163.com
To: tiwai@suse.de,
	wangdich9700@163.com,
	broonie@kernel.org
Cc: wangdicheng@kylinos.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ASoC: fsl_easrc: Use div64_u64 for 64-by-64 division
Date: Fri, 17 Jul 2026 15:02:51 +0800
Message-Id: <20260717070252.525545-4-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260717070252.525545-1-wangdich9700@163.com>
References: <20260717070252.525545-1-wangdich9700@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3tYmk01lq70RfKQ--.38418S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF15uFy7uw1Utw4fuF1DAwb_yoW8JFWrpr
	9xK398XF98Gr43Jan7Jrs7ZFykJry8Cr4fGa4rt34jv3s8Zw18XFZ3tr1rKay7t3yfGFWS
	gr1Dt345JF15X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi_gArUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbC5wsQX2pZ06v6sgAA3g

From: wangdicheng <wangdicheng@kylinos.cn>

Fix a compiler warning about do_div() truncating a 64-bit divisor:

sound/soc/fsl/fsl_easrc.c:2061:2-8: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

do_div() truncates the divisor to 32 bits, but val1 is u64 and may
exceed the 32-bit range after (u64)in_rate << frac_bits >> 12 with
frac_bits up to 39. Use div64_u64() to perform a proper 64-by-64
division and avoid potential truncation.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Cc: <stable@vger.kernel.org>
Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/soc/fsl/fsl_easrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 114a6c0b6b73..d0bbe9f71e36 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -2058,7 +2058,7 @@ static int fsl_easrc_m2m_calc_out_len(struct fsl_asrc_pair *pair, int input_buff
 		/* right shift 12 bit to make ratio in 32bit space */
 		val2 = (u64)in_samples << (frac_bits - 12);
 		val1 = val1 >> 12;
-		do_div(val2, val1);
+		val2 = div64_u64(val2, val1);
 		out_samples = val2;
 
 		out_length = out_samples * out_width * channels;
-- 
2.25.1


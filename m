Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82013B42C3;
	Fri, 17 Jul 2026 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279775; cv=none; b=M02QmKOnglk0W1fmeNNQKNxrh5mqpMaYhNYBy52CLVfKTiBMNO8oHvrp92OZtirsYhZTuN+e8euCkarOi4sFpz9VfPez4asPhNA6t+IoOhgT7bykh9bsYJ/6fL8m9JgEKm8sRvPhcO3qfI4P0mK956dDhDLeVBMpd6dk73IBv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279775; c=relaxed/simple;
	bh=848OXhe6U0KxRAxr7jnpPmZd+1CeMFV88mt0Nz7HL8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/wCY03i9S+7psfXsdhKlL6F2DBc7nVV2Bzoeu10GXYpOgF2/l/lNiraXT3OmwhmyJ16ZKqzo0eNOf0r3rvV8OlK726veHopri/Tglg2e3lUqwB1ZfbcFIpPBAQ9R8eCrt3J4ZKrMuA3PdxQ07qxPJ/4X8Dya/Zf37Vs41kv6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OuTK+U/g; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OuTK+U/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ar
	NuXaaXPl+pNmtWexIb7J0Kf0kgXGBRhY0rUy8F624=; b=OuTK+U/gkX7aJUHN5/
	gbQh/pNa1aL6rGvOdEDFRHRiIncdrMBHu8NoDfOYStMeBHTTlPZR023+TlmPvOrs
	6ajrhu8YvhMmdflw1tA9XN13xhDWko9vIGI9ZRfD4s4bNR8qASHf0AcMLlSvZgaU
	D3fcA+5yLdYnR00ANa6RBz19o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3jTm_8llqT1CgJA--.17062S5;
	Fri, 17 Jul 2026 17:15:49 +0800 (CST)
From: wangdich9700@163.com
To: tiwai@suse.de,
	david.laight.linux@gmail.com,
	wangdich9700@163.com
Cc: wangdicheng@kylinos.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] ASoC: fsl_easrc: Use div64_u64 for 64-by-64 division
Date: Fri, 17 Jul 2026 17:15:42 +0800
Message-Id: <20260717091542.721877-4-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260717091542.721877-1-wangdich9700@163.com>
References: <20260717091542.721877-1-wangdich9700@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3jTm_8llqT1CgJA--.17062S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1UZFyxCFyxKr43WrWkXrb_yoW8WF43pr
	ZFg398JF98GF43Jan7Grs2vFykJFZ7Cr4SkFZ8tw1j93s5Zw18tFWftw1Fkay7tryxGrZY
	gr4Dt345XF1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUDGnUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCwAXeLmpZ8sX7CwAA3B

From: wangdicheng <wangdicheng@kylinos.cn>

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


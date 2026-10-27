Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071377;
	b=HnElq48UTNVt09EZry0JJqKYsO1QJJw7T5D1RbcBbpbo8TsjZDEmJKMX5I4so0iuTY+A
	 DySUHhfTTKpK3q4iOovRh1J99DJxBMJmRb8bGj9I65dlJKBgEb9KRbItGhma48Zv1RYYd
	 m19eyS73k7isplgYCtvy/n3hXL48JRo41xSBjxY3eug49raTPk+tzrKw0oQXIC5ffHR2i
	 DvaA4MioUfgRF6cnjps7PxzD0pDreki9pt5/4qkuKcjd+62gbL1PebV5u297qnJKiot+0
	 8/S1AWug//SMrZnhifdT/Q0JxYNZifSu+rUDdue2+ByTjMgIAkHQ2j1iC5cfl5h6JBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071377;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DiTPXO5xVu0vGg/SOQMr/bg19yBbPJ0qj2Y96BQ/D0w=;
	b=iZJLKHPjYo3FpH4boz0rLbMZkQIMbLVd0lVyilz3gw78BEXGqOvRjKjB3Y/GZUxfW55+
	 sk58o/xrSDTwDgydlkc+lTMq5sX1dyY8p9zsK4kKekF1EHu/UwO5ZEMwpdHmQ7Un7W7w/
	 VZ74jWg84WSb8jOpKhVLW6dpK0KC9nF9dlh0fpMd5LxVOCpJ1m45LpuAb7Peqb9Z2Jd0L
	 0lnkLgqWxr4wQzU1bpyclMk5lguevz+2zahUZB/ibDu+1rRTqb/iN/ShBntcvwt0UxJOl
	 L9mnU6lMkhm7lzLw26rKzFR97KScIPI9Ui251UKgGyQD5NaJ0Atcw1FWdF+TuvSloEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Ic3OyrLY;
	arc=none smtp.remote-ip=203.205.221.235
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346C606A31A;
	Tue, 27 Oct 2026 03:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1346C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Ic3OyrLY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793071367; bh=DiTPXO5xVu0vGg/SOQMr/bg19yBbPJ0qj2Y96BQ/D0w=;
	h=From:To:Cc:Subject:Date;
	b=Ic3OyrLYxyoXcCpOxbkR5LLt90d9yaJ6tb3/LTN5pKTAb55ZwmhTtKh3E2mOExNdP
	 Ew+GIlX09fyIA1QWsLYJbVqa6crW9zLZw4uxEhyZNc5J1YlGDTRJNiSKv/EC5nfDwN
	 RLb7EifbSA7vDWlpoDIDUYVDGIbirpb1x+SdtM00=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:ad3c:addd:6586:2a94])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 5AC19A76; Tue, 27 Oct 2026 11:22:44 +0800
X-QQ-mid: xmsmtpt1793071364t85lw5a1y
Message-ID: <tencent_592E3D2D89322E934E28FE593E67826AAC09@qq.com>
X-QQ-XMAILINFO: Npb+f4q7yCDRDd/jO7WSCn6CUiMMevd6fSeZ1TZYAoiOzwH3/m5M0kUczkRqnP
	 gPmSuV4rsoB1Gz6YA90xTuGXt3ao0QRQbsSYpUY88KiowXNMSvABKGGy+Y4bxOI2ZOMPVOzJdiHW
	 dXI1ejT+A7imFZH61+7pa/glZY1YDRue0LIpE/Xuu2YyfitQqKMgAUkGgSAfXPh3hs9yXdH/oHU/
	 4EkE/Wr11sbqepjqxGrEBMP/1tVhRBa3qKg1dWbrAnpYSM96JxOdC9hOVnif914MPhsbDF0PM8oX
	 IXKkIuoVQLAqS8+sIPVlb587zuLZfL8ttGh2xheDl7oD45PgzAyl0U++JW+8IDm40xqbdMA3Hgqg
	 1aCrInPM7kCOhQ7WRT5js8sIxLMnxVZ+SVRUCE17Psbb336j37pWIvZsku5+GStqxOeOQ+cELDZj
	 DntZeYbdFT5tuXAGTolmHdiGFbFTBuyqtcXJyQeEIgeqz/GwS06cZgmtF5Uyr+F09QnDwHHYVcCE
	 zUf9+CHY0HSGydrnrwZ+cHqRv5lZ8Fm3xByh8D9XaLfv4Op3xjkl75aticRE75MTpLieUiLw9oGP
	 l7qDjFoW/tkxX91+vD5GuFlPu7v3IBxDJU2n4xh2xOk+hxtLsdkceZ2lTUBft9CLwXdzThTC8zDA
	 zMM/Ft3G7LZKB7/IyscQnCF4N85UfliOrSsB+A4r+Qx006kDIi3ObBU0mlQ6Aqx0pN4Aan//VRoZ
	 kaapLMBT1j88tpM6GYiVYcnjDZPefxhMXA3XH0ShxRRWw6cMQa2ujwS+FjjSRcdKarVQeq9DhqRS
	 cN6Kndb3yQZ8BFEGh6p0E0CwtRUQiIVKVmwoQBGWWR9Npfxzig3PLJtJs/OsYeml9mECRuItzTJk
	 j7/AMUBSIIQkbbeDsa3+qBaOc82SqW7l230vGlYhEKRe99LHP6Vsv8uuaSm5KPAb+E7rtZTotYrt
	 gwnDagVVv6zClwHPFTpxrxwwovwqCP0/wMJghAt5QlJ5WXQL5fJoZgmGbjHTfioAR1UkYxnyY/l1
	 /G9jkqdwgKyYQFQNUn4oc3wfGEUxoai2D7KKD1JQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Yingjie Wang <1075151112@qq.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bbhushan2@marvell.com,
	gakula@marvell.com,
	gthiagarajan@marvell.com,
	stable@vger.kernel.org
Subject: [PATCH] perf: marvell: Fix DDR PMU polling period unit
Date: Tue, 27 Oct 2026 11:22:44 +0800
X-OQ-MSGID: <20261027032244.3333338-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
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

The poll_period_sec parameter specifies the overflow polling interval in
seconds, but cn10k_ddr_pmu_timer_period() multiplies it by USEC_PER_SEC
before passing it to ms_to_ktime(). This makes the interval 1000 times
longer than requested: the default of 100 seconds becomes 100,000 seconds.

The driver relies on polling to handle counter overflows. Delaying those
checks can leave programmable counters frozen at their maximum value and
lose events until they are restarted.

Use MSEC_PER_SEC to convert the parameter to milliseconds for
ms_to_ktime(). This corrects both the initial timer expiry and subsequent
polling intervals.

Fixes: 35a43326a9e3 ("perf/marvell: cn10k DDR perfmon event overflow handling")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
Built drivers/perf/marvell_cn10k_ddr_pmu.o with W=1 for ARM64 and
x86-64 (COMPILE_TEST). No Marvell hardware testing.

 drivers/perf/marvell_cn10k_ddr_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 9b68d6c1c31cd..31641a21e3792 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -516,7 +516,7 @@ module_param_named(poll_period_sec, cn10k_ddr_pmu_poll_period_sec, ulong, 0644);
 
 static ktime_t cn10k_ddr_pmu_timer_period(void)
 {
-	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
+	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * MSEC_PER_SEC);
 }
 
 static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,

base-commit: 652ab8ee0d27f21a5f402a0b6ac227c8bbfdd64c


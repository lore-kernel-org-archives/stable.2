Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285253;
	b=aaaIteSQ9nRWECI+XC7iaKEIaf3s3yzqKxUEj+3X36OSCVuKHP8O1lyQmPcvbqgCRMF1
	 NIxVOpbwrPo3x38frJwrU2dMF9vnSwsZrYelSfpeUVTR+zY4zGQcGPwkXfTrK6+ivEdlO
	 yc7natQIv5/KMgZXjc3TcPOn2JbH8637BWpbRtF/9wQXZJfI1KyTMHK7BznAb/2Vpx987
	 hBBbqDH7MryKHKO+eHwIjliB2F8Ku5JE9S4zGPKBfA1a2VTMabW3uZ+URH7a9plQftDXk
	 pVdSVGLS9WxD3SwDxOw9RHhMCQIrhBtUWlYrhE/v6ssY28Z34xRjvP0CCBmTeNHObiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285253;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=UxWNGLEx+/y5+pkDhn0vOJ8y7NZhdTkUk3GIpLbhKiM=;
	b=E/byDXCGn3JFz0KLMx92o3pdDBUf3kCELLXtPXB+FjPPlVpDrROfQrrzQL2wEuxabpqc
	 S1kJiMDVjnNZZRWl/PWDRKjzbChTiA3u0FwGtgaUVaFuVg/4yDGDXeWsbaFB8dzB53zeP
	 036eNAktzPbZQhsdDdsxSfP0zHIjgOiRzbyoy4R669qcywWMl+8j2lqjRTM8q7MTsWJnY
	 ItGIPOM2BH1Zz53+hRdcsJGNTvUa7o/DBBUhxsZBpEymoQD9kqoVUFBluHQH5i5Zywh4Z
	 UBTg6rPWR4AtnvKJJoZZhRxYO8DTvB7+ph6iLCY51mTdWAjJRnQ75yTAtThvgsNGqPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0935606A335;
	Sat, 21 Nov 2026 18:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0935606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=UxWNGLEx+/
	y5+pkDhn0vOJ8y7NZhdTkUk3GIpLbhKiM=; b=wQTXMcWui6mvauhe73rNLE8o+V
	+UNmIFY50RzTpbzx8LOAyqelAYoUFtdzrJZPBN8y45uhk7NXPZS/CY+bCJ4X3kZQ
	nIUk4eoEOzk+aoa7BYsxtOr/jq8kMnymPW98ZmVcer7g9oOXMhL1DdVAsfUqgIf2
	svxThI7FTZUp4BBzE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCmxPr54AFrVWUGAg--.50854S2;
	Sun, 22 Nov 2026 02:20:42 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: dib7000p: fall back to 8 MHz for an invalid channel bandwidth
Date: Sun, 22 Nov 2026 02:20:40 +0800
Message-Id: <20261121182040.18514-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BrQMCkCmxPr54AFrVWUGAg--.50854S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5try3tryftFW7tr1DWrg_yoW5tr4Dpa
	93Wr9rKF95tw1xAFZrJw429F1rJw4FyFZ3G347W398ur15XrW3Cr95ta12gF1UJ34SyFyY
	va4UCFZF9rW2yw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUkuMNDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUED2sBtkkSPAAAs3

dib7000p_update_timf() derives the new TIMF value from the channel
bandwidth:

	state->timf = timf * 160 / (state->current_bandwidth / 50);

current_bandwidth is the bandwidth userspace asked for through
FE_SET_FRONTEND or DTV_BANDWIDTH_HZ, in kHz.  Zero is a value the
driver can be handed: dtv_property_cache_sync() maps the legacy
BANDWIDTH_AUTO to bandwidth_hz = 0, and its OFDM bandwidth switch has no
default branch, so an out-of-range bandwidth leaves the cached value
untouched, which is zero until a valid one is set.  Tuning then divides
by zero once the demodulator reports a lock:

	divide error: 0000 [#1] SMP KASAN
	RIP: dib7000p_update_timf+0x85/0x1e0
	...
	dib7000p_tune
	dib7000p_set_frontend
	dvb_frontend_swzigzag_autotune

dib7000p_spur_protect() divides by the bandwidth as well, after rounding
it down to 100 kHz units, for the devices that enable spur protection.

The demodulator is reset with an 8 MHz bandwidth and dib7000m falls back
to that value for a zero bandwidth, but dib7000p never got the same
handling when both drivers were converted to the DVBv5 parameters: the
old BANDWIDTH_TO_KHZ() mapped a bandwidth it did not know to 8000, the
new one divides by 1000 and returns 0, and only dib7000m was given the
fallback.  The same divide error has been reported on real hardware with
kernels 3.10 and 3.19 but was never fixed.

Use the 8 MHz default when the requested bandwidth is zero or below the
granularity used by those two divisions.

Reported-by: gary smith <kaisersose77x@gmail.com>
Closes: https://lore.kernel.org/r/CA%2BfUvsiNVBvo3%2BfjvDcQr0Rc%3DPp5pQA1qL_cYq46NCN5z5K%3D6g@mail.gmail.com
Reported-by: Adam Baker <linux@baker-net.org.uk>
Closes: https://lore.kernel.org/r/550B4F8D.7070905@baker-net.org.uk
Fixes: c1f814f49904a ("[media] dibx000: convert set_fontend to use DVBv5 parameters")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-frontends/dib7000p.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index 48d84a05ddfa..dd3181aed2e4 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -1515,6 +1515,20 @@ static int dib7000p_set_frontend(struct dvb_frontend *fe)
 	struct dib7000p_state *state = fe->demodulator_priv;
 	int time, ret;
 
+	/*
+	 * dib7000p_tune() scales its TIMF and spur protection settings
+	 * with the channel bandwidth and divides by it: by bandwidth / 50
+	 * in dib7000p_update_timf() and by bandwidth / 100 in
+	 * dib7000p_spur_protect().  A zero bandwidth, which is what the
+	 * legacy BANDWIDTH_AUTO and an out-of-range bandwidth from
+	 * dtv_property_cache_sync() leave in the cache, or one below that
+	 * resolution, divides by zero.  Fall back to the 8 MHz default
+	 * the demodulator is reset with, as dib7000m does for a zero
+	 * bandwidth.
+	 */
+	if (fep->bandwidth_hz < 100000)
+		fep->bandwidth_hz = 8000000;
+
 	if (state->version == SOC7090)
 		dib7090_set_diversity_in(fe, 0);
 	else
-- 
2.34.1


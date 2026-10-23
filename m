Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758939;
	b=lnFq+RCj6HBmHWevGhg8k3zCTKC2ehR39TaaF8a2jWaoaybpdO/Qg3l7DVr24TDjZ8iC
	 re8Z2XcsQ0d562VTee/Bk7+g8TZGgqkk/b0wPCGfPdau4DEW0EDq6fKkimpsPetYTRGyV
	 6gisMgw3maBIEqHH0qbyBCp30doKIqM2sfsJG5K0RGU8i80FjCf1qpsviQjhGPwjWjE+2
	 YGSon2NpluCZeYomBSsnVyOWwxuWB2oqBjTjg75fL7hiQxBXYpwtoQUL3BGcL6F48Moyu
	 Qtmj6vr8COLmhck+7uqj5I/gb2/sLTri/ZOZiU6jyCjgcTvg3PiDztMp9JGl4o3bIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758939;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=i7c5g4V4NRNrPs46Phu5SgSG/wjuIJtWQCmaQrZperc=;
	b=DgtCYPIgjZSm/SFgacHAMFv7n7OZtqTbSsquZwqShujKWa3LPWHYpZAIqlSud55C/eOr
	 X6/Lk5CE/aYYyjVzBZ+bPxDByRMNLqUcK0SrWpCTx+wpCABsNRcAeV/3UKdm4cyivNH0S
	 K3GdMO/NaR9INoDmx2c97wJZuVqSG2xuMfAfZIxY+doEkZ6kUfB0i+OSPntq7TlB89Rer
	 kFgW6BwAHLDFABf93JK7wqOnCHSFjWsnjRft8C5oqU0nm4fT0OGYjeviJP4zY0uVgkBwi
	 OAxMLIShq+olbzxvphYFqsvE8Z2+3WthBUKmM/KijxPq3pdSlW0V2IOvb6b5PxU9+xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="NhOfbM/L";
	arc=none smtp.remote-ip=43.163.128.44
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA4606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CFA4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=NhOfbM/L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792758930; bh=i7c5g4V4NRNrPs46Phu5SgSG/wjuIJtWQCmaQrZperc=;
	h=From:To:Cc:Subject:Date;
	b=NhOfbM/L0VqaoTy+cyqnlwWNFJud0IJZ3fv2IYIjEYzitm+JSVDJXPNkwfDP9/fRr
	 n6FNYyDMVKHpp8DcoLE7WEAFZ+gjIQsDJ7o2IQLDCAVG552QZW0trZrP4Rc2SaSm0X
	 g8NZnm+puy0ivnJRiUOUfHT2++GUHOT+d8k+gvcA=
Received: from kernel-lab.tail5e91bb.ts.net ([39.144.194.158])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 8DB1E2F2; Fri, 23 Oct 2026 20:35:27 +0800
X-QQ-mid: xmsmtpt1792758927ticp0kl9c
Message-ID: <tencent_FE2FC74E3EFEBB3E8582A6AC1C3CA788D809@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLiA9HHanLmRKwRYSMW2dTzqnFvBZ73lqtJXVTQslhdqO2Nl/Xxk
	 UaylcIrQ6ajJ7u8+t3zacvgwQfd1q5lhfFD8DeGmlvJ4Qx3XADnCwCq16kVTZ15xTRoECIMLJSPP
	 wl1feGtcx2LOIfZNzovfg/kqNum/KvP3Xfefhe1710FgqF1dWWPRH3w//83U3fcqPnjbtPyF9SZS
	 lu30ZWH6hQU5lmqsh515WKDmpXMZfharNGhRM6Izep6VE6c8WtFPkBtPyimBzk2rC1+E3T6j7DIW
	 l0O1PRX8r62ncqWGAevzbNh9U+VPXCWfY1qGQusy7zEla5v5YueXbyLWlX0lcgbgFP/C4hQk4Fbf
	 AELAbFBdDB0gEjcyU/avESo1PZ6hbuCG3ACpcaPG2Wp48kKrsdgQ+C1UkHopWdqodQtHfXEG+10O
	 FtonebI8gAP2g66zPMAqW40XX3+386lyEQ3db1ph7lBOljIQ9NL9zBkwpdpnePgPKk+06EQVyuSu
	 w0qeu4SKRQ+xghZ5cs5IkFjmQaS3Yxq/jbajqVtPTg8SZWGUz04PrYGic8l1Qu3fmrwV0JB/aO/0
	 SqMH/ylWaN1dDLZhOUmcsPdr1yxc0xnY4YXPutro1VtcaEjsoKs2eHB4a5zQncmWIdABVPB5bhvl
	 oLksB6p+6J+mO05uSETBJ0JPNHWz/82G6+VlFLU28sIc2CJEQn6uvlMMPCRkuZhn1P66GsDBOG2X
	 CeuBFGT79LIfFJ5vN3Rqjw/df1qVYKbSm8VuEWtS6ZpppXmUsCSZ62nkGQWhE2BApRNB71FKmAjl
	 xskaRt1hy4FKHveHNfww9175FCpf9GLYknZ8vJN4acTJtIq7NAWxQonLWfcFKRWBr76ggYyxruu1
	 mwq+92SNjuHuQtOntXB+TXaiJikSYXtzAFZyaiaKLSfskyJzdF+leJAXk9KHKdsVCvElyQHBYq8E
	 PoL0IcPehWrgJI3PNsYo8ZoBByIGUAOwcqMXb002Icj/6T4S91iwlzJJ1VpQGieh7oADHXOlNet4
	 TQOl+OT5Yt2OAA50yYxi0wHqUG9l25lYkaMW7JHW3Xh6qvbd0/rDtHjMs2els=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Yingjie Wang <1075151112@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	Simon Farnsworth <simon.farnsworth@onelan.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/dp: Validate the I2C-over-AUX speed parameter
Date: Fri, 23 Oct 2026 20:35:27 +0800
X-OQ-MSGID: <20261023123527.118840-1-1075151112@qq.com>
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

The dp_aux_i2c_speed_khz parameter is documented to accept values from
1 through 400, but its generic signed integer setter accepts any integer.

drm_dp_i2c_msg_duration() uses the parameter as a divisor when
estimating the I2C-over-AUX transfer duration. Setting the parameter to
zero can therefore trigger a division by zero when calculating the retry
count for an I2C-over-AUX transfer.

Use an unsigned min/max parameter setter to enforce the documented
range at load time and on runtime writes. Valid values retain their
existing behavior. Retain the parameter type in the module metadata.

A software DP AUX adapter reproduced the divide error without display
hardware. With this change on an x86_64 KASAN build, runtime writes of
-1, 0, and 401 are rejected. Values 1 and 400 are accepted and complete
an I2C-over-AUX transfer. A boot-time value of 0 is rejected and 400 is
accepted.

An automated audit of writable runtime parameters identified this
issue. Codex was used to analyze the bug, prepare the change, and draft
this changelog.

Fixes: f36203be608a ("drm/dp: Add dp_aux_i2c_speed_khz module param to set the assume i2c bus speed")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 488fd123a01ad..53fdaa7b59275 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1975,8 +1975,22 @@ static int drm_dp_i2c_retry_count(const struct drm_dp_aux_msg *msg,
  * FIXME currently assumes 10 kHz as some real world devices seem
  * to require it. We should query/set the speed via DPCD if supported.
  */
-static int dp_aux_i2c_speed_khz __read_mostly = 10;
-module_param_unsafe(dp_aux_i2c_speed_khz, int, 0644);
+static unsigned int dp_aux_i2c_speed_khz __read_mostly = 10;
+
+static int dp_aux_i2c_speed_khz_set(const char *val,
+				    const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 1, 400);
+}
+
+static const struct kernel_param_ops dp_aux_i2c_speed_khz_ops = {
+	.set = dp_aux_i2c_speed_khz_set,
+	.get = param_get_uint,
+};
+
+module_param_cb_unsafe(dp_aux_i2c_speed_khz, &dp_aux_i2c_speed_khz_ops,
+		       &dp_aux_i2c_speed_khz, 0644);
+__MODULE_PARM_TYPE(dp_aux_i2c_speed_khz, "uint");
 MODULE_PARM_DESC(dp_aux_i2c_speed_khz,
 		 "Assumed speed of the i2c bus in kHz, (1-400, default 10)");
 

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.43.0


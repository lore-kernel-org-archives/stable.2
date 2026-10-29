Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258790;
	b=p9cXEvrakWtUhiZ3KbYX7tQ4l45fgqiS+mMOkYD16LeT92WqLmQQcy1lmyciqW3zZLuv
	 6hhM6IH7nZX/TAqLNHRwmfre1hwkF15OaJZYIfagCzbgG0TsZLiRXBRTiEAdn4hFUlMAa
	 /8xaETQ2D/KIOODUasx4edCQ2s3eKBVwVQiE3+4eHkf5GMqRs7G/qFa4Kk0/BvydyV8jS
	 84824TpAwMaEAztj7Bt1H6p59kDNFfolanL3St9AIYllORIFfEBXfgOnwicV9D4y24mtt
	 KyAR3tjPSQic3hbPmjMnuxfJ0GI4oTu3HzOyTAn3O6vViioPzzYuEIji8MCoyCDnrig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258790;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xS03boMxCcllpwzg5bPDKCyxLreVZX2lgaA32onDXs8=;
	b=GcCXXhuYO1hit7PdPmPLtPHHpd6+TF75syd+uhb3L/1YZ/AfACfcMG5824GWVm/+Mbzk
	 YR9ZlhhLAT2MCZvB+tstR8eDmA2AD7etAunyaxB9anqT8fs+KrTWeoTbgH5WAQcj8Uo+j
	 IYJEZHhNhdvs18P8qWYhBTo+81lhXjtdivZ0fiKT/lmuEhUqFQTGSe9yEBLQ0UDC6aTeV
	 QNF9qOH/C2fkjSV0g9XynWPt2oOC/5yV2iHhwh8K5i11mb6AfVVgajNcYJeoOmcdYGW5a
	 bp1VneqV/qhgc7EnBiAnh9NlQ3RZEiaJ8AXZKpGBnDgoDgdMzl64lQSSOw6yFqeYJAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="IiHW/MJ5";
	arc=none smtp.remote-ip=115.124.28.124
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E60606A31A;
	Thu, 29 Oct 2026 07:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02E60606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IiHW/MJ5
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793258780; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xS03boMxCcllpwzg5bPDKCyxLreVZX2lgaA32onDXs8=;
	b=IiHW/MJ5bbZGdwPnArtWv+lBz617dqVw7CdpRiifqpe0fPBdlt+qtzxwUMweE2otfcZ9thRCz//E6uY9Lpmyv7UlQHvsKTwtZblGke9G+gguTzXZYyRBaDQSIPje/DkPbdo9wSgcRtsZt1sYdkVZW8KEP87sdhshI+iLCyBeG5g=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09175418|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00504625-0.00099433-0.993959;FP=14400804172128161412|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065030;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jsBbwDV_1793258779;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jsBbwDV_1793258779 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 15:26:20 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Umang Jain <uajain@igalia.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: imx283: reject unsupported mbus codes in set_fmt/set_ctrl
Date: Thu, 29 Oct 2026 15:26:19 +0800
Message-ID: <20261029072619.4136911-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

imx283_set_ctrl() and imx283_set_pad_format() call get_mode_table()
with an mbus code that userspace controls.  For codes outside the
supported 12-bit/10-bit list get_mode_table() leaves mode_list NULL
and num_modes 0, and v4l2_find_nearest_size() returns NULL for an
empty list, so the immediate dereference of mode->width oopses:

        get_mode_table(fmt->format.code, &mode_list, &num_modes);
        mode = v4l2_find_nearest_size(mode_list, num_modes, ...);
        fmt->format.width = mode->width;      /* NULL deref */

imx283_set_pad_format() is reachable with an arbitrary code through
VIDIOC_SUBDEV_S_FMT on /dev/v4l-subdevX, making the crash triggerable
by any local user with access to the media device node.  The same
pattern exists in imx283_set_ctrl() via the format stored in the
subdev state.

Bail out with -EINVAL when get_mode_table() yields no modes, matching
the upfront code validation other imx drivers perform.

Fixes: ccb4eb4496fa ("media: i2c: Add imx283 camera sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/media/i2c/imx283.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
index 38ea1902f..2c9af6e13 100644
--- a/drivers/media/i2c/imx283.c
+++ b/drivers/media/i2c/imx283.c
@@ -767,6 +767,9 @@ static int imx283_set_ctrl(struct v4l2_ctrl *ctrl)
 	fmt = v4l2_subdev_state_get_format(state, 0);
 
 	get_mode_table(fmt->code, &mode_list, &num_modes);
+	if (!num_modes || !mode_list)
+		return -EINVAL;
+
 	mode = v4l2_find_nearest_size(mode_list, num_modes, width, height,
 				      fmt->width, fmt->height);
 
@@ -968,6 +971,8 @@ static int imx283_set_pad_format(struct v4l2_subdev *sd,
 	unsigned int num_modes;
 
 	get_mode_table(fmt->format.code, &mode_list, &num_modes);
+	if (!num_modes || !mode_list)
+		return -EINVAL;
 
 	mode = v4l2_find_nearest_size(mode_list, num_modes, width, height,
 				      fmt->format.width, fmt->format.height);
-- 
2.50.1


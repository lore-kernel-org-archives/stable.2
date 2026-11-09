Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216818;
	b=iOs/z2DGEsdtDxaRyMrGTW2j0VWeOK92gCMDRyh/r85R4xIrGa6lx7C4kwCa4cO8NUvP
	 dtGaVpfY5SdUnL7g6R91vfnJIPaeY/PnLQKvCBkvtX18yUCAFUXS/munZyK4yU42kMKV6
	 DyyLCx9cTJ7ecpUaS/hv1LcYQHHgZKsXMzeRMg+kVy3dEya4H9Cbfu1V9VxUIxOQe0Lua
	 9fWpOyy6ieGDaGM19DEY8mv1eh3kfaCU9GFBQs2ksb/9+yJTsTHKfT3ey5bBbHpY1uYUv
	 0Lhqa9gIAxqChFyow4vXvrVqIDS2RB8w4vera61BrgdHg6lbe5MUE5R4/oIgJ6pKJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216818;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=tdrqNXvbOJfnmlPst0iypdpdKmNbCcqOM+pkeWm09qc=;
	b=mnLpGzEdVEg0aBSo6ggIQvi7vl3gRlnQsa0FOR6SwaHp3lzjYFdUHCAMydn22qot9Shx
	 7JNScjykwM2uOZA/VeJM3ecESpohKfwD3UyrjnU//g8d4v67XsUDeRw8YsznB9OxraSgf
	 k83sNuqwYEvmO8D0hEuQGaCwHbNYIhZoylemxwhk3um869MA3nPqnl9mf8sIq1HV77qcK
	 pUo7hCqBTRHYAb4a9qnrQnSy4tLNWdHqPcE9jUWJHZWRaaDKHeNk3PWayhUBGqrJhGWlQ
	 3eMRx3i9MY2jIBMtQTDtNbwNj3tCjgUh6aMRvkrEtaY+SCBFSyTpUQnaF26EKhMLYeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=XFhDgguA;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91308606A321;
	Mon,  9 Nov 2026 09:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91308606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=XFhDgguA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794216784;
	bh=tdrqNXvbOJfnmlPst0iypdpdKmNbCcqOM+pkeWm09qc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XFhDgguAQjvgw9TZqisvDJsFQxJ12Vo+EtmHyNwd/1jkzbMQ1ASLm96lYiq03V9Vm
	 /YNRzyLOSEGgQo8vTULvk5KrNnMAobqDKIP8Xo98wREsDQxfKDQpWfmBCqbBO/iBRl
	 pkzbTmcTsfNgo0H/qP6LSrZfUWgk90zKosWNUmPQ=
X-QQ-mid: zesmtpgz7t1794216768t23ed94af
X-QQ-Originating-IP: QejUh9wpFsrmFWP65cpzSdFpRsHVcwdB0Drmsw1YPsU=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 17:32:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1809446386184203717
EX-QQ-RecipientCnt: 9
From: raoxu <raoxu@uniontech.com>
To: sakari.ailus@linux.intel.com
Cc: mchehab@kernel.org,
	hverkuil@kernel.org,
	laurent.pinchart+renesas@ideasonboard.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: ov5645: Initialize the default mode
Date: Mon,  9 Nov 2026 17:32:45 +0800
Message-ID: <2870CBB9F723E453+20261109093245.3777610-1-raoxu@uniontech.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M5AoSkhGr8pkVSUAhN/flHLD3yDWrYYyCw4RC58g1HIH0DJUa50p6TwE
	DnNDPju5fCtm0bek4s4XvXAGPKrdM1dvbFqseimZZ4K49hfZy0B7eZlEPjEItQOi6AAtaxF
	w1WrtN224pqhp8ztbQI1dYVPHJX7QQky7w0inRIll1VY05s/3/2dbl3Qz9S7YdMDoQKsK93
	iclZdjMfJQba6Atbc0tW8hAA/k6mVKJq01oQBdtycKgFplVQwS/Qt9QEYvptNrDE5xkmDFK
	diSOsaPM1+V1+zJP1K/efTao0qGoBGoS2PF9BUYlHx4zKK3PH+5GcIuInmO4+D+aIoR4vkX
	zsIj5ZfUiMRY7Qu/a3C7axVUBzx3PNLp8hWWVjbyIv/UdkbAJ5RTFLJtAvPxUfSA46RaUwA
	MKca76rX46dSV/j/kwYCIUj8a1KswcNFHDwFiWFTh3iL6y7ltDv9qjOsID+txSeE2Z3cd0u
	tx67JVV5qiuZZ3hX9oKs8mdtnfBbv0O58Po4ts6eVbKlKNEyAGfZi38D4rp6wu0tc0R5aVS
	yB3jJ+yBXRYjGmKiQQ3Ps1UdVffeplfQVmNMFiP1MPS9kxGZIngN0gJPs+YIBx6lRZNTBzd
	Ykr+lnpoJ3aY41QO66gHC9q61AVUOXeFsrPrO5cWsGVlRF0xcL2is1cML4xZ5hvWFpRw8V0
	axwv0slFQHuLjTOWA/KZ/ARDR83jCDaJ44jSNVo4smrrC8Ul2vDwk34ZlpMZxgEzfyrelmK
	A16AuN5eB2H50RerllXKf83/GJSVMCU5Gh8tPuaRJ1ClPrOEm5WUNMAmMyBadY+LJ1UV2yL
	Jn0AlAKnUUloODDBiu/Azja55jzMtCw8FrLHqZnLWD/CJgwYdilDlENBsrncsihoc49tHu2
	Xax/tz6NcbdIqfvYHbSeGiJK4TAqCnrY+iQsZGort6e2LKC8MVKep3FoMzyUxuHzCE2i+Lv
	urxq5JJ2Ph3YGI7sDdc1e7q96Y3Q9q2DaN6k3HEbHam2mD48E98pNLi1TXIoddhv1TJ85QP
	s+yqi2kP4WvewOInUJKCcfYO7rBXY7RlSTndKIZ04ss2XFq9IJ
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

ov5645_init_state() initializes the default 1920x1080 format through a
TRY-format operation. As a result, ov5645_set_format() does not update
the driver private current_mode, which is only changed for ACTIVE
formats.

Starting streaming without an explicit ACTIVE format then dereferences
a NULL current_mode in ov5645_enable_streams(). The pixel rate and link
frequency controls also use values unrelated to the default 1080p mode.

Initialize current_mode to the same 1920x1080 mode used by init_state(),
and use that mode to initialize the pixel rate and link frequency
controls. ACTIVE format changes continue to update the mode and controls
through the existing path.

The supplied fix was reviewed and this commit message prepared with
OpenCode AI assistance.

Fixes: f92711869c53 ("media: i2c: ov5645: Use subdev active state")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov5645.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index a8d740ed4dc9..e77d70078097 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1024,6 +1024,7 @@ static int ov5645_probe(struct i2c_client *client)

 	ov5645->i2c_client = client;
 	ov5645->dev = dev;
+	ov5645->current_mode = &ov5645_mode_info_data[1];

 	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
 	if (!endpoint)
@@ -1095,12 +1096,14 @@ static int ov5645_probe(struct i2c_client *client)
 	ov5645->pixel_clock = v4l2_ctrl_new_std(&ov5645->ctrls,
 						&ov5645_ctrl_ops,
 						V4L2_CID_PIXEL_RATE,
-						1, INT_MAX, 1, 1);
+						1, INT_MAX, 1,
+						ov5645->current_mode->pixel_clock);
 	ov5645->link_freq = v4l2_ctrl_new_int_menu(&ov5645->ctrls,
 						   &ov5645_ctrl_ops,
 						   V4L2_CID_LINK_FREQ,
 						   ARRAY_SIZE(link_freq) - 1,
-						   0, link_freq);
+						   ov5645->current_mode->link_freq,
+						   link_freq);
 	if (ov5645->link_freq)
 		ov5645->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;

--
2.50.1


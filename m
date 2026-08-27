Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CE4432FD
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842772; cv=none; b=AJXDa6rH6t38GcrAt1pvpMiGspjT+paHxecv7rDIH3qrZKeHvpmt1SwJHuX1PirIzh9lSt5qn1rsFUwxID8PFeb4jO/l1HggBWix0rD/CXYQaZEoVtEBSLwT2CT7JxiET9xddIuF5iEZDgIi5cu1DnN7mZ62zZsoQewDccwC4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842772; c=relaxed/simple;
	bh=uJqwj486hWxLAALuJR7oWC34BqTBbz7uaJxgRsqpTIY=;
	h=From:Message-Id:Subject:Date:Content-Type:To:Cc:Mime-Version; b=Q+GrrQX7l7HKemCE9lfKk23U8CktJtc6uDcf2LGT08Uiw9vwWwL1i2QobGFHxjdhC5S9HS3A0ihBVIcZ0ARRj6GIzL/TtqgvmMmejASrjMwJOOoYq+pBRYfxx8yYf3l1yVgH3u5wE8kxwRmZ+i0strxIPkLXTZGQOZk8tifMrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=jb6S7Wkf; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="jb6S7Wkf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787842756; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=jvHVGXLRnB/myR7QpYOFvo9mljYI+Hq1VtE6Y8mURT8=;
 b=jb6S7WkfQpSCK9yBnW3/+Em4FtbZmkwoZs7ODGIRwldP2sGfN5l5hMc6q0l1TLfWFdJoMo
 VA0ggLye3QfPAdR0EIsKK77aONYXHehIkVBeawNxS+aXtlqGOcnEX5Jq1CmBUQv6nsYVtv
 q7hD17nwqQ++jHSU6XG45MTZT5eGqs0AIrliEIidoWiTQ2H6zzvdTvonVkK4FoHsyDSVhb
 P+Ditwn80FpT9rNRxMf9cK+cqspMgpzn1RN6oF/ZDyVxk+Ab6CADAUphnPZN+KUQcSi7vz
 UOtqOpKGlHfSZzJjUbeYZu0eE45u8zZLcWW3BNO2zuVOzo0mPr9vdh3UG279Vg==
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260827-go7007-i2c-buf-bound-v2-1-82b185f9cb82@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.163]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 22:59:14 +0800
X-Lms-Return-Path: <lba+26a9050c2+fa4d82+vger.kernel.org+me@cherr.cc>
Content-Transfer-Encoding: 7bit
X-Change-Id: 20260827-go7007-i2c-buf-bound-d4fbe42a4a79
Subject: [PATCH v2] media: go7007: bound EZ-USB I2C transfers to the usb_buf size
Date: Thu, 27 Aug 2026 22:59:10 +0800
X-Mailer: b4 0.16.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
To: "Hans Verkuil" <hverkuil@kernel.org>, 
	"Mauro Carvalho Chehab" <mchehab@kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@suse.de>
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL1QkGoC/4WNQQ6CMBBFr0Jm7ZhSC1VX3sOwoNMBxgUlLRAN4 e4CHsDlS95/f4HEUTjBPVsg8ixJQr+BPmVAXd23jOI3Bq10qa7aYhusUhZFE7qpQRem3qM3jWO ja1PbG2zTIXIj7yP7rH6cJvdiGvfWbnSSxhA/x++c796fiznHHE1RFEQXr0xpHtRxjGciqNZ1/ QJ5d9kqyQAAAA==

go7007_usb_i2c_master_xfer() copies msgs[i].len bytes into go->usb_buf,
a 16-byte buffer embedded in struct go7007, without any length check.
The adapter declares no transfer limits, so an SMBus block transfer
issued through /dev/i2c-N can write up to 34 bytes into it and corrupt
the struct fields that follow the buffer.

Bound the transfer size with i2c_adapter_quirks so the I2C core
rejects oversized messages before they reach the driver.

Fixes: 7955f03d18d1 ("[media] go7007: move out of staging into drivers/media/usb.")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
Assisted-by: GLM:5.3
---
The EZ-USB I2C adapter in the go7007 driver copies message payloads
into the 16-byte usb_buf embedded in the go7007 device struct without
any length limit, so an SMBus block transfer through /dev/i2c-N can
write past the buffer and corrupt the struct fields that follow it.
Bound the transfer size through i2c_adapter_quirks.
---
Changes in v2:
- Drop the Cc: tag for the maintainer from the commit message; the
  recipient is already covered by the Cc email header.
- Link to v1: https://patch.msgid.link/20260827-go7007-i2c-buf-bound-v1-1-4555cc3d0464@cherr.cc
---
 drivers/media/usb/go7007/go7007-usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/go7007/go7007-usb.c b/drivers/media/usb/go7007/go7007-usb.c
index c0cb92fa6ab9..867548d655b3 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -1029,10 +1029,16 @@ static const struct i2c_algorithm go7007_usb_algo = {
 	.functionality	= go7007_usb_functionality,
 };
 
+static const struct i2c_adapter_quirks go7007_usb_quirks = {
+	.max_write_len	= 12,
+	.max_read_len	= 15,
+};
+
 static struct i2c_adapter go7007_usb_adap_templ = {
 	.owner			= THIS_MODULE,
 	.name			= "WIS GO7007SB EZ-USB",
 	.algo			= &go7007_usb_algo,
+	.quirks			= &go7007_usb_quirks,
 };
 
 /********************* USB add/remove functions *********************/

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260827-go7007-i2c-buf-bound-d4fbe42a4a79

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>

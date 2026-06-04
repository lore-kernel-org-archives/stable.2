Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3892F8EB0
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574897; cv=none; b=FzzWp9k73kK41mRCj03E2RdW5gN8cmcaJzMfMRV1ai4YH6GPSdEFdZxCuBO3OtfWn9N6d37UMoc8Hog0hJ0F4iXTZ9oD8Z4X2pmCn8WT0PlcUqekBGNlb98dbwsGiLj6vKB5VbfWSDPCocG4hpRgF2wtBjplIoiEQ787j+/4knY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574897; c=relaxed/simple;
	bh=pDej9qiEtSkG5xwS6uiPaMxwYSALQKyH9//LqwM3QB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5gdYob7ThKazYGwdwqZQQYi2rnUJ+oyVjfryMprLARY4LCHGCh9VdzJe/IPMNBihdcEpwYtutn8L17pq1Z1PAgpZ3An7SP3bKOWeKlEfrpXfbpH6D0xoaFk8BcDPEyp32TyCKdV7a5KoOpL3UjUJYg16/sn8WndNf2ri3A2RxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4t8zSZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4t8zSZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73231F00893;
	Thu,  4 Jun 2026 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780574894;
	bh=bttJQ/T7q6CE6YSIUvI5QDYmuQ1kkigPxkyJGMeflHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4t8zSZCCDHySIHsPFAfMBjpqeA0Riz3Cy0xX4bZ6I+9Pd4cVjiuoNe6biGxknlgs
	 D/Aa/YkibrAaISHdD0MDqsX+FT9PsjZPe7JY+54dsIyamR4JYDG5nuGBflslDwpfgA
	 7Qttnj60T5Ce/PyPBS1MrhxNezxDbEe8YsUyaRtZYHtcH66MhIUch8viAPS8SqRyeW
	 DxyUqY2f6w93J/Xr1KHCqnk0Xcnq/hf5hkeYgrSZYYASfQJ9waRC0Zl4I3/q6xEqvM
	 Z4V7uVyoXml/NQSgJKqI6fQ1DTq5Q4Oz3Ux9l1cV4urYPYyOW8gCN7623YjHp7l3AL
	 w/U/qFsyeAZbg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV6rs-0000000BcMy-3Crg;
	Thu, 04 Jun 2026 14:08:12 +0200
From: Johan Hovold <johan@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y] USB: serial: digi_acceleport: fix memory corruption with small endpoints
Date: Thu,  4 Jun 2026 14:07:58 +0200
Message-ID: <20260604120758.2769085-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060427-gossip-stony-dea7@gregkh>
References: <2026060427-gossip-stony-dea7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit cb3560e8eab1dfa1cac1ed52631adf8ec6ff2cd5 upstream.

Add the missing bulk-out buffer size sanity checks to avoid
out-of-bounds memory accesses or slab corruption should a malicious
device report smaller buffers than expected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Should apply also to older trees without kzalloc_obj().

Johan


 drivers/usb/serial/digi_acceleport.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index a06485965412..a876d6629b65 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1229,15 +1229,34 @@ static int digi_port_init(struct usb_serial_port *port, unsigned port_num)
 static int digi_startup(struct usb_serial *serial)
 {
 	struct digi_serial *serial_priv;
+	int oob_port_num;
 	int ret;
+	int i;
+
+	/*
+	 * The port bulk-out buffers must be large enough for header and
+	 * buffered data.
+	 */
+	for (i = 0; i < serial->type->num_ports; i++) {
+		if (serial->port[i]->bulk_out_size < DIGI_OUT_BUF_SIZE + 2)
+			return -EINVAL;
+	}
+
+	/*
+	 * The OOB port bulk-out buffer must be large enough for the two
+	 * commands in digi_set_modem_signals().
+	 */
+	oob_port_num = serial->type->num_ports;
+	if (serial->port[oob_port_num]->bulk_out_size < 8)
+		return -EINVAL;
 
 	serial_priv = kzalloc(sizeof(*serial_priv), GFP_KERNEL);
 	if (!serial_priv)
 		return -ENOMEM;
 
 	spin_lock_init(&serial_priv->ds_serial_lock);
-	serial_priv->ds_oob_port_num = serial->type->num_ports;
-	serial_priv->ds_oob_port = serial->port[serial_priv->ds_oob_port_num];
+	serial_priv->ds_oob_port_num = oob_port_num;
+	serial_priv->ds_oob_port = serial->port[oob_port_num];
 
 	ret = digi_port_init(serial_priv->ds_oob_port,
 						serial_priv->ds_oob_port_num);
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679465;
	b=zKWaRCWP8dbcOKE/7B+FCMhIn82XsvZ8O4QKizXda7L17rLvTshqG0pnfg3N9o5tRJ2r
	 RVVhpfyLAp/SyMlwcrE5u+aLSDKBBTSJ1Uom+25knrqf7S+PR0OOPo2a5Jz7a6uiWPE1n
	 66BFgZhtYU5J7s+YHl4kq59kIat/3DnbApQtORK1ezLW2ryuxysurDv+nZVF2e3iJu/y4
	 WNglJzK2sTmxyz8xsKM5U9TdR52fxAXfPV5GE9eVjXvaIuY7sIoBa6k2ftTnjC4SYYaPf
	 hLlhg/TfH8g4ban84JRc64V5fVdteDyttYwXxXRrljRsfNP7AS2ZMdli/sUxsdxS8Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679465;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=RDJNlND8Zcv+HDCZboZyrXYOvWnLdQmbBes09PYx/G0=;
	b=b5xVylQeDPKAwT2ic1quYnliSbuMh8UkRSkdwEY9CV0DLsuFXSvGlRzUIVRyAxanuzjk
	 t5EFKqjX3pJzeaPFxStT6cZxb7E2gqMgie09T8plfP5p0i97OTd2UlQ8ati9xhLOHfGb5
	 JsaiZMhRyDqcFbZuiQ3vOwlB0wFgOOeIzKMaH7v34KyXXC0bgdj/UMYpp4fExCkS9W00c
	 XSKnuDJfdutFzv+Hy3QoEycnUIJQDN8onSHKh4PQQ292z1MwrM1Max/bzQxVpdCAOM9QH
	 ie1Oz1xN6dOvQNMFAUYKS0lkrg5B1h5CSZ9D6L5Vqe3h8Wx6mVo/xQivuh8Uu+tPPEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pMEc2GoT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E999606A323;
	Sat, 14 Nov 2026 18:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E999606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pMEc2GoT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679458;
	bh=TxqmposBOHXdDsrH5e74JfVT2uddDv95gdLnKGzzKc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pMEc2GoTmGBOglomGtdfytnpNJTkCk4lOsXjoqMlh0Xp+qJwK8gwEQ6egtuqVAY1N
	 lX2qK+lCZvoqSc4MJVsc5h7EAP1zkDnroorLGXK6Qpn1dWmXWf6CuOUc3DFSzH8t+N
	 N5RdSzNaM0+VSQT4wWhdD42QeIgU8OXLENaKnBuO8nj5wGgu+NnGL01W/PktKwmEiu
	 tKgHfWOEnuFmNdDMofAr97wd93mZW4ScHsx3hTat1Ti/EGwaidTk84nPD8n8f72fLa
	 XC9cFn7ZnWZ/XLkYPpzRHc7VagGJCffi39KQ/7IDegAT0XlNIgtGKOVXNc816aT5v9
	 kGt34JSdeveKg==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD9D317E0B1E;
	Sat, 14 Nov 2026 19:04:17 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:25 +0200
Subject: [PATCH 01/25] video/hdmi: Copy SPD vendor/product with
 strtomem_pad()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-1-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

The HDMI specification defines the SPD InfoFrame Vendor Name and Product
Description as fixed-size fields, padded with zeros and left without any
trailing NUL when a name spans the whole field.

Mark the fields as non-strings, so that the copies can be handed over to
strtomem_pad(), which implements precisely the required semantics.  This
also bounds the reads from the source strings, whereas the open-coded
strlen() could run past the end of the buffer in the
hdmi_spd_infoframe_unpack() path, where the names come straight from the
wire and are not NUL-terminated.

Fixes: 2c676f378edb ("[media] hdmi: added unpack and logging functions for InfoFrames")
Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/video/hdmi.c | 11 +++++------
 include/linux/hdmi.h |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 45b42f14a750..cd18121afa20 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -217,23 +217,22 @@ EXPORT_SYMBOL(hdmi_avi_infoframe_pack);
  * @vendor: vendor string
  * @product: product string
  *
+ * Both strings are copied into the fixed-size infoframe fields,
+ * truncated if too long and padded with zeros otherwise.
+ *
  * Returns 0 on success or a negative error code on failure.
  */
 int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
 			    const char *vendor, const char *product)
 {
-	size_t len;
-
 	memset(frame, 0, sizeof(*frame));
 
 	frame->type = HDMI_INFOFRAME_TYPE_SPD;
 	frame->version = 1;
 	frame->length = HDMI_SPD_INFOFRAME_SIZE;
 
-	len = strlen(vendor);
-	memcpy(frame->vendor, vendor, min(len, sizeof(frame->vendor)));
-	len = strlen(product);
-	memcpy(frame->product, product, min(len, sizeof(frame->product)));
+	strtomem_pad(frame->vendor, vendor, 0);
+	strtomem_pad(frame->product, product, 0);
 
 	return 0;
 }
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index b80a5ee63bb2..08922d5330d6 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -271,8 +271,8 @@ struct hdmi_spd_infoframe {
 	enum hdmi_infoframe_type type;
 	unsigned char version;
 	unsigned char length;
-	char vendor[8];
-	char product[16];
+	char vendor[8] __nonstring;
+	char product[16] __nonstring;
 	enum hdmi_spd_sdi sdi;
 };
 

-- 
2.56.0


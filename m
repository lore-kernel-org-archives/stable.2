Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701738;
	b=CMl2o2WvnsHE/Ic1hfhUCi9jRi4LZIW2IEVvP1GYM5SfhFzuWknQ77eozF5IprAiEw1o
	 5B+NmQ4x2m5W8VoijAMi/J74mv1lWALXMfvar5Z4lvIFcdAOQkn+JYitcvHMDIfa3TEyF
	 TGY+EdoanP3/F9R5t6evfrIxy8E0RcsM0BrcvooJgx/ga+1OjVbYWxfw2Q5RypMWeoJex
	 z6DTRg0PoxsR2Ot3w1rHT0cUAnNep8yrRCPTC5kEYXIr/aWWl4BbrSc2EaadhYexC+vNO
	 YPc+o5yFuztCABLbO3iKRu+AtFHod3EpavVZUnaCtKI2k8PiIen+OuHXPIKzUMh29hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701738;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=atR9w/LIKXlCxoZMtunWQfcgxsIkELEPvu7ajRcHDaM=;
	b=rPiXixtM73A0bAj2F4JIDgZrAb6c+0yBFvqpPuSH6SGqPdCam9nJD7MkL3sclrF4EPvK
	 mHiwi+14zpSH4yoxNQ6ZGR1sAAusbScIbtzMeeRCH4LaVV1QvkthFMZGL25739laCNRXY
	 SXKR/cZ4XJHPcWwSvZ0LO2tox8T3VCAy5sdPABA08UCH+ANsR6sWmVBZf9SW/eIvvhTmz
	 lbzhMOW1JZfa2ZOa6bxa5dyGiPyVvgYsEQzH/sBMSjJdF0JErC+khxjGPLo9o3AR4Xr8E
	 YggU15KKU627SuKSCwQ0Y2zLvN0PXNnE1NxABdrlEOLCmXlX6MIdRp29zk0bcSUDLNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CA60752F0;
	Tue,  3 Nov 2026 10:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 243CA60752F0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnN5hjt+lq0qk7AA--.49100S2;
	Tue, 03 Nov 2026 18:28:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: hso: free an unused shared interrupt state on probe failure
Date: Tue,  3 Nov 2026 10:29:00 +0000
Message-Id: <20261103102900.1340894-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnN5hjt+lq0qk7AA--.49100S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1xury5XFWftw1UJFW8Zwb_yoW5Aw43pF
	4vgFW5JrWDJrs8J3y3Xr4rGFWF9r4kGa4UCF9xK393G3sxtrySv34UKFy5tF45CrykJFWr
	tF9ruFyq9ay29rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
	yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggAA2rpnIR0AwAAsh

hso_probe() allocates the shared interrupt state with
hso_create_shared_int() for a multiplexed interface and then creates one
muxed serial device per port advertised by the device. A muxed serial
device takes ownership of the shared interrupt state by incrementing its
ref_count, and hso_free_serial_device() releases the state together with
the last reference.

There are two paths where the state is allocated but no serial device
ever takes a reference to it: the port mask read from the device contains
no port that can be muxed (including a port mask of zero), and the
creation of the first muxed serial device fails. In both cases
hso_probe() leaves through a path that only frees the registered serial
and network devices, so the URB, the buffer, the mutex and the state
itself are leaked.

Release the state in both places when no serial device took it over.
hso_free_shared_int() still has to be called with the state's mutex held,
so add a small helper which takes the lock first.

Fixes: 72dc1c096c70 ("HSO: add option hso driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/usb/hso.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 71caa3764b23..818444830072 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2736,6 +2736,13 @@ static void hso_free_shared_int(struct hso_shared_int *mux)
 	kfree(mux);
 }
 
+/* Release a shared interrupt state which no muxed serial device took over */
+static void hso_free_unused_shared_int(struct hso_shared_int *shared_int)
+{
+	mutex_lock(&shared_int->shared_int_lock);
+	hso_free_shared_int(shared_int);
+}
+
 static
 struct hso_shared_int *hso_create_shared_int(struct usb_interface *interface)
 {
@@ -2853,8 +2860,9 @@ static int hso_probe(struct usb_interface *interface,
 	int mux, i, if_num, port_spec;
 	unsigned char port_mask;
 	struct hso_device *hso_dev = NULL;
-	struct hso_shared_int *shared_int;
+	struct hso_shared_int *shared_int = NULL;
 	struct hso_device *tmp_dev = NULL;
+	int mux_count = 0;
 
 	if (interface->cur_altsetting->desc.bInterfaceClass != 0xFF) {
 		dev_err(&interface->dev, "Not our interface\n");
@@ -2912,11 +2920,16 @@ static int hso_probe(struct usb_interface *interface,
 						interface, i, shared_int);
 				if (!hso_dev)
 					goto exit;
+				mux_count++;
 			}
 		}
 
 		if (tmp_dev)
 			hso_dev = tmp_dev;
+
+		/* No muxed port took over the shared interrupt state */
+		if (!mux_count)
+			hso_free_unused_shared_int(shared_int);
 		break;
 
 	case HSO_INTF_BULK:
@@ -2943,6 +2956,11 @@ static int hso_probe(struct usb_interface *interface,
 	return 0;
 exit:
 	hso_free_interface(interface);
+
+	/* No muxed port took over the shared interrupt state */
+	if (shared_int && !mux_count)
+		hso_free_unused_shared_int(shared_int);
+
 	return -ENODEV;
 }
 
-- 
2.34.1


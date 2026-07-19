Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692E24DFF9;
	Sun, 19 Jul 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784425407; cv=none; b=GmPXGNExQtt0iuaLHbntpi3J3Cq8Q8Jg8mUYvf+6XTZ9RH08aVAIk8TZz//FTazmu37aNpNDVu3/0esTwC8ZMLxJpQxN+TbsJ0/U6ho7Kb7Rp80eFBd5NcjyYbWpxCWK9Wfh0inNDCgKx2sP1v/nQFtJtvfHHddv6RSaLKjJ4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784425407; c=relaxed/simple;
	bh=O89bbFA20RmpyqSYgYVWt2OM+tCkz0iWGLthW3OtOzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJ0UGEmLhx6fqk4pRsiSWOTKNNt65mqS8kQgCLMZiv9tMh14ilbQWku+HywV3Rl8e8R1DBhHISWLZGTUpRQYzJhF37glUEnC947r+62JrW3QGG0pS66JBCLppf4FI+R1RmROybmcDvSbEYvcu8MnBmJDuE6x1m9ODWAv+3hBhB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAnEfe0K1xqZeIQAA--.29823S3;
	Sun, 19 Jul 2026 09:43:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgCn2TCzK1xq2YZnAg--.18290S2;
	Sun, 19 Jul 2026 09:43:15 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] media: dvb-usb-v2: fix double-free on URB allocation failure
Date: Sun, 19 Jul 2026 01:42:20 +0000
Message-Id: <20260719014220.3164004-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCn2TCzK1xq2YZnAg--.18290S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?2HJs3gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZzZ6AS7DkpwtAM66MLhS4sr7iQKTvl37/i7z3mVDKI+te9n
	Wf1JGG2Oxkpgz+tpcN6p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxCF17AF1UZryfXFy7uF1rAFc_yoW5Zr45pw
	s3Gw45tFyDJF1xJw1Ut3ZxKr4rGa1xZ34fKrW3Wwn8ZF4rGw1fta4xKr4rKrn2kr4vva4x
	tr90v3y8Ar4DW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57
	IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE
	14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
	6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jnKsUUUUUU=

usb_urb_alloc_bulk_urbs() and usb_urb_alloc_isoc_urbs() allocate URBs in
a loop. When usb_alloc_urb() fails at index i, the error path frees the
already-allocated URBs:

    for (j = 0; j < i; j++)
        usb_free_urb(stream->urb_list[j]);
    return -ENOMEM;

but it leaves stream->urb_list[j] pointing at the freed URBs. At that
point stream->urbs_initialized equals i, since it is incremented once
per successful usb_alloc_urb() before the fill/setup of the next URB.

The -ENOMEM propagates up through usb_urb_initv2() and
dvb_usbv2_adapter_stream_init(). dvb_usbv2_adapter_init() returns the
error, dvb_usbv2_init() returns it, and dvb_usbv2_probe() then takes its
err_free_all path, which calls dvb_usbv2_exit() ->
dvb_usbv2_adapter_exit() -> dvb_usbv2_adapter_stream_exit() ->
usb_urb_exitv2() -> usb_urb_free_urbs().

usb_urb_free_urbs() walks urb_list[urbs_initialized-1 .. 0] and, for
each non-NULL slot, calls usb_free_urb(). urb_list[0..i-1] are still the
non-NULL dangling pointers from the alloc error path, so they are freed a
second time. URBs allocated here start with a refcount of one (usb_get_urb
is never taken in this path), so the first free releases the memory and
the second is a use-after-free / double-free.

struct usb_data_stream is embedded in the kzalloc'd dvb_usb_device, so
urb_list[] starts zeroed; the double-free requires at least one prior
usb_alloc_urb() to succeed before the failing one. That is the normal
multi-URB streaming configuration (e.g. ce6230 .count = 6).

Null each slot immediately after freeing it, so usb_urb_free_urbs() skips
the already-freed entries via its existing non-NULL check.

This issue was found by an in-house static analysis tool.

Fixes: eb28dc39d3e8 ("[media] drivers/media/dvb/dvb-usb/usb-urb.c: adjust array index")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/media/usb/dvb-usb-v2/usb_urb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/usb_urb.c b/drivers/media/usb/dvb-usb-v2/usb_urb.c
index 2ad2ddeaff51..a6edec097fb3 100644
--- a/drivers/media/usb/dvb-usb-v2/usb_urb.c
+++ b/drivers/media/usb/dvb-usb-v2/usb_urb.c
@@ -143,8 +143,10 @@ static int usb_urb_alloc_bulk_urbs(struct usb_data_stream *stream)
 		stream->urb_list[i] = usb_alloc_urb(0, GFP_ATOMIC);
 		if (!stream->urb_list[i]) {
 			dev_dbg(&stream->udev->dev, "%s: failed\n", __func__);
-			for (j = 0; j < i; j++)
+			for (j = 0; j < i; j++) {
 				usb_free_urb(stream->urb_list[j]);
+				stream->urb_list[j] = NULL;
+			}
 			return -ENOMEM;
 		}
 		usb_fill_bulk_urb(stream->urb_list[i],
@@ -173,8 +175,10 @@ static int usb_urb_alloc_isoc_urbs(struct usb_data_stream *stream)
 				stream->props.u.isoc.framesperurb, GFP_ATOMIC);
 		if (!stream->urb_list[i]) {
 			dev_dbg(&stream->udev->dev, "%s: failed\n", __func__);
-			for (j = 0; j < i; j++)
+			for (j = 0; j < i; j++) {
 				usb_free_urb(stream->urb_list[j]);
+				stream->urb_list[j] = NULL;
+			}
 			return -ENOMEM;
 		}
 
-- 
2.34.1


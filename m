Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794457128;
	b=zeQtTCdNg2Bg2fcKdrqV1DyINLTYt7GmdDc4xo0eHd6xxWe+o13WpjeNMrQv7JgwGArO
	 pZ7QjnvxSDKstVEt0wHmcW+3AAAee/PYf7cOi/Lz+gKOwDiUCct3CCWCH+qFJtEimZX8N
	 g0NJqLJ5mZUSjjO+7Bp2Gx7IWSMcsU1xQ4g6M1Pz7rW/+qrehqKDox9Zwim89sseXP0vz
	 Vg7SLyXxHmwST8uxT/jqoPzuDgquJuhYx+3jKhBlFSHlHPbV445XRI16tKsOhZeTGBPau
	 dXD8P0Y+F5SG9cyaLWWBhNsGCgkhKSFk0W7H9yqifNLZ+uylIgyXaOVOtkhSyRU8zlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457128;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jxUJ8z3TMPKH3Cow8UWYF/1eg9MTwLe2qZvbY7WTmaI=;
	b=oc/zG/VLrg5UtEQQSnl4ygbjuXr91gkO31VdFmOEC92WP0sngCxIAY15Iui1Ux1/QhoM
	 dvTv9VGfubMGaDDhTezIPcgI9KFZ2TGx5Rm2wtBCwhLJxwKV3vkP3RwJk9fyu/SRuXlGJ
	 tkIm36A5hcl1AG4KrkJptHicCOdB+uUtIjMhAUTBqqFOLYYqzc60/CZQ/50+ZQqXqAmdL
	 OyoQwyzKM//kmXJvZFNXU5/Dsehiky5hcqp66rW5deMXZtl8BteMA0dUgmIt/OvLCZzJT
	 PGVUCbgPtNlwhi65/2jJLbR5fJIvjBXhNfRM/iiF6p/eSduoWn6brTqQwKIsk+zGwTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5CCOp50;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC57606A32E;
	Thu, 12 Nov 2026 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5CCOp50
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794457128;
	b=0gq/viDJRcEtndXiJ+wJIoschfmgJB5TpWPXVahOSGVGRV8Spl91BrnUrK4VfXI6eIJC
	 XCtjID73Rp/y329xRzlCo9Qz29WN3PjRnfy+YQXdUwLBMvSOI0AVdmO2f2xrfXTmUxLlj
	 IbM4gYCUxvBaRLIOK0zylybvh3BpE4nqUZACQG6rV9Hu73wGjPXkzkOEIx7bYN/Hh3JNt
	 DyJVObxLr73uN0KdxOE4dytMGxDNvpr11PZ1tVGPSGyKEn1IEE/iAKjyQ/4Qpy2XtPgx0
	 mw0Vq1qLnvFAL0Jt2EAD4ayQah1uooQnCYKBkcUb4F+o6NN+GDYNahQN5/f2uYvdXAA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794457128;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jxUJ8z3TMPKH3Cow8UWYF/1eg9MTwLe2qZvbY7WTmaI=;
	b=TmlwaqgleRXUUEoiMPFccd3iykamvQjAQRXhG0jdfK7WGs9hF7210pXyNGdfPspEtKA+
	 jK7jrR0AlS4LQFgOiff375UT+34oa3y8zthoTOc3DgdGNx02rR2fXot17MPEaSruZowN1
	 C84EovZSJLm+5BtOUqLfrjsNDy3bmbgz4s9jjdenOSjNuu5csKtjh2kjGIEN4QDZdpOgD
	 sIP89dIjq8kWM8r/KSIEwBh/EWwu/LdSOQfLtFO8D89ttvsDZbLPR6zqv47PdsXs5selH
	 B/nYfxsscp3VVnIxIBZDs1jZVQuRsr0Oob7LefQKhS4r/ECZ9fqzE4fRiVm9n6yk0ZQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6E7521F00A06;
	Thu, 12 Nov 2026 04:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457128;
	bh=jxUJ8z3TMPKH3Cow8UWYF/1eg9MTwLe2qZvbY7WTmaI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=g5CCOp509x8OmQovYGLdwqvT01ZAf1nMRrzEpRFb9TqhVuhFALds7hUrDeTLthllX
	 Zc16X7UZq36t/pHKJ/Lldma5BStB5t8zOTwDXF6Gp9nXQj7c+iIeNE2BCrWchUgJoB
	 kKPG4X9qq47njMjOBqEYAkD7PLQAywyZXle+ynSxQk8Zr1v5YKFt+F4+n62q9fMybF
	 ps87rZ0O6zMaZpbpPd0IVA5dsT7Q7raEQ+sp1KYYXzDdNxfhXMcpYZjR1DgqgGS1i8
	 03t9P4VfxCRMoUuwvdkNb0oeVD6mjuLEaACeOjIu9oHgWp91LZFjA4+S5QmoJG4hRS
	 uReTuEBxpvWXw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C593049289;
	Thu, 12 Nov 2026 04:18:46 +0000 (UTC)
From: Weidong Wang via B4 Relay <devnull+weidongw.illinois.edu@kernel.org>
Date: Wed, 11 Nov 2026 22:18:29 -0600
Subject: [PATCH] media: pulse8-cec: Unregister the adapter if applying the
 config fails
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
Message-Id: <20261111-c4-n014-v1-1-a66fd8e2125c@illinois.edu>
X-B4-Tracking: v=1; b=H4sIABU+9WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINBNNtHNMzA00TUwTDFLMUszNTI3t1ACqi4oSk3LrACbFB0L4ReXJmW
 lJpeAtCvV1gIAP9r2qGsAAAA=
X-Change-ID: 20261111-c4-n014-01d6d6f52778
To: Hans Verkuil <hverkuil@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Zijie Zhao <zijie4@illinois.edu>, Weidong Wang <weidongw@illinois.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794457126; l=4025;
 i=weidongw@illinois.edu; s=20261108; h=from:subject:message-id;
 bh=XIF8JyNv4pQCSsgeieTZ6qi2XZW+IcjZVp9dPdC0fP0=;
 b=gPs7q29+4FwmadOTE1BAx1Ci2OPqW62WrPl2x0RhJDM6I358tKzpso63OFSxT3dmkQcma4Fg0
 1FzA+jfnBJvDm77KH+d0PGloGTlS2fNA8Gc/s2UVs1CqIYgc68Y7V85
X-Developer-Key: i=weidongw@illinois.edu; a=ed25519;
 pk=DR2S1xPEa5sELrWPfOpvUphJQ2VHC+MDc/wJavE/ifg=
X-Endpoint-Received: by B4 Relay for weidongw@illinois.edu/20261108 with
 auth_id=1449
X-Original-From: Weidong Wang <weidongw@illinois.edu>
Reply-To: weidongw@illinois.edu
Content-Transfer-Encoding: 7bit

From: Weidong Wang <weidongw@illinois.edu>

When persistent_config is set and the adapter is in autonomous mode,
pulse8_connect() applies the configuration stored in the adapter's
EEPROM after cec_register_adapter(). If that fails, for example because
cec_s_log_addrs() rejects the stored CEC version, the error path jumps to
close_serio, which frees the registered adapter with
cec_delete_adapter(). The cec device node stays registered, and the next
open() of /dev/cecN uses the freed adapter.

Unregister the adapter on that path, as pulse8_disconnect() does.

Found by an AI code review agent (an LLM-based bug-finding tool
developed by Zijie Zhao and the submitter) and confirmed on an
unmodified kernel, without error injection, on x86_64 under QEMU with
KASAN. The adapter was emulated on a pty with the serport line
discipline, as set up by inputattach --pulse8-cec: firmware version 8,
autonomous mode, and a stored configuration for a playback device with
CEC version 1.3a. With persistent_config=1 the probe fails with -EINVAL
but /dev/cec0 remains, and opening it gives

  BUG: KASAN: slab-use-after-free in exact_lock+0x66/0x70
  Read of size 8 at addr ffff88800e03c360 by task poc/72
   kobj_lookup+0x1d4/0x410
   chrdev_open+0x2d7/0x5b0

with the object allocated by cec_allocate_adapter() and freed by
pulse8_connect(). The same emulated adapter with a stored CEC version of
1.4 probes normally.

With this patch the failed probe leaves no /dev/cec0 behind and KASAN
reports nothing, and the CEC 1.4 adapter still probes and answers
CEC_ADAP_G_CAPS. The reproducer is available on request.

The reproducer, fix and changelog were drafted with AI assistance
(Claude), then reviewed and tested by the submitter.

Fixes: e28a6c8b3fcc ("[media] pulse8-cec: sync configuration with adapter")
Cc: stable@vger.kernel.org
Cc: Zijie Zhao <zijie4@illinois.edu>
Signed-off-by: Weidong Wang <weidongw@illinois.edu>
---
Tested on v7.4-rc1 (05441d697f7f), x86_64, KASAN, QEMU/KVM, with the
adapter emulated on a pty (serport ldisc, as inputattach --pulse8-cec
sets up), firmware v8, autonomous mode, persistent_config=1:

               stored CEC version 1.3a         stored CEC version 1.4
                                               (control)
  unpatched    probe fails, /dev/cec0 stays;   probes, G_CAPS works
               open: KASAN slab-use-after-free
  patched      probe fails, no /dev/cec0,      probes, G_CAPS works
               no report

No KASAN/UBSAN reports on the patched kernel; checkpatch clean. The
code is unchanged in mainline and linux-next (next-20261111).

The reproducer is not attached (AI-found issue, see security-bugs.rst)
and can be shared on request.
---
 drivers/media/cec/usb/pulse8/pulse8-cec.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/usb/pulse8/pulse8-cec.c b/drivers/media/cec/usb/pulse8/pulse8-cec.c
index fa5df1062..374a8fd25 100644
--- a/drivers/media/cec/usb/pulse8/pulse8-cec.c
+++ b/drivers/media/cec/usb/pulse8/pulse8-cec.c
@@ -888,7 +888,7 @@ static int pulse8_connect(struct serio *serio, struct serio_driver *drv)
 	if (persistent_config && pulse8->autonomous) {
 		err = pulse8_apply_persistent_config(pulse8, &log_addrs, pa);
 		if (err)
-			goto close_serio;
+			goto unregister_adap;
 		pulse8->restoring_config = true;
 	}
 
@@ -896,6 +896,16 @@ static int pulse8_connect(struct serio *serio, struct serio_driver *drv)
 
 	return 0;
 
+unregister_adap:
+	/* the adapter is registered: tear down as pulse8_disconnect() does */
+	mutex_lock(&pulse8->lock);
+	pulse8->serio = NULL;
+	mutex_unlock(&pulse8->lock);
+	cec_unregister_adapter(pulse8->adap);
+	serio_set_drvdata(serio, NULL);
+	serio_close(serio);
+	return err;
+
 close_serio:
 	pulse8->serio = NULL;
 	serio_set_drvdata(serio, NULL);

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261111-c4-n014-01d6d6f52778

Best regards,
--  
Weidong Wang <weidongw@illinois.edu>



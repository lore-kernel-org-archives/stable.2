Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061925A2A2
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970960; cv=none; b=RNJ24QAmBsV3z7uxmJFMSgXVkwS6kR0kyizglOTcsR+x0Hnr9afgtjVMPwJMm9jadTt8I1skhS9WWBg62ftXtcJkJPH7x9/4PenOW083XRUsiVarZFgp2C/dBQtXVGggEJjcUDw8BR9VeF9s/pibR+40NQt0l4EbD6A/juOy2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970960; c=relaxed/simple;
	bh=5e1DN0MH+2uhstHQPY9yvSOiQBlfYmFimowFYKSkVuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TJme8/zFyOEhoOgUAIS+x8eIzRgCD2EYjIw9s8+k0Ygz7QkPJKfIm8Sr4AdEDWxVigQOvYSqxqJYnLHLUpZj4fGgcgnhCIc6xs3zwxuA2uHvRhA8p/xc53PdWZiqugeMttkP3y5o93Jkd5UiVxxvtC4TKXpzFKMBa4wLtHvkMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacecubics.com; spf=none smtp.mailfrom=spacecubics.com; dkim=pass (2048-bit key) header.d=spacecubics-com.20251104.gappssmtp.com header.i=@spacecubics-com.20251104.gappssmtp.com header.b=N3iOXIwJ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacecubics.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=spacecubics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacecubics-com.20251104.gappssmtp.com header.i=@spacecubics-com.20251104.gappssmtp.com header.b="N3iOXIwJ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so2219120a91.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20251104.gappssmtp.com; s=20251104; t=1789970959; x=1790575759; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wqlm2oKxQsTu2i23sWiXCPOdJxQdXfXmPVhtM0Xyv9w=;
        b=N3iOXIwJ0z/jlax3Fiu6BpYnaPF6neEeJEt/b8P3htrxe2k06KZRHbU4EM/6wAU8CV
         T3q1zryvk/+11u7rhnaTRjX9ehqNpYuCUeiJmGbnwPStHYhh00ymX54S1Cum1BEJpU7f
         XlnMMfnT5oVWo83a5oQLp+2P9o0xsy9t2mBY0cla7ttC2oDztdiKBzfevJNZYlC9Jm76
         jfPTHYynVztttBOVKhqI1KfIxxoBtgg0XWxzVUtogBUKPO9vt8DsfoxXvdKV1FnOR5qh
         Y82b6ZJV0dR3L1lolultWLwA8w+i2sEM16Co9RAgeJw8vAnksWkDmV4lQsKarn5g0+sb
         RZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970959; x=1790575759;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wqlm2oKxQsTu2i23sWiXCPOdJxQdXfXmPVhtM0Xyv9w=;
        b=mY7w4NyR0SmS4OAmW829ATFpdsYjjg3f8NR6GIUDoTDwi2ZNzVpgzb0tQ3OKIewt/6
         K8d05qjw2xXpiOj3pyijVREu+fMua7rBf6XEO6K9piFsm/PDErsMOQve+FiiYnpP9x54
         vgmvAUtdTtU7cEOjrvmdgjg6mhNI/QQ5tVmhyejpOgT6uSbMXBnjs6F/qe8GvFZoeoC3
         hl3WE4/kemNyoVD5/dumGWzGy6V43WRuv3vhBgdVnD29bE7/LZgHuxv4xbheXDBAThAO
         SJ7ln5uvmtXG367qkS3kdTx90XphnMstok4SuCIOBoqlKFPUiTLgWpFIHvpTk046IVA0
         p5XA==
X-Forwarded-Encrypted: i=1; AKwUvBwNik35Ns87QmJUfMD9gv8SzP/AcP9l4BFrD2st7+LTDa8x7UPke3vTMOLlCy81V8Xh9rf/F6o=@vger.kernel.org
X-Gm-Message-State: AFuF++mIzGPVyp5umgkClUG3S0DfsF9E+numiBoeVnjIa55pi2ZjqQQQ
	WnVscQ1MBHo/SoZXoQdKHcfUSGqiR3tGb25NazyK4UHmPMZf7p6aTHe4HUZOtidaz0Q=
X-Gm-Gg: AYBFou3qjMrkUgBmjj66+DfF+3RUdn2XK7xYNhOg/26JdE2fJkkB+DRF4Y/amoa+bRa
	vyHPPEysEFycODxH386fgJMAlz/F95g16fhhFYl8kGVHxzXdPbuXQSG9uvEM7ylwzbbMx4jj1WX
	HhUhHCtcXXvoMkW9XMhmU6ADN89j9mwTGSu04A8PnvZdRf+f2oi1F1kgvWvt8sc9ttjZITDounS
	piMBdlI5po0LWfLSWf63Pyro0SKNYn71bUNtPl7uVTUCeutJeEC4kqOStFx/HVv5KVXufGMbbUO
	OQINxK1xPHOcvIzRlr/pChIHFte3Dba1XjYyfjFnMt4PiDySGTU5PE2n1zNTWihChEjZUeAFhW0
	eqhbf3eCsBASGsKJGgZrqdy2JJOT2im2+XkBNIdLgQw4wM+ftXEkT3yM4ZpB+tZGIGdJySSu1gk
	j8BkrArZcbL89OEcijhO4FJBHS78bZ/PL52LPeEnwvgL422ft8gNDzHrkcjV5Rj2vdnh2uUC7Fz
	LOjVGXQUGdDs90nEcludOsDKklJ8WTvcmMRtNJTFg==
X-Received: by 2002:a17:90b:2584:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-39e6c68ca2emr8661197a91.61.1789970958653;
        Sun, 20 Sep 2026 23:09:18 -0700 (PDT)
Received: from [127.0.1.1] (221x245x252x90.ap221.ftth.ucom.ne.jp. [221.245.252.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a031d63ca9sm7736324a91.14.2026.09.20.23.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:09:18 -0700 (PDT)
From: Maximilian Zimmermann <maxz@spacecubics.com>
Date: Mon, 21 Sep 2026 15:09:10 +0900
Subject: [PATCH net] can: xilinx_can: set CAN FD flags on received frames
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-fix-xilinx-canfd-flags-v1-1-a371c90b4e7c@spacecubics.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2cBadDp/RXzo2mRGRibNlMLYv
 1vd47ncc1YwykIG12aFTB8xmbWCOzQQH0FHQkmVwbe+a3vvkKVgkUm0YAzKCXkKo6Ebjunkzsz
 hQlDlV6b6/IdvoLTAfR/tPTwpLr8kbNsXOLaTT38AAAA=
X-Change-ID: 20260921-fix-xilinx-canfd-flags-1b4d517ffa8e
To: Harini T <harini.t@amd.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, 
 Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Maximilian Zimmermann <maxz@spacecubics.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789970955; l=2529;
 i=maxz@spacecubics.com; h=from:subject:message-id;
 bh=5e1DN0MH+2uhstHQPY9yvSOiQBlfYmFimowFYKSkVuA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgTdhHxRWjd/5fTnSCl2OntVxEesqbE
 9i5nsw3HMsMZQEAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKXfMkUxdDkzbUxrYqcR9CmxaEoMSR48XP0S0bdMqlRh9gJxY12FDmi0dDFtQsct5b1Va9/oXnU
 BgiIyHvpargc=
X-Developer-Key: i=maxz@spacecubics.com; a=openssh;
 fpr=SHA256:0PWSMXfOZY6FZQRGGLZq/AMDyoKTiLmNTaQ2XShpqeA

The Xilinx CAN FD controller reports the bit rate switch (BRS) and error
state indicator (ESI) in the receive buffer DLC register. The receive
path currently uses this register to determine frame format and payload
length, but does not set BRS and ESI in struct canfd_frame::flags.

This results in applications being unable to receive the BRS and ESI
flags, even when the controller correctly received them.

Add the ESI register mask and copy the controller flags to the
corresponding SocketCAN canfd_frame struct.

Fixes: c223da689324 ("can: xilinx_can: Add support for CANFD FD frames")
Cc: stable@vger.kernel.org
Signed-off-by: Maximilian Zimmermann <maxz@spacecubics.com>
---
Tested building against net/main and backported
linux-xlnx (31626ef92ff1).

Also tested runtime on the backported linux-xlnx kernel with
QEMU Xilinx CAN FD 2.0 connected through host SocketCAN to a
physical board via candump. Verified reception with and without BRS
using frames transmitted by the board. Send an ESI frame using
cansend on the host and verified that both QEMU and board
reported ESI.
---
 drivers/net/can/xilinx_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43d7f22820b8..52661e088205 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -157,6 +157,7 @@ enum xcan_reg {
 #define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
 #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
 #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
+#define XCAN_DLCR_ESI_MASK		0x02000000 /* ESI Mask in DLC */
 #define XCAN_ECC_CFG_REECRX_MASK	BIT(2) /* Reset RX FIFO ECC error counters */
 #define XCAN_ECC_CFG_REECTXOL_MASK	BIT(1) /* Reset TXOL FIFO ECC error counters */
 #define XCAN_ECC_CFG_REECTXTL_MASK	BIT(0) /* Reset TXTL FIFO ECC error counters */
@@ -959,6 +960,11 @@ static int xcanfd_rx(struct net_device *ndev, int frame_base)
 
 	/* Check the frame received is FD or not*/
 	if (dlc & XCAN_DLCR_EDL_MASK) {
+		if (dlc & XCAN_DLCR_BRS_MASK)
+			cf->flags |= CANFD_BRS;
+		if (dlc & XCAN_DLCR_ESI_MASK)
+			cf->flags |= CANFD_ESI;
+
 		for (i = 0; i < cf->len; i += 4) {
 			dw_offset = XCANFD_FRAME_DW_OFFSET(frame_base) +
 					(dwindex * XCANFD_DW_BYTES);

---
base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
change-id: 20260921-fix-xilinx-canfd-flags-1b4d517ffa8e

Best regards,
--  
Maximilian Zimmermann <maxz@spacecubics.com>


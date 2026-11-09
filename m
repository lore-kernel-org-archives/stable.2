Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199763;
	b=rAMmIFOf25vD5BmbcJ9hSmVesWJgKTH8/SudrHT9Hip0kFU6OTU8y51Y8rwGensNAOAO
	 KLTFXEyRnIMsEqGwsPnhF2cqpDyt5A/Lb4DcP++rsc+DxGJvkH7JKoCptUsCGKJCt9+1g
	 NyQEyH7dJ9IOOyNyoim1rZcgNdfV4kIaDVLoqWBJs483lwOVNLLknXo7mL5Vfd16a0nxd
	 +MgYzEGwNPxkcaebWqz03GNCk4tk1JVX3D9YladG6YNpS32Ec+MHobSKuTStq47h6vbjW
	 mr35ZyQsPUwt+VuMjANXsjUYkivsgmhGqjOK3bvtZ42Gr7ZHwLGRlG+WcEfWjJiUjDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bW3pGp4kpjQciNHmYt5QU27XFZt+thBEFfTG9An0N6Y=;
	b=YgB0sTQ3qAjyLcSaWM9kws6c40B9ZUkEMwNX+3W8I8wxD9NonGccLvWqjD+F4fLijFYI
	 Ko7qVjwO65+aWaUIqy0FADiBLIAGDwPS3T/RCBYBCVT0FVW1TRtP4RDsKAOwaD1bOuzHf
	 f20dVrndH0BublpV83GqwUUZqDVIUX2PkS8m053d3CTaMZMagcIOaDYUN1dKkmP1upjKn
	 fDWZIfncYd4p7Wx9Vg6zqc/BPlADTDXtZLdPx8ayCL/QRGdy9YlMUuCPXNX4Z5SKK2anD
	 IT+HufPz0UaEwflbfOdWR97egbYCXcsTcNHMmLIIns+SJZ1iXXRQ6/6e24iSvmL+DfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YWPG7Rw3;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE4606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 04:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFE4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YWPG7Rw3
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1931ff67a29so1302969c88.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 20:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199762; x=1794804562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bW3pGp4kpjQciNHmYt5QU27XFZt+thBEFfTG9An0N6Y=;
        b=YWPG7Rw3GhQIDeRfhmsePYwuXhvWsxUUzI6hojJ+fY1qaHH1Htyi+eOqe2wQWDslPR
         I22+t1yGJ8y8fkQHpmb46zHg32JdmQkKEr7BQ4MsYwXJlJaORrqh6xo6jYXYKif+u1VD
         tkbRE5zM6Gq+kcfUtTYrhSoOTR5LpsTKqQ48P2TYrEQITbuVm01NBm0SgkNqJ2Ttw2Z+
         g9vqBLhA6tnfHk4DgCaglDGtCMfHPKDT2FZyWSZd4r9hptQKX9HgfuZ6bgDoStFQ2QLu
         hGuh0W2YSWGVfl9gYX/l1pPT4xjKW/xddf73Ul5FDoFkOi4RD9mC68FXTOFmvXVzef8v
         Ki1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199762; x=1794804562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bW3pGp4kpjQciNHmYt5QU27XFZt+thBEFfTG9An0N6Y=;
        b=KZ/ROdZntjq4J9VKihR+tFj60eyyh/nzAx5bERoYCm/Mbs5tnl0i6irf+MxI0J9S+I
         bJbwO8xdQZw2TuWZWzrIMlkWsQnrK9+50Ew02E431XRMAgdGNcdBbDI9tg0QHlFdeDp/
         JR4wUS84Wr0Acezx53wgMrh/kD0oJnv6u/5IkdGUgzfq8QWHjVbaQ8sTnHIPZTzDxnZA
         du38jIdker5JuXyWLpKVlpP43zTkxkeeq7L3MFBGM5rrHSFIqG0DLjL8ERgOGRzMT7h1
         6isvorTh4tpQLhGV+1/4/zZMVGKBbQuxW9W/UUpWk7WUWAXjoj72gvOKWt+881kl+VC0
         9KNw==
X-Forwarded-Encrypted: i=1; AL+hErESabdUNYAwaQjl/ANiC8RwwWnAkWmb9YdR5oDlCtqT7wRyNH39od7aSBizwc0CgBpuw/IdSf8=@vger.kernel.org
X-Gm-Message-State: APuU4Z95/GwzNDO5+TDtbV1Iw60RgoEPo8o3Z6n40gLbwpyLxlaqHs3X
	NQRP2+yWMy9PDIkESBxt0BM2hcAiomNXKmN6jTepe6DDZj+onhWXZwZb
X-Gm-Gg: AYBFou2D5AQsqmTKackEU56tsEnKGXEoSFMnH+4+0aw+cIvldUZ2Wxx0/9bofQ62ber
	9htM9Zf79KZkANfzOwfXrH4SjDtoiNhrRqbVlukQiVhUg/E5BLYNQS8jPosCVV0sfH+gSmS5xhk
	U46o+UblsUy1OYA1OFayPJp+A4KcBlpdB9reZDs2f26NEduK71jocCEjYYHojzBFCRwuVphz9pL
	Ioj2I2bxSA1jEAW98bajrrKkwWqqZfvkLl95M0AUuJCTERpj+6ONdfvu4vqZBEvR5MUNrNFBD1K
	bJmxmR2lm08golwqOvchmEkQ/EPy8p7pTe1zmHxvfcKr1a8fTWdABhiqkm8CB9ZFRT26kCWPiZh
	wPEXePhAGkGXlGiikw202OkA0IDPX1wy2uORavzGmq673Ibz9Jn+FT86ZD9m80OpcS5EQ5DS9pf
	fpC0mzUFWeVw+P/BlBTnZC8qL14iaoCV/s62qJLsp8hV1SmyiZkF/70vk48U9OeFcReK0Y/LQQw
	iDNW+CYcoHkIdqJpM/mAoBpA7bObWl+f4eJ4YoRJXzyikWoj3ZpTVgHarYA/gqsV03DSgAwJgW/
	Kn1l9tES3wWiVSOCQ5gfXupSs58W+BFaN4VJCnyC9xRoK/uZ
X-Received: by 2002:a05:7022:7f01:b0:193:9aa3:474c with SMTP id a92af1059eb24-1b39feda7a3mr5031920c88.21.1794199762248;
        Sun, 08 Nov 2026 20:49:22 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37561ccabsm9386759c88.12.2026.11.08.20.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:49:21 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] can: peak_usb: pcan_usb: shut down restart timer on free to avoid use-after-free
Date: Mon,  9 Nov 2026 13:49:11 +0900
Message-ID: <20261109044911.1163505-1-hj351016@gmail.com>
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

From: Hyunjung Ko <hj351016@gmail.com>

pcan_usb arms pdev->restart_timer from pcan_usb_restart_pending(), the
completion of the restart-command URB submitted by pcan_usb_restart_async()
on bus-off auto-restart or a manual CAN_MODE_START. That URB is not
anchored to dev->tx_submitted/rx_submitted, so peak_usb_unlink_all_urbs()
does not kill it, and the completion can run -- re-arming the timer via
mod_timer() -- after the interface has been stopped.

pcan_usb provides no teardown for the timer, so on disconnect (or a probe
error path reaching the adap_dev_free label) peak_usb_disconnect() calls
free_candev() with the timer still live. A pending or late-armed timer
then runs pcan_usb_restart() against the freed struct pcan_usb ->
use-after-free.

Add a pcan_usb dev_free callback that calls timer_shutdown_sync() on
restart_timer. peak_usb_disconnect() invokes dev_free() after
unregister_candev() and before free_candev(), by which point the
endpoint URBs have been flushed by usb_disable_interface(). Unlike
timer_delete_sync(), timer_shutdown_sync() also prevents a late URB
completion from re-arming the timer, closing the window a plain delete
would leave open.

Not reproduced on hardware (no PEAK PCAN-USB adapter); found by review of
the restart-timer teardown path.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..113b2e745331 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,19 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static void pcan_usb_free(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+
+	/*
+	 * The restart timer is armed from the restart-command URB completion
+	 * (pcan_usb_restart_pending()), which is not anchored and so outlives
+	 * ndo_stop/unlink_all_urbs. Shut it down -- not just delete it -- so a
+	 * late completion cannot re-arm it after free_candev().
+	 */
+	timer_shutdown_sync(&pdev->restart_timer);
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -1051,6 +1064,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.43.0


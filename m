Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539846;
	b=VVwb2o4xV1YCCzBBsSIOAOOFvYPlR70lhOIaOXM5DPix02H9U2wW5jI7zS4HHMz4hf5w
	 54ddaWQMX0wc1dA4+ziIfAfiZqggDjxtiQ0wZ1RsFIxLoi2em6obCAVLsz9QDK9/yu8hF
	 npgtFSzEY12QKx3FQnHLCtCxnJpeHvHe58yQf+rsS3laN1Wlcrs7zJyLCIbe2E0Kdh4mw
	 /+wnzzFReGvF4fKJ562Vog5WxgoEYJqsWf+GMG1EckRnr/aMBK3rhHG9skhVZMA8+/eH8
	 ZIwboY7z8/ukYr6jNsIdJQWUeAWP0dwSNBC18DcvOAEAfq6B9TKNE30cww/QC0CXHqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VH1JvbJ5DKEseDp0EiJhFAguvVeg4Ny3vVHdRa/BfIk=;
	b=S2lFQ7C/AgnfkRcxjDgKIqOlPND/JfeAmcTVjFST0tUTYW4cLqXw6Ou9O8v6+PTUbTnW
	 WEGFw2P1UObXJ/NpioXsNOZIwSYpqZRaKPqJT+zXifviVtOK5rUtx5Nf+mcJXUEmD4P0p
	 KfCpu9dun0n0iFvvzD46nlQAWlg1yyTGd72vvrWorw20+bKl+RxnVnfmLKY1F+MU3FDjG
	 re2Y8crbXRH+yqs7gGcuerfNzWpTSMpf5HcCzOBflaXpqx0d6RlXs2zzzPwtFeigcSbet
	 JyM8kiE4Vmm/KTh/gUqQOz4RUwzn2gvcbY+IGBKjlIRr5P+dU6JtBRN422D0OLv91yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXNM5xI9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306C606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXNM5xI9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C41F000C6;
	Fri, 13 Nov 2026 03:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794539845;
	bh=VH1JvbJ5DKEseDp0EiJhFAguvVeg4Ny3vVHdRa/BfIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CXNM5xI999BfYu0Pulpjlt1D4Qs1zX1DywUgDB2eHTs5DHcWDepr0C03rD9hrIEVN
	 Z3nCeUdby7f4XZeRWgoI60kRCVbONxuONc3J2dck/RjF6e3jb3N7ia2JYA/7t3XxyO
	 AfTrWCQDVmMIjAN7RLa0ZdqabPMKQgNvwfSmuTqolN6exQRQh3llQcotLTkE5Y9P55
	 1Ou/2lq5Fx9oKLMqGPx7vhdHAE2+aQ3bN35AXEnjeO6/GqJnXVaXV+C2SOSmOx2+Jg
	 bmVfJJFLkjtEn2gSRW0JjeDxYeQdQ0Sx2oEUU3TIlArdCKiTZ/28g4f7m+XwNRCLUp
	 ljkC9utNuFfuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuqiang Sun <izaiahsun@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ALSA: usb-audio: qcom: Check the return value of qmi_handle_init()
Date: Thu, 12 Nov 2026 22:17:23 -0500
Message-ID: <20261113031717.979005-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113031717.979005-1-sashal@kernel.org>
References: <20261109200549-failed-6.18-a3cf5ebab5f1@kernel.org>
 <20261113031717.979005-1-sashal@kernel.org>
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

From: Yuqiang Sun <izaiahsun@gmail.com>

[ Upstream commit a3cf5ebab5f1db9e6f751e2a08df05a84f37ea57 ]

qc_usb_audio_probe() overwrites the return value of qmi_handle_init()
with that of qmi_add_server() without checking it. When
qmi_handle_init() fails, it has already freed the receive buffer and
destroyed the workqueue, and qmi->sock may hold an error pointer. If
QRTR is not available, qmi_handle_init() returns -EPROBE_DEFER and
qmi->sock is ERR_PTR(-EAFNOSUPPORT), so qmi_add_server() passes it to
kernel_sendmsg():

  BUG: unable to handle page fault for address: ffffffffffffffb7
  RIP: 0010:selinux_socket_sendmsg+0xa0/0x590
  Call Trace:
   security_socket_sendmsg+0x29/0x50
   __sock_sendmsg+0x43/0x150
   kernel_sendmsg+0xd6/0x180
   qmi_send_new_server+0x1b8/0x2b0
   qmi_add_server+0x165/0x200
   qc_usb_audio_probe+0xf4/0x2e0
   really_probe+0x2b4/0x850

Had the probe gone on, the error and remove paths would call
qmi_handle_release() on the half-initialized handle, which destroys the
workqueue and frees the receive buffer a second time.

Return the error from qmi_handle_init(), so that -EPROBE_DEFER defers
the probe, and check qmi_add_server() as well.

The bug was found with kbound, a static analysis prototype for
ownership mismatches at kernel interfaces, on v7.2.12; it is present in
mainline.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings. Run-tested on QEMU (x86_64, KVM) with KASAN and kmemleak, with
the driver built in and a test module that registers the
q6usb.qc-usb-audio-offload auxiliary device. Without QRTR, the probe
crashes as above without this patch; with it the device is deferred and
removing it again reports nothing. With QRTR the probe succeeds, and
removal reports nothing either.

Fixes: 326bbc348298 ("ALSA: usb-audio: qcom: Introduce QC USB SND offloading support")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
Link: https://patch.msgid.link/20261102035237.56253-1-izaiahsun@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/qcom/qc_audio_offload.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 62a57b8d171b8..3a0a0d8f4654b 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1975,8 +1975,13 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
 			      QMI_UAUDIO_STREAM_REQ_MSG_V01_MAX_MSG_LEN,
 			      &uaudio_svc_ops_options,
 			      &uaudio_stream_req_handlers);
+	if (ret)
+		goto free_qmi_hdl;
+
 	ret = qmi_add_server(svc->uaudio_svc_hdl, UAUDIO_STREAM_SERVICE_ID_V01,
 			     UAUDIO_STREAM_SERVICE_VERS_V01, 0);
+	if (ret)
+		goto release_qmi_hdl;
 
 	uaudio_svc = svc;
 
@@ -1993,7 +1998,9 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
 
 release_qmi:
 	qc_usb_audio_cleanup_qmi_dev();
+release_qmi_hdl:
 	qmi_handle_release(svc->uaudio_svc_hdl);
+free_qmi_hdl:
 	kfree(svc->uaudio_svc_hdl);
 free_svc:
 	kfree(svc);
-- 
2.53.0


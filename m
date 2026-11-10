Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272751;
	b=frqVNPYtTwypYG+aEetZayzNuGxqwV6YsEWWsN88lkc3h6Yf2QXk7n0zwwWoMcRrsNIp
	 FrHXZz9ZRsfurCYd6jHR0A6EbS0jz8OQHeLwV9mHuaVQHrxmmKtmjsLTRinkFW34EmPsu
	 zFG83Xd9Ifz433kYFRJfePSgxtEix+iPAGFxV60kNGnOKwvNujVFG+4o3e6n9onqnD4zW
	 Lr0LcDdoVvJT8YKyuxa/eqYuH9qneINMeEUmcwhgZ8YMdI+Pqr7NGFzSN50Mn/kPMALdV
	 iuPSVZmAq9Llwk8GTDCCS4sZqljnDTyA9BHx4wibnuF+7ZUQJm62CyyvuPO7rZZQGqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qZ+Y0cORwY4DGDI6f73FfC3YYAvu+fkj7a2wZ6rJ4a8=;
	b=SVcfNI1mNEfcAoroAwO0DpCCEeKJsJlTC4gjrolLZalJCBNOoXzR0TwEx+zHyvtIUpoW
	 b9TWd7TEpSzzF3OCqpKJOqMpSodbbLfll/N8zG/Yx1qjwYSUZJI+UEQFEIM6j8yStSo+R
	 0JX5tMZVthaaCTtQAGkdGvtpW1+kRIVE3yAW1cDy8Sh2UuoO0zHxH6+aTaT+T1uIbQAtF
	 ykUTf4OWBe0bSFfAhZxIHbkX1iS0YNiqP4W7oeBwya7i4RSmr1hJDwWDv8P2kG6BZ4pyo
	 BiwOuN0annTwxpkRkfl3zvC08eKHKwCnxC7aG6hJw1WEkjsYFs4MhT/dWV+FPsdFTpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVX3QYsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVX3QYsD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004C21F0089F;
	Tue, 10 Nov 2026 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272751;
	bh=qZ+Y0cORwY4DGDI6f73FfC3YYAvu+fkj7a2wZ6rJ4a8=;
	h=From:To:Cc:Subject:Date;
	b=HVX3QYsDLdreg6BbK/X71MsrbwI2KMay+83SnScvnVos8XiBp3cmGueger64cAxMk
	 HSulQa09eVGIjT+EdcKIS8A9VpBFI+LMUwg3vkGP1cFbXefbjO76iKkS8pjEw63+J2
	 ORwTWrlqQWzBw4dG/EkqvSwytthRUpDJQlETXzFBXNRwQYzOxF8OeDsHRBo9Ba16YA
	 6W3eGbvPwEHtqlxWvxgwgcWyqHlcUbAS0cyWq+I47cG5Umh6J1UazkcZJ1uRdRoLob
	 vgFMp93yvP40MtP1RGtCNO8QfxQJu7ZdeoYr+TQqIqAWvc3hKxh8ZGtcVxH84CfaDo
	 tmaZhnHySZLjg==
From: Sasha Levin <sashal@kernel.org>
To: izaiahsun@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: qcom: Check the return value of qmi_handle_init()" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:49 -0500
Message-ID: <20261109200549-failed-6.18-a3cf5ebab5f1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a3cf5ebab5f1db9e6f751e2a08df05a84f37ea57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200549-failed-6.18-a3cf5ebab5f1@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a3cf5ebab5f1db9e6f751e2a08df05a84f37ea57 Mon Sep 17 00:00:00 2001
From: Yuqiang Sun <izaiahsun@gmail.com>
Date: Mon, 2 Nov 2026 11:52:37 +0800
Subject: [PATCH] ALSA: usb-audio: qcom: Check the return value of
 qmi_handle_init()

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
---
 sound/usb/qcom/qc_audio_offload.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index e4bfd43a2488b..5ee568e0454cb 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1969,8 +1969,13 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
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
 
@@ -1987,7 +1992,9 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
 
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





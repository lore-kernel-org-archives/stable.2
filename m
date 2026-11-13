Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539845;
	b=0J0AnJ3ilnmQ/GLcIW64CLtuoGL8/dmXaMWEMgAQ7iibY+sgPh62/IEZatQI3DuUMVds
	 /bnw78AzIYWeMHguNzDLqTCFvd2WpT4ON5E2/78orGiMiIXnQLbLYzkcxxKckVXs141S/
	 sRN+TCPKk6hs4Ju1bnHPNpBMNRh3n0V4c3Bp/px11gmJFFp0/AKjQR5ykVLZxKUI3cuEl
	 vCOTmogsnXRCzURUpic4Kc0/s2oDF8zXi4+d1bxW2zDp7o6DF+TyN8pVRvF2ejmNI9lh3
	 ZamkwQvrokANwO4ZgF9RS+47GU0upXafBjjct4KFCaRnllmH2ORc0omeAh6Fcs7OoqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J4B0ABZfnPAAzeN1jVcHT5tGATdVjhKe1CWL3mCcuXM=;
	b=yAJC8g0bOwzsfPQr687lMItsQGVuDK+F0qqyMxG/+6yWLTKJcvUEXLyJ5cS7NOqo2hRf
	 dMSj3IfMdw/Zpzks7duCshwoqFokSdn1kDbdL4luireLJhaALCMmPkVZ48/iWePYTyzYc
	 475/+ihMU+GARUAmEt1CNSFn4HEoMEV+tSYyt5NoEiwg1hhlRYpoSjpIHT/V/9e0donGh
	 5jZD6qCdQFqlV4GTKB33k+ZCym8IDhH1I+fa8uA86/OvTlLP1pNf0mGmJNtku6dycKBXO
	 kUT0U6se45rKxzAnWPn64Wr/M1pEL2e4UbI6XqjKa0i8vOxZUKaZdoAhZ89tqF8Uqtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arCyxmeR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFAE606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arCyxmeR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C871F000C4;
	Fri, 13 Nov 2026 03:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794539845;
	bh=J4B0ABZfnPAAzeN1jVcHT5tGATdVjhKe1CWL3mCcuXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arCyxmeRN2XyAWPPan0IF7zES9V1KklwSblMr0B30hTKGnzdAABoKykZ9IZ5F0DeB
	 i9VAofxUnB1eRUa8Gh9LYBj5OiTYVx0FdXlA1togL4zFfor4J409h3DV9vkFyvyIx3
	 de8yJZpt5sQVJN3bkjJowjJQu7hTP4njhq3ZfzVxzxflxPZni2k0mP+RlPuqVVEA2O
	 3jH1mL5u/3/SCeB8oSNy/hJlhQhtarqp58h1lqhzVL+XS7PLJrXjy/fFzZTLJ5jN31
	 XScx5lVWS+4Tgp9ejsUGRpxzVZkFSw8/4hSfpgLP9qlq7CE5lRLYxLGQ+Igstxdn3h
	 +pkeYaDUeIzUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ALSA: usb-audio: qcom: Free QMI handle
Date: Thu, 12 Nov 2026 22:17:22 -0500
Message-ID: <20261113031717.979005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200549-failed-6.18-a3cf5ebab5f1@kernel.org>
References: <20261109200549-failed-6.18-a3cf5ebab5f1@kernel.org>
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

From: Xu Rao <raoxu@uniontech.com>

[ Upstream commit b8ff1f3578f83dedf5feb796d97a3f67c1bea58f ]

qc_usb_audio_probe() allocates svc->uaudio_svc_hdl separately from the
uaudio_qmi_svc object.

qmi_handle_release() releases the resources owned by an initialized QMI
handle, but does not free the memory containing the struct qmi_handle
itself. The probe error path and the remove path currently release the
handle and then free svc, losing the last pointer to the separately
allocated handle.

This leaks one struct qmi_handle on each affected probe unwind and on
each successful probe/remove cycle.

Free the handle after qmi_handle_release() in both paths.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/9108EC860F3F87DF+20260623071308.2549182-1-raoxu@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: a3cf5ebab5f1 ("ALSA: usb-audio: qcom: Check the return value of qmi_handle_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/qcom/qc_audio_offload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index da2759f2ee866..62a57b8d171b8 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1994,6 +1994,7 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
 release_qmi:
 	qc_usb_audio_cleanup_qmi_dev();
 	qmi_handle_release(svc->uaudio_svc_hdl);
+	kfree(svc->uaudio_svc_hdl);
 free_svc:
 	kfree(svc);
 
@@ -2018,6 +2019,7 @@ static void qc_usb_audio_remove(struct auxiliary_device *auxdev)
 	qc_usb_audio_cleanup_qmi_dev();
 
 	qmi_handle_release(svc->uaudio_svc_hdl);
+	kfree(svc->uaudio_svc_hdl);
 	kfree(svc);
 	uaudio_svc = NULL;
 }
-- 
2.53.0


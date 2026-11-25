Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593679;
	b=nX/hwvZZ3acR5LQffbShvkTQbZIe0WoLWIwhj90stcMisJ9Iwarr+5s1jaAP7Qxqi+Jm
	 AsLkiRk22OR1SNcsNOeLm8MNYZuBwSQPTE2noGMw0iHuFNbP0ei20PP2ndeT5jzfhn4el
	 CkJZpKt5+KFeCecVzGhtMSdK1wa1C8KfUUA8szH4VhznAW4RHBm94SmS+RTltrJIi63Mc
	 rnyblizuwvcgo608prR/8THxbDq5zQcJmWSmRaG8zFaGLWptABtuzfg3Jdn0DcmOueN+B
	 L0TElhWxTvl1zYqUjYCfTsed26RN88hBCxjojyYApABs2Ylq8bcDt0RxYgDunhEz89w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593679;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=f4BDOrjWvnpZkSNCn7i4hODP7e8CFhLG3YbJwtbq2r8=;
	b=kDlA/Y8ELyH27rx6SEHRfSeeQe5mBydI1v2WlUoFoC5uPfcUglivfZ3tkV7SzQpJevq0
	 6hlV82zvvPvCV0dEA8esYwpGv6o8znUYFAaGLrg0ER/MS5fJYQ1Uiq85Apn04ZYM5O0Pt
	 Mi17f0sshnF9NN82q5HB0pAmq/GOnIsm3hivCTMcQF4YGxgqFTi/pQn+21qhnmz6+EZTa
	 8Py0Iz8tx6eWi8pBXfWSqGDULReVt1jXVU5C0NAkytMqnzujheosxyd/WqSp4nRvdRlGO
	 raviyS+8KufLQl63UT7SSI6FFqx88XgcwE6XhAyQ18OQeNMoEyG/O0MfN9rPg/I2v/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=m7cAnaND;
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E039606A31E;
	Wed, 25 Nov 2026 08:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E039606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=m7cAnaND
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795593640;
	bh=f4BDOrjWvnpZkSNCn7i4hODP7e8CFhLG3YbJwtbq2r8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=m7cAnaNDSb25xweNbzWEfE1coqCu9RK+W0BbYia6wAXgbLmxAIabmRLgLUwcv8QTc
	 Y8xe0WfqtyLLLth36rwWT5HgnmAOHym+gfM5gPr7vJuBROL1oVVxzyRiHRGYwrisSb
	 fVb9O/wP4L0dooVtb5KTiUJLMQ3qRtweQaVocE+U=
X-QQ-mid: esmtpgz12t1795593624td5f0f43a
X-QQ-Originating-IP: ANCK05klNgD3SRV1Ylh0egbkc17pc0M7nyJSwN8vr3o=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Nov 2026 16:00:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6911233739420315500
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: pawell@cadence.com
Cc: gregkh@linuxfoundation.org,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdnsp: fix NULL pointer dereference during system resume
Date: Wed, 25 Nov 2026 16:00:21 +0800
Message-ID: <7B818A718E70C344+20261125080021.3907332-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NhdiEwnVOUqEoYTBV85/Sbt1sDdyb/Ak6xUl/7CZDKPexW2/c8kH8QRl
	HVCRBrFFVOLOa3BNnarsI07U2+zJYye2StVPPBprsvw/XX3VyfuhsGs1G0jzWYMm8EKaB/j
	RobcY9buh17V3Csj5PoS7mZUOKJQmMWfk1Evf816TKuNEHwXXWNeC7nCvYzKC9Mf0Zvj7hj
	RMf9AqoZoxWT0BAtErEpU3k5arwhxQ42M94rm59d3E/Yii6STLLMQsmAvBw8RTI1oGbUwzL
	3alKrpJrCLJv1GMjpxLRcw3sdTPtNC216TYEDHfBAsc71rhI8ROTjV7rjay21Ady7Oejkx8
	GmMzuCPlrWMC3X8ucJcexTViNFXd+ydtuWucmJSFbW48NjAZr1JqojpnGe+76PJNXUvUUuU
	Yn1ze0eX3efyfzJZalfpO7E62n29l4wPrWoamhDsC8wxf4ExGy+QTZhO8R+kN8++HgoGufI
	/VkLr8s1rYMfRXRBJC1T4eFNlUxrV1zgJJ0RNQGg7s44YT2FR5KlyvHLhso8KQhUNifEevN
	qF7Uy0RqFN/nGkGb9/56Zu2/DzWr01OFlYqgA1cwrV4OgByU2uM8tbNGs3eluuDlEnvHqTB
	YWK6BrG+wMgD30Pr/a9rH5rpRntm9EjKcUCYOf5jh0CDPi9NLxSOFGBPrxRxPZ1I2LLazRz
	OEwCw6MhkCt4z+V1ZKpCRhQYAYG3GMZoF0B8h1Dw7KMxgei8O4ZpTRAJUuhhArwtnM+cD8Z
	HNnvYBoOTjcGH7faDcRqpubeZX4otdHqeOZJMb2/51BJiCKdbEU3aUCoUHGbpT7bAN40RpQ
	OFo6CQ78rkqhuLIOb8PGfQnVEN4t/6psjDtw8Vd1UvuCxQK7JY8RLYH8DUovoCOZPSXfetY
	kAVGVHPwbmUq0/CW9E6NeER4lh2iT24+L0x6LLqPF/VN9+baKv6Uy2aS5g6EJ+9PsmLcvsO
	F53Q1hCCWwEjVaGI4pJbM68Pphvyw6b0uX9/PUVqJvX3ciV+EN1DONPyfxJtNcTB2/WTucJ
	wiZ17E0r5dkF8HR3DOFco1kr1M8Ak=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

cdnsp_gadget_suspend() now always disconnects the gadget and stops
the controller, even when the link is already in U3. cdnsp_stop()
disables the slot and clears active_port, but leaves the cached
link_state unchanged.

If the controller retains its context across system suspend,
cdnsp_gadget_resume() may call __cdnsp_gadget_wakeup() based on
the stale U3 state. This dereferences active_port, which is NULL.
Port-status event handling cannot restore active_port at this
point because resume holds pdev->lock.

Remove the obsolete wakeup call from the resume path. The previous
connection has already been torn down during suspend, and
cdnsp_run() puts the enabled ports into RXDETECT. Let normal
port-status event handling establish the new connection.

Fixes: eae6460f6173 ("usb: cdnsp: fix wakeup from S3 after controller context loss")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/cdns3/cdnsp-gadget.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 2830b595d632..350e45f511f5 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -2160,9 +2160,6 @@ static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)

 	ret = cdnsp_run(pdev, max_speed);

-	if (!context_lost && pdev->link_state == XDEV_U3)
-		__cdnsp_gadget_wakeup(pdev);
-
 unlock:
 	spin_unlock_irqrestore(&pdev->lock, flags);

--
2.50.1

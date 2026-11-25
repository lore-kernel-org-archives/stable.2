Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603225;
	b=FjiNf8Y7alcNJZtimm7fh9/Se5IMWHHwUZjAq6jqD8YQfc6qWe3aJSbPP1WrUxxzFqk3
	 S8HVTXVDrzSHJEpLlePw2q2cSawwjxWgrMWdBXQmUHqxZbcZ789FLBacK1z1bk5e72e/y
	 FtXukSMiiOaZTHFNVMazU6B6vz6tbSxWGDap8PMgapG4wMeDCxqnueyf7A1ilremKpvDA
	 MaexTtqWcxDAZEzxfclkqtYJIzBcutBqqdAa6BiY0ZirpK/cr+8A76XFO5BTs55EzV02G
	 cQTvQa6aN/9yoxynNgWO9Sb03RkzkdY6JzoVBz7TobVjg+wkCQbo+te24E1kcRCDnzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FCGiSnqKfVbZlERkyNiXjjepPnteWrvTd+cryhqdlBA=;
	b=A5AJ+usCBZVjjidSU51PSBnpS1Nec1qktjdKl5UH0yFHqfmnEKw5HQ8oXhPyuFrFVPIp
	 SBH2/foI7Ohcdg9F97b9m8OqQZXmXVStTynwuDWqbRCRwLTLejFZPYiicEk7f420D4uEJ
	 QiE1MQrdl7k85kbntrCNTV4+kRSc17JkF6xmTbRIBqi8IEU6QeDgBjYlGX8YrTNFl6nIt
	 LQeaW0yKnrY/F78lXoIupf/ampBIPjSKUT5aH0sZs/fOXpYlIThhFgWDY592QGFiG+89Q
	 U1pXrEa5FtphJbc6te2NdiD3pwtUfTvAzAiOWwSeYOi2BXcbzU3VW4m6Gk4SkpJxqYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SMuzwxlF;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C7606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F34C7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SMuzwxlF
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so59743655e9.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795603223; x=1796208023; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FCGiSnqKfVbZlERkyNiXjjepPnteWrvTd+cryhqdlBA=;
        b=SMuzwxlFaxBdqEKupoqmL/S5WE8PpJsTnWFjM1zii4Q6GXyUFHoEZXDsKaCwmck9t4
         f0WqCVBC0mqVf7f69CnS9RFOxFrLyIlwRZoTo8jULsBgRrFUxSSXpu1j7MJ2hR+DS1uz
         LFDRkspPyJZsvURcDdN5SxT87xjcwfy5LiwZQzxFSssIJqxH7KWZbpEaPQVbsQGfwmnX
         NZ+/kG6+Zqx3OI4SaA6b1Ut6x2RWxYFuvVv/J08DwDThpKpaTD9sxkJUmg+k4ter6jhj
         SbBYu2fe5HZrUKEEAZEuTTgYz3c8TJhf3k+UZD5Xev+IOtN+KEwY2LTz6XBg3u3PbtdY
         lOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603223; x=1796208023;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FCGiSnqKfVbZlERkyNiXjjepPnteWrvTd+cryhqdlBA=;
        b=0RUf+mSMP6a2fGYDjPSMTimcihEcGxHbsPug4v4YUFNfBAb/lzJK2F1WG/20qp1U30
         rjkwAEkpGaVOfIBdABJ9vtY2JSzYYGUF6TkbCupm8NMpaksmncgCbmFIYNRP0lXEyoz3
         yLSO49sAn1LT16/+SqnNDr4NiHchvZRcNs/zLEB1YEEL+Y3xjsMMTM55Vykq/jqu+tlz
         AgD0PnVjugEp7WRW/SbMji/W730psgFqKkhm2OCR4skDiPVklkKlp3lJlF416TlcBeGu
         KlfdyIy+z9d04rdbwSsKWaG+AxOfoWRPw9c88+b6bWEANOgKv1w0NGyeqWPsLyZBU2Ak
         kuYA==
X-Forwarded-Encrypted: i=1; AL+hErFBqk/DzPcBF38TLyM6ZzqTftZfXhY/uJ99hS14LVWPXDzV3VKj3SKGNIqPcIZja0y19zNUimI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IrvvMfPaYUX6kagldHQjx6jrVQ8cVpkQL9dpYJBcizbieBili
	P1Qs9NDFcC8FmkFz1s3H4gpHXEt1qrM3lU8eQSz99FD9OxKxnychWXFbo1tUh3on0X4=
X-Gm-Gg: AZFdTZcfTyxl50yMSf5sQVjS1hSsXNA0w93qnXzTq23kZRYthiXyjSK+UqJrv2BLsr6
	vsSnO/vwvoFNzXxizhWpyZOIITH1GHlw29E0ol7w25wgsWfsirlRp+mEh/seemhpQfZx/3jsBE6
	T+w7tM9u2gwfjPEBwPKulv8UdFwdt3HZK+g/Fdg+gmh9siedczl5TNVo3IRDk8FNITVXjkW2QVc
	t+q6xkrPuS8aA6W7SgsswKujVo7dGm6EkxZ787N2pcmPSkisylToqS18Jlmwab+bTT1LSGuzni5
	C+N/J0Wo55ug7Z3WGM+yfsA/qtbLigtRD+nBVsZo+Jrzvp/9HGvn9/pUorZLi0bgpZYz4M2zlHP
	43+DFlUxCn1TA7wO13hGElnZaDDzd/S4R/ZOZ7Y8aFVNsp/BjLoIqxI8sifEeLeV+plvTNItLrl
	ECjSFghckJRyE2hwnVYTjPM57xXiSPLvWaNQBYjSHiQpKEYrOQu74aompAZSpvCMj/26iEVIWXr
	EDTs68vULb4OQykBJdJs1pxEsP2NfPph0mc+v65ss/luW2vGi6EXGCzRkZLmSThCyVG1AGDYAEn
	g5PJqaMxUfhe7JXFbyb35XtK1vAa0luOwJySUBgmo6+7N9YkIQ==
X-Received: by 2002:a05:600c:5395:b0:4a3:5a98:c279 with SMTP id 5b1f17b1804b1-4bb8880e599mr354010915e9.8.1795603223157;
        Wed, 25 Nov 2026 02:40:23 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm527792685e9.2.2026.11.25.02.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:40:22 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] usb: tcpm: partner sink capabilities and altmodes
 leak fixes
Date: Wed, 25 Nov 2026 11:40:16 +0100
Message-Id: <20261125-topic-tcpm-core-fixes-v2-0-aede2a3471f4@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIABC7BmsC/4WNQQ6CMBBFr0K6dgwtAdEV9zAs2mGEMUrJtBIN4
 e4WPIDLl//f/4sKJExBXbJFCc0c2I8JzCFTONixJ+AusTK5qbQ2OUQ/MULE6QnoheDGbwpQotO
 2sue6qFEldxLag6Re2x+Hl7sTxm1sawwcopfPfjzrrffvY9aQA57KotOdqSvnmgePVvzRS6/ad
 V2/6BHjFc0AAAA=
X-Change-ID: 20261120-topic-tcpm-core-fixes-5cb1a6a9838c
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <groeck@chromium.org>, Igor Paunovic <royalnet026@gmail.com>
Cc: linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=q+iadRc2orBsXL5qBs+zHiCenMxscHOqHsHaUM4IaQc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBrBrsUmzXtCJQx/WGLZ892QyEG45Ph72qKqMVeWDon
 G++hBBaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCawa7FAAKCRB33NvayMhJ0c80D/
 9PYd+FINwhj2BglLqCvNiJFIGPRZ742HdVDVLsS9Q7k1ey44Um03c5MFFBlmhS+6iioCfsbSbM8gyC
 syYrD50pUM6lYJvAXu4BcvRkshojWIMa8s8sOkvE4QQEiwHDVnDRh5PeNr3+JwhC7LLadnCk/G93rT
 IEU9I3Laq4+V2eH9zNm6WlRtvw6UCqfcZ0+yuYCqXcMZhKTztLwdjHmyA/i6r0dgDjkhIJibOjsvAW
 2bWwr1DVyf505I9wLqnZbxqT1sFrfCVMFyBzd9n/0m6BOVK5f503hPfflY6MTwQSOoGmVrHjTjkn5o
 6iJVSLHzSglFuBaW2Fi17R3EBTwpJZ8IpnokcEv/eCgou25b7P49QeZ1QWQUXsLECU55fKOsq5jRxL
 oXeNboxtdu1U3CtbcONdAKIOB2f9eYH/Q84M5G0E+DpkRXWVmmTCxOGYGL4iJDt85woXyBnMcob+S8
 um6ngevCtPDG2k6prxic2+vSvo1qKRT9gAA6D2fEk2Wdp+ixSCdo0B+3fpETQ3sR/acHGzmmqC+r7h
 sVlS3vcDspY5E0v/xd8qVxo7tAjOKw9Qc1Teh347w1n/4zTJPugz5q+TGlr1rO5TWV8Ys7ntqaWVZI
 Yg+DpgVvxI+bUWF+YrKEhrLifsS2rKnCOXEMA9BJ4cb300qSfhFJhTRGzcIQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Two fixes for potential leaks where neither the partner
sink capabilities and altmodes were unregistered properly.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Add Fixes tag and review tag
- patch2: Unregister partner_sink_caps before usb_power_delivery_register_capabilities()
- Add new patch to fix a regression when calling tcpm_unregister_port() and the TCPM driver can call back from tcpm_reset_port()
- Link to v1: https://patch.msgid.link/20261120-topic-tcpm-core-fixes-v1-0-c753d1d286bb@linaro.org

To: Badhri Jagan Sridharan <badhri@google.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <groeck@chromium.org>
To: Igor Paunovic <royalnet026@gmail.com>
Cc: linux-usb@vger.kernel.org

---
Neil Armstrong (3):
      usb: typec: tcpm: unregister partner altmodes before re-discovery
      usb: typec: tcpm: unregister stale partner sink capabilities
      usb: typec: tcpm: destroy worker after reset_port() in unregister_port()

 drivers/usb/typec/tcpm/tcpm.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)
---
base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
change-id: 20261120-topic-tcpm-core-fixes-5cb1a6a9838c

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>


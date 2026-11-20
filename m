Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168581;
	b=E8pUWhoPkKRRtgjuZURSax1hlg1oZHu8cs6X5mJc8cYkCkxY25s5yoLXxZmlji1VYAP5
	 TspJmvN3UHBcqe12ggktN27Ac6N/RUuDlmvxvrtobsQ3/SliHl/yllCHbNWuq/MTvtCBr
	 0/kJXGqc/Eh6ZTGEmLd4t1Q9hlV7HmSPabH/Vmqitg1b4NPhLbY/hIV4bvGCp7Z0Bf+LC
	 VPgSQ62X8291w/3DjWtZnj/lfXzxu955ezocX1yw4IJZsusNU6MPvzdHJ1jGL3PGakbHZ
	 zpAzWGaNYRSdgfTozT/bxJAik3VzY+1zGo8FYdNshag+GCxVtADAWefxr+yfaYrm9IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Lv1hMdrGV6lcDc+ZHAsf9MP/3WYy0zcj8WENnVEBfgU=;
	b=e1fIa8OaMdSdvKbOVVptk7efSmkLqYC6E7DN3zcFtr4DBs2qb1ajnMDq12Q/ZmcWxa4P
	 s93c25MrOr8gm6S4vjBNi3GAXuCJPgajMBPeHuL4QN5ilrUh95oDnIq52AAeSDMyk3Tfb
	 ja2nvK2N18xUto9m6+AImomA04Ha7+AV6J4Lc7+Ei88Chsqjo3flF9P/IbrY5g4EnsfXo
	 Sq3YCHOpV9h297sUwyucWafwdTwZu79VL3OzUaKASsKk/ICHynciQz3Nca8WL/BJMavPK
	 31zmsbbVCqMevU3Z8z4O/CLZ9nW6hjldAXP8qVoyTQ1XLjjUQOlKn9ZoMrHRRNprc6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gAZlj6Iq;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E6606A334
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 849E6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gAZlj6Iq
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso4661005e9.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795168580; x=1795773380; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lv1hMdrGV6lcDc+ZHAsf9MP/3WYy0zcj8WENnVEBfgU=;
        b=gAZlj6IqekXEVfJlggjfv07DOWW6/7cYKnlC6avwAGwiXMJyW8YVrzL/GxhFWRa4HS
         20CY9aZZkCXPpfwmshL5IBBZKw5DpekkU580DsPGlGcJPzYwX407GeYZq7locg3Gh1kG
         0yD9TYuQ0G/VzkVOrG3TkTgbswsaQDEXGn/H+g5E6y1bC5gn0OappA+od9TG0pZk2yrV
         JVxX0Kk228/UB15RXZnzKnXAnV6Fj9TNi9cuxtU6O0KvRq/5k02Exq+RVPtVoG7g3/pH
         hnDnX2geutmNmkCF4Rz5vAlx2XNUSRMPb1JwTtQkG8eJVnvgB1BiXMixgrzxsXe7YiZ8
         7uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168580; x=1795773380;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lv1hMdrGV6lcDc+ZHAsf9MP/3WYy0zcj8WENnVEBfgU=;
        b=fD37xgNWSaLJCLLVRHreoQFaAX67W0ptNp4vQNwQIM3gHJVfe3Av8jEc11nHgshhvz
         HFphSfjQg60Ldud4K0vm/kJPnbn5+Q8h29DQ3G/iBpyvLv4tIsV3FK0aQKakF57/YNOq
         rzoiDsuTA0WSuramXITvYNCe25Gkr3skgllGPRo+yaRJLjMBbT1POcPca0YqouBIail0
         Fd1JygbIB2y3QmoNeFe+CnrwOOjyVKpdcUnc+AfqLGuCTyHRyrBRRdPjnhs6eOofwvVv
         3T8QwUuW0oRvIU4NTVK57u+fGm+ShT8i4vn2gE6fSQvgYb3xkbMEHMixl7USsoUxQi20
         o7lw==
X-Forwarded-Encrypted: i=1; AL+hErHyJSDXoao8RWNCasyVBEKAWds9MZu9zx1B3kELK0bgp7sb+6g+J8OBZs/4uA5QUwQaQTx+6ug=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RWjchJuox7cJWZAzK6JaTp24LVWIx2/i3NsKUw10xZbOhXYfn
	ryygePxWGqksc5F/Wjfnp9q4IVKu77BMcehNIJ7TdkCZV5hz586guvLgwNbKTaWLC3I=
X-Gm-Gg: AYBFou01XWz4AX1lOkocm6wvjsnADsV66JG4juO8298DD9Oe1n3w7Nm0NOFnz2BOskm
	3D9SCyEgr2YBYERY4ypz+WvbDxTlrBL3vE7Ni04eNIMxOSwBzii2Kyo9y1i8bb4rATNDVyMzxty
	2ZozlHQ9NlkICn5eEBUbIH8qxF9XdCbmSN1t7ZQ94x0plX4wdvCIeAplopcJ9Y9dzcLMe2kcN0V
	6eiGUAvpFZX4SYgUo+pYjQS8wtb6h6olx/KRsr4flXX0Ba7HXCps/gLQxdk4hFjxiNpKLHQtfnT
	0hvr8HULCqJNfMs7BIjT1ACaZVR+zwBiPLbVQrFlQS0epY6HTP6OQApeH2dP1w5UgODZFgMWA0L
	FNvf4l+YamIu4cyR3dDwafMEjk5JxHlhBQ056d0d2ZGCpDa9Rdsel71WU3YkmIaDcmLYCTbF+ZR
	FfYxnDRBhdclw0bdRsFmiyi4KIc+4Nlbjgz398ZFWR7XRGjc6FvIustuDMr1KxLdnpSGPW3r7C2
	YA69RAb1VK/vlLs1Rx880DQdij1FxiPkGIHJ2kGXHdnlMI0kd+krdtX/ttoIDj3wxRiwNBM8oco
	pQo80wBGqYCtW0p9xfcCZAcJmUMKxoq+MrknAt2IJ5RH0mohZ9zKzzsN4b6GHAFTOmf4k3xS
X-Received: by 2002:a05:600c:530f:b0:4ba:6d8:dfad with SMTP id 5b1f17b1804b1-4bb88811eecmr50126415e9.14.1795168579630;
        Fri, 20 Nov 2026 01:56:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm149124555e9.13.2026.11.20.01.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:56:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] usb: tcpm: partner sink capabilities and altmodes leak
 fixes
Date: Fri, 20 Nov 2026 10:56:15 +0100
Message-Id: <20261120-topic-tcpm-core-fixes-v1-0-c753d1d286bb@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAD8ZAGsC/yXMQQqDMBCF4avIrB0wKYp6FXERx6mOUBMyaSmId
 ze1y4/H/w5QjsIKfXFA5I+o+D3DlAXQ6vaFUeZssJVtjLEVJh+EMFF4IfnI+JQvK9Y0Gde4rn2
 0BLkNke8hp8P4t76njSn9zuA8L+9MymV5AAAA
X-Change-ID: 20261120-topic-tcpm-core-fixes-5cb1a6a9838c
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=638;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ABTe/CMW+uneLPb0+x4INHD8usYaqAzWMzH4S3nWxqU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBrABlBLyUA7GhYb8kYEwoJQG+Htl9VB520u9KuWjT8
 YrPZkFuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCawAZQQAKCRB33NvayMhJ0arjD/
 9+WjkSBvHCBR61F1mfk2BrwAnS7T6VJJlq2yTM73ABCqaTCbFBZeZa4Jzvrost9jFS2FOrCuw/U4bR
 6NMefRxSWuMAqP4DZnQ7LZbOqdUlNGrs7y9J4STrqBRTBtqtyO9FyVDmcbtx4mxpF0VcbrfgSgeric
 1uPtx5s8DTSJm7tkGah8W9QTd/zMJG9EKSUvWaTs3/asjf1wv3B2yqhkTEyHwzj7/VZtTgJWp7V9JN
 hJtPi2/FkFGY13AXxYkyaKI672FEjWncXA/AQ/BUEopTs9Kyuyy2VM8LPswBiMWb1BMqXD9v4MhXKy
 jt7sGB7uDtcEIXFiki654DuZjtFsY3nVr2+s9+OnfOKV0P4gjZnPVEDPmSbs9kHTyp5sIg+VLyg1Rc
 YMefNjTUkciFRgeNWyNMGsUbN3szFy8Proe3PbwUGpVQ6tKfwbMsmOHZ4c5Im4Kz17TMSeuW08kCbR
 l8Rp1xkND4zfcZkEJuPaaHpnSk0y4OarNLErwaZZtjkQPKfoV7uUCnOktxwxJQHun06ocjpTp4jACO
 gmnbyuWMyx+TF88Z5K8xFCRBBtMtVfTi4iZZfUGbIL4a1lcuSr4avScosmv3J7aGNMJnBGCTXF5nj5
 YLcPgFYvKez1FmvVJJontsHZGLwKnebiFBG/hfJ9VtYcy9+TanCuhe4tezJw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Two fixes for potential leaks where neither the partner
sink capabilities and altmodes were unregistered properly.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      usb: typec: tcpm: unregister partner altmodes before re-discovery
      usb: typec: tcpm: unregister stale partner sink capabilities

 drivers/usb/typec/tcpm/tcpm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261120-topic-tcpm-core-fixes-5cb1a6a9838c

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168583;
	b=XYeegjlunGUsCEZP/mm/12xIVNF2uFhRCbR2COp0XhhT1zBnajPA2ZQJQAnCR2aug+T/
	 HLP6vMqpkqyqFGbmFXaCLKdQRuN259vdKBR51NiLF0WHIiZwL/4HwtyLG2Kpsv8sfK8Io
	 nJenQuneWu2wgAjJbJLW84onAVXCOnzLaTUDhopYVkLr1HM+PLlqZ1zHYkpl1yDdmBegQ
	 rzWk9gVuY/0GiQSeeItxyxbJtcIYH8eXSsJJYXtiO2s/NQ9+ypBne2WlgZMRWsOg8wJQJ
	 2Nb2UVcXgS/jNpKOMxV95H3lA8tfoMKj3cPpBgnN3VZ00DREVoDBdlhhcKBWdREkEcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2amZazKKLalsSZdiPvfObeg76WQh/qrsF14EgMPaGhU=;
	b=SsN2wk8czYxIbxReXwlOnt3JfHnGE8L08cOP/nbnjknj1VS0LO9uZzjaH+OG7V6Y2uka
	 1ENuAVDWIPYrtHzsVvLGYf+MY+5ppF5vhMWWjCJvIS3QYQxvzediwmTv4AC4fGkuzOpcZ
	 P2FlqQV2hFJGNW9SjXk1VFLlzlCpZzLtd+LbQOYTkIlPyTHq13wWRnXBEpG+hvpekbN1r
	 pxO5sr5tXTabJAx5LkZ3eHwTtKUW9VE6eGJ03LgPVZUIKkEdc4iVBxpIKnHc72eIW+WMI
	 bJ5lfmuXUIc8gXTDD7q6C13AuRilO1VXpOgrM9OaFxxuspkQU/dWun2pRVRShsRiv6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NAHpx8t1;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C6606A33F
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6C6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NAHpx8t1
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so7589905e9.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795168581; x=1795773381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2amZazKKLalsSZdiPvfObeg76WQh/qrsF14EgMPaGhU=;
        b=NAHpx8t1WZfx058Dx4xvrQlaILcQlZccpGy39MwuzqoOOYQJIHxmU45+viJw3cb7y4
         MVbxwj7u1kMUvj7wSdHKAXalPAgzVejYRiIvyoE6Udsu48DhH1o9wyGPmdCVk/xpgNP0
         3Yndpj5YofXNbcgflsRpzU2OqG3I4aL7Ek4sbADfl2tjYw389Za+CjtkQ4nRH9PAIku1
         vPU8yNbX/t63Y8+GMFb9UisfmM3rTFzdUG/s8oJ3l5/iOFS9YmxFz9q2jaI2nq95nao/
         v4rD1Pr3sQFCaZYIUgcL9X8PM0/0gAi5t46qnFkoFPAQofmb6emHScspBVp6Ta2A6XUI
         RyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168581; x=1795773381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2amZazKKLalsSZdiPvfObeg76WQh/qrsF14EgMPaGhU=;
        b=TfTg4hmFpAA9pP74Ji5Vlg6yWcDdhsrsi5cew0IbqC8sHIyR+FKrfagdOHpP0GYa5B
         mZ4LSv4kQAqqFf6raF6EaZNJtYkUslPsXZnArbCVqDbZkkHuXJ5jsVMiFm2Da0yRFVUW
         zRLOhU3Tq6lN91vF10zNUvUxSGveEOK0t2gAAo1upIbEvtY12AL8xid+n4Aivc18CeZj
         MpIMEiJDfOUDrvKN/fsmA693rgZmyDVBxz043Gr0WpY//fEef1vBO0uSzcXD8hubSd6O
         +GJCVun7T6zOdR8bPjr9cZeiYKRbuIARTn7OgWx70jb7gW+1YKWyP0qnSYjAPVF/vl0+
         eCaw==
X-Forwarded-Encrypted: i=1; AL+hErGTVGvpyzhr5kEH8HpctSFcpLOiTfWrHBYVaa1h9PfI04fN1CcFofy1C7ldZhYXHFhr+PKBf34=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PSM/Novyrf2+eglWSfoC87rdYW06Xk2q8PbabjI1Cm2AfskH+
	EsGI2uTZOGclfGqCobBLZHyyIriAMCcO4QMTG3do45oV6nzSYHEbgRRr5UGMnLyrIXw=
X-Gm-Gg: AYBFou0pbHIJwDIDvz+gj9dQYqOcSP+VuqGB7bCRedf9tb9PcAwyNCW8BaLgtuZrWeM
	JvmPn8kNa9E38V84J1UKfiPx+y7bCE2VREvh9t0jCHLkRMy4m/T2+1JzPsWP2llWixtsS0QYVBy
	WesQf3NDkg+tsEybjXP1Ktg6Z5bNjzvzIQKD1EAxs9+0NfLsAjyv4xntvEn70gt57sjIkV+9438
	DfZaKxSMXjf4K8fIbLu8lzM6pjt1LWrcmruMpmnFFymMDEk6smB3FiP1t2zusWWKg5HVwXxXfzx
	NAa/zIveOPFKyYNVXr4cr97n5KzzLkveAUeZELrrgbNvfIac5aIGwEc4aoiB5tDRSxCRX/X3JiA
	K6qq6Bmg1LTkmWNGFtKGSD/5vB2bMsVI5nO0p2wgkgXeVGenjUbVVvORRTg9lTZP7XSr2P0427V
	zI2CtK2+r1LrVuJde5VY18HvhC1eRMYTgceIJb8rrwLwrecOUwAazyXn/CZ9MdHpBvxuR3QN4AS
	4dX2hJjx1CjTLZbzzo4+PUEZ3G9Alz8eCAA5ZpyiZ43XAu47j9sThwnz87G/g7oItcmyS7meOWR
	vbjehwvNNtrbVwFpQ+4MD3KEepSS8pvoalF89CGrg4OUFfdhD9Q=
X-Received: by 2002:a05:600c:5303:b0:4ba:4928:8aec with SMTP id 5b1f17b1804b1-4bb88807d7cmr50159465e9.9.1795168581091;
        Fri, 20 Nov 2026 01:56:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm149124555e9.13.2026.11.20.01.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:56:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Nov 2026 10:56:17 +0100
Subject: [PATCH 2/2] usb: typec: tcpm: unregister stale partner sink
 capabilities
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
Message-Id: <20261120-topic-tcpm-core-fixes-v1-2-c753d1d286bb@linaro.org>
References: <20261120-topic-tcpm-core-fixes-v1-0-c753d1d286bb@linaro.org>
In-Reply-To: <20261120-topic-tcpm-core-fixes-v1-0-c753d1d286bb@linaro.org>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=otPFy8+sAdWYiXsyCF/s3Tty3teP58JpE75OVUEWQEY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBrABlCzfWiK8UvhhnQ+4ieSdK56C6hbkrG4+Ap3beZ
 2yDLOpaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCawAZQgAKCRB33NvayMhJ0UctD/
 wP8HW1ePSGMMTS006wGy0fgLV91tIrbQCOrw/N9WIjcCxlkuv5n9aHFEnHBoSGaDQ+neIXUbFHe3Lt
 nWbU5fNCK65PC0CjNwBx0/pVhASezq8uX7eYrsY3rQsV9QhUPVCCJsOH2xPBJvn+Aeys1xoQMU4NO0
 TGAiZ2yy29yZBYYR/VSzbiYcKyok8wq61iaZ6f7EgLoqWemdazVImw2uOYDyY/zutGb/lPhgt6UBex
 JdAdEm46PAeMl+TCIIkqjwt0kdYyTLHY266uhzHJZ7jyZJx0vibZrid2dJzLTsWye+NtX6zJXuHbNP
 aiEVMI0/l9DLcaKM4mK1bpYA4myYSaLtn+XJLIm3I7iZl+IkZQcMzdlvqqad8AKEEKWqKwtLl8d+Fm
 IvkqrBJeoSs25tpK+sE51l8FZfOLSn7WdddcFFefzXNgTiyGO+i1c5jnCU5OEyXIR52+DDuQTN26if
 iWVtnzHv73Mih/B4WqBW6i0lJ2sOAx6/Y1Y50wbG8MdAhWw7jUBLRh9Hd0/+jjP301nFARl/HdBJ+Q
 6Ky8aoSSofBYJCNmG73FV3139PAHdbz+xNJMazwNdgk1w2gnl+JynqHXsFQgnqvTlN9nAbFzrkpyfS
 EbUVnZKjFc1rk2KvN6jlPfjloblA9J5sGuW/LMH13vQkLvJu8tahPaz40BAw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

tcpm_register_sink_caps() registers a new "sink-capabilities" device
under the partner USB PD object every time a Sink_Capabilities message
is received, but the previously registered one is only removed on
detach.

sink_cap_done is cleared on Hard Reset, so the sink capabilities are
queried and registered again on the same partner: registering a second
device with the same name under the same parent fails, and the stale
capabilities stay exposed in sysfs.

Unregister the previous capabilities before registering the new ones.

Cc: stable@vger.kernel.org
Fixes: 8203d26905ee ("usb: typec: tcpm: Register USB Power Delivery Capabilities")
Assisted-by: LLM
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1d007e59a2bf..c5a4c0b6da16 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3563,6 +3563,8 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
 	if (IS_ERR(cap))
 		return PTR_ERR(cap);
 
+	if (port->partner_sink_caps)
+		usb_power_delivery_unregister_capabilities(port->partner_sink_caps);
 	port->partner_sink_caps = cap;
 
 	return 0;

-- 
2.34.1


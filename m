Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794B483BC8
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470869; cv=none; b=l2a5I4vZU9VSW38e4WDyJX1JOwQfVWTEzsplW8LrsW1+1vbOTstAyMkb+L/PPrszc14kHtTIWwO9G12zMiM9D66MZk62AiWHrGReOx7rxGNOnV4zKPgGT20YA6HcvfXeMyVWUNfaZH7SpjnodAfEf/zqVZfwe4d/IJXM07sdbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470869; c=relaxed/simple;
	bh=/oB6vaOXGg5+3zOLKgYNrRDA/rQtpvhIZtESt0iNrCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRA+9EHfouf79b2gLS8vB8QuxUoQq548AX7pKXEyO9plRLt5IPnylqzvJdOUQM+RnV4agzPz53HZxvgH1TT+2KhspjUA76dyfecStOPXt6dwDjA4fqnpkpRTTxS0Gz2g7to53si5kRUB2mouN65BEIxRKJrC6F5hqY/JJIf7cRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrFmsY8V; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrFmsY8V"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c9928a36ebso117757e0c.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789470866; x=1790075666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAuAan9y645zprFQBzGcUeZpc28nMxYe+p5U/JKA+9w=;
        b=IrFmsY8Vm0oNl1Slv+vA+t2gkkYrXCSzo7+aq4bNg73a8fCBGC62P1o8bRgzt42PAA
         QfDAm3zXPzDF3CaKfFaL7eiB/gUD7fvfCWOMpxqSVRPHo597txkiRUOmb2XZpfEIN6PF
         giXqxEPkPfz2X7YqXc8XmAtZCJuTiuUDlJp8XCNz98vbTFEnHAkLHj9mEKUd6ZapdDX4
         5iDyMK+u+ZyZ2hgx8+mMhm3zHNCt7FWw629UZkpfU7zKt6MsZIbS6/o0YKzx72Y5wPLT
         zZCpuq7WXyOQPFTyE3iLd/QjUb6VOMyIdd41mVFcfXFS2+mzy7knUk0S6kz1HDiiisj8
         CAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470866; x=1790075666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAuAan9y645zprFQBzGcUeZpc28nMxYe+p5U/JKA+9w=;
        b=J/m3K8YPHxHGsi+FTpa6XHpYY3Xeh0UMCwC7pHzbL+mZiE6VpDPOSPfCirUuSlXAV/
         a3NI5UNHQMQRv1I3o58IKPjHjeW1T9awMSBtRIC0INLy3rrv8DnPTk2bBRZH7vXJkK0O
         O0RQfCo2w51ebbuz8dZoP3wLF8g8Z25kOuriQkTcTQYNCk7AJc6LkRDRg6viUw0CN/D0
         jzCiRAE5+G59ZTJ1ScY1OgGPUQy/a0flJayyrzEAxBbYrrvNajyj9TLKIm63DsRAlFv+
         mGGEvlN+wnHMbq3p9doPnUzN7viRtCKnN72QLSKg5xz5nR09yLFkww2s+ctY+u/Ely2h
         +QFg==
X-Forwarded-Encrypted: i=1; AKwUvBxRPfJYlT3jqzQ7WlgbtealTIkFXpawbuRnH/rmTcP0gKqIGpuHbwByy4w+bO3uev8FdOONFbE=@vger.kernel.org
X-Gm-Message-State: AFuF++lzaISx/FYSCsRjwPf/30XfIIyOfuWzlC0EcV8lRuRk23JVy6cA
	wYislV3cdzh5/N92CKwuhlghxInPZWM9UlGP9RrojsjCBvbSmUoaitCk
X-Gm-Gg: AYBFou0Qv/efRlmKS7u3e4a5KcBcybEZlRfVpwGIxZPOncm9FRhzII1kpT8aoxfoszv
	aV5uWR5J/B8ewy5yNPa6mTt0UWXtj56SGcgny6ekyLjSWK0joJ1XyobzMXaWZUeK1MpAWUJpF7b
	PoSaQv2xBBh/L86l1oFLQSMQFyzH3KdXbVkZ3Q7JMakeiJ4xvGRz39P+BVHxefP7MQvGnrZww8p
	5HQBSvWES69YNnlYKciKomSiZjIiriLViF8oGc3pGQ0A4L0rYaksr3TW6SKNrgW4tvWUmGrjtvU
	6rdTNduNKCMSWeTlzcl8TMysWNzt22niCB9h2Y4YWq8mens9JqThJK6DAORV6L4qCuvJ2zH6VP4
	ZEWee6ZdYMYuhdW9advU4Tt7DCyGxcCag5oviZned/Ak/v+sbOMm2rj1L6eTV1/Bm/UUcLk51nl
	OGu2RlBoKFfrp6N6ZfVLEzSsr8vapzU86CiEFg2BdGYb09Npr7nQJzx2ht/CoL3yXW
X-Received: by 2002:a05:6122:894:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c981d87e33mr4414877e0c.8.1789470866398;
        Tue, 15 Sep 2026 04:14:26 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c846f76238sm14577407e0c.2.2026.09.15.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:14:26 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] vsock: preserve child namespace mode on an empty write
Date: Tue, 15 Sep 2026 08:14:17 -0300
Message-ID: <20260915111417.2726515-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vsock_net_mode_string() returns success without updating new_mode when
the write length is zero. Its caller then reads the uninitialized enum and
may permanently store a stack-derived value in the write-once child mode.

Initialize new_mode from the current child mode so that an empty write is
a no-op.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467..61163357ae 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2878,6 +2878,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	int ret;
 
 	net = container_of(table->data, struct net, vsock.child_ns_mode);
+	new_mode = vsock_net_child_mode(net);
 
 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				      vsock_net_child_mode(net), &new_mode);
-- 
2.43.0


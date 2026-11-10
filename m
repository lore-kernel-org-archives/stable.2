Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309257;
	b=wWsXaED5R95FqTR9f+gY2KFfsa3wokjPvQkhUDfsKzTJShTrk703xXbTwBJcPOvwEReC
	 CxNgPBwhC8FrcKB3cY28A6EKBMFqvLhTibia/zucsFnR6BHb3BOmqKpK+QtVUScWLI00k
	 a6oQmamWtDJ04Ak+eBnv/YGpGUVUZdw6OTr5DYvdsONeYcYA9M/AlZ7i+ui4JVjURBRAY
	 RvNHw/YqV6/lOHlrm7xvy8qsNE46QIEhJbwii0iJLGIyWfvj1XfwfAJMyMBlXvkW8f4vT
	 0aXD9dvIgoid3212HrLFwWksmwm2AujSnxgupOv5+cW+FlQrO+F6FjpWenIJMCdEHlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9cmPq1xovx31wY8V3YqLuXzHjOU/A8Tl8hkT2pJxDB0=;
	b=h4xymAynBhlB94fXDziOYYh4XH5/PYVr1z49MCH8wN1zAL8pkMeg0VoLxxL16FRhluK7
	 IR1f6DoGgSlBH/HDwJVYnBS/MStTtBicDe7ysrrMxSIw03w4B4+ghicnViqLugwFi/I56
	 fOmaXSsCfk5i0o9Q92sonKVfI2b+E3c1GrwfSPrGmH3ovExQqYHfa3WmJqOYxwYO/OdiK
	 PBtliiASbPIHw2OBcxStpGF6XLyWHSoNBoa4NbS+cVZGslxtMFlnaK5nQ+FJNfD6bLosl
	 rZ8JSsNBom78fCVrxiphY580YgP3prBaztjuwl5dJPy1ZxI4j6bt9DqS//3x6dD3mHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=whEgGqij;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049C606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4049C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=whEgGqij
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so3106554eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309256; x=1794914056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9cmPq1xovx31wY8V3YqLuXzHjOU/A8Tl8hkT2pJxDB0=;
        b=whEgGqijQSILV6KrKPrl7DR6X0Hr8ZyZ0F+U95wxJ5yN553gCfwFMIILJpN1Ue0c3+
         DyAwDdzrXHajzSVmVDGGWiKYcfVBffIovDms+hLlDkIsNjua0YbuJKkAf/u2nLzZAANf
         GD4YqVyXjmiWIwusmBt6KjrGLsqg3BklO+ipkyBexKh32346bos5/CPbYPH1CwmcEBIU
         g8n9/jMTecJ5JzfqiB3BBg+CNz4Jr6iseEuQXSdPl9H0nDgj7IXbQUNeuCkP7D/NXnP8
         1kuEVHOCbN7tUqWaVlqHkvYdB9anRnflK2zc4Sar7uK5mnf5HrjtP5nVx1JxCyx24MDL
         IpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309256; x=1794914056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cmPq1xovx31wY8V3YqLuXzHjOU/A8Tl8hkT2pJxDB0=;
        b=qAZ7aShqzUFIQLK0knywORoFFewsF54yGMetQKg8JF7SAI8d8Uh4+O9v9bXikq9SPA
         jbEGjh6WWjcCOew5flijq8ET9DDZIOQHJXFstqtINI8rnL2olkFOLXGPqRUKXSZucGCg
         8RklkMcqabaf2+TIJSh432yczWnWJysLcn8RWIO4t0WqXSK0RscQz7PzDbnV59ubE/CI
         gbI4V+QLBzXj0OBJcYMbrTqXs7kal6eIgyYGaRUuJCOA7nB5JUAy50NzG2S+vK9qVAXB
         po0DTU+Wk//CVhyMQX6QAhiVvQCPRPmb/n4xOkjhKfPD+KFGvRMXu/QBnoeRKjfYT4NZ
         dZCg==
X-Forwarded-Encrypted: i=1; AL+hErHsyEaKbn/z0D4kvq3xLf71ht0PjubpuYv4cUZplBP4l5EX1A1Gp4WcYEngtc2IhyQ/P2L0xh0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UUrX3Eik2K92T/V+FsKBTYDF72hSwfdRINEQEVS8h2GuEumlk
	SxvZBsoY7NhcIMQWfqimeUgd9pBmb3vorXQFDMAf9sb5famsg1kF4niK
X-Gm-Gg: AYBFou177W+vUJzyxKCgrQ4+fgfigkkrAf+JZcSke0I2fl9AbXIfeR4AFL3s6l6W10i
	iXxygQ6cdVlT2vyshd/ANVFsXnt+HFwAbCNktTYrd0wzTkhEkAm5eRKHM+pIWftoQBY9p1djcAq
	EFzSltJ2Kbm7PeJvuFNnEXA3cVNfvtYPJ7+tFWiuwocsaTGSoWuXBjM/6nvpoZ2U7qHUv9+v215
	IYPGJFe6OmlTbYTPYZq6kcI7iZC99oQ6lslLT1uFFrdbeVf4sPksBmUdbRCEWJI9iRKzxA2cCRQ
	H11oelyfkqZONFBOdBARwinKt4jI8bIZ8srhkSf/fGhi5WINZ95aAiG3Xmum06n/n7hfmy4JmZt
	edS1kxGVJhDrxJiVtCU5fBMa6FeUh9YHD9v/qyhyz6f9qOnWot5kahOxAnYDDUP6XFL1PB5uBaL
	kgVw5EShVxs++LP3bt2rAAuZ/IeqQixtMZRbIHPRdkjuOvlsxaGLCYexNtqRL6DQNeJSmi3Q2Mu
	4ISw2Ptrtv+8eadOLFqlf700F/ekn4HbPJmoxt6kw7cfZiE7hEG7aRMarUDnk3ZxNPXqzKL/+gH
	oZ+KDu2lEVrxJO/kqp7IBzvDlpG8DxJOo2KwMJw5AbCOrtK7Vg==
X-Received: by 2002:a05:7301:78c7:b0:375:87f5:ccee with SMTP id 5a478bee46e88-37587f5cedfmr1886929eec.29.1794309256012;
        Tue, 10 Nov 2026 03:14:16 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm5908119eec.3.2026.11.10.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:14:15 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] usb: chipidea: core: cancel power_lost_work on removal
Date: Tue, 10 Nov 2026 20:14:02 +0900
Message-ID: <20261110111402.2504885-1-hj351016@gmail.com>
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

ci_hdrc_resume() queues ci->power_lost_work on system resume when the
controller lost power during suspend. The work (ci_power_lost_work)
dereferences ci: it touches ci->irq, ci->dev and switches the role.

ci is allocated with devm_kzalloc(), so devres frees it after
ci_hdrc_remove() returns. ci_hdrc_remove() never cancels power_lost_work,
so a work queued by a resume just before unbind can run after ci has been
freed and dereference freed memory -- a use-after-free.

Cancel power_lost_work at the start of ci_hdrc_remove(), before the
devm-allocated ci is released.

Found by static analysis; not runtime-reproduced (needs a chipidea
controller losing power across a system suspend/resume that races unbind).

Fixes: cc509b6a47e7 ("usb: chipidea: core: handle power lost in workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/chipidea/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 3461dd7..400e4ca 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1246,6 +1246,13 @@ static void ci_hdrc_remove(struct platform_device *pdev)
 {
 	struct ci_hdrc *ci = platform_get_drvdata(pdev);

+	/*
+	 * ci_hdrc_resume() queues power_lost_work when the controller lost
+	 * power during system suspend; the work dereferences ci, so drain it
+	 * before the devm-allocated ci is freed.
+	 */
+	cancel_work_sync(&ci->power_lost_work);
+
 	if (ci->role_switch)
 		usb_role_switch_unregister(ci->role_switch);

--
2.43.0

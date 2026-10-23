Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779550;
	b=Xch99KNT668dqRTds0vtY5jrprH1QbZaps/zDPf+8PzkrXx8GX+MVMIa7rYtMJZ8acJI
	 evlyajUgMg9ipgdpj/oQPfVdlkeIL4xTzAfaTwuAVXbwZQoqzaW0j29QMIX8yjGCd2VSD
	 NZ4zYLYsW3KWr0/YWhUMsYrEjT6g2FKENlZrUc39hYZR/ChSoM/LE7riiCZOWJumNDLdj
	 OPGvQlaZtC2GrQBHYwl8v/VBPxsk9r398IdqFmmfC5/egv+08F2uqomEspaQP4woUd7ud
	 7nyOsoCeC/a2DcDWCsnTO45sCsk1q34OYLISY1qIQFPeS/sQiLQavAf2Onr2l/7YjXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jTqLA83kbkT8YosbSMCS7zXjw/VlllCMxeIzfWZ/V6o=;
	b=JpYEAE43i+QwdHS8zHgiV/FflU0JNiJSjfjNXGLCx2/h/e9EI9JUN2MJWSIcUAtaV4SL
	 ZEMCbS65g6EFEVkfzL9u8GT4PYFJHY/BYG7N51Jdk8XKq2tr+eaYMCUUt8UqHC7kwJ2x7
	 eOI7I9Q6gcc4tcnuh/7PNGkL8QMyEiVRgeQFr0iK8RjkSOv+barYrB3qn0Yo+7iTznacA
	 SscF9pJm4fNdz8BbSKKgn6uDKiSeqerqJvGdrhaqEJA9h6xlw6YGKDoDL7q2BvV8voQtT
	 Cxa2hW6ICrpATUx8Fktd/3xxlMV4YFkd+Bej9adw62WqubJKifZ7nr44nX2poh3zxmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rdrR6k0O;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB0606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBB0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rdrR6k0O
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f20b304c0so104735885a.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792779549; x=1793384349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTqLA83kbkT8YosbSMCS7zXjw/VlllCMxeIzfWZ/V6o=;
        b=rdrR6k0OlUKzqPxQyJiYbBnrQkgZ+qohSF3KF+C1dXPgNSxeScZEznfJ+TibVoEKV5
         to9TBc2RzIOWg9K9asy1HxWi9y3AQFTbqMbHsUgiISJOqSttA2M3xodgm32bJotPTKIT
         YUv8m5jyEfEgZDz6UQTmHlBqu9gb0sYxWtK7TUcXYeOC7suawnsVYjxz/FqrVvCfCUkF
         bS7ljpyDKT3gS7sE0G73EqWq+QvmHHRGRugfFYQ6YC/PuV6QiWY03BSXx3+mS3yp7PpN
         644Okg4fAmu9mjV7aMfThJ325ww1rMmXRU4V73huK1nZNYrY08LYNFSsBOa60Qz/vMaz
         hvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779549; x=1793384349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTqLA83kbkT8YosbSMCS7zXjw/VlllCMxeIzfWZ/V6o=;
        b=GOD/P7cUzlN0MM8buYNpmLgC23yJ1lp0RnqiBKqOZPF1SwTV4vHe2I3vH5k1hN1lCr
         wRZWc7Q2Xavc2/9YawnSlafcAeYunvoFKy+6w2mCkoUmLbhZoLqLzAc80yE+5Twb9UP7
         SIgOx7Lk3NXEl885gdXXeaOtOr96PhRzgwtChyNySOlU4SB6gIX3AWKVaKgUfS6vh782
         cYxO4FqWhVMc+rIUrFbbQPWwZn5elZUVN8SfjM6v6KbfLDZhFGJ6/yn7ZQSCrcn6oLo0
         vtbkTAr7N9HF353zSOx6yMn4R1uF8YiCfjgRoVyxahhmir+uLY5fN8jKS8nEQ5I79pCG
         izRw==
X-Forwarded-Encrypted: i=1; AKwUvBwIuwpz1pwNvB8kJyTvR/9KgxBJ5vQz0VAsevqV4vr1+fJTldQCyW5hPPD2qbujv6Xt/BWGGYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLu6jcuucZZ4LWBwlv6lWPbi4/XrciIYXDlRUtQBbwSEi5PJxbE
	vVX5yr7JUgLEEh25z16uYTwhFdW3rahk+x494ErD5pv3s7L9XrKc3frH
X-Gm-Gg: AYBFou2+RpmhVeI4d1Z8LjMgRELM+c/rIol6s4126L56GyQEEPuL7ZOrfTQT+qEoJeK
	+MeMtkgevO78RWOW80gt/Sm54rY/zYtH0QpW5txI/HOkDILFQXuI12D467YsdHuv9KfAnh8OADf
	c9bP2a2vA9WHbAEjZAEJrolw1I8RkZfYqzmJOcAsWd3K5Vvnx5duqPluCwLVshInIr94NG66lPe
	8Vq6IpJoMICFe5op1fF5NExuWyhhW6RgoTFGhimBS+Y4QuafOC7NVQmFj/YECsEp43ofVUmhCzl
	vhZVYPFkYw/1vn8QX+ZrrcdkWStYeuEHaYBHFwu8MKIdSdT2RtNQIFW1ZNAla/EDRyOAthCHvqj
	+key3gOfuXcHFiXBbHdDmlOnU5KKKIY2LomdvyPn5feqbIm1lG32waota65a6gbZHqtB5lUafco
	c1clTgOy/w87iUO9rkx+6EMhrWihHMLEslsQrybPw0NC2QuGTxIJ4435SbflbczVBVM8YzvTLkQ
	dTWRHs2ztmBk06EHOume4OOnpR69EhDPuFdKRaWbwWvzF5GmwRfMWqEPbUPYVRQYjsmrlTk5V1M
	mmLAhhW1NQ==
X-Received: by 2002:a05:620a:439e:b0:93e:acdd:acd9 with SMTP id af79cd13be357-93f6f79e2a1mr550689285a.7.1792779548875;
        Fri, 23 Oct 2026 11:19:08 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b1c97esm80339485a.30.2026.10.23.11.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:19:08 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Rui Miguel Silva <rui.silva@linaro.org>
Cc: linux-usb@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: isp1760: fix use-after-free when kmem cache setup fails
Date: Fri, 23 Oct 2026 14:18:57 -0400
Message-ID: <20261023181857.114054-1-shuangpeng.kernel@gmail.com>
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

isp1760_init() ignores the return value of isp1760_init_kmem_once().
If creating the isp1760_qtd or isp1760_qh cache fails, the error path
in isp1760_init_kmem_once() destroys the caches that were already
created, but the global pointers keep pointing to the freed kmem_cache
structures: urb_listitem_cachep when the qtd cache creation fails, and
both urb_listitem_cachep and qtd_cachep when the qh cache creation
fails. Module init still succeeds as long as one of the driver
registrations succeeds, so the driver stays loaded with dangling cache
pointers.

When the module is unloaded later, isp1760_exit() calls
isp1760_deinit_kmem_cache(), which destroys the already freed caches a
second time. A controller probed in the meantime would also allocate
qTDs and QHs from freed or NULL caches.

Propagate the error from isp1760_init_kmem_once() so that module load
fails cleanly instead.

Fixes: db11e47dd7b0 ("USB: ISP1760 HCD driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/usb/isp1760/isp1760-if.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/isp1760/isp1760-if.c b/drivers/usb/isp1760/isp1760-if.c
index a64190addba6..bf33289bfcd4 100644
--- a/drivers/usb/isp1760/isp1760-if.c
+++ b/drivers/usb/isp1760/isp1760-if.c
@@ -274,7 +274,9 @@ static int __init isp1760_init(void)
 {
 	int ret, any_ret = -ENODEV;
 
-	isp1760_init_kmem_once();
+	ret = isp1760_init_kmem_once();
+	if (ret)
+		return ret;
 
 	ret = platform_driver_register(&isp1760_plat_driver);
 	if (!ret)
-- 
2.43.0


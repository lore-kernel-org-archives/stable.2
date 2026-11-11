Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383529;
	b=eCi/eOC63QAdxWD8RkMJ2MtJSgam9I77CItIQLjqa1DalfqyujpUXjgStiREDsnAc3Jj
	 7joM+RNrz1aWJtq9mszZBVsC1Ys/2hm3gZGfYroRRQcz8nFaqyI3S0pnVkovK0lfGJ0Ph
	 xu1h3ZZRqKzkPFXzdSZRQTgCwiDplLejNd23wA0gFTa+nuKVDzCW7c8F5vJ7J9JKcFq9y
	 va11F9jEbRVNAR/ynOcO+z2T+Mouv1OeC6qcCJXzhkMTOk2fPnOkvYRUzAVke0b+RBeJF
	 ZDUYci8IT88q+vky0m6XRLQ5SZ/FUWCOQ2sLh9Wfa55Uq8hXnMYgn8g1unXqPZyl2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uZIN4D7jbH1Urh+LOeQa3/6TVd5EZ4/PM32bHYfTJqU=;
	b=bSB2Q5E+3CPGJxyHdCPFOPV3by3cYmz53CkGn2HWJ89505LFDU+kSrgAJyE+QihHlu6L
	 qWnwMnWabqJRLuW8huYSIzCrRwzHg1rW1P2A9mNm++Qhj0MTX+XVW+bWICGLBmFGyvmXA
	 DSrBoZ2DI4myEQj38KGvLORWuik/g1AarT3qpW63MDuiEACReLBCwhf/PmVM4vQmEtMBl
	 lf5bksm3C6UwOXSuBS2qN2lR8GbBtx5vHTfgXmGe8lg9l9pdUDPcEbk/KhT9cUhvu2k7Q
	 Aj8VIPgBAl6Yce1VL9jLms2dstjQ97tKfRa/wUAz9kqjy4ZSlz0Vi6cCwIZlF7HyM1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mozVRJlM;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90899606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90899606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mozVRJlM
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so779927c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794383528; x=1794988328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZIN4D7jbH1Urh+LOeQa3/6TVd5EZ4/PM32bHYfTJqU=;
        b=mozVRJlM7OGbOsRObxBDXtbtLpVd8WFZ2Nbx/PZPECiiYobK4Jq74y7FkD10otMWLf
         fkic3pPMkYhDiOjfooRgOmv4xOmC79EJuziJtQzaPS4JrvOREtk+DoCLT3rjPebXMx3W
         MEZf2qmv7Aynt9nAqI+NVPCFLzwxPcLhTxT/CIiiIisLDMrlx+SJ2hTMRMkRwxWuzmBX
         Jpzb6Ps4id/RbCnDBzCDc14wXolo3dJwcc6ucPReOy5UshTS+hxq78v/Q8nEEvFeNY9O
         jLR0W3HzDgvkPLnBz05ffXeRhnQvZPfdWlMugRUg07DR0GPY679oQsti0XbAiDkozUj3
         rUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383528; x=1794988328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZIN4D7jbH1Urh+LOeQa3/6TVd5EZ4/PM32bHYfTJqU=;
        b=cUMfaNg++j1Xks0OH/v3o2em7hMAyoZ8ovZY+XSqRkj/fLGFoeRFKKBXQpZ4LPEk6X
         wzNeoip+MMT7KRyJr8WSe9wScF+jHPEcKfEGBdV3vFfbyylrKNGoMV4Fd67spU6Q7SKi
         elcgZFYlfav6YAuqLjh+C80mPxGadGr8gExMAb0XKBIp4n5UHJf6c+UbftikkfW+FfCe
         Nyt1KKNjtB4bHt+7xsATJYo2eiSujVwfpxSMVWEWP1Ro3M65EUtWiIZLt5fNPHHyNzfE
         qThzTAkJWiiz10S8MdNGTfuKVGQluIk92OD/zykXIqenNVQakTvkpjeF2OH/Df7M3BTP
         KoSg==
X-Forwarded-Encrypted: i=1; AL+hErGTfqri45ykZTR/xcLAmmaW+n99CdbnVTqiOAfVsX5osn1J70n2MtHp6b9e2Go6B62Hy0mta1U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+za7KQ55YwXm9UatawIF7HzxvJzmLGUaM+2Qx1DsIOhD9jM6RG
	ESr9maqPMHTHDmMytdYJ8zy00vqsIbzBRjtaiS/T5rrgTYKQ/au0FwtU
X-Gm-Gg: AYBFou2yjRlmIdefN3VE/ck+fMIoHQGxjB55kWI0k2Z6vbn313wQ/CtoarakKMuTGE/
	D65U3uCPGdwxDlYZ+uxR0SIdFbMWy/FnvgfBsk/YtgSSElb+WkTofM/85hbowJ+W7spdZKPbCNV
	20/m9p4vbLVbqtHYFPufSvmJwh6T/0wPRIA9rpo7WQ875NFsNlvS7ksikXXNCh+HlSNAEwfsMfK
	VNC4utx4R+W0Pzrt9TXTFE5qtzgmtQyi4jE1W3tfXCfyXJCWf4CADF+5QwXlS2MmXe6iHA1VfzL
	RiuX1+4EMR1Y8jW9tytX0vRjmhB1+arvHCDsj1EPSUHmlHNTOfcbPhqCaM6sjkPpTjRISbwY18U
	4wJa1yVhiKTaqcRSnFhseTV1LiOC8YA/h0PmV84+3IlmP1FV8MC+VID+PWY/td49IcS2iGDb0Wp
	3GqCaZSAMcbuklyT8/xeELfMpXVy8u6NBXiRakWwjXauoJvJPz6lxZvhzb/IwQloHeKvHq6CFce
	wEQDHXg2ipWrRLUuQ9kNLqJHRgY3ZnVp5A/hveAJErkWi98bljcHy6cVqB5OPPfo8KnxvIPb/EF
	AuX3jMS/wlNO6DDoYmSpUpIhbEbaeikwn/25drEDsw6jyYJP
X-Received: by 2002:a05:701b:2302:b0:1b3:a26b:8b97 with SMTP id a92af1059eb24-1b3c0353171mr1674179c88.41.1794383527293;
        Tue, 10 Nov 2026 23:52:07 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm11284950c88.13.2026.11.10.23.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:52:06 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jiri Pirko <jiri@resnulli.us>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtio_pci_modern: don't sleep in atomic context in admin cmd submission
Date: Wed, 11 Nov 2026 16:51:54 +0900
Message-ID: <20261111075154.3017978-1-hj351016@gmail.com>
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

virtqueue_exec_admin_cmd() calls virtqueue_add_sgs() with GFP_KERNEL while
holding admin_vq->lock, which is taken with spin_lock_irqsave(). The admin
virtqueue is created with ctx=false, so when the device has negotiated
VIRTIO_RING_F_INDIRECT_DESC it uses indirect descriptors and
virtqueue_add() allocates the indirect descriptor table with the passed
gfp. Admin commands always have more than one sg (header plus status), so
the indirect path is taken and a GFP_KERNEL allocation may sleep while
interrupts are disabled under the spinlock, triggering a "BUG: sleeping
function called from invalid context" splat with CONFIG_DEBUG_ATOMIC_SLEEP.

Use GFP_ATOMIC for the descriptor allocation that runs under the lock; the
table is small and the -ENOMEM path is already handled.

Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 922e2df027de..ef96140118ec 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -101,7 +101,7 @@ again:
 		return -EIO;
 
 	spin_lock_irqsave(&admin_vq->lock, flags);
-	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
 			spin_unlock_irqrestore(&admin_vq->lock, flags);
-- 
2.43.0

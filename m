Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743275;
	b=BUf9v4ddRPjF9ek0o0EonbqsN4CG/KuQZIH50aqZ1HxMW5aMarFahar87LuKmOY3Qlwp
	 CYq50rM2L6V74NbiWaVqiYZqqV2GbXR8dRSFsTfPf4ekwuS3RE0h79dvpJdmNlIrxMBaH
	 eLQC71Q9pJLw/6RfCMm2Dr9rfIYoq6ZbOfKWqPOBZ3i4/jI/Bh/U752ATFPOr7Z//euLV
	 B4f6SpfnWE9jvY4ZA+5VQ+BSZHJzqWdt5zBgID0kKT975JAgY9OeqgtOueDYos97Z/nUP
	 RLCCK38NQlQTTjTaEPxuwQ2bNnVvCrCqIRvTQDQCVxXkxfh/+x96BOf4taOnE5fwlCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743275;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=6f2sASHFDTpQp30NDWOYVGZZ1kdQ6WO9ewogODjhD6Q=;
	b=rMia+NLdcX2siMtVhTJTw/R1AYHITHedr0HCgpUk09BQmZHRDRqexLAnjNR8u4XAP9P0
	 vyICl0vpoRfFcn0JPQxxekYHLJ1dKb6blOQhrzTnZrmURRHdGcEemO6vh2nSAl+xxAs69
	 Wce32HohiFdWy35SK9aQelazKWST914YaV8FV3Nyj01GlLyuEEOyVElr6v1PkhguOF3DR
	 LP7fhpDPNLfhORApJKAYZsiqmNHWv9gpOOievVrnL8EB5h3YuA4veKjZOQ7uwRTCbnOYt
	 Y//jV2Ki6vQ5N6jK8sAntOKdGXKtmZ4KfL0qFEEBiG1obLVojUaMHfe9tw5OkV9CNYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=LRBrxkMT;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D398606A338;
	Sun, 15 Nov 2026 11:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D398606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=LRBrxkMT
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04d7;
	Sun, 15 Nov 2026 19:47:43 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Ilpo =?utf-8?b?SumQqeeeqHZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Derek J. Clark <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Rong Zhang <i@rong.moe>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2 0/2] extcon: synchronize all-connector removal and fix
 Lenovo fastcharger teardown
Date: Sun, 15 Nov 2026 19:47:40 +0800
Message-ID: <179474326098.103840.15531040789536968458@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df08e10703a1kunmbac61c98bf76e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUpIVhhNGEhKGU8YQkpOH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=LRBrxkMTJQiTIXvV+FwesJO0vwnpIXE0A4xzedRHk3fz94aXNxIROY7nqKLdWjbh1z5VoOuZ8O1P6LH7lVCe4QAtRAVfKTylaPWh4PJiXblC8sDtGqLoxGDwR+nb+BiXQ2WCsL5K6C/N15zEwv4PKPjLm53U4PxoMzwstBOg4UE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=6f2sASHFDTpQp30NDWOYVGZZ1kdQ6WO9ewogODjhD6Q=;
	h=date:mime-version:subject:message-id:from;

The Lenovo Yoga Tab 2 fastcharger driver releases managed serdev,
pinctrl and GPIO resources while its extcon callback can still publish
work.  Ordering the devres actions alone is not enough because the
all-connector raw notifier does not wait for an in-flight callback.

Patch 1 converts only the all-connector notifier chain to an atomic
chain so unregister waits for callbacks and is safe from interrupt
context.  The per-ID chains stay raw because some current callbacks
perform sleeping regulator operations.  Patch 2 then installs the
managed work cancellation before the notifier, so reverse devres order
stops the producer before releasing the resources it uses.


Hongyan Xu (2):
  extcon: synchronize all-connector notifier removal
  platform/x86: lenovo: cancel fastcharger work on detach

 Documentation/driver-api/extcon.rst           |  2 +-
 drivers/extcon/extcon.c                       | 28 ++++++-------------
 drivers/extcon/extcon.h                       |  2 +-
 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   |  6 +++-
 include/linux/extcon.h                        |  4 +++
 5 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.50.1.windows.1

Discovery: found by the author's in-house static analysis tool.

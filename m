Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C67327C09
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434679; cv=none; b=OJEjNPMJm2+FSum/axV/xee88ummo6YIsK7+1e0Zxplz41oQKjwMNRWoSmXPv+yhMCo/eHN6THD84pJY3z6aP0J1+nAgX9uSVxrPuDgzlr0iU/YqLS11KQYdMwMAy7ycPRFI6V0gx/7EWFh7RJVK85ArSTdj9TK/8RG19lhTa6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434679; c=relaxed/simple;
	bh=RthSqZf0DDbfE7GqRv1mD8ZLsDt8tj3LzD0j2X4Sgvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJH4MPnXChufFWmlK0byHf9jCLMt1EV/rxq4R3X83uuJ1MeaRsXwK6AMioh0VVCknoIvSOx6Qy8ekZS+PTtCn907Avntl8TFA5HfiX1O8W7Z57JwiWDPmlUOGQ24RxYkzCKX5Zc2ThlfypE0SDI2h5E2leSns43pEhC3wMSMMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNdCqk0H; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNdCqk0H"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939e59ff27eso377373385a.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434677; x=1790039477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAKtLNOJWbVnxDBkVZ/0uqO6Tw1qnmXMwpf6IStwoh8=;
        b=sNdCqk0Hm6ite7Tx1oZ/hS/Gvw+feC5ZRZA3nzQvfP4jFsKaUOXZ5w1KhY/HkoftVP
         spXdVOSc+hDKavpA0FgWewktQDR9zvpTq/Ek9TJKZQvrlf/fg7ohiotkG9dyLoGuNf5y
         nKTJDNjcfbcFnufPipL0+Df31o5Yq1Dru7RS7jnnuByGw2ZLevFLInyTYWJw4/MuqYaz
         tHgABrPuDT36jErffc2Zyblia/5AQ43P54PDA2tShVoz+mX7cz10dg9ghkDUiHS8cYM5
         dPhAg+bd/HoxmrhSQOMkAAlEMTenp5MbYtGLo4w1EnUgE8oNgl+nvJMO7cg/vKbiBKuV
         XK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434677; x=1790039477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAKtLNOJWbVnxDBkVZ/0uqO6Tw1qnmXMwpf6IStwoh8=;
        b=ctknbwyMUxo7nYhdPvuD9ap6NwfGtKVUeD2VBcRvK8s/Pd6RWPPm+yQfnnMqQgkW7L
         k/1hqixnD42iTpDgyKNCnkC09mt/XZuU3L8tWYa1oMevkl7nm54QtpuuLNl7k+QUm37q
         0w+xIPaPg7SYzRt2PQkSYRGVAV4CHaO3PGb3n62ahKnTAE3jE8YD9SHOeRgjuyTj4JkW
         ZK7MgCkWbuGDFE6eCqbqm3z3cN7u0Z7UxB2bf9JQtjJhpZFnVjhW2GNjT+6sO10ew/KX
         ZW/75uy123gWF7xbmri71xT/DkdcWJiuAwnuoiTM6iAxy/Xd1eA42y4kXlRi7P127a/C
         jvWg==
X-Forwarded-Encrypted: i=1; AKwUvBzFobkM0lLwT8JK6NxJ/uLmTVF6z9Vl7YoU7RASggR4+L5EWFWOD+HGc9vxQJHGGtGRQ1RC+vs=@vger.kernel.org
X-Gm-Message-State: AFuF++kp1w7kDCMtKBvyNmlXVP1jEZ8+WCzlG6k7y78iPtXGwNBUh+Q+
	fI+hPKQPzyngQ8K03yCP+Kr5/PwFbB6zmGPo2augHoKgqY5uFYm9nTU=
X-Gm-Gg: AYBFou0AHX00If9afFPdHCXSaUPg//m1qRL3i5f+GDT2P+epHzahVRWvzoF/Rq0rWEV
	hp9fXxTTQkEOw266oCBhlqDZKdcRA7PGmH3wwGR9NRTluroEId7aclTGFwGr+3AV7eQIcxJuH7x
	lgcYN1QKqzHm2zvq8gm9r2fWX2w4KI6SJnAoo36PV/vmR97cQ6Yd3d6EWLd0t/waIXNdlOc9Op/
	4sDCzh8f2eyGff494N9iVTsQPIYh5ullKhGNB8V2tzxkzk0UPaU2In9HPr2MymARjUPhnUluW49
	lx0oOBmG40T46rAOfFDoeR569TAd9aOkQyTphstGczRJCqjZqRZiPtfhz7ihrHHWidFe6w+0jax
	rxajEHrBd8K1jFM6bnb5VAw5QXKzqT68/zbCWXwLNfUx6ywpww7HwgX062cp/5RYfe4HfbCTDze
	qTqTCC4x1QOYkMaLJGRevZzF5t5eU/dAVKw5NS4QH15CjwfA6UMkxbzBBSRDG898xQxGphbBhPD
	82A5OkZOSiXqDavjre8yj0BtYsUtzgRVR9Dx34AH76jW3D6vrKBCGeQKVT0az/TBh+2rroRUA9Z
	xowur/pSwZ8DwWvfnAocKpT0oL3rrnp47z2662P1ZQ2CLcwZ2vA15pjb/gli9IS0w/Mv4iU=
X-Received: by 2002:a05:620a:4555:b0:93a:2e8:5afa with SMTP id af79cd13be357-93a29939a68mr737739085a.30.1789434672383;
        Mon, 14 Sep 2026 18:11:12 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e809fd0bsm1118996885a.33.2026.09.14.18.11.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:11:11 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: tw68: balance PCI enable on cleanup
Date: Mon, 14 Sep 2026 21:11:05 -0400
Message-ID: <20260915011105.56149-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tw68_initdev() leaves the PCI device enabled after a later probe failure
or tw68_finidev(). Use pcim_enable_device() to balance the enable reference
when the driver is detached or probe fails.

The managed disable runs after the managed IRQ has been released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: e15d1c12c587 ("[media] tw68: refactor and cleanup the tw68 driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/pci/tw68/tw68-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/tw68/tw68-core.c b/drivers/media/pci/tw68/tw68-core.c
--- a/drivers/media/pci/tw68/tw68-core.c
+++ b/drivers/media/pci/tw68/tw68-core.c
@@ -228,7 +228,7 @@
 
 	/* pci init */
 	dev->pci = pci_dev;
-	if (pci_enable_device(pci_dev)) {
+	if (pcim_enable_device(pci_dev)) {
 		err = -EIO;
 		goto fail1;
 	}

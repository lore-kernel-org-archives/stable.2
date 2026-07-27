Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549533F9F46
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150945; cv=none; b=F3+EhpLkVJ0Q8cMku1mcnbpDayqC825SSL7cngxkMUigROq5GlwU8MZ1ZbriKSmd9pD/J9ecuLLwtGviKS8JAe4YWB6SpbnJlE8XzwCBR7dHTddoRqljWZm1yI7PFEpfI3w9Nhx58eigAFJxJLG8fUkGSdqCguV0pkpIcRDGIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150945; c=relaxed/simple;
	bh=GoUTgUI001M7Nkvz5L0znPw4/YTz9d1rdGCJaMUXKvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmI7hSsqT5XKNY0kNkxpDmNjhAgsT9aCr06Oeyo1fM9oXgnP1nwYm8tDVTiWP2BvlD5RDfkrF+GPx8qu6xc4PbY5xfYVEes4eZFTCUWqzZJUhd27mjCS+aAaue8fTFVOSmCzQlhhnJr09o8dAKHMsgd+nqAhRHajfYzNv4J1YLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGSBJ/Y5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGSBJ/Y5"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1501517a12.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 04:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785150944; x=1785755744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z++gezlvac4xYRLRtWLYw02S+0yg9RS8Olu40yBTBJ4=;
        b=KGSBJ/Y5+gsE1G+/n1S8Q+vCRPwXlUqebBNAnVUkB/c5ptPQDJWppv0/uD3BTSEMh9
         UMKV55dJHqY+ylA7nvMDYZYMzK25ikEgnp9x+frzWtbZkr6Cy/z7glqda03quywWnhwe
         opqEBNx8tJwpCOoQ6KpzR8ASspymXURRewzXncE7P3x8Si2b1JjlV7BSUFGTAwLPJ/bu
         rKOw+E2HjGiSIBy0KA8a/V+1jRZM45LaHWdb3Oo0/JGCw7d74c8kfY8Y9p53QGI/MYp1
         Bws/t19j6Zau24huBJ0ql5giLqDJ0N5OCXnz14UVcMVv/djp0fmbrOdZqzRUKE6Rnv7j
         ayjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785150944; x=1785755744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z++gezlvac4xYRLRtWLYw02S+0yg9RS8Olu40yBTBJ4=;
        b=HMDVR4p5GLJdeew1DuvGPVOfsqYxhJTUX6mJktz3NqMHJFh20/IKN64vUiDiAlwwyw
         0DgUVyJ4bN+VMU1VVnjLjev2/cbXMQxE1IHz9kCVmjuRli/qdOtvPR5z6OI87CUlViYo
         Qw6Fuq8EOebFR7KXaGrM9FPBLS4sz2sL/N+Fwf1H8XueBTRvVBQYK/ixJuO/US+GSBH7
         7dLYzZgPDmRl2SQ72nsIUwKWel1gow9hq5xhcNhQZyYLfpk7uwuO/b9VrksqHI/n3kJD
         x/jg1ojsIofndG+DJG5h2nzczfYzHFcGrC43BJrvdjl8gR3Wx/3R+DUoXorDdiMru4R9
         QJpw==
X-Forwarded-Encrypted: i=1; AHgh+Ro74lkwIIfUFp9+Cu2qNZZY0cfUP9lmNLrijwCSf98mbSwlCL34t2nsq9DBIuG3jXBQSRjkiYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpeEl9WS72b071ipExKA2pPten6YRZXleaR7HBmQG9HqrwfmB
	i80An+hmquRIsTN4z7QQp6CjHYWnpBUn0TpW7qwCHBLMowa0cPq4FU04
X-Gm-Gg: AR+sD13srdwd211Vu1mexhifjrp+EwU6EsEsnUnL/rGzAXhhNuSquXfKrDGX4OepMYF
	I6wIgu03gXJT2h2B7aubybr/w4E4U74it5pVZ3OcL84IRcS8Q3w3PqDnERgnMh3BbJ5aRhmtrn0
	gerTDstnd4XsNlvMJoTp55vCxm7w0PnivAK7buIBeKR8+wWtXjBOxU1NiJ4BvWormLQ90q0vBWC
	/mduxZBA5JMOxFFpF48nH95Hs/qR3CYX1XEYjSiuaTIAwuoC9yBH5Gv7CdhVatpLhQldXyyG7ZG
	V/xfGsJS4ZHWv38epFcs/timya2l8HT6qr2V7g4dZhgGMf7fH+4fy7NcEiPEHxGfRUI/j+DJmlD
	xjb77MyhYR9U+3Vfv2iqIAU6TNYC/XEosyABVpwk0BP0ejD3HgTr5JiSK3620d/GiqpwpXbQSZp
	/elAvFC5uOOFf7XoBJTfc=
X-Received: by 2002:a05:6a21:50b:b0:3c4:147e:98f1 with SMTP id adf61e73a8af0-3c67daa7226mr8285938637.31.1785150943517;
        Mon, 27 Jul 2026 04:15:43 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130262d2sm49070926c88.7.2026.07.27.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:15:42 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martyn Welch <martyn@welchs.me.uk>,
	Hao-Qun Huang <alvinhuang0603@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cong Nguyen <congnt264@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: vme_user: fix flush_image leak in tsi148 bridge
Date: Mon, 27 Jul 2026 18:15:34 +0700
Message-Id: <20260727111534.729615-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When error checking is enabled (err_chk=1), tsi148_probe() allocates an
extra master window resource, tsi148_device->flush_image, which is used
to flush posted writes by reading back over the VME bus. Unlike the
regular master windows, this resource is not linked into
tsi148_bridge->master_resources.

Because it is not on any resource list, it is freed neither by the probe
error path (which only walks the master_resources list) nor by
tsi148_remove(), so it is leaked whenever err_chk is set and either
probe fails after the allocation or the device is unbound / the module
is unloaded.

Free flush_image in both the probe error path and tsi148_remove(). This
is safe when err_chk is disabled: tsi148_device is allocated with
kzalloc() so flush_image is NULL and kfree(NULL) is a no-op.

Fixes: d22b8ed9a3b0 ("Staging: vme: add Tundra TSI148 VME-PCI Bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index c695ad9b4ca2..8ee1e00cef4f 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2513,6 +2513,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		list_del(pos);
 		kfree(master_image);
 	}
+	kfree(tsi148_device->flush_image);
 
 	tsi148_irq_exit(tsi148_bridge, pdev);
 err_irq:
@@ -2619,6 +2620,8 @@ static void tsi148_remove(struct pci_dev *pdev)
 		kfree(master_image);
 	}
 
+	kfree(bridge->flush_image);
+
 	iounmap(bridge->base);
 
 	pci_release_regions(pdev);
-- 
2.25.1


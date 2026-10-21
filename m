Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553093;
	b=n1KUeoQYmRKup//11jDuhWoIMy71+6woNj869NYioNS5yphA7clYeHBOvAMRDqrqcche
	 4smrTZs6fPNdLgTmyEb9++j/v6D/1pLDiE5/6fDPI+kC7r5tI2Iq5CLNeqppCeduLip9/
	 clLvxhm+ivSdbbMyYlrN2JX1+Cn9gflWzKtl78QnoJhn+0Db2FaKVId0rkatDjH6PpjGC
	 ZfK1OvphraHsZVPmM9eknSOcBrRNSpH/g4Rl72c+TiBh2KSqb+EAntvaN9p6fbBVDlHw9
	 EsIOjtB63wSKzsSubpn+YpqQM45dhm8k00ErceOf6MznuQQOUCcGAPkwAIHePiGmkpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZFVAKQGsMgdgNfkXAN9sULjMGSL2i7oHnvsLeDRjk+s=;
	b=1qHFu9zMf51jx5GvPpYTevUIbtmOz7idKfhxbnJAYRBHOY66pLFeGG+5Ll0C1htu08Og
	 1+zeDPj/kBiGy9XUz2k10wROoVfeEHAYEo3m5ORWMtQNHA41Recf1Sh3wgOXFS58i1/el
	 aopMwLhZZexL7jZqBb5NpBnpvyVLmk4FMu6/Opw/rPXsDxVA0dfKy4USsQLgZJ4XTG3ov
	 MvAf2XrIioAYfOD0T8oQHkxgopkkZnBr8/xha6RJLAaSAnROuQ+hwQUz35STjZm0wPV7D
	 g+cwh6g5C/7oCYna0JYWdSPWrmFiSq6rGe7XtEW8y9xw1UqNk3zb7xQEznQeCVM5C4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=ojPcxL9A;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D41606BEF5
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D41606BEF5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=ojPcxL9A
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso170937a91.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553092; x=1793157892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFVAKQGsMgdgNfkXAN9sULjMGSL2i7oHnvsLeDRjk+s=;
        b=ojPcxL9Amul7kBOJOcMw0LKjDpPLd8q8X4B9mxDTd+UGa5ldBO7U8up7cReajCWUjL
         q7dsM3IKeJh7w/ESsLpUyS49ZK7zLfX1Jme3+ilA1Xi5x2L5rYG1aMmNL2F961FLUWfJ
         WfceVgc85Q28m3htW28qpD0iXq6Iv3pPg0vfevqlM9yLNDjHVZ6Ibqye0ijNEGEOj4Fx
         kUyTfo7Iw6O8lBLh7rbEDQbjhi1kURc4pUlFIkKD24lU/iCToGIUR7WGFYV5RnIMS3tM
         zx+A5QO0tfj1tT8xxgq3mymKhLtyyxEXmf86a2DBqsSqCY0EAZrvvXzVH7YKZ+DgJW9i
         I7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553092; x=1793157892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZFVAKQGsMgdgNfkXAN9sULjMGSL2i7oHnvsLeDRjk+s=;
        b=zICe2MoX9jDrJTRFnhcbdtaDfOq3oJ7qYbAIH/qZ38VgQl7qUN0B8LvGDRew9afPKF
         SUlpwImuHRkjHBibgaxolWmwCZf2I+v0cuRIdWqSUPO6MTiaQvEU88XXTzLKRYjdytTI
         NVv5239w1zAhOj2JkPGAMD2If2VCEQzZMAhi9uJZntJNi5HhpLtXqd0CzybhNVV7eMyJ
         2QiU4ewHG8cgCWx/rwwBA8AJNJBEFf3qgQWtMpF+MqMfkDt1gqkaAt1CopCmBbgmA/n5
         wpnX4hALujK2JjkBQ9A0NepKTu4yPyyAHi1Fh1rWDOVJvBjt2zFcRXslHqS8LhAFVLoK
         Y8Gw==
X-Forwarded-Encrypted: i=1; AKwUvBzlqbUpzSEf8JGX+el3Hwgi9SzyrPLmRsIsNcG5JXlbig/llp7DGL7VMQtgC1qisVJhv8B5cR0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW3fhCvq/779nVhEpiJmJiYgQ9cU7jkfSNEhjqUDf8E/qh/NJr
	JkEmMKhUcJpjVq89EDGkBAZkUUU16rLhAHuA8K95Duh44sBxIL+QCV4OdkiVv/3eQYI=
X-Gm-Gg: AYBFou3Sw85lINUE6GLS+2GD/ncTGuKPFNivjmOZM2VuLgUN8rCcScmFhkixxJh8nuk
	v0agQYoE66KF/cN0x5iIpNjtPdmn38ngQyZZR9zsfYntoC2P4qIkz9yn8AY6puc5UYgxe/ydrQB
	DJNF1e3c5gg5oin2uYc9We4cX/i45ZW8IGGk+1ZAW1ivtwfJpymRzQa3v0vkqIw3djgp/4NN0VC
	Hk45srfOPfTyV9c4EknYbHckw8mrcWwgiGSUGJhhIfGhnH62kkRkFIUvAwT6iO1duTSWfMWDseX
	DC6Z5hr+GlP3GLjdWzTU0sFPgyPtgm4te6dr+XryDP6R87ETJIr3nmAliDtCjCeEsPyUPVoUcX4
	cL60rYDTznZj6zx3AX9CWeb9hEw5MUjIkoIVJkskili/w1gjMy1WRKtUd+zTTLMyj3hXNGulwRS
	JCmwVyPsZTqmVCEtSqlRBl+STIPWtCIMEmWYa+z0V3tPXv/XLo16XLAJ4KQbeJoBE+JfzEKGLl+
	uYGJypzBwxv8qGrHcldXdyxDXAT2pF+n2ntVJ/JdgXHQPF4n6CF9etqzsClDoLOAQAB5I7tBGzY
	SWTGquHyvZo6yRqCE59DhZEFzrgibzK580vh6mIRjn1ZrfkPBjGLicixz0xC8uyX+RvHbDgOH/8
	7Qw==
X-Received: by 2002:a17:90b:390e:b0:3ac:9706:7735 with SMTP id 98e67ed59e1d1-3ad86b0c35cmr794388a91.5.1792553091800;
        Tue, 20 Oct 2026 20:24:51 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.24.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:24:51 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 1/6] nfc: nci: skip controller reset while unregistering
Date: Wed, 21 Oct 2026 08:54:38 +0530
Message-ID: <20261021032443.44412-2-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021032443.44412-1-shubham@octane.security>
References: <20261021032443.44412-1-shubham@octane.security>
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

nci_unregister_device() marks a device as unregistering before closing it,
but nci_close_device() still sends CORE_RESET and waits for a response.  A
transport may already be detaching at this point.  In particular, line
discipline close holds the TTY line discipline lock for writing, so receive
callbacks cannot deliver the response and close waits for the full timeout.

Skip the reset request when NCI_UNREG is set.  Keep the reset for a normal
device-down operation, where the transport remains attached and can deliver
the response.

Found during a source audit assisted by OpenAI Codex, gpt-5.6-sol, and
reproduced by closing a pty-backed NCI UART while its NCI device was up.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 net/nfc/nci/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 73e3a96470ac..8ee33505e93a 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -582,13 +582,15 @@ static int nci_close_device(struct nci_dev *ndev)
 	/* Flush TX wq, RX wq flush can't be under the lock */
 	flush_workqueue(ndev->tx_wq);
 
-	/* Reset device */
+	/* Reset device unless it is being unregistered */
 	skb_queue_purge(&ndev->cmd_q);
-	atomic_set(&ndev->cmd_cnt, 1);
 
-	set_bit(NCI_INIT, &ndev->flags);
-	__nci_request(ndev, nci_reset_req, (void *)0,
-		      msecs_to_jiffies(NCI_RESET_TIMEOUT));
+	if (!test_bit(NCI_UNREG, &ndev->flags)) {
+		atomic_set(&ndev->cmd_cnt, 1);
+		set_bit(NCI_INIT, &ndev->flags);
+		__nci_request(ndev, nci_reset_req, (void *)0,
+			      msecs_to_jiffies(NCI_RESET_TIMEOUT));
+	}
 
 	/* After this point our queues are empty
 	 * rx work may be running but will see that NCI_UP was cleared
-- 
2.43.0


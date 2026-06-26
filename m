Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532333E92A9
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464613; cv=none; b=dYBZWu3aw42+wMVIF5RdworT1LVS5UMF3jjaMfZZWL/YhkgosifnjhOfLH3k0uPYRKnVbgKMzNEmJttveEz+x1XTpgS87gUa+PihozE7jNmnsHyl4pbwsrByPyXScbOhRBuvf0N5dKp/YvcT/cMD6LNq2kntAbfOlXBcBZih560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464613; c=relaxed/simple;
	bh=0M0mxNXpHFTkb8lNX2bKAWdZx27Ftz5ouO/m70GPZoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/MyxFrdq0nKEQ2+xZXb5KWJmOavze+cmLhIJZMsDbBb1FXQuTA2o2Jqph/ohIPFfv17VjNDeafgYHc4R2mo7plZ6BBEhAsxYg5ZuMDDLQ5gbLI/pDMimnPmr93iHB2FN8Ym2m4ntcB7SprxRy6HVX2SQ5zq1NpuR+yDxNBY2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=Aol9WYie; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="Aol9WYie"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c122d85eae1so43399666b.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782464606; x=1783069406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NKt0Mt/SHh0nM9NlYpItPXQZdY1JVeNAiPrcQ3UdMg=;
        b=Aol9WYiefrjy088K1Bt00UB8GORivLX9aWW+dILVDntGQwhjV41mJBHefvKstm4Cyq
         wZvLt22PzMVZerpOFOU+qZTOMTsXi0m43i/zfzTfvgy/Mw/FufT2b1RDXs4swlfINkLB
         Eu/Nl5uhjh+lRWC2vqwceUHKp00LtPB4H94wGHGhdjS7S8BNJpX7etOKvuzXqpA7LyrP
         G+PZV1xl1ZGeNaj+cCdJN4ml9jM/QF9ib06ibAV/ApBpsuUOyzIuGmjEKbporcrRlLxG
         CNUuLNIlgtpiJQCNIhiZdxN/x2oOCdLCvMUlgz+ixuvYOS5UpnXKEOQCzFwtJc7BTU/o
         BWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782464606; x=1783069406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NKt0Mt/SHh0nM9NlYpItPXQZdY1JVeNAiPrcQ3UdMg=;
        b=sv6biuMjmvhA1xzv0m7b7lXJ5fHltbpr21ovs3FZ1yBK4Fqf39LsDhdW5XWMfhTiT6
         Ph62CZsa+cZ63wSkj9LBznrCpru0rG8u3p5ohFZoUZDl8W/sk8rPpZHnYvSc2AOesLNX
         SMyhYwqAl+1ddI+umq3YJqtLT3mppM//9JwKe5ShoFgb/793r1EvXLOZU4396l1A0FMN
         0q6c0mGXdyP/NuEyZUUF6AMNFwa+QvhiR1f9f/1rkAnm/ecGeGPssft4NcIAQwO4tqCk
         JJ70UdYQKgzNKIek9WaPSI22AThNIeDkzV/c7jQ5qJdBzdx3k6eJ1C96zv7vXZo/uJHq
         xFhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrh0uFOEQTNzWX9uM8Iu5gxjGbCqxfBSXxEyAKIYku43Stz0dbvoR3cY9/ioAFzt2vLZcjT31A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLmyYa63U+CTseROtojYTRBCE0n9CgKqsC5kuMPfgD9rPMuzm
	zi9cuQ6UqbwFtV9NF71Hk2uFMqTiAXNMJiu7Q+i9D5Ot5fkcnkWWTK/rYc6f9w0dCFU5
X-Gm-Gg: AfdE7cks4k+zgBpOFfbrPifvElCIOk1g9xG4ZXuIwSAbXVQ7di7gztkEBcKDaIqohdq
	brBzutWpzH7H74m4bGEU8KHKU/6wm+/kRNGy31vYwQqG/WtL+OU1HfLmkhKbb8cEDhX4MQmrxc9
	qnFSCax1bqkDTx50aIxh881SL8aMpjGTO/uVPIU9DpWNpbPeH2qSlSRL4aqAMd+A4kYcPc/2lB3
	CYEAit7D+ftZsRoJVZlD3qeWVD6WlGFoI/pNTxPnqlG5c2v2uRrwyv4ofZ3u6YO/OWKQeZgcZNe
	Mi/NrpxOEgnsYTyR8vLqPP7peYHkCXOcs+Xl2syy8w3NhxUKZOFwzu8b6Z8Xb3dFJ5iielw55mt
	z/OlTchg+hse34PEUPIW2jc2tnDmuPJ1wA8W9LX55yOd2I4vPGiIas1gpo5ZNP2wNpW5zYVipfV
	vq
X-Received: by 2002:a17:907:26c4:b0:c12:15b5:8773 with SMTP id a640c23a62f3a-c1215b5a71amr250832366b.6.1782464605602;
        Fri, 26 Jun 2026 02:03:25 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05b6dsm317589066b.37.2026.06.26.02.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:03:25 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
Date: Fri, 26 Jun 2026 10:03:01 +0100
Message-ID: <20260626090301.2139500-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_rf_discover_ntf_packet() and nci_rf_intf_activated_ntf_packet() each
parse a notification into an on-stack struct (nci_rf_discover_ntf /
nci_rf_intf_activated_ntf) that is not initialised. The RF
technology-specific parameters are only extracted when
rf_tech_specific_params_len is non-zero, so a notification that reports a
zero length leaves the rf_tech_specific_params union uninitialised - and
both handlers then pass it to nci_add_new_protocol(), which reads it:

 - discover:  nci_add_new_target() -> nci_add_new_protocol();
 - activated: nci_target_auto_activated() -> nci_add_new_protocol().

nci_add_new_protocol() uses nfca_poll->nfcid1_len as both a branch
condition and a memcpy() length and copies nfcid1/sens_res/sel_res into
ndev->targets, which is later exposed to user space via NFC_CMD_GET_TARGET.

  BUG: KMSAN: uninit-value in nci_add_new_protocol+0x624/0x6c0
   nci_add_new_protocol+0x624/0x6c0
   nci_ntf_packet+0x25b2/0x3c30
   nci_rx_work+0x318/0x5d0
   process_scheduled_works+0x84b/0x17a0
   worker_thread+0xc10/0x11b0
   kthread+0x376/0x500
  Local variable ntf.i created at:
   nci_ntf_packet+0xbc2/0x3c30

Zero-initialise both on-stack notifications so the union reads back as
zero when no technology-specific parameters are present.

Fixes: 019c4fbaa790 ("NFC: Add NCI multiple targets support")
Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
v2: Drop the inaccurate activation_params / NFC_ATTR_TARGET_ATS scenario
    from the commit message. No code change; the ntf = {} fix is unchanged.

 net/nfc/nci/ntf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..274d9a4202c9 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -440,7 +440,7 @@ void nci_clear_target_list(struct nci_dev *ndev)
 static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
-	struct nci_rf_discover_ntf ntf;
+	struct nci_rf_discover_ntf ntf = {};
 	const __u8 *data;
 	bool add_target = true;
 
@@ -688,7 +688,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
-	struct nci_rf_intf_activated_ntf ntf;
+	struct nci_rf_intf_activated_ntf ntf = {};
 	const __u8 *data;
 	int err = NCI_STATUS_OK;
 

base-commit: 02f144fbb4c86c360495d33debe307cb46a57f95
-- 
2.54.0


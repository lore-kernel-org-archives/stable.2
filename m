Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1383B38AA
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771854; cv=none; b=IVrn41FbpEKjmhkQaajzoONKWmzU18SgnoheJHq8eiyzWrTtIEaTLoi/FEUjPiwkyiDm+sVly/6Yl/wD9MPRmSv8Kho2IzkDHnYGVBm1HsHFhB8hSxa1uJRYOpjEOA36cZv9lef81YDN2R6bwm/5EQLyNYAB2Urc6iLiwbLWMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771854; c=relaxed/simple;
	bh=pOwuoiQjzretG7oDfDmFYA3hIp2H88a2vhblAg1egbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2CkqTUwYtUcXIpp3Fgbu2+qIyk12sIk7C8yfje9qbibKMkx47Daox1/xZxflRBHf+zTePnb6WtQdrGrtd+5iSmSMFo74Z7vigXn5DqY20OgPLg8DqQAcRtDBjxBMHJxqZboudOxZ+w3hnf7qrs0FktmVK3Wq7gfVc0no+I+9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z3PbnRG7; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z3PbnRG7"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-69de16f5f79so355595eaf.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771852; x=1782376652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ali2EOfmsyhEzhaOAaUOh+zn1fjnnog9jkuNp7bauLU=;
        b=lYhyJsQ74UJ2vH4YWaDgrh28KZfbKzlXvBhy+/S0ik9vo9XHibuK20Uqmfi81Viibq
         ssiSReRoNBg18YsOV02rOKBouZ3PVBwMVYcwIZa3jb6V6IN+kNaK05CFR//qodFeGKp4
         kMcOb3nSi9D0wfVJUV4jYIUShiy+g1mxFG02xKsnf+DQl/dIfXuDm2uS45l7kPpxdIdR
         xQSBm7bff+uuD8M9dWPvFmqLB7vxqI6jc17C0h6TivltUg6ZrwrvtYzeUJkNVJ8327gv
         Ov+Oi4dGzLLjj6FwRK2iu+o2b0hnBHncnKa6Teao2+IVqHYyk7pNE+kOM5zwrHw50WHT
         3uOg==
X-Gm-Message-State: AOJu0YxN1TfyWnyPuyDrRq48r38zbc3HiRAG5nEb9d7shuDoMaQf4TUV
	ooKmQesYJ/yaLvDzOk/7v2zO9iOINRTGrVb7ax4KGGAhKnbCUWfmEymCmTvkk3S+0Fcb8Y2z2Ph
	sWgeY8Ymubu2Py0/U7oXqUESgEfCRxaU1ghe6kLPi/ZszI2Mi1z6lbGmmJP/DQ5g0Y+o4zVwq1Q
	N/tXAoO8XhAN+jJ418FBkFmGQslOUQOKv8K0KlGptdiXlsVC7mrbLyn3dPWBfVRnrCdUtVBvfHM
	ju1Q6MsD2+Qt1paSg==
X-Gm-Gg: Acq92OET2LKk/LCA4cStviYt20CVyWuBF9DTzu5HhEEGk0qvL0hw6M9bGNs4vMvy6Bi
	tlvVpJHed6zeqSZ4C7PLZpj9BU9AqFDbgZOvORs12B//sqzQVKChICYULBCp8/Zzcsl9nKKdprJ
	ZZT+jElZ2vapgz+0N384mNxYwU9/8oXNFPKXwWA5O7/01BaSa8mYZajrMQmSBnQzSnbr++ObvXK
	nUo1a1SbqLZJ2BNKaRkQQlVUHwl41jdbr+TRpTuuaHtUydpAgaaith1oLwOo76ZjOKdJMYClrlw
	sBgHPQubW83Eso0/KzEdyXEpAqfO30A1oTMsAmrJlKQmg8ylxj33d5jFOWrU4M7HhroZwq7jeXy
	VE2QAcrTlbpLrrtx863yDW4vNMqdcSNSTY112Eb6/7h/6RYYn/yL27Sf6T8B0qS9sXR1FEAMOKF
	dbhEWWXHYvVYCZSfK3rksf/3UAcuE5tR9umi5NrYsTCOf34fRLmXdE
X-Received: by 2002:a05:6820:174a:b0:69e:2e0a:58dd with SMTP id 006d021491bc7-6a0b618d9demr6160889eaf.38.1781771852264;
        Thu, 18 Jun 2026 01:37:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69f00ec4a46sm822672eaf.14.2026.06.18.01.37.31
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:37:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bdfcf7c14so2894745eec.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781771851; x=1782376651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ali2EOfmsyhEzhaOAaUOh+zn1fjnnog9jkuNp7bauLU=;
        b=Z3PbnRG7RwUZNKm8nE+twtL1ioxcp80xQhoiFoIcELbKVpRmTdeTtHkO4hnauimVlf
         PciG5XllfT0QaCFWHvr2+6euHEIk4+xeeMeHFKVAt8+zjcGkeri75tbkDv/bi9FDbgOu
         97VjlMarbuULn1IId0mSY0ytf/8NO9HZDSg60=
X-Received: by 2002:a05:7300:8608:b0:30b:c6f0:1cd9 with SMTP id 5a478bee46e88-30bca0cd6e3mr4005751eec.26.1781771850989;
        Thu, 18 Jun 2026 01:37:30 -0700 (PDT)
X-Received: by 2002:a05:7300:8608:b0:30b:c6f0:1cd9 with SMTP id 5a478bee46e88-30bca0cd6e3mr4005706eec.26.1781771850085;
        Thu, 18 Jun 2026 01:37:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm27475037eec.4.2026.06.18.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:37:29 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaosuo@gmail.com,
	iri@resnulli.us,
	jhs@mojatatu.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Bin Lan <lanbincn@139.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10 1/2] net: add skb_header_pointer_careful() helper
Date: Thu, 18 Jun 2026 01:08:06 -0700
Message-Id: <20260618080807.1269070-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
References: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 13e00fdc9236bd4d0bff4109d2983171fbcb74c4 ]

This variant of skb_header_pointer() should be used in contexts
where @offset argument is user-controlled and could be negative.

Negative offsets are supported, as long as the zone starts
between skb->head and skb->data.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260128141539.3404400-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Shivani: Modified to apply on 5.10.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8abbb64bd..a2daeba8b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3686,6 +3686,18 @@ skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
 				    skb_headlen(skb), buffer);
 }
 
+/* Variant of skb_header_pointer() where @offset is user-controlled
+ * and potentially negative.
+ */
+static inline void * __must_check
+skb_header_pointer_careful(const struct sk_buff *skb, int offset,
+			   int len, void *buffer)
+{
+	if (unlikely(offset < 0 && -offset > skb_headroom(skb)))
+		return NULL;
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
 /**
  *	skb_needs_linearize - check if we need to linearize a given skb
  *			      depending on the given device features.
-- 
2.53.0


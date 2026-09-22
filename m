Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCE4570CA
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069491; cv=none; b=Qx3NEw8kf5JcbCM5Eh8yyoJUfnwxf7siwQVidDrFQkGsuxixkIPuzvuGSMgQjDkNLqGYzu3xMuvhsATvVbFzfymHPq5oLVitxBTrBZFj7q/kM0AqYcFZwSSgbyAMEQUFoMQxqgpBY8mzl1zU8cC1Ea7PK966zSwMpYroz5axCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069491; c=relaxed/simple;
	bh=PA4WHdZL97fHMVeMYVBzQqDhDDVdPEHyHKSQZGzkDpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOMggViv150gp39RIezW+Ep36aQU+4hz0gYucXmLlBi0g6Mu6OW5KhBJ1/9+C4X47Z9q1HfG8g3datOgNuV6hAZmZqdk4GG3kdC2wfGWCccXSGZ9MqjKbc7HQadzxZUuynA/4c1uCNUGr30TYx16WanOTOe5HW+9yPvC1mgK2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB7oLwW/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB7oLwW/"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91a931f66so27683275ad.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790069488; x=1790674288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lD/BJV6m0Rx8++xUr7O227okZULoxqZpRvzaX7SrdP4=;
        b=PB7oLwW/pmGx3sJE6GHr5pu79OWc8YNG0xa1otR6ejUQUCqenyLBw1BGylNirm5lG6
         e+dv3+ACe5gM4tLlyxIiZsXuhPTdN4k7+pMQmAktfyW8i3di7VOKShaR+aRrKmftN033
         9BRXZHxQmnpy30+q2oms5n7XuBvH9GsPROPpj+tTG7SMkDwQ7hrWE4L/4/9CuOxU+1b1
         QmMi57e2yokbXUzTthLrP2fESJvNK3kLbvNXVVIjnS/bRQ1a8uhS5E6xbS1ZJGVOa0wj
         O/Q6EMlTgGXXmDS0ZspflxS5mv9zuEvi0vug4nuic6jMNyOqNPD+1101JCFP5Y5mHl18
         Cz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790069488; x=1790674288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD/BJV6m0Rx8++xUr7O227okZULoxqZpRvzaX7SrdP4=;
        b=AoO/OMep79TT74h9GeeOmrio1ifzqL52LI1OWQMleLgzG/fRQRJU5tFjMUTcl2EpXt
         Kdgav1U1m83qCNPEOyCdoberhdZIdkd6IQlzalZ9Y5Lg2n/F7GMBSPBRTuXMOvQ9CsCd
         BjN1ifXtOwGcpxVTUN00dmAtmVAcM4YXBG5v2kCEwq1fcqKL8/Pt/uk7/sQ+wDsJZibA
         Glzdugn8mXPa5NPLHdZ/9ewDCMrqBCNq2WN7J94otXiM8XhubZwNIFVdV7qvnkYzYEFM
         CsN6sTPoeqrCTVVb8+JBi4QACeK08s+UpXg/EPozLqEOliGvEWchs6GthS9H2cdrVxsM
         Tfpw==
X-Forwarded-Encrypted: i=1; AKwUvBz6qGjbI2Na3C75BzOLtyZCTyJnnp5LDnix4MwHZmUTIzfy4fRm/bXm6W6Iqy5euwcIwiemkAU=@vger.kernel.org
X-Gm-Message-State: AFuF++mHl9BTQizq9WF3PMccjVCuQ+B841luDaH6r1ulEvupGEAjtoL3
	PdKfXq6OqvKc+m3AFG9mX4LsVK5av9T6TWvnCbwEO70+vp7Ejqpx/1eg
X-Gm-Gg: AYBFou3iRIiYL3S/CTDWm2ZJ6OFZHxiCzxyOB3GjAHoFX/idsKyVvLS/lUlDz5xvrsF
	UFbNXvMSGm9C90CjBoVNf3f6BRhI+Nchd6laQn2KMblp930AucvOsvlkMomgHDGsoOvdePGp0x4
	r/SLhiIuRylXPCQkiRKNd4/vf6WQpWwt1+ZQQShKF8fngWVjSHGa7sOVKSwGh2nmeHIfDHGyi+U
	ohs8eetl3VoQGSL4LzWV8GU2esmAQYGMhLcmVxYtETeH83vnhx3y1jY947wTG1i83JLAL6u14id
	q4nmnB1PLIKRIjIoLEWX1iyPJ2Ca5xs9KMH4xvaPYpxRbfCViZz5B8N3NyfK/JyAtGTAelF3F1r
	Q1U0d/7Sw9NGVyqnZpmbkdEc2QeOdBzDrMVaiJUnLEk5zNaXPrej4WvWU8EYKEokW74BbVAwnS/
	3ox12zu2SRvbztIgeJyy0T0HWlXJ1y8pbw3pnOipT6XtOBH9+N+8vJd1giHw/WoYsvN7Qt73I4U
	2LuGx/6+TQPJjaHbfjJumeaJIyC7y5wQX3cjp2oJvLHVnd1p7B232D3B8/Y7/rPELgDXCXMEJpy
	KITKFM8OEg==
X-Received: by 2002:a17:902:e88c:b0:2dd:c100:4b82 with SMTP id d9443c01a7336-2df60b77a23mr6810615ad.57.1790069487953;
        Tue, 22 Sep 2026 02:31:27 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df63a22f54sm103915ad.61.2026.09.22.02.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:31:27 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Hui Peng <benquike@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 0/3] ieee802154: ca8210: fix stack and slab out-of-bounds accesses
Date: Tue, 22 Sep 2026 09:30:22 +0000
Message-ID: <20260922093126.141969-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three out-of-bounds access bugs in the Cascoda CA8210
IEEE 802.15.4 driver:

1. Reject received SPI packets with len > sizeof(struct mac_message) in
   ca8210_rx_done() instead of checking len > CA8210_SPI_BUF_SIZE (256),
   preventing a stack buffer overflow when copying a synchronous response
   into priv->sync_command_response (a struct mac_message on the caller's
   stack) and matching the actual SPI transfer length
   (cas_ctl->transfer.len = sizeof(struct mac_message)).
2. Initialize lenvar = 1 in ca8210_get_ed() and validate
   hw_attribute_length against *hw_attribute_length in
   hwme_get_request_sync() before memcpy() to prevent overflowing the
   caller's stack buffer.
3. Validate the received SPI frame length len upfront at the start of
   ca8210_skb_rx() before reading data_ind or allocating the skb.

Changes in v3:
- Patch 1/3: Check len > sizeof(struct mac_message) in ca8210_rx_done()
  where dev_crit() logs "Received packet len (%u) erroneously long" and
  drops the packet, instead of silently truncating the memcpy() with
  min_t(), addressing David Laight's feedback.

Changes in v2:
- Split the ca8210 fixes into three single-issue patches (1/3..3/3) and
  addressed Miquel Raynal's review comments on patches 2/3 and 3/3.

Hui Peng (3):
  ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
  ieee802154: ca8210: prevent stack buffer overflow in
    hwme_get_request_sync()
  ieee802154: ca8210: validate data_ind length upfront in
    ca8210_skb_rx()

 drivers/net/ieee802154/ca8210.c | 39 +++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 12 deletions(-)

-- 
2.49.0

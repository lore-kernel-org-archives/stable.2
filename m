Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964B39150E
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736908; cv=none; b=bVsvlLb4OfiGotGPmyU0I/vAsuzSeSGhVJSVaHxQQeLB0Bf+Q55jq6ECOhPdG3pjMqmB/oysAGn+y6Jfxyf1ax4kjtT9xCNDwpe+pOprE0zTY0no2Kfu5ZlH+zj6z6uZh5y0Z8cz3p/gScwREAUFhRLycAC56u+QmdVG2PV55PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736908; c=relaxed/simple;
	bh=Xxo2GmyRqJ6wogYd+cDC6txXOd7LJPumMEyFBZsSQgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjPzW1AVBgk4PQkutSsAn047eoU91mnH0oFh72kKGJXf1COypNyMZea5obUTjxBYJ5jtt+q4zaZdCeT3jYy2nnBkHip/pTBQbEcw4umQz8d+kL8jqmCBxzL2ercdFmVND6vIoU16YknEGpwypl9y9PGEweh1MO/HXX0la2fYjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZqO9fs2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZqO9fs2"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a818fc4so10292301cf.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786736906; x=1787341706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qt39tWaDTPOV680UZL11ems19BuKoQqgDcx36aFXLs=;
        b=eZqO9fs2hL10/t7O+LVkVGpMd3yRPrNxNKaTpFNIdaR2GIqv0dvrCVJoREEKQTFQny
         oWk8RWzjUFDXTS39xQxeZyd5jI54WQrCfW7aOHajQkkF+EMGDCv2zruVxg4XHx1E5uSB
         xb7u1Ib28GVIlaK586Y1Xbsr/7MK6a4MiRh3sJ4SdXyGGO7BW61DDs1IRO9qGZ9yu2cZ
         /jX9tSVwAWfSdbNwIBoa3nIBv5OhVjrLuX1EAdhKmj1fNSDNwbM1+Vq2wa7oRAKeXwYz
         HbxFJ15Q7H5d2Xw/ULIyEv0fC0G0wnjGzmFgPcb56MiMd5D9wFkduKDYq+gRPKbMM9yN
         DdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786736906; x=1787341706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qt39tWaDTPOV680UZL11ems19BuKoQqgDcx36aFXLs=;
        b=ZspmqZV+SXxH9e03ztuP+pDpY8ZR3mqKJqmirRr/m262DGhOz7zn/M3KBUSI7ZvVve
         sfk72RNK798vt1yBJzqf4D3xCX7jWMjw7kde9FzkU4QOzkdACAN611Bgs9a5vGvBxFiL
         KOm3E0A3DnMbcpGNR0sQQWOl92pF2Tyj85435oVIGOlp6HGYfXt2rer+9q/tmsynffS2
         fUjN9f/DlsNJ6u8N6w6A8vh78UQeVenHltXOnyoxppf1lLJK1N81EAQbJEBRv9L415Ah
         bJSwjSCQcNLIsG/YSwgSMIlDqcReXUGidEYM6X5OhADeb8COwwa74zsAHjnVr2tFyGdj
         JdQw==
X-Forwarded-Encrypted: i=1; AHgh+RooQeI8VIf2Qg3JTvUm+69eAjMhN/v283UQbhXuzn9PdTggJw4jpFqD5kAE5UbiRxGfv3tAuQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQN+XtuMUxXx7PcqHwtu+MNH7tlW23SziJTiA+YfIVyTtrgLf
	NWi0w+QgSCj9M9fHhZGtiIJg7Mp39N953zzW72nt+0xgsg5yazTKtVu6
X-Gm-Gg: AR+sD10Yzw2vZgvQTuWbz5HlWKTcSV1EFirEZNVin7xNZIEAYGRGh2l0EbTubH0EKlr
	TTu3Oqo016xJ/Un/3MBT7KLhEYHAbGd6gIYkWn2N3dxVuAJpQSed+lbMt8+X1fX3sn7LJdJVnY5
	VcrvnAGfJeIiJ9/AUXz7N3WyR97Ev3NMq5ovpr4qeiMwrkUjp8LP+yMYWOOyE40fH/N3sUXeWSY
	U+dqF4g45llJOWdofti49Yc7vEOuQyvBNH514V/cbsHNMZK1lnw1Iz+/sV5iLyKBew9fTRifG6h
	NUuDPtZd1L12fbDK/Oux4IXf5z+ltAFtrqTvN8bcArLAa74s7UWU+dri3yt5p8JQSPfkJs9HdUd
	XOVPjdktwd96/MciS/cgr6SUq9CDzDaMVgZJ0yi47DEQ+Ao++h9zuZJOzzrykf1nDIw7Q8oJPuQ
	FNj+ERpEE1LZjUYcG9Q8iZBaMLze7ZdnOaIgn2M2wk+soREg/4SD7EYSMI7X+wuef61wyiqb8Xw
	dYviWR9+/BtCr3lUqSvjRxeGg==
X-Received: by 2002:ac8:5ccf:0:b0:528:22:8c61 with SMTP id d75a77b69052e-52d854f3ce2mr103561651cf.38.1786736905868;
        Fri, 14 Aug 2026 12:48:25 -0700 (PDT)
Received: from shivam-EliteMini-Series.syr.edu ([128.230.213.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce1ea65fsm340247485a.30.2026.08.14.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:48:25 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: security@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kumar.shivam43666@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
Date: Fri, 14 Aug 2026 15:48:11 -0400
Message-ID: <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081459-handoff-wildly-eeb5@gregkh>
References: <2026081459-handoff-wildly-eeb5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvmet_tcp_try_recv_pdu() reads a PDU header into the fixed 128-byte
queue->pdu union, then computes the remaining payload length as

	queue->left = hdr->hlen - queue->offset + hdgst;

and reads that many more bytes into &queue->pdu + queue->offset, without
ever bounding the result against sizeof(queue->pdu).

A struct nvme_tcp_icreq_pdu is itself 128 bytes, exactly the size of the
union. Once a header digest has been negotiated (hdgst = 4), a second
ICReq passes the hlen == nvmet_tcp_pdu_size() check but yields
queue->left = 128 - 8 + 4 = 124, so bytes 8..132 are written into the
128-byte buffer -- 4 bytes past its end, over queue->hdr_digest and
queue->data_digest. Those bytes are attacker-controlled (an ICReq
carries no digest), and the duplicate ICReq is only rejected later,
after the overflow. A remote unauthenticated host can thus corrupt
kernel memory adjacent to the receive buffer.

Reject any PDU whose declared length would read past the end of
queue->pdu before the second recv.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/nvme/target/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..c9c98b8eb149 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1229,6 +1229,8 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 		}
 
 		queue->left = hdr->hlen - queue->offset + hdgst;
+		if (queue->left > sizeof(queue->pdu) - queue->offset)
+			return -EPROTO;
 		goto recv;
 	}
 
-- 
2.53.0


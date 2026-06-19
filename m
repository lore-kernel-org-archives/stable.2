Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD58367297
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863089; cv=none; b=jvhrLRmzHBbEixGe3mz/Pp02s0pRrIMc7PvFeWK6OZ11hFtvZUdDVQc64rMa2q22fxyPKTCPj8appLZJ7ojEDCOlPPfY6uc48LeGvNhivHFSl5BepiQgy5Cmq0A1OggbfmpWR1gwDXh+QLFv01idmIYWp+GHQJwc0jOGfNbLNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863089; c=relaxed/simple;
	bh=gnqYplrvnOKhysmkaWxCDnkGO5zvC2BvTJjxuHPuzak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPkkdol6109Ujr37MBmJppQLgYNPC27WxNkGc0h2JmSVyTrjKqhHAmKqoZSy1mIn0q5+Xnghq2BwZpNeirDMeBmlC+uxz9xM7ZffkFO1K+jLVZeDo9nMzQomPo2P6QA6imu6ulCImu8uqHI15IseBIiKDnuLo9Z2kf5V/1H8ZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WCtI4nRV; arc=none smtp.client-ip=209.85.222.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WCtI4nRV"
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-966c74ebc1bso1404401241.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863084; x=1782467884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMj6/kEzjl1ru5UHUZhZ/YyeC10jEp1W8ogblv+QKRE=;
        b=Zex5R9GW8LH8evFVNcC56LxqWUJcYM5xgkY1o4witsLGQ6IfEMXoAuJ70HTXC4OWOw
         WlDC87tHJrZB+H42f37kqhR8dXMsCcGHX+b2d6pbWUpiURgq5y6hf7qBVvyIFg3uAUV6
         ISbkUaPwg7V+Mj1yPlZ2SUeVhhpZUWQoKmmtIKUxD0lgN7Uh1xMhg7013aaZN/aB2GWl
         kvzpG75eSqglKrEAJniLC1e8a6MGZS4CB+ymPqd3Ds9FUY4EEbIxbzN+00/X8M7V/tCw
         0Bo1gIas9XUD9h1SKkaJ2oaZ5AXsLiI97MwrVmdQejMfafniSNJjJIZqxNhwvRG2ZcZo
         CdiA==
X-Gm-Message-State: AOJu0Yy1uACbzXKCe33BNHBjyJFs6RUglI/h07kCpksBlYZCzEJxuHJv
	/CoeEPMAuoplZyzSZhesFjiiCZMtiF0lQlSd2ubcI8vJEG0n95m5a6DpXshuNmeTfQgGdhpMIUq
	qpqXxvld13+L4WAC/5ky8SYvM8IpOXXmggkzYpTiNNIeE/BjCZIfSfzsdm4OZwn1Ew1RHqYlS0/
	SdJ/lg9zA8WDb1x3P3IUx28ptX5EOqEOjbauZvgRvSBjcRDzjEHgTjKHVe1OpdQfJnXMO2jrk/c
	XRv0EksPXf+peUR9g==
X-Gm-Gg: AfdE7cm6mvKAxyAuHH7YbcRp48pp0naEmDn8haXV+OVPXisMZJIXbVIRS49MVygqDcU
	I8RTo9BGw2qlAmQTiy3L/hjywDC/iaVYSlfx3/MVJiAWtBziX1jdRr2eOHMiG8kqOEpX35iBrSV
	qwjdqJZaI3vqvLH/fyVgl1keYe5idOeWOvzfnam9GfUIu+cm0i21K3xfKs6CxtZmNgcRecYRlpX
	GDXxivNOQFE/KtC/RjbfAS930pLwnIW6Uc/2vuL9hVwS/Oqc8XI5/4X0o7rFRCaoNweOHIA313d
	TgF9wD00As/DpxhOpMhnRCyHdtOQa740+hGMuAujQrQ+CPCXHx9alk2bdpsDdwPaZ0YczUcJdOa
	rGdT1+EQN0B388My423pSMfZOr4H9j+KcY1agipzitSPmEgNKv2WNpUOgSHCVKSZYHI8eCJ3ncJ
	wwyRVZs/um0ucT0J3tYydi7iIR/9FOmx9p/nSArUBd/WCEtwN9F/QI
X-Received: by 2002:a05:6102:390d:b0:643:80f1:350a with SMTP id ada2fe7eead31-72a0154bf73mr2372863137.2.1781863084322;
        Fri, 19 Jun 2026 02:58:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-72a3491308esm152545137.12.2026.06.19.02.58.03
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:58:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c13bb8ca9so206613eec.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781863083; x=1782467883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMj6/kEzjl1ru5UHUZhZ/YyeC10jEp1W8ogblv+QKRE=;
        b=WCtI4nRVRHE+sflh9YeAaN74he+ZXuZaJvY5HUjbJtJlqv+PUhtodFVxLqL2N53z51
         Q2HDeIwK7YTQeoSY/EtijfweP/J3Giq1GqWybrdnhnsDE9IpG7XQ34fmoAC+a0wFwDKY
         XjYcsXKwXq1oyyyfGhbpRrTHKbvQ+xj8wQGpA=
X-Received: by 2002:a05:7300:cd8d:b0:30b:bda8:a70b with SMTP id 5a478bee46e88-30c06fb6c08mr1706542eec.4.1781863082691;
        Fri, 19 Jun 2026 02:58:02 -0700 (PDT)
X-Received: by 2002:a05:7300:cd8d:b0:30b:bda8:a70b with SMTP id 5a478bee46e88-30c06fb6c08mr1706518eec.4.1781863082047;
        Fri, 19 Jun 2026 02:58:02 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06d5bec5sm1851910eec.26.2026.06.19.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:58:01 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1 1/3] netfilter: nf_tables: always increment set element count
Date: Fri, 19 Jun 2026 02:28:48 -0700
Message-Id: <20260619092850.1274076-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
References: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Florian Westphal <fw@strlen.de>

[ Upstream commit d4b7f29eb85c93893bc27388b37709efbc3c9a0e ]

At this time, set->nelems counter only increments when the set has
a maximum size.

All set elements decrement the counter unconditionally, this is
confusing.

Increment the counter unconditionally to make this symmetrical.
This would also allow changing the set maximum size after set creation
in a later patch.

Signed-off-by: Florian Westphal <fw@strlen.de>
[ Shivani: Modified to apply on 6.1.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 net/netfilter/nf_tables_api.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0c4224282..ec4bfe53b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6670,10 +6670,13 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_element_clash;
 	}
 
-	if (!(flags & NFT_SET_ELEM_CATCHALL) && set->size &&
-	    !atomic_add_unless(&set->nelems, 1, set->size + set->ndeact)) {
-		err = -ENFILE;
-		goto err_set_full;
+	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
+		unsigned int max = set->size ? set->size + set->ndeact : UINT_MAX;
+
+		if (!atomic_add_unless(&set->nelems, 1, max)) {
+			err = -ENFILE;
+			goto err_set_full;
+		}
 	}
 
 	nft_trans_elem(trans) = elem;
-- 
2.53.0


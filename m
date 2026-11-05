Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850599;
	b=sp02ZOlZZQurGt8ogFQo3x75ASqs/EZSvdxPjHvS2ckWdkflaYIEbfZkKCaePvdUZ5HF
	 IxAKC+OiaJVz+rJmvreO/L8H07yo2Xlr2it+Q+E3TtujjxZwkaWAd/vsAO0HFzbp6Qf2M
	 Gz1rQ/Gk3jXfciLXrWJOISq8HDKgBxm3LbKroF8KRf7d8za6YEy8gDwRUJHRIM7j6n4Aw
	 zn93dwAmb48gmN0YiGWLrieVLGI92WmkAgW2co/dsVpsPugAOaQrhzSc4RO1hctiyi+bK
	 Cdjd2qnajSnVNdN5r+SGkXUk++/MF+l0sueRnS72GZGBBGQ0RRpnTv37qq64jAKUiYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850599;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h6ndChTxHtbIhaC0ltvbH8Pm64ZG9LJKsQY5dXIKHCM=;
	b=bfaaDPpCsBWkWONBv1XSG2rFpCxd8C5CPOFFcuDGB8/ivW6JC4qHVC2j+li4EJJlDdCi
	 f+kctR37t/fIfrysUYIww/4asAbc9l7X9hKEQTJy1M4vcKRJ1fQmhf9OkqGNHLQeZeZRh
	 FPOAq9pJnosIU6mr95cf1k4uxpYqAE8kmqCNrPKeXveF3k2yn8QKw8+xsIgJgf/uvuemF
	 f1IZAjRVpLkmhuWwgpJyHD9Jr5Tfkxob7VYDPkY5WjOgyQXgKvCNZ/pAaDNlnp7qqlPcM
	 oKGxDblW/V1vQubD62HcGLRFz10rfhBzvQ/bdm1qXNemFEEYpXFJiF2931pX9EvX5nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=lCC76EAy;
	arc=none smtp.remote-ip=115.124.28.50
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C4606A31B;
	Thu,  5 Nov 2026 03:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91C4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=lCC76EAy
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793850588; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=h6ndChTxHtbIhaC0ltvbH8Pm64ZG9LJKsQY5dXIKHCM=;
	b=lCC76EAyPYJGSmX1zzwRwW0lWy0hRQg1gozIttmPEFixLIcdXxFJrdV80B+rMVNRjZ12/agk6x8IXihJOg3mwCiDMixZGC/BVvUZS0VrSa6+nYKz/ytzJRSzzN5ccHJOhjO6e/wmaBJHpTF7kqTYvc71n+vCQvcKzKCfXp9n8Zw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2552083|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00781532-0.000679782-0.991505;FP=10230451583523169632|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jxEROSv_1793850586;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jxEROSv_1793850586 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 11:49:47 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhugl3@xiaopeng.com
Subject: [PATCH v2] usb: dwc2: gadget: fix off-by-one in ep_from_windex bounds check
Date: Thu,  5 Nov 2026 11:49:46 +0800
Message-ID: <20261105034946.20566-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

ep_from_windex() checks whether idx is greater than
hsotg->num_of_eps. However, num_of_eps includes EP0, so valid
endpoint indices are in the range [0, num_of_eps - 1].

When idx equals num_of_eps, index_to_ep() accesses the endpoint
array beyond the configured range. This results in an out-of-bounds
access when num_of_eps equals MAX_EPS_CHANNELS. Otherwise, the
zero-initialized array entry is NULL and the request is rejected.

Reject indices greater than or equal to num_of_eps.

Fixes: c6f5c050e2a7 ("usb: dwc2: gadget: add bi-directional endpoint support")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
Changes in v2:
 - Fixes corrected to c6f5c050e2a7 per Thinh's review
 - Narrow commit message: OOB only when num_of_eps == MAX_EPS_CHANNELS
 - Add Cc: stable@vger.kernel.org

Link: https://lore.kernel.org/linux-usb/20261026031138.35911-1-fangxy@xiaopeng.com/

 drivers/usb/dwc2/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 0637bfbc0..b2a25cd5c 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1582,7 +1582,7 @@ static struct dwc2_hsotg_ep *ep_from_windex(struct dwc2_hsotg *hsotg,
 	if (windex >= 0x100)
 		return NULL;
 
-	if (idx > hsotg->num_of_eps)
+	if (idx >= hsotg->num_of_eps)
 		return NULL;
 
 	return index_to_ep(hsotg, idx, dir);
--
2.50.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725161;
	b=ysjb/AZOG2adA0UwjCPQeNu5WAisXN0GahwEJten9/dsHw/lOZoxyWikhfaK8PcHmxxx
	 ZlsmxY9wuNppmnXkt18VeVOMmTueDgkgdxTmWYIDOCm1K35cFduJbeOD7rZC8jwxXsqLO
	 27bRrOcv5X4K1gJpnnerIH2oG6fZyDURroaGpkUynuLgxmJ8TJ5RlBYojHmJYYo6Wnx0+
	 lcNeO2Z+VQgrt0V1o8TeS1HKahbt92Z4yBbMhNfkjte1alwG2XTkBOERqGLaksrhx8jC9
	 tGf6ICqfh0oBozWMEa9bq8+qO9HbopD/oO6DVT4Q81MuVF5sku6kuAoi2xzQRphY2qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=x1NI3skowoAtNdcXptzYo27srndyE5ZnDqWHrHmy4U4=;
	b=5XqMAGMShOj3liEk0OtPoSwv6BaIT8Aailz1vHAGTwRxHfz5VS9uAt0K4k2Kp1ttvNi9
	 kmOTJe6hE6rHlI0kA7uw7/aYsQwoAd4K9ru8nJDpMqHkhUNt6NnDU/yPROFvOciKDe0kW
	 VLPN6v5HUC8Xd346P3O+MhJ6rxWj4SJouDjbVDoV1uQ2l+rrGqH6KcyhZa3ruamckdhhx
	 KlpVOrrbuEOLnH4iQ73O/ei37D7isT7ps3lOELdDr90Fx/qqny0u1fOUBUhSUUlNOiUnm
	 PwARMni/05spkprI46Rzdl4FA1UJxvbHwSrmuAdSg0AQgeJWHSo3UsWGIKcDrY/TUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1password.com;
	spf=pass smtp.mailfrom=agilebits.com;
	dkim=pass header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=HvE6CnDk;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB450606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB450606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=HvE6CnDk
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-945ae2daa3eso330295885a.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1793725160; x=1794329960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1NI3skowoAtNdcXptzYo27srndyE5ZnDqWHrHmy4U4=;
        b=HvE6CnDkjqXySwNnSQZMyeD4DSmhSNJZ5RuJy5b40IJ8vc3t7iydK31t81eeeIpz0e
         ZBLyyMJH+Z3iDY+sb0OebSLGqPrZy9R9RhUXkFrBvJT0VjU+YQ6c1S/inFLyGnz3EY9t
         Bdaj8s+/76t7301785EuSYGoocmPSroSPJJNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725160; x=1794329960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1NI3skowoAtNdcXptzYo27srndyE5ZnDqWHrHmy4U4=;
        b=mBW6zZS6d+ug68v+VhUDSQaCM1RLbTdJhvAKPFfkZ+4rwsLhzdUSHqJXkQZ+Va7W52
         BFVcYiLEuBNpOZR7ADq1chZgYPE4uSnvhuDNX+77Fy6dSO/hTi7UlyphDL8/2c4s2FJB
         F0FJWJC/Ofywd9HQ0aNMyYpXKTkVpoW1HFihC1b+qfwDJQKUv2wIllGrpDeaLGwXSvXG
         4pjmPFgnODkiNLYIcidta7+freVjFdSJ/KcCvS2gagyuiItKw67bB8UAJJjvCs018foa
         vZzGEOUSR3sIGm1zOg/6B0MTMQSvp11rK8+zT0TrwYPCW5Bx+F6ctLKFkw7R77X5PwEZ
         hN7w==
X-Forwarded-Encrypted: i=1; AKwUvBxWUJ06g39Moll4MDr4CMsfw0yIG+jAVBc3Rd+ywDcS/YZQqisbQinTQXA9DvLPzJ0iUMFCFIA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V6ZDi1uzbaFso/4ZPqYDqfgXkqeqce2DvEjd7zkmiKuALa3X7
	8nWpabtU2Ib7Lrefprdhf0NO5NwtLkBXYGMQg+fUFQeVeWw1K2C1G70DFJDtP1rn7fE=
X-Gm-Gg: AYBFou0D3koSYhGx2bh4jTmyX/NRtHwWAeBkeP5zJXP1Jqm/LY2l29oT8yIa5rsyA0A
	H2pThyokA46dlFwrID/MnJi0RFo+MdYm9tETZToBfe199h+mQltuvQrqzfWqdADSNBcIPUawK3Y
	G+D15Jf8EA9sgotAGoodTsEKc0LeSuDrpTcBmz4trLGcr/27w2+SfRLcxIJY/17FXU2wIaZf8pL
	jKr1s2jI3SSVJnCRq+Xr8711VbgVNfz6bVULjNvWwqgv5MRf/22fGZG9gXFQKdqhx06XFEj/KUf
	k1YLnRaYubXd8BNblM634vsWC59j2rkOTzZEgP1SaY/znEzjLKTw8i+G1vq+i0qn/kupcmb3VQA
	At3PrMilV7tjhRtBwDxn0ZhMVeLGNk8P2NvcCo4hV2XfBtf2eb/2y5hTdXntiQCmVP1TyA+Q9/i
	TQCjp9Z/yAX1xk78bZXHlQ8HdplrLTJkBTrBEp/5GdrGXJfSZMMt5TKdNcJeJhkZDTeN79TYueI
	P5FqqKCB6HON9yHNFw/d/ycJy4mpjoEtyPN3D70hx5919yoefg4Z+0X5RoZPmUEtTy35AgUBEa5
	4UJjPRp7fICC8bw3nsvYR/np9YFT0AgUIW8C5Lrvp0nfcA6jl3/caEDThSxY
X-Received: by 2002:a05:620a:4385:b0:93e:5eaf:dd87 with SMTP id af79cd13be357-944217c1057mr2138536485a.62.1793725159609;
        Tue, 03 Nov 2026 08:59:19 -0800 (PST)
Received: from localhost ([2600:4041:59c3:300:a850:2af1:eb93:4121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca8066ba4sm120593986d6.33.2026.11.03.08.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:59:19 -0800 (PST)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: ja@ssi.bg,
	horms@verge.net.au,
	pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	w@1wt.eu,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	stable@vger.kernel.org
Subject: [PATCH nf v2 2/2] ipvs: skip cport 0 connections in ip_vs_conn_out_get()
Date: Tue,  3 Nov 2026 11:57:46 -0500
Message-ID: <20261103165746.39516-3-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261103165746.39516-1-axel.mierczuk@1password.com>
References: <20261103165746.39516-1-axel.mierczuk@1password.com>
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

ip_vs_conn_out_get() does not filter templates. A template with
cport 0 is matched by a packet sent to client port 0 that traverses
the out hook, and handle_response() then runs ip_vs_set_state() and
the timeout update on a connection that must never see packets. A
backup server receives such templates over the unauthenticated sync
protocol. An ordinary connection scheduled for a client that uses
source port 0 has cport 0 as well and is matched the same way.

Apply the rule used by __ip_vs_conn_in_get(): a lookup for client
port 0 matches only connections flagged IP_VS_CONN_F_NO_CPORT, which
still wait for their cport, and a lookup for a nonzero client port
matches only connections without this flag. Test p->vport, which was
already compared with cp->cport, instead of reading cp->cport again.

ip_vs_ftp_out() relies on the first case: it looks up the data
connection with client port 0 to find the IP_VS_CONN_F_NO_CPORT entry
created for an earlier PASV or EPSV reply. That lookup keeps working.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Axel Mierczuk <axel.mierczuk@1password.com>
---
 net/netfilter/ipvs/ip_vs_conn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 94f25fb7d87e..29cbe797bb86 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -579,6 +579,8 @@ struct ip_vs_conn *ip_vs_conn_out_get(const struct ip_vs_conn_param *p)
 				    ip_vs_addr_equal(p->af, p->vaddr,
 						     &cp->caddr) &&
 				    ip_vs_addr_equal(p->af, p->caddr, saddr) &&
+				    (!p->vport ^
+				     (!(cp->flags & IP_VS_CONN_F_NO_CPORT))) &&
 				    p->protocol == cp->protocol) {
 					if (__ip_vs_conn_get(cp))
 						goto out;
-- 
2.50.1 (Apple Git-155)


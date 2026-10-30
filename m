Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321421;
	b=qeJIfu5KXPL3XIFnhRlb7V8A8lbgy1sGIV4GBgXzqsTjJoJjosbcA2RNdm39KiJ5Fe0u
	 vQWijsZRJIwy1+1qvuca3Dcx4x/Lv9dXrxhVRor2ANF6tAb9wEouzeeA2q8g1v1Zd45FI
	 T64TowC6dt78QyXGKo6yvgpRyPlGTQkNwxFTyf1FBa2dGZUYAFaA0gOUltTZRoY7huQ5a
	 xHqzn4Pc4ssYuBss9RMqBU2IS+hPnQFUm0ycGyvANqnc2OWo14BBcJOMgc8LWwkfiqr/r
	 PB3/QbL98xcZLx4J5VZD8GPhHubSZnVtb4xV7XzKx7MdTMZqY/yxxyIj3b/yAziJbNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321421;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
	b=TTjp7GF1aMESBoy9AaqGuLEOWN2OJHZ/ViITC1GApq7Mcy52KhJJTCgMVCGWrcioMep0
	 cJuHdv9/vJfpUX+vvFMe+Nwul0RiSkPZBbVnbfXnhcR/TZem3hvMBxZpvgMDP1lzYSTJY
	 WTmX0kjpYz/oL6h7YFUc1IDFivmim4wet59i1BP0eLCpA3vMhHqgJxXX3bvJuA35vXLLb
	 AumknN+siVsbcbCc8InAlJBRU1sVqPgvtAQMLP0ZkCZhdblSllfstS0Iw2EqqwVnB9KXy
	 /YFAlnN0shHbkINWjPzrdoxTmoo208azvXlbskUydgjvYvDQW/NajKq7ZwcyKbcCanA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ajc63aW9;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA87606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 00:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ajc63aW9
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so92034a91.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793321420; x=1793926220;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=Z+GSyRSidPzNNPNcF+mG6/RGlINrxq6T8ERPqoJIMN+OFi2kSAeSlR23T5/AQT75lZ
         rf3qWIhdRF33ndFGnw11hM8YFuJSz6Or4q3j7sndyfLouzsGUexSnAo0BUp0Jebum6V6
         MHG4qSVgE5Agd/DsKAbBdx6ujryD6P7acJzqap9qv6CsIYiXppYmRRB1p01Ba5SSmiuI
         NA6V8yAtoJ6CWeHReE1zm4xRuB9dRC0kW/qP/Rewo87DlzYXGze2GxthygyLiRr6MaxJ
         MHGyQMkfwzD/wnBvMfXpG44ztn9FYNx3Y5aS2SU64gELna2N/+ZQdwY3U8+Ax+1/151t
         tN1A==
X-Forwarded-Encrypted: i=1; AKwUvByHzt9dOnwRMskXz+Us9LtqXJpPQFUqKnY2xir95WKtZBZD/IqUiTd6ZpIuS0oBP7F1lp/v8tk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ51eLLyTdycaQ/wVUNw+/dFB9LFrvf8PoMGr+qFjtopAq6mAJ
	1CEfCgjaQWm8nVJ9BSBZ2rab0AbmrCz+kjawQD1+3/2kaPBZfxuoPGh2A49dS9TuxjPOK60z2H9
	clRx8wo5CceHir90TfNqiIvgpAUvH6giTcokTLYZhk3ScDH4xZha6nKWfqAROVIKzDNbXYfS7qg
	0kI0HGZ5TUm0axVOCl+bhJA04DuoLlc1Pisf1lrRm4bxACksXg8fnqxLg4aTmh9t3vbajXoxRA1
	ptYZDv+e+iPCHDi
X-Gm-Gg: AYBFou33gPV58R+jPaHcukWXjUBOtkBsWcdAq5kp7fxP04xSjmkSVJ+6iSzgMnuO2a2
	PT44o1qI7vxZkStF1Oy/Xkx4bZ6h6d/Bv4ItkXsrHKyIEXVvE1/IIpduAoWrRq/bS1HS6SHUBOH
	sBJDa2IdIZWmPsIVraubLQazEXHnM37xJ4U72iS2vxKkV/szPnjA4Lk84uV1CF6EOsMuhuxQky3
	3EisJ67UBRbM4VglPczr41ZrKy08KU4nQe33t4bag1HqXor/Rp+tQ4P9m/QC/LcRHSCEtLpTCaQ
	v4ULYhGGjsAZg2TD/UAJr0Zgnav1rV91v3N8nnBIbA+yHUNTYPlynnFotoc6AdLokv7ZlGxPpoj
	Pl7MutjYaNftTpmJPjEoAhb9BB/Xbmn5V4298Z0ojUZ9jvvWWqUK5iDHyhg4Ez7YKpF4bHjfTYU
	iU4XnnrdyBSZQ8Qr5uOrhW7pCrqP+b8MCWWccUEqzS
X-Received: by 2002:a17:90b:1c88:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3ae898510b3mr527938a91.53.1793321420335;
        Thu, 29 Oct 2026 17:50:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85f87a56sm344880a91.1.2026.10.29.17.50.20
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 17:50:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93909014c85so26388285a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793321419; x=1793926219; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=Ajc63aW9Ew1hm+Kyp63OASSAzjln8RhJ19fWH55BOI9POe4sML6ZQ8Lc9YFk3r0pmV
         c6Ii+OlobePH2+8/QgSf3l2Wr05k0Gquk81ve8Nj8XGU0zxdVc7qW5cigkG/UoRCF9ke
         gSqcsYymOikZrfYk0X1XJ/wWbbhDXib2KUbJs=
X-Forwarded-Encrypted: i=1; AKwUvBw5XmbIkEz9bcS7RttYU1XKcGmZpoT4XChy0rJqHpwkf+jYlnY3wzUSYEB1+TvVQZuoYQMTKTw=@vger.kernel.org
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id af79cd13be357-944217bd696mr156469685a.47.1793321419204;
        Thu, 29 Oct 2026 17:50:19 -0700 (PDT)
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id af79cd13be357-944217bd696mr156467485a.47.1793321418692;
        Thu, 29 Oct 2026 17:50:18 -0700 (PDT)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b293sm6674585a.8.2026.10.29.17.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 17:50:18 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 17:51:39 -0700
Message-Id: <DMHREZLFJ65S.3CBW2WL5U0DRS@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/vmwgfx: avoid underflow when stripping short
 GuestInfo replies
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029215738.3010276-1-zack.rusin@broadcom.com>
In-Reply-To: <20261029215738.3010276-1-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20


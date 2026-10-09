Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C644AAC50
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549690; cv=none; b=fSIn/2sy9XDTpCsw28202FDwy3VnPurzcPyToLd1U3F4zSKaLNHhDsL81tiZwKbL73+j8q7STb6HRtr1T3O5Gk22V5QtgALuMt/QgZD11RcU1xfvU+sot5SuCh2APL7DT7tyubFPhjSlhR3OL8BJFQPrHDX9BpMTLHUhTnz5UqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549690; c=relaxed/simple;
	bh=PfNhsuzh4AOEts9llViSuzmKalMWMyZHXZnTes1rkHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iECXowtvjofHD42lBvta+r50+RDqlsAwoBaVxeKR/IX3AjSuu4soHcEzc1KBAW5uSUj8wnAxKdBRR39hyd3p8jterWl/252FCVZ6B7UFwHA0ioiP4qrN5TowDkxDL/vK/jFKFPZhZeUE/X6pldCbLZMq5snqx5tvLmfVtSIVIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgyw+bYU; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgyw+bYU"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-4511f6a63edso745218fac.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791549684; x=1792154484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ryl3WOCqZhMHH6Gxb8y5ffAOVmJr/vg7ENqE2edW0CE=;
        b=lgyw+bYU4JkFYG/IjDvkSjBGeDmIHjZctUFElep4Hb1KTsjxK6gcev5mfkWfYxqVSl
         DUYyYFvRDX5jRpMgdm+5XqryPwNIxGTFyIcwNn/q624CnHYdWa1kWMz0liUc04BoBt38
         1d+/JR42mo2uzyiwAOU1rqj/P9p36vpV3kGP0AzeKWhDy9lthwoA9Kr6E6kszuaQiRVa
         9YP7n84fdnzoSMUMkmQF+6jo/qd396sqMqP/1NnDZjXcfCH1wJCUvjOavfKQKJpI/VJv
         0Sd2OCpBsMnHsCxBH6bMdpe9iHPhY5pSZUAWntwpmVLrvynieGR21MfPSpiV4TpUgWAw
         YPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791549684; x=1792154484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ryl3WOCqZhMHH6Gxb8y5ffAOVmJr/vg7ENqE2edW0CE=;
        b=d/BI1skw7cXJiX3BjNfwWPdyKJ0T/RkpffTpBzEK4Z0ElX9tu5HASoaB7UuQPTlbZY
         5/BYsnU49xh78rPt0Q8p9cCYDEXHFUcZRwmVycMgAhYhqoW0ah+U+ZXSMx+UCnD0TbQu
         2o/a7BlDcz7ZZAN7GQJkpwzvneNPqSYszXjQb9HWzo2hu7owOkQzioAfX6wKWB65tnMn
         GYsY3VE9NV+I5C4RfaNWsS6jomt+8ReLhPOGIqqmH1Q9ezHvjAT95XiRqfcwujF+xWXk
         56lis7lKLxfh7/xvDk3CG352T4oIPsm9EZ/NFIVSIpnwBVuMLM46rxAdojBj2z/ZsQKs
         Pv8Q==
X-Forwarded-Encrypted: i=1; AKwUvBz+Ip41UNcHyS9Rn+UUMrd3Vb1LWTS3I4UwUUz8tWWe00W0kFVYW+7PtUBNPP/ycYc07VxBOOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lfw+U5HpVDIPLUiuTATWVkmG+/Vek2yvN0krYCMYqOO1N6PED0
	+4lBVtVp9vj242H1A1ou4Wc6vnb0/cG+0mgOqNrSMjeCbId4VnsISvqg
X-Gm-Gg: AYBFou0LfqWFZaeSli5A3X0VT8noSPUAry69Gav7eUYo2ktV2oMcMLuHpHeM7uHNnRu
	TTg4mOG+RErIAQMkm9y8GCMyDiZT9/cU+7ncnLrZIEteT8FmG1L8YPSZBZH7q8Ss/qB3DZSRikz
	zL10DNRiNDAI97jnWquDex6dsOuH4x9DZGt+tyHk/Mew5RfWvXSKS+hHVbU3aNbyfsHhFNbO7kS
	a/ExoRSOvwS87U0trHt7gAzCRI1qiP8a3FGnTnqYCXa/Nw223uJQoIzTPS4sbNJvGFYGSvcs4++
	RRDji2Fs0lCYMPsjc1XXcxX5ZlTBrdt8UZqRneMMHO/59NXDrujRaB7ubkyYAw5RdMrPnHIDi0q
	3FC0FhFOdQFKQTEIUjgNoVKgr7prl7KP0EcBunPkjD+ZrYiH3ddrRo/Z3Dps/0+LshzCyCP8Wmr
	yDtZIIVmtZkA3V9lTRZuGhyCHh44Uf8x2oikb6p42k+chi9nlk2hoK1M/H2ob44agyr1Y+W6H6L
	HE+hCiy0bYkq+e7z/Io3FYJ+i1WwOVF0UxDeQ==
X-Received: by 2002:a05:6820:1c89:b0:6dd:6d12:2305 with SMTP id 006d021491bc7-6ef08e71af8mr1263442eaf.3.1791549684102;
        Fri, 09 Oct 2026 05:41:24 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef00520fb5sm1492829eaf.5.2026.10.09.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:41:23 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: nf_conntrack_h323: fix NULL pointer deref in decode_seqof()
Date: Fri,  9 Oct 2026 20:41:16 +0800
Message-ID: <20261009124116.3950469-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eight supportedPrefixes table entries (_H310Caps, _H320Caps,
_H321Caps, _H322Caps, _H323Caps, _H324Caps, _VoiceCaps and
_T120OnlyCaps, all reached through the _SupportedProtocols CHOICE)
are declared SEQOF,SEMI with fields=NULL.  decode_seqof()
dereferences f->fields on the first loop iteration whenever the
attacker-controlled SEMI count is non-zero, causing a NULL pointer
dereference.

Return H323_ERROR_BOUND when the nested field pointer is NULL.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 6830c9da3507..4d66db5bf5f7 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -692,6 +692,13 @@ static int decode_seqof(struct bitstr *bs, const struct field_t *f,

 	/* Decode nested field */
 	son = f->fields;
+	/*
+	 * Malformed table entries may carry a NULL fields pointer (e.g.
+	 * the *_Caps.supportedPrefixes SEQOF,SEMI rows); treat them as
+	 * undecodable instead of dereferencing NULL when count > 0.
+	 */
+	if (!son)
+		return H323_ERROR_BOUND;
 	if (base)
 		base -= son->offset;
 	for (i = 0; i < count; i++) {
--
2.43.7


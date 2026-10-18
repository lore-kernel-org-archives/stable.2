Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862C4ACC7F
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331372; cv=none; b=QAt63iHSJPHL9mVo27bdSJkHLtAUojv+ugqdJNI4A0ZLTcwzHGnWpPkH2gpmHrXAQKx/182GnBZtNfbUWu9elVan+Ft11T2nmFGbMyCF/V2kDor2D0hlTlUfAib3Z8DsWMnpYrJHCqmLaiS1p64+GloQ0XO3IyyWAmI9OTBETVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331372; c=relaxed/simple;
	bh=zpl50vYkYsZSmjFnlHACLXORChUB5b5D6PYRX3WesnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvyFY3LJ4h2K56b54RnBD1CN5yeCxCi6loYw9MVh1efEK80bzaNR1p2EGxSOnvYO6guI0w4wWdx/Px3WBuCc1YhhJAsCSKnfkSTnrJxu5flFTdMFKtvU1Epq4TVW/0+W6e6qLiSTtj0VAYPWuR5EqbnygJ+0I+Rap/WaHW/+Oxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQUV0KNb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQUV0KNb"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso185205266b.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331369; x=1792936169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMxj8Cuy1L8WOHlx+WIj2otsX/xN7hQdQoq5GYxc9Ao=;
        b=MQUV0KNbEROblxzdWv38Htdt3SaFMxh1VliYdx/1B6U2dh5Cfmmwk1NdVVx69AI1iu
         CkecRTcLhELPEnaa99rBoQMP/ibyz2E8xXlkXY1pwxVbRFE/PlJeJrGowTDcSP2Z774w
         Kb4u6hZ3YoUcKE0GByrobYGDcgc+e41FU2etPeKphy0d7R5ZccxV9ozE2b6xZmudmszK
         6zDSMFrEzx7qcrpIivpmuTdJrSnUM2XMwrHilQDC6Ei9CMuLNmdWjuFSBSp0n+LwSuHh
         BhgT6IlCF7VBdFG7YHqdy1bhMEDeXCTt/OSd9eVnvW+PpOs/fp9pnTXEKX5TpXHLJ+3R
         FiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331369; x=1792936169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMxj8Cuy1L8WOHlx+WIj2otsX/xN7hQdQoq5GYxc9Ao=;
        b=SwQQhhXCWo6ArqW6uVy2sW/yP4CUIXYE6NV5vxfP9gtJhoYEYPSwWj9Gl5StNdwau5
         qHL7XqczBMxGidq5wdtOwHx20cppTJq4vytUsMSdVcj0X77vVFq71dCazVtgYMmSsSgi
         nEFUhg8B0GVPA6DeRcEMWD3j6T9ULtyHrXwhl7I7QvDoNkUx/OLIqHdmt+c5dBRUxy8b
         BYJf2LYoW6aEjpEohDDuHyrfnPPRmoDPbEbc52gLt4HOXRxRa8V4VW0M9d3HGQ6em9m+
         6QJVpCsWmCh7/pvqouxIkcZLhWyD0hLPPXDFveOd4tfzlXZ4FHhogTDY2Gl1Pn2TtDhD
         y9wg==
X-Forwarded-Encrypted: i=1; AKwUvBzxCPVF9Thm5ZqdSPZpzaY/OMCFFJYRTO+3iSKiesVocu3yr8XJsMXC5usE6VzJSiT5ytylD0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWTtf1BdtuJxat5YcaUwYRwa/yhbIZ46hnU7Sbnbue9Pp30LWp
	66/zIJiSdA9G3p0xc3inI2fBKOfEOmx9oFXFM0VOpxPBXBHHsiJNwMeR
X-Gm-Gg: AYBFou3gVgYax9H0/NhaVfVzKtXU2c9stzeiEgSgQqE9EUZ/m91T20vqWQHX4719dAy
	QJOFXnMoFcSeFZzCRL9GiH9ZZx/LIfMkhHEcuFzY84jLkthMr/POSVzr4iDPXWcOih4+EncOtgH
	Wolxkle53vTbtcQM0hvTx2rM5lXVqWieX/G9eNFsmYSSaahSalf9TfjfXDb1SGjsopHGjqH92Gz
	2nd/No4E7CiO39TruiMLK9X0s+UJQwHlNB91z9npt6gR78TqBgor31PuLOue8MBblDe/sZ+yuSB
	9rTRSaNh/cxoh/LLoC2jh5zN7GmHEGYb/4e3DLwh3e2pCHpfdjxskynZHgLCjx+dL56uKZwyE6S
	v8LTHqL5iT2bpa332E737pqFVgkG3VnsNj40tKLoMiccorVuQqPSEnYh6+QogSAsILknSVlBko6
	cP/S27M5XMiMc4+WCvv0nzoQbFQUOchUlCUHJVYMGF7kAcrIjXGsmNjJlETTkr0B+a23urA3wET
	2/8TN6KOR2c5NvqeLNDvoqTXO6FilGqPC8VQ88t
X-Received: by 2002:a17:907:c80e:b0:c44:16ad:c31d with SMTP id a640c23a62f3a-c4416adc6afmr28611766b.4.1792331369203;
        Sun, 18 Oct 2026 06:49:29 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:27 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 01/10] sparc64: return from the generic clear_page implementation
Date: Sun, 18 Oct 2026 15:45:03 +0200
Message-ID: <20261018134738.1016106-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
This executes 45 extra instructions, including six stores and three
FLUSH instructions, before returning.

Return once the clear loop completes, as GENcopy_page does. This affects
processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\
-- 
2.43.0


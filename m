Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669635E1BD
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919591; cv=none; b=PIn9456Eh4l5HHSO5WoAyuhHe7PaPxu3840CAUDu73DZdHLJKJvwDqH4bYOMkWg6HrgCo4PM5bYhQYT59bFaRLalE0pfixsF0Y0UpJD1o2CUMUfJ/3pkiTOyCt3FSutNpTTr0VOCRUEWZXAsc9n4J+VQFSuAev4UvKaXQpDcYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919591; c=relaxed/simple;
	bh=5KKvZn6IaZhVYrolIjH5BvTvKhdtgpU2i+18MXjnZJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szJopFlFdhqaJzNyRCk/BJwsSJsqrIsyN/azML/2VtLfZbBpqTsocZUog9ce8vpRN6t+5pcjJPBRJIsh6ZlFYXgXj8w+M1iED74RGaacTFuI0VntvisVfwF+HLWZZa5qYkpV6o2enZP/Op72Xcke3zAxmnX6w860wXnb1Uodfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeXmLtxY; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeXmLtxY"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f01363so45232855ad.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 22:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790919589; x=1791524389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHPDs6nkeRx1UXviyEr7eXV4Bpi3Y+X0rLcUXCBs6zw=;
        b=DeXmLtxYL39qCB1bODhzNM1yCgR1u3discL2qJUNzSnht0Ixm1OcqdghPV3NC5v/De
         4lt/g+8H5TdHt6sqYAEqafYe/2PWvatc0OzLCkUmNSQAM9SmjmEfkXs99UZ4hYs8VE/S
         LBMITEEJIybckC+uap/AtlUMz6n/TUPEr5SptOYO0Gp1gwzGhRGq2T61HJD5JG4Mt2AW
         BgsmY12fR06a/YcwXKzCtSvXgL82PF4aX+xBp/KLScNbmZkBgU2T+wZkaRnXiFDFGwu+
         Zzt7FsFAaASXkzF79LFKXVeU28FdXLyOGv3YWdEpb+SsQsmJ+Pdl75BSBsz75x+QGKrj
         7pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919589; x=1791524389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHPDs6nkeRx1UXviyEr7eXV4Bpi3Y+X0rLcUXCBs6zw=;
        b=hlksWpUhgJHFKJzV5lmjNp9fl7WxlTGylc0jO2N/UJcSFOuAY6KNhZwNrJnmWlfElL
         mp9W4gwLurFF0UD1J0KdLmA/8ICk4/eeAHG2oQKCCNtunuPMdidG7qTP9gQnUrqAP4Us
         LyiNpfc4oyu/y1wBQ1Ze9O5NjxHXOUwBkXBG/8w0LoLoHWGPqEpdB6+EPgOLM5sr3/lH
         fkm4g8Av9urAaR169b/Lo79sThtW4XOsif9gBBgStoLJJuCmHCFSlQ51AM/E/Xqxt9HD
         2Fe9n2RmIhVGmaYE7b5EiaV9qzbD4T1i4ZFoYwicuZdkrbbBbSrGeGb3WgkQA3Bye8QY
         k9mQ==
X-Forwarded-Encrypted: i=1; AKwUvBytkIIy8kC7WfarQLP3FqXZMt2In/zJpsVo66fkDPvjkMPf4thDS4QkbixBhuUoauCdh6E0i/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb/ZWZBTV4szWiIDH4JAdVwCFH+A38MMHeHoMvuFbpBi4qdEmk
	Sjbnn105TP+bGlsxZmZASOv7ArSljf1ZalQ+J9W2BtYX045ZSrqvGyfrRFYnFiaz7bU=
X-Gm-Gg: AYBFou04s6DM2OwIEbQUABPxvx0JrGlwUjnCLMTm8b7xfpL2NP7aJE0236WeyXoFgfr
	ulKQ44JD8NBiTzLzpuiJ3SFXcL26Ii2PZDDlu0dK+3R9EiG5pOWOefB9WYy7zrWH7ioCKOSnTlb
	zatJswJ7HpmUYE6HkU2WkV3tTqvpKvdUCecYCHtYf/rPSjBY/V35rWc776LcZpNzB9BLDSzBDKt
	rBKL5QqQbGgbPgM6HZo+1cwinVkpwNgzkCqTIU9RTebHssakfm0nlurTqs2gGynTYHtx8MwJDAm
	rqWOSNzsNXM12RZ8ru8RfkHJVDXf5qLa1Bqcg1gPyIBnx9JjOiB6V3Cv5ephkHMPUjHwkKQy7qq
	iXcRCYYqQVurktHY/hlupQ1G7xNWHCgRPup7To3H2eY8ae3YWbxpbuTfebZeIs5cwPJf4e6rnAh
	NdxftOPNsYtFm4pRgfUGqxk9evlmHJJnJsjiEzFAIJpVrCYU0Z+vnj2t7mMz34ywoJssRNUqGLW
	idWX2OqcDE=
X-Received: by 2002:a17:902:dac1:b0:2e4:b37a:d583 with SMTP id d9443c01a7336-2e4b38a215bmr631455ad.61.1790919589335;
        Thu, 01 Oct 2026 22:39:49 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e4a59edd6esm3045785ad.12.2026.10.01.22.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 22:39:48 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: fw@strlen.de
Cc: pablo@netfilter.org,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] netfilter: conntrack: avoid recursive master destruction
Date: Fri,  2 Oct 2026 14:39:41 +0900
Message-ID: <20261002053941.1132097-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ar6yM0h2zdVUU4rt@strlen.de>
References: <20261001180224.1018290-1-4ncienth@gmail.com> <ar6yM0h2zdVUU4rt@strlen.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for taking a look.

I think this check is reasonable for CTA_TUPLE_MASTER, but it does not seem
to make master chains impossible by itself.  There is another master writer
in init_conntrack(): expectation fulfillment assigns exp->master to the new
conntrack.

In particular, ctnetlink_glue_attach_expect() can attach an expectation
from an NFQUEUE verdict and set assign_helper.  The expected child then has
both a master and a helper, so it can serve as the master of another
userspace-helper expectation.  That path does not pass through the proposed
check and has no cumulative depth bound.

This helper propagation was intentionally restored by dcb0f9aefdd6
("netfilter: nf_conntrack_expect: restore helper propagation via
expectation") for SIP, H.323 and userspace helpers.  Restricting all nested
masters would therefore need a wider helper/expectation compatibility
change.

For that reason I think nf_ct_destroy() still needs to be stack-safe.  The
creation-time check could be added separately if nested conntrackd restore
should also be rejected.  Does that match your intended invariant?

Thanks,
Daehyeon

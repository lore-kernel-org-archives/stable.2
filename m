Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4C4FE2C1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698080; cv=none; b=b4wOopWlfrvpNkBqQpXMeMmsZno69+iOqMur9sMr7a9Dv63acY0ZXUVkMu87QNlblCCvYPaaxWB0+4SbtxMuGoNUb2Ob/vt7/YKlTrYtgSmyGyMoWWC1pla2aW/YHLA09UXuPOenjsEyr91SbTx/RJr6Q90CFLLpCJl7RYCRO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698080; c=relaxed/simple;
	bh=oO20afitQI3DRoBEJ+TYTGZ3k4nyS/yHP02w42WrpM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WdXevEpX47LRY+613vSuBw2CsVXlR2gIbPxv8frm+XIrFnZEUb8RLDSguJQqn6cXWveUCaND6vBq8JuKfw+fMHqZiIvli6KY77NxlgIhaUj8wH3hvpGw8i9lY7lEirEuRBLoBKU2uQ2FbmF9GHjtE/sDloacfA9hu7dMEeyTt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqFGpr7l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxoH9Ds2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqFGpr7l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxoH9Ds2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790698078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YICz6wkOnVYmVxpwpf1GoF6EDBToHXCYtSEDFbfB/RM=;
	b=QqFGpr7lGNa8eTVPqvPIpd/v7izSZOsEko30eGJWtjT/cKBkDZMp/yBJLbm1+pGPPEgeVG
	aUk6/C9D+1sv7osZPeJWCd0AnM9Eng+bv452H2GUQJuhhiTmYns3JJ2NhPvIER6BjMhoEX
	ObbVkeb7g2CJQmLVtblJkUJSTZFe5vA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-cIDULTBpP5-be3AZqH9WzA-1; Tue, 29 Sep 2026 12:07:57 -0400
X-MC-Unique: cIDULTBpP5-be3AZqH9WzA-1
X-Mimecast-MFC-AGG-ID: cIDULTBpP5-be3AZqH9WzA_1790698076
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93c820cf67dso471778785a.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790698076; x=1791302876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YICz6wkOnVYmVxpwpf1GoF6EDBToHXCYtSEDFbfB/RM=;
        b=CxoH9Ds2ARZfsdH0wvHPlvg93wGI2pVCbbFL6t37PEeCgnzYbwXlmk9aQ5yhlKI/1e
         RPRKTJaVPbyH/Fsb2BBgwNtmVAcJioYy+A81eTDX4xqepT1oSo+bi42r+cEO6ag+vrF7
         VeJfGOmEYw7+o+GSfBA6wPYvthEVe1lOon8E9qWvcl692Qoj2eU58qofD3o832JwrGPb
         DKn/Rq1LOKnbyxShJV4+b57Qy4xEUXPpXckvwkVuAxDVeLlOG3tkFgw9RLAllMt2laem
         ai6SzfeZMXgqhrvrf4mKpGh5jQFzj8Uv0yFrSJ7SaydZFpMLNL1Hyu8xH1ODbUO5PWOi
         5vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698076; x=1791302876;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YICz6wkOnVYmVxpwpf1GoF6EDBToHXCYtSEDFbfB/RM=;
        b=Rf0WSw1f+rQCg4iWfbrxcNZdMBSpxUIBpThU0YjlNI4N10nzLKPCX7EusqKUyK+gbC
         iz2JxiGlvcfpUA04Zx0Zq1eEy8KTtAm4eVwnUvSnMaLE4H6PzPsgyE1GIPOdX1M4TZvp
         DJ6QeExoIzrt4HjQyqiPCOCH47A9ucanF3mjQJFTtyTSHQ5PA68PvUQU2o4pQG+Mc51s
         CHxmexDjWl/wKHxvW/EURMr5T59gmaytKvy6Bx+c6AhUKZ9VkhbAdwmSwuuO/PpViiX6
         eMXeGelnkleKm0lw0Ld3ZzTPJs2w4a7L4JIWjXUf8Rvw/oF72ScSM1fHP9D7QDCu2mbG
         dcZw==
X-Forwarded-Encrypted: i=1; AKwUvBzqxtzLfQKcosEM4gSX+GCbl1nFu9YwM6ycoDiqCnhJzE3nhAferLbq+16mrR+lK50uPLVqUF0=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ01BBOzuSB7B4VniXv3G/JyiyhIa+XDohw/HHXIsvmIXEDcTq
	yePgpk7snFUkVdgCbVN9kbO9vq92eHfwtndXrn2SIxmItsAG6/at0onxFod2euGc/MRqcS7ual+
	NR8LDRhYpLsddggPRb36LNbk7YL5wUCYLONh86VdaJOMUKVHmRNQws0+k8A==
X-Gm-Gg: AYBFou3p0dKqIcCU9ikCa5DsJSyuRdgD3Po3YphgCzDL4rlaoaxdHnSgcvbPvprSlL7
	cRZwAyTcSesmdezRUkWqXcAOcGiYMKNjhgTZK5hLCQ0N6euxqnaw3uy+vyPmERhVxMUeZHZE22V
	w0tp8UGOjHegG5ktvLN0mZ5hc96+ewCDTkkhTLxL8moMV46CR9HvGaNVA5M6rkw+IAfsQWRQf4O
	Ag8yOqJ5X6xXyuVJxU2zLxuh/M8tbJGh283LkR2dCrTTc8bVM3SSc7d4j/pn8P2+bVoicyGhw77
	mx04PhjtpMvR7i4h8FHYQALQjdQ37a1NCvhZKnZptCWNlG4g7vXSMKvj3tF5XV4gIA5WhESFLiO
	gv4cOToQ6V7uT/WSCTaWx3LgsNj46MY5cHo9TNxvclkQbCFOGjqY=
X-Received: by 2002:a05:620a:4381:b0:93c:7955:afd9 with SMTP id af79cd13be357-93c7955d94emr1435196485a.52.1790698076376;
        Tue, 29 Sep 2026 09:07:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4381:b0:93c:7955:afd9 with SMTP id af79cd13be357-93c7955d94emr1435188685a.52.1790698075843;
        Tue, 29 Sep 2026 09:07:55 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f4c06a5sm2828085a.22.2026.09.29.09.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:07:54 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: kernel@esmil.dk, hal.feng@starfivetech.com, mturquette@baylibre.com, 
 sboyd@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260604064314.3772678-1-vulab@iscas.ac.cn>
References: <20260604064314.3772678-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] clk: starfive: jh7110-isp: fix refcount leak in
 jh7110_ispcrg_probe()
Message-Id: <179069805856.199845.4030674011944202692.b4-ty@b4>
Date: Tue, 29 Sep 2026 12:07:38 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=342; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=aDDleVR0etIFnvKWHzkitvvdqIxKDBW1b3ZUHEDccRY=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJ2Pwpf9/BMceonriV3lBM1e9Pniza9DLq+cUXppA/b7
 0+/O0P9T0cpC4MYF4OsmCLLklyjgojUVbb37miywMxhZQIZwsDFKQATKYpjZFh894RSWHDcsnl+
 hUklcyz2m7oLMM2bnqAqrHWwMv5VoQkjw9f/zVHJk3V2WfGHecwWE14qMcngxbP5J7unBn37fE8
 pjRcA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Thu, 04 Jun 2026 06:43:14 +0000, Wentao Liang wrote:
> clk: starfive: jh7110-isp: fix refcount leak in jh7110_ispcrg_probe()

Applied, thanks!

[1/1] clk: starfive: jh7110-isp: fix refcount leak in jh7110_ispcrg_probe()
      commit: 1c4f9480473917558908c083d1293b4ebb3d50c5

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


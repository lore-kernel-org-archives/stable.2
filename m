Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0646EF61
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792384206; cv=pass; b=F+MvJEMKc3yi28tV8jY1sSDJ2XGHi36ZP4H95nvmIJSVK50qM4ldpbiFcK7+OVcmQ4LB9ct4WfNI1VxUZyM9iRAYwlWfbFb+ZLDHn8sp5KDTA/3zTucL1e3EsePB21EunDWlt6oVa20c83CCC9KTTU+4Q0jVdAY0yzofe5rj8ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792384206; c=relaxed/simple;
	bh=asE30SXVAoP90qhP9dNI0QR+nkwcC4PqmT3gY2NE+Dk=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8NeSXFo8FDWAaIXshBxu50F/JxY1MykRGQyiVIxE6DPtvIuQbcoXj0PDJ5nvctzRBQIRmDrT1beWDkIc6RgvQ+zK/4yMwg/khw7PFkeSFlv5RqvFTbXkJO6KLjbjKsWhvjejp7k+ckzm3or0ApP+5HQK4YF7JVZ+S57XoF8snA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rX/rQ0HE; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rX/rQ0HE"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337fa12431so255941cf.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792384197; cv=none;
        d=google.com; s=arc-20260327;
        b=TcKkRlsLA4VFGKoIfiGFQ2v16pxBvMqWyM9bbSJFoBOkChwdLixIoN7emVpRUoZVgd
         y9w1wDPAO/wYlmSmEaDE0Mnvv6x9S8Efer2h4foksgI+4mCx7RdfD6FVqxR9fKvLPjxF
         MF7JM+iR/fzqsIMDUFy8IUIQ14S69I59yADjhqr2tLcsFnzoXSQYYi9t+t17oPnM9bpe
         xA+fy99YwcQrstw8jSI42q839/uJXnYofDXVp2VCRknziS6bLH5fo5Y0V5m6DQuqrIoh
         dPFGtQVvAoecKzvbtdp73ArqlYeGV2ULpqkmbzaj78CJGqO1Puol6eBRIteseKylD5Gz
         xHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=asE30SXVAoP90qhP9dNI0QR+nkwcC4PqmT3gY2NE+Dk=;
        fh=uQnNPmwIRLcOt0/FRebU//+CfwXamAJo+EXbBJnRfBg=;
        b=K1ub5JlWiCt9iFgEU2PI5+WNehjVDQuAm52iwvh/7YPDpEzFALZylWgLgNkAxgt+hc
         HitKsDSqx3ufosqNWNtxjNp7GBU52XTNbGloIiAQBjv5Ee38K45heYj16uUPhvuZ3qzv
         QbDEa+Ry9O9lufXKx/dF80t7R8wTbQq/vQ4bufRSVn2Y7T5KbtavPN4FdIXGiBvoKhQA
         AByTwNfN8d1HGDqs8jAqMCYHSXihMY8//1ywM1HhvTCuad4OAos9E6ExGuj7pZP2iiY9
         hPINVDHgjl3b4/psTZVayvJMJ9TEYlAZf6ebJi9MiEXp65aOJ26WXUIGNucDuvX5Nua0
         J7Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792384197; x=1792988997; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=asE30SXVAoP90qhP9dNI0QR+nkwcC4PqmT3gY2NE+Dk=;
        b=rX/rQ0HEKLJX8qBzFVQDFAiMyp/Zpn4YvJngjq2qxJL0TQl1+f3Qhr9zfPMQgC7yka
         OyyUFmVHDrAAdGlrqIea2RR6Fg/fS8knB9pX9awXJuKRaSrpaTUY35+AlGcHn0tHuOv0
         4KgKF2hf6E+rhzy7uiM9QM8n1i2Yxot4Kb+/doUezMR6iODptFXeBoTnshovBnhKT91P
         aHOHMoMzWT2vEB7ZMMvfI83/thn6XBI8CD4invQSbHSr8+kNS1l8ONs9zDMwvzchxWmg
         fvZtRNDyw82opiqdL2/0+N9k0ibVU8s3M0DIQm6bXACy/o5EFaW9Z3NLClCIFLmvBGI0
         48oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792384197; x=1792988997;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=asE30SXVAoP90qhP9dNI0QR+nkwcC4PqmT3gY2NE+Dk=;
        b=Up7He+g1axc1InGkKHXZkqMfMXC5MKgr/o87JLZicJgFEGE5eqpNefmqxJklf5tIn/
         NcE+5wPDRl9I4lS6BxyyyhlLvbR21RUonZAPdjSpoSEXNMx4adVS30+GryS+K16shH+J
         HX0EcdqkRLqcJajCqW00i3O4s5HInCVrjgtregsXd6BWTKZ66furYYzUyOfTs57B1ANd
         1z2no8uk7kmV09h9StpVwXxfo2OndcQjIIf6Un84Wc206FgElPRoSmbMWu3SNhg595Pa
         6VPZ3wbyvGD5TE8ShP36e9G67FNrGdeNysQ9nlxm6lQzhQLQzhp/5cQ8xe5wut/5Qra5
         KRLA==
X-Forwarded-Encrypted: i=1; AKwUvBwfQFT+Q1rL0WSSwHJYlhuoSJ/fZmXM6ZcTRWUGCokT8Xcw+sIw8u83fQfc/RUM/uxmVdjl8cM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5qztM1XakkaDE6o3OExBKKRmgX2B4wR39dsCqXaxErd2SSJ7t
	B94/SKLyy+egYN8WfiOk+dqGCTGxowwl2OEtzpaiSHT3cWglrxad2kioIRtr3XghQajHWNC3VtM
	Jj93izE5/SXn2bEu0WRTb53eQ7Y410+/5mZnok1b4
X-Gm-Gg: AYBFou0hXC9pZjQjJY98s10mJ8nWXLhhO+oGF2Ipa+komDql42hYm/3m7Fd0AKVkd+H
	K4nwYIakNTgMmWtoRUPAOD9EDS4I3Jg2VU/6vbDTN/wJD7WRaoayek7o9h8tILffEhnk6U/DTuc
	Bu+DXApeZDehYUDL63FyGIl03oWwXHrRfcKyTt6X/K/+qNJ/zkme4QOCXEItw1eQKqPV9D6LgHN
	vaCzSnZxazqLF8ejZvSn8k8kwkO8ne6cwYHxwbYFbtVQokCnTl7w6M5+034oV58oSBnzuPk50tl
	zf+llpL2XF5Xu/VlBU75eSghRbDv75uRissiWI+jB0wyHwL4TdMKuid7ACFo3vImBmS9J8LZc49
	W3V8eCYg=
X-Received: by 2002:a05:622a:90a:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-53649acf23cmr28899601cf.0.1792384196502; Sun, 18 Oct 2026
 21:29:56 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 Oct 2026 23:29:55 -0500
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 Oct 2026 21:29:41 -0700
In-Reply-To: <2e042211ca0ebc974ad5ec4c0de9f3f93b3c75c0.camel@iokpp.de>
References: <20261017084403.875420-1-stanleyjhu@google.com> <2e042211ca0ebc974ad5ec4c0de9f3f93b3c75c0.camel@iokpp.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stanley Jhu <stanleyjhu@google.com>
Date: Sun, 18 Oct 2026 23:29:55 -0500
X-Gm-Features: AclHuK-HgN0FmhIdLMEsn6Gjhf6fsxEJCtdj6atYDCuubd88JF0LL5qqpkihSd8
Message-ID: <CAE14pdc3QJyxY+YizyUfi2+NTB4oxYyqu_zTyT__-LfMxJLMmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] scsi: ufs: core: Factor hba->outstanding_reqs
 helper and fix double completion
To: Bean Huo <beanhuo@iokpp.de>, "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 2026-10-18 at 21:52 +0200, Bean Huo wrote:
> One more place has the same problem. In ufshcd_abort(), the "cmd was completed,
> but without a notifying intr" path completes the request but leaves its bit set
> in hba->outstanding_reqs:

Good catch, thanks. I can confirm it. I will add a separate patch to fix
it in v3.

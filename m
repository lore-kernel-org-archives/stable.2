Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321757;
	b=mLQuJtPDNEhb1YAvrpKWw2aLyb/Wea+MYhiusWLyX4ukhjbkaeJk/qGwuKiEUNEHClCb
	 w02Tckm3A2Gg6INHnXBrGQyVEov0jXN185pfZFj/c2d50iSWFTU+cAYQJeA/g+VgJw9QE
	 oGCcdnDWT5xOEuv/9+C7RmVt7kRYTPKTAX87nhygfTpoUnc837+F3crY7OXYoJqtPoBz0
	 6aEs4Uoxu7WY/vhpGvcVZNQ9w9A7yjAq8ijnYGyFHpR6Nr+aWJ9QTguYdHHgxSCP3a6hb
	 yTZZn4TprqvJBbbpYsmPziI1K274PPf2c4QBYGFPeFZNZeZLmsyNKUw+av9Rjh8U7sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321757;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
	b=dFUtUCc9e174yXPWrR2XLDd1/FMkAM6vu2BVDcQN7L8jT1NBogmn0t4sCkZ02vmiyGaT
	 h+W4JjXVjEIgQB4LMJXkyTqcS+UA9y1qs+AtISxF92Go6nPOP330kbXjVULvXa3040PIq
	 gpYZK1HldG6p657ahETnZJTWqsK4zkC9nbC15su8UxRb1tlP+fCT81B7FijCMw6F1Z2KX
	 VCBRhDgWd2uLpCVFp5ErnPpxKH43cFHyDAbRlqjPSNqxBc9IdHoYjp5C/8/nvlxsTlhiP
	 klB2g2lAZvVpHjlmnYPH+SGihYAD9u+iTLrpCY0ZHDt3HM5yQO8woFNyfm9OWaZxqkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ETAS8aBC;
	arc=none smtp.remote-ip=209.85.222.226
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742F606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 00:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9742F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ETAS8aBC
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-9440304604aso20947685a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793321755; x=1793926555;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=QUoNVO/FKpIciiekm3BvZzyZrO70gTlW5jrwilGL0zXHNTJgbvlRoic2y93/BECUV2
         ZZSfJJaidT7i/RORcd8nrOtbQDGvcp7Yg1zd3Iggdxjg7ZmyEjtPv2KX1hyMKZkA/TEG
         Vpn7fGGilDdcTZidEi7D89kEEZU8K8k4+bjm8fH6r88yoc27IwPDdWl7PHi/6idNygg0
         8fra4GzLo/56Rkaol4uAvTqtbZZAmB77T3OQPq2z7wRbAe8lqJozICAfXvrAAKvlhW1C
         BdbiR4Vw5HhEvpA7m9wxLeWljUkH8ErtYu2YZHl2csSjy2KcwaWLOr33PHsY+uwueZ9P
         GTLw==
X-Forwarded-Encrypted: i=1; AKwUvBwhCekWLBlyjvesEQSiUUeQnKnWYibv4mVde0ufnjS2UQZ/2i1Mfzv2CXEOK2QCbFL+TwQAcGM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFumfy3VVkjfGAxbCLYG6iQ1gTKadpBdCwIvdvnH5Bv6Qvz0/F
	nrEtIIaDYfLHszxxN4mR1Fmkz3uRIJaCVd7+6A2tYUbubVZJpqTLXBp7+TlOg4JRBHT0Pm45nmm
	z9MbzHV7DVMRE/xVzyEb6/Qh4+eyduRVhAAX7HbCIL9xfEHAHRTYBhK3Mu8fEErE7jdF7smE9yS
	QYv/e2JKAf/1amvg1t685ZYNKoVyD3VCs7GVocXacPmdUNgm1FhriVR2FpJJHKZbiT9PXHx3p7x
	4IgjrEBs6rMso36
X-Gm-Gg: AYBFou2WCEIWqltx9Iku3h+LiN1SjOQXY5lli3S7fFiDu/N2oYXrf9jD2A5lgen9Ldq
	XH167m+PaLze1/66qtpbasphmgS3JHgIv1FM6EtKdOcDbaIghdNaEIzkmxkLVjH1KiO8Csb9gHz
	2f40EHPCmFEMVia4oTEL3imfjRMstzFhm8jkOkd4jvkqgZKrR8dgw6442Cr916w3MKZs+Rj5XDr
	NflGZ1EpoQxBAWCxVDO51NX1FI71uqHrqm38+subHf77D9OyaEn23sPxTXoU1Mmv7256jd1tjno
	ELLznFMWS15IZNGWpNc4HcuU2Kv2+ld1+kTUcV+v7ZeBowde9oNXowcfXJzEMOfZpYBDErTfWdK
	NgqzWU5n/iBX1jnQXVavnfW/O+Zj9SSdhL/ZGik2jripqfIqIzBUM0wEL894XFs3QpHWcrnujHf
	jtxcsxZSkwII/SbXNeuuWkNKCt4xRbucT7i5mTtVDF
X-Received: by 2002:a05:620a:46ab:b0:93f:2bca:2cf0 with SMTP id af79cd13be357-9442171fb52mr149301085a.35.1793321755549;
        Thu, 29 Oct 2026 17:55:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-94424e8a55csm1443285a.0.2026.10.29.17.55.55
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 17:55:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3425098ae4bso1842522eec.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793321754; x=1793926554; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=ETAS8aBCzYATyBjUX3EQVyOm0vO+7gkBSlYL2suYCw8MUsxYh11lPbW9L9mcOaBFHY
         /kXgqMnM6fkJggryTuqDFunvVuNpBeb5dMsOtteKdPbk1RqK5joSTNDGnDLGcM0oViRQ
         upykpF6d1xKr0cHVIb1GFlKY/JQz4KmDSqUOQ=
X-Forwarded-Encrypted: i=1; AKwUvBzRexVShrRBuEKyVaa1QiE24mt4NB0+vxPy4EIHjGfk/lSzsfEQoUQi50VjY3ziKFHbzMvVQS4=@vger.kernel.org
X-Received: by 2002:a05:701b:2511:b0:182:d0a8:d1a9 with SMTP id a92af1059eb24-1a93c6ccfa7mr5041512c88.0.1793321754037;
        Thu, 29 Oct 2026 17:55:54 -0700 (PDT)
X-Received: by 2002:a05:701b:2511:b0:182:d0a8:d1a9 with SMTP id a92af1059eb24-1a93c6ccfa7mr5041486c88.0.1793321753424;
        Thu, 29 Oct 2026 17:55:53 -0700 (PDT)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm2198320eec.24.2026.10.29.17.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 17:55:53 -0700 (PDT)
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
Date: Thu, 29 Oct 2026 17:57:14 -0700
Message-Id: <DMHRJ9K73XAV.2Z5TV83Y9TJRL@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/vmwgfx: bound MKSSTAT lengths before rounding
 to pages
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029215738.3010276-1-zack.rusin@broadcom.com>
 <20261029215738.3010276-2-zack.rusin@broadcom.com>
In-Reply-To: <20261029215738.3010276-2-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20


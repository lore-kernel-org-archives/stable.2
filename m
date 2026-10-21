Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580347;
	b=ZUVJUjIcOpyJPAMHn6lKxtMOfEplJFtftoj/qokKzV7M1RDz8qIErUjtf0GFmHlAki+W
	 ts/H/zLNOZViD8HKLo7rnnjo3gED4CuquzRnlqO5vw5FHBuY+70de45stek2UbBfsOFjL
	 /dRSgSsFP053S7GQCzooRI+dxJ3ThGXZfFNwNQHW3Fcfaj3iT5Ats344wk2htYCK68i1E
	 q+NLfN2Ox+n7yY5Yp/B/irm6+5iIVkGvoz97KDmMJ+y8LNC1CC/+6LLABtg4pOQ/nlmz7
	 pDI8Vr/aXdwZ/nDRl3AQoIOL1JiOfCgeMYjQDCOeWTb+kYNuZQWZRJ5SPMINQRQJGkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:
	 Cc:Reply-To:Date:Message-ID;
	bh=+6DqmLcffIJ4zXqo73wDStwtJ+XJU97CzviAZxX2Wys=;
	b=anZOxmS2Zzg2yaCN4LfGwk/yG+DwZ4cAzqaz2qVTiXCcdpjs5sXODeFCZrOVVXSeYhGf
	 1NkQP8CKkMIrh68gakVfuNq285XxEmTMuIjKx1+h/KfF/NrWB+5T/a+bnbjYBlsaNTgIo
	 fR3quPioZXt2nZ5UvFiLDOdZKaEn7cri69LnK8bR2NF6cuZDxO3ifeT94XD/j2trAflkm
	 RWZKSS5dWK3LTkmgGAgIMkk//5o/AlsZa9MT8Ql94EgeXtSRH48rnwfSuKfslYk1RC4mD
	 k+ZWfQUK2NgchVT7xEKui1By1QU0iL3uabPhWa47w0QVfycqjnbwF/CyTFvUCezRYSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=NAzoW6At;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A7606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B62A7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=NAzoW6At
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-366421dc8ebso1043426eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792580346; x=1793185146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+6DqmLcffIJ4zXqo73wDStwtJ+XJU97CzviAZxX2Wys=;
        b=NAzoW6AtGJfu1fVPolKVJjo0VvlxBtwcRPThX+nIjyjqjJ3rFaaaUXHS9Tgzo6Fn9A
         eNLLcY3a9avzwHPL9j2mfNUIOCDgIhrctjaLX48xqBFKQsRjS6GF86K1eIaIbP+hu8q9
         B4iElnz/SEXrYw8MdkiBfN0KDXNI00U3V6xKzV/sp0ib28ts0yKIxNy/CAyyq6ghf43F
         miVPu+EJqixBVC8u6DpDRbg9tQ8J4ZkkVXPocQtkAFBnva7aYy0L0xv/7OmZpHw6soP5
         K8zmGsNc+wAoBGcECghbgvHFICnLf14MJdFNOVUePdzgPZwohk9/rmMzay5mpyt4ej2I
         moRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580346; x=1793185146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+6DqmLcffIJ4zXqo73wDStwtJ+XJU97CzviAZxX2Wys=;
        b=hU1EjR1Xn9VjsqdpOlyWHyIkf6UuyHjmcLgG2MFFM6y834ZOff7n/dNX+FrHMUdD/A
         /ULf2UnyI4WkfWpEfH7CbUAdr0foqg3+mcNjYwP+CM3TeRrJZANwRaYZAkSkmKqjdk/F
         tbBYjMtV1hYXrElTw/4nM1aX87uitVQcR3E9PCCt+RiZvfo7HLW1GS6PaX5BZryhsZsA
         53MbWW2jS5uhXxIqHZA+CXbzDGpoqAZTjLc5vUEiDU3FhrwbyOPHdVnHaAYRDYysvTMy
         4KJ1bQ14wfjWNUsLojcidRgCp6t1EFFmFDIXL7tCvK739JgsITpVgKOToLeZ4NhbTWO0
         C06g==
X-Forwarded-Encrypted: i=1; AKwUvBwIGUNM2UsRAsv3waiiJrw9d8echpON+w+24/oDpgItOu2yiyw9P5MUEJZjjo0zqLoPg3BG1+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhSwTw8UkThfY7QsI3iFXd9Qbz9zVzGemBkpvk7Fmlxm+dvlM6
	wnNfRkPh16pOJx52g3vjcpHgtZNwGshoLUqTz54QQpZWjT8aZMEr76yBpfPDR7gPI5o=
X-Gm-Gg: AYBFou3CJFB2lQm84+8YvOIx7ZqGDgGwqWZfpt4DgCXe4XDrszV2ddRIcsuZNPEmgp3
	AJt30jv3m56H6L1IIgSlzluabJIf7lRWrNnXHiD/1ZkYlc21sFHImSl/DPhzvtNd7f1anq72eEz
	sNDIxiGuF1nZw3ToVzh9cmnSrKmFMa5F3vkmb51h5B2Yhi/EN5CSkKFVEwmABweUdkrdC3ToqwZ
	j6lvOJ+iWZW1w2bVztAwdnula+MWUC/xx5a9ITJu0Ek9Pw1FIUlMxXssqM6sNW4tZru0CAFYX7S
	jgc5INfp/rZofIu2FA6LMSWifpG+C4hxekA+47w8m1xnFb1hSDurlhCEoBd+924lY4i2GU722Qh
	UGnS0AESd5yRcIi+pb31SKeNAlOKWAanOMIUNtV+iGkix8OV7Lqo+WPsRyhsD8ZNfCtjLLTK44u
	W1JOohm8n7b8NiF2djL2F5+s+CBce17hbiyqpyEMWZfQSxy16PTPGyToA6l4gT92/KnDF5AhAo9
	XrbvJC+s+5TN37RXufrFRlTBQK7h03vhrmg8bCucO3FXh0w
X-Received: by 2002:a05:7300:e825:b0:366:42ad:7074 with SMTP id 5a478bee46e88-36642ad7654mr8064603eec.22.1792580345630;
        Wed, 21 Oct 2026 03:59:05 -0700 (PDT)
Received: from 6e52bff8000c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198fb21sm6387219eec.23.2026.10.21.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
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
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable/linux-6=2E12=2Ey=3A_=28build=29request_for?=
 =?utf-8?q?_member_=E2=80=98f=E2=80=99_in_something_not_a_structure_or_union?=
 =?utf-8?q?_in_arc=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: regressions@lists.linux.dev, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Oct 2026 10:59:04 -0000
Message-ID: <179258034449.241924.15241097267562754477@kernelci.org>

New build issue found on stable/linux-6.12.y:

---
request for member ‘f’ in something not a structure or union in arch/s390/mm/fault.o (arch/s390/mm/fault.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/mm/fault.c:448:59: error: request for member ‘f’ in something not a structure or union
  448 |                         clear_bit(PG_arch_1, &folio->flags.f);
      |                                                           ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/all/179258034449.241924.15241097267562754477@kernelci.org/

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:07763fcc4cc009398ef2249ab57bfbb01900bd79
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e
- tags: v6.12.114

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ad8885055fda5076059d734

#regzbot introduced: 7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e..85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e
#regzbot link: https://d.kernelci.org/i/maestro:07763fcc4cc009398ef2249ab57bfbb01900bd79

#kernelci issue maestro:07763fcc4cc009398ef2249ab57bfbb01900bd79

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903974;
	b=kq51BBlOFNIIdurgA2f/7KfZG9zfZUBoPGEF2/zNHn9S4cfcGHPd6uVghRFWb8hefvIB
	 oUVVI4el0h8UYPUq8FRFXvGCMYn+g4cNpPlIxE7GsNi460YEvvhh/EvJ7wjzzkXsKPmY6
	 vigOlJt13x0qdNXJshQFAOvrGwjNo1HKPYYipl3TsnqFU+RB40deyWqhCP7O8RxaBhjuF
	 kUuXzNnzQEzTSN0NB2HBXUwqEOmMFkBsjHtKX9wpEzvIRM8+uAugiu+nWNuOBuiiZyHQz
	 ccq+EWin3dr8ZcOZb7aSZgaFq08sD7Qd8eCSdLmjeaHdJRaLmur9HQTXFpCJv0tmBkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903974;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/vmTha+/NBgXWyoBJFSSnlMTejShcEZUjZERBZZ4wT8=;
	b=Dz8HmC4ni46TCXVO7tMzxoFDd5P/bG+pFTmLtcd75IHNeryezBpVJrXoIUs5xsf3v9jA
	 h52qfL+e2YF25Lg/YijlDpU97ElPln/YWt3T+7oRce+A3KvIdnPUGcdQ8dI8ksJjNJxz3
	 Vk0Oh30tPDwZY93KryIWhctamWlfRneTUgrPRAyWvL3ueD4j3iew0g/uU+2q4uUThUBVE
	 xeVZxxELvdTQCHkhT0MF2hBG3qBij8Ct0wR7Qi6rPiL2f5cBiMGJcrWw+2x1RHWR3lGsk
	 klBtlpgXFUcVEJDbFMjBE8nHZJQ8Sc6AY34KqBjhcjGW9XFUxiYlrdyLjVcxwn4cMpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUxOmdGN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38994606A334
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUxOmdGN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC11F0093A;
	Thu,  5 Nov 2026 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903974;
	bh=/vmTha+/NBgXWyoBJFSSnlMTejShcEZUjZERBZZ4wT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUxOmdGNLBHj39kAt6sRM53ZreT22ldFtpEVpMELymJfS8swfeNkFX1+UOQy7h4Zx
	 8079mWR2/+a/w6mQINhHyNywPQmKsEM+wmiWwCaTdkrfHJ65Fbbcyo65U82ai/FxQL
	 oN6u2MAq7GQZlI9/t/tC/qUk6jvavu3lpCZdG7NFycbKgkE1y4CNKCV/Nz0Nwee/YC
	 KqcrfipOSvjwz6saAleM9+BJO6TTO6BuLXIjKHH99DWTrC+pdG5Ha6/M9tduT4R0Uk
	 qRt2Rhq03Jr3PFzjEHNmS38uy4xKQnV+S9lSNUoqgsXSQ0HSQeRnXpsiQCZTBuNV52
	 yYlll3q6YOghw==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?Tales_A=2E_Mendon=C3=A7a?= <talesam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Kjell Arne Rekaa <kjell.arne.rekaa@sparebank1.no>
Subject: Re: [stable request] drm/xe: Implement Wa_22016122933 (d5b0bf3f37f1) for 7.2.y and 7.3.y
Date: Thu,  5 Nov 2026 13:39:16 -0500
Message-ID: <2026-11-05-1-daily-reply-0011-xe-wa-22016122933@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <OLAP279MB00864A857672EED0E6BF554997772@OLAP279MB0086.NORP279.PROD.OUTLOOK.COM>
References: None<OLAP279MB00864A857672EED0E6BF554997772@OLAP279MB0086.NORP279.PROD.OUTLOOK.COM>
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

> please consider backporting the following upstream commit to the 7.2.y and 7.3.y stable trees:
>
> d5b0bf3f37f1 ("drm/xe: Implement Wa_22016122933")

Queued for 7.3, thanks. 7.2.y is no longer an active stable tree.

-- 
Thanks,
Sasha

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794627617;
	b=WWTfJWNNiX3fnwfHarTiO9EcjFOXSMVFrEkTC9Es7m5LnXEOS1QDnPhUgfpMGl0s3SUK
	 7Cin2zUJUs2FxTN6CLVZsLwJorMA/4VRiiv3AW/wSf8V70nFPBH9y71165zDMFPkREw1P
	 VrRqtidmLE2wpf9HmaFZ2umm6mAuGT6VsXxwZcceFX97IlWrORlGHU5lWy6s/be7q/9ZB
	 5AZdQGy/JwimuboD8EVgXMtY61q5HWf/vs91CfcF2msR/h+ZuchJ6FgWzhyR/xw6Ll/g2
	 SOWAuMR0+SQKiOrzJWyQOIET74aeUi7Q/W3+2EXX3fW0L9FhYPpI9Wg5K7/qHyFyxqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794627617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=E/QJ/KMx5WyVj2J4TdNqaAQXU0rL7hIGOlDe9g33IzE=;
	b=w7aFeUUW8gNUsbl4sXRbZyc2kPYPNw7EoamvvBRsq9B/lkzXW0pcvtjz2ggWUEvwxtac
	 ++eEQel6x27tMzr/7UatxalZwmQKfMV52QsCxBzJuoeezU32yHyIhr7ll62sO6hBTDnaE
	 GGACuontu1drTvD963iqRsJeDwXD0od9x1bgKs8p1LieKfJCzPzQkJiA3YsbEZfG8tk+p
	 R542FFQ7wGch5e8aCnJabOC4IdRHCmCuEMDT8dWfQEgKfTzhmQGn+BbVNIBgrobi1gse9
	 wYGrsqMnStQ2Yuw4KYEVw8IMNh3pE9KjBg7zwEm25yocWqN3a7HO+DHu6mHxfsZaEbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Swbm8bhZ;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FC606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739FC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Swbm8bhZ
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a60f90a924so692596b3a.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794627617; x=1795232417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E/QJ/KMx5WyVj2J4TdNqaAQXU0rL7hIGOlDe9g33IzE=;
        b=Swbm8bhZoLVt463haIQp+R3/P1wcnkOFskVWDfwhp0AZfE6Lxuem+EtPdpusnoeQH/
         8UoqDEMI0SE7yJDpFCdUfDgFebiZL4vQMVax+1ZFiCivI9JJUgP6SYwRueJ4F/i2roat
         jsOhxPQ5dkrwm8pm87hdstcKmZPXz3MRilSiLkAQlC2529WYAKjtDkdkT9zeLd52WX8I
         QA18p6gOIHq32OxypSxxTV8xkTYdzzuTLFKeiBURfrVblVnDKJ7T8dG/eIerAe8d3Ziu
         568M9oQF/MXiyFbArVgE/fl39OQELrkco+txj1RRz+5YiBOiBrmwNy28OQOQzGEISnNP
         mp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794627617; x=1795232417;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E/QJ/KMx5WyVj2J4TdNqaAQXU0rL7hIGOlDe9g33IzE=;
        b=mbTQoECQoymG2hhtqobzS1iEImMZay1B2tb8PUBxIVRr5Z+IJ5xfaCxRB9+PI2p6Ty
         E1edpuaCISZJS4hdFN9Ii6N7Oxk+xxHzilL4Rz+7Hy0/OHFWRM4veJ1dt6ks1cdNrqug
         Xp301EszWw3mnTrhaUULu8cX+3l4tFtoqPR9JJ2vvm7OMx5bPwMa3Kr7fi/wT5Ev1TXb
         GCHDyNcTDACbcbth+QEEQtVxryQV2Xvv8FcENAOtA0og16KocJPFoqqNr/pqBxWJeh+A
         fMvobUkNpN8KvYEVz9AhXgVn/zdAUfmSlm3pb3WjpHjyBu8FS2cLZbHIsPZEJ6Bm7+ji
         w7NA==
X-Forwarded-Encrypted: i=1; AL+hErHuQCNFCyHu9dqwbyKCuFaDFjcja2bKcJx4BUV1odkLjNsa1t1hxD3kdWCHFfdOAsfFuBgdstI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/N+wxRFiBtjb3FYcRg+ZG4if7mAEYf6qqRsdebx6fLDJPO+ZuZ
	UbxFxcpxd7WAF0H05NAFG4JqivlXGktHrNdrCkyMfQnI3x0A3bEnF4RauNBMNEFHAZ8=
X-Gm-Gg: AYBFou3jLCWmOPSquGz2dziBZKcTaH5xi+kUBr7Kf8MuFRHw82JBT7DYCqI/HV3AtjN
	FBBWaqyWeJiqBClT6/Fyfy+6AYhAbRYV2HC6/cxFLeji21W7G550dRd4b1IBphTL6YMUE5cy9KK
	V7KzjXwK028EFUpYHSHtVhgrSWgo+GpZl3vfBVcqdS5I5hyCEut91UWqCGBnQApCIqQC+pKNlsf
	8NsbQII1x9pnrQEynOcHFtU23BOs4qNt3o98uyKwW+tauVHu6xSeBa+AgN8eoD3O9eeLxWjp7Nf
	RO4o3xHMjtCHt1XXvvgkDvQn+cwG0fVrTJrO7w9EUvkBaxUs4xgTD0BagvUpkbAV2RLsmwdj3mV
	AAEchpFcALqMkzi/TLfLB7FqvbLEvGldjLr5E8f96XTbCHfXNUWGrgBC6hwzJ5WDzFIiRid41xU
	yYS0vy24RYtB/nPW5esIt5hVDDHU6cDobnMfnvgO1XCm4MITAEn9jSOxyc5tBtZqIaMABonAk+k
	TgPM/U5q9wVbvL4pzBHdikqgUgC1A4MSrWXiYQAHMaPSJo4DMMb9Ldwems/nnoDz9j1bWn30dFN
	jDd9/3WYkgVrz5pWkV9foMTJiUqOe1mgYcLVsuk7rKUd9Bsf+FUnWMTIWkUv4PPLjzIbGXYCZFO
	h06EWar5Vc7hf03TD3DFPrUh1rgJSH0yHVCSamg==
X-Received: by 2002:a05:6a00:1995:b0:8b6:d2f:72ae with SMTP id d2e1a72fcca58-8beb53d9ea2mr4567673b3a.18.1794627616742;
        Fri, 13 Nov 2026 19:40:16 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:f861:b117:6318:c068])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed263b648sm1705244b3a.46.2026.11.13.19.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:40:15 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	erich@areca.com.tw,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v3 0/3] scsi: arcmsr: bound adapter-supplied completion indices and message lengths
Date: Sat, 14 Nov 2026 12:40:02 +0900
Message-ID: <20261114034002.549899-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791803953.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791803953.git.yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is superseded by v4:

  https://lore.kernel.org/all/20261114033810.549787-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee

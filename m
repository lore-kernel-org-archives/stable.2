Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346F30CDBC
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435229; cv=none; b=ZsmuneV3QKLyo88FnvG4Q4v+8R5s2zHUQWVtlEy0WppQ9QuZSAc6frTIjMJoe9dZfOczmVW2JbbciSzuDkHyiDh1FhixDAdULG4+KPW8rzumey3y97Qv3xnMvFPC1BEigSOev3d/CxXC1Sk0OCdq0HrGXL+l+tVYl2Hv4ypYIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435229; c=relaxed/simple;
	bh=zLBagadYIkgHnlxLvmsxj4cwyFqnUnBYuMtGNS57J5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHqDkvvWJ6PCmUiJI45X8Z7nRJNuHa2fL2DW4L7ihevJnKqWL/Kv1MgfEy760kltlzIAma2mF+/hS4NiSjmJW8If1shE2Bl7eseZHHV5LQq2edFxvNhcAwpVfA96UTMFM+A7ucVu23tT5+qrhPHXno3y/LZ3wn7atgF4FBpSsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=so5pRUUu; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="so5pRUUu"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d0so29195461cf.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435225; x=1790040025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HicEH3nO+EqTxA/vkVDZn60ZwfdK+A3BWy3aE6/nD5g=;
        b=so5pRUUui4UMGwIJpCv/Xg+WGsPPiNKg2Yov0YqsfNOH1sX67dDlhFDA+/drc1SzDe
         GaPQ8ZMmqOJoyfKrF+HGOX1mM5cq6QMxiIjF/7fs9IWOz9HmXNyp1I8ZWjfL6cbd+0d0
         k2kWq7YA2ahXIO2hDn/3uyZwkxccesV2+DGynIJc+KyYMYq/wid3oPi9wA940xDCEl6c
         Ev98sV+xqmcxn+FwNwWUlRltgtsjMWz+PPQ6u/y4XOd0yu6X1QTlmjKaQMTA548WkBhy
         JIff2vCyNfG9Fycye7/+aHwDTt2yxToHtzL8yfFovTWrLk4mHUzpJ6T+3Gd1ZSF/f9wK
         fWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435225; x=1790040025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HicEH3nO+EqTxA/vkVDZn60ZwfdK+A3BWy3aE6/nD5g=;
        b=Etktvkc+vyDVv/myazDHSqtpZn2PDFxKwWMgsxX7iLs9s0UPrGuC6/VoJLYaq9cnQR
         0p5vykLysnICe57Hg1zwo6RF0+XqpSJkabC5MK12bG18IQztnEOe5be+UOr4T1VyTOdd
         jEzn9Prsp2Z8hQB4wZWTDKbUgf/V6FKuHYTAuffglz2uFfS3/Si5xWwvYlcr+Rj2i42I
         8mHyCrkVdb5m6ooBMYU8LQmbep8Yj8BpqhV+ty58m+NVNlIj8ELme//QlP6cAR3mp63i
         j2CJSRbMtwRLSr9rc0XqlvXTIagBgZdpqq/Z47HyhWsIBkf/GUKuT5GHB0Nl3ragEPcj
         V5Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxH94XuPmOREnPVGpbB5gUi5mC7FI95629cjAA1XnYE/Sg+g8iFewrM8DMt359cStHj8V2Jw/c=@vger.kernel.org
X-Gm-Message-State: AFuF++nhUx+ZyEVO3jhvOTrBgoL6v8UcIeA3eWKyjMQ+l0N/kmHM/4t+
	V6O++wvss4TiAx9vSh+LUujGoIDDaHN4rUsEv2l7UKDZmc+GyNJOt5U=
X-Gm-Gg: AYBFou1VBYP9dgJ5KiSHaXDKX3HuDq+JyHCUVA/xe4cT8Cytx+2wZUAmGOVQi5eUpxs
	lLmFM0yzW4bdiYeA8jajW49a1FoWSDpVCEjDPuxfBobuKsCWyhNnPO6b/nIT96Z7TlB8touWBNs
	yJ7mp0vejR1DaKl+6R8bZ/UCVu9Gu0o/OSS/QY0BqM/oTjuBjtEm70svCTASLtKrKFoy8lyjDJU
	BWvmPq/7NHRs9RfFxPybK985CjH0J9j0fjJZsBUEWSjHgRRhQ9vN5/QcE9Dckl4vYX7ON4KwNTh
	eCEVh4ou8RsikMT9v4jwyKW35naUPyB3ulD2PMt5tLZcMMkP5VrBC4lELkOvJIC9FFnMCrVGtR6
	iVC+kOuIftzwFNV1GaVORT9ppJ4JJcPuG1Gh/tSOOMDACPuCFPLGkRHS19LAYKmHrvw9GVvp4lK
	GKpBlcu3MTiv3wzSE17N2V7xq6O0umT1BwMWIhBuRg9az390HqaEktwxqTQCltcoUnvdUNGgF8l
	GiGpy2pdVBraqxZGXHOl/YkQ3MBsQAZsKKPgCmszNH8bJQwyybT9/QCMSDzCVEE6Ke1yIFOVepc
	eUApvMFsug1U3OwZLpVqjQctYXjS4YCdD4kZ3jDu7eysW5mZBDoCl6UekW5RJ0TuTCBbUg==
X-Received: by 2002:a05:622a:4c8:b0:530:1613:e09e with SMTP id d75a77b69052e-5310cf14c2cmr70974781cf.1.1789435220207;
        Mon, 14 Sep 2026 18:20:20 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a62b783sm91141946d6.23.2026.09.14.18.20.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:20:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/4] usb: ohci: Balance controller wakeup on cleanup
Date: Mon, 14 Sep 2026 21:20:07 -0400
Message-ID: <20260915012011.61874-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These four independent fixes disable controller wakeup after HCD removal
in the DA8xx, S3C2410, SPEAr and ST drivers. DA8xx also needs the same
cleanup when notifier registration fails after the HCD is added.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Assisted-by: LLM

Myeonghun Pak (4):
  usb: ohci-da8xx: disable controller wakeup on cleanup
  usb: ohci-s3c2410: disable controller wakeup on removal
  usb: ohci-spear: disable controller wakeup on removal
  usb: ohci-st: disable controller wakeup on removal

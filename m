Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10C5187DE
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904407; cv=none; b=oXl9nSKKJpbnIQjqb6vbKhBK9MUY18Qkbmymuhspo9RMw/+rexx7d3sVyzSfwqoICcd5y52TmeB5ySK2pIphbTtrlZtEZp0pjTEJB3hl34sB+LNFsfNEsP9nZska2aX3UwYpll51Q3LWlvJ5uqpoWUDkygo0BSOsh8hzUoqI3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904407; c=relaxed/simple;
	bh=v1oMUlr0j+OWLBDHKzTtuO91b3I1/3rK/UpKQ22TafQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xtq0VLgzWikoAwe2CEQjuELvxvmH91SApgwRkt6gb9+7Btb9Ap5QYL4p54u5e1g5vKyLvckFOIQpc4yme/XsAmtQpYkjGgD+IFu85EZMk16RVbMZ9NoJYZcjlsff7+D/2bxBw1tqnqZLwJKU3+j7CmhIN2p3uqD2luJLkiOPLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=BO/JMK64; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="BO/JMK64"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89d4030cc57so223351b3a.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791904405; x=1792509205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xsC6RbLkcpl6vUO8QFll7KRyQolqiQv4TDUNdnm1Dc=;
        b=BO/JMK64Z74MaNO+q7zVPWzD7WKKGsiQ3vTyCGp/RfLfZPfZ/T//OhVTs3ONKwg2FX
         A8WaCm1M01iu8gS+88iYKgL38CsDLs20272kd8u+I3+z+9OCcXYA0PUA1MzPs652aZIj
         2yPupmVDDRExiLYvxY9NdG9TzmYXEm3+qxGhCJokC68LTVnmb34z0JQ50/gbDhkpwZ0a
         2mOYpfTqH/qjQBjvR0i5TtsyJG8Nq5YwlF9ymrjPwRfrFpV99sPD+gPmBVMLpLERkoEZ
         HYuC55kzisFI4KWky9V5Msgl9H4EseUS/78eUwTA0r4IZBrakLh4BCgO9Sg+AX1pYkPN
         YUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904405; x=1792509205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2xsC6RbLkcpl6vUO8QFll7KRyQolqiQv4TDUNdnm1Dc=;
        b=CwU3wFuVh71yxgHEnBm5PdqQmZTu5PAjXFNJG6nekMytW9DyTSMfz5AceEEQwHAhxM
         nm2PC0yBBGK5w5mV1cYz2mzCiREi6aSVbW+nMLAGyMYrP02JwwBXqyj9NJhNmV2ElVh6
         lsjtGYeNf7t9ABo7FNIqK0Cidf/C1rdZOBaBlxZkRKOThe+LO0qOGiD7gFYl52yWMOwl
         N30xJlcvhaQCqqsxscNvrl9BQsbJbA3I51fKytsNmSsDNaIcTHGGZMDvOp/Iw7Y80rKT
         /TvipWTQrnghl82vRUlyJe5UJw4QdVDxnV25N1YuuIyC2Ne2lmN1mLhTLGMo+0Aa3bZC
         D2ug==
X-Forwarded-Encrypted: i=1; AKwUvBzmZGSNVCsAgRzqhfGcFbN75Zx34GaKGt/KtuyRx24nZKXSg/bwDqqH+vejbLO4qaKNq16Mpl8=@vger.kernel.org
X-Gm-Message-State: AFq9FYInVF9ryA/JUKnMn346e9Ox129IhFBNbUW/uoWY1+Qm0BXv72TX
	Sp7mprBza43VUhkEJJYmfPwv4oVqWq9ijGSsPSq10sv3jHeCDgY6Py4DcaTe/XU/5gc=
X-Gm-Gg: AYBFou0qRbo1hXz1vHJodmaOr+4g0tmUHFeZ7bjYEi6Jdg8Z1ssx6901lCbLhYuorjM
	Wh5aE2LFKzdturkhZc9C2GCN7Er+0jTYjhT5mu8UJLOCrqzI0QBfZYXxiiMzFtlg6g+SxvbS7Zu
	5nOcfd7AP+V3y/2sfAaPv7QZtbqeFpWvsjF7axLrwERLUtKzUgMZjJVeBrL9twx2D59HBUPySRv
	iKD/N57MmaLJ+y9qSjTwy6se0uOrU7kStaSUvbNiRZX29NEZjbQb7u/qWxAV+tn7dXI881KEuZc
	mO3FixdOfTl6ss9s/mV0TtwiS1+WeigdRyT/irvRtpaHwuNbUVNPbfDl566YmvtYS482tQ1wbRU
	fzEj1fsJjrQbLmTXPjoghFIPY9yWqZbZgY/ze+UnT7CtvnNYIvfRZ7ER8Q33EzZQ5fWuXnfXa6v
	Z931ouMy/9K/67eHLGx2ldRkcfMgKMgsEUreJ/XGs+Ut6i+jgCXm7oCdotZUmSa9jOz/qUkqMi5
	mgMWGCeySIHeiXBoTEd
X-Received: by 2002:a05:6a21:8217:b0:3dd:85a9:55b7 with SMTP id adf61e73a8af0-3e16be2b1e4mr12853348637.34.1791904404981;
        Tue, 13 Oct 2026 08:13:24 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd614dfa382sm1462434a12.26.2026.10.13.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:13:24 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sashiko-bot@kernel.org,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com,
	aacraid@microsemi.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH 1/2] scsi: aacraid: bound the SRB sense data copy to the source buffer
Date: Wed, 14 Oct 2026 00:13:03 +0900
Message-ID: <20261013151303.3169745-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-169890@kernel.org>
References: <20261013140214.3156938-1-yhlee@isslab.korea.ac.kr> <20261013140214.3156938-2-yhlee@isslab.korea.ac.kr> <sashiko-outbox-169890@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch only bounds the sense-data copy; it does not touch
scsicmd->result or the srb_status switch.  The result set in the
status != ST_OK block is in fact overwritten unconditionally by that
switch (every case assigns scsicmd->result with '='), so it is
pre-existing and independent of this length change; I have left it alone.
Resent as v2 (with the HBA patch dropped):
https://lore.kernel.org/linux-scsi/20261013150420.3168223-1-yhlee@isslab.korea.ac.kr/

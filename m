Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B63A1A21
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490350; cv=none; b=EPGNXkDARjqBQ2PbUsDH/T0D92PCoCNV4Rf27lwGkH7CY2UJW4fEbFs3Ptx0pC2zX/tHggZF03hqjLZ3Gf1+0MM1LEBlocGj/d9MVlvOutI6u+aTlMS8nsBMoSJ2GHxku2KQUuwvNNEdexeu8bsL7NKvTDRqhjgod0K79gxwMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490350; c=relaxed/simple;
	bh=ht62jhWOhWn7AavnfDM2FcUnwIzP6+bRh2zDwIcDfb8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eFEHkUfZs/YMaK2H1y7ccuzqwstLPEPAF4LuYd4FPWsx0mLfPQuhk64l8uLCq6ZprQ3icOOPg94S3O8F5i/VIAuZw3K+Mpux4I4Uegd1m6c851dOzo9d4LDncxnVLAQHxPSSXi+R3Dq2GnqTUFCVev5Ogv4Jf9y9kTnq2BKspn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=CURFSSkJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="CURFSSkJ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84861fc51f5so525361b3a.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785490343; x=1786095143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ht62jhWOhWn7AavnfDM2FcUnwIzP6+bRh2zDwIcDfb8=;
        b=CURFSSkJCWzDSY3VYX/Y/cQbqftuk3LScUOJg4+vwVn8FXMgzcXgb1oGdE39LuKZ+e
         ABAysh1FG25Pv+iNx7iM4zeuNuftYapboOOEub5wXPw4Nj47oWjgYs2axCVpOceQNM75
         r5s7vo0U30oHj8jevO9ImiKL43I1JiCGJFEN387UjgwLX1rnkkinbr/1zwZqXVBN12dJ
         qgoczHmJzzIEZT1mwteCM55p3YmzQYrCSrhJHlSYCdBbYZmRLwtwNPbJU03pLojSJnhc
         4Huq41rtk1mJkggI1UDjOwYEabu5cEPPqxvzEssjnCGkSNShGiOOR0BKkVpJ4JQsa+J3
         qhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785490343; x=1786095143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ht62jhWOhWn7AavnfDM2FcUnwIzP6+bRh2zDwIcDfb8=;
        b=QnAat/YJam12iBBWaiuzvxli7CgNwUpvlmhb5cdtyDrVVx6klM3yGi9fykOCouFT6+
         HuMz01ebddUHjCp6RP83rF8wQY5NfB41cm8NS2932WTj9r4EndWzojQx/gnDHaBk0gMr
         GgipkKlOcWxjansnVmbMT7/+ZbgPjdjdZpb0QhlUiiRzX7ZfFxOHXgZvjAeirqcvSIK8
         vZWbVQrPjtMvKQPEGYPohgmbhdIJct2u6Sx0+hp1ByRfR7ZmRqXwbOhsARAubtDQbP/o
         jqV1BtbI7g/YJHA9ifwx208d162V9XJIDt0uu0dLGSK1fmQCPo02bxPrQq8A9jVLZ9Y2
         sqyw==
X-Gm-Message-State: AOJu0YwoJfckotS0QqTswySmqcqJvKTZeufRUkjOMuhfz3T1cTLFimEu
	y3qkQAMv8tJnJ2lrqTIc0VPjbu/2c/k2VpOoe5drkaPHfQ1nDgKrzecfkkjspasiIBt91s4gZk0
	2pLDhnHsEYg==
X-Gm-Gg: AR+sD13g1HLAESh50eisxU35Nzkw82kP0w/Uq0wcBZt47jJHK5sAp8fqbgdY5O3zE0M
	f8GNtXgh9UnEPEogKGTHqXiK1VDagmkuL1f1VjwuFAZ+errQkfHTSUR52cEz8o/Rb3onqr0meJF
	xCEEbiJLEwAiIZ0xzVeyHMlS2sw9grk/dfxSV76B+MxoD1avlBhrf+8w62I1EqT9tZfruY/RS/z
	M0eqyaW/XL12yeKXWQoMzkOGaVGx6iFmaHFCGfoHAphrIwRMteFvbtO3SkCpaYqzOgNteTuWpxa
	cO/qjAWjanEopTO6RyAlAwf1x+/1GSdjsT0PXeeHfRmPkvJ0e0bqHY2hNHjk10DwxMyFoKTN0OS
	Vcnaed5CTQnf6bXlYtglVfqQb5QGSm6+TWJt5hDwK8bxjGwB2by6RkWPycM60NaT9FO/7XwUOJl
	zI8ikEUCGeipV1GqCCahqDI0nkuSqmPSVmn5MO7/eH/IUVxALtw64ZIe7d5cVqsMvZ7O8l0w+6j
	XAsB1w=
X-Received: by 2002:a05:6a00:3026:b0:848:57f3:8f99 with SMTP id d2e1a72fcca58-84ed7185a75mr1079180b3a.56.1785490343048;
        Fri, 31 Jul 2026 02:32:23 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe396ea571sm344799a12.17.2026.07.31.02.32.21
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:32:22 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: stable@vger.kernel.org
Subject: [stable request] net: mpls: initialize rtm_tos
Date: Fri, 31 Jul 2026 18:32:10 +0900
Message-ID: <20260731093210.1820903-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Could you please consider 295dd295e213 ("net: mpls: initialize
rtm_tos in mpls_getroute()") for 5.10.y, 5.15.y, 6.1.y, 6.6.y,
6.12.y, 6.18.y and 7.1.y?

mpls_getroute() fills a struct rtmsg in an skb whose data area is
not zeroed, and sets every field except rtm_tos. struct rtmsg has
no padding, so one byte of uninitialised heap memory is copied to
user space on every non-RTM_F_FIB_MATCH RTM_GETROUTE for an MPLS
route. KMSAN reports it as a kernel-infoleak in _copy_to_iter().
The fix is a one-line initialisation matching mpls_dump_route(),
which already sets rtm_tos = 0.

The affected code is unchanged back to v5.10, and the commit
carries Fixes: 397fc9e5cefe ("mpls: route get support").

I omitted Cc: stable when I posted the patch - sorry for the
extra round trip.

Thank you for your time.

Best regards,
Yehyeong Lee

Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB8552939
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991463; cv=none; b=j8aL5FxltvEERqMAgSBsnRz+3o1c+VZAjNpF3ACXhLDfZBU3M01u5bEzJ6Mtk5Unz5GMy6VNfR5e7XXuBaM7juExLWFVbp3AuyyxZijDOINqxir1QwGDGTB+Ippa4xmwVG+3p4Ao77krJZniCeSZfEc30Ayr7YRJTFc7GoiVVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991463; c=relaxed/simple;
	bh=AuomWEZX4AZzaXCJpww4x5u2oFWJ1CWj9oyE8+TmNiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7/G7cXRlwJnRBE2H4IWz904cwL/MmXW+HN3BLOHJpXjTO++HDuWiJreU7Ml4ucV9+BkvMRTqpzoms+4wjAKRd5GHs4qVL8T/PElxYWvF4BPsEW7Bu5Cse/hor+KHBglAIIScALFbNlypOq3wBhcwzb5ut4GTLAhg5IpRqnmBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=tim4LgQF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="tim4LgQF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e60f9af6e6so9279825ad.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791991461; x=1792596261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oe+0IhcD+dLnpRRZ2AO6uP7D6+WkqiUo4+grQwp5VRM=;
        b=tim4LgQFznfakpE7Q77lOgtffIurbEZsGhEFewaNF64KSC5GqyLjgjbO/XaX49kEpC
         06tvI1hVJrCeUJIgInYdmPDsvtcQavZkZujTr2lYOH7iOTrifuVFP3mM/25GKISS2Uei
         Dai+m8DxizKQh7uqa8qX4ph3W62gRn7K9CrEQlLkh3GMEJVdl6JuPIYaNHCrPLTQk+OD
         LaObQwB2CuhtdAkeoihpH2QrwLWvFPXfX42zBQeZRqLzdT2nhD68PoUlhBA6OzNxMWq6
         wIufLcNo3vHG4UQbWF0YTDQquqeF69nXx5TiXC5PVPzDs6DedGU8aMgsv6jGMWF1SVEc
         DWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991461; x=1792596261;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oe+0IhcD+dLnpRRZ2AO6uP7D6+WkqiUo4+grQwp5VRM=;
        b=OGnnQ0UnzSWVXbPRC+REL/7NiUfV9vZ3xcMThQGDvYm0fYpX0Tg8gZR/r+yJmqupXX
         D5ZGhy3jZyBvmTfIzI7JLMSeDoEwl93tgeWoEHfmM2w31nAcaBDNTOZhoj7GYVuB5gOH
         zT3RIF3ARqPkagLrrYudxrCuRtdGYdfxUuk4c+3c5Sj5w0Mn+3IAVxLHL1B4hxHABAxm
         ItMwqMa2/U+Osa/HnWpnCRzxMkJuwD6PwBcdXrfaKI1aG6LP8f/023nwthcmG0ktK/NZ
         6s1r+EVyyP+ant+VDrGKQLbFWrk14w8KuyY1hCFtj7eSFcF5/suEwAiGcby/cDaXFcKC
         +D+w==
X-Forwarded-Encrypted: i=1; AKwUvBz8jXNG6H+UeH+SGb++sCL28aFEyMJxGsyR4TZCbtIKZof4oAh4XJl+c+UseGgLJat4Aw2U4tc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+UjYcc6jYW3q2eonzokZg6wDXvPoc/IJJroOMVMse3baXzUIE
	2QiWsq96UA9HeDBWEd6a/zdzId7Sdfr12UOOui8MkWsSduduXtrYrCjHN/7Y5waiOgUR6g8FzcK
	IbxA7
X-Gm-Gg: AYBFou0A5aKTI2IAyVYRw/PW+tIfvILCxpVAteoHad5bZ3Zgl64E2orAZdqRn0R4t9T
	+A7QNPs/2AmZBCBgV5iVQvencZcuQIPCYQH2zrrqxJ2y7143gOUiNtlxDZ8j/ka9ugWM2HXcPgm
	tC/MNfqN/pjjSAXIO+PQ3Wd7FH7HmrUWR3yX4xqjQEZPIw0xj6TdL+PH/TV9iBKcvZ5UCZ0iiiJ
	bjYhqKVKTn0U2FLxJjq6mrgrHrQYlZNWq7hNdq8yEyuLr2oNKjQzZd50mgkptBxNtvC+TfPfBVb
	iWUDnoFoN1eQAWskLaAOwcz/syWNE+blyG5cUfrLSyDXbxbFAdnr/cp7p6UmBUwBcAyni76SJRy
	4VhdJydtmseB757N9GSJoRWChlF8HlLUVxMcqed/+tyKHzHasbuK7vVMqey0FCOWNFYvUR0jGVi
	J2AAQMLooB2L58XwUfaGo0juJc9ywNCXoAFuMuORrZ10hMUJAglDPSpVrrP+aCxmCR0NOK+iVpZ
	TJ0B0yaGYTDRuXF+Xtd
X-Received: by 2002:a17:902:c94b:b0:2e6:dcce:8222 with SMTP id d9443c01a7336-2e842f389cbmr147131975ad.57.1791991460638;
        Wed, 14 Oct 2026 08:24:20 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b298dsm69536815ad.33.2026.10.14.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:24:20 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v2 0/2] scsi: mvumi: bound two firmware-supplied lengths
Date: Thu, 15 Oct 2026 00:24:08 +0900
Message-ID: <20261014152408.3637388-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013173145.3412863-1-yhlee@isslab.korea.ac.kr>
References: <20261013173145.3412863-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please drop this series.  It is superseded by

  [PATCH v5 0/6] scsi: mvumi: bound the values the firmware supplies
  <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
  https://lore.kernel.org/linux-scsi/20261014151914.3632701-1-yhlee@isslab.korea.ac.kr/

Both patches are 1/6 and 2/6 of that series, unchanged except for a
READ_ONCE() in 2/6.  The series also carries the handshake size patch I
posted separately and three more bounds that a full pass over the driver's
firmware-supplied values turned up.

Sorry for the two threads; one series is easier to review and easier to
pick up.

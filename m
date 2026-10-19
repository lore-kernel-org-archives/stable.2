Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8C330317
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376250; cv=none; b=u+YgTLAkPSEe9cqkbPFTLht6bWHneu37g+bB8C2wr46UVVkV2cfzk61FnZ4i8joEut18kUqjfhLPgbsziG/wE/Esi1cci5TaFfi2T8mEtXiHBI3XSzlb6009ioD4x4g/uKiAvqc87yxG7enGfPkWlmWX9ju2rCa0dhOEhQlm5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376250; c=relaxed/simple;
	bh=NJJGDOvEDiGRbIgSFW8MSvLC/yadQm8VHB1EwfkMMck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb3DlTY9sHpEe+o9O75FtHkDeXJz6Ub77frmoZRSBjnI+HKueOkR3nITcWzPDfrLSXTIkWm/UbZspZQ0VIQGz+2E6QaSWLTIfHRjHJoUOBXubtmfm6tv0tYzM3XoxexcTNwFpA9F7gfPaCe2sR9b16PkpOKSex7H9WD+IQtLZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=Ji1gaZtJ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="Ji1gaZtJ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3514b90bb89so4066644eec.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792376248; x=1792981048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJJGDOvEDiGRbIgSFW8MSvLC/yadQm8VHB1EwfkMMck=;
        b=Ji1gaZtJEp/1uK1gCSaYzNSctLm3210xuTsvphqPvtrWYqsg84IMWG6Dei6f3R/VOc
         uxtHffmtH9WIX4yZ/tTW982pkisXW5Ab+dHdyYtC4eZgfO4Isq/1bEPICQxN67+NAPMo
         sA9/7f8GrIj/TNGP+52oDO/w974N5E5lkrhGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792376248; x=1792981048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJJGDOvEDiGRbIgSFW8MSvLC/yadQm8VHB1EwfkMMck=;
        b=VP2Qfqqy8k9avX4vdVb8byglV87IH5yFHq4nhnOeBhfR3iK1ObswnIJeXnX6RZtySy
         mCfLEhozfeIusYHOynkZr5qnUEUWU7/lB5/+YlJHuS73+UtNB8bvMrtPwWtf4XbpFulG
         +vgcA3DlyjPjBj6ypgqcJ54RkxKlzOXPuyDtL1RBWbYbQNi5xDHTtjTkGqMuMx0dwvgd
         Oa0l2y7nItkjLS0iUsdQR2ylTZ/7fIL9siftRL3xH56aStJzzVmbRTF7n2jm82GqoPCj
         IJRjGaP6qGbEqFMOJrhFMAAG5rgleH8jMZAVSz0KfiCabAIhMIe89TbboRz3kog877k1
         L3KQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7ceUYCmIkmjl9WOnXUgZaXr6QCDSA82LUx1W32i8FmF7OxC4kfelL2ljpxYbTP2lngqe6Z7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnq4e2Z+inhI7YJOrEg48ulw+2Jy6mDru9xis6GdwEk2Eyi4uZ
	KuQcrO5h6A5XKyIH7oIFplaweuAIpocBhmkLJmyo9GW/k/Xhdqsa8DZMsPBVlUvVkvE=
X-Gm-Gg: AYBFou2hnFGhwNRKxO5oXY6anM5utK0x7FNO0taHx5NhEVbogLuhGCFH54pPPf2Hd/3
	WgWdClpQV9LRYmARP5PB5yDZ14MF/shAuCRNkwZPJ2KOHJUjw/AoK7TQipiafY1TUDTFagSg2AQ
	XKuVWnE256RiK4eQFeShj0TwGBQDLxnSFjJwbBKmDjxaydBu4i5KZ1XdIh5j83tldi4CAnboBD6
	c0QWIB4NoRO8oV3oSFkk55cXayFNaQsI1nI6NKtPCjbfON9fq8zyHAhs6etsKO+wVXP2mt9dhKW
	ZYXny69uOu9+OXVqAGREjmMhByMjFvkTiS+JtGtxvbxO7CF6zmm47YfDIfpNBeogVC1qjWcRZzg
	dHd1O1xnuWR8pD/byUOqHg5mbs2e7EjTEs96pInPvf78U9RLj96AgsO59kpEyXI1rv5Qph565eh
	IdGWUu15QgVrQPzu2oQ1BbWdy0Y2IkwdMBJXuw7Bi+fq7NA21x6vkeyIheRxn+JKg7/fYZNNNbI
	WytxHqA2ZZAT3eT1vOvwBSF/HBFQqY2dDYjAn9K7aDFvUVmcp4JUTc=
X-Received: by 2002:a05:701b:2207:b0:136:c443:80e5 with SMTP id a92af1059eb24-1876658f6c4mr5983797c88.6.1792376247926;
        Sun, 18 Oct 2026 19:17:27 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314b1722asm25766382c88.1.2026.10.18.19.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:17:27 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: andrew@lunn.ch
Cc: 98lawweijie@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	law.wei.jie@gt.tech.gov.sg,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	woojung.huh@microchip.com
Subject: Re: [PATCH net v2 2/2] net: usb: lan78xx: reject short register and statistics reads
Date: Mon, 19 Oct 2026 10:17:13 +0800
Message-ID: <20261019021713.150059-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ce3a8add-3bf2-4507-b778-a0f8a10370c7@lunn.ch>
References: <ce3a8add-3bf2-4507-b778-a0f8a10370c7@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You are assuming reading registers can fail with sort reads. To be
> symmetric, don't you have to assume writes can also fail in the same
> way? Should lan78xx_write_reg() have a similar test?

Thanks for pointing out, and I agree. This will be added in a v4 patch
request after the 24h cooldown expires.

> If short reads can happen, bad things are expected to happen. No need
> for examples.

Will drop from the commit message in v4.

> This belongs below the --- so that is it not part of the commit
> message.

Will be moved below the --- line in v4.

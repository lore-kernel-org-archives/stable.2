Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BA2E738E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477945; cv=none; b=g8HFqf2yp205EuFWer37+WYMcR1IKYz4ydWdzDQCoivLTo7MTNXgnG48H3sWcbexG29sShN3oJ2lhas0hOLo4Gdu2gDvunCT1qvBZ4Er5GmrtnOn42iVG3oY0KQC6hFg2QZCosEAq7wHaDf9vOberSCtET2FAuMTd50uhm/muRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477945; c=relaxed/simple;
	bh=uLUKGiObcIBhHRIvw/DxV9M9ATIicSdMLlcsFem5vpg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=spCrC+OyiVHG+ZgnuwK8lP0swJ2jS6hZT22rWmRWjbGz+gKQXt3IuBoWuXyF8MhEd36QxvnqtVt+76e9a7NuU6EL2fqBsqw9t4mtETIKGHGRxmp1zimdykj+U6zhkQ7/a5+uE9KXZr/CpEmY/x8H+Ki/0+F/EbXbSa+VD5O1nSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Q5ipIqnK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Q5ipIqnK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49234dc0b8aso293205e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782477941; x=1783082741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LqhxnIBUKP3oie2bitoteLZ4f0XNfCRqg2qhFPCMmSo=;
        b=Q5ipIqnKGYUyykaxZhzxRxcvsyY3eztolWc62RT9WCLn/GMtMTHsRoz/OFgY8gD2bI
         L/xMswSafl7nFm1XG8B2/mPEMuheoj3kTowNadRnyJ5mzhYHy3FNu7Z0ZK3Ww2OQ8g8H
         fDI4kp/m9if0Qdw3oylKLU8vCu4mDHI/hxAp0Exb6VPHhTrasPw+fh7iS8a6BsYolN3k
         Cucl6fg+Xs9CO0zrSRaLUZVyJKJ7kr9qNybc1Q239u+q54wTk+RfmTpku9RP+PdCCXzP
         NdZYNHk4/D0231BXFlqVJLWdhlTJYchEg+gbTdTstoDEiAO2hzprgi+QxRpfxMUdwRCG
         0ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782477941; x=1783082741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LqhxnIBUKP3oie2bitoteLZ4f0XNfCRqg2qhFPCMmSo=;
        b=qzAREIawh64wXdGPW2ehXrTxtMedI+VY8i3gYazKLtDtAr4emKPZ+s54n8GffhOLcy
         PZbbuh2YrnuWW+WfX0ECaJU0dl6TgkfThKLoz4cKyvCKPdbemFVoo7wdGg4ptux/G+1E
         Ns0YTFr7/HMgo0dIeE5qZThFX/mVYTQ+GBCDI33rt9crrYrem/vlk0Hs8PL8aR1nwD4M
         rlnvkjkltTfpPaEOeaLlTtPAqPtCFES8tQ8fXs5omrgcGcZtJpPkNIEK7L0LBjhfFNVz
         GfjyAdRL1RKn0jFTpk/1ue65xAP0d+v6HIQoA97vRHiUUrrXtM9Rn1+s2VPSZfQ3HlHL
         0bbA==
X-Forwarded-Encrypted: i=1; AFNElJ8bd9JVz9fFTQiSSAw6QxFOXVQ9PT+Mpz4/uMr3XsSkqzfMAeW/pg/3oKPEl9HKeAbXyYVXp2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTAZFX8wZa4oHy6jeS0eOafjk622q5QnUOzgKb8lftlKFXCNk
	jiFuDSiBdEC/JSmL4w468FBJMefDXDCtA79UTlAN8ZKiAeXz5yCdyt1QnGh52BgGJII=
X-Gm-Gg: AfdE7cnBaYV5XIeHv3lzspse5WznhVgqvBV5UJ2cHme40D/pzDOSOPAu3U2tuN0zmyg
	vqrztMy4hsIKd604/SVoYNVt8Gb64L0gFgPA+4dZGr5MnKbYAxInFtHOqAtmQjdfcmi5p+Jn5WW
	Lubz5S4yXTHyw5pPXB4aWEvAg4WVsOg1bkiAOaZWJsGvc85KFR3Z2rvB55KB3Zj4Q/LfcqAhOhV
	NeaT6/oaV+HzzYkx0xdJVxJNbZLrXEVC+LuHIDCX/ZzaqCo7vW+iGG29Nj8/uzH8ns6dXsLjWkE
	FbxtjqRqw0KjOrZftOIQPjsOL2o61IRZ6p+zGphsxfVar/roY8ZHQytnXxQCWr23MMb7En4Kinx
	LI5iMeclXn6tUXmrTM8oLyvAX73ycwxcQ9uzc95DO9EfaBZjZS8jMqeCOS4Gyn2U8PE6iHaBPIB
	lbPWI4j1844MN4rXZUj6WZfeg6ki6QxApi74P+Jfw5Bkl0
X-Received: by 2002:a05:600c:674f:b0:492:3555:b9a with SMTP id 5b1f17b1804b1-492668ac07bmr46619965e9.8.1782477941354;
        Fri, 26 Jun 2026 05:45:41 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:144d:e00:98f2:1188:3abe:e8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269020266sm73981765e9.15.2026.06.26.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 05:45:41 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [stable-6.12 0/3] 3 SEV fixes backport
Date: Fri, 26 Jun 2026 14:42:20 +0200
Message-ID: <20260626124539.201250-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, hi Sasha,

Please consider to apply these 3 fixes failed to apply to stable-6.12,
I've tested it on EPYC Turin/Milan with kvm-unit-tests and basic Confidential VM
functional test.

Regards!
Jack Wang @ IONOS Cloud

Sean Christopherson (3):
  KVM: SEV: Ignore MMIO requests of length '0'
  KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
  KVM: SEV: Ignore Port I/O requests of length '0'

 arch/x86/kvm/svm/sev.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.43.0


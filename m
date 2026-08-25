Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54468393DFB
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654829; cv=none; b=mm4k9A44Bfcwin1qkyHVx4GE7s45TgNChGB7EGFhHEMCMe2RF3SNeNzitIGdV0IVRS5yP0ePJecUcTVOV5nQzIbZCac0FtKHLBHxWv6gkC1gfor162d/o0QUnx3LXOLtIzFW5QEfVEVD0lHNFGr7DUlIsy0YSkhzOUSPomOXuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654829; c=relaxed/simple;
	bh=KoWnSXBGaCj0jbCTvpHVOuxUQJsRstO2RferBywnX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chBO1g4AyJIoF+uG06j6IoG52FIEoYyURxMPbMR5TCiIeJlQBlucsr6YDQTgw4nl79LQlm11WhBPJOhYCSwxDVrPA17q+6z6pZCNwK/qGhYIqIYpH+Wrc1R+xkeiSMrFgvlhb5CPYLigq5jAMJ+9/mUfBJtybGZtw/J6tqA8M5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/AbB6nz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/AbB6nz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d6efd73032so3314715ad.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654827; x=1788259627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUuxtBGmNOQbmRdHfy9LEMAv45qzxqGeH6c6o8+FBaw=;
        b=r/AbB6nzyVDv4MhKtw7UNa0FCSddWRptTcq7tPC0JPyFORgaqMlxOuUzeyvSlDH3bp
         I7YiUXRZ0fenXogObzQLn1N+0kS6QCNamAXtDNPFN3Q0Jf8+cT1JTv3cA4n73rEqzsya
         NqjTdGPSysaxccPbY7nXiYHYcRWqjZtD2TrmDrRA+8o7nsqqkpsX73ap0a1mV1zdowaC
         daa+6P0NE838PQzOOLCacXKFyCygteN/s8luIxKsG4oAeVg+BcaEPwmzPZ6ayO0eDAmq
         OmeCFs1jQfTFgROtu8KNzU7Yd66GMFooejFtnAIhpmLtBzJ3Ri2UcINt+K/2w9NUkOxE
         082Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654827; x=1788259627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUuxtBGmNOQbmRdHfy9LEMAv45qzxqGeH6c6o8+FBaw=;
        b=OixZ8AD0gt3NN7Atq6LdMatspmZHCRlHtVslieZfseQpIw+zDMEzXgBP3dzkNo91x1
         BrMIZsMpy00qTrIANQwo4u9FIih34oaB6C10PAlOOXdUrVTZoyDBXXO6+gGmhyVDW4ii
         tD6hXwEKHi+r0HoAai2d3bqHqRFwALweNEubU9XhR4SYnZVGfVf2Jbb80TiGLFfvoRet
         m8jbfgjC0zef3DnSCczbRdq8VbTrhV781TSp0BcGqs/l+ZG+arqe2+OkAtQJmBypovca
         znGoWhL4PKoUpo6WVb5aSRrIMCiH/+P36Z2luuOd94dQjNzYYccP9g9e7gu5qRyHIp/V
         alMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSGTD+mXg53QBa7SWUAPXUPakM7lmEclEdyu+HDFdAi0rZQak0E366OMdPlnqQvXJzMOmeMy0=@vger.kernel.org
X-Gm-Message-State: AFuF++nqNJj/HKl9VVJeZLujCYXwl4l4atAQf4mKu3uT8umu4mo6Kc8h
	97NVK2PR+1YOVgsqFGeNw8/5ukhxg1zWzJK7eT/T6LCsuG9zNlO+eSdx
X-Gm-Gg: AR+sD10h0IQtfytCCHnSnOPGybP5iS9XbMZiAuNQnfs6RzlpIqwGasM1tCsN/h5mFdQ
	pL+I4pcBwkYpYJ2qFL/01PYE4+gW64JD0a8Px/jcWb88V5k0l3sbXHgIUc3sMA22d9hJSJtPs1v
	M8Sy0LhzOf69CLZUnKT++0r4+WDxV0sBihMtsS3vOrCW1JknMawXvM6OWd0gs3LG9V2/5CfWeLO
	UUSJD7fl/0unKRfECLYhLLzsWcqYJYJFnUKFncp4BDKhOT0ciKqO2NhI1PzMichTp7M5cJAzHeC
	t5Ug3GcgRx/70biHq3V570SeLwWuQrUXJpo6AmPQ2H+BYHYpbyMcKR7RSDSfneXCRVSjYMmuxpy
	4lEAPmbAxHJ5UgrZ6WtiGRPP0tQEJ59riqdV3StgZjvcAbFRFmeJiHgJYgDwV/hoD/QEPVhwz3Q
	SEUk5oXVVpSpjouMAN2XMlZz4NlmnAhejBRr7oA+/bRoBPOwwxuEdvvoaj3YpkLpRzrUzGPsU5W
	nD8P+pCMasiCicLIzYLskP02wPeuGEnsFq8KWmf8PnoJHphJjrZOKIFQAV3wPzoyTL8ToWXPrta
	dn58HHj+CudA38xQNTaBDR2W
X-Received: by 2002:a17:903:19cd:b0:2c9:d277:2cdb with SMTP id d9443c01a7336-2d6dcab5925mr73666195ad.9.1787654827563;
        Tue, 25 Aug 2026 03:47:07 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6eee850b7sm4561755ad.3.2026.08.25.03.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:47:07 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Tue, 25 Aug 2026 18:46:59 +0800
Message-ID: <20260825104659.16251-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825061027.105062-3-98lawweijie@gmail.com>
References: <20260825061027.105062-3-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by the v4 series:
https://lore.kernel.org/linux-input/20260825103123.12216-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing these bugs and I should have
acknowledged that in the earlier postings.  Neither diff is changed.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie

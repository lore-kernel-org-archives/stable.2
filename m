Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65B4F30E3
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975715; cv=none; b=SNiLdS6WeTwuZzMBFpt6GBEOcTCXzwGyhrLmCAbmlQOFplov0pr9Sg/4mlzsUMmVtm1p5ZmvBv+t9dwhqnE7X1XFrsW/4i+EpHwBiUnOQtyBIdTj6oczsN+8zLkpePo+xe2Vd+S9yVcbDs5QnEUNHv0hn/6jDHZHiWE/efyep+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975715; c=relaxed/simple;
	bh=4r3y68PXpRnW4+xDS6oYVYJ/itlRjzMaQakZZwvt080=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4hxClcJhbQUgCNmMq1SQa9HZkjyo1AUYuEB1Lh5XBfqNloGYGKaf4yMAOZX30dxayqKObj4SZJ0Fdw0CYO+Qql/aqf/8S/xe/sVKF/2RjnpGuPkySu0YQ48J7SHlx02jLFwlgnMuVDCEz6raSHUlgwi1jjZOuMWIqmolTRFYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS71hX7o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS71hX7o"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso27892205e9.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975711; x=1792580511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHiNAL91Xid+WHCxhOo2pAad/m3iCzr2YePKwS0EFY8=;
        b=eS71hX7ovAnQUXbj3x0Lw7L2KUqcCJuQXaWeReKd2MMrvCvADlEduUerkbCzVzYeYl
         ID/+bTrIi/ZSlkp8G629QQFn31wj0Y9oaqRfrIXD3WR1r8dJduIGVyWe3Mgb9SlXg9/z
         kM2p9BVDpTPjiJneI7NjlN1oTM0xWyEnh/Wdd9OE3DWa6tKS1HBt2gUrAymFUpkh0+eQ
         tNYVNTOunGDPwhzHqapYUafveXEPEkHeu3SPtnA1aeU2SwMqRnfBQvkKTQZAUEcyCxMs
         lVGHs/e7gTsK5/vwB9X+nt+ZM1CIN9kmzO0f6bwqntnwPUBIFHQ7xqlwGxJwpTTQDvjM
         P7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975711; x=1792580511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHiNAL91Xid+WHCxhOo2pAad/m3iCzr2YePKwS0EFY8=;
        b=qlx6p1lzwS3T+9As4B33sziWti7AEFjbEa43o7CiSFuWk0V1A1hAR2OQs9CmhR5mJt
         fsE0yP9nGANKto/7Cn2YJEhIGUWnM+aXdWy+RH4H3OVM/cuf1Jyiq+tBb2WzodNmnIKK
         f3u8pbcSz6Mm4WW2KFUW7yUkVH9RJfhOmbiID4NG8GNd4FQIYYhQzjWcqBcAD5QjIepj
         36Q8VjXwb8axeeVFNxOMQjsSbPn/DSZnVdpr+MInx1VsgRtUT26tZTlEe2Gcm+NKLL7B
         L4igtA7rKIsSaRIZuHWBTmLaLW0qtm3H2STRgXZM/tgB+/BFLU8UUMTa12uvgwn4zDEQ
         eq3g==
X-Forwarded-Encrypted: i=1; AKwUvBzCHkP+INVNunT4XShzoq2ICPw3pKgu8rZzJPmDrXDxSdIbflPwLbCMso6S333GEc9eCXsFXok=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4bX/SfDUGhal0gFR3+TETPbm/kEuWR2eWfzgn5xTtUDiXOTpR
	irff3Ln2gru9k8adpXeInnj1QAVWTmADCdw4Qy2sbs3krOtBKNBcC/I2
X-Gm-Gg: AYBFou1qEJnR04zE15oQZXVNtMHKHQCsYRdvYEJx/l7VaXpZEh7u2hml/GIS2n4D6Ak
	ghBJ+xbwMv01vGqu01XH6zrON6qwetek7NP3+XXOJg7ucM2+DBrvu8FcZKTAtOzDUWDgICqtXbo
	nUNXolNw4AY5cg/9PyKyzvu34HxYLpswRC+gV8pvU+Pra1SvOQTRbgraPvL7hECC24Hrv3HCwtK
	gEjEvNh5tiiEvfNWeGHyiIEAOMMdlFTZ3+f/78rsrRjPsflV4pnauwATURtqpCh3chHHV2ido2o
	f9JHpGX3tUSNY93V8FQOP9wTctgfnkj8N231h0ByVI0uMIr1WTUoqQWRpQ7K+TkJ93168nESjCs
	Spunl+Oz6v1SwK4Rj1mXh2R3JgKCLebQ1YQX15gdYCT9bTetKly9o+dovC5bBzPXZohGEG3Uf1M
	iS32wdpiraenzY8YXVG56tXZcCLpTansAw14cnTYjzwUUTgeGFSSKqxzTSPUD2KZt5+EYU6H6w6
	Zi36fyQGpiEMGMt+5lzqp2EakHdVegaXkeOXMCg9sLLhQ==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id 5b1f17b1804b1-4a18e4cd667mr303811435e9.26.1791975710181;
        Wed, 14 Oct 2026 04:01:50 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de2e2ef2fsm9396807f8f.59.2026.10.14.04.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:01:49 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] nvmet: pci-epf: report transport errors in command completions
Date: Wed, 14 Oct 2026 13:01:45 +0200
Message-ID: <20261014110146.95291-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1b4ee842-844e-4b6a-9ce8-0c4e7229825f@kernel.org>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-5-parri.andrea@gmail.com> <20261013142736.GE14759@lst.de> <1b4ee842-844e-4b6a-9ce8-0c4e7229825f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 05:12:16PM +0200, Damien Le Moal wrote:
> On 2026/10/13 16:27, Christoph Hellwig wrote:
> > I think this looks good.  Damien/Niklas, can you test this on hardware?
> 
> I do not have the hardware available right now. Niklas ? Can you test this?

Thanks, Damien.  I don't have PCI endpoint hardware either, so this and
the SGL patch are build-tested only.  I'll keep Niklas on Cc: for v2.

Thanks,
Andrea

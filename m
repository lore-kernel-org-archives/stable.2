Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409C42C511
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439607; cv=none; b=K4rwSLMDh1QE/A/WE8NyP4jrDpYo863y2kWJWiHJzsqKVw/gE9nwJ8d7SURcPQiD03WjLHxBD/byWfHOq2JzDlMQKKTXRyo31oKq+44YmyZ2QeAFuckrE4I7BfZzdDSzpfLccGWSkhTV+4mWPs+QHRTKH+Hi5NDBbhjaSlq158o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439607; c=relaxed/simple;
	bh=eXTEDFxSkgdYFKaZ+v9LnbZewalK3Gedj5d7pJyL5F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5g5ULbC9S0VzA6GJV7WXVPcvDwWMO7hSy/87LQWd4H+6MQvOkNunei7B4NNTFc+OerlZfUZcQH9DLPpF+NJeCk9LsV+U9/2bPtwzRTpJZp5m2ECBevo4N/lJlETgC1gmRGuaIQa2xA+j6QeXlCJxvoanXtEGSKN3O0sGIcda1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al85h61b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al85h61b"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49978908b35so2196465e9.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786439604; x=1787044404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eXTEDFxSkgdYFKaZ+v9LnbZewalK3Gedj5d7pJyL5F8=;
        b=Al85h61bREn4kxCaJ0kDVEytK9rE/+udegJqwFEs26j2iNHJcKVgY3gweliz6lSIlL
         gZKM4Ktuy8tP5DBBGJkUEjMLAVGauz69jVyLzMVLnWSxyXwUunvq/9qU9rDMpb2S8UOY
         MLlST2odWibL3tI88DsoK39kFM+K16egmO452n8qcEWOPdAekJxlNmFlwqTBjNEqm/36
         7crs9GBQCKfsPrLDXkqNhF9zzrfDufDpesw3gUvTq5jgm4b8P0gaaOsVvBZgCvDyXzXb
         h2dyZgEl4KWvlhooSd9a4m1beEoFx1uMuRW9qUvM1Fb96F1YFK1X/uP1GNJ74BY28iNT
         xkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439604; x=1787044404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eXTEDFxSkgdYFKaZ+v9LnbZewalK3Gedj5d7pJyL5F8=;
        b=AxYVV0jjUPXsRurepcmciEERH4dBfrYjh8eaP78eSdYg7UOLVpfAD2UKG1jN/zTCnx
         g8wapUoUrYo3laDxiPDjcPHLim4g3bNorTgeZunF1XY+LYjyXP01r11aba6v2K5x0Mnp
         tTSNAi1dml+KSpC0c3dwKWp9uojFySz6rs4tgYzwIfAGOJVyETN+JYI52KXtrf6l1RIQ
         mUY6MUDR85OF1jYy4stML9MpGMs3WI6mu4DNRpJPhQJdUA01/yP/5yIxS7OOdXaiTzg1
         7CygAdXW63Gv8McJ7JosFvvuwkmmpQul2Mn62nldIJP2nAZ74s6m09D5qRsuoIDDKGxz
         Q1cw==
X-Gm-Message-State: AOJu0Yxu5pMEp0/NcAoEYEs2AMF27uZHibVj2dVwrmb4J+9Ojy1v22j0
	RxgzAkvou2i0jhpk9cf7f+E9KeWLSL87AASsJ8lBg2/FmC2e0pCDH4Tq
X-Gm-Gg: AR+sD12bzyVJ9uei4q/tA4t1DgfHDU+k8t3TdkV9XBcTZ3jNAIJy7RsVH/m4Tw6Qv7q
	/JBSzznssXOzlbHPuC7yj2FbqMOMfR4Zchg04WY060JONfmBo6ZrKYQmtVQoRgV0/dBEH1DbPkm
	UjDPzBfnbNFhaI7wPlPoY14d0QpbzdMe3GPui/ALjghBxmbSWhArggYbwaf3LOP3oQTPJ+142SA
	ZF6eJnzs0XMZ87cP6rh0tZgQ3whG0KkgtI6bsEcyJxk3ps118PdFN547c64aVH888k+dASl6JN1
	xNpZm15uuGeonfHsdNlYWWTmE/+KtJMUK4raF+mi0jc9Qhqd+v2Kw8thwL4L1ZWk5HWiVPapzP7
	+uYpS97wqjzMZVgqXayMJP2uF6YPnlROqp6PF0cTsbpaa49hBYzbkzelCBU2mTTgF+ZkY9nsnp2
	1ntA6dLk1GQuA7oQ//nqkr2IbjanIbsz2eLaTYYulrT6itknzse9ue2xxfPt3E25zAmfVxTR/xJ
	sVdow==
X-Received: by 2002:a05:600c:3104:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-4997842f614mr27031495e9.7.1786439603740;
        Tue, 11 Aug 2026 02:13:23 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5be1b7sm2787760f8f.14.2026.08.11.02.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:13:22 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: stable@vger.kernel.org,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
Date: Tue, 11 Aug 2026 11:13:21 +0200
Message-ID: <20260811091322.3592403-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811084018.3566861-1-mehmet.fide@gmail.com>
References: <20260811084018.3566861-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, that fits what we see. Larisa is on cc, so she may remember whether it
started as a fix in the NXP branch.

Either way the behaviour is the same. On vf610 in DMA mode the accel path drops
the tail of odd length transfers and byte swaps under SPI_LSB_FIRST, and this
commit removes both. That is what makes it worth having in 6.12.y, whatever the
original intent was.

Thanks,
Mehmet

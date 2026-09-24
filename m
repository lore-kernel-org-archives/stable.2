Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C4356747
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224305; cv=none; b=k+FK7GlmBrm4p99OxRCjmKYQ/AqZHE3Aw8GsAN354x2J4UWY154o5cqkzoWOg4r/s0DdOQm4IHV7nA+05aslKIsYocHfx5Wiu9h0VGtULKO1xFNtLqS54f+AtOLwdau4bMifvTiwF/bOhIPc978U+wZl4NgbvuLnWm01ungHChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224305; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig2DCuyGxoHntfSAM4dE8+Z8f9ZWapbtO8Ir+M93nb6zrO5dR+xIlbk+KQeB0QP14FLZbwUbDiGrpvWxcT1YCSicBKoBdevgoIwAAh0JaQXZ5cRvAhNxHXEyX7QLxjoY3WtZPHHvUJVfa65hgkywxTP9z0bMRSrDBgBMJWIZjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f07ABrTh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f07ABrTh"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so828371a91.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224304; x=1790829104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=f07ABrThenmPAoZggDsncPQzi45hJXPN6tRdYyKQJeFi6jByNb0GtfRwE5VAoTC8P1
         CdTaKCmJkRKcxSfhJwYhoK23GbIPRaliVa5xNnsXntG3qyToLJ+QuxxkEaQim5J1ApN0
         HBnfU8L2iWy/b0DcejsRCU8Jrt16bKKjLXY2ILC+OQhey7AFNVgMsfRtkXJ2mnFVfkLT
         Fvb+JSbEKoojAFm5e+zOOpLp8++QpfCdec5p9G2x9JoKqiD5Pfv1JcPiObhpJSluFFyp
         g+omvjrJANnZJV2ouvsq0N/xRKEunvKH60BCFDPbJr7XU06kZCRCiRxfTQPdHNbOVb48
         uU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224304; x=1790829104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=P3qsic5nxUYUBhVmZz2DcgizvOjhuwTCHO9kA0WwmlJZvhdn60KTjcFbrq2MemZnig
         Aki7l0lwu6h20omavpzTylr9acoC6hBAaYHbQXrnWxxQAjAFedP8VmfsiT3PlYW16o3q
         +Nf9K9EMpny4pslUIqCFgWJBqXxk/NiQHzfuz0FHfbaC+V6Xgo94m1X14N+1ZUqaGZda
         d3gLGGjcerbcmv9FnWAtzQJvG6R9aTBXofuDGgokTh8uwor7KwmV+SrIj48pSPd1kTx3
         ZjSWckEf3k/OVw7NIjZFyr7Ckyi81MgBySptZsiboniEwuXWQRdH2aG6DGq/1oyRHX71
         Btjg==
X-Forwarded-Encrypted: i=1; AKwUvByQPoysYrlnbeOehMbBFgGsUV7XLdir31i30cIYFqA/tMFS7rQjk2WJSJQd7QBLtZUeU7+NJYY=@vger.kernel.org
X-Gm-Message-State: AFuF++kWfeoOpHlkAr4NnxrBqLjuYp71Txz6bo5Iu8EEed4MX7xufrox
	imavcchbdH2SdwO6rlHfoeYGssG/PJLz2ls5s+l3v6smwCyMu/9DdXrZ
X-Gm-Gg: AYBFou0qWSSlOVW7DNvcpDEFYLEoaD4HN5p6lrXzR/ZXLMO5MaPYCYX0d8oFiyW+Oxg
	ESFK+rkZL+C3YFa6D8yO4vRUNAcuV0VvHaYdTNlvHNNnxOTXMsYqRacoKTpr5ZjS57qfQUOo4mt
	KKxOXI7H6lgB/dcjxykkL1x+IL+uDwww4Rg+QPIqCO1WqpLKBEiLEMQPy2kPdKpZJE/wTlsWK5V
	5SCpRzQd0x4iJuzfawv+DL52nrTr9h9Aj2sbNu2wxmWh9i5wh6wwZu/vB3KK8ZjejBVv8orctkU
	Y/W08Tu8oi1kTpEYP8Fffv1OB0NhEbGysBpNxvgo3sqb5lp2NHH6JlH83YENAUpFniP2csST+tb
	oe5qOgths5YVpPevLDkVfYHIO4Ovv4JkUzbbFVz00kkDiqubY5RG8zN6283/2cmcPItrjkidnEQ
	kxsoL1+RpF6nk3OZw6PRZqVZ+6+i297T4LJJYcFkP2DzyD85tUnASb3jkCeOW4yBv1wujb2dA8b
	z/qRFsTZssTc8nHeB+oKRlIM/MPkDnBcO5lgZE+dO37KjsDCORX6viZWJeO99UV+2CkUuYoNKU4
	JMysuuMcJMJO5wWVTBrLBR0I3eL7xPVoh/xaRsdmk1T5k1IwjpktEQSsAs0=
X-Received: by 2002:a17:90b:1652:b0:3a0:9640:8043 with SMTP id 98e67ed59e1d1-3a098ccdd41mr1110650a91.15.1790224303753;
        Wed, 23 Sep 2026 21:31:43 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773e7c3sm2181929a91.17.2026.09.23.21.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] qnx6: release buffer_head on error in qnx6_block_map()
Date: Thu, 24 Sep 2026 12:31:39 +0800
Message-ID: <20260924043139.3894954-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-2-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to 1/6.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>

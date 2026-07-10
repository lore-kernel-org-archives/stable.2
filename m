Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70742A160
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687853; cv=none; b=ufbrnBHxta8yHXBz0A/vwKNoZP4jt//Sy3XAeQP6lbpvPzh5t6jCkWgif+jJR5Wp7b7iOmEr6hcu0NnpnuXfdN93pjjtpIEnTUxrN4ak3RGaG03xkl4Okj2lqvgxlVJPjioRbtagH2lup7Z4vvbVxihAUJjTNngeaMYouQhBF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687853; c=relaxed/simple;
	bh=ueIgM9Zedjth2EpM5bWLNhuGCU0XWXsv4zidLgqXdwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOJ4schdrOEdcUHYr3RNDzFseGdrGWSDmOVoMHyzE1VRQ1Lz8xghqx3Z8EQtkvfsTyk1toFhsqIP6AP4dJ6sgcTbVdy5V/7Cfd/3p/sizfdKJRjGhtLz/nNgv8k0OIN/4ky9314VQWKwCd7dap6ismikHNoeF89+9I2h3Eizey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vabxe2pX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vabxe2pX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ce98cb8165so692475ad.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783687851; x=1784292651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yps81SWeSsxnRHs1BlhSPYN6Oe99kcCdL3BlNrpVj74=;
        b=Vabxe2pXoq3icPAfdr1hO+kiwBT5kJGJPnvhbe+5MmWigyYGEpMsv9CJlc/0RR7BoB
         J/zZq+n4UXx7eYDjlqFxWH60Nebj0mZvAT80GUmk9eP+Vp55lw8XFaAF+Ee+XPG23lxw
         Re+So7uYwuAlmE2OGvD6VqSE6IAyBzlEFikxsBszTzRLJlTR6RFjbl3aVJ0xO1UMQzJu
         Pp9M6vh3cnkPG+Z3uy6GQpvww9QCr7f2uHSckhQAJjBbOB30ZNV4w/7B5IKgqJXBuodD
         tVXu2z/G/mDFke3JRZaeOZCKwE8Na75QpUoCa/v1H7Jp5TqdMSQJ9w7FMdbx4O4ZloIG
         V1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783687851; x=1784292651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yps81SWeSsxnRHs1BlhSPYN6Oe99kcCdL3BlNrpVj74=;
        b=OxtdTyieDKRkNuFt91oGoFtVl/aWAhDvPzMQOqK4/dBcKEBoiYj9YKkJFIyxsDCpja
         ggjm9++RTkYX9Ku/gDUdrRbVimzzDRR3QEEUjaBFYzv87CC4KsVfZeRgH4cyyKVeXW9r
         VcgtzYM777n7+D2XJxckteDMkf4a7b+xhHFqojgOMIQ51tcHl+YIntBun5q/2dS2JMFj
         EnE1gM7GrKfGdjHDjpIHK5hAH75B59jW8lPBkvuKmBkQfX4fuOpRhU49PHHqPYTps4h0
         Aj1I4wKRcq2AXUuXAhsIZp5AzDu8P6/A3swd60r3fhlfBDMwRYKJDmvNbffYnRplbrf3
         09ww==
X-Gm-Message-State: AOJu0YwWta+div9meO+uFY8v/FHgLc1o140DcxpsnPi6k+kkIFRc5B1s
	rG9CilgXvj6YFf8Ku7pr85G9BCEdDGSJ3XoDDd1UZ/PoCJS/bNmOvGdonHaju5W0
X-Gm-Gg: AfdE7cmOYaCJ1fb5qJWSHXUI+zDvTCKb+1Y3RKMbmTpjImo7ME25ta0H5NRvbYb/mR0
	FV4u1NmcD3i5TvEFrwhU3nIDNF01XMwH8lx2wMqdEiTp5jPlNa5nskYdAAqZtYXerQwsKggJwkg
	pgebBE0LkP4/ihcOG+FPIOj20iyh+65Ei+SwvNWAISQoKLka7IxklDI0EqAyNmEnGlJ/unuIyRy
	L3skX17JsmwhQUD1PImccdTE15+xPkG0wocfMC1HmVwNsf9WW8TL9/ANft0732yvOsRW2S8hoU2
	LhrhCETQfdl7jA9wyb0wMMwOmxjPB65Y/gaADcp/0h0Y1t2Xqxisp1j2BjMjlU9/hykEb/BRjgw
	TLkxSc/ryXo1qrk0R9Kerea/emsN88tHK4y4OoAIuFtTOuTgTE2pRoG7QCJOEky28/B/8QrsMmb
	TGDANcDc4o0USDG8f2mLvL8tbAxiAcCdnTw2nibknamYuFzmpncQQZlMshCd6P0Mpmz76pZ28lU
	Et42yeinuWNrnmne90oqdqSh6XORIW7xApXR4Ppvcd0v+sT
X-Received: by 2002:a17:902:db12:b0:2c9:d56d:afa3 with SMTP id d9443c01a7336-2ce8292bf9amr34395325ad.15.1783687851070;
        Fri, 10 Jul 2026 05:50:51 -0700 (PDT)
Received: from ip-172-31-54-240.ap-northeast-2.compute.internal (ec2-3-38-221-237.ap-northeast-2.compute.amazonaws.com. [3.38.221.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf7678sm60145945ad.20.2026.07.10.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:50:50 -0700 (PDT)
From: Hyokyung Kim <pulpannie@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 6.6.y] virtio_net: Support dynamic rss indirection table size
Date: Fri, 10 Jul 2026 12:49:12 +0000
Message-ID: <20260710124912.5277-1-pulpannie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
References: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha,

Forgot to include the test details - 
sending a follow up e-mail just in case it helps!
 
Tested with KASAN (inline) under QEMU
(guests 6.6.144 and 6.1.177), using a virtio-net device that advertises
rss_max_indirection_table_length=512, i.e. larger than the driver's
128-entry VIRTIO_NET_RSS_MAX_TABLE_LEN.

Boot time testing:
  - unpatched: KASAN slab-out-of-bounds write in virtnet_probe (both trees)
  - patched: clean, no KASAN report.

Runtime testing:
  - patched: rewriting the full 512-entry table via ETHTOOL_SRXFHINDIR
             (reset and explicit full table) reports no KASAN bug.

Thanks,
Annie Kim

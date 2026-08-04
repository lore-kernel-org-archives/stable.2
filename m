Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18A41D633
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848440; cv=none; b=C0xiLI50yGnVUrDV2+mKdtIMDQm8FdIYxmpydeY2IK0IOgLYGbIBx6WHqb/7VY62iXDnUltXRxzlDL1YobQCt6hg94MtO+Tve/frb4T/TPBwUHBwOaPZWseeLD1hsDqdsg0KV1PVbKzO5OqJKVRXmtf3e4m5acxzKAgxs5TUZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848440; c=relaxed/simple;
	bh=1gcBWOrTOzOQV/Ehg06RxfoXmN13vDhe0cvi3LfVU9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bHOPMRZcR10CWYYG4vxPjTqLsqjdhyODH5FswsfA1QPPr+TCerPesWrYsPFRC/z52GHTUXMIXyjld+xzJBn7MJgSYAgGBJG3aJBnc+5A4HA9MemVBFrFeRTCfwHPRghaQKPe9Et/KFmhRbSLcm+P+xeC8T2lhX1BfK8YQtA+A6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=W3AAKI9A; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="W3AAKI9A"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso2614393eaf.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785848437; x=1786453237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EeesDTwPxGyABvFI6+fdkOe4CXYZC9PTOa9K6Xr2inM=;
        b=W3AAKI9AwaOZG27Qyd9OOk7AB9bsj0XbXx4nLI77dD6h9jQjLG0nxCq/VMe15pBzBf
         2fEtSHFVv34l08ojxcyQjO0X/bo4OEcrDOkWdPw4aEL5GljxgHvnbE53iMsFpGZyQiO6
         aa6pdICg0nfbhXn1/LbnSlxWT2Fyi9A1RswwvcWsd2bG/QF6RRQEmzLij/CGyfr1x9BR
         SJew6Q4nY6SRz4GydC14KWhF0XTOjrZbgyzi50mX/3pJLmmvv7q2u9cRWtuA6f9JoQfT
         rlx2+3/LLOTgsWrEGCnkbgwQN2hMQSACgyXvdAMFspa6WdqI5HAxHKkonWGsOugIqpMg
         twXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848437; x=1786453237;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EeesDTwPxGyABvFI6+fdkOe4CXYZC9PTOa9K6Xr2inM=;
        b=NkI7c86EyY6zyw8Erzj1Kr1T0bfSQP//uW+FdLiK9SDN24e/qM6lKNacY1cX0Tmdrn
         m/i9TwrzlkboWc7KzkcauOi15gUiz8LDe+ageWZmqMGbc4rQLn+1NsJX8NE6Fy7x6wA9
         n2nzOGg/OE6hD9ui+LPnI36VmZ2Inkchyx4eJdvoUK518DW0kpKtgyb6S7ljszoAFPc2
         qkIcIxfxevgfvZQJMvlJQOfY/sNY4GU5DJXDhAG8cLj6F1YpgRIgtuphE0aqzRfQ3Erw
         H1vSp3nRaoSUrGRqkjWDuo2vxdyTcU88A9WbGz8jSs8V+5xEZlhiNxNIb0IAH4uhKw9W
         YeGA==
X-Forwarded-Encrypted: i=1; AHgh+Rqv799z1Ab+GKevtqCAyWJ/SDijekdHXlHdHLF4eOF6feez5oPVEz/JFVSFUnP9fAMYRA7p43k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQ5OB06FCUTO7pwCNfcDyoTTmWQzHB1eTRZg/JneXa+r4OCOd
	4PMDLp1tjnH7/jZQxv7rXXCwDSvzSJniB/+ED6m0mGuBIy8bzTVYCy3kq1/h1ZEn0OuOJFf07bU
	ExhqoV+qGuw==
X-Gm-Gg: AR+sD12U6g3Yv3/FFNHSU2x6NIZEWEKb5MS8UYvIq6aMaMpgLnfIX4kKrUWmVlukeKl
	c6bZg3CXw4gtFL7ydFtI8lqAuLu6fknIIIvboNaV05Nt6AyhRFBsF+kCQWMPHBXmHVBP7aj1HpG
	CAmkpGlUdT3RhnX61zmixGRS8FA4UMvftO6//7/KjXKEGtDvANroeTWPrKGDIeINa6fiKUYEB/v
	Lujvpc1d9r754b3Y5Q5cHL1aYA3TPvFqYwX5JXZAOkSYt/wP47/ThGLoN4pqHYCq+fyIBgfKLlK
	onFRruDvTrlmYWzqVj9c4DIZEaaBsPUqVp/Aw08SeFJe0CqIOHAjH73xXYtGQCtoDixye6y07UG
	5bLKTSDokLz+gAuWwW2LyNnJ+KMJoIMYbtAuValp26VwF9ZZ6YrqnHMwB343UkyE04s9fw4VYe2
	J8Lo0fGiuAxnXrCS0Ds4X+CaxAbrNIMiMHEE6zZyN+EgLkHRnDeDElQ4T0FR3QfwGUb51pLyZg/
	jBlY5Tmywwu9cFOA2GE2Os5eZXR7FyUMqqFC76m/w==
X-Received: by 2002:a4a:e90d:0:b0:6ae:4be6:64ee with SMTP id 006d021491bc7-6ae4be6684amr15265579eaf.34.1785848437457;
        Tue, 04 Aug 2026 06:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d61482sm61530eaf.7.2026.08.04.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:00:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, raoxu <raoxu@uniontech.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
References: <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
Subject: Re: [PATCH v2] zloop: truncate finished zones to zone capacity
Message-Id: <178584843575.926496.3812961471455510787.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:00:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 10:34:03 +0800, raoxu wrote:
> The size of a sequential zone backing file records the amount of data
> written and is used to restore the zone state. A backing file whose size
> is equal to the zone capacity is restored as a full zone, while a file
> larger than the zone capacity is rejected as invalid.
> 
> However, zloop_finish_zone() currently truncates the backing file to the
> zone size. For devices with a reduced zone capacity, finishing a zone
> therefore creates a backing file larger than the zone capacity. After the
> device is removed and later re-added, that zone file is rejected instead
> of being restored as a full zone.
> 
> [...]

Applied, thanks!

[1/1] zloop: truncate finished zones to zone capacity
      commit: 72e67c118642634c25465db0c8bcfa54c4ce086c

Best regards,
-- 
Jens Axboe




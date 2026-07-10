Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9C2DCC1F
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696150; cv=none; b=KdlV0wMH3ImRLpunhUMlcNr+76lE6W6zTID7c2VvTB2JSuI9MJz0lc2faL5A7QChs7NQnmAVUlABfM/yWucAV9dhMH5g1hoReVQHMr7bu//Gy0IDwvZwmzTjm62Pr6g5vHuaiSj7Xb1VQbWcsBiegxQZXzKju21Q2Fmml/prEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696150; c=relaxed/simple;
	bh=KZqtujcSYrjp1XKrHdU8txiKbJH+Es7z7r2jC7Zc6Sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VZcaaMCs8ecOi5qnF9lqCoHO6sxIeGMJsmpWZHOz8hgTvZyq3Feh4AUkxXBnxAbxnqc+CcL1axeaupaCTWnAOzzwuSKXpJZVJoVAHpznc8O0FwOZclfaG1UcUAkw4iIKZjMvnoUhFC8+ad4wg972u0BTZXCtm9oS0mHnJyaHtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=T6sIx243; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="T6sIx243"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ecd7216cso521434a34.3
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1783696148; x=1784300948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3tK8TtDuHzKVLUaacAPkZ3tgZuo4O65PAWl05AIJ+4=;
        b=T6sIx243ummo2V782Lg4u+AGt+fWHSM+Uhg72U0JEX8f/NIt4663qJ/9HNa+GFmINu
         K1lnPZyRSzV9j113rccnciLgH7uWUcWtkfkWWC1a0mq75y/I7aD86NeIsFRzofkPDTPH
         Wz+7Cf2bbBd8kItdK26GuB123QIlKRFAdIfKnbhjZkOv67YIaNobJyr94/GhuqUfhwpo
         enLIU9kqQ8DN0jV59upgablVDx3ji8NUOgt55H7Q6WNqgw7SqujN6y4XdzgWgBno5kJ6
         1A1N6oZnYfN6ds1QGLGOIPPmq1qfaEnPKdJW2+IQjprVbzOQSiUtZZPVIiFbQpQ3ECWB
         /vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696148; x=1784300948;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3tK8TtDuHzKVLUaacAPkZ3tgZuo4O65PAWl05AIJ+4=;
        b=Y5LK31A9Fe2QPN5DmgAm6+fZbDwuC9Y4+5qshIB8ruuLI5nxDciRfP8dRghZBbNQlb
         wYT72g5u1wVImmxefX1ZtfxbfdaL5YPQQSUIiMDPb1sewRaVcow7oQSiBF4Raddmlb4v
         zcy5mvG9d/eOD9PC9igjoDv+7Ww4Lq6cBG4TgC/HJJ8Ht+/XqcPgIiKqStPFgwnSnioZ
         TL+9vL0g+C1CAJZ0u1hw/OEl13eUw3gHJnftq7jqB6v1QGYeDsu9GsqWRtsTdHMRkrmx
         3Jdv5jtGVJL18Ev3t7PfEr/J/Shm89a+r1io83ru6xQQgTBdBmE2kCEkKl0F8zC7v73F
         XZMA==
X-Forwarded-Encrypted: i=1; AFNElJ+iEUB8NE8Sjx9k7HD+v77wQsaNK8jVMwVvQxzJUUbbBmRIEZTX1SdQgPXQ6HnzFK5D5p8DsCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmWwUR+Hd45JamzTI99SUFkmeOl27ui86aDTmlQFPjFA5HdT9
	MTkh7u6iyZtq5CsE+adp1Atvc4fIDoSFqyLss27PkpmgMdwFlgCo9TKlwxas6sx5W3Y=
X-Gm-Gg: AfdE7clXe5denzJWij3n0HU37V88x5794sHI7HAr/o68sl0I0Vs80KqPP7teBUgVpsO
	7kNPNpCvE2hmaXFgrZB4ODgkhz13+MWwqazzFtGF+W3VksG0hPGfNJ+VQPGFJFswCyqJ+aotqB2
	esg5/k4C0vXPAEiberIre7QuGZZN6Fs3GTNtDFLX24/vwM4x14SwByC0MWUWxhOTKCqmxMGXoeT
	rZssUZntUqYUHyStZVr6mgxFhdvm5220nELYf+Hc43UxWE6MuPa6MOgjc8vgZzcntKJc+I4I01Z
	dRhLzCHwdBaVZs0l5zZtQQGfWo3+FtiL1Pwy42Nf1BVEShtsZCbm6O8XwIzU+ZxUAECg789TQfZ
	8c9SiZrXV6lKLOri1ybENmy8XwONBytq4hacIn7h+30Z2DrMAuMzUQ5dHkygvHrp5HkUSm2fwL1
	qwFiHM79R/QhiiEffZm5od/r/jbiIQvw3wE5Rz6akoMI2t7Qk8vwUd3J7/mDNGjBZEbg==
X-Received: by 2002:a05:6830:81f0:b0:7e9:b4cf:d8c7 with SMTP id 46e09a7af769-7ebcff9cc64mr8083563a34.27.1783696147861;
        Fri, 10 Jul 2026 08:09:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm6709330a34.5.2026.07.10.08.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 08:09:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Connor Williamson <connordw@amazon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, yukuai3@huawei.com, hch@lst.de, jack@suse.cz, 
 nh-open-source@amazon.com
In-Reply-To: <20260615130715.53693-1-connordw@amazon.com>
References: <20260615130715.53693-1-connordw@amazon.com>
Subject: Re: [PATCH] block: remove redundant GD_NEED_PART_SCAN in
 add_disk_final()
Message-Id: <178369614634.284240.18222044248749979725.b4-ty@b4>
Date: Fri, 10 Jul 2026 09:09:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 15 Jun 2026 13:07:15 +0000, Connor Williamson wrote:
> add_disk_final() sets GD_NEED_PART_SCAN before calling bdev_add(),
> then calls disk_scan_partitions() which sets the flag itself. The
> early set is redundant and introduces a race.
> 
> Between bdev_add() and disk_scan_partitions(), concurrent openers
> (multipathd, blkid, LVM) see the flag in blkdev_get_whole() and
> trigger bdev_disk_changed(). When disk_scan_partitions() then runs,
> it calls bdev_disk_changed() again, dropping the partitions the
> concurrent opener already created before re-adding them, which can
> result in transient partition disappearances.
> 
> [...]

Applied, thanks!

[1/1] block: remove redundant GD_NEED_PART_SCAN in add_disk_final()
      commit: 181bb9c9eae4f69fe510a62a42c2932d0314a800

Best regards,
-- 
Jens Axboe




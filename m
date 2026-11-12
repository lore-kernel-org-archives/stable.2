Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489187;
	b=K+GESpkBuveuHWwv4dEqOapJXlWu5xosZYjw+4eGkSilQZJgMwk4J42kSlXKzSeGq+Qx
	 e6D+PAp6Guzx5L7HlXY2UUWpELz3aWq/f6opZVFD4J+lP+tixF2BGeOF+1e1h0JfSUTWG
	 4fLV/mr/NwzI/vdrNNBVvLRo1JLUBt4z0FEdXYJnnBX7q15oDKAHYR7a7uioO5WA79Egf
	 nCgECy662ipkBVQKJ2xJLqlch6Dh+ezpiOEE7i5mkZAP4wVKH75AnqKuWsh/yEDD+NDaQ
	 JNsCaVBDm31pXwCLI3258E3KVnuNnr24muflDBkCjMCh6hdy2sYAHUW9JYN95SmBZNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=X04LkhaQLlaV3mioxdzzAAyEpGQXEeHjTvbwzjQY9xU=;
	b=UXAzeFGa96WAoLP14khS9Gd1wKhp73aOJRnD5pCDlOa7ffFGAD5mPqY68Ur1athPjS64
	 rRRuFg/eG2pEs6MpgjPjZqQpX5luIqxZJ4pzNAkXlJDs/o8ij89fEK2Flc+YLnY3sHjKP
	 F8xk3T3Hc9tbqmfsWZZUFfgpckYyWSR0Nn7v9xqBnlJryudZtcUzyTBo4llHUMIf+X1ka
	 wT0TRUJmGycYGvNvuahIc6FKC+fXONKgcyA96dM8YxhrS3vTx2hfdoTq+w8NNZSI+pOwG
	 XvlQtwGRSgoBir08RjrxMLuI7p5YPEmQ1VlM6uIRvnAvWmIJA9aMbS5CqmjjpZ7vwoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVQromht;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8E606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A8E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVQromht
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so29680085e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489186; x=1795093986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X04LkhaQLlaV3mioxdzzAAyEpGQXEeHjTvbwzjQY9xU=;
        b=FVQromhtN/Go/XIDyuYC902RHTcN5TsejdoIaGldu+QyhfxuyH4c3hZSeOxgdGut4P
         6dfj2etj/NgfxxRUaLJDtuS/Erm5AjNwBSE5KltouHCh+ScqB80NRuUiElnrDAskBYu+
         jO7JNG4B/jX5w21G2vgepNhBTmf4tb+f+JAHLnNustRzIxWDtm1A8jFMFA2C1wLuMT5V
         pryw1LtqPgCi3KNz/gKwISKJiWFl2yZubIl3zx3+3N7yNIXhHO5BS4qJUL2oI6EZuFpE
         rIlFpOdcPV0m0kjQmF1jg1+2oj/aVT+qaKsVhxXLlgRJ8c+ZN1Z6B2aSaYHvUAYc21Z/
         FiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489186; x=1795093986;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X04LkhaQLlaV3mioxdzzAAyEpGQXEeHjTvbwzjQY9xU=;
        b=HDs9i9dl3W4WWbypSPytGhZ2hKqtiOu06PK7axPwZXo9mvV+1RBUrVxev2Ctox4RE/
         dN+kYpOAvIov8H00s4vdjesNAxqJM3Pwd31HQcXyqr6hRyQxbbw/gFbz7kK5U0crmX/X
         5OBtCLaQPB+67PB+Nx/sbK9VTWqgaEfoDjSnZEEh/a+8oRMMEf9KKIIU+/TmkPa4aYje
         a7BnCiM35IO7ITdjUGhJCjEMtrvrzIg2DGFBgSOe2ZQ3KE7yDzKhFV/DOf+kflWkRisl
         5rjWC8Sglbj4ecsBHkjJVzxiHkgPLd6UaoKEB6uxoe2diCYzdObfU6PT+pDMHU+G4NtF
         Mm2A==
X-Gm-Message-State: APuU4Z8J0Ir4biOQLuL+2TQkRCouoFp2jK7TLgoX4N+7SrByijcqU6OI
	CTuN66wRXcKs0+B3jLPyIr2iRHaGv4Jr0HoyjG4y9kpK4RIpA4Zp6SLd
X-Gm-Gg: AYBFou0vVWAkwwdJLx4nEvutfZMnIIBmUsVtSVbX15vUW5UBJjHCLyw0rdrzc11xdP1
	/saXGuwVTcsXQdeRHchkVR7++SPl1d3L/SrfUoHzEz1Ssswuct6gHW9QGcYkMCZb6OJzjCeJh4i
	Z+9Vy8+/R4X/vxPyU8AmgXfYfC/+znHWwOewVE5qDjP7HIZst2XP6kn9+khXlXRRIPo79eCb3JE
	cuZfpuEX6MoRel6FrIiZkwxAzdyRQjZH0qlqkkwkLcknGe1HWO6qM0BiXOIvqqLocvHzxjUMT/R
	TNUOgIiiZ0GqmWrZZfYTq3k9Or+hvRbBvbx/XgvmkRkOLlbQbiVKB2TkGDjahIqI3f/2iyb5VwS
	muyjejeyK9e89j7t+d2nXvBBLe00TEdx47tS648PIji0i4LofZvKwp5ClaHB7m+x5nhE1+oQB5E
	E8vNKqWE/vZr6rrMQ4wOIEwG1vo8DhrjcG3lzp6nyu1VLeccIQk2LS2+QdQz8fVC9lUnOqVeYMf
	UZJ50Ss5tDF1ia+6B3mjEr6LV6Ez7SDaRKhfTAqItP8+OwxeAn605qyv/7SMVrK0XUqvPJmkPAF
	UyhzE3WccX5yu81ty2Vxm6gGHXfwo7qGhjdsDex5Lk7kQLTWv/GPwyJeuFJm+0CT+cNPZo3nEXF
	/i8o7/KPG7rlCTL9FPW8VzDRye1nTVGBIJK1iJQaNs9o=
X-Received: by 2002:a05:600c:1c22:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4ba093b5bdcmr122698505e9.17.1794489185746;
        Thu, 12 Nov 2026 05:13:05 -0800 (PST)
Received: from cachydev ([85.97.71.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e25e3bfsm69368635e9.7.2026.11.12.05.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:13:05 -0800 (PST)
From: Sercan GOKMEN <gokmensercan@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7.3.y] ASoC: cs35l56: Wait for firmware timer expiry before system suspend
Date: Thu, 12 Nov 2026 16:13:03 +0300
Message-ID: <20261112131303.184083-1-gokmensercan@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <2026-11-11-1-daily-reply-0021-e40967988dae637472c1@kernel.org>
References: <20261111-cs35l56-fw-timer-7-3-y-v1-1-43fc95730c11@gmail.com> <2026-11-11-1-daily-reply-0021-e40967988dae637472c1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 11, 2026 at 04:54:54PM -0500, Sasha Levin wrote:
> The same bug is present on 6.18, 6.12 and 6.6, but 6cc7db9fdd06 ("ASoC:
> cs35l56: Wait for firmware timer expiry before system suspend") conflicts
> there. Could you or the Cirrus folks on Cc send backports for those trees?

Thanks for queueing it. I'll leave the 6.18, 6.12 and 6.6 backports to
the Cirrus folks. The laptop I tested on only has working sound from
6.19, so I can't test those trees.

Thanks,
Sercan

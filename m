Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF23515CD;
	Sun, 11 Oct 2026 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737313; cv=none; b=IUgiyn+focby0p+H/3b+1iiC+r5eCQo5dKl8jZj+xMns/BKoH2smHX/XJWrUt/830XCZyKvGBdbNQXNmZvWw0o+UwZPC0KKYNAAU+EZewM4URJZag5dycrVMucsMPsGb+YuR64KDjqzxEReh8fby/2fFlyL7wmrCEvKW/pgMwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737313; c=relaxed/simple;
	bh=4+eQjo03LUtBY+noySbeFg6JpMN3qG5vQjSUb8GNteg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfKjx8gutDP3O/hHL1lOHUHUTV8YtCuI61kVlhbcSMITQ7/84KEL3cQdRVy6EteOAchorcmycVOeb5qN8it8vbPgkz1Qz8Jq6kHUKfGfmmlOrg9UccdUcIIdg3n0olAscrpajKUyZJV8rjWvs8skIjeX9bskCdRQddLHCV/DAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG4Ncgef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG4Ncgef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BA51F0089E;
	Sun, 11 Oct 2026 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737312;
	bh=OB+vfzKm3XNV92058admPw+IuQBNMelZc6Sdfj/R7KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UG4Ncgef78z6L7ILZ7TQ1RPPyLE0qNZvsb4F0QZRgCQFKo3t09cvI2Bu9V2agY/i6
	 orVJ+SqxmTanRhPOzy92QDO2jkNu9x4k7jc+RSryOEGhnqton99L9wccMcWDCXsYzt
	 PHLXFTPQsJR70NM3TeA4fTdro/LBtDVSk8f4VrdesLZ6DUHXze+tr19DZK1R/uKzXl
	 6danHmRqiQXTxhYLIqc6hZxJ8aJ+BERCwSA+llpsryNoPXGwmU+hc/wFw2d6v53yQR
	 lDbdtTAAWkg8I3ZyczzdyGGQVSREG8z/msZA8n2MdfcuS7oOb9p4e09D9XGP2HuEde
	 kWXkkhK/gCihw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Min Ma <mamin506@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Eva Crystal <0xiviel@gmail.com>
Subject: Re: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to the BO size
Date: Sun, 11 Oct 2026 12:48:09 -0400
Message-ID: <2026-10-11-1-daily-reply-0002-amdxdna-sync-bo-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009032616.432392-1-0xiviel@gmail.com>
References: <20261009032616.432392-1-0xiviel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> amdxdna_drm_sync_bo_ioctl() passes the caller's offset and size to
> drm_clflush_virt_range() on the BO's kernel mapping without checking
> either against the BO size. The ioctl has no permission flags: any

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

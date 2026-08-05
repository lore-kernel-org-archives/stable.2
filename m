Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333137419B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948119; cv=none; b=fHRzVvSYF/jndAO4YRU7qNGrRKqEfFOIv8bekVHloUhJpIvXmxNtYqlBWN4w9mi6l4EejCP5fNT2A86CgcbLYhoAgokUn+kwRk3xamzHaUVJDvAutsZ3CRUaxNYGMhvmGd0WzWbLkQWlXoYPilEUNRntky3H8O1+w5o3Z24CjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948119; c=relaxed/simple;
	bh=x50kFoJB2sr7P4wgPNeWHUItaNdH1O91AtJNxzutqNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIEnC15Bnn8qBS0dSCF15UDWjjs2lIP3qpXcYksEnVhd/YbCOMlm8UFDORH9hU5P3lPZnEw3JNuh6o0xtNzrBTgLOw47byyo9LbhByjDp8zymomEGoaz0R5q1PUx+gKvvPmchy5tra+zZalHuWt3WEMK0UUi7c8Dm8EsBm8RJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsQkAWk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsQkAWk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4850E1F000E9;
	Wed,  5 Aug 2026 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948117;
	bh=nTkWqo8KVaxCZoPrLGCzGWvWbbe/M02sXGKG6Y/V1+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QsQkAWk2ljuFsgd8v/WIGVE2V2gOZC4JMCUvH3hK8C80wPrOcxoTKpLobbaus9nag
	 CmaVROHrPuAfhfK1UMiMXcB1xdLczm8pmDaZqboYBgO3JcMojbOYWajY2oA+O6GP9C
	 cZfSR1yE6ArQcjZh8CQK8qMCwBC3AVInH9d4kSF6oV3AcApbUCSPnq1DeBshqNTZT4
	 eKfz2tfaCoWMSNQc0W/8KE9UXWV1Du5M8tl8/eYyuj+RhfKtaz49m2J2tTnG6fGHx2
	 KIvE4LGbaU3/7PW606dVw70+ALV/xXzeB+0ef1u7O+Jon/E7Gex+SNUDbLWv6BO5b7
	 Vtih24ujhJUKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH 7.1.y v2 0/8] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Wed,  5 Aug 2026 12:41:47 -0400
Message-ID: <20260805164000.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
References: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 07:42:52PM -0700, Ashutosh Dixit wrote:
> Backport of the following series to Linux 7.1.y:
>
> https://lore.kernel.org/intel-xe/20260615224227.34880-1-ashutosh.dixit@intel.com/
>
> v2: Fix upstream commit sha's (Sasha Levin)

Queued the series for 7.1, thanks.

-- 
Thanks,
Sasha

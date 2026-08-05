Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4F357CF4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948120; cv=none; b=uNXdTK0HQyQmQFJ1wW57/LCRHaFMhn5WuXX8r2Fi96yRNZ3586AQxlkRJPG6Lf4ib9jpnzstve+pFQu4Bz5sY/MtTiaPJ1iiOVilIiRYJ0zdruUSv6MVAGNEpQvg4xJSSozAJOFKvfzw5CSu2QjLGbIkW2RwjRpMoWE3xBc3n9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948120; c=relaxed/simple;
	bh=AoyoQzNjIPVEUK/a/7zz1CkO9+Qz5wba19M8qMXmNog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWBvDIjoSFCOGWiGIHrPVeVg0CUtsRyJUHH4vG4gBb4q5in7qOyZWufE3BCZ6nFhEpaZWB9eCDcRVR83S5L1agYanBaKAzYZtATKHEupysdtcggZATXD74O5kRoy7mnfui7QQ7goCPLn7BgomN3ZPFTmfUy9cR7kK+WxHfbI4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QItcT1U0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QItcT1U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE21C1F00A3E;
	Wed,  5 Aug 2026 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948119;
	bh=VCIdb3UFejydojy7ZwG77vKzRRsWk+4qvbJVvqA8yuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QItcT1U08RQnAXp78WWFn0nkV/NYVB9qJJ/o2yuGzrWiMaw4tT6WvrBujHXtkfasR
	 C7r+HRnUQq9yEoqAyOe7JEIs0lGMBPmqvDXpMDqwO3nMJH82cbO7aj6QVAbHnVN6Fm
	 khu2wkEgPe4acn+1TNFYfKiRXchKaT9kp1iAImkqp1OGEHEasMTbv5LIzSqvwNmRGQ
	 J29ID+7lCd9c7YhPpGxttVfoaLthf4KGqmd0WNdZSdL8OtIFzTlHvZ2B8pO1oZud5H
	 plyYu/3H5A+1y3rGFlTIEPqwDm3PZ2r/cIdaczDxctNlP/i1pQ+7miKgUQtCBagASq
	 1zbWVF5OnsP9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH 6.12.y v2 00/12] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Wed,  5 Aug 2026 12:41:49 -0400
Message-ID: <20260805164000.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
References: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 07:49:03PM -0700, Ashutosh Dixit wrote:
> Backport of the following series to Linux 6.12.y:
>
> https://lore.kernel.org/intel-xe/20260615224227.34880-1-ashutosh.dixit@intel.com/
>
> v2: Fix upstream commit sha's (Sasha Levin)

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha

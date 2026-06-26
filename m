Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D453A83AC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496504; cv=none; b=m3n2i0u6HFphiUROkHEiOWtg+rJRWiXeNxkjPKICmJLVQ34guOc2obEg28f4vPWJ4yb6VkLu1yytE1E2MHNYBewB4GMrbRe+suFF3tPj6dHB1aT1v04wWlObU/dBU5E4wfIc1YKhcTYUh2Io3dZYqhOR5KN+m5gEyC/zis1ukDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496504; c=relaxed/simple;
	bh=rzv89d7x0CS/lgx+sOybxv2ybeQTLerIGI9OP9tctMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWkQkO1ZiEO1lieAobesyQjfB5K1muPsjdM8Il0hmadTpDK52E3gtZSmBVpcr9PRySwp4uw4Zhl3zOyffK5kNM9gAI4UObltSEU1qXdKcHMFiQDr4ru34DaAyJOh1uiSVsrca1e8wKVu331e2z5J59paStklcDydOMPgXqaxGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BucADCAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BucADCAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACF21F00ACF;
	Fri, 26 Jun 2026 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496502;
	bh=qIDhNn27LtiZ78FO/Hnj+1740GHIkWRZOms0c1Rzsx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BucADCABOCDh2uX0z3LDDOSiwSZVqi3vQh8ftDfm9LVNImPw5aSoLIOWQ5sfu3jbE
	 jdP345fJFQ5phqNuU47plYQJQXYXGrqi5k404nK5Pp3RIOCAovTojSHGOhP1tjRzKl
	 KpjT9G4xwd1gNQxlf+iWQ4uLIZk2Pless73vVEETOWhF4JyBU6rcy5z0KK3tiPKoau
	 hB7iTRNmbpvDM4cBnlqylWoTvApp3hIX1ttowd3OjPsoWZHQGTQurb7rC2Lf/F9+Y+
	 O7BiDNps9fytB+6ET0ywxPo7gFR0SRWQa9rJlsCkjaYShkfDTryxnN/aiZpD5hiNQl
	 YfjXRipy9KCgw==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	stable@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 6.6.y] Revert "ptp: add testptp mask test"
Date: Fri, 26 Jun 2026 13:54:29 -0400
Message-ID: <stable-reply-item013-ptp-revert-66-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3651ff8e1f7ef3a6e8f40592a1759e494d7b3a6d.1782385355.git.petrm@nvidia.com>
References: <3651ff8e1f7ef3a6e8f40592a1759e494d7b3a6d.1782385355.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] Revert "ptp: add testptp mask test"

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

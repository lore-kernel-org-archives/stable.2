Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F852394E91
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787099330; cv=none; b=NW+6jWoQi7D8tQhMqiJouh9s9UIKKChJtaCZyzO5Yy6o5RiUgIHpoaYIefxzb5xQ7vhB0BS+Zzm+pBeqOTA5E8xp+F1X2YQ3ju1Ublakqs2eoIpTyfz9SVvan84YSo4eahIbsMZV2zv4oNKLbaKG1QCawy5bJ1QF9Y3EWvh6/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787099330; c=relaxed/simple;
	bh=Ouj566medV5aIyecajK/jVWdXC1kZHJRwZEe5Flm4ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j83XwZr7hWJWNnMk7DJ9KGfWuYKHaGpsFdesK7Y8Tx3NGwIvmZ3mydT/swgJKJDMLg2sTJABMtC3/9gDMzILB4yzq+TxVRZuZDLmsrXtFtVwJWtWiw/Tuc+eleo3SVD5iCfXv1vm4QQyx7lIZEX+B5kCDJkZabs3kpjBvMHePjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxLxrj2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxLxrj2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642AF1F000E9;
	Wed, 19 Aug 2026 00:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787099326;
	bh=Ouj566medV5aIyecajK/jVWdXC1kZHJRwZEe5Flm4ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LxLxrj2C2ikFlueucRqOOI8GK8eMZYp1K88LxcUW63JktjdKNGqR5BRvfljiWd+4v
	 DtwLRBzfWNpzw9FEk2O9myHllh/KXDIUN6A2st3tRaqeQkev0Syqz/7pTKYTJLQEKe
	 /jARU4HbdCk/uXZsA5Ln+Up0E4OI72pBn6p5YLkoEjXAyh8/H44v0JBz37J/Ag9OS+
	 6H0sVbeogS2EBB6s41+a3gdodSfXhYlQuqH2Ec2Qx97XJ7KwT1OvJIIxItTzq3WJZf
	 cX1b6vLbBrUXi8JF6oA7GHyvWwpGe1WoXxiAh1eyejoOE+XqukrxWWHNtQISLh1jAP
	 mu1fLmO/Rb4bQ==
Date: Tue, 18 Aug 2026 17:28:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
Cc: kernel-team@lists.ubuntu.com, Ankit Garg <nktgrg@google.com>,
 stable@vger.kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>,
 Jordan Rhee <jordanrhee@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Joshua Washington <joshwash@google.com>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [SRU][N:linux-gcp][PATCH 1/2] gve: fix header buffer corruption
 with header-split and HW-GRO
Message-ID: <20260818172845.4aee80cc@kernel.org>
In-Reply-To: <20260819001532.21315-2-rickey.castillo.valenzuela@canonical.com>
References: <20260819001532.21315-1-rickey.castillo.valenzuela@canonical.com>
	<20260819001532.21315-2-rickey.castillo.valenzuela@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 18:15:31 -0600 Rickey Castillo wrote:
> To: kernel-team@lists.ubuntu.com

Stop.

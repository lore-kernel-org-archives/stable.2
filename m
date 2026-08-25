Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D73EC831;
	Tue, 25 Aug 2026 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658580; cv=none; b=JNweh+gBDBYl0Ta+HRCSf7sCg6kk7h/7zqVbxRPdHKOhzIxpcxq3w3TP8oJVZh6Km8TBme3METb3jlzSop5Ae7GeJfm8cAciqa9N+yTIRBdnIyZEtxHjQUNnRrACPC4sQL8s56YTL5nehY7PC3RkUXWoWbLWNC+ptbEOGmTVNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658580; c=relaxed/simple;
	bh=vF/NofhQRISXuBLKCIyJDQtBtbKwrIKf3STqcasmukM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZANDudSD/BwmrtiL6C6UO/Y4AFUAH4q/PBlygcVoIILEAqyrWv0eiJzOO8q7bayZsD+PIe6KDGYNjFhTiVGTmDeNYVHRsDNNb9eqwxuPR5r/5NQ2Ci6vaNEAQTc0gMqyWV5AC80E338zBt9Bc3WIWrWtl2RAUp9UAqBtPl3j00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WODV7CYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WODV7CYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8295B1F000E9;
	Tue, 25 Aug 2026 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658579;
	bh=lQ+Bc+20YB0DASmNf601uYMQYURFQFS2LpCO8+kh8Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WODV7CYj3cEyG98Pq3SKhGKq59EPeZAfgergN/ocEEGPCIr4glo2i0wMH/2TG3917
	 uuCO46ic6h89G0t+x16Gz/5V+V4NV8unzy7bClQg2W5RagT2iDgO/WLfJm5TBDoDv5
	 5qn8pOtkzomP6n4H0CLYjfXki0sTxFNdSFkQAN4pOBp6A8zIfsjfApRZPhB+nQ22kc
	 7IX50Kva47LaOv1kkipTE8sV3fVjyvOBqWi9PH0RJHIGF3ApVfrG3UiL6TB5731UJI
	 qbZNaOajlJeyx1Zs/il+f+9lfpA/UeTx1Iv4p1sPUxqW0w0sVs5aAyNGzoFP00rB7a
	 uHysp80gZZtTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xiang Mei <xmei5@asu.edu>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.1.y] xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
Date: Tue, 25 Aug 2026 07:49:23 -0400
Message-ID: <202608250001.9680466620fa83c7@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821044210.10076-1-artem@trailofbits.com>
References: <20260821044210.10076-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 21, 2026 at 12:42:00AM -0400, Artem Dinaburg wrote:
> Please queue this unchanged upstream fix for CVE-2026-64581 in 6.1.y. An
> unprivileged namespace user can race UDP transmit with per-socket XFRM policy
> replacement and double-release the cached destination.

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

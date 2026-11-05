Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886326;
	b=wr33sw+6zOu5kEEzNTBmJUwR8K0VGv1L9cbuUl0txAYUW7bkzJLGW/zEkyQ3nX87e4E5
	 KjI/0+oHOfM3dhF9Hg4MwfmipvCjiXrokGdI0yR6Tis2I8Gh+ye/1SZyoieA5UKXFQjbE
	 37yLz37h0AJrehMZtyVgzi7KaCXua9XetdFqKtT6PxvpowwIQZ1a89pa7EL4ebdp1akB7
	 upM/H7i0O76MuyplB23E+0Nf+Sp1FGRiRcZPqnF/VlHzVOE+bCNk8E6oLs2TsrbsEERaS
	 UFvvM4GiOcQUXInNMsySOIuZ2SHvC+E+YHykys6dHAg5rLyK4crpIL7aggI9n0+SrsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886326;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/yduNHVdR2dgpRVHoce+3rrFz1H4WEhQjPiyQnUEpz4=;
	b=GF9HbGqd8a2Hf6ws8ykVgAL7JBCHY/b9+2CxUXbMWzNC2k+fgyjwo6SCrndi3yVWmzgr
	 P0GyHONJ5NWLkFcpFA12Ma3AipPvniilBGMC1WrPS4Mtu71lT3cjD6lAhWhXqy5BqH1GQ
	 vl5gpVgpj8TlPB2nvXUMlXNpu4pXkaerLLBDsHkSRR53AMJKbc2cot/dAOqMfXstK4h72
	 QgByOV0AxXBz8lYnTVkrm/YW7rlAiUVK5TEU4t4knGFYBUetuEJGa44X6pSThe4Bznfl5
	 veEs1wJh22Rl38Ttj1sHmHefjbU5pAyxBBfmzOnhQ1sW1bpk8u/5dJtlC05U353a+KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQmchriS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75F606A331
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQmchriS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25E71F0093A;
	Thu,  5 Nov 2026 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886326;
	bh=/yduNHVdR2dgpRVHoce+3rrFz1H4WEhQjPiyQnUEpz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQmchriSJJkf+Cu4MRqL1JZQYw0qjjjTO1DloGRO5glGhhIdfFu94YEDhnRb/J4xs
	 91ecz0GycNDy82+w2ifcQnATqvOnzY0m6ezeMAhtXx9yQ1yb8BMoip+wpw6NSDyXCj
	 4LzWja5v56dmM/HVJHNGE2JXDRWZJNYkKoA8xfhgw7jGR6YsDH4dannDJ78WwwElV9
	 jcojlm8l1hokDSsRyi4IEycd342ebydil2uZjGfxwG6CX2J+BqlZzLO0dmlkDgSMOw
	 VqfppztlPtuX7dWIGisKFYfhGWST9NkZpVqoQwM7yOAicEYjrTpCJHhMp1jGuV0TPd
	 tX9T5PEsFFn3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: flag excessive delalloc rt extents as corruption
Date: Thu,  5 Nov 2026 08:45:24 -0500
Message-ID: <20261105134355.1398802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110458-culprit-afar-aadb@gregkh>
References: <2026110458-culprit-afar-aadb@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 2b47be015a5e54f4a3d62afa636ba593de9b67f6 ]

LOLLM observed that we should not allow repairs to proceed if the count
of delayed-allocation realtime extents exceeds the number of free rt
extents because we can't install negative numbers into the superblock.
It's unclear how we could end up in that state in real life, but let's
at least complain loudly about it if we ever encounter it.

Cc: stable@vger.kernel.org # v6.2
Fixes: e74331d6fa2c21 ("xfs: online checking of the free rt extent count")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: removed the xfs_has_zoned() check because zoned filesystem support is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/fscounters.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 98634c668b56c..ac7e6329e46e8 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -606,6 +606,13 @@ xchk_fscounters(
 			try_again = true;
 	}
 
+	if (fsc->frextents < fsc->frextents_delayed) {
+		if (fsc->frozen)
+			xchk_set_incomplete(sc);
+		else
+			try_again = true;
+	}
+
 	if (!xchk_fscount_within_range(sc, frextents, &mp->m_frextents,
 			fsc->frextents - fsc->frextents_delayed)) {
 		if (fsc->frozen)
-- 
2.53.0


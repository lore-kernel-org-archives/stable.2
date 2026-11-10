Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354541;
	b=tJ4ALjuIsq3Qa1ciBl7Vs5S070hnZ90RFgq6yh+sDmAkg+BTE67xOeizHLyx1lMotklw
	 QPKoDVPe4QsnEjbWmQBJXKSFTfhVDeeYiQAv2GCvJ2aSaqFoC++ia9J49dWZiS+HYT8v3
	 T1WaXyI3YacRITfZ/M88DrtFhx5O5+jYdVnAwsJMvtwYyj9XcUtZF//GUzrD5xAs9gj4E
	 Y0iaURHR5pID8g4ASnQhrJBZ1NEwZ4Tp6J/ORw14wJTSl4W7BgLvl0h1zZNBuvLTvRg10
	 jAW7bX/P6635Qubs3UOgqaTpCSDOU7EaN4+CIhMbUB5I+5Vf5r+onWlEkhi6cf6toVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W/Z8HddXRhulnDOv7WB6GJf9/tiBNFZLPLdOuvDbWkM=;
	b=Z+dTtnoyXgbaqhD4ER+Y3TO4TPJrma1Wsg7pSwixopgpJBhLB6EywaKbiOkgekt7Jugt
	 I+lyCkFhwcgJTxPxN3gcTwnV/USw2/b2PUTSMyAPPvvlSu+O+YewbNlVhgSNYAQfAvnK3
	 +Y1qZhoLlm4PTetnb0BKeNOd3bMHF1YdC1FJtIMtgUFeRiJEW4pB1Pea3kbYPAG6M4scY
	 RDy/yMwa1z+FyF00xjjQq39s0+NFqVokn92Za4t78aFE9h1H+cZXECCFOqxfvkORqlrRY
	 KtPAi7rpUs0FhJuyd913UZOPJsUyXKhHb2VCAX6ziJ3p3Ie7PLZWS0E8eFHRnYyut4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOhDv4v+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOhDv4v+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9F41F0093C;
	Tue, 10 Nov 2026 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354541;
	bh=W/Z8HddXRhulnDOv7WB6GJf9/tiBNFZLPLdOuvDbWkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZOhDv4v+qPDNwZl2caz3Tjgt01VonMnZdB7lJ4/Co8cpiM+X+yFoXoM4wqSBIraBn
	 FcUZWULvGecp9FrYcKctRuuFSkNb5XB60LfafSpHvBYx1ApF7WH5QnbeexZgvRWfiL
	 ntXmv4/p6mTfQtWjg7UiufFyx1Vj+ZE0zLJSt2BgP+2GuHBpPzAE4ThEhoIKtbdfR6
	 iT6aIquMljg7ZiSuHQnpwBfu+Gf11XP1jFltNZzUN5i2jZW0yKOEr7abyE6poCjpic
	 1VoOxWwFS1Jem7YwZv4QszTeLz1MRZt3pOvIBAOIIU/cw6xiuSziFurJ5DrIUBSRo5
	 zoQ2mg4uV5/9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keita Morisaki <kmta1236@gmail.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/display: Fix swap in median3() for DSC rate control
Date: Tue, 10 Nov 2026 18:48:59 -0500
Message-ID: <20261110234820.186732-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062650-failed-5.10-7b23bf82ccbd@kernel.org>
References: <20261107062650-failed-5.10-7b23bf82ccbd@kernel.org>
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

From: Keita Morisaki <kmta1236@gmail.com>

[ Upstream commit 7b23bf82ccbdb4cf0752f2b8686e7319a7ce497f ]

median3() is meant to return the median of three values, but its last
compare-and-swap step swaps b and c instead of a and b. When c is
smaller than both a and b, it returns max(a, b) instead of min(a, b).
For example, median3(2, 3, 1) returns 3 instead of 2.

_do_calc_rc_params() always passes 0 as the first argument, and the
second argument is never below 12. So whenever the third argument is
negative, first_line_bpg_offset (and second_line_bpg_offset for 4:2:0)
is set to the second argument instead of 0.

Fix this by swapping a and b in the last step, as intended.

Note that this change does not affect valid DSC configurations. The
third argument is negative only when bits per pixel exceeds the
uncompressed rate of the colour format:

 - 3 * bpc for 4:4:4, 3 * bpc + 2 for RGB

 - 2 * bpc for 4:2:2

 - 1.5 * bpc for 4:2:0

Fixes: 97bda0322b8a ("drm/amd/display: Add DSC support for Navi (v2)")
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1ddc4bc97a62fc89d9d3681413d9f977e1fa1a83)
Cc: stable@vger.kernel.org
[ sashal: Adjusted the target source location because median3() has not been relocated. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index 4da21966ddcec..c860e536e98e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -169,7 +169,7 @@ static int median3(int a, int b, int c)
 	if (b > c)
 		swap(b, c);
 	if (a > b)
-		swap(b, c);
+		swap(a, b);
 
 	return b;
 }
-- 
2.53.0


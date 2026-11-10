Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332605;
	b=Ea4h7obf7Z88rdHdbBV6zB4vrJbiGqgvRRvwAuViizlA64FOm9mTXDiUEVj8biBuT1MZ
	 qcoMhHjSN+UvC4Se4SHacFQbIXpXSBP3dUpkZMOvK74z1kzlDY9VseLosahtFm5ErEpHm
	 76kIBAthLAmRsVxA4VHFRur/SFz4Ge4c0d4p1n4txL63qc89mJKjxkUKj0yRLOHqL6lE8
	 VH3lX7AjCRpFjYPBjjijm/6Fx/5QGjeJXPZ4XA7uiNLTvvn3i7efPUxv/2CUWJxCnK5ME
	 6JmPiybdLM9SFA9Gj34PRt1ep7ltFcgDH4lWz+qHOPqEiGc7sJ4Al4kVr4TxZKf6BgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qm6tj3QCfDAO0LbV2Q6CXcZimBSmTc/mXZiqrA6fLX4=;
	b=X1TzWMWgV8qH9RAgu3NUo+mK1lyWskq6uMPDDpygkqHgaWsCLKHDDkXC+K7kupgwXVgs
	 7nx/tM0quhkLVyThCnTVVVWdr/ilBu5+DINbcP7y+zQQM65yHE1aofAkvtFgDTaKF2jL1
	 ZROvSxcHZhm/4+sANtlKHp9KrAOAnEmMw7bQTUqt+SETWJ5j0/8WOvkk7fsD8GXQAkYB5
	 143nZjwDO4OHSMMnOQVi57vabqJVdTZCRuBnzkWwfU+4/Xw0fQYc6Kthl2/+h+53/STuE
	 k75N0MkrCe1ubqdyUxlu3gC1GGHYnJG3su8JMrFRZSXyoaOzzlaXxksGwKmR8ZdrsOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCDSYkQ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326C606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCDSYkQ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB11F0089F;
	Tue, 10 Nov 2026 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332605;
	bh=qm6tj3QCfDAO0LbV2Q6CXcZimBSmTc/mXZiqrA6fLX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCDSYkQ3JufyrLinyJnYEn2VH8xcTyaPGb52bwu5qw3UmWGOl0cHuKyz5yjtBi8U/
	 5WIiAwEL8pl74iy341PZyK9pApjBZ1kghUNHebPn9K/LVITG5+yU/NVjPcjG2fk0i3
	 quWI8YNuSMe19xj02fu8pIechIXtB3thmHheQHaM7OSPjeZgfdxtviAlbj7hm+hErW
	 91ByvXMX9BvvS2GHMaaevOMJff328VKM+iPWWV0WwhDyu9Z8/SwNJlmeymi+M6SXfp
	 IBDt8qu3Sld2LH/UOjE5cMJPIf3rne97V+HSwxVxMi+WoFk/vPYatRgFZYnIQ6ojWI
	 rV8ONzsRezS0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] intel_idle: Use 2-argument strscpy()
Date: Tue, 10 Nov 2026 12:43:22 -0500
Message-ID: <20261110174312.2985582-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050546-failed-7.3-403524796685@kernel.org>
References: <20261107050546-failed-7.3-403524796685@kernel.org>
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

From: Andy Shevchenko <andy.shevchenko@gmail.com>

[ Upstream commit 2094ae12eed8e83dd91a631ac0a582fee5934c36 ]

Use 2-argument strscpy(), which is not only shorter but also provides
an additional check that destination buffer is an array.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260813082624.2650581-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 403524796685 ("intel_idle: Adjust state names and descriptions for _LPI states")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 651408df9c24a..c5b65f7d7271c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1906,7 +1906,7 @@ static void __init intel_idle_init_cstates_acpi_lpi(struct cpuidle_driver *drv)
 		state = &drv->states[drv->state_count++];
 
 		scnprintf(state->name, CPUIDLE_NAME_LEN, "C%d_LPI", index + 1);
-		strscpy(state->desc, lpi_state->desc, CPUIDLE_DESC_LEN);
+		strscpy(state->desc, lpi_state->desc);
 		state->exit_latency = lpi_state->wake_latency;
 		state->target_residency = lpi_state->min_residency;
 		state->flags = MWAIT2flg(lpi_state->address);
@@ -1956,7 +1956,7 @@ static void __init intel_idle_init_cstates_acpi_cst(struct cpuidle_driver *drv)
 		state = &drv->states[drv->state_count++];
 
 		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d_ACPI", cstate);
-		strscpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
+		strscpy(state->desc, cx->desc);
 		state->exit_latency = cx->latency;
 		/*
 		 * For C1-type C-states use the same number for both the exit
-- 
2.53.0


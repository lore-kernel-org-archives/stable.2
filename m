Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087935;
	b=qITRR3esj7mL8WKcsWYqawsYS17w1CZQqhEyViZCxbiELBA8ooJ1Pb4IqAZqNwnJeNr1
	 zas9x54i/+0coS51dAxOif8ffcHwUci0QCSNXa0lzUDtWfrtHKSPE6XqtTNxI+neLNoBi
	 gMwr26Op83QREDogyRKqxY10lBzi6V196Cj8ABlzcPscVRYQHnDz6HOs5ZciDTo99i/LU
	 Bl4yDCeaekXNtZgU/xOc7Gk04QKtoeRE6NR3Lf4nKltmufF0EE28GxYYsyXrYpjLlwUqW
	 cdu86kmljGYNirgb255RFjegc7KUXHRVqEDqXJCzYjj8PNB2I5JZYZmKkjz/7wngL2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FY7qwVWBZaVu0fZDA6G5pfiPoOpiQaFFaAvwMZq9K8Y=;
	b=DNw1A8HyoGFM7s/i7DS5jBd90CN/UojFfaQ3NlQpLo+5QvP4h9nYPESKQIVjGzAOXe/M
	 oPDS2lMbKZ0vKinE+Jpfj8wHTkGZ+I3XUPnXiGVXEatwgMBD0bvgA/pYMQRQyOPMyevWB
	 DlfFSVKuD+DAYSSexJWeNVXM/Hto2TdDVfoGjTfZvh6fG2r8/OKbpHulurjL9UAN8S3Nd
	 Q4Fp2ZLd25hOnkPeQ6kVWQksLzGx0PdbmHPwy4NTCd0ui5PjsMNFfEPQYp0wbGC2F048c
	 ZkTilkZRVPFHyenFKmAzucyecl1naka6z9g5R3LOF1GCTPw33XwoVSYCx3NCBbc1P2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4c9ftAQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C94606A326;
	Sat,  7 Nov 2026 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4c9ftAQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5FC1F0089F;
	Sat,  7 Nov 2026 21:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794087934;
	bh=FY7qwVWBZaVu0fZDA6G5pfiPoOpiQaFFaAvwMZq9K8Y=;
	h=From:To:Cc:Subject:Date;
	b=G4c9ftAQlcZVnIcqMjz+xNKtNkGQzTDKz0PKeR/caHowjELL6QFJ8bjRvDrpXllPN
	 ngix5yUxQ9UvJiLOq+vXuFQ+52RBJGrgoAoWq44ZdEv2AtWdl3wjbuPsFG5xX/TXh3
	 GPouKTSkyjhrAc3ZnGu5dji8yydj3Lb7PbSgGb0ars+wlhQL8POcPngAXEPova7I6C
	 GTRhmtii2jl2h0ua+LnUuHtNuyw9XuYBTExJZjxStUmJN3yDLKZMtwSVeUShY/yM8R
	 uQw3w18qEOOeYV6S4Xz2+6LBYGVEbMkpip5WhEDWTrFNwM60AIOAzIOqO3/4T14wui
	 RDomJEREViHDw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.12.y 0/5] mm/damon: porting fixes that cherry-pick failed on 2026-11-07
Date: Sat,  7 Nov 2026 13:45:19 -0800
Message-ID: <20261107214525.304638-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Manually port five DAMON fixes that cherry-pick failed [1-5] and turned
out to really need to be picked.  Note that seven patches [6-12] that
also failed in the same day were having wrong Cc:stable@ tags, so
ignored.

Patches that this series is porting.

[1] https://lore.kernel.org/20261107051942-failed-6.12-90c2fa6adfed@kernel.org
[2] https://lore.kernel.org/20261107051944-failed-6.12-1613ac9edf38@kernel.org
[3] https://lore.kernel.org/20261107051946-failed-6.12-29c6084658af@kernel.org
[4] https://lore.kernel.org/20261107052624-failed-6.12-bbeec2d8324d@kernel.org
[5] https://lore.kernel.org/20261107052626-failed-6.12-5695abc4e742@kernel.org

Patches that also cherry-pick failed but deliverately ignored.

[6] https://lore.kernel.org/20261107051949-failed-6.12-df7d9a0f8d91@kernel.org
[7] https://lore.kernel.org/20261107052123-failed-6.12-6f276422aded@kernel.org
[8] https://lore.kernel.org/20261107052125-failed-6.12-a1c7fdaf1657@kernel.org
[9] https://lore.kernel.org/20261107052128-failed-6.12-1bfb9384ae0e@kernel.org
[10] https://lore.kernel.org/20261107052130-failed-6.12-cec08aad3def@kernel.org
[11] https://lore.kernel.org/20261107052132-failed-6.12-409d2ab6d982@kernel.org
[12] https://lore.kernel.org/20261107052135-failed-6.12-1d2397b2c414@kernel.org

SJ Park (5):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/paddr: respect folio end for DAMOS actions except STAT
  mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
  mm/damon/core: filter out damos address filter-split failed region
  mm/damon/core: remove unreachable damos charge_{target,addr}_from

 mm/damon/core.c             | 59 ++++++++++++++++++++++++++++++-------
 mm/damon/paddr.c            |  6 ++--
 mm/damon/tests/core-kunit.h | 11 +++----
 3 files changed, 58 insertions(+), 18 deletions(-)


base-commit: 76e5c9c4cde792b3376e382e973c8ce7b978496a
-- 
2.47.3

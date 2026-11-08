Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168908;
	b=KlWq30VTd/nI6JoExujPRXHlwm279p+5d8EVyNQU28g55Wi74wQSQItZI5ADsx6d6gYN
	 FDn4eMEjcSPoF4lQva417SCgmZqZkkQ4cPfH7qCmTeFDWVOBuxEK/Xcgw++wQD03JV2GP
	 Y+ot87KYNRi0yMXzVAYBytfQEQxVVihXT/4mtTyyDpPLM1v2tNUgjYc5aKCm/ZhRgDjJK
	 qX5ZLnS3S1EHSHdqP/NYWR5hkg6ur5L6hDiOLoJ5yNRktHxWOu/iEkarXxbvs26/LjAQA
	 Eeg26qpKRBW2JhIapmQfiYlgcCVrjLQ61yUofBiMn9T6f501PRTKaA52Pu6KxwIHdjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P75XztLr5IL9Ot3tsv1xaB+BM49nfqPilwdmFEEROM0=;
	b=dLTI8GrMg7I5NnHJQf+LrUvVw95WtqzFFvjqh3VrL96WuzC4aUmoHsDNy9Micp6Z7Mr5
	 EWXl9n/0IqAQLRf/YxtyP7S6OFFTeJTf9dNrZH4G6rgzdmKvjreyVBcuBLtrQMd7iASzP
	 UsGwOWcePqsB/NliEnP116IfruvlRTvf7H58Y/tziyRAnEZG7h2VfvSptJGbnrP0BVPrU
	 U0h1vCPYIS9cWDCQv6HR520R2WWekN21DhfK672iEoiJLUCLQged20pK56VOoJBK/wKzL
	 L0Jtsy0E1ebvuBEIS4JDEFfL3u/1OuG5c8g/iLRdzPi6EIAApmaTIiz62Z6SXa9YCzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6fD9mCr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E5606A321;
	Sun,  8 Nov 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6fD9mCr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD22F1F0089F;
	Sun,  8 Nov 2026 20:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168908;
	bh=P75XztLr5IL9Ot3tsv1xaB+BM49nfqPilwdmFEEROM0=;
	h=From:To:Cc:Subject:Date;
	b=l6fD9mCrsJ5XYRkRAQHVZUO1675trAEW+KF3H1cCmc/LSK+grgE06c2UvConlo0Wj
	 Bdmd08hoePlpA/3hGQlSCCE6oZU7Y9vklQl7VX8p6Z90KdeW/GL0BDRBdXMAb5+J9v
	 siNuw8mhtAp81z3UMeXPDTYS6puGmIHtx93+rVEd99ITuiIKuE6/S1x/Mmq+G8WujM
	 K69WMhyBq18HVmTxaQWxc4Ly/h6IP8KKdqh1EtNbLSYI74pEfgPKrLCa/bfOvBeOY4
	 /y/PmQni3lqEhg4foZJJ/RqiJrdsImciUta62n2xWNO7Gx96kpakRUH0myv1Dm7bMk
	 3ImyhU2ClPk9Q==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y 0/3] mm/damon: porting fixes that cherry-pick failed on 2026-11-07
Date: Sun,  8 Nov 2026 12:14:52 -0800
Message-ID: <20261108201456.116824-1-sj@kernel.org>
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

Manually port three DAMON fixes that cherry-pick failed [1-3] and turned
out to really need to be picked.  Note that seven patches [4-10] that
also failed in the same day were having wrong Cc:stable@ tags, so
ignored.

Patches that this series is porting.

[1] https://lore.kernel.org/20261107053211-failed-6.6-90c2fa6adfed@kernel.org
[2] https://lore.kernel.org/20261107053907-failed-6.6-bbeec2d8324d@kernel.org
[3] https://lore.kernel.org/20261107053915-failed-6.6-5695abc4e742@kernel.org

Patches that also cherry-pick failed but deliverately ignored.

[4] https://lore.kernel.org/20261107053348-failed-6.6-6f276422aded@kernel.org
[5] https://lore.kernel.org/20261107053350-failed-6.6-cec08aad3def@kernel.org
[6] https://lore.kernel.org/20261107053353-failed-6.6-409d2ab6d982@kernel.org
[7] https://lore.kernel.org/20261107053355-failed-6.6-1bfb9384ae0e@kernel.org
[8] https://lore.kernel.org/20261107053357-failed-6.6-a1c7fdaf1657@kernel.org
[9] https://lore.kernel.org/20261107053400-failed-6.6-1d2397b2c414@kernel.org
[10] https://lore.kernel.org/20261107053402-failed-6.6-1c3352282063@kernel.org

Changes from RFC
- RFC: https://lore.kernel.org/20261107222202.331476-1-sj@kernel.org
- None.

SJ Park (3):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/core: filter out damos address filter-split failed region
  mm/damon/core: remove unreachable damos charge_{target,addr}_from

 mm/damon/core-test.h | 11 +++++-----
 mm/damon/core.c      | 48 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 13 deletions(-)


base-commit: 9990534f18e75bebba6b6a557012d1253980de9e
-- 
2.47.3

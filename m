Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293F44CAFC;
	Tue, 14 Jul 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037688; cv=none; b=cKEWNJtLjwBYm5WPbfvG7qOaUZecfUCNYWv55UH23lmIDV9jakcMTWorq7ZICVLCDCYdQwjKNJgHCosnvUNROnL77y1D0VDb0uy5YBMLIn0qVT5X8efNtoRarCNfH0QAWddBHneQ6XFF5nX8Hq0EhxH2OA2Tqx8458w+sma3sBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037688; c=relaxed/simple;
	bh=d0V2rb/osngXT8gHWvu1/UCcS5rQAWXYd/aLH1oV/Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crs+phpSuateI9kS/1R5abWBkM/xsYTLkQDlrhG1tQNqabVZiM7t6h+IRJofKome9i88x8Xw8XUz73KCFloyFLdd2D80pv1eoGT3iyaXnpdBgc2abfx8fX9+GtRZypqtc9TSg6UsZOtXA2f4bFzfNB52s90MfbLPDmuPOd07i9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+JcNMVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+JcNMVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272E41F000E9;
	Tue, 14 Jul 2026 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037686;
	bh=QRQ/R6IhyCOalIrS8ASQJa7G5ZabRey9LTdrVciopCs=;
	h=From:To:Cc:Subject:Date;
	b=M+JcNMVV9CDgT0gPBIPVPQSA27IJL/gRBnZAOPTX1WydwcRhmGm7WHkJ+0D2Da0Kb
	 VsFEwHsYZBFvPHqSiZwuu5jB3yxU3xf0i88j8ksfrRuxJJcdSEQ2YnqNfLZGEYwsli
	 wxb6yIDiox1plPbqZwCpcUmzzxSksbVCCQfRkG83JP0ME+ys8v5Lqxy4si2ws1L+sF
	 rDpjKU3XhM5bR5kp+XGi8OQNWTsNdMoRzvrXKVo4dGgPKqp+hX97+wl3G2ZcMYM1lb
	 0u8cVMT42gYYMQHLstUqNdW4T61VCoZ+Jr8BJvRSJmB1paB7OdGnxqbV1KVe4ekiFK
	 xGhcU/6ZOQVMg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] Docs/ABI/damon: sysfs ABI document fixes and additions
Date: Tue, 14 Jul 2026 07:01:12 -0700
Message-ID: <20260714140117.94147-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes typos and fills in missing entries in the DAMON
sysfs ABI document (Documentation/ABI/testing/sysfs-kernel-mm-damon).

Patch 1 fixes a path typo, "intrvals_goal" -> "intervals_goal", in
four What: entries; the documented path points to a non-existent
directory, so it is Cc'ed to stable.

Patch 2 fixes two further typos ("WDate:", "manimum").

Patches 3 and 4 add ABI entries that exist in the kernel and are
already described in usage.rst but are missing from the canonical ABI
document: the 'update_tuned_intervals' state command (patch 3) and the
'tried_regions/<R>/probes/<P>/hits' file (patch 4).

Changes from v1
- v1: https://lore.kernel.org/20260710044737.561102-1-husong@kylinos.cn
- Rebase to latest mm-new.

Song Hu (4):
  Docs/ABI/damon: fix typo in intervals_goal sysfs path
  Docs/ABI/damon: fix typos
  Docs/ABI/damon: document update_tuned_intervals state command
  Docs/ABI/damon: document tried_regions probe hits

 .../ABI/testing/sysfs-kernel-mm-damon         | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)


base-commit: 4c3e511167ba60f3934a530fa5675143a09eb909
-- 
2.47.3

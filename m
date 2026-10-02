Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61023D7F4;
	Fri,  2 Oct 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950810; cv=none; b=FRIIXPwedpRi1OokuYNye0zPFR7r0weFnDzE7WRLicnFicMaDx/LkNTQ4hqZA28q04atzPNTgWOV2vX8bSfVSJQygIX5XBN2dO6sduvlO/g58ePJxv/ZrCd1N0tfgjFSl2KKlVx1h2ZveapNcfiJ08eF8hKOhcN8TwL+5ibTDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950810; c=relaxed/simple;
	bh=Qjs//hyhzltZ2/SN/i3nl9EgEgC43TBUpBICUm7V2F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYlJskOKv3see5NYZRRKwBRiQu9xRJMZDzO42NprDGD48FfRmzHLvw1FWU1WRjTdJKiFcV8rtGyyXdewqfFhwLwF9JM6+ReLN/uxSyl/PDcmlJFIeuzO9TmkcvRJ/KuBFa0gXNCnjjGa49z18gFAdv6oFQ6foYLTwqyLbyL1RX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eASxa3cA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eASxa3cA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03A21F00893;
	Fri,  2 Oct 2026 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950808;
	bh=mNva0dZ+Y7yZHNv1JAHhXIkUHu7JycdybK6trLwdS9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eASxa3cAfHazHMoBvaaabN6IZ4d4+69FZ/3JnGlpx2vA+4cweLRyK7xdYvyeeShbE
	 YPbJjUoDGeMmV9p6laHmBPOblasPNea7u7yHXP9UwByAP4hzZY1rsuntvKzc9aD9dF
	 R091cWK70jQwPfqFAuPooGQiXokSnMe4+Yxl1IYYtDVyu+arOxwJebZhWddNhi8w6c
	 2iCfdePMEqjMt4fll8F8hEm0jFm8ssHJi34szAVLM/Zmcg6Eg10DtPY9HBN/zqasw2
	 msxvmk+W5RFMwyKN99POHkOKz5zxjVxrEHBc85VniLVEFXGH1gAivdbJ05Y7nqm0zk
	 O/PN9DLTsBNiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rppt@kernel.org,
	sayalip@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v6.18.y v3] selftests/mm: hugetlb-mremap: add setup of HugeTLB pages
Date: Fri,  2 Oct 2026 10:19:52 -0400
Message-ID: <2026-10-01-1-daily-reply-0008-re-hugetlb-mremap-setup-v3-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001181330.684841-1-luizcap@redhat.com>
References: <20261001181330.684841-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport-notes: this is a partial backport containing only the aligning
> of 'length' to the hugepage size.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96EE4B95C6;
	Fri,  2 Oct 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950810; cv=none; b=jYfVzJEqfDSIgemmbZ20f7SrB2i5XaUdlKY9pvULMepKD4lnuazUainHZIieScSLIOQqCYu4fZ51NSF/+7EqBE6/52y/3uORKDuFfxqWFhbHpE1N/SAHoWRTPmPN3Avz6Ed72b/inFIwLc3oRIaNrRkaLsNQUZ+NbTx/MW8hqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950810; c=relaxed/simple;
	bh=LTBxfgXffPX0gDTO8jyz2BifcBHdk9iEU78cOzTDdzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFvct6wLJ86g1EmFoKBwRgPVr2B3uvOUbuqlp8QekCpFL2KygxlozDVjK0Goaykv9ihUjGl1R+9mou9vvf/u40AXL4G4YRmnQmO5MKjkQts9BqF1tgJzFemyDHvHRKvui+g/yaMbSzT73N8veryqkg/bmdn18rXrjXZdXq8nIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtXJYox5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtXJYox5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CBB1F000FF;
	Fri,  2 Oct 2026 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950809;
	bh=/3Dre78GSTEJXqtMWvqAY3FH4G63L3kygArBXnvuUPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtXJYox5qqmy9W1ieadaB1RknAHgKwLmUCQ2sU5IOTM0YTPX50/Kma3TubfRF4VL8
	 I9y+TV8XHnaJj68Eh2mR9qwH4qXYAtHsRxXL/bfG475YeFUACLwV4UO0yvfwREgcI3
	 WyT17IS1etjXfrw6wbpUqvrfHO9thznCTLAbCidrHDb7bPIMQC2vCLDeb6UjMIVcgP
	 IYBNvv359VvgWL6n0haIO4l3RduoyA1UBW5MvF42IyEdtcb2PbmI0eNH7ior/4lqkA
	 RfmFzFM+cpZdu9YvwuueP/vApR1uAPzLcPXt4gbPJD3sb3QfRwTukK1uFhSMa8vm8x
	 aRWqyDCEVo8nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rppt@kernel.org,
	sayalip@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v6.12.y v2] selftests/mm: hugetlb-mremap: add setup of HugeTLB pages
Date: Fri,  2 Oct 2026 10:19:53 -0400
Message-ID: <2026-10-01-1-daily-reply-0009-re-hugetlb-mremap-setup-v2-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001181518.685129-1-luizcap@redhat.com>
References: <20261001181518.685129-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport-notes: this is a partial backport containing only the aligning
> of 'length' to the hugepage size.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

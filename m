Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DC3CCA19
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701611; cv=none; b=b0Ll3dyOwSUiRxgPRdL69QjtdantNrnXlTbjvJe9SLNyFpaQ5axcUic7KNSARSyuYcw7FpCS06qXXLSl5Kj94swJw1oXHyPZ5tV2ozcNesEQUO5hs2BrzsWnYOk68z71z8B23tfo0l9Szo646t3E8ELlxr0ANsVNytHEkBpBils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701611; c=relaxed/simple;
	bh=KJ0R8gJmd2uL3giWY8LxHXVa5fNsqkp6NaAnmQPOI1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0hcAyFc76HkNVHnrjmyWphauVF2SSL4jaU3hAlTTIAF5a0wchdkoYfBF9uoheTL2b3I9zb/oXP4oOEDX8Vn3z5bMrX2275jRG92KFQl6QWinUSNruWzTTx/RwXUrKbg17dlpBB05IT9SElBl3mb2JD6IAsSC9kjw0Nc34Z3cN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdJNa99y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdJNa99y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB961F00A3F;
	Sun,  6 Sep 2026 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701609;
	bh=8T4k/SdalWIlcg3C734UeZpgeZ0OrdKgOL1FlsYTFI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EdJNa99yUJnT1ZVo+zLpmM9ZMebEFB2TmOAnoXumZPSQEs9oW7ZYkuilldaI/uaEx
	 Or9SCd1wi2MBGcTl6LUXPJNO6u8oQehJHQp870Tbl7Rzi6rwHkjpxcGcSBEGw0haiD
	 7r6s3x0J6a7pcw5jchi3/fin9L+Xw0mJg3fSYHTbmbalTwvJewyUtItCjhMugPhMll
	 9MaB94TEA7sen1k6oOKrN3T5MZUd4/xtD7/9YjJVxH1LtV8+PCG64p7ri5f6EeS3EU
	 mLxIc42l1TA2K6ZlOJx7KM3AfBDIyJ6jnILzO0QMwjGqN8stLXi/Npj39JGnIy2c5P
	 u9QiiAC4TVtCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.18.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Sun,  6 Sep 2026 09:32:35 -0400
Message-ID: <2026-09-05-daily-reply-0005-skb-zerocopy-source-skb-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904085941.1806194-1-i.maximets@ovn.org>
References: <20260904085941.1806194-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> skb_zerocopy() copies frags from @from into @to. On an
> skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
> operation on the source skb the copy helper does not own. That completes
> @from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
> SKBFL_SHARED_FRAG page-ownership marker.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

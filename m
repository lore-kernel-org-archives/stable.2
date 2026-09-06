Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF53009CB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701611; cv=none; b=d6J3BFyTQtqB/vneEMCvXdUTfSVQEghNNd8FT6sIJ/cPkFQdbXBHyorqxmRBwKz3sQG2VRQAHnjiyHOxuLHbU5rpodKfJIM6kvunQM7loEXziTws9PW9FkMmnyHPYMWCUFpCZUtcMZCiAATIHCgGpIYWYFCIZt5InNKCLpgJfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701611; c=relaxed/simple;
	bh=eU4W7WCOFj6ycq7opEX7fYg7LKH8vtYmp/SgERmQzhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seWgNrnwlRqK4gqUcsEZEQ+q+HdoomPaB8P6GF62U6qvfGBaAQ8Bu+Aip3etY0Q0vDupfmlaWXAFS9hF+eZjxrAptdYjETzXHOFGnoK/f5KUK83b2s3EgD+y+W+n/1KSqyqbj8ktxU1laBJUz5FwA0lDfpii0V7YtDzZKeO2MpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUkSVFIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUkSVFIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8131F00A3A;
	Sun,  6 Sep 2026 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701609;
	bh=F50kPVolPvF9ouauspXLq5A8J9MgYqbE2ew6dsDfo3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dUkSVFIhrMxJPyk5yHBklx6qo6qOn5otTP9ncYM/Ukz4wbNp/ZUKT9Fm0vEafdL4A
	 Xi9KYy+52JTXQB6TLwwqMWyOw3lQulb81d0w6Xl/Iikqlj61+1hwSAz08FCxR+cDI0
	 +QOavpZX0HIsersQH2Mnui/S5K1rBl9oxsFEF+yz3Jdnl1oZVvAjmriCfIpmF3HcjO
	 TudPXa/hNt2NmxPo2DWyJSaSUdZ6GNKUe8LDYtoaFUSD0jpQEn8UYsMxaTQv8ebsyS
	 VHMqXf6UfhlbObQh//g+cmQTOK/pIMGTu634atJujIBzM+Q3wZJbLAJg+wsxyQK6bA
	 5ThYTK7+UHQWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 7.2.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Sun,  6 Sep 2026 09:32:34 -0400
Message-ID: <2026-09-05-daily-reply-0004-skb-zerocopy-source-skb-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904085746.1805525-1-i.maximets@ovn.org>
References: <20260904085746.1805525-1-i.maximets@ovn.org>
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

Queued for 7.2, thanks.

-- 
Thanks,
Sasha

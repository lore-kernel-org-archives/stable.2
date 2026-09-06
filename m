Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB763603D3
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701615; cv=none; b=nuzMwoQmWYLYunQLFMXDLAJGUAtdHs3xvVSDtDBNWNthBEPCrwNRveAqaT3lHow1VSdQXHCSYSzEe5tiIdcbHap7qVQCEh7icZo50pki2TC2RwbM8Ncsmp/5sktd7Y705cjh/2RYG6Vb/yxxWDIVBBj3qpO0TPlnad9lfXhDuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701615; c=relaxed/simple;
	bh=JQxqttBigp+he+7b6NTlfEELbNQppEufchEX6jCwd6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJPiCPq/fG42qgORFLaqhzq2+IJruZgOF18K7j66uen4+K3q3HRBE1+hDbRCZz3J2d+55vF7OYt80Ia/0S5/7w1gfMO4totOhTu7dqI5BHje29sTiJanFz6B4cohQfJTfdGPQ8WCGBYa/OL9vgKPBnDaDk1HrAN9aUHgqVyatBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIFkOfMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIFkOfMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4911F00A3A;
	Sun,  6 Sep 2026 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701612;
	bh=NKiIFTrGabndRIsSKbcVlkHqu8/brYTlQUS7WedaXAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIFkOfMcHkNAio5ZWbw0dPD7tpd9dbEVnENtz3wVMlu5aCvYwV95NrROdKY7FHAxl
	 zKYoxiUOGbXmsLFetXuJajCSikQLYBdzRS6vH/OfyTR3urNM8TW5JE1PQNo2Qn6h/z
	 AQasZas+dbPGumkn4IxbO8plge/k+r4U6y0LhxE5qYYimP8eUV6VqSfzEVnWdgq27s
	 75Xwuk8Ot7gnLWPbjv39a+a+RG6S8tZZ3qnfN0MljsWXnR5rLflC8UoGFdaYaBoij9
	 0i6WDoxh37JBdHGTD4ISNqiofPD++1l3Hbnf95ANoupyLgyKnEo56Q/L8lwnvYqq8c
	 L0TGKMeMuPCXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Sun,  6 Sep 2026 09:32:38 -0400
Message-ID: <2026-09-05-daily-reply-0008-skb-zerocopy-source-skb-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904090529.1808224-1-i.maximets@ovn.org>
References: <20260904090529.1808224-1-i.maximets@ovn.org>
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

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

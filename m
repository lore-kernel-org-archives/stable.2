Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3513CF962
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701613; cv=none; b=LbC/hCd582+bs9V+YIsbF2d4KLV5mcMzpf4EMviQ8M+WbjEi9aGKg5x67ft83MRyystFBIXtrPj3PCfCB2KUXqY4ZjBioaorkWRQyJxC/y5oPlcRzdyfY+E9rOKaV2N1nayzWVpz7fx7BMVtTWKSv5bw5TgnmO8OeF/zZEKz0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701613; c=relaxed/simple;
	bh=66+9LW35NCVkDvc0BDXRiQBcprhQAd2qkxAPeqzSlps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt4I55MNA8PzK7JUTs8cVhKtuUDYhudFnPFen0deNqR4ZYe2IU+S08QfqKumFjU0VIkpXZjRGuf0SzpKm/CsOdP3vbkgeTknPlz3gV9x/sOiYa8VW7dF8hqdO9y5/wYMHEgO7SV7m8ItvK19jiFdPDlaHY/EvfgkUdDn9zfVwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfsY+JkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfsY+JkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2339B1F00A3E;
	Sun,  6 Sep 2026 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701611;
	bh=6KMg57nl7vxkfMjZcJlLrhnj1ObOUT37xaOUQsv3kQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MfsY+JkGqbYOWzmAuW0aDwKUVpNAcb7vJiTNlnn/778IvXKUp5oiiI/fqqlMt2Fbi
	 +EFbpPmukeyP/Cpu8oYd+ZWjpEYrqqfNIEQqLqyjWjNr/pzS1G8r3PD77Kqwycmx+y
	 g8YEQfe9hYxCWoW3L1j/rrXbgDbJsaosOzRAg8eh4AGCPmpIBFf1Zy72AQYWuY7qJg
	 ykJiWCYznEvzT6rsUq+W9+L1ffGIFz9t0FFSuAZLjSFelFkX6WD9AhI7R6q+qh3FzS
	 ngOj2X62CV2tKzrV76VTMYImyAqJsb/tRLW37THsUSSMpWD4Av0kelaDbZHzu8IWSd
	 JFWYyN0z8xKqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6.y] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
Date: Sun,  6 Sep 2026 09:32:37 -0400
Message-ID: <2026-09-05-daily-reply-0007-skb-zerocopy-source-skb-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904090356.1807583-1-i.maximets@ovn.org>
References: <20260904090356.1807583-1-i.maximets@ovn.org>
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

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

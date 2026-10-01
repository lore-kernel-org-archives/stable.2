Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134F318EC5;
	Thu,  1 Oct 2026 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861016; cv=none; b=l6gqcfwlGL6L48aXnh6ew3YKLYJhdh0kxq3l2DYte6e1kDUnto3BT4YToat6eCi6meL+AZNHO0q60lr29VKx60+9ouvow4WtZ24T2erI9fezQDtbedaFmtRRxbMgZvbe+RzeFw3E3U7BMz5huc7yWI+3ZpFcqbOQD3BS+ZkqWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861016; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=raivRcametrNPEfThIaJw9YOiX8JbFbTo1JkEnoEwYjaIzDzSsad0Jvc6os+P7DqrNiflbtAI9hiPG/gZmXwL1GBZDLQjX1x8aI8EnCTyfk5lA17B4TJVYc4TEvrJxmkyOwXU/iYcSfh6rw5vPy6zOJDm9KzUg9bbwlCqHkaOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtK1U6tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtK1U6tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CBF1F00898;
	Thu,  1 Oct 2026 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790861015;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CtK1U6tjipayBbhRqxMgCOx6DgloCpvFJGooNT5Isle/1fwyo9kd1/OmaD8WPqGlc
	 DJkrQkqcEPg4EzcxruWMhFiSOCYbIVZiHiD/s8dqhzDmjED7OrJbLjwAoL9ZIOf7at
	 DgG2ycro1euKXPF/V0diWX1KCgTVlzCuLiw083INBB4pe2I3duAe8EWaQju6VYeIQ4
	 VCuiSuR384SK30Y3XHE6E+Bvsj0zYifboDqMJyb2qeH11Cz4KOM8dbvBvKQysWZ7qb
	 NeNP1W6xrzZFdyQCesKb57XGnLOjs7bpBYZ2IzthadZTnACdXOpO6c7Rr3pv3epiXf
	 f++3qFiqGd+Fg==
From: netdev-bot+sinfo@kernel.org
To: Artem Novikov <naa@amicon.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, lvc-project@linuxtesting.org, rrv@amicon.ru,
 pchelkin@ispras.ru, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10] vxlan: Fix potential null-ptr-deref in
 vxlan_gro_prepare_receive().
Date: Thu, 01 Oct 2026 13:23:34 +0000
Message-ID: <179086101460.31693.11225223420004934540@kernel.org>
In-Reply-To: <20261001132038.21173-1-naa@amicon.ru>
References: <20261001132038.21173-1-naa@amicon.ru>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

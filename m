Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1331355C;
	Mon,  5 Oct 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208855; cv=none; b=LO6Q8OlFyDYQ5z8+MB+ZnVX7RrmO+3Lyfh4GTeftWnAzXgnC6FXotcs2/JFZbVBkh+P6fCK35r0ECVZ1qa5DBkoUHIUqVprsH7Eg/iNYloh3Le/3mTvuV1FfPA9VKuVatTLR56JQM2ZENVaLg2OSbK/NbDJLrvOndiSZX3y5l98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208855; c=relaxed/simple;
	bh=RIuMMFcZLY9wzddjkZV5cSo6aph28YmRGJhH7GDAT+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL9euO6MNUsE3DbtMurybRNticGQZ/2OOi/2F6z4GXoUL99hyQj7WqYH5exiI9o2s2bxwgmD6zEgY75fs+rBGxgoVlaPkBVUXNgaqZFtgY7u5C1P85Wgmik/t18AYC/BhU/lN016H45chvX6J3Ld9H8dfg39C6d1JtqAE4H8XBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAAmNTKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAAmNTKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126B11F000FF;
	Mon,  5 Oct 2026 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208849;
	bh=NK8IgM6qDsaqMaelGby/WPyf/ApioUZd84f15x8UU2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YAAmNTKPeUqS+aurOI43UPNDp8ghqvtzPtAY8vUUhiqQcwyeeKdvAs0jWk2Y9mTDp
	 g4bGUlphDEb17ceOpOJ/1HqHA6R12ZtlGXDuKyQoTU8AwbQjSsIYZ9VpLduzUItvf8
	 6m5rmggtJ3ptUjVuPJjpsjW/7CrRDge40qU6aJ2WYaHHWrGR3jhVjDfCJLtI2BlNQb
	 aMku9dARmTHhJQkC274PFN047XekwQTMP63VleT2eqmsjtWAozf4OsY2y3D5gDu7HM
	 ZA/lL2GT4r1OrVHL5bCbmyI69kVLRHH67HvTjXvfWf32GJyUPzd6gQCMSE1ziM1krp
	 NESXC2AaN55Bg==
Date: Mon, 5 Oct 2026 10:00:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>,
	stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	John Fastabend <john.r.fastabend@intel.com>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: netdev LLM review for backports (WAS: [PATCH 5.10.y] net: sched:
 cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode)
Message-ID: <asOtjgd0NMXMjCCZ@laps>
References: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
 <179119639380.1402591.2155637888002963@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179119639380.1402591.2155637888002963@kernel.org>

On Mon, Oct 05, 2026 at 10:33:13AM +0000, netdev-bot+sinfo@kernel.org wrote:
>Hi!
>
>This is an automated message. This series looks like a fix, but its
>commit messages seem to be missing some information:
>
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.
>
> - Whether the issue was actually triggered, or is only theoretical
>   (e.g. found by code inspection). If it was triggered please include
>   the symptoms, like the stack trace or error messages.
>
>Please do not repost the series just to address the above. Instead,
>reply to this email with the missing information, so that reviewers
>can take it into account. If the series needs another revision for
>other reasons, please include the information in the commit messages
>then.
>
>The evaluation is done by an LLM so it may be wrong, if you think
>that is the case please reply and explain.

Hello,

I started seeing these reviews on proposed backports of net/ commits, and while
they are REALLY great for upstream commits, I do not think that these comments
make sense in the context of a backport.

-- 
Thanks,
Sasha

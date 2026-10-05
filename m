Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E343515FA;
	Mon,  5 Oct 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228037; cv=none; b=hV0hA3QAH1c7MYFb29b3O+3dyLh4r/07VXXvGksiSokUNg6L2nfVf7PMppEpUuN8A4i1oN0H7fFnqwNz7383VifciKubZ3Y+k+nuVTQ5hFsHMEDJRVH6V4hRU1jznre4c3QSe17O5PWKSxtSAsf0S/idzbH4xSenOwqhZTiawCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228037; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kg5qwNDcGSxSYfBMGX1jN9cOo2htIJZ90rHgR71YZekg/VwyWroN+VTnYRX0twEBMR+zRN/ASsM3Ie2bnSuivLATHShaHBCP6Dep9GmJp1ZnvLpV+o8OjL+kBzprsXpvczzTZhsdQt+EBWMXabTmnimS+R8Lo+XPNBotk8pydbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcOB74ww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcOB74ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287391F000FF;
	Mon,  5 Oct 2026 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791228035;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZcOB74wwbPJcPjJlVeRpUGrWG9CO71O+Prnolp/E9RFX87VQvkCkj6v0eHHJGMSdq
	 FCHq3sr0En5cf824BqinXCYbzEanYj+fTCYAVjBXXAA8xqMhfPzGVgO3FXpIW8IUR8
	 feCDFOXM2RiPw7npEMzpraBoyHTiYOiSVIB4RUSqqrmybdhipugRROlm+NNW52k8PX
	 gPSS25+0Ijiaeg5zKywisOQy8wTWhmMEY5BXNs/eigPdU2xRfMre9B9Ce5an6T6sK5
	 /G0SSVcuRM8oe2WzYIrw5Rag1tYp6EK6O8PXbdmIGkfUOQK9ZmUlmd/M1jEskFWzOq
	 bzPxTKpGeqy5g==
From: netdev-bot+sinfo@kernel.org
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 William Tu <u9012063@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] ip6_gre: let collect_md ip6gretap send from the
 unspecified address
Date: Mon, 05 Oct 2026 19:20:34 +0000
Message-ID: <179122803467.1402591.12893544301783319251@kernel.org>
In-Reply-To: <20261005191227.894665-1-littlesmilingcloud@gmail.com>
References: <20261005191227.894665-1-littlesmilingcloud@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

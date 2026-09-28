Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E203CF047;
	Mon, 28 Sep 2026 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622358; cv=none; b=Ty3e5ZSEI1eU6BMl5+hT8LuCcGZ/TQoJpJwyILXcPOy+f6urZQLp7VQCEH9R7FTgtbTYQn2mcH1G9DE3CvAd5r8R7Xky0pp+6EgG+Bj1wn3FiegfHOOBV3P/kS9hhT1fYdBMApyf/xJNzvmiw4+CAyyRJ9qkNQjNR2g1kxkT73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622358; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqPNxxNY68MhsCiBhfZbyqea0MwMyi3h12YBzf1tkwJ6OuPPxDamwhQEFKh8cFYNbz4i2OaCNbFAL6qZILKJo0hXDZrCnO4TEVGbTm59cMnWVAZGhgMvEIpb1HwGTKjoK92uFdah9t6PLh7hy/BpwfQgOonkWRfovL8zIxircC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nez6B5ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nez6B5ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31F51F000FF;
	Mon, 28 Sep 2026 19:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790622354;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nez6B5NDfkeFmsBCGzd5A9msSEiBKFiAR8JeCRk8PZPGt3yFh7ESWu62GIeRt0pJG
	 /Nocqdc9EIc5mUi7ByjFqcKCrco3Ue3jDthJeix3yFD8QfsuUcuxeEOcdG2QL35nC8
	 s1yuvYw3s4HBixLlr+NCOnpMIeu3kE7md0ZnRB8PWLx7yky5yWTbCOBPMvlPO3t5Or
	 m5FIZ/ml/AdFfR6egp2Euj6c7SHTG0jKnmbwzPsnYM3gSdR8jtZ1xKbsfC2n92ud1V
	 PG/83GfYpFghkCqlnJP1AHuZsxRErTVYGF4H9yIBb1KU0n4lPo+UM5nsmA7sU18qsP
	 id26NN+Ke08cw==
From: netdev-bot+sinfo@kernel.org
To: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, fercerpav@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, gwshan@linux.vnet.ibm.com, joel@jms.id.au,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: ncsi: clamp filter table counts in GP response handling
Date: Mon, 28 Sep 2026 19:05:53 +0000
Message-ID: <179062235338.31693.7662054582529437023@kernel.org>
In-Reply-To: 
 <CAANnmVAicVNhy8fMUaFJ_N+b4DnbwpYi1MOL4yMVisix1WCX4w@mail.gmail.com>
References: 
 <CAANnmVAicVNhy8fMUaFJ_N+b4DnbwpYi1MOL4yMVisix1WCX4w@mail.gmail.com>
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

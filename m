Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68547388E72;
	Tue, 13 Oct 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909348; cv=none; b=DADbxj0rprqETLd4rCc1N4ZRuul6zkaTGi7gGI55Liko8V0/FyNkIFjyzJgCqHCV3Bp6H6G6FNjgalwnVclyBl3ziipLJG2siDxzR42urY9r0s+sYxH8tVP4o/afftGamq8a/lhOrTVWk80HcvIJEgRFA5QxNglmBYT/Ry1UGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909348; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0emwUFhUyhV4mUgP4/SezZmFLKcdcckmGKvlpl48qIOUzQRArA7Rz8r5TgnqdYvd2IHDP21VKO00a0gQoXt1uah3KPkfC3asdJNb5GlnDbDMge20GHmynwhL982JGtJ9dwi2mFTOm6X/0vih4JPKdtrHsRC1mo79tybsWhqoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yzy7EZuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yzy7EZuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783FA1F000FF;
	Tue, 13 Oct 2026 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909347;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yzy7EZuQBhKG92gICaBA+mFCaMDI6k1oND61iEkFUIjtT3El0jv9zcHwGFFSacLis
	 XUuzbiwOa46vYW6CymqS/FE3hzWUfQoxT1WTPd9Y4xxbX7An3S8ocgOtmb6+x4ICiT
	 rOcTO5PitB7Gli08/SDdmzx+2Ho2+r4FM1zz5G1sUBBEaB/QosZFE4IvEeEcoRfujA
	 WOsXDTujVIoLMPnWJegpP2dGCDMOtK9rpU/OnMNEP5fN7t2uSkhwnovsH/gcJRm5ZV
	 JyGI5k4X4wrTysfmxcSs0xtfiDsO6CSLKbQfesimvYL/uSOq7qdrTUVraRgzdBg3+L
	 tZ69CB32cuNmg==
From: netdev-bot+sinfo@kernel.org
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, elic@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH] net/sched: cls_api: skip indr register on failed bind
Date: Tue, 13 Oct 2026 16:35:46 +0000
Message-ID: <179190934605.99822.9665976540343357527@kernel.org>
In-Reply-To: <20261013163014.25722-1-q.h.hack.winter@gmail.com>
References: <20261013163014.25722-1-q.h.hack.winter@gmail.com>
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

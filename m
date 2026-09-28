Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3804F392E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613991; cv=none; b=hV8FDbXFlA4JndsZB4/zHiBKPGOYQ/VCmYYGt/yCNdcIhRa/fTKpPOtDKAoiHTeiNrZZ8TIGMh0HylH1mZlHL4RqyIGoiYRT40wYA4w3Jzxih0R92jwDPDdIVLJt7bs6o1BhM7MWZzXQKEzvlb+pruR8u2ZXisHv8iPU9n16IKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613991; c=relaxed/simple;
	bh=4xMJntxHfn6AwnHN8JU2RmwZiQ3aHB3uDh2MewEkjeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFg2w0iG3TeI88ndsSymWIEEChXJ9HichYtBazxWoGlZEAbECtZdpYKcvzVb+yuBFjySc/irCmB4f69Djr9lwZUsCHqMCHkr/cBlwB3HZkn0cD591fKasmRLfaVCV4s/8MRBK26F584EumZu1ohd0sA0V1TE19PrwemeKmDtNEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq38rIbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq38rIbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41B71F000FF;
	Mon, 28 Sep 2026 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613989;
	bh=WdcjITcVR71rM7DxTLTIh39xUvW5S3Rxo3Jx0Miukg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aq38rIbH981z4IWcpB36/Fg1mY/uTuFVGWpAbxc3r6obpcjwj7aCCI1YRADQy0dFW
	 ljhH3KeKYtGmia0JfAF88MOrppUsP2g72MYbmIJSPvr+0nnIYuaaYFceEoDFp7dCRb
	 GUv2t4q/IErlalOy86nAy8KDxLwyACye/wUvYDr3GjFIu8PKizKQxgkEi5m97dyS5l
	 vmEqUu11O/zymYm5C4opfAGzmQfWqf8tfej6O7G//HUgEIQ6tbi5eKoMDmKWYlEbln
	 dkBUWC/9oRn8a7LmwwPTaCV+YVBLYgp9TSBt1DjFLe+d2VbbB1k0JYCl2baXNx+e13
	 EvCruGpiYWitA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Florian Schmaus <flo@geekplace.eu>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"H. Haechoc" <h.haechoc+kernel@gmail.com>
Subject: Re: [7.2.y] Please backport 41112a787f91 ("PM: hibernate: Freeze kernel threads after image preallocation")
Date: Mon, 28 Sep 2026 12:46:11 -0400
Message-ID: <2026-09-28-daily-reply-0012-re-hibernate-freeze-kthreads-7-2-already-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKp=m=Assw9TBMVQbUPSvr1r6fLWFn3=0iMT9NOJ9iE7C+x78w@mail.gmail.com>
References: <CAKp=m=Assw9TBMVQbUPSvr1r6fLWFn3=0iMT9NOJ9iE7C+x78w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> could you please backport commit 41112a787f91 ("PM: hibernate: Freeze
> kernel threads after image preallocation") to the 7.2.y stable series?

It's already queued for 7.2, thanks.

-- 
Thanks,
Sasha

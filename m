Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCF2F8EAF
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252278; cv=none; b=O9KNd8Eu9yhMLD9Kq/Y+1925c/I4+yzCHppGcybquiefNQ6S8d40UpPpwyjNcnWJVmgRgqCFelqc6bLgZqeXj9+BWWuY7ItheUV7/0Ap5/l5tDVsTIOwd5h2ZV1EkGnoBKF9++R+9WIK1FE6zvLZqCk2Z+9XhIZ7n5Prr+HawAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252278; c=relaxed/simple;
	bh=27cmhaoz+HM4ZMxdQJfaY220QhiAAH2CQWcAmzBozr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHTXPFoA0DEw7YgRBVENr4Bm5rWIDNFLij2wIpF4C/yVrN3u3sFTVau/7JsagjRDh61lC1GwGP6eBDEjJnWW9/u/PKfQtiyF6Bt0vVVh+04xg//7sofpbYxQ/WN73jkQqpSPC+5AHL/39nkuvDT9jBrFVdbEcICy5yqbksmgsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULw08LDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULw08LDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779891F00A3A;
	Fri, 17 Jul 2026 01:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252277;
	bh=h2+ma5LxVFGqMrLWlG5UKPg0Bp2I7YM+Z201nMwf2qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ULw08LDdnU85vEKNx5DGq+NwFwEs29Z+HlVMPMqF4C4uAGLZur1efpIlNHgh8uTFA
	 lHgf341hnKRwCRYuIEvQza+Z9cBskNRv52Z4H0alvzKvLJT7W6PuUCuIQY615oNQme
	 UNDVZNpNqOav/pnhgLIgvPWwdnTXLzOZI5Ezk8rv2iOxfsUHP4VIWWaDFkIMAZxpBq
	 r9etteDArRm6/oeNmEbaH+5qYtDF/EebpOyy5RVPIfj4E9H3cAzkmY9xd+FFAuLmaA
	 SNmhZOajQAVCvrWG8sGdw5yEYL/rLD3tlLJN96x69ddvHmgNoCOWRAq/c3BGHcUh80
	 hDRc50Ek72Y6A==
From: Sasha Levin <sashal@kernel.org>
To: Erwan Velu <e.velu@criteo.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Adam Li <adamli@os.amperecomputing.com>,
	Peter Zijlstra <peterz@infradead.org>,
	colin.i.king@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: sched/fair: Only update stats for allowed CPUs when looking for dst group
Date: Thu, 16 Jul 2026 21:37:35 -0400
Message-ID: <20260716232340.0008-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071635-goliath-clamp-5cef@gregkh>
References: <2026071635-goliath-clamp-5cef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 16, 2026 at 03:12:00PM +0200, Greg KH wrote:
> On Wed, Jul 15, 2026 at 04:29:09PM +0200, Erwan Velu wrote:
> > Please backport commit 82d6e01a0699800efd8b048eb584c907ccb47b7a, introduced
> > in 6.19 as all stable kernels are affected by a significant performance
> > issue.
>
> Now applied to the 6.18.y tree, thanks.

Queued for 6.12, 6.6, 6.1, 5.15, and 5.10 as well, thanks.

-- 
Thanks,
Sasha

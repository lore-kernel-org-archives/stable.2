Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CBC35CB7F;
	Sat,  3 Oct 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045084; cv=none; b=tR+DTJZYqvV4VZSR9bKA8mRpGNds034ImqKzUGuV0fTHWq9Ix28EJM7kX4axTOt1U3+nsce32uZRxja5Td4HNBfSrA68gwlgyLsSlpp9LnZGAv32/MZY9ympq5Y/rM89hbddOp93pOPlL+BM8GW6nytdXkmnvfyIQWytzotzFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045084; c=relaxed/simple;
	bh=5e/KN/xUw7lArWbSdyarhZ1XThDnY18ob5T7lpmm0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMSX9g4I6zMcDk5zisKHYi10QqXMlwlcrUF3IcCZ52YmTJlHyhO/6tyIGxAgO/z3ck7s6QxGc13DA/qXzNZgBk2SufYNrBMUaJYe5+X3yBGANi8I9jNGcPmU2YlqnFnxX+s0or3vjYyvrn/RuPcAHyzgVhP/+Am8tV02giryBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL5f2GXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL5f2GXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9153D1F0089B;
	Sat,  3 Oct 2026 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791045083;
	bh=5e/KN/xUw7lArWbSdyarhZ1XThDnY18ob5T7lpmm0Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UL5f2GXcsaUNO+Dla38WGrEPCA3dtkjUMAzxdJuDHF8S1eelSbizJcH4mKrykxXt8
	 zqUlqcp4q0GxEwsxowjB+M0ber7JoEgoWMGs6nyyV7PtSkRi7cMDH6G7Mi7+GMcP8G
	 Kei8bnTVVpahVpLfF8CrruSrc2aIQ/8VdPjPPnTDeZvv27maY/8JurP0q5BJPMKnWa
	 EAOXeTmf/5TiXMIfG3zWJg+VdH80A62WQG9y92TGVid+k9bSM/oT4UTlzWneWzdxgi
	 zHIh6osUjXjpsGm5BcCCv2m39/mzAICt+B1lyZAdTqI+bKl7rgFKBdre4lmBCxfRg9
	 nm+ElMSU6d5OA==
Date: Sat, 3 Oct 2026 17:31:18 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ameer Hamza <ameer.hamza@truenas.com>
Cc: rppt@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
	david@kernel.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 4ncienth@gmail.com, sashal@kernel.org, 
	alexander.motin@truenas.com, caleb.stjohn@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while
 perf record runs
Message-ID: <asEtt6OIJmBww-0T@gremlin>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
 <asEllR7if-J3wteg@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asEllR7if-J3wteg@gremlin>

Fix for perf sent at
https://lore.kernel.org/linux-perf-users/20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org/

I cc-d everybody on the thread also.

--
Cheers, Lorenzo

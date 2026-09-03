Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB649EC75;
	Thu,  3 Sep 2026 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439375; cv=none; b=EkAqFw+rijOU6omQ3JDLFTFZeQ4Bl1JN/976dyGB3htGlu7A5GaAYFu8/7jLovUeLWzTIlDRWWOeOF/jZifg60vsfgZ6TbT9rwmyy6ChCRkt5IKkQwcujHKbYLLFMhU2fVXRKNDToeRRt/FT9P06Qf4y3+XI3kA6S3EZeBHVBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439375; c=relaxed/simple;
	bh=ZllD5TAO0xt0mZaigH62R5/lx4AsRJAX+uJln1TBcPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIYYqEq5hp/iXNBeI8NKPg9rsrVf0/z0G78yzJXxVScquDJmTmk2Aw1aSIoZ1vpCsW39r9I9FeF+y9IbXcCHLZ2W1NlZZnAVETFjkx+P7OBcC7bw85vJJB992Eo7ADc+G6EB+cDz4KVdlxmPa5vynNZCX+E8AgKu9/AjEKPI9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpmmJT6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpmmJT6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979971F000E9;
	Thu,  3 Sep 2026 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788439373;
	bh=acAKOszqupKXuMsDtFwZQrgAe69n50iavBmumTXF1KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OpmmJT6QFPZXaRm2WFz5Rs/z6FmUtkwkOFxPczvJwaAW8KNo09rh5REBBKFNOpkhU
	 Iprooz3cH2XRxlykZ9d6h0MIWnuvCz5RQ6H4FXtF89kvvewmoWsUpDFK9WDkd01del
	 ioLChyoWJ/lF1NMTcw1cQJhF4COCgLyWyvFwccoQ9MSQF0PR6doQgeIoznAga1GN4V
	 vRlGZblcbuUq6uuZDDUazRP8INxbAR7HZbGeXtObQTqUvEFQh1EdQEu5Ig80kDge56
	 iIOLdMCbVdrtP3ZBipzB0ohhx33poMJhFlaQJMQO4H/feCToqCCexBNoTnilsm92Pk
	 yLi4fUrjKxa4w==
Date: Thu, 3 Sep 2026 13:42:50 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Breno Leitao <leitao@debian.org>,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mailbox: pcc: Fix shared-memory teardown race
Message-ID: <20260903-accurate-lavender-jackdaw-ffba7e@sudeepholla>
References: <20260903111328.805352-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903111328.805352-1-christian.loehle@arm.com>

Hi Jassi,

On Thu, Sep 03, 2026 at 12:13:26PM +0100, Christian Loehle wrote:
> Breno’s fix frees the PCC channel before unmapping shared memory, ensuring
> the IRQ is disabled first. The second patch serializes channel release and
> request so a new mapping cannot be unmapped by the old release.
> 

Can you please pull these couple of patches as fixes for v7.3 when
possible ?

-- 
Regards,
Sudeep

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345643E097;
	Thu, 30 Jul 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420609; cv=none; b=B0+WrJYE75eVwcFgTE36piDzisdZ52aABkPidnamkjCtCc+k2FfhAh9726vFKKO6dKEkF+y+WLEQpTS6ZASt5rqK1WCsX5kwE/20OFfzd3YIko3PTQucOUBeuAwWB48hvy+BmOwK4E6trKB1wR8t34UjaQiDjUzU7aWrop8mnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420609; c=relaxed/simple;
	bh=JFacijSoOk+Pfz3bncLtVSm7DvRRfvar765CcQ10RiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG5ePyLS4yYQJchx+ikaYB9B+z4HsHKmzfbzBBRO5KnGkFA7xGffk5coVL/UJmyOyjdtl5z6HEFfwCVhkm2AhIPLyh7N2OJIKScYzBFxcZeYGiGAY8dMIvPYT4AWq9BJmu9H+7mYoZUSiO0ea4OKFyF1S4RRttY9uRTNK7dNp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u0D36w1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u0D36w1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6AA1F00A3D;
	Thu, 30 Jul 2026 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785420607;
	bh=n0GKQP4+y2busracc0QkdYbb3zXLNLuvBf3Ozt98nAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=u0D36w1DScj92QqkZZmwwKXoDN4LN6ORkaYhGEO1OafSEL1oFFrzSlg1UWH1ePCK1
	 sBmOARlczob3S85HkOF98ixqZAaXrfIQB1TGMpj18UJvLRNQcfBo/rM2/HXjR0hstX
	 N6S1QOVUjwiAMi8QfaZdeFsMMVs9K9v9rbAhwxkY=
Date: Thu, 30 Jul 2026 16:09:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org,
	Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>,
	Srikanth Aithal <Srikanth.Aithal@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH stable] KVM: SVM: Bump asid_generation on CPU online to
 avoid ASID collision after hotplug
Message-ID: <2026073045-shrimp-amaze-7668@gregkh>
References: <20260729225006.671397-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729225006.671397-1-pbonzini@redhat.com>

On Thu, Jul 30, 2026 at 12:50:05AM +0200, Paolo Bonzini wrote:
> From: Nikunj A Dadhania <nikunj@amd.com>
> 
> [ Upstream commit 25f744ffa0c8e799e06250ce2e618367b166b0d4 ]

Applied to 6.1.y and newer, thanks!

greg k-h

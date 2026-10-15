Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0F380FD2;
	Thu, 15 Oct 2026 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041755; cv=none; b=g0jcMK8Py0F819bNOcdXLhorVZVtAT8fRZkZc5hj3aHhgImI/yjs7uVb2lSiQg3BwziOIX/rZu8fNSXq6VT9Gf0mh3+3kVhEFA9G4pbvXW9idLCNHCzhJVPC4GT9MahSpSZ6vE6jKRiAuM1+9DkZha3+b9VoYqAp2Bwp7GU2jkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041755; c=relaxed/simple;
	bh=2kSeRLlvat2XNIzXaCBv1O5ETKEZamXhSS2ykhVOvp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzM72EEH5qyX+IRADpQVaHYck4dHzZhUsryRsnF/u2k+HG9M7/QmhXalkvkPR39P9PQrI80ShqSG5jSEw4wW8vf2HKXfhBIGTPf+zYuy098yW9hLqZADtWWnD0JeaoadIOtKySKrJlwJ1RdPB1MmY4R/Pd9ZSL/tcyMn4ofE52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3pv7Qyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3pv7Qyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64EA1F000C4;
	Thu, 15 Oct 2026 05:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792041754;
	bh=qwI4tiZkRarAW0AI0Lu1Vqn2JIOQvuU/qFCTMsMk+oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L3pv7QylAnSb8RDdZOH53ljig1Cw5ZY1MfR5tUmEKoYjpJnNyDVcdKwWytDd6ui3g
	 DDFAlqgkoNfAN7U5YfXWC17XLx72JpAyn9MgjJe80OFxIcxuSX9DteVgh5a0Y7ng6D
	 juJ/9H3vn4Zh9IId/AiesqxgBXTRLBE/zVea2GZA=
Date: Thu, 15 Oct 2026 07:22:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Anil Altinay <aaltinay@google.com>
Cc: stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 6.18.y 0/6] KVM: x86: CPUID faulting fixes and AMD CPUID
 faulting virtualization
Message-ID: <2026101519-deserving-attention-47a2@gregkh>
References: <20261014212844.11997-1-aaltinay@google.com>
 <20261014221854.275719-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014221854.275719-1-aaltinay@google.com>

On Wed, Oct 14, 2026 at 10:18:54PM +0000, Anil Altinay wrote:
> +Cc: Jim, Sean, Paolo, and kvm@vger.kernel.org (omitted from the initial
> send due to --suppress-cc=all).
> 
> Full thread on lore:
> https://lore.kernel.org/stable/20261014212844.11997-1-aaltinay@google.com/T/#t

Why not just resend a v2?

thanks,

greg k-h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A14D2ECD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660682; cv=none; b=DrPlkzomqjln/aJwgmMpk3LLrBVQKt6hW3Vg21TMyDq6VIu8mkBgipWH5mLiruLtUYe72x7ru6O5bnod7CJ4PkKsxt0KF4r2HYMJn61GJNzzmyRiMFXs9S+FYzTmEdJUWU8Git/Rw1O7mIrLz2y1MFzH1ZP+/rAWDoGpma/8lfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660682; c=relaxed/simple;
	bh=zpQ6si7uw1jl/RIzu1NxCMPAq6M4QSAgXRUDFD4KHAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aipev9OCcmdiY3wnmPOxom9ZY/cRACfuXlXIjSFrTY903xvhJi+Fap+NTkwmzvcdIX5k3rqfDQIY3fPE18nLpEmvqfnspA/Jg67xoEwWEedWF20jdaynIiZeYcHu2XSu9F5XnJIHAW1Wevwv9UjEVEr71k4D5tKAQSU7aBObPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loX0r3T+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loX0r3T+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978161F00893;
	Fri,  5 Jun 2026 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780660680;
	bh=N5UqwPknsHGDQjy1hj/N8q1WQ81FcdAIH2gYxPFswcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=loX0r3T+GIzuMgq8TcMZ8o94w4VqLbhGRBvsOSMdJbI+GvVhZlqFeh8eFfrkPOpmR
	 lHxxK6sIo8o3WRMl+kh2A5GnXGX16abFzkRB/ngbQxyCMUZeYkR5EKAz9KEFXY9sgg
	 HtM+Gl1oYb4ckLWlSiidDiB6BGBq3OQXBaCReXKQB2NhXqE+h6FB9mV9JTiDpgM2F5
	 mxvone+RMKG6Y8G1Rqw2H4+xAqCzBh9QFLfudlha5MfF30AT46oGOUtQl7SneX8gwk
	 jzBUca0wI0u8wcp4UycrKiJdLcpVIa3xx7OoZtIkYB3uf6JEAP99q8XGg+Q4q3uQMG
	 FExrZd7JszovQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id CCB97F40068;
	Fri,  5 Jun 2026 07:57:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 07:57:58 -0400
X-ME-Sender: <xms:xrkiaohhsBejZS_wkdgPIUUqGKdf3fbQxRq1bje0ytlp9LGjpgmkgA>
    <xme:xrkiatNivklow-apLIqPrXnzlvtD55MOMJP9Af9jrxxfok6D17Y2-NcHJU6XzrMOI
    Wm8bco-74L4fbFZbMG4s1mPI2ylnMwGOTQMbrYWjaGZhQlrN4pIAa0>
X-ME-Received: <xmr:xrkianMMLoxn-PFPPoOphZYOXa6UwnUMayhMLOLmyxytdnAI6GXHJy38XTpkmg>
X-ME-Proxy-Cause: dmFkZTGlMapHgO6YPxLOBpEgF2Nb0Po1CwNgwnzdZXXDmQLsRei8CnmZzV6j4zUiNwC0oR
    n3vF7GbKPb4lL7Q26i3oNiGGyFvC7IrxrN6en5MlCla4erAiuF0EaxeRhcW2riql7/GA3e
    qRJwlLyh0wNvOgiPpeUqndlYfnTbGpTJZnrBELkchn7nKJce6m77HAgeMqKrp0hWi3XArV
    QEheiBglO4ZXJrJUBi4uCOBpmNwKMV0TC3LWNqs8VX2SRkiYX+GZ6/U2RBCZ+yd3x6h9Aa
    Cl7+yqqNwQd6SvjfR6MlgnBRT84dO2WjZMf9U/Rx/RLVBXfmA+iKUYcRRpshqKu+GFTlJO
    32m9WXtKGPKPsSRyqSKqWMJWyVJOHLAKvbjcPDuW9z53/AOT4tqdj8Vh2wy/6l0oyAEa8/
    pSNJFWwTB5lQo49qxGYHREjjYYq3K6j9UfSuOPqJlG0dbT4Ueg/bKQevPqXa047DF39fJq
    xtaTRRBx2ZrYj8M+yVOiTHFuH6vHE1+8kYRL7mW37Wjfm6yHhaLcPhdVE0Bya6LoPUYAok
    c8ZclHkLl19lAr4Ne4Che6i7eywyuY3zmoZdqK8RJ9HSrW1ep/0WV/1mLK9zpK6klmx4Jv
    f8KEsvIw2VmnF4QmwN41Bb4ewy2NFJyYFz7n97SzEfKzE4D7SqQAcvb3TfzA
X-ME-Proxy: <xmx:xrkiak0BWjEcy2tZ0lbcC00Uno29pfygx18eQ-A0VffU7FhJpObPCQ>
    <xmx:xrkianFb7boTwnKWIoN6F2s2X_bog_uFUWcDPqdGdpazlG0VMAL3RA>
    <xmx:xrkiathKIFMy529l82kWgg44Vlikr1czc0Q_ghF0ysVd3DbaKHUjBg>
    <xmx:xrkiatYgC1SxW_kVZmJ9eCACfB0RRmYQyAUg_o3afc5Tp3WmMddnzQ>
    <xmx:xrkiaq1B7bC-cClojz01n-_Yb-gga_qG_w4EKf74606p9ygBanjTH_yd>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 07:57:58 -0400 (EDT)
Date: Fri, 5 Jun 2026 12:57:57 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: dave.hansen@linux.intel.com, Binbin Wu <binbin.wu@linux.intel.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, seanjc@google.com, 
	pbonzini@redhat.com, sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com, 
	xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, david.laight.linux@gmail.com, 
	ak@linux.intel.com, djbw@kernel.org, tsyrulnikov.borys@gmail.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] x86/tdx: Fix zero-extension for 32-bit port I/O
Message-ID: <aiK5eu0GuXhd0NAx@thinkstation>
References: <cover.1780584300.git.kas@kernel.org>
 <ca503ae3de72d90956fcaf5dbc0760ec20f5a5e0.1780584300.git.kas@kernel.org>
 <22c789c3-13b1-4c39-898f-2eec3bce98c1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c789c3-13b1-4c39-898f-2eec3bce98c1@linux.intel.com>

On Fri, Jun 05, 2026 at 03:10:39PM +0800, Binbin Wu wrote:
> 
> 
> On 6/4/2026 10:47 PM, Kiryl Shutsemau (Meta) wrote:
> > According to x86 architecture rules, 32-bit operations zero-extend the
> > result to 64 bits. The current implementation of handle_in() only masks
> > the lower 32 bits, which preserves the upper 32 bits of RAX when a
> > 32-bit port IN instruction is emulated.
> > 
> > Use insn_assign_reg() to write the result back into RAX with proper
> > partial-register-write semantics: 1- and 2-byte forms leave the upper
> > bits untouched, the 4-byte form zero-extends to the full register.
> > 
> > Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
> > Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
> > Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Cc: stable@vger.kernel.org
> 
> I think the concern sashiko commented in patch 2 is valid.

Yeah. I guess I'll just use the KVM implementation verbatim.

Dave, any objections?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

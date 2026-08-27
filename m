Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B73644A0
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787867509; cv=none; b=QIAVeLZRO98N66n7dSLJLefGNA2f3aKzY0YKyJIUwSMoUXzHadhT1FFz9n2wtfpUMMZp5aHGTx2mxzmpvRVrmlbK4u6ppB+nQSGvLABWqeNDNqupChATbgX2XMQElWnL/oeXRXMc/uDIE1X26FchJY6shDuILTUS1ETBZ2bRreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787867509; c=relaxed/simple;
	bh=sVyT6SJ1XC4Ev63As2WkQ7SvZcqntdNVSI/mm6dpXks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8I9NKiNt5kNTUvHK44TdKmfOa9chKPJ3ims8yAKPCCBcaIpsO+RKXaDzsTYrPnfRbJnj2UvWMkHLze1nJl357qXw1YL3Htamsose3VTydzVeq/M+1+AW+kW3xL4HcI9YvGrlJ8TkV9TB+g1er5/IWPXfubwlNC1fGaUQDvZcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebPY/f1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebPY/f1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA371F000E9;
	Thu, 27 Aug 2026 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787867508;
	bh=sVyT6SJ1XC4Ev63As2WkQ7SvZcqntdNVSI/mm6dpXks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ebPY/f1N2Ot4aeFQ9gH6FxknSvSgg4u7RXPUnffmi2GQALy7b9YmntZ/yE+N+9I2e
	 xk8RIqUhNCm2mdICjFcLzYocPnvyxTIMweKntjKcE8rPbfQ2YRzRfrDYIW+uk/PuIa
	 LNgTufCqhQx2v2UCNwVsVi/w2j/a4TXwG5od5gPVxKOTDyE9E3Re78r/vd2wC0Icvz
	 Xn26+vzhlkvdpvke/t4UHt+zUixDUimi437H6noqXqUZovJUK1lTihveZn5+IGrMC+
	 5Flm71feo5qFdiQET2D8TRNNkN/a2m4xP3icidZXA2+f+XfuSXudGQqSvruid8zu3A
	 9u/PvlyE65pLw==
Date: Thu, 27 Aug 2026 15:51:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: reject unsolicited H2CData PDUs
Message-ID: <apCxcvW33xppjCf_@kbusch-mbp>
References: <2026082755-stucco-champion-2bb9@gregkh>
 <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827192455.1849385-1-kumar.shivam43666@gmail.com>

On Thu, Aug 27, 2026 at 03:24:55PM -0400, Shivam Kumar wrote:
> nvmet_tcp_handle_h2c_data_pdu() accepts an H2CData PDU after only checking
> that its TTAG is a valid in-range command index and that the command's
> data buffers are mapped. It never checks that the target has actually
> solicited that data by sending an R2T for the command.

Thanks, looks correct. Applied to nvme-7.3.

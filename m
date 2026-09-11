Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BA4718CC
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126242; cv=none; b=nHcvHGLJYhwvR1I9B2jJbxXAkyr6NTwyHAPOlPyUWEERX0GOh0klu10QGjwXK11enbk5n/qACZrJR1kLZXZ4+mWiMHwkrGR7h277dj5hDR7AFhXZLIgdCov405l+qNgawZLfSQ6HKVFr77IeN14gggIkeOrzNPgcS40u1EtK5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126242; c=relaxed/simple;
	bh=lkNKh8MjCsYKb5Bgs9DvKOZGFOOPD9A46M3YhLtVBrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwFhSFpXkvpbTqW4tR7XXm9OO1pyEY/IIhapWtdjyjg78LgGe7SBCz4O3fg53eEXQPmf6oCMm+50pWd3cgLYngPXZ7ckXPBbLsPmdTKpky2FY75WWjcwpO0WjJQiQJpd/owcCEzMXcn88leZpvPzEafZmeN69ZCPcAvE/w9JwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sTsG4Yzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sTsG4Yzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB311F000FF;
	Fri, 11 Sep 2026 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789126211;
	bh=8D/NrpurKDvuELZn/oroQTVO1ynb1aMWhLRG3Abcmes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sTsG4Yzn6b4PdNMYcOjBJQ0SPw/mfhXjrF9EI/FNCSyUM/ZW2IW4KhNPBxBhodeGt
	 NMBH71lRBlUloHMruPxOehpzQGr7G+cDqeKwu7xOEcGKfVoOoGXX/zTAJ5jhQST/Zp
	 GYwg7Wp4TJqO2RbNnYBV3QNFL9SFNjJTqO1KZOnM=
Date: Fri, 11 Sep 2026 13:30:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org
Subject: Re: Attaching CVE-ID to specific kernel fixes
Message-ID: <2026091145-trilogy-raider-b6cb@gregkh>
References: <CAH+zgeGSQTgn=LVUKj-T4LnxSFjn-t7cftfAiEvAsQpdr9sfXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH+zgeGSQTgn=LVUKj-T4LnxSFjn-t7cftfAiEvAsQpdr9sfXg@mail.gmail.com>

On Fri, Sep 11, 2026 at 04:50:40PM +0530, Hardik Gohil wrote:
> Hello Greg,
> 
> I had a query regarding CVE fixes for LTS kernels. I noticed that
> while fixes are backported to LTS kernels, the corresponding CVE ID is
> sometimes not included in the patch.

Yes, because it's not needed.

> May I know the reason for not adding the CVE ID to these fixes?

We just keep the identical changelog from what is in mainline.

> Wouldn’t it be a good practice to include the CVE ID in the patch, as
> it would make it easier to identify and track the security fixes?

That's not what the kernel changelog is for, that is what the kernel cve
vulns.git repo is for.  Some CVE ids change over time, and some are
rejected and the like.  To attempt to keep that all up to date in the
kernel source tree itself without rewriting history would be impossible.

thanks,

greg k-h

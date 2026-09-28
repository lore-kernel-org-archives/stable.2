Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA7320A14;
	Mon, 28 Sep 2026 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573731; cv=none; b=gRAIoZb7wobCgHxHI7XeoQANNC62V9A7o9tT3Lq1Ww4lT8KV1XiFBOjeyhTJ7yAzCovAr4daCCaSiY5rVdXJZQCmB+HuH2JmZ5pBtjMvQQeOKq29R9QSevVZPavkqNKPPOQ97He+57wfcnQhdk3UWEHrR2mfwV1uyM5AjrP+B7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573731; c=relaxed/simple;
	bh=eNAOnS3k805oxJmXLzSCijqlFpgfljf7mwkqK+tBxXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDxnpdf5rxDNpPDqW+RQe+/4FsK7anVnCyLEpjcoutPc1OrXT3X7ln5pNPMrjtCl3dTBY9z1fHWAuDb5JixGQjLRnSG16kiZ0AgsSimsxZspuMAzmzVb+DKcqKtlU+V8+YVQc0c+4hbVb501tuumJzWEhrKHeQwh3ni/8CdAtx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zr3YWIZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zr3YWIZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E61E1F000FF;
	Mon, 28 Sep 2026 05:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790573729;
	bh=/dLADSu3KzJa7qy3ofcif53MVtk/tUV3iTYwz4zg3pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zr3YWIZPIwIRAyTjqFr84y1KYsnMnNSMQETqn+qV6IhkkoEgiTryl+K4eDz2DAL7N
	 AnbzMuUa9N8FCDKVMOVQ+3qka+uBgcFWsRz6NslPmeOdUf6rCSbxkPGgrubaCR9OSD
	 F7IdJvOQ21EQ847U/DR6T0/J1OhCxLfsnK8YAfTA=
Date: Mon, 28 Sep 2026 07:35:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, rafael@kernel.org,
	johan@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"sashiko . dev" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 1/2] debugfs: fix use-after-free in
 debugfs_read_file_str()
Message-ID: <2026092854-script-safehouse-be1c@gregkh>
References: <DLPDB44JJRGJ.3K6JNS746M71C@kernel.org>
 <20260926195844.1296333-1-qwe.aldo@gmail.com>
 <20260926195844.1296333-2-qwe.aldo@gmail.com>
 <2026092720-sandblast-heroism-30c8@gregkh>
 <DLQ9CHM33ZFK.3HZOB0LIGXGVT@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLQ9CHM33ZFK.3HZOB0LIGXGVT@kernel.org>

On Sun, Sep 27, 2026 at 07:00:04PM +0200, Danilo Krummrich wrote:
> On Sun Sep 27, 2026 at 6:37 PM CEST, Greg KH wrote:
> > This is probably not right, don't do loops like this.  Either fail or
> > succeed, don't loop.
> 
> Please see [1], where I listed a couple of alternatives (e.g. use GFP_NOWAIT and
> accept allocation failures).  I'm not very opinionated about which of the
> options we use, but GFP_ATOMIC seems wrong for this.
> 
> > Again, let's see the real use case here, what is hitting this in
> > userspace today and what debugfs kernel files are causing it?
> 
> Not sure if this was hit in the field, but in any case, the reader lacks the RCU
> read-side critical section required by the writer's reclamation.
> 
> As mentioned in [1], there is also a separate caller-side race in SoundWire [2]:
> nothing prevents a concurrent write from freeing the string while
> request_firmware() is using it.
> 
> This is also why I think the API is a bit of a footgun. Fixing the debugfs
> reader won't address these caller-side accesses; something like the synchronized
> accessors suggested in [1] could address the broader API issue.

Ick, how about we just delete it then?  I thought we had removed debugfs
string functions already because of problems like this in the past...

thanks,

greg k-h

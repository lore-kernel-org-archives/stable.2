Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61348D860;
	Mon, 21 Sep 2026 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993381; cv=none; b=dBgPLTGk+eNV9NzoScyKxJMJrFm27KjRDl1fgFOUHALRFVGWj7NROMOiAG5Dcc2CdzfDvDHQidqbykqrT1XqZ198TkITcYgyA3yWxXL4qqxiduJNnN1dFcxjIeREeY3VBamrGpIlytGEmdfd6+9GkufGxnPJxiGjbokDuCd2Eos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993381; c=relaxed/simple;
	bh=sHyTpWHes5t75Pc2Fmo8SNWMvQx1Uqr3FJpfTa5lMM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiWhSzb9aYcRiJQYCoLTzUOLLESKBLvVOuBoy9HcmV50NMO7Np3ljpMMsCsdY0Yr/eivTR/A45A4FB7CKxaQpqqrN48/6iZd4THmfojw2csXHfkVMeq/rqJcnCo68ymF2dn3P7u708nH5QB6D3Xybqzc1tAwN8RqSGty7m9S9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHgIduiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHgIduiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5CA1F000FF;
	Mon, 21 Sep 2026 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789993379;
	bh=lTzvc3ARjN3lgv2zB53AMrhfzCTL7oIJ4fUjptI3xGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nHgIduiKc67QnbquwIqFxD1s7R80IYxaTWQMVhLeNACpqzTyrBiCKSeq/Et3hmo6H
	 Z5YE/hTyKTryFjezNvMjueSraoriFXKB750dTojdph5ayOKvS4mkq+EbkVXn4QnvDd
	 4jXalW+sqq9fu8v4OEx8MZ0rcLvLdDTY84lbAkHY=
Date: Mon, 21 Sep 2026 14:22:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huang Wei <huangwei@kylinos.cn>
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+e7aa19176573a6992617@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: typec: ucsi: acpi: don't dereference a missing ACPI
 companion
Message-ID: <2026092130-thong-secrecy-1dd4@gregkh>
References: <20260920090711.300-1-yogeshgaur.83@gmail.com>
 <20260921030346.1996820-1-huangwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921030346.1996820-1-huangwei@kylinos.cn>

On Mon, Sep 21, 2026 at 11:03:46AM +0800, Huang Wei wrote:
> Hi Yogesh,
> 
> I checked this over. The fix is correct - the sysfs bind path can
> indeed hand a non-ACPI platform device to ucsi_acpi_probe(), and
> adev->dep_unmet is the first dereference.

And that's the problem, don't do that.  Seriously, if userspace does it,
it deserves the pieces the kernel ends up in.  This isn't a kernel
issue, it's a userspace "do not do this" issue.

There is now a taint flag that gets set if userspace tries to do this,
showing us all what is really going on, so we can ignore reports like
this.  Also syzbot now should not be attempting foolish things like
this.

thanks,

greg k-h

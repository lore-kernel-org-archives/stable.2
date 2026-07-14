Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E462F3614;
	Tue, 14 Jul 2026 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005921; cv=none; b=XujYHIEV70Ab65gkz+CXoP47e6CMWy8rT1db/arAdzT9JnNapnUFjOC4bN7sbjalPeork5rHe/paC3P8XP1FgKD6dcedcPKHkiDe0L/RJ/FwkOv8FUYCYzh17N+RKND73drMiDzLhvyDMAEN2MRnGaRIZ5hUb5hC2lrDKADdzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005921; c=relaxed/simple;
	bh=V+J5wcDt9BT4FocIidr/3kedEYLhbq3IG640h+4YwDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ0902db+/ZQVVXOBcCS91NshD9Fb0g5gmIJDoahvT+GxZE115tZCEOrZHWoiE4lE3w+a4R1/Ne5lNaN7yfpa4L71Rxck+Ibri9Ic/k8jNpgOJ2Fs91p1Tzb9NKHEBB4IduHeR/yabI5m6Zgwapyu5ssICiOzZv+uWuTX8szlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aG8KdQ8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aG8KdQ8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2CD1F000E9;
	Tue, 14 Jul 2026 05:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784005919;
	bh=9YQUitHq/d56p1N9YWz+5SWWA2J65cSwrWop/b6GfVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aG8KdQ8wrhhEtGXaHTdZYpPLTNgdjLvwaaHENqvNG+lDQRxG6Kpk8uRU2aWybw+nC
	 Xj0uo5jWQ7+7rQMj3qh2xXGQMsMb4g/f58MiD9GIpsxvrzlPxsSRk0Ees7F9VhlxLN
	 hETgpwDVffluGJs4UjVHUxKgHcqVZmA448CvptJ8=
Date: Tue, 14 Jul 2026 07:10:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jay Vadayath <jkrshnmenon@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [BUG] USB: serial: sierra: slab-out-of-bounds read in
 sierra_instat_callback() on short interrupt-IN packet
Message-ID: <2026071453-reminder-ageless-dcea@gregkh>
References: <20260714033729.11023-1-jkrshnmenon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714033729.11023-1-jkrshnmenon@gmail.com>

On Mon, Jul 13, 2026 at 08:37:27PM -0700, Jay Vadayath wrote:
> Hi,
> 
> I found a slab-out-of-bounds read in drivers/usb/serial/sierra.c that
> is reachable from a malicious USB device.

Great, please send a patch for this, in a format we can apply, no need
for the LLM-generated wall-of-text :)

thanks,

greg k-h

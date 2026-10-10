Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE23195FE
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619918; cv=none; b=ceOMBKAc38xMKldBMXkofrIeBnEflKIQscr7le3iIZJ1aFgYQj+w93tH8ZkcniD+KHrzen/IcRLsyPT0TeoJduUMAKx2nYiZKikH492EG/iPZvQGmU10Zd71e/IhGTinqPZL7hGYyTB49cM3bo6Dy24XXAWrdIoDxC9Yx3gfcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619918; c=relaxed/simple;
	bh=2rZUdgbMGJzhI9CwwX7Mud7hTxfmVTF1ZQqKv2q2yrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue0f5ROvAfbjIf8tT4njGPwVSAwL15nr6FKc4C6sidrPEdC1kmdBoVOtmE9T3ZyBWn/NJQzjduiU7U+imSzr4Ihkjy53cXpENJvAwWrcNYzmnu+uN2uN7KJbqTIE7eZBrJhRtEZ6qQg10a4Mj+ZirRZ89Gq2SM3hikmg2TCY4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cvxIrYN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cvxIrYN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFD81F000FF;
	Sat, 10 Oct 2026 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791619917;
	bh=zXoT75VAg0QQnbU3meJurk3OY8K/rR/+4AFCNCvYv6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cvxIrYN0nT21NXcwwJSlW+E2nE/B0SEXd0k91NtUC/PztsXLyMM36fkHKivfvP+XK
	 OPQczRwzcY0E0dtd/K2yfmw9o8FlkkikoaPHlVZ9xMJyRMNWQDZ3JZ97kGvBtIhGap
	 P3RlpVL8+TkcxIsC2fItVuPMLmzqcyvSkHi8Dee8=
Date: Sat, 10 Oct 2026 10:11:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eli D <info@16bc.ru>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	alsa-devel@alsa-project.org,
	Kamlesh Chhetty <kamleshkc2002@gmail.com>
Subject: Re: Backport request for 7.0.y and 7.1.y: 6485da8579e2 (ALSA: hda:
 Add Lenovo Legion 7i 16IAX7 17AA3874 quirk)
Message-ID: <2026101016-quarters-headlock-683c@gregkh>
References: <7afbbd73-a09b-48d4-a534-4b38ffc3e191@16bc.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7afbbd73-a09b-48d4-a534-4b38ffc3e191@16bc.ru>

On Sat, Oct 10, 2026 at 12:24:42AM +0500, Eli D wrote:
> Hello,
> 
> I would like to request a backport of the mainline commit
> 
>   6485da8579e2  ALSA: hda: Add Lenovo Legion 7i 16IAX7 17AA3874 quirk
> 
> into the 7.0.y and 7.1.y stable series.

Both of those series are long end-of-life, so there's nothing we can do
here.  Please use a more modern kernel release that is supported, as can
be seen on the kernel.org front page.

thanks,

greg k-h

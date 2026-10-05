Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6294CEE4E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215072; cv=none; b=JUwcxDr4d6IcTvWWXzioTii9c7xD+eW8Ba/ioXzWuEYpXUd+MdqJGX5SO2yMAAyraSHEJpUFxQMZmLL1vkfZfdV5UEFR6TYnb91MPSX5b9Ix/IqcXayoS/8gnUp73Z3BlM77Q+l6kCW3mGdyNppmhmBBK8a+JtPOSU0YUG0fpQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215072; c=relaxed/simple;
	bh=O2Cqy9X0cnY0zi9KCWois5E09rbBzlQSIft3jT/xZ7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRJK7WiM1QjhZVk4KnR00oYcqxW7g7f7uBrEPRizrtu417g5hxrResgFXPZYgjMZM7NZhJtosEON/unQ/fapqt/crzNIw7YdFnjhPAbz6xw+dCbh6+g6jfO9GiFv0P7KRT6NI/fzSXpC3HF+e2TlVC1MKPK2RUxfKgEsNNk5KVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=MdffjIsO; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="MdffjIsO"
Received: (wp-smtpd smtp.wp.pl 25876 invoked from network); 5 Oct 2026 17:37:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1791214661; bh=sl8bWpKfvgeoaqT0IZcQdTriNS+Ul+cP85zNN6ZqRpI=;
          h=From:To:Cc:Subject;
          b=MdffjIsO1wtqXGuBDovF0N2ZpKa1jamJ1j34ITePSQu2K0H+MxH76312yjf1yGF5P
           unnqOIllpckdzoYH5+vmXPNt4borUCwirw9jl2oQAKnOfoooEOCPlnhCK5hK8IC0yR
           CN5sHYKNn9zdX2lAWQ0ryxR0iDvy6CyyEXxbIQhCECWEiwm5KQ9OAMTP0J045GFZo7
           9nj+xNnLoMhNQm9+3e2OO7P56YkWMa0sIikzZ18jCBMp1Yqb/L1xbtdZVprrPfjbru
           s8mkQ8vHERshyNJABkvlg0HYcn0tNeKkbwWRxqmxlEhAd5CMpWnNPs/dhQ+1gseuks
           jjbcwMI1pz4+A==
Received: from localhost (77-236-6-58.static.play.pl [77.236.6.58])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 5 Oct 2026 17:37:41 +0200
Date: Mon, 5 Oct 2026 17:37:41 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"David S . Miller" <davem@davemloft.net>,
	"John W . Linville" <linville@tuxdriver.com>,
	Zhu Yi <yi.zhu@intel.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] wifi: iwlegacy: 3945: protect sysfs TX power update with
 mutex
Message-ID: <20261005153741.GA25122@wp.pl>
References: <20260929123329.2135878-1-runyu.xiao@seu.edu.cn>
 <20260929181458.GA17064@wp.pl>
 <7360e480d5eb194dc7c16c6e82944dfb73f3892f.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7360e480d5eb194dc7c16c6e82944dfb73f3892f.camel@sipsolutions.net>
X-WP-MailID: 2dc24ef8d6483809a3b1acb1846c8421
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MdMh]                               

On Mon, Oct 05, 2026 at 03:14:20PM +0200, Johannes Berg wrote:
> On Tue, 2026-09-29 at 20:14 +0200, Stanislaw Gruszka wrote:
> > On Tue, Sep 29, 2026 at 08:33:29PM +0800, Runyu Xiao wrote:
> > > The sysfs tx_power store handler calls il3945_hw_reg_set_txpower(), whose
> > > command path requires il->mutex to be held. The callback bypasses the mutex
> > > used by the other 3945 control paths, triggering the lockdep assertion and
> > > allowing concurrent TX power updates to race with other command or state
> > > transitions. Serialize the update with the same mutex.
> > > 
> > > Fixes: b481de9ca074 ("[IWLWIFI]: add iwlwifi wireless drivers")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> I think we should rather remove these files: custom, undocumented sysfs
> shouldn't be there anyway...

Maybe some of them should be moved to debugfs. I'll consider that,
and move/remove them. 

Regards
Stanislaw

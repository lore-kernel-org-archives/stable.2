Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC03F9A13
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705710; cv=none; b=s5Pj2hFUMRpCX2XASk6ePg6ZzKqkp2YMinJkDiWrY2giiCz7r1GvGyeCqJiGnAjL3MKNdeEnuX2LUxf6ghWQy6lXT54XUZmsATHAgq197xR1PKDjl/T/ar6FNPcPC5QZ2cnqZE1GFTJA5SWJgLDk3wgfAN8RZbvA2QamCh9mP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705710; c=relaxed/simple;
	bh=7YlaKSKdk/AQctfnNlh1p80wxyapyt+yadIM352C7/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhmTVk2HbmK6YVbZVkIRXpCi+ts2UTAHIOvXJaD0wjVSe0hwDEuVzfseVL4oykcRGmI5rzc17k0hYQ6VfJ6hNjf1fV+viHZVBWOEIPf1IJGCEh9BwBH9chOg8BO1k7Bk/cx2yuL0Gn7eoXXmYDkN6feWWiEC0HE2st3e8ucLqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=m97gfN/m; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="m97gfN/m"
Received: (wp-smtpd smtp.wp.pl 1904 invoked from network); 29 Sep 2026 20:14:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1790705698; bh=gYAiV4904KKNcflT+EDNb+ZPGPPIrx6h9mgzalGq1F0=;
          h=From:To:Cc:Subject;
          b=m97gfN/mdrBxI52wByHwIoCx0jKavQKsfK0HFwKW018doiJzDulNIYtDjWe7M2jHM
           yx6AhA8K77qQE7reNpoiqIu+BRAVPXtF8BlYfUr/OfFMuQBvlJZES3uagE2khJawHP
           vxCP4KStBGD5C6iMCfnkGUkIycaIrloFPzHvr9LTLWhPFsSrr3scssTchcMevpUieV
           fPUrwgx95+Clqg92UKqWfIH/xW834Brt4PHxL+lNn06MTaX7VyhbMMrOh9W5AjZhJL
           B4AEqEBgItfLNDRavAOdz2sZ+/GQflK+O9XTVmFBoXwVw0J3wSRb4GPnnSxXVeu+M1
           s1QEaNd7DMD9A==
Received: from localhost (77-236-6-58.static.play.pl [77.236.6.58])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <runyu.xiao@seu.edu.cn>; 29 Sep 2026 20:14:58 +0200
Date: Tue, 29 Sep 2026 20:14:58 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>,
	"John W . Linville" <linville@tuxdriver.com>,
	Zhu Yi <yi.zhu@intel.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] wifi: iwlegacy: 3945: protect sysfs TX power update with
 mutex
Message-ID: <20260929181458.GA17064@wp.pl>
References: <20260929123329.2135878-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929123329.2135878-1-runyu.xiao@seu.edu.cn>
X-WP-MailID: 5a3024da050e293244fd07980ff6c828
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [cSMt]                               

On Tue, Sep 29, 2026 at 08:33:29PM +0800, Runyu Xiao wrote:
> The sysfs tx_power store handler calls il3945_hw_reg_set_txpower(), whose
> command path requires il->mutex to be held. The callback bypasses the mutex
> used by the other 3945 control paths, triggering the lockdep assertion and
> allowing concurrent TX power updates to race with other command or state
> transitions. Serialize the update with the same mutex.
> 
> Fixes: b481de9ca074 ("[IWLWIFI]: add iwlwifi wireless drivers")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index cbaf25062..e8cbc2993 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -3083,10 +3083,13 @@ il3945_store_tx_power(struct device *d, struct device_attribute *attr,
>  	u32 val;
>  
>  	val = simple_strtoul(p, &p, 10);
> -	if (p == buf)
> +	if (p == buf) {
>  		IL_INFO(": %s is not in decimal form.\n", buf);
> -	else
> +	} else {
> +		mutex_lock(&il->mutex);
>  		il3945_hw_reg_set_txpower(il, val);
> +		mutex_unlock(&il->mutex);
> +	}
>  
>  	return count;
>  }
> -- 
> 2.34.1

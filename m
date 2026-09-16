Received: from k29.k3ae2098.use4.send.mailgun.net (k29.k3ae2098.use4.send.mailgun.net [204.220.183.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D83BCD3D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.220.183.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536207; cv=none; b=HUFimBku68gteYmdo+qYXyLZK1yAsboNuz7YFkyRGIVBaMWISmTP+lTwq+DQZmkg21UqL+FidAyHjjH7CJ+hUjxaWGqpC6yt9ldOaI1D+6xXUZnAN3EPwwaDG/rMna7lnUXwaQe/5UHkaj3rMLffb4Obn/AY6wqcZwZBQpGAdlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536207; c=relaxed/simple;
	bh=Oa74gWgM2W4vIl2iw9lcPSh19+09yWW6fQ8K7jFep5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUm+gRE0W8L1TWqQFml/226uczS2w1+Wf7t/ch+LxXAxiHIJlFg7SMLjSS7ZRlsN/kx7S8lKXEfDK9JbyX/OYwsgdWousVhNs52mcqoTUHHND+LgdVsZ3L43zAkMMqPtzTkgZmZzklbACydmWXxMwcTetEBapt129WZdMq/nFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech; spf=pass smtp.mailfrom=equiv.tech; dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b=AL1en92u; arc=none smtp.client-ip=204.220.183.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=equiv.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b="AL1en92u"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt; s=pdk1; t=1789536203; x=1789543403;
 h=In-Reply-To: Content-Type: MIME-Version: References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date: Sender: Sender;
 bh=I6hyPxo8FCyVGDysp76cYsc0WHS4NTTZyCqbaacWvWw=;
 b=AL1en92u+jzi+qHQ5AOaAtDovKtyyn/hRv+U1/sSteUPECDkEFbtZc87IWLVom6Fe7jgSasnXu1lgGHXCtrjLQsvj2KlvWTho02ZeDBgvMpr5vwWZ3f563QdYKd52jgoCEeFI3KhhevoZAMgOCoqDC8SWBOptQxMqhE4vZddS/PXyJ57E6savNLU7/gNbfl/VCaW2Sj2ht7qBfhmxXs0kG7rcooLAEYp96Cwu7fT2J/s3H6llcgaxtIrt/sD25ow0DMvYX40Xy+yB/IC8TjRayBsmFmoHsFrJpMXKNZZNmL0EJpgNxYiEIUEaw3WU67zU/SGpMeBAb4Jn1PeBppFJg==
X-Mailgun-Sid: WyJkYzI5MSIsInN0YWJsZUB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by
 2589aaaac44761cdf43912c5eb2d540323feac9e05ab4e148d1e2df9c36482b4 with SMTP id
 6aaa27cb05bd73190797e3db (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2026 05:23:23 GMT
X-Mailgun-Sending-Ip: 204.220.183.29
Sender: james@equiv.tech
Date: Tue, 15 Sep 2026 22:23:22 -0700
From: James Seo <james@equiv.tech>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (hp-wmi-sensors) Fix use-after-free in
 fungible_show()
Message-ID: <aqonyobyLatFCaBh@equiv.tech>
References: <20260916002926.161595-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916002926.161595-1-meatuni001@gmail.com>

On Wed, Sep 16, 2026 at 05:29:26AM +0500, Muhammad Bilal wrote:
> hp_wmi_update_info() takes state->lock internally and releases it
> before returning, so by the time fungible_show() dereferences
> nsensor->current_state in seq_printf(), no lock is held. Two
> processes reading a sensor's current_state debugfs entry at
> overlapping times (or one reading it while another read of the same
> sensor triggers a refresh) can race: one thread's seq_printf() can
> be part-way through printing the string at the moment another
> thread's call into update_numeric_sensor_from_wobj() frees it with
> devm_kfree() and installs a new pointer, causing a use-after-free
> read.
Thanks for identifying this issue.

> Take state->lock around the read in fungible_show() as well, so it
> can never run concurrently with the free-and-replace in
> update_numeric_sensor_from_wobj().
> 
> Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/hwmon/hp-wmi-sensors.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index 03c684b..55aee16 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -1247,7 +1247,9 @@ static int fungible_show(struct seq_file *seqf, enum hp_wmi_property prop)
>  		break;
>  
>  	case HP_WMI_PROPERTY_CURRENT_STATE:
> +		mutex_lock(&state->lock);
>  		seq_printf(seqf, "%s\n", nsensor->current_state);
> +		mutex_unlock(&state->lock);
>  		break;
>  
>  	case HP_WMI_PROPERTY_UNIT_MODIFIER:
> -- 
> 2.43.0
>
Fine with me.

Acked-by: James Seo <james@equiv.tech>

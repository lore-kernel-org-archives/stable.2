Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5B35B657
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790393205; cv=none; b=SllHhASfsB9gJX4MMX2hMLN0rJPmm6/erbV0xHbU5qbOnRMklZFB8tdC61NEamSKXCryWfRurFSjwEu9dfJMOAK0UF9G4rbuUBAZOSrWiAHY+ytzda+gbve+u4B58mlO1Dn6MfGjArS89nxIkALc0e7NBfFha8TQf5njpGdJtq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790393205; c=relaxed/simple;
	bh=EMq+CT5k7M/Cu8J/DMy0Hw6p7g2pRBF7OkWnLRHY0Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnLttA6YVMO80+lAu9P59ofO9zSukCxyYZA0JZoCPGEY6KChiSSJ8wsRZ50kRXd17OUcXpaK6wmn0Gv23+hrkSfA6RJN7tXZMQWt0V6T0gBK/dJl/e0N8s/s/+PDuEUwAWBGa6ItyICK2/PCYSirbm/HwmVcwzLeOu/yavFDKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK5lG8g9; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK5lG8g9"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so903673a91.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790393203; x=1790998003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AUTbzwoy7+m0eppodGhDizq5Z+d7wwUlGieKv0/AF08=;
        b=eK5lG8g9qAAsoDEXz/ICcJ9Ws0d6lFKZjFwE3B+kKy+1KwcQAYQLPUjhlp3Aut/DoA
         KTk5B87U0lxbK8Hbw4hSQymy+5CJ4fyn8UlkTexcibCB1eH2XsGx0uucOqWcunZOqVN0
         /VFg9NTP83oTvjA+agT/P5opVt+oSmhbaF4pOfPO8QGfKnk5i2MJI4bYflWIHn3924ug
         JGSL7re8+OTa9fdRg/aAqGnWLm19WD5UJRXAH7LyuhFqDlpU1qNe/P8gkme7IvSyuZ4H
         rYeToZzt8K44c5/bkCH4HiUmq2BYfuxPFyKToubc7gp+SPOJL01Ij6D+p+EhgtSgbiVl
         rD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790393203; x=1790998003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUTbzwoy7+m0eppodGhDizq5Z+d7wwUlGieKv0/AF08=;
        b=Bz/l4JZVdhnJLnvz7otwsF01GRF8DuN/vr/OMB5uJUB/d93Myy1aIXWT4gtfbhzbcL
         yRbGCBxweCqJMpbg0FZkYvJPATEojkcrr9jsGBTrT4hdUrfV2lUuyl/N+eDAwCx2rTeV
         a3+AlDQ9DfmHwCqGDs57+oJPyN0KzpdRVA3XLaRMfjzWSdb82+clWh/C2g2zFL3OjHOT
         EP5ClH8UCd3/kvHyj94ia6gzvtUsfCipdX8TBQ3WpmezKllL1/zpAX+eFrjRFf/gfkMs
         fuwFa6AZ3/L9GOmPtI6QQNYwQH4yXo0g4VWF0YEJDbSHmBey83XeemRkeJaww4YWEULB
         yfQg==
X-Forwarded-Encrypted: i=1; AKwUvByaM5/Jca/a0lpmURBImlR33O7CY9JUbb/vPdD9udOerW7R8waL4mtbabf3xpsL82VAnRzgEfE=@vger.kernel.org
X-Gm-Message-State: AFuF++lp+ChqhM505/llXUXMWzOeoY788+j+D1DVnSQSqh6VNetWXUjx
	ly29sZ62PdlgMpBJBDGA+j297C+e3LPXmER3BAA2jC52aH4VOSDLAS9a
X-Gm-Gg: AYBFou2qMhTBMcxFcEbP4RkR/F+GSJbhPV5j7Ji9VrGpXEn3Wu7WSh8cI/Fs/F6h8GE
	rH7eu/yCxIxghqBNy9DW/voESzNyjzWoDK7BC0dFY/m01LbntN4IMVPgy26eT1kJjJBLKxieAV2
	fGGVXSfmE9cg1IeOb104SSolDSItMcO/9hAz/bfHX6d82yQMF7dCWggbJ9vWwk6KKx0ySrSlSPB
	v1I9e5Stqtm4bF7VA6KuZb7G4fCqJOclhETuOFzOuWGmiPWu+/+Ayu96HasaotG4R+7fQY+D+wr
	aSH9iJqPoHGep0KbzweQXW6dnoolgGF1VhtyaIBkclJhzR7S8chutLWja4atFL7L0xpC1xgcknP
	yWgcbl++nhZ+Kue97ZQyh59mWdIDxn1Fq1/MBpEBk3g4RyhirDM27+xWJcBZXy1HYHzAsX9E+iR
	OqILYNqH7AsNV9Ku4OGDCm27DvE+4lKC+LDEH8cD4PF3muEcHmilIOY0hoie7O/Zods7Nm3+OKj
	lXWfy0fctUFaJ69HLi/m80=
X-Received: by 2002:a17:90a:e7ce:b0:3a0:2662:815a with SMTP id 98e67ed59e1d1-3a098db8c10mr7151512a91.43.1790393203358;
        Fri, 25 Sep 2026 20:26:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773e7c3sm13617688a91.17.2026.09.25.20.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 20:26:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 25 Sep 2026 20:26:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tom Verdonck <tom.verdonck@inspiral.be>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, John Muir <john@jmuir.com>
Subject: Re: [PATCH 2/3] hwmon: (tmp108) Fix jiffies wraparound in
 conversion-ready check
Message-ID: <1771fa8b-7b5b-4bf3-a7f9-ef1db4e080c1@roeck-us.net>
References: <cover.1790358356.git.tom.verdonck@inspiral.be>
 <525fa49d8c50922344fa53e22be5e6133c9bbb62.1790358356.git.tom.verdonck@inspiral.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525fa49d8c50922344fa53e22be5e6133c9bbb62.1790358356.git.tom.verdonck@inspiral.be>

On Fri, Sep 25, 2026 at 08:23:23PM +0200, Tom Verdonck wrote:
> tmp108 records a one-shot deadline in ->ready_time at probe (and resume)
> and, on every temperature read, refuses the read with -EAGAIN while
> time_before(jiffies, ready_time) is true, in order to skip the initial
> conversion.
> 
> ->ready_time is an unsigned long compared with time_before(), whose
> signed difference is only meaningful while the two values are within
> LONG_MAX jiffies of each other. Because ->ready_time is set once and
> never refreshed, jiffies keeps advancing away from it, and after 2^31
> jiffies the difference flips sign. On a 32-bit HZ=100 kernel that
> happens ~248.5 days after boot: time_before() then permanently reports
> "not ready" and the driver returns -EAGAIN on every read, without ever
> touching the sensor, until the next reboot. The continuous-mode path,
> which sets ->ready_time to jiffies with no added conversion delay, wraps
> the same way.
> 
> Store the deadline as a 64-bit jiffies value and compare it with
> get_jiffies_64()/time_before64(), which does not wrap in any practical
> uptime.
> 
> Fixes: 66e1c9171339 ("hwmon: Add Texas Instruments TMP108 temperature sensor driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>

Applied.

Thanks,
Guenter

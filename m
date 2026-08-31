Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C7397925
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154155; cv=none; b=seNF6qW1i/r3p6vK0+jOk4D42ya3LGAkbVd2WZzTjYMS/tyDg245jmeHmxyMxgau26QMXbM2zOeE2N0eF2AsVv05A3X1k6sPyMvyhtp7Zr14BuToUaV78A5yzF4CSgY3Rfs2I512PBQuNO3Xzhhp9S/d1dL0x8TM1Mv5gtgz+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154155; c=relaxed/simple;
	bh=f5j4hIxopVe9dqBkAdMBlPfS2+vnW55+OaBP5zbinTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBn0PUFO4LtXjHZ7pvW2nhZlFDQUVptcuFEpXVYeo3iDYZnXbqQJhnOZkn4qFKHSTa4vQdUy1j9K1/wFK78f9joyEpeH8qhay28qExBydZK6kJMHnaJYa/n0gKo2vDuQkuuBRuxlqK7dfqzQ38yec9+8PunbzSofFUo2kRaILQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqKFnQMD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqKFnQMD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d7195706f1so29587555ad.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788154152; x=1788758952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QEL2VbN1y+PU3YvPygq8npMdJ9wl/ZS6P++bwrOJdII=;
        b=RqKFnQMDBUrLFAC7LXTLhcu3boVbGASnB56TGQ8Pi653msxocylrVrJ11MQM/H2jIE
         VA0Kt6EfCltuKGvT2J6grNW3eJW9qKTiXmw/Bc3N60hjZeHNYxzZHnq35Oj0zK7ZToQt
         LGMFYLBsuRurwbiK0FgwFLU+orCTZ6hr/MHOnKz3Ifgl48EMMwwR/x19YgO7VkaltHG/
         Orwvvb7ywp1Iv1Zj4TqV4Zlp0w+yo/eTF2Yme9/Nylf85O272pEKp1RENbU/d7GtsRAn
         eiW2lZvu4s8jcHoRm9GtW2bY3JgIpXAkwLOY3IbmDlGmBtsga1YaG/WtVTFgP40Z+fSj
         rRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154152; x=1788758952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEL2VbN1y+PU3YvPygq8npMdJ9wl/ZS6P++bwrOJdII=;
        b=o3yg0Ex8tUYQBtDVCHerxMfrA3E64Ud2viYRzg5O5ynXBexSSgr4543BFIcW7liqey
         KeetOyrnv8HeqeAFtMA0Y3trqeXVebCMxiKaXCD3PASDFE5yryNgRt2P1hrFxPJCCvxK
         8nTuWlI1ZpDDWOODRlgofxklzr4t9gesP1Dp+Ok55XmwlhzmiD9igWQUuWI/x36HMJvY
         UVUPnkshc/myyWLC6lsFOnqeT+o+nRrKeXMtTwvzbPNByt8FrtkTtl7XVXQj097bXTxR
         G1lw1yFVpavOKl7/JpyjUy3I5Az495vWtRsIo52+ezpfoYMEAuRgTSPFRmwsYOuCdBLl
         tp9w==
X-Forwarded-Encrypted: i=1; AHgh+RrZ9f4s/diFYvLMPB2cTF9LA+Qbyn/+UxUjSVdE0JKckurUWZrfUrPF1gBJjK1aoXCv+4mizHo=@vger.kernel.org
X-Gm-Message-State: AFuF++kDL0aaW1eV0jik2vP3lTXpAFb7IY7UQjwfGpMsKoyD0Lyk0Nh/
	0+wD5GRa+ZbMZl3/Llq4wulbSwH5dGeBvPqD0KUrZQq9DASrXgFNOfspQFHDmWlH/DQ=
X-Gm-Gg: AR+sD12Kcba0DD1NXNUUw1CEDPlsYdTOfMUC/XPd2oYEDzVyGD1qkJQYAqQKqVLZ77V
	ymcvToiUVAsSzO4E89qhqp5mitYDQKiMUewBh0ODnKTld7HbFL131rpBS1zwTmnJuyDcBIisUGQ
	Fc2r49FNCHDfiOH0Ok7OGBJWJs9uPjMRQ/y5P0MJMD0h1URJckdu/NuGLmXSmr8BnyzkELcGR10
	yt/0xtTew9lbvCqU6fk3qpopUobqT801aUSuPflIgZetGOrYSX36uE/sy3/D6CcP/1P6tByKgbW
	EvdaTuERZ02NANkJDtNdXz/4galAptlDB7jQh2UpOZhK8RSGShC5iinnjUtjPAsEQdr2zbw0LjE
	rm19TdEqEtmHUU6YnANyoLDMczKfwzMR2vFTMCckXZ2E7mXknAnY2ojLM59UkJ91oLTrOaHuwmv
	Hvv8UG/RAtD/xKuBtJv1vfna9+erdql9/d2HI/9ox7fFrmDoGI/jVaybUCXYu6u58=
X-Received: by 2002:a17:903:11c9:b0:2d8:d4cc:be62 with SMTP id d9443c01a7336-2d93fa24005mr12660775ad.15.1788154152024;
        Sun, 30 Aug 2026 22:29:12 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b5bef7683sm12379462eec.12.2026.08.30.22.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:29:11 -0700 (PDT)
Date: Mon, 31 Aug 2026 10:59:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: initialize policy rwsem before sysfs publication
Message-ID: <apURJD6v92pMNKbJ@vireshk-B250M-D3H>
References: <20260830155301.2713780-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830155301.2713780-1-runyu.xiao@seu.edu.cn>

On 30-08-26, 23:53, Runyu Xiao wrote:
> cpufreq_policy_alloc() initializes policy->rwsem after
> kobject_init_and_add() has created the policy sysfs directory and its
> default attributes. A sysfs access can therefore reach a policy callback
> before the semaphore has been initialized.
> 
> Initialize policy->rwsem before publishing the policy kobject so sysfs
> callbacks always see an initialized semaphore.
> 
> Fixes: ad7722dab729 ("cpufreq: create per policy rwsem instead of per CPU cpu_policy_rwsem")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

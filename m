Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B610356775
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252773; cv=none; b=oiKroMOz23tatQvGfuGl17F4qbMyKV6oz0LLVXFdsDHcWbrGmuDganO4q1DptOEQflv/2f8BnYoNejeolGs/xasZxwBZNbyiqHs6DrY/EQ92Uk/79TA++hdru7A1VgDNrajt/ydhPPrUb0bStRdgnLLjHTGuID3g6wYdTu/XluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252773; c=relaxed/simple;
	bh=yunkd6Bn6c/Mt2Vp7v8ZZtH4GNK+T67PIaiWUEUNy+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf1RL1ZMZMq8l1kpe4Qs9wxJC1LaCd/tmHdXgzEXBekohGI8X4tVKFCQieXsbmASaIvMdTlLfbvYJ5MT0uIfkHZRgPTvaqY2qGL3UsenWxf1qlZTAdi574l6iGUiRDUR5wi6trXU9anAnM9giefFVSgq7cwkbDpGZxxyFQAzqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=AK/4S+RG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="AK/4S+RG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46013161068so316238f8f.2
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 01:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781252767; x=1781857567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kk7PFzycgY3eDC9P54eIgjAqx/pkRN2cuIOJlvdAVik=;
        b=AK/4S+RGVPvvD6YWyYzAi/N2n90VGDFTltZujqfDN1BvwuTNxeD79Oa0q90j6/nat9
         ZrSgiF0Px1r3b5GZTjRx90q84gGsZqHYclluWDW3TPGKY1sIQ2nkiwY8j/Knj0bclHsq
         UDGGc1DYdghSf59vKZb9NrOWdIcadigcyi6chhGee0zWiJp8mzNDcBdI2s8BqwJuKnYB
         K6gA/87aFKE+vEepg0o6q+5mCxgXMm0+2uC+TrohSWmFMPaoAcunHt1qQUFS6jbTMj7y
         2ffQ91CfNkjUuvQeiaiRm+LN1kDqeTU0VxNnIj0bvLYCVwl3jnW8EomGiNuSJMyT6mmA
         Bo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252767; x=1781857567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk7PFzycgY3eDC9P54eIgjAqx/pkRN2cuIOJlvdAVik=;
        b=owI/zpayAILi4rOPB5gAiV2myMvFiNDnqJtWaxn+H+NJ7BnVcY6Uln0sbKBK3J/7Al
         HZ7Ee2Iil3UlKZ/KmhL8CAec+hhyHv61/5KovY705dQSKgJfoJ+senlVIYanIp4ScHYP
         AOamwAywg3XBXuNlnheKYLRpB6mHWRMTFLh32EHsl2JE8R08ZGxn7Goyz2AeipBwqCje
         gTSQEZ8GCHfmYywWKz/dBBV2HH9/0HcfGjn+xjeKUe6v6CyorE8kqdkuPX1bGuV3HEUU
         GaMTwzsxlAVw7j2NbFfMSwx8yCcg8dC0s5ZHLIH3uNDzJx4fePzhAV0NY3nPmGTwOjct
         yIqw==
X-Forwarded-Encrypted: i=1; AFNElJ887GSoc2XDL43AxuBEfaVQISj3oH1vCvCE0+i7wexUbKc2IWwwEW1h0DAJhXU192rMkwFdlB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhfzbm3OSOpu21BMvYr3dcdS60knTcP1svuvufOClwgJOXnpGV
	WV2i+ITECLr/mRFd8hMwNp3qJKg2fkidDtqBSQ3nmc38kmpd/LTcF1vuyRFbKqAk+tc=
X-Gm-Gg: Acq92OHd3roN/cSRccYevRIrKbGNxDHT0J2uV2AQUuu+1TpiRVbGuR/BlG938vPEJhs
	Tsdx2rwTazBWkhgcmAgynIE+enRzOJShokZKntIQyBQIx5KIGfcM1sIvF3mvF7XU1nBP+YKZK1G
	fWgzVa/47GtlBiYB8K6QrJWjI+pFB4uPmOrl73lU+8w7ItjlMKyeizHMQ3ChA4TfJRhapI0hJKE
	Cha9eJU0XiVZWi7j8i+ME7lTpoVZL3C4IUwIMTcYNVhv2saaH0LhKsy5rrLyivMU9rMdjwOgOLl
	HndpWCa08TEx7i1783RxcZLzkCxEmfwBiZoRNOTBnQz0y1uxJ6BIZcqQdwocr3Sc7tJkzR0DTkZ
	v5AjSDmI4XjTaSghJHN55dO0d2YsYuf9o9A5r9ybnQky9O3k808jBjYm6Ivg2yNGx11nO1oBxGJ
	IKsbZwJNcfsw0O2Uf2RN1eifZ+2BnuMG8=
X-Received: by 2002:a05:6000:2087:b0:45f:f142:d569 with SMTP id ffacd0b85a97d-4606db8dd7fmr2332029f8f.15.1781252766905;
        Fri, 12 Jun 2026 01:26:06 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3fcfsm3525465f8f.26.2026.06.12.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:26:06 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:26:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] devlink: fix refcount leak in devlink_nl_reload_doit()
Message-ID: <aivCLGzQHYTFPcey@FV6GYCPJ69>
References: <20260611162557.98150-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611162557.98150-1-vulab@iscas.ac.cn>

Thu, Jun 11, 2026 at 06:25:57PM +0200, vulab@iscas.ac.cn wrote:
>When devlink_nl_reload_doit() is asked to change network namespace
>(via DEVLINK_ATTR_NETNS_*) but the reload action is not
>DEVLINK_RELOAD_ACTION_DRIVER_REINIT, it calls devlink_netns_get()
>which acquires a reference on the destination net namespace. Then,
>after detecting that namespace change is only supported for reinit
>action, it returns -EOPNOTSUPP without releasing the reference, thus
>leaking the net namespace.
>
>Fix the leak by releasing the reference with put_net() before
>returning the error, for example by adding it directly on that error
>path. A cleaner alternative is to introduce a common cleanup label
>that performs the put_net() if the pointer is non-NULL.

This para is very odd. Your AI is probably providing you 2 alternatives.
Please adjust. Fix looks fine to me as is.


>
>Cc: stable@vger.kernel.org

No need to cc that, afaik.


>Fixes: 2edd92570441 ("devlink: don't allow to change net namespace for FW_ACTIVATE reload action")
>Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
>---
> net/devlink/dev.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/devlink/dev.c b/net/devlink/dev.c
>index 57b2b8f03543..fd5633fa88ec 100644
>--- a/net/devlink/dev.c
>+++ b/net/devlink/dev.c
>@@ -578,6 +578,7 @@ int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
> 		    action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
> 			NL_SET_ERR_MSG_MOD(info->extack,
> 					   "Changing namespace is only supported for reinit action");
>+			put_net(dest_net);
> 			return -EOPNOTSUPP;
> 		}
> 	}
>-- 
>2.50.1 (Apple Git-155)
>

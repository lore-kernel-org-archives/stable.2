Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416A3911CA
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348653; cv=none; b=b0qaIQefm7od3l7S3QNl97i5fM876+2TajYNy1nTMgEZPNWaF35LKILQZ9PV69VA38XODEsUtSt7ipyaup0jD4hwRMNog86Jnbf19exNacTV09LxBL4vfa6mEBW0uu2p5/EcrNvuat25lYMzLel+YH0yC3mPLep0+6UhMMkKi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348653; c=relaxed/simple;
	bh=Q+/ssEHzlQooBUf9Jokz3i6r7X6BdwTkGLYLXKCuspQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bykzdNCVVmyZwZ9uVDQYF5ozzeDjMpd22nz21wYRKmpUlGVE3Gu4kWT5wMAICwQK5r9/IOxhpYCHiZcC12m9f4uG98FpZ2qyVri3D8dTpBLl1wrXOaAXBVZoCoaXBGV126TWfB/QuWy1MVdmjwDSpbdrbhxeai0sAPktfRMrtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl8OiWAd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+QOYfQl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl8OiWAd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+QOYfQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786348650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faSl/UkvZhLeViesyQBAMKjmyR5NNeTyZ1tUwhC4yBU=;
	b=hl8OiWAdea8+i7CvrmQPrc4koWzz2ksDH4OZ+XqfEH/9GYNC6JmHXIYCx7uFTnZbGH3Oa4
	J4ZfcWp+CbCQ2pLTmccZHf+PBvoEAAHYKnHJElYlhnioY+2yzVbGAziHN1cpjpsfgwTuBC
	Udne/Z1Sjy93xoOGb9TKWXI7CeInbr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-69BfpokAN2uwYdhThg4yng-1; Mon, 10 Aug 2026 03:57:29 -0400
X-MC-Unique: 69BfpokAN2uwYdhThg4yng-1
X-Mimecast-MFC-AGG-ID: 69BfpokAN2uwYdhThg4yng_1786348648
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f7039fa59so1459944f8f.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786348648; x=1786953448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=faSl/UkvZhLeViesyQBAMKjmyR5NNeTyZ1tUwhC4yBU=;
        b=Y+QOYfQlxkT+6VEnP2akMUWJT5x7bPL1uhmFAZFmjOtSmKV7vfO38UceaNTgwEdqRn
         9nVsPKgGBavcawksjtpFs0inrP7YGG0wQfbxb3Ax+9GwR/n1QOJCpxVV7hBr8C8RfC/u
         XuGE6661Unrz1AeplXCu6Wmmrp8hj9DYI5ywiWVpOmjzcjMyTXtt+52HaFWncBlKD+AB
         pPLZhUJlgBY+TDDqrc+v3TW5ylIhZYeroVAJciq9FulM6Mhs6rZxDdIQarGogA0F+8NQ
         JVTi62li/GcUmWLNrCxTxVZXlHCEpj8WeLFW30l1L8D7aTc2o16ZOOEAJmfMKZCplShI
         pRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786348648; x=1786953448;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faSl/UkvZhLeViesyQBAMKjmyR5NNeTyZ1tUwhC4yBU=;
        b=kasBtIcXU943Q8QIgYgVXMZhzue3//28/RBt6/OTT6fuvYRbghNTA5lVKGdZb5CCV6
         nyo67e0XRWPTD8DAmxK6Sbtl2+RO/xsuMabhcxX6S3SDDsMkqxBSYODJYahEFMZwM1yV
         daf34q1si/JlJJtnz5TL0gphPuVUtv7ENfZTtuApa4dc9QwL52QFoXo9lNXBhaI8y0RF
         PqAyKlzjywdeWU8xh3lP5405Z7HHlnbMYM1d7qEuu2jFgMMEkac2BBy7BTf4PYhqimQ/
         yFW9kP+RJJyl3ieymhuraEset23JCTozk3+LUzTxQb0NLSjGZ3jnBq+Ehz3o1QpbrTpy
         cUMg==
X-Forwarded-Encrypted: i=1; AHgh+RqVrhzdId0ABilqXkGfLSna3bB49pTv8qMsMkEFdMyoq8hXvUmsIonzNaDGreSPz5nspIKIZxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6KuywdBHXtNoJNzbPcjxGz4oKxEPd8l3o18mfR0sjV5/XA/XO
	5eEYmOW9o89fMEBchSIoMVT0n4gyA6mgomNVe5OKd4DSKHrjwniaIQW8cEYPri0aSQp8Ulyia4c
	08rQ+XaZQle3XPztCNF2oUXECtPOaeFRcQlOAX61ijNGfCFQgxeupjLz7Nw==
X-Gm-Gg: AR+sD11wteXD0Ia5N0k5zveyun976/QpWkxZprHjNr4zdfBb0HrQdK61uN6tFdElDI3
	2LD7B8uLzaZrkn5rAKFbNFaeBs6j0VerNNJJNZSWb6NVVWc06RrKUWxhql5H4/NaWUQXZxjpxZi
	biAqMkHp3e3ZXCf2hfBBqNmiKf5WoRS1fOetQv6x6Sru3CzXaLwelnO4twyZPvZz+7OaACPUgLY
	6qOf6ymadFtY9QISybBQVeb2K9MeIxDHaXgLygsXrx3iI0Bv8JALwc0ZoqO+EFPT/g2VhNcBzhb
	iahUPQZOkkfbdGTTHqbmIBK1Ox584RNhQGNhqM/6Se/7Q73s0JQx/J4wKYJrCxTFs13EuIUTGVE
	=
X-Received: by 2002:a05:6000:2988:20b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-47fec4e2975mr52858449f8f.4.1786348647961;
        Mon, 10 Aug 2026 00:57:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2988:20b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-47fec4e2975mr52858392f8f.4.1786348647534;
        Mon, 10 Aug 2026 00:57:27 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506c0sm29711749f8f.11.2026.08.10.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:57:26 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:57:26 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on
 a->goto_chain
Message-ID: <anmEZqiY_XEdzR_T@dcaratti.users.ipa.redhat.com>
References: <20260809090928.868186-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809090928.868186-1-jhs@mojatatu.com>

On Sun, Aug 09, 2026 at 05:09:28AM -0400, Jamal Hadi Salim wrote:
> tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
> rcu_access_pointer(a->goto_chain) and then calling
> tcf_action_goto_chain_exec(), which does a second, independent
> rcu_dereference_bh(a->goto_chain) read and immediately dereferences
> chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the gact
> replace path) can clear a->goto_chain between the two reads, so the second
> read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.
> 
> Fix the race by doing a single rcu_dereference_bh() read of a->goto_chain
> in tcf_action_exec(), checking it once for NULL, and passing the resulting
> chain pointer into tcf_action_goto_chain_exec(). This turns the split
> check/use into a single check/use on one value.
> 
> Fixes: ee3bbfe806cd ("net/sched: let actions use RCU to access 'goto_chain'")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[...]

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

Thanks!

-- 
davide


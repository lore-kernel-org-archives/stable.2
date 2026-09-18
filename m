Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B334D6C25;
	Fri, 18 Sep 2026 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719418; cv=none; b=ekpy6NWL5ml9zqg7yxInZbRaiRNRw1/h0ZKrN/neU7HrvOg09nAIe7qptMp1Qn0WxBi7/BjQqlZei2fXFsXYto4sOUPD+264KT2O+t68DgFzV9U2NzrFZV/8dX+/0Jo4vNk73BjKYToaRlb7eo9mI926txsP20hEm2MppowfiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719418; c=relaxed/simple;
	bh=P9OsT0qg2bzapua/ITt/JbIf1GVB4FVSgwGYiBUmvrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiQA1pd2ZJMRV5YOwbpv7jT/SVJ8q2FJm/OALSLiKlGtTpNfRp7uM2btEnx7bFOQ9x+gR+ox3h77a9vAjxeqarv6vSHPqpIrTkIoj/i726jqiOnhUg0HDEN2rCFR7ADCL7SX9Z7mVvyP9yEViM5Tjwlgza34O6NC6oxdGN54QQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k0wqgh4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0wqgh4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE13A1F000FF;
	Fri, 18 Sep 2026 08:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789719415;
	bh=1qj0EBYA8l4HCnpjpYt+rm0XiHjkojJ2TD79yOIJm/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k0wqgh4oEX+eSdEIjfY9kuvUaAyB+bn1dqiP+KFP6EqTizikpKEw9h1hJEsw4Fnjd
	 foL8FS2NX9bsnQKxwetZakVsV+5eccTs6cWb8S+TZt7OPw+pozrozYvGdrl/fsnal9
	 xnPBfidEzbZ+neqb6CsTdVkkv7XOG5f0IIFOt3Yc=
Date: Fri, 18 Sep 2026 09:14:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adarsh Das <adarshdas950@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, driver-core@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] kobject: fix uevent socket use-after-free on net
 namespace delete
Message-ID: <2026091807-coma-unraveled-a65f@gregkh>
References: <2026091732-armored-lilac-fec9@gregkh>
 <20260918060826.8434-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918060826.8434-1-adarshdas950@gmail.com>

On Fri, Sep 18, 2026 at 11:38:26AM +0530, Adarsh Das wrote:
> @@ -804,14 +810,19 @@ static int uevent_net_init(struct net *net)
>  
>  static void uevent_net_exit(struct net *net)
>  {
> -	struct uevent_sock *ue_sk = net->uevent_sock;
> +	struct uevent_sock *ue_sk;
>  
> -	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> -		mutex_lock(&uevent_sock_mutex);
> -		list_del(&ue_sk->list);
> -		mutex_unlock(&uevent_sock_mutex);
> +	{
> +		guard(mutex)(&uevent_sock_mutex);

LLMs don't know how to use these correctly, shouldn't this just be a
scoped_guard()?  No extra {} like that please, it's not normal kernel
coding style at all.

thanks,

greg k-h

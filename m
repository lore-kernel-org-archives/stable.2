Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.14.14.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191772;
	b=sVq5bKWv9668TqTouyzenQlRYuXo2o1htK0d0+dWOScKLgNen6qe7ZUTv7DosKFmWuDw
	 SdjAu3N7zp2S36vdrzCdjGBNDqv+FieKrkBrN5orhDf/Ve4PJJINqudbfE5mXzRerW4DY
	 J3/S4pUM502d72Pn9YfX0/kYvmDPczbUc0syJzK3UYTDyFJ57TFrsUaMTjFhD3nZyDZUQ
	 vHtpP2Axri4dejPYy/hNXY5BblQAZK99YA/ofFRfErAUsXUr4hevX9EMHBegcaRfjZgwz
	 /jJuZ3VHStGT6nBPMOd/a2OxlPVIFsfwmDOK0vcUC3z1O8s8yU3rhFrfNa2WKVZysPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191772;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=bs8xnKXxBBHbGpU3xbc6laooSZSBeaegD7Ow6zNQ+KE=;
	b=Win5Ykbc6m9uNTEQmsaNT8m662kZDfiDoDnAjV4WdS3s5fEBa4C/clAiT50WEbXhJ/X3
	 0WIuACazpBk8SbkhCNaqlOm4XOAXzkSTZpHAbGaske10VVKslRNmoeRhDANSZjvpotdIZ
	 53pVWY+ah1PQblwkCjpZs99C3SnjpCS+t1ujKYlGePZ0/zvgjKGyp+yZO3PNE0VSGXWYN
	 m40eFrhA/HE4lg+/AwDJZIDQeL33joPt8A8O7kC1DgmyeMnTDgXkqOPLRFLjCyJ5dqidT
	 GW9ShFdCxL061OPqR4TGtEH1h9yHg2WhalyJIQC9JLiMuk3XXAKZj9WP4nbpIgddIVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=taladin.ro;
	spf=pass smtp.mailfrom=taladin.ro;
	dkim=pass header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b="n33/mKtt";
	arc=none smtp.remote-ip=31.14.14.46
Received: from taladin.ro (unknown [31.14.14.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E18606A320;
	Fri, 20 Nov 2026 16:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E18606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=n33/mKtt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bs8xnKXxBBHbGpU3xbc6laooSZSBeaegD7Ow6zNQ+KE=; b=n33/mKttm+rApyV6t22KmflZ9I
	nknmQC/hS4cAe5Pj2572eJzhXuiKaxEydLHZwC8+TcX8tB4oKfM59EY/vv4T7sz/4JVZfWxh5VjgL
	X5O0fCDqRWv6UzCvb/HYqUBda/4jFH4Dg44tgatqizV+yIak0j6XGXZy9QddyAvw+XoGJoEjjNgcZ
	XujXr3laa69oGkgEASOCs67b04McxZTBNpRSS/ylEiriXvCQSWhDJnvAtzaiawIZUQ0cqu0mBhfF2
	ghUC7rqS6oq7gaEyJe7ChCJfNfGd65M1P5K7YezNUpcIiX101DwbKPPHg1pha7B8QNLxa9v3EpxDz
	Tz+NnuDA==;
Received: from [::1] (port=43858 helo=cloud607.c-f.ro)
	by cloud607.c-f.ro with esmtpa (Exim 4.100.1)
	(envelope-from <aardelean@taladin.ro>)
	id 1xURNn-00000002JV6-3YM0;
	Fri, 20 Nov 2026 18:22:41 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 20 Nov 2026 18:22:40 +0200
From: aardelean@taladin.ro
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
 hubert.wisniewski.25632@gmail.com, b-liu@ti.com
Subject: Re: [PATCH] usb: musb: gadget: mask the MUSB IRQ while complete()
 runs
In-Reply-To: <2026112008-dean-crabbing-a331@gregkh>
References: <20261118115435.49748-1-aardelean@taladin.ro>
 <2026112008-dean-crabbing-a331@gregkh>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <ad232a7458badaf3a6f0ece3020661e9@taladin.ro>
X-Sender: aardelean@taladin.ro
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud607.c-f.ro
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - taladin.ro
X-Get-Message-Sender-Via: cloud607.c-f.ro: authenticated_id: aardelean@taladin.ro
X-Authenticated-Sender: cloud607.c-f.ro: aardelean@taladin.ro
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-20 16:07, Greg KH wrote:
> On Wed, Nov 18, 2026 at 01:54:35PM +0200, Alexandru Ardelean wrote:
>> This patch is 2-part (in one).
> 
> What does that mean?
> 
>> It reverts commit 3fc137386c46 ("usb: musb: Fix hardware lockup on 
>> first
>> Rx endpoint request") and implements the second possible fix suggested
>> in that commit.
> 
> Please no, make this a patch series.
> 
>> Reverting that commit alone would bring back CVE-2024-56687 which it
>> addresses.
> 
> That's fine, that way that CVE will get automatically rejected and a 
> new
> one will happen for this fix if it needs it.

Oh
Good to know.
Was not sure how the whole CVE mechanism happens.

I was hung-up on the old mantra of "each patch should be atomic and each 
atomic patch should not anything".

Will re-spin into a series.

Thanks :)
Alex

> 
> thanks,
> 
> greg k-h

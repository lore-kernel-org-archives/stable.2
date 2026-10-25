Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941424;
	b=bXZJzFcZqzLt0ztbh5Iywo7qhlWIVWyB1ijKyxrYZdwVlp/TRgLYpZw/D/lci2P/VXpt
	 Q04Ov/mTTZ1JoxCZOIDZMB2iwawK9etHZCmUc/nF0m4aEbO3Dv0ZafS+rylsC5BP5OftF
	 BF6o4DTiVgMStmSwWLfbFXoXxsyA6nkIypYKNZpG0xVBx2IYdFICyXw+T+u/2+juCRiQa
	 Zc3Zzj3fmZKcnvz3QqKgclo7t71J5/2dCyC1UNquU6DsmQfiIL/mHGB3gQer4geJGJPK2
	 WY6CaIHY1S7VCekXPWjcLB8yKZviOjNDan8WYbcIUd2OyIlm2x7TnVbqmpfV15lwpEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xuT4b3Ogd1sn4kTuluW41732TPOf5pb8loXXUU48qds=;
	b=deePRg+xEypBDgxySFwi5elgfnbIye1Wsm882VWO5XF9lYdeiOgyeOR6sddb0z3Czb33
	 M05QnzSyM1LalSsukiicsW3+CLveyuOrV6RUkHJIdCGW8u1RL5s8h6q8ksNCvflEQQaAu
	 RWHMB5VYy/6/6rGaIyO5NTIrt7wWSbZtmdefm3cJtBje3R7pXZIBJx7JFTSk3xgq6E36o
	 Om6RQDu8idjclZAt2tcHsaYJjS9MunNXy10EZ0QlOTZ98H2DE80dwxEnqchzwCYdiYKCK
	 U69VnyZGuEhEgbzIlL86lufhJ98rY3fdA+RKoOfVL0je8c6m1qk+2LFtCNMGfdSUvdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=bkhX3K5F;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36376606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 15:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36376606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=bkhX3K5F
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e64d52949so189981985a.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792941423; x=1793546223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xuT4b3Ogd1sn4kTuluW41732TPOf5pb8loXXUU48qds=;
        b=bkhX3K5FjsQrft3v3hXQxqYDsSuQznzyGasYeLiPw0fXaiqj12taMq35qXL7NI3cSN
         hlUm/LZwUyjwX15zW7w1wiPTx/xepHFLqWLtyfKSkFVURXGjuSKFvD+X3/PFa2jDRbDt
         50mBJi6EsGzn1/LladRetekFy9+VqpXAkcM5Qq9jHW/fPD3Q4BP0Gadx/TUvpolO+nKC
         UDAF1qWTxf2i0dAymEkgXv1NCb7sboO4Te4RaWSatHa68p4ishuL2T4OlCQ/1554Tm8P
         zGaFI1XMkYnTGilMixj1aDMxKxUv09uJwzo3/gL3OgH+ZHMU6x5NffvYICXeok2Bqyc3
         vY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792941423; x=1793546223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuT4b3Ogd1sn4kTuluW41732TPOf5pb8loXXUU48qds=;
        b=iCdIeUhF3Wl5zR2fbdSX46O5MljKdIiPg09Tb7aSPCGoV49ncu6klMnLXly8JYy7FA
         /OP+x8rvohGLI7m2S6hG0BVACL9qQeD2dDI+sYUlNAx6myj4ULA4ByCV+xPGvvpsYfVl
         al4Uy4MmHsF8XvTC8EPsmpRQSMx7pQDDT+N4OEpEaEh6EiAqIy067xIKgEVyZTGxa29i
         35BCw1aN8ISZ+XGSCzBDOkWjmDM5FyuOde2hpX2LCPbqAdXQ6SVsBrtcipewzUR22sue
         jv4UHW5jbj6xab/ZtIeVUzU9ShgZe6YLF9FdPrLLbhO3FW8bASq0IWPWgHlL89alXREG
         MLTA==
X-Forwarded-Encrypted: i=1; AKwUvByFpA/xYkwauIbAE7xhfh2fNLVk/EVza3EggNlPPX6cv00eY3XIBw9UVeB6baQZlZz2/l8vApE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJphcbKr9A5L48chOgxN/N0NjroUju8Oaue+TQL95wVS/HZukYe
	NjT6oAWXBS7UWBREfouYyiWZC42CGmr8SozWuEIx2RWVCQUnrgjyeUfhL1SK8PN01w==
X-Gm-Gg: AYBFou1YQxfWJOo5BHxNSvUKxbM4l0dZYh6NQRW63K56PWn0ChxiEoEJv1C3fokqrNo
	NWOYdgjr0sXBQ01tbHaUKk6URdym3ecVqPFu7qcS2HkRbz0mnl1ZtQJ2bYH0A+8S14ftC0FaPSj
	czgnKCdZyAlOnnKYtIGPlvwtIY+rM891MkFe1chbqDmQ2CxK8I+LXE61TSJ9hyirt1H0O0JV/Oe
	yYuONhFNk+aa0hMp42X0aLfqGTZeYrnnT+vrGuTlwxxWUr4YXu0TCzDrvZwkyZ2/MV3jlINx/n0
	t+Xl9/oc38U/MSSVghC0nJ6asMxGI//0aKx67INFC7cwUeQJxMccdHcrtihAgMeYhPX+vzqMStY
	DRcL6gF8hAIs7+0xiOX8Po4T1qbEMxMg5doJGqc6ERxc54ITZHgADcPnJ+bte1VACkXPu9/0UKo
	bv71NDUlvXo/zEnIxTOA0AK3X6+S1qiKN0v6rfN3T+IwPeh/pZkFBn+goJC+9HJ5SukixXPqqd5
	/+Y/hDLxA5xFSFbJiJNVwYbUZGd/989NlYC7ixf1xqa9VHEGX0RBGYl
X-Received: by 2002:a05:620a:40d5:b0:93e:fd69:9a93 with SMTP id af79cd13be357-940ef8d837emr663389785a.31.1792941423007;
        Sun, 25 Oct 2026 08:17:03 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47cd9dcesm47203106d6.42.2026.10.25.08.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 08:17:02 -0700 (PDT)
Date: Sun, 25 Oct 2026 11:16:59 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: IgorpetinDev <igorpetindev@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: core: hcd: flush giveback work on stop
Message-ID: <76dfb124-d488-45b1-9525-5369026b529f@rowland.harvard.edu>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
 <20261024155614.2732-1-igorpetindev@gmail.com>
 <20261025000643.425c57ca.michal.pecio@gmail.com>
 <CAG21Q83f_Oj5+-OPjFdxzmLWnFkjfYhY9ordyO0zoGtxkWEW3w@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG21Q83f_Oj5+-OPjFdxzmLWnFkjfYhY9ordyO0zoGtxkWEW3w@mail.gmail.com>

On Sun, Oct 25, 2026 at 10:54:57AM +0300, IgorpetinDev wrote:
> Regarding cancel_work_sync() vs. flush_work() and usb_remove_hcd() vs.
> usb_stop_hcd(): these changes were specifically suggested by Alan Stern
> during the review of v1 and v2, which is why v3 was shaped this way and
> subsequently received his reviewed-by tag.
> 
> I'll defer to Alan and Greg on how they wish to proceed and which
> approach they prefer to take.

I don't much care whether the new calls go in usb_remove_hcd() or 
usb_stop_hcd().  I suppose usb_remove_hcd() would make more sense, since 
no URBs can be sent to the HCD until it is added.

As for cancel_work_sync() vs. flush_work(), it doesn't really matter.  
The situation we're in is that there are no more entries remaining in 
the workqueue and no more will be added, but the final one may still be 
executing.  In this setting, cancel_work_sync() and flush_work() do the 
same thing.  However, the name "flush_work" does a better job of 
expressing what we want to accomplish: wait for the final work item to 
finish, not try to cancel it.

> > > @@ -2787,6 +2789,13 @@ static void usb_stop_hcd(struct usb_hcd *hcd)
> > >       /* In case the HCD restarted the timer, stop it again. */
> > >       clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> > >       timer_delete_sync(&hcd->rh_timer);
> > > +
> > > +     /*
> > > +      * Even though all URBs have been given back,
> >
> > but does anyone actually believe this here?
> >
> > Hundreds of drivers written over three decades, often
> > without linux-usb review. I don't trust them at all.

If it's not true, there's likely to be trouble when the completion 
handler is called.  We could forcibly remove any remaining URBs from the 
lists before flushing the work item and just leak them (with a warning 
of some sort -- ideally, one that prints out the names of the completion 
handler routines for the leaked URBs, if at all possible).

Alan Stern

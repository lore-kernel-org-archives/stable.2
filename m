Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8E3C6600
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090828; cv=none; b=S/0o8z8i4LxLfCzLZfDVkCLtyPH1TEGvI5NDu+rx+6UXeS6NeHhMMXcvGlzfct1ZODq8nK5ofRjlrzAcapv+IacgSs4GxC7NEcDKR0wHEWobu+0a7PAMv2245/oMfkhDw9e05pwG14M+2iKn2Xl2q4A8LKp7SeV7R8Y2bnmoKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090828; c=relaxed/simple;
	bh=/bLyKypnNwfGX2WH2jEoAUwwNIROKLlCEg6+ySEJI08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4e9ffURdjDpt6/i8T6CoRL7FOWSz88aP894xLmh7ufmQbu3ye1AcvCzQXyMIL+aS/vWcW4ZFEdsT0dVHfkdA9O3TRucmDOWT7HsiD2LnZJEBvpr2DMv5Ert73N/hDKjGAclUUNY/yiaN1f0HVgcAXGXPCWR4T6+m573LD18DCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0Nmpgdv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvUly7dY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0Nmpgdv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvUly7dY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790090825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Htkt20pVczBoadvUlOct83zLwipczk5AidQ8VvN0o0=;
	b=N0Nmpgdv3DhW0U/dDqBFTEnVlUnbIADYKcZzx6xPOXXw/i0KQNUrfTY7dIhumo83HUDMSX
	achcQ+VA2lrwYyGL6UBILVZnmjqcq9H2rTaG5+ZiSDRemVZqw3+LhQF+yZBTmeejPRdPoC
	CqUKuPbIYFIrPtQ3Etn1P8Rz1VRyqrM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-zo_nxLFwMRq6ZmvTwqsjqw-1; Tue, 22 Sep 2026 11:27:02 -0400
X-MC-Unique: zo_nxLFwMRq6ZmvTwqsjqw-1
X-Mimecast-MFC-AGG-ID: zo_nxLFwMRq6ZmvTwqsjqw_1790090821
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so31630635e9.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790090821; x=1790695621; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Htkt20pVczBoadvUlOct83zLwipczk5AidQ8VvN0o0=;
        b=EvUly7dYqavQqfq1jXf1ADamLFgaWspaM0f9f9a6J07ar2GatdkBBX2YyerClV28S6
         vSXvbmSR4JhiDl5QPRGmDjLQLGWYV+Yl+DBt9/LZvEcGiIAkK79vcSZX7+ci5uZD9qH4
         S0DzDOtF8TT1AOet2Z+NBpdHhVqJM5iJEFNOtvtPRnwNzwD5we0siL9R3WbQqYcjADAG
         r8F49JDath0Cs8u1kUCjK3v1pmmiun7NktSWBV4iakhx4Vy+R2dQuHEuFA4tsBM2CHWp
         mh9z4FnlSkEkSG8Ai8PoQdePwM6wjtfsUT5oR34RKPojmfEZspkk1EI9dIIrSYK2RrJY
         7nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090821; x=1790695621;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0Htkt20pVczBoadvUlOct83zLwipczk5AidQ8VvN0o0=;
        b=LQYPHZ74ZYGMj0IWFu6LZqxMqNgaUesLFDOcXoZD9AEhL13gO366Sh9a/n3lrIRTq1
         uDyqy/jaXdZeCdisRxEljhA2GafzXxRlj57ZpMX+6elL3yEHuEtDhfqsyTpLs/n1hJmg
         eL09w2hYB0iiyUYcAki7SJ3MZKlIjc/99HqEnQql+0hXT5m+l6f7AYKQWkNl+9Vw1Aav
         u/8V0qz6+hk9Hs3MbmC/BaWEUVwZ+zEwaR5HRRMZbTy7hcM+DEYdLXqEaHg9t/QeqjCn
         xMBHVssg3vyrTTtbkfXI0l98yzTraJvalgTstt4/9qXtikyBGRNUFKtjFf5jJQpmt5+B
         t7Jg==
X-Forwarded-Encrypted: i=1; AKwUvBxSDAQHW+/O3/0WnLPxsBfQW3GgTEkO+1ia3JQA5aT2tk5S9az07LaQGj5OUkJq1/o03X2WzhA=@vger.kernel.org
X-Gm-Message-State: AFuF++lVzw0lNww3oGOiZ5zj9MeWymCjsTzq19iLSN5sev9TPZYy6uSZ
	zmKeVYpAJWOZ2YomLRZ9CK3GUvtSFUvpaV08SZlvHShN+VIiIabMzSONSBcPLUgGogbaE4gO0io
	MPhPNgvyHTpHWMFn+6faM8jy336lmJ7hjYZAsIV8CNK+ChtcmSyM3kWhr4g==
X-Gm-Gg: AYBFou3ia+Ke6/+qSmEh1wzdP2qhroDr7cnFm4mbMIpragxTKx+HTTKjm51wQn5yXdg
	1Ev7/EsQSJL8AK3zUKoct0aJXTznYOs1kjJHXrqFSbfRAwMvLLx5YGTqZlbmogBFf7ncJxMApe6
	3yz71KK9COPsk+YSCNWtdRnNB3SGX2FoiNHe5FPU4Xtu10fLG5md7lC84sYbvYuy+pJsgStvqsy
	Z6tlH6KUXjp4mxaoW55Rm8/dY4wBTGa7Hrzp9sT76i3XlAetJX58c875akPzRcGqBna9Fb8JMut
	8K7jfy5sQ4yClDdNvh8qZCOKeTVrmWfONhm7McV9gXJUtKyGJMlU2liiEeRrOknoSuSsaUir+qu
	r33TzF5zsWwI7PbGAOaU+xArVvWYZ
X-Received: by 2002:a05:600c:3b05:b0:49c:fa21:e746 with SMTP id 5b1f17b1804b1-49fc57570c8mr185474665e9.28.1790090821076;
        Tue, 22 Sep 2026 08:27:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3b05:b0:49c:fa21:e746 with SMTP id 5b1f17b1804b1-49fc57570c8mr185474355e9.28.1790090820708;
        Tue, 22 Sep 2026 08:27:00 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fddfd164fsm2995925e9.7.2026.09.22.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:27:00 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Pablo Neira Ayuso <pablo@netfilter.org>,
  Florian Westphal <fw@strlen.de>,  Phil Sutter <phil@nwl.cc>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Eelco Chaudron <echaudro@redhat.com>,  Jamal
 Hadi Salim <jhs@mojatatu.com>,  Jiri Pirko <jiri@resnulli.us>,  Xin Long
 <lucien.xin@gmail.com>,  Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>,  netfilter-devel@vger.kernel.org,
  coreteam@netfilter.org,  linux-kernel@vger.kernel.org,
  dev@openvswitch.org,  stable@vger.kernel.org,  Axel Mierczuk
 <axel.mierczuk@1password.com>
Subject: Re: [PATCH net 3/6] net: openvswitch: conntrack: fix helper UAF due
 to extensions realloc
In-Reply-To: <20260921145655.3167436-4-i.maximets@ovn.org> (Ilya Maximets's
	message of "Mon, 21 Sep 2026 16:55:45 +0200")
References: <20260921145655.3167436-1-i.maximets@ovn.org>
	<20260921145655.3167436-4-i.maximets@ovn.org>
Date: Tue, 22 Sep 2026 11:26:56 -0400
Message-ID: <f7tbj9pb933.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> While calling the helpers, a raw pointer to the extensions area is
> wired into expectations list:
>
>   -> nf_ct_helper()
>    -> helper->help()
>     -> nf_ct_expect_related_report()
>      -> nf_ct_expect_insert()
>       -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)
>
> In case the connection is not confirmed yet, more extensions can be
> added afterwards with *_ext_add() calls reallocating the extension
> space and leaving the now invalid pointer in the expectations list
> that is later accessed while removing the expectation.
>
> Make sure that helpers are called at the end after all the other
> extensions are already added.
>
> Note that the helper rejection now leaves the mark and labels set,
> but that's not different from how the NAT was handled before or how
> the mark and the labels were handled on confirmation failure.  And
> there are no atomicity guarantees provided by the API anyway.
>
> Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

